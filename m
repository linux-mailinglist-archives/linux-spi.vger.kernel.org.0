Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21C431D5841
	for <lists+linux-spi@lfdr.de>; Fri, 15 May 2020 19:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbgEORtT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 15 May 2020 13:49:19 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:38368 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbgEORtT (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 15 May 2020 13:49:19 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 6ECE680005E8;
        Fri, 15 May 2020 17:49:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id T0VLfiG8Gp3u; Fri, 15 May 2020 20:49:11 +0300 (MSK)
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Mark Brown <broonie@kernel.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 2/2] spi: dw: Fix native CS being unset
Date:   Fri, 15 May 2020 20:48:55 +0300
Message-ID: <20200515174856.1406-2-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20200515174856.1406-1-Sergey.Semin@baikalelectronics.ru>
References: <20200515174856.1406-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Commit 6e0a32d6f376 ("spi: dw: Fix default polarity of native
chipselect") attempted to fix the problem when GPIO active-high
chip-select is utilized to communicate with some SPI slave. It fixed
the problem, but broke the normal native CS support. At the same time
the reversion commit ada9e3fcc175 ("spi: dw: Correct handling of native
chipselect") didn't solve the problem either, since it just inverted
the set_cs() polarity perception without taking into account that
CS-high might be applicable. Here is what is done to finally fix the
problem.

DW SPI controller demands any native CS being set in order to proceed
with data transfer. So in order to activate the SPI communications we
must set any bit in the Slave Select DW SPI controller register no
matter whether the platform requests the GPIO- or native CS. Preferably
it should be the bit corresponding to the SPI slave CS number. But
currently the dw_spi_set_cs() method activates the chip-select
only if the second argument is false. Since the second argument of the
set_cs callback is expected to be a boolean with "is-high" semantics
(actual chip-select pin state value), the bit in the DW SPI Slave
Select register will be set only if SPI core requests the driver
to set the CS in the low state. So this will work for active-low
GPIO-based CS case, and won't work for active-high CS setting
the bit when SPI core actually needs to deactivate the CS.

This commit fixes the problem for all described cases. So no matter
whether an SPI slave needs GPIO- or native-based CS with active-high
or low signal the corresponding bit will be set in SER.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Fixes: ada9e3fcc175 ("spi: dw: Correct handling of native chipselect")
Fixes: 6e0a32d6f376 ("spi: dw: Fix default polarity of native chipselect")
Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Mark Brown <broonie@kernel.org>
Cc: Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>
Cc: Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>
Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>

---

Changelog v2:
- Add a comment about SER register, that it must be set to activate the
  SPI communications.

Changelog v3:
- Rebase on top of the spi/for-5.7.
---
 drivers/spi/spi-dw.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index 31e3f866d11a..6c2d8df50507 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -128,12 +128,20 @@ void dw_spi_set_cs(struct spi_device *spi, bool enable)
 {
 	struct dw_spi *dws = spi_controller_get_devdata(spi->controller);
 	struct chip_data *chip = spi_get_ctldata(spi);
+	bool cs_high = !!(spi->mode & SPI_CS_HIGH);
 
 	/* Chip select logic is inverted from spi_set_cs() */
 	if (chip && chip->cs_control)
 		chip->cs_control(!enable);
 
-	if (!enable)
+	/*
+	 * DW SPI controller demands any native CS being set in order to
+	 * proceed with data transfer. So in order to activate the SPI
+	 * communications we must set a corresponding bit in the Slave
+	 * Enable register no matter whether the SPI core is configured to
+	 * support active-high or active-low CS level.
+	 */
+	if (cs_high == enable)
 		dw_writel(dws, DW_SPI_SER, BIT(spi->chip_select));
 	else if (dws->cs_override)
 		dw_writel(dws, DW_SPI_SER, 0);
-- 
2.25.1

