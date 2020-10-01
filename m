Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFE65280A37
	for <lists+linux-spi@lfdr.de>; Fri,  2 Oct 2020 00:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733207AbgJAW2z (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 1 Oct 2020 18:28:55 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:48060 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733131AbgJAW2w (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 1 Oct 2020 18:28:52 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 7CF4B80023E8;
        Thu,  1 Oct 2020 22:28:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id XqOqJBNkD9VE; Fri,  2 Oct 2020 01:28:42 +0300 (MSK)
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
Subject: [PATCH v3 03/21] spi: dw: Detach SPI device specific CR0 config method
Date:   Fri, 2 Oct 2020 01:28:11 +0300
Message-ID: <20201001222829.15977-4-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20201001222829.15977-1-Sergey.Semin@baikalelectronics.ru>
References: <20201001222829.15977-1-Sergey.Semin@baikalelectronics.ru>
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
 drivers/spi/spi-dw-core.c | 43 +++++++++++++++++++++++++++------------
 1 file changed, 30 insertions(+), 13 deletions(-)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index be16fdaf7ce0..6b89330708bc 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -27,6 +27,7 @@ struct chip_data {
 	u16 clk_div;		/* baud rate divider */
 	u32 speed_hz;		/* baud rate */
 
+	u32 cr0;
 	u32 rx_sample_dly;	/* RX sample delay */
 };
 
@@ -228,14 +229,9 @@ static irqreturn_t dw_spi_irq(int irq, void *dev_id)
 	return dws->transfer_handler(dws);
 }
 
-static void dw_spi_update_cr0(struct dw_spi *dws, struct spi_device *spi,
-			      struct spi_transfer *transfer)
+static u32 dw_spi_get_cr0(struct dw_spi *dws, struct spi_device *spi)
 {
-	struct chip_data *chip = spi_get_ctldata(spi);
-	u32 cr0;
-
-	/* CTRLR0[ 4/3: 0] Data Frame Size */
-	cr0 = (transfer->bits_per_word - 1);
+	u32 cr0 = 0;
 
 	if (!(dws->caps & DW_SPI_CAP_DWC_SSI)) {
 		/* CTRLR0[ 5: 4] Frame Format */
@@ -251,9 +247,6 @@ static void dw_spi_update_cr0(struct dw_spi *dws, struct spi_device *spi,
 
 		/* CTRLR0[11] Shift Register Loop */
 		cr0 |= ((spi->mode & SPI_LOOP) ? 1 : 0) << SPI_SRL_OFFSET;
-
-		/* CTRLR0[ 9:8] Transfer Mode */
-		cr0 |= chip->tmode << SPI_TMOD_OFFSET;
 	} else {
 		/* CTRLR0[ 7: 6] Frame Format */
 		cr0 |= SSI_MOTO_SPI << DWC_SSI_CTRLR0_FRF_OFFSET;
@@ -269,13 +262,29 @@ static void dw_spi_update_cr0(struct dw_spi *dws, struct spi_device *spi,
 		/* CTRLR0[13] Shift Register Loop */
 		cr0 |= ((spi->mode & SPI_LOOP) ? 1 : 0) << DWC_SSI_CTRLR0_SRL_OFFSET;
 
-		/* CTRLR0[11:10] Transfer Mode */
-		cr0 |= chip->tmode << DWC_SSI_CTRLR0_TMOD_OFFSET;
-
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
+	/* CTRLR0[ 4/3: 0] Data Frame Size */
+	cr0 |= (transfer->bits_per_word - 1);
+
+	if (!(dws->caps & DW_SPI_CAP_DWC_SSI))
+		/* CTRLR0[ 9:8] Transfer Mode */
+		cr0 |= chip->tmode << SPI_TMOD_OFFSET;
+	else
+		/* CTRLR0[11:10] Transfer Mode */
+		cr0 |= chip->tmode << DWC_SSI_CTRLR0_TMOD_OFFSET;
+
 	dw_writel(dws, DW_SPI_CTRLR0, cr0);
 }
 
@@ -373,6 +382,7 @@ static void dw_spi_handle_err(struct spi_controller *master,
 /* This may be called twice for each spi dev */
 static int dw_spi_setup(struct spi_device *spi)
 {
+	struct dw_spi *dws = spi_controller_get_devdata(spi->controller);
 	struct chip_data *chip;
 
 	/* Only alloc on first setup */
@@ -396,6 +406,13 @@ static int dw_spi_setup(struct spi_device *spi)
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

