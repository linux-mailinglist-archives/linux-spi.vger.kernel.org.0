Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70C5027F1BC
	for <lists+linux-spi@lfdr.de>; Wed, 30 Sep 2020 20:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730258AbgI3Sz6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 30 Sep 2020 14:55:58 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:41656 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728270AbgI3Szz (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 30 Sep 2020 14:55:55 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 2C0D7803073D;
        Wed, 30 Sep 2020 18:55:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Dcvh5TDCLioe; Wed, 30 Sep 2020 21:55:51 +0300 (MSK)
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
Subject: [PATCH v2 02/21] spi: dw: Add DWC SSI capability
Date:   Wed, 30 Sep 2020 21:55:26 +0300
Message-ID: <20200930185545.29959-3-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20200930185545.29959-1-Sergey.Semin@baikalelectronics.ru>
References: <20200930185545.29959-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Currently DWC SSI core is supported by means of setting up the
core-specific update_cr0() callback. It isn't suitable for multiple
reasons. First of all having exported several methods doing the same thing
but for different chips makes the code harder to maintain. Secondly the
spi-dw-core driver exports the methods, then the spi-dw-mmio driver sets
the private data callback with one of them so to be called by the core
driver again. That makes the code logic too complicated. Thirdly using
callbacks for just updating the CR0 register is problematic, since in case
if the register needed to be updated from different parts of the code,
we'd have to create another callback (for instance the SPI device-specific
parameters don't need to be calculated each time the SPI transfer is
submitted, so it's better to pre-calculate the CR0 data at the SPI-device
setup stage).

So keeping all the above in mind let's discard the update_cr0() callbacks,
define a generic and static dw_spi_update_cr0() method and create the
DW_SPI_CAP_DWC_SSI capability, which when enabled would activate the
alternative CR0 register layout.

While at it add the comments to the code path of the normal DW APB SSI
controller setup to make the dw_spi_update_cr0() method looking coherent.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 drivers/spi/spi-dw-core.c | 80 ++++++++++++++++++---------------------
 drivers/spi/spi-dw-mmio.c | 20 +---------
 drivers/spi/spi-dw.h      |  9 +----
 3 files changed, 40 insertions(+), 69 deletions(-)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index 3a7fdca8d335..be16fdaf7ce0 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -228,60 +228,56 @@ static irqreturn_t dw_spi_irq(int irq, void *dev_id)
 	return dws->transfer_handler(dws);
 }
 
