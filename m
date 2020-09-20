Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0BFF2713AC
	for <lists+linux-spi@lfdr.de>; Sun, 20 Sep 2020 13:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbgITL3m (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 20 Sep 2020 07:29:42 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:53718 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbgITL3j (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 20 Sep 2020 07:29:39 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 6F4578002549;
        Sun, 20 Sep 2020 11:29:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 2kO6ijVyJ1qQ; Sun, 20 Sep 2020 14:29:30 +0300 (MSK)
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
Subject: [PATCH 12/30] spi: dw: Detach SPI device specific CR0 config method
Date:   Sun, 20 Sep 2020 14:28:56 +0300
Message-ID: <20200920112914.26501-13-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20200920112914.26501-1-Sergey.Semin@baikalelectronics.ru>
References: <20200920112914.26501-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Indeed there is no point in detecting the SPI peripheral device parameters
and initializing the CR0 register fields each time an SPI transfer is
executed. Instead let's define a dedicated CR0 chip-data member, which
will be initialized in accordance with the SPI device settings at the
moment of setting it up.

By doing so we'll finally make the SPI device chip_data serving as it's
supposed to - to preserve the SPI device specific DW SPI configuration.
See spi-fsl-dspi.c, spi-pl022.c, spi-pxa2xx.c drivers for example of the
way the chip data is utilized.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 drivers/spi/spi-dw-core.c | 35 +++++++++++++++++++++++++++--------
 1 file changed, 27 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index c21641a485ce..a9644351d75f 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -27,6 +27,7 @@ struct chip_data {
 	u16 clk_div;		/* baud rate divider */
 	u32 speed_hz;		/* baud rate */
 
+	u32 cr0;
 	u32 rx_sample_dly;	/* RX sample delay */
 };
 
@@ -228,31 +229,41 @@ static irqreturn_t dw_spi_irq(int irq, void *dev_id)
 	return dws->transfer_handler(dws);
 }
 
-static void dw_spi_update_cr0(struct dw_spi *dws, struct spi_device *spi,
-			      struct spi_transfer *transfer)
+static u32 dw_spi_get_cr0(struct dw_spi *dws, struct spi_device *spi)
 {
-	struct chip_data *chip = spi_get_ctldata(spi);
-	u32 cr0;
-
-	cr0 = (transfer->bits_per_word - 1);
+	u32 cr0 = 0;
 
 	if (!(dws->caps & DW_SPI_CAP_DWC_SSI)) {
 		cr0 |= SSI_MOTO_SPI << SPI_FRF_OFFSET;
 		cr0 |= ((spi->mode & SPI_CPOL) ? 1 : 0) << SPI_SCOL_OFFSET;
 		cr0 |= ((spi->mode & SPI_CPHA) ? 1 : 0) << SPI_SCPH_OFFSET;
 		cr0 |= ((spi->mode & SPI_LOOP) ? 1 : 0) << SPI_SRL_OFFSET;
-		cr0 |= chip->tmode << SPI_TMOD_OFFSET;
 	} else {
 		cr0 |= SSI_MOTO_SPI << DWC_SSI_CTRLR0_FRF_OFFSET;
 		cr0 |= ((spi->mode & SPI_CPOL) ? 1 : 0) << DWC_SSI_CTRLR0_SCPOL_OFFSET;
 		cr0 |= ((spi->mode & SPI_CPHA) ? 1 : 0) << DWC_SSI_CTRLR0_SCPH_OFFSET;
 		cr0 |= ((spi->mode & SPI_LOOP) ? 1 : 0) << DWC_SSI_CTRLR0_SRL_OFFSET;
-		cr0 |= chip->tmode << DWC_SSI_CTRLR0_TMOD_OFFSET;
 
 		if (dws->caps & DW_SPI_CAP_KEEMBAY_MST)
 			cr0 |= DWC_SSI_CTRLR0_KEEMBAY_MST;
 	}
 
+	return cr0;
+}
+
+static void dw_spi_update_cr0(struct dw_spi *dws, struct spi_device *spi,
+			      struct spi_transfer *transfer)
+{
+	struct chip_data *chip = spi_get_ctldata(spi);
+	u32 cr0 = chip->cr0;
+
+	cr0 |= (transfer->bits_per_word - 1);
+
+	if (!(dws->caps & DW_SPI_CAP_DWC_SSI))
+		cr0 |= chip->tmode << SPI_TMOD_OFFSET;
+	else
+		cr0 |= chip->tmode << DWC_SSI_CTRLR0_TMOD_OFFSET;
+
 	dw_writel(dws, DW_SPI_CTRLR0, cr0);
 }
 
@@ -350,6 +361,7 @@ static void dw_spi_handle_err(struct spi_controller *master,
 /* This may be called twice for each spi dev */
 static int dw_spi_setup(struct spi_device *spi)
 {
+	struct dw_spi *dws = spi_controller_get_devdata(spi->controller);
 	struct chip_data *chip;
 
 	/* Only alloc on first setup */
@@ -373,6 +385,13 @@ static int dw_spi_setup(struct spi_device *spi)
 							dws->max_freq);
 	}
 
+	/*
+	 * Update CR0 data each time the setup callback is invoked since
+	 * the device parameters could have been changed, for instance, by
+	 * the MMC SPI driver or something else.
+	 */
+	chip->cr0 = dw_spi_get_cr0(dws, spi);
+
 	chip->tmode = SPI_TMOD_TR;
 
 	return 0;
-- 
2.27.0

