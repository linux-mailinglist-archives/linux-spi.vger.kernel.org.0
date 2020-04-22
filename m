Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1F7E1B46E8
	for <lists+linux-spi@lfdr.de>; Wed, 22 Apr 2020 16:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbgDVOMo (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 22 Apr 2020 10:12:44 -0400
Received: from mga06.intel.com ([134.134.136.31]:55662 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725810AbgDVOMn (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 22 Apr 2020 10:12:43 -0400
IronPort-SDR: zaOt1LOLZKwGVu8aTRzdBeu/YjJrENqiOreGrWR6ItFAauGtLxDs/pwjHNAqmdejirEU8RmTAW
 beo3Ai/KQ8HA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2020 07:12:43 -0700
IronPort-SDR: np/ZyBmVZpoGV3MpAK87xIbJMT8QNxrej0ySmw8aSkmPgRChP2YQBoX1Pj6t6zcvoEtyoR9vvy
 7GoLB9u5ITnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,414,1580803200"; 
   d="scan'208";a="402560721"
Received: from wwanmoha-ilbpg2.png.intel.com ([10.88.227.42])
  by orsmga004.jf.intel.com with ESMTP; 22 Apr 2020 07:12:41 -0700
From:   Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
To:     broonie@kernel.org, robh+dt@kernel.org
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        andriy.shevchenko@linux.intel.com,
        wan.ahmad.zainie.wan.mohamad@intel.com
Subject: [PATCH v2 2/7] spi: dw: Add update_cr0() callback to update CTRLR0
Date:   Wed, 22 Apr 2020 22:11:37 +0800
Message-Id: <20200422141142.25591-3-wan.ahmad.zainie.wan.mohamad@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200422141142.25591-1-wan.ahmad.zainie.wan.mohamad@intel.com>
References: <20200422141142.25591-1-wan.ahmad.zainie.wan.mohamad@intel.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This patch adds update_cr0() callback, in struct dw_spi.

Existing code that configure register CTRLR0 is moved into a new
function, dw_spi_update_cr0(), and this will be the default.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-dw-mid.c  |  4 +++
 drivers/spi/spi-dw-mmio.c | 21 +++++++++++--
 drivers/spi/spi-dw.c      | 66 +++++++++++++++++++++++++--------------
 drivers/spi/spi-dw.h      |  5 +++
 4 files changed, 69 insertions(+), 27 deletions(-)

diff --git a/drivers/spi/spi-dw-mid.c b/drivers/spi/spi-dw-mid.c
index 0d86c37e0aeb..9cc010e9737e 100644
--- a/drivers/spi/spi-dw-mid.c
+++ b/drivers/spi/spi-dw-mid.c
@@ -318,5 +318,9 @@ int dw_spi_mid_init(struct dw_spi *dws)
 	dws->dma_rx = &mid_dma_rx;
 	dws->dma_ops = &mid_dma_ops;
 #endif
+
+	/* Register hook to configure CTRLR0 */
+	dws->update_cr0 = dw_spi_update_cr0;
+
 	return 0;
 }
diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
index 384a3ab6dc2d..a52f75e22109 100644
--- a/drivers/spi/spi-dw-mmio.c
+++ b/drivers/spi/spi-dw-mmio.c
@@ -106,6 +106,9 @@ static int dw_spi_mscc_init(struct platform_device *pdev,
 	dwsmmio->dws.set_cs = dw_spi_mscc_set_cs;
 	dwsmmio->priv = dwsmscc;
 
+	/* Register hook to configure CTRLR0 */
+	dwsmmio->dws.update_cr0 = dw_spi_update_cr0;
+
 	return 0;
 }
 
@@ -128,6 +131,18 @@ static int dw_spi_alpine_init(struct platform_device *pdev,
 {
 	dwsmmio->dws.cs_override = 1;
 
+	/* Register hook to configure CTRLR0 */
+	dwsmmio->dws.update_cr0 = dw_spi_update_cr0;
+
+	return 0;
+}
+
+static int dw_spi_dw_apb_init(struct platform_device *pdev,
+			      struct dw_spi_mmio *dwsmmio)
+{
+	/* Register hook to configure CTRLR0 */
+	dwsmmio->dws.update_cr0 = dw_spi_update_cr0;
+
 	return 0;
 }
 
@@ -224,17 +239,17 @@ static int dw_spi_mmio_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id dw_spi_mmio_of_match[] = {
-	{ .compatible = "snps,dw-apb-ssi", },
+	{ .compatible = "snps,dw-apb-ssi", .data = dw_spi_dw_apb_init},
 	{ .compatible = "mscc,ocelot-spi", .data = dw_spi_mscc_ocelot_init},
 	{ .compatible = "mscc,jaguar2-spi", .data = dw_spi_mscc_jaguar2_init},
 	{ .compatible = "amazon,alpine-dw-apb-ssi", .data = dw_spi_alpine_init},
-	{ .compatible = "renesas,rzn1-spi", },
+	{ .compatible = "renesas,rzn1-spi", .data = dw_spi_dw_apb_init},
 	{ /* end of table */}
 };
 MODULE_DEVICE_TABLE(of, dw_spi_mmio_of_match);
 
 static const struct acpi_device_id dw_spi_mmio_acpi_match[] = {
-	{"HISI0173", 0},
+	{"HISI0173", (kernel_ulong_t)dw_spi_dw_apb_init},
 	{},
 };
 MODULE_DEVICE_TABLE(acpi, dw_spi_mmio_acpi_match);
diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index fbbafb099571..b475fd32f39a 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -277,6 +277,47 @@ static int poll_transfer(struct dw_spi *dws)
 	return 0;
 }
 
+static u8 dw_spi_update_tmode(struct dw_spi *dws)
+{
+	if (!dws->tx)
+		return SPI_TMOD_RO;
+	if (!dws->rx)
+		return SPI_TMOD_TO;
+
+	return SPI_TMOD_TR;
+}
+
+/* Configure CTRLR0 for DW_apb_ssi */
+u32 dw_spi_update_cr0(struct spi_controller *master, struct spi_device *spi,
+		      struct spi_transfer *transfer)
+{
+	struct dw_spi *dws = spi_controller_get_devdata(master);
+	struct chip_data *chip = spi_get_ctldata(spi);
+	u32 cr0;
+
+	/* Default SPI mode is SCPOL = 0, SCPH = 0 */
+	cr0 = (transfer->bits_per_word - 1)
+		| (chip->type << SPI_FRF_OFFSET)
+		| ((((spi->mode & SPI_CPOL) ? 1 : 0) << SPI_SCOL_OFFSET) |
+		   (((spi->mode & SPI_CPHA) ? 1 : 0) << SPI_SCPH_OFFSET) |
+		   (((spi->mode & SPI_LOOP) ? 1 : 0) << SPI_SRL_OFFSET))
+		| (chip->tmode << SPI_TMOD_OFFSET);
+
+	/*
+	 * Adjust transfer mode if necessary. Requires platform dependent
+	 * chipselect mechanism.
+	 */
+	if (chip->cs_control) {
+		chip->tmode = dw_spi_update_tmode(dws);
+
+		cr0 &= ~SPI_TMOD_MASK;
+		cr0 |= (chip->tmode << SPI_TMOD_OFFSET);
+	}
+
+	return cr0;
+}
+EXPORT_SYMBOL_GPL(dw_spi_update_cr0);
+
 static int dw_spi_transfer_one(struct spi_controller *master,
 		struct spi_device *spi, struct spi_transfer *transfer)
 {
@@ -316,30 +357,7 @@ static int dw_spi_transfer_one(struct spi_controller *master,
 	dws->n_bytes = DIV_ROUND_UP(transfer->bits_per_word, BITS_PER_BYTE);
 	dws->dma_width = DIV_ROUND_UP(transfer->bits_per_word, BITS_PER_BYTE);
 
-	/* Default SPI mode is SCPOL = 0, SCPH = 0 */
-	cr0 = (transfer->bits_per_word - 1)
-		| (chip->type << SPI_FRF_OFFSET)
-		| ((((spi->mode & SPI_CPOL) ? 1 : 0) << SPI_SCOL_OFFSET) |
-			(((spi->mode & SPI_CPHA) ? 1 : 0) << SPI_SCPH_OFFSET) |
-			(((spi->mode & SPI_LOOP) ? 1 : 0) << SPI_SRL_OFFSET))
-		| (chip->tmode << SPI_TMOD_OFFSET);
-
-	/*
-	 * Adjust transfer mode if necessary. Requires platform dependent
-	 * chipselect mechanism.
-	 */
-	if (chip->cs_control) {
-		if (dws->rx && dws->tx)
-			chip->tmode = SPI_TMOD_TR;
-		else if (dws->rx)
-			chip->tmode = SPI_TMOD_RO;
-		else
-			chip->tmode = SPI_TMOD_TO;
-
-		cr0 &= ~SPI_TMOD_MASK;
-		cr0 |= (chip->tmode << SPI_TMOD_OFFSET);
-	}
-
+	cr0 = dws->update_cr0(master, spi, transfer);
 	dw_writel(dws, DW_SPI_CTRLR0, cr0);
 
 	/* Check if current transfer is a DMA transaction */
diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index 445362c23fde..d4d3b0b6f5d5 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -114,6 +114,8 @@ struct dw_spi {
 	u16			bus_num;
 	u16			num_cs;		/* supported slave numbers */
 	void (*set_cs)(struct spi_device *spi, bool enable);
+	u32 (*update_cr0)(struct spi_controller *master, struct spi_device *spi,
+			  struct spi_transfer *transfer);
 
 	/* Current message transfer state info */
 	size_t			len;
@@ -252,6 +254,9 @@ extern int dw_spi_add_host(struct device *dev, struct dw_spi *dws);
 extern void dw_spi_remove_host(struct dw_spi *dws);
 extern int dw_spi_suspend_host(struct dw_spi *dws);
 extern int dw_spi_resume_host(struct dw_spi *dws);
+extern u32 dw_spi_update_cr0(struct spi_controller *master,
+			     struct spi_device *spi,
+			     struct spi_transfer *transfer);
 
 /* platform related setup */
 extern int dw_spi_mid_init(struct dw_spi *dws); /* Intel MID platforms */
-- 
2.17.1