-/* Configure CTRLR0 for DW_apb_ssi */
-u32 dw_spi_update_cr0(struct spi_controller *master, struct spi_device *spi,
-		      struct spi_transfer *transfer)
+static void dw_spi_update_cr0(struct dw_spi *dws, struct spi_device *spi,
+			      struct spi_transfer *transfer)
 {
 	struct chip_data *chip = spi_get_ctldata(spi);
 	u32 cr0;
 
-	/* Default SPI mode is SCPOL = 0, SCPH = 0 */
-	cr0 = (transfer->bits_per_word - 1)
-		| (SSI_MOTO_SPI << SPI_FRF_OFFSET)
-		| ((((spi->mode & SPI_CPOL) ? 1 : 0) << SPI_SCOL_OFFSET) |
-		   (((spi->mode & SPI_CPHA) ? 1 : 0) << SPI_SCPH_OFFSET) |
-		   (((spi->mode & SPI_LOOP) ? 1 : 0) << SPI_SRL_OFFSET))
-		| (chip->tmode << SPI_TMOD_OFFSET);
+	/* CTRLR0[ 4/3: 0] Data Frame Size */
+	cr0 = (transfer->bits_per_word - 1);
 
-	return cr0;
-}
-EXPORT_SYMBOL_GPL(dw_spi_update_cr0);
+	if (!(dws->caps & DW_SPI_CAP_DWC_SSI)) {
+		/* CTRLR0[ 5: 4] Frame Format */
+		cr0 |= SSI_MOTO_SPI << SPI_FRF_OFFSET;
 
-/* Configure CTRLR0 for DWC_ssi */
-u32 dw_spi_update_cr0_v1_01a(struct spi_controller *master,
-			     struct spi_device *spi,
-			     struct spi_transfer *transfer)
-{
-	struct dw_spi *dws = spi_controller_get_devdata(master);
-	struct chip_data *chip = spi_get_ctldata(spi);
-	u32 cr0;
+		/*
+		 * SPI mode (SCPOL|SCPH)
+		 * CTRLR0[ 6] Serial Clock Phase
+		 * CTRLR0[ 7] Serial Clock Polarity
+		 */
+		cr0 |= ((spi->mode & SPI_CPOL) ? 1 : 0) << SPI_SCOL_OFFSET;
+		cr0 |= ((spi->mode & SPI_CPHA) ? 1 : 0) << SPI_SCPH_OFFSET;
 
-	/* CTRLR0[ 4: 0] Data Frame Size */
-	cr0 = (transfer->bits_per_word - 1);
+		/* CTRLR0[11] Shift Register Loop */
+		cr0 |= ((spi->mode & SPI_LOOP) ? 1 : 0) << SPI_SRL_OFFSET;
 
-	/* CTRLR0[ 7: 6] Frame Format */
-	cr0 |= SSI_MOTO_SPI << DWC_SSI_CTRLR0_FRF_OFFSET;
+		/* CTRLR0[ 9:8] Transfer Mode */
+		cr0 |= chip->tmode << SPI_TMOD_OFFSET;
+	} else {
+		/* CTRLR0[ 7: 6] Frame Format */
+		cr0 |= SSI_MOTO_SPI << DWC_SSI_CTRLR0_FRF_OFFSET;
 
-	/*
-	 * SPI mode (SCPOL|SCPH)
-	 * CTRLR0[ 8] Serial Clock Phase
-	 * CTRLR0[ 9] Serial Clock Polarity
-	 */
-	cr0 |= ((spi->mode & SPI_CPOL) ? 1 : 0) << DWC_SSI_CTRLR0_SCPOL_OFFSET;
-	cr0 |= ((spi->mode & SPI_CPHA) ? 1 : 0) << DWC_SSI_CTRLR0_SCPH_OFFSET;
+		/*
+		 * SPI mode (SCPOL|SCPH)
+		 * CTRLR0[ 8] Serial Clock Phase
+		 * CTRLR0[ 9] Serial Clock Polarity
+		 */
+		cr0 |= ((spi->mode & SPI_CPOL) ? 1 : 0) << DWC_SSI_CTRLR0_SCPOL_OFFSET;
+		cr0 |= ((spi->mode & SPI_CPHA) ? 1 : 0) << DWC_SSI_CTRLR0_SCPH_OFFSET;
 
-	/* CTRLR0[11:10] Transfer Mode */
-	cr0 |= chip->tmode << DWC_SSI_CTRLR0_TMOD_OFFSET;
+		/* CTRLR0[13] Shift Register Loop */
+		cr0 |= ((spi->mode & SPI_LOOP) ? 1 : 0) << DWC_SSI_CTRLR0_SRL_OFFSET;
 
-	/* CTRLR0[13] Shift Register Loop */
-	cr0 |= ((spi->mode & SPI_LOOP) ? 1 : 0) << DWC_SSI_CTRLR0_SRL_OFFSET;
+		/* CTRLR0[11:10] Transfer Mode */
+		cr0 |= chip->tmode << DWC_SSI_CTRLR0_TMOD_OFFSET;
 
-	if (dws->caps & DW_SPI_CAP_KEEMBAY_MST)
-		cr0 |= DWC_SSI_CTRLR0_KEEMBAY_MST;
+		if (dws->caps & DW_SPI_CAP_KEEMBAY_MST)
+			cr0 |= DWC_SSI_CTRLR0_KEEMBAY_MST;
+	}
 
-	return cr0;
+	dw_writel(dws, DW_SPI_CTRLR0, cr0);
 }
-EXPORT_SYMBOL_GPL(dw_spi_update_cr0_v1_01a);
 
 static int dw_spi_transfer_one(struct spi_controller *master,
 		struct spi_device *spi, struct spi_transfer *transfer)
