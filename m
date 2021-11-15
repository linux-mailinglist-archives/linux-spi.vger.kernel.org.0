Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A950B452508
	for <lists+linux-spi@lfdr.de>; Tue, 16 Nov 2021 02:43:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358216AbhKPBqa (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 15 Nov 2021 20:46:30 -0500
Received: from mail.baikalelectronics.com ([87.245.175.226]:45122 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241612AbhKOSY3 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 15 Nov 2021 13:24:29 -0500
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
Authentication-Results: mail.baikalelectronics.ru; dkim=permerror (bad message/signature format)
To:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Nandhini Srikandan <nandhini.srikandan@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 4/7] spi: dw: Convert to using the Bitfield access macros
Date:   Mon, 15 Nov 2021 21:19:14 +0300
Message-ID: <20211115181917.7521-5-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20211115181917.7521-1-Sergey.Semin@baikalelectronics.ru>
References: <20211115181917.7521-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The driver has been using the offset/bitwise-shift-based approach for the
CSR fields R/W operations since it was merged into the kernel. It can be
simplified by using the macros defined in the linux/bitfield.h and
linux/bit.h header files like BIT(), GENMASK(), FIELD_PREP(), FIELD_GET(),
etc where it is required, for instance in the cached cr0 preparation
method. Thus in order to have the FIELD_*()-macros utilized we just need
to convert the macros with the CSR-fields offsets to the masks with the
corresponding registers fields definition. That's where the GENMASK() and
BIT() macros come in handy. After that the masks can be used in the
FIELD_*()-macros where it's appropriate.

We also need to convert the macros with the CRS-bit flags using the manual
bitwise shift operations (x << y) to using the BIT() macro. Thus we'll
have a more coherent set of the CSR-related macros.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/spi/spi-dw-core.c | 31 +++++++++++--------
 drivers/spi/spi-dw.h      | 64 +++++++++++++++++++--------------------
 2 files changed, 50 insertions(+), 45 deletions(-)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index 57bbffe6d6f9..b9f809989fda 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -5,6 +5,7 @@
  * Copyright (c) 2009, Intel Corporation.
  */
 
+#include <linux/bitfield.h>
 #include <linux/dma-mapping.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
@@ -254,7 +255,7 @@ static irqreturn_t dw_spi_irq(int irq, void *dev_id)
 {
 	struct spi_controller *master = dev_id;
 	struct dw_spi *dws = spi_controller_get_devdata(master);
-	u16 irq_status = dw_readl(dws, DW_SPI_ISR) & 0x3f;
+	u16 irq_status = dw_readl(dws, DW_SPI_ISR) & DW_SPI_INT_MASK;
 
 	if (!irq_status)
 		return IRQ_NONE;
@@ -273,32 +274,38 @@ static u32 dw_spi_prepare_cr0(struct dw_spi *dws, struct spi_device *spi)
 
 	if (!(dws->caps & DW_SPI_CAP_DWC_HSSI)) {
 		/* CTRLR0[ 5: 4] Frame Format */
-		cr0 |= DW_SPI_CTRLR0_FRF_MOTO_SPI << DW_PSSI_CTRLR0_FRF_OFFSET;
+		cr0 |= FIELD_PREP(DW_PSSI_CTRLR0_FRF_MASK, DW_SPI_CTRLR0_FRF_MOTO_SPI);
 
 		/*
 		 * SPI mode (SCPOL|SCPH)
 		 * CTRLR0[ 6] Serial Clock Phase
 		 * CTRLR0[ 7] Serial Clock Polarity
 		 */
-		cr0 |= ((spi->mode & SPI_CPOL) ? 1 : 0) << DW_PSSI_CTRLR0_SCOL_OFFSET;
-		cr0 |= ((spi->mode & SPI_CPHA) ? 1 : 0) << DW_PSSI_CTRLR0_SCPH_OFFSET;
+		if (spi->mode & SPI_CPOL)
+			cr0 |= DW_PSSI_CTRLR0_SCPOL;
+		if (spi->mode & SPI_CPHA)
+			cr0 |= DW_PSSI_CTRLR0_SCPHA;
 
 		/* CTRLR0[11] Shift Register Loop */
-		cr0 |= ((spi->mode & SPI_LOOP) ? 1 : 0) << DW_PSSI_CTRLR0_SRL_OFFSET;
+		if (spi->mode & SPI_LOOP)
+			cr0 |= DW_PSSI_CTRLR0_SRL;
 	} else {
 		/* CTRLR0[ 7: 6] Frame Format */
-		cr0 |= DW_SPI_CTRLR0_FRF_MOTO_SPI << DW_HSSI_CTRLR0_FRF_OFFSET;
+		cr0 |= FIELD_PREP(DW_HSSI_CTRLR0_FRF_MASK, DW_SPI_CTRLR0_FRF_MOTO_SPI);
 
 		/*
 		 * SPI mode (SCPOL|SCPH)
 		 * CTRLR0[ 8] Serial Clock Phase
 		 * CTRLR0[ 9] Serial Clock Polarity
 		 */
-		cr0 |= ((spi->mode & SPI_CPOL) ? 1 : 0) << DW_HSSI_CTRLR0_SCPOL_OFFSET;
-		cr0 |= ((spi->mode & SPI_CPHA) ? 1 : 0) << DW_HSSI_CTRLR0_SCPH_OFFSET;
+		if (spi->mode & SPI_CPOL)
+			cr0 |= DW_HSSI_CTRLR0_SCPOL;
+		if (spi->mode & SPI_CPHA)
+			cr0 |= DW_HSSI_CTRLR0_SCPHA;
 
 		/* CTRLR0[13] Shift Register Loop */
-		cr0 |= ((spi->mode & SPI_LOOP) ? 1 : 0) << DW_HSSI_CTRLR0_SRL_OFFSET;
+		if (spi->mode & SPI_LOOP)
+			cr0 |= DW_HSSI_CTRLR0_SRL;
 
 		if (dws->caps & DW_SPI_CAP_KEEMBAY_MST)
 			cr0 |= DW_HSSI_CTRLR0_KEEMBAY_MST;
@@ -320,10 +327,10 @@ void dw_spi_update_config(struct dw_spi *dws, struct spi_device *spi,
 
 	if (!(dws->caps & DW_SPI_CAP_DWC_HSSI))
 		/* CTRLR0[ 9:8] Transfer Mode */
-		cr0 |= cfg->tmode << DW_PSSI_CTRLR0_TMOD_OFFSET;
+		cr0 |= FIELD_PREP(DW_PSSI_CTRLR0_TMOD_MASK, cfg->tmode);
 	else
 		/* CTRLR0[11:10] Transfer Mode */
-		cr0 |= cfg->tmode << DW_HSSI_CTRLR0_TMOD_OFFSET;
+		cr0 |= FIELD_PREP(DW_HSSI_CTRLR0_TMOD_MASK, cfg->tmode);
 
 	dw_writel(dws, DW_SPI_CTRLR0, cr0);
 
@@ -850,7 +857,7 @@ static void dw_spi_hw_init(struct device *dev, struct dw_spi *dws)
 
 		if (!(cr0 & DW_PSSI_CTRLR0_DFS_MASK)) {
 			dws->caps |= DW_SPI_CAP_DFS32;
-			dws->dfs_offset = DW_PSSI_CTRLR0_DFS32_OFFSET;
+			dws->dfs_offset = __bf_shf(DW_PSSI_CTRLR0_DFS32_MASK);
 			dev_dbg(dev, "Detected 32-bits max data frame size\n");
 		}
 	} else {
diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index 893b78c43a50..634085eadad1 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -41,39 +41,36 @@
 #define DW_SPI_CS_OVERRIDE		0xf4
 
 /* Bit fields in CTRLR0 (DWC APB SSI) */
-#define DW_PSSI_CTRLR0_DFS_OFFSET		0
 #define DW_PSSI_CTRLR0_DFS_MASK			GENMASK(3, 0)
-#define DW_PSSI_CTRLR0_DFS32_OFFSET		16
+#define DW_PSSI_CTRLR0_DFS32_MASK		GENMASK(20, 16)
 
-#define DW_PSSI_CTRLR0_FRF_OFFSET		4
+#define DW_PSSI_CTRLR0_FRF_MASK			GENMASK(5, 4)
 #define DW_SPI_CTRLR0_FRF_MOTO_SPI		0x0
 #define DW_SPI_CTRLR0_FRF_TI_SSP		0x1
 #define DW_SPI_CTRLR0_FRF_NS_MICROWIRE		0x2
 #define DW_SPI_CTRLR0_FRF_RESV			0x3
 
-#define DW_PSSI_CTRLR0_MODE_OFFSET		6
-#define DW_PSSI_CTRLR0_SCPH_OFFSET		6
-#define DW_PSSI_CTRLR0_SCOL_OFFSET		7
+#define DW_PSSI_CTRLR0_MODE_MASK		GENMASK(7, 6)
+#define DW_PSSI_CTRLR0_SCPHA			BIT(6)
+#define DW_PSSI_CTRLR0_SCPOL			BIT(7)
 
-#define DW_PSSI_CTRLR0_TMOD_OFFSET		8
-#define DW_PSSI_CTRLR0_TMOD_MASK		(0x3 << DW_PSSI_CTRLR0_TMOD_OFFSET)
+#define DW_PSSI_CTRLR0_TMOD_MASK		GENMASK(9, 8)
 #define DW_SPI_CTRLR0_TMOD_TR			0x0	/* xmit & recv */
 #define DW_SPI_CTRLR0_TMOD_TO			0x1	/* xmit only */
 #define DW_SPI_CTRLR0_TMOD_RO			0x2	/* recv only */
 #define DW_SPI_CTRLR0_TMOD_EPROMREAD		0x3	/* eeprom read mode */
 
-#define DW_PSSI_CTRLR0_SLVOE_OFFSET		10
-#define DW_PSSI_CTRLR0_SRL_OFFSET		11
-#define DW_PSSI_CTRLR0_CFS_OFFSET		12
+#define DW_PSSI_CTRLR0_SLV_OE			BIT(10)
+#define DW_PSSI_CTRLR0_SRL			BIT(11)
+#define DW_PSSI_CTRLR0_CFS			BIT(12)
 
 /* Bit fields in CTRLR0 (DWC SSI with AHB interface) */
-#define DW_HSSI_CTRLR0_SRL_OFFSET		13
-#define DW_HSSI_CTRLR0_TMOD_OFFSET		10
+#define DW_HSSI_CTRLR0_DFS_MASK			GENMASK(4, 0)
+#define DW_HSSI_CTRLR0_FRF_MASK			GENMASK(7, 6)
+#define DW_HSSI_CTRLR0_SCPHA			BIT(8)
+#define DW_HSSI_CTRLR0_SCPOL			BIT(9)
 #define DW_HSSI_CTRLR0_TMOD_MASK		GENMASK(11, 10)
-#define DW_HSSI_CTRLR0_SCPOL_OFFSET		9
-#define DW_HSSI_CTRLR0_SCPH_OFFSET		8
-#define DW_HSSI_CTRLR0_FRF_OFFSET		6
-#define DW_HSSI_CTRLR0_DFS_OFFSET		0
+#define DW_HSSI_CTRLR0_SRL			BIT(13)
 
 /*
  * For Keem Bay, CTRLR0[31] is used to select controller mode.
@@ -86,26 +83,27 @@
 #define DW_SPI_NDF_MASK				GENMASK(15, 0)
 
 /* Bit fields in SR, 7 bits */
-#define DW_SPI_SR_MASK				0x7f	/* cover 7 bits */
-#define DW_SPI_SR_BUSY				(1 << 0)
-#define DW_SPI_SR_TF_NOT_FULL			(1 << 1)
-#define DW_SPI_SR_TF_EMPT			(1 << 2)
-#define DW_SPI_SR_RF_NOT_EMPT			(1 << 3)
-#define DW_SPI_SR_RF_FULL			(1 << 4)
-#define DW_SPI_SR_TX_ERR			(1 << 5)
-#define DW_SPI_SR_DCOL				(1 << 6)
+#define DW_SPI_SR_MASK				GENMASK(6, 0)
+#define DW_SPI_SR_BUSY				BIT(0)
+#define DW_SPI_SR_TF_NOT_FULL			BIT(1)
+#define DW_SPI_SR_TF_EMPT			BIT(2)
+#define DW_SPI_SR_RF_NOT_EMPT			BIT(3)
+#define DW_SPI_SR_RF_FULL			BIT(4)
+#define DW_SPI_SR_TX_ERR			BIT(5)
+#define DW_SPI_SR_DCOL				BIT(6)
 
 /* Bit fields in ISR, IMR, RISR, 7 bits */
-#define DW_SPI_INT_TXEI				(1 << 0)
-#define DW_SPI_INT_TXOI				(1 << 1)
-#define DW_SPI_INT_RXUI				(1 << 2)
-#define DW_SPI_INT_RXOI				(1 << 3)
-#define DW_SPI_INT_RXFI				(1 << 4)
-#define DW_SPI_INT_MSTI				(1 << 5)
+#define DW_SPI_INT_MASK				GENMASK(5, 0)
+#define DW_SPI_INT_TXEI				BIT(0)
+#define DW_SPI_INT_TXOI				BIT(1)
+#define DW_SPI_INT_RXUI				BIT(2)
+#define DW_SPI_INT_RXOI				BIT(3)
+#define DW_SPI_INT_RXFI				BIT(4)
+#define DW_SPI_INT_MSTI				BIT(5)
 
 /* Bit fields in DMACR */
-#define DW_SPI_DMACR_RDMAE			(1 << 0)
-#define DW_SPI_DMACR_TDMAE			(1 << 1)
+#define DW_SPI_DMACR_RDMAE			BIT(0)
+#define DW_SPI_DMACR_TDMAE			BIT(1)
 
 /* Mem/DMA operations helpers */
 #define DW_SPI_WAIT_RETRIES			5
-- 
2.33.0

