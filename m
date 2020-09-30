Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2AC27F1FA
	for <lists+linux-spi@lfdr.de>; Wed, 30 Sep 2020 20:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730090AbgI3S5S (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 30 Sep 2020 14:57:18 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:41714 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725771AbgI3Sz6 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 30 Sep 2020 14:55:58 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 045AF803073F;
        Wed, 30 Sep 2020 18:55:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id HFhlKFJUj3QK; Wed, 30 Sep 2020 21:55:53 +0300 (MSK)
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Mark Brown <broonie@kernel.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        "wuxu . wu" <wuxu.wu@huawei.com>, Feng Tang <feng.tang@intel.com>,
        Rob Herring <robh+dt@kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 05/21] spi: dw: Simplify the SPI bus speed config procedure
Date:   Wed, 30 Sep 2020 21:55:29 +0300
Message-ID: <20200930185545.29959-6-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20200930185545.29959-1-Sergey.Semin@baikalelectronics.ru>
References: <20200930185545.29959-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The code currently responsible for the SPI communication speed setting up
is a bit messy. Most likely for some historical reason the bus frequency
is saved in the peripheral chip private data. It's pointless now since the
custom communication speed is a SPI-transfer-specific thing and only if
there is no SPI transfer data specified (like during the SPI memory
operations) it can be taken from the SPI device structure. But even in the
later case there is no point in having the clock divider and the SPI bus
frequency saved in the chip data, because the controller can be used for
both SPI-transfer-based and SPI-transfer-less communications. From
software point of view keeping the current clock divider in an SPI-device
specific storage may give a small performance gain (to avoid sometimes a
round-up division), but in comparison to the total SPI transfer time it
just doesn't worth saving a few CPU cycles in comparison to the total SPI
transfer time while having the harder to read code. The only optimization,
which could worth preserving in the code is to avoid unnecessary DW SPI
controller registers update if it's possible. So to speak let's simplify
the SPI communication speed update procedure by removing the clock-related
fields from the peripheral chip data and update the DW SPI clock divider
only if it's really changed. The later change is reached by keeping the
effective SPI bus speed in the internal DW SPI private data.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 drivers/spi/spi-dw-core.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index 77dfd6681f0c..478262fb4f8e 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -24,9 +24,6 @@
 struct chip_data {
 	u8 tmode;		/* TR/TO/RO/EEPROM */
 
-	u16 clk_div;		/* baud rate divider */
-	u32 speed_hz;		/* baud rate */
-
 	u32 cr0;
 	u32 rx_sample_dly;	/* RX sample delay */
 };
@@ -274,6 +271,8 @@ static void dw_spi_update_config(struct dw_spi *dws, struct spi_device *spi,
 {
 	struct chip_data *chip = spi_get_ctldata(spi);
 	u32 cr0 = chip->cr0;
+	u32 speed_hz;
+	u16 clk_div;
 
 	/* CTRLR0[ 4/3: 0] Data Frame Size */
 	cr0 |= (transfer->bits_per_word - 1);
@@ -287,15 +286,13 @@ static void dw_spi_update_config(struct dw_spi *dws, struct spi_device *spi,
 
 	dw_writel(dws, DW_SPI_CTRLR0, cr0);
 
-	/* Handle per transfer options for bpw and speed */
-	if (transfer->speed_hz != dws->current_freq) {
-		if (transfer->speed_hz != chip->speed_hz) {
-			/* clk_div doesn't support odd number */
-			chip->clk_div = (DIV_ROUND_UP(dws->max_freq, transfer->speed_hz) + 1) & 0xfffe;
-			chip->speed_hz = transfer->speed_hz;
-		}
-		dws->current_freq = transfer->speed_hz;
-		spi_set_clk(dws, chip->clk_div);
+	/* Note DW APB SSI clock divider doesn't support odd numbers */
+	clk_div = (DIV_ROUND_UP(dws->max_freq, transfer->speed_hz) + 1) & 0xfffe;
+	speed_hz = dws->max_freq / clk_div;
+
+	if (dws->current_freq != speed_hz) {
+		spi_set_clk(dws, clk_div);
+		dws->current_freq = speed_hz;
 	}
 }
 
@@ -323,7 +320,7 @@ static int dw_spi_transfer_one(struct spi_controller *master,
 
 	dw_spi_update_config(dws, spi, transfer);
 
-	transfer->effective_speed_hz = dws->max_freq / chip->clk_div;
+	transfer->effective_speed_hz = dws->current_freq;
 
 	/* Check if current transfer is a DMA transaction */
 	if (master->can_dma && master->can_dma(master, spi, transfer))
-- 
2.27.0

