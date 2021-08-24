Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF2FD3F5A4E
	for <lists+linux-spi@lfdr.de>; Tue, 24 Aug 2021 11:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235509AbhHXJAx (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 24 Aug 2021 05:00:53 -0400
Received: from mga17.intel.com ([192.55.52.151]:21969 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235488AbhHXJAx (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 24 Aug 2021 05:00:53 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10085"; a="197517193"
X-IronPort-AV: E=Sophos;i="5.84,346,1620716400"; 
   d="scan'208";a="197517193"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2021 02:00:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,346,1620716400"; 
   d="scan'208";a="597515663"
Received: from ubuntu18.png.intel.com ([10.88.229.69])
  by fmsmga001.fm.intel.com with ESMTP; 24 Aug 2021 02:00:05 -0700
From:   nandhini.srikandan@intel.com
To:     fancer.lancer@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, mgross@linux.intel.com,
        kris.pan@intel.com, kenchappa.demakkanavar@intel.com,
        furong.zhou@intel.com, mallikarjunappa.sangannavar@intel.com,
        mahesh.r.vaidya@intel.com, nandhini.srikandan@intel.com,
        rashmi.a@intel.com
Subject: [PATCH v2 2/2] spi: dw: Add support for Intel Thunder Bay SPI
Date:   Tue, 24 Aug 2021 16:58:56 +0800
Message-Id: <20210824085856.12714-3-nandhini.srikandan@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210824085856.12714-1-nandhini.srikandan@intel.com>
References: <20210824085856.12714-1-nandhini.srikandan@intel.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Nandhini Srikandan <nandhini.srikandan@intel.com>

Add support for Intel Thunder Bay SPI controller, which uses DesignWare
DWC_ssi core.
Bit 31 of CTRLR0 register is set for Thunder Bay, to
configure the device as a master or as a slave serial peripheral.
Bit 14(SSTE) of CTRLR0 register should be set(1) for Thunder Bay.

Signed-off-by: Nandhini Srikandan <nandhini.srikandan@intel.com>
---
 drivers/spi/spi-dw-core.c |  7 +++++--
 drivers/spi/spi-dw-mmio.c | 20 +++++++++++++++++++-
 drivers/spi/spi-dw.h      | 12 +++++++++---
 3 files changed, 33 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index a305074c482e..f7d45318db8a 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -300,8 +300,11 @@ static u32 dw_spi_prepare_cr0(struct dw_spi *dws, struct spi_device *spi)
 		/* CTRLR0[13] Shift Register Loop */
 		cr0 |= ((spi->mode & SPI_LOOP) ? 1 : 0) << DWC_SSI_CTRLR0_SRL_OFFSET;
 
-		if (dws->caps & DW_SPI_CAP_KEEMBAY_MST)
-			cr0 |= DWC_SSI_CTRLR0_KEEMBAY_MST;
+		if (dws->caps & DW_SPI_CAP_DWC_MST)
+			cr0 |= DWC_SSI_CTRLR0_MST;
+
+		if (dws->caps & DW_SPI_CAP_DWC_SSTE)
+			cr0 |= DWC_SSI_CTRLR0_SSTE;
 	}
 
 	return cr0;
diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
index 3379720cfcb8..2bd1dedd90b0 100644
--- a/drivers/spi/spi-dw-mmio.c
+++ b/drivers/spi/spi-dw-mmio.c
@@ -217,7 +217,24 @@ static int dw_spi_dwc_ssi_init(struct platform_device *pdev,
 static int dw_spi_keembay_init(struct platform_device *pdev,
 			       struct dw_spi_mmio *dwsmmio)
 {
-	dwsmmio->dws.caps = DW_SPI_CAP_KEEMBAY_MST | DW_SPI_CAP_DWC_SSI;
+	/*
+	 * Set MST to make keem bay SPI as master.
+	 */
+	dwsmmio->dws.caps = DW_SPI_CAP_DWC_MST | DW_SPI_CAP_DWC_SSI;
+
+	return 0;
+}
+
+static int dw_spi_thunderbay_init(struct platform_device *pdev,
+				  struct dw_spi_mmio *dwsmmio)
+{
+	/*
+	 * Set MST to make thunder bay SPI as master.
+	 * Set SSTE to enable slave select toggle bit which is required
+	 * for the slave devices connected to the thunder bay SPI controller.
+	 */
+	dwsmmio->dws.caps = DW_SPI_CAP_DWC_MST | DW_SPI_CAP_DWC_SSTE |
+			    DW_SPI_CAP_DWC_SSI;
 
 	return 0;
 }
@@ -349,6 +366,7 @@ static const struct of_device_id dw_spi_mmio_of_match[] = {
 	{ .compatible = "renesas,rzn1-spi", .data = dw_spi_dw_apb_init},
 	{ .compatible = "snps,dwc-ssi-1.01a", .data = dw_spi_dwc_ssi_init},
 	{ .compatible = "intel,keembay-ssi", .data = dw_spi_keembay_init},
+	{ .compatible = "intel,thunderbay-ssi", .data = dw_spi_thunderbay_init},
 	{ .compatible = "microchip,sparx5-spi", dw_spi_mscc_sparx5_init},
 	{ .compatible = "canaan,k210-spi", dw_spi_canaan_k210_init},
 	{ /* end of table */}
diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index b665e040862c..9fffe0a02f3a 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -76,11 +76,16 @@
 #define DWC_SSI_CTRLR0_DFS_OFFSET	0
 
 /*
- * For Keem Bay, CTRLR0[31] is used to select controller mode.
+ * CTRLR0[31] is used to select controller mode.
  * 0: SSI is slave
  * 1: SSI is master
  */
-#define DWC_SSI_CTRLR0_KEEMBAY_MST	BIT(31)
+#define DWC_SSI_CTRLR0_MST		BIT(31)
+
+/*
+ * CTRLR0[14] is used to enable/disable Slave Select Toggle bit
+ */
+#define DWC_SSI_CTRLR0_SSTE		BIT(14)
 
 /* Bit fields in CTRLR1 */
 #define SPI_NDF_MASK			GENMASK(15, 0)
@@ -122,9 +127,10 @@ enum dw_ssi_type {
 
 /* DW SPI capabilities */
 #define DW_SPI_CAP_CS_OVERRIDE		BIT(0)
-#define DW_SPI_CAP_KEEMBAY_MST		BIT(1)
+#define DW_SPI_CAP_DWC_MST		BIT(1)
 #define DW_SPI_CAP_DWC_SSI		BIT(2)
 #define DW_SPI_CAP_DFS32		BIT(3)
+#define DW_SPI_CAP_DWC_SSTE		BIT(4)
 
 /* Slave spi_transfer/spi_mem_op related */
 struct dw_spi_cfg {
-- 
2.17.1

