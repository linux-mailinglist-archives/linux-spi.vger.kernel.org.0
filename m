Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83CAA2B5C0C
	for <lists+linux-spi@lfdr.de>; Tue, 17 Nov 2020 10:45:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbgKQJpZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 17 Nov 2020 04:45:25 -0500
Received: from mail.baikalelectronics.com ([87.245.175.226]:41620 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgKQJpY (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 17 Nov 2020 04:45:24 -0500
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id D9B0B8030718;
        Tue, 17 Nov 2020 09:45:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 7D0ZcDkkRORN; Tue, 17 Nov 2020 12:45:21 +0300 (MSK)
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Mark Brown <broonie@kernel.org>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH] spi: Take the SPI IO-mutex in the spi_setup() method
Date:   Tue, 17 Nov 2020 12:45:17 +0300
Message-ID: <20201117094517.5654-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

I've discovered that due to the recent commit 49d7d695ca4b ("spi: dw:
Explicitly de-assert CS on SPI transfer completion") a concurrent usage of
the spidev devices with different chip-selects causes the "SPI transfer
timed out" error. The root cause of the problem has turned to be in a race
condition of the SPI-transfer execution procedure and the spi_setup()
method being called at the same time. In particular in calling the
spi_set_cs(false) while there is an SPI-transfer being executed. In my
case due to the commit cited above all CSs get to be switched off by
calling the spi_setup() for /dev/spidev0.1 while there is an concurrent
SPI-transfer execution performed on /dev/spidev0.0. Of course a situation
of the spi_setup() being called while there is an SPI-transfer being
executed for two different SPI peripheral devices of the same controller
may happen not only for the spidev driver, but for instance for MMC SPI +
some another device, or spi_setup() being called from an SPI-peripheral
probe method while some other device has already been probed and is being
used by a corresponding driver...

Of course I could have provided a fix affecting the DW APB SSI driver
only, for instance, by creating a mutual exclusive access to the set_cs
callback and setting/clearing only the bit responsible for the
corresponding chip-select. But after a short research I've discovered that
the problem most likely affects a lot of the other drivers:
- drivers/spi/spi-sun4i.c - RMW the chip-select register;
- drivers/spi/spi-rockchip.c - RMW the chip-select register;
- drivers/spi/spi-qup.c - RMW a generic force-CS flag in a CSR.
- drivers/spi/spi-sifive.c - set a generic CS-mode flag in a CSR.
- drivers/spi/spi-bcm63xx-hsspi.c - uses an internal mutex to serialize
  the bus config changes, but still isn't protected from the race
  condition described above;
- drivers/spi/spi-geni-qcom.c - RMW a chip-select internal flag and set the
  CS state in HW;
- drivers/spi/spi-orion.c - RMW a chip-select register;
- drivers/spi/spi-cadence.c - RMW a chip-select register;
- drivers/spi/spi-armada-3700.c - RMW a chip-select register;
- drivers/spi/spi-lantiq-ssc.c - overwrites the chip-select register;
- drivers/spi/spi-sun6i.c - RMW a chip-select register;
- drivers/spi/spi-synquacer.c - RMW a chip-select register;
- drivers/spi/spi-altera.c - directly sets the chip-select state;
- drivers/spi/spi-omap2-mcspi.c - RMW an internally cached CS state and
  writes it to HW;
- drivers/spi/spi-mt65xx.c - RMW some CSR;
- drivers/spi/spi-jcore.c - directly sets the chip-selects state;
- drivers/spi/spi-mt7621.c - RMW a chip-select register;

I could have missed some drivers, but a scale of the problem is obvious.
As you can see most of the drivers perform an unprotected
Read-modify-write chip-select register modification in the set_cs callback.
Seeing the spi_setup() function is calling the spi_set_cs() and it can be
executed concurrently with SPI-transfers exec procedure, which also calls
spi_set_cs() in the SPI core spi_transfer_one_message() method, the race
condition of the register modification turns to be obvious.

To sum up the problem denoted above affects each driver for a controller
having more than one chip-select lane and which:
1) performs the RMW to some CS-related register with no serialization;
2) directly disables any CS on spi_set_cs(dev, false).
* the later is the case of the DW APB SSI driver.

The controllers which equipped with a single CS theoretically can also
experience the problem, but in practice will not since normally the
spi_setup() isn't called concurrently with the SPI-transfers executed on
the same SPI peripheral device.

In order to generically fix the denoted bug I'd suggest to serialize an
access to the controller IO by taking the IO mutex in the spi_setup()
callback. The mutex is held while there is an SPI communication going on
on the SPI-bus of the corresponding SPI-controller. So calling the
spi_setup() method and disabling/updating the CS state within it would be
safe while there is no any SPI-transfers being executed. Also note I
suppose it would be safer to protect the spi_controller->setup() callback
invocation too, seeing some of the SPI-controller drivers update a HW
state in there.

Fixes: 49d7d695ca4b ("spi: dw: Explicitly de-assert CS on SPI transfer completion")
Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 drivers/spi/spi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 0cab239d8e7f..353fa178e39b 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -3327,12 +3327,15 @@ int spi_setup(struct spi_device *spi)
 	if (!spi->max_speed_hz)
 		spi->max_speed_hz = spi->controller->max_speed_hz;
 
+	mutex_lock(&spi->controller->io_mutex);
+
 	if (spi->controller->setup)
 		status = spi->controller->setup(spi);
 
 	if (spi->controller->auto_runtime_pm && spi->controller->set_cs) {
 		status = pm_runtime_get_sync(spi->controller->dev.parent);
 		if (status < 0) {
+			mutex_unlock(&spi->controller->io_mutex);
 			pm_runtime_put_noidle(spi->controller->dev.parent);
 			dev_err(&spi->controller->dev, "Failed to power device: %d\n",
 				status);
@@ -3354,6 +3357,8 @@ int spi_setup(struct spi_device *spi)
 		spi_set_cs(spi, false);
 	}
 
+	mutex_unlock(&spi->controller->io_mutex);
+
 	if (spi->rt && !spi->controller->rt) {
 		spi->controller->rt = true;
 		spi_set_thread_rt(spi->controller);
-- 
2.29.2