@@ -290,7 +286,6 @@ static int dw_spi_transfer_one(struct spi_controller *master,
 	struct chip_data *chip = spi_get_ctldata(spi);
 	u8 imask = 0;
 	u16 txlevel = 0;
-	u32 cr0;
 	int ret;
 
 	dws->dma_mapped = 0;
@@ -319,8 +314,7 @@ static int dw_spi_transfer_one(struct spi_controller *master,
 
 	transfer->effective_speed_hz = dws->max_freq / chip->clk_div;
 
-	cr0 = dws->update_cr0(master, spi, transfer);
-	dw_writel(dws, DW_SPI_CTRLR0, cr0);
+	dw_spi_update_cr0(dws, spi, transfer);
 
 	/* Check if current transfer is a DMA transaction */
 	if (master->can_dma && master->can_dma(master, spi, transfer))
diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
index c0d351fde782..d0cc5bf4fa4e 100644
--- a/drivers/spi/spi-dw-mmio.c
+++ b/drivers/spi/spi-dw-mmio.c
@@ -110,9 +110,6 @@ static int dw_spi_mscc_init(struct platform_device *pdev,
 	dwsmmio->dws.set_cs = dw_spi_mscc_set_cs;
 	dwsmmio->priv = dwsmscc;
 
-	/* Register hook to configure CTRLR0 */
-	dwsmmio->dws.update_cr0 = dw_spi_update_cr0;
-
 	return 0;
 }
 
@@ -188,9 +185,6 @@ static int dw_spi_mscc_sparx5_init(struct platform_device *pdev,
 	dwsmmio->dws.set_cs = dw_spi_sparx5_set_cs;
 	dwsmmio->priv = dwsmscc;
 
-	/* Register hook to configure CTRLR0 */
-	dwsmmio->dws.update_cr0 = dw_spi_update_cr0;
-
 	return 0;
 }
 
@@ -199,18 +193,12 @@ static int dw_spi_alpine_init(struct platform_device *pdev,
 {
 	dwsmmio->dws.caps = DW_SPI_CAP_CS_OVERRIDE;
 
-	/* Register hook to configure CTRLR0 */
-	dwsmmio->dws.update_cr0 = dw_spi_update_cr0;
-
 	return 0;
 }
 
 static int dw_spi_dw_apb_init(struct platform_device *pdev,
 			      struct dw_spi_mmio *dwsmmio)
 {
-	/* Register hook to configure CTRLR0 */
-	dwsmmio->dws.update_cr0 = dw_spi_update_cr0;
-
 	dw_spi_dma_setup_generic(&dwsmmio->dws);
 
 	return 0;
@@ -219,8 +207,7 @@ static int dw_spi_dw_apb_init(struct platform_device *pdev,
 static int dw_spi_dwc_ssi_init(struct platform_device *pdev,
 			       struct dw_spi_mmio *dwsmmio)
 {
-	/* Register hook to configure CTRLR0 */
-	dwsmmio->dws.update_cr0 = dw_spi_update_cr0_v1_01a;
+	dwsmmio->dws.caps = DW_SPI_CAP_DWC_SSI;
 
 	dw_spi_dma_setup_generic(&dwsmmio->dws);
 
@@ -230,10 +217,7 @@ static int dw_spi_dwc_ssi_init(struct platform_device *pdev,
 static int dw_spi_keembay_init(struct platform_device *pdev,
 			       struct dw_spi_mmio *dwsmmio)
 {
-	dwsmmio->dws.caps = DW_SPI_CAP_KEEMBAY_MST;
-
-	/* Register hook to configure CTRLR0 */
-	dwsmmio->dws.update_cr0 = dw_spi_update_cr0_v1_01a;
+	dwsmmio->dws.caps = DW_SPI_CAP_KEEMBAY_MST | DW_SPI_CAP_DWC_SSI;
 
 	return 0;
 }
diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index da9b543322c9..c02351cf2f99 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -109,6 +109,7 @@ enum dw_ssi_type {
 /* DW SPI capabilities */
 #define DW_SPI_CAP_CS_OVERRIDE		BIT(0)
 #define DW_SPI_CAP_KEEMBAY_MST		BIT(1)
+#define DW_SPI_CAP_DWC_SSI		BIT(2)
 
 struct dw_spi;
 struct dw_spi_dma_ops {
@@ -136,8 +137,6 @@ struct dw_spi {
 	u16			bus_num;
 	u16			num_cs;		/* supported slave numbers */
 	void (*set_cs)(struct spi_device *spi, bool enable);
-	u32 (*update_cr0)(struct spi_controller *master, struct spi_device *spi,
-			  struct spi_transfer *transfer);
 
 	/* Current message transfer state info */
 	size_t			len;
@@ -254,12 +253,6 @@ extern int dw_spi_add_host(struct device *dev, struct dw_spi *dws);
 extern void dw_spi_remove_host(struct dw_spi *dws);
 extern int dw_spi_suspend_host(struct dw_spi *dws);
 extern int dw_spi_resume_host(struct dw_spi *dws);
-extern u32 dw_spi_update_cr0(struct spi_controller *master,
-			     struct spi_device *spi,
-			     struct spi_transfer *transfer);
-extern u32 dw_spi_update_cr0_v1_01a(struct spi_controller *master,
-				    struct spi_device *spi,
-				    struct spi_transfer *transfer);
 
 #ifdef CONFIG_SPI_DW_DMA
 
-- 
2.27.0

