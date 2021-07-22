Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA5903D1D76
	for <lists+linux-spi@lfdr.de>; Thu, 22 Jul 2021 07:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbhGVEyK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 22 Jul 2021 00:54:10 -0400
Received: from mga05.intel.com ([192.55.52.43]:49349 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230306AbhGVEyI (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 22 Jul 2021 00:54:08 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10052"; a="297132160"
X-IronPort-AV: E=Sophos;i="5.84,260,1620716400"; 
   d="scan'208";a="297132160"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2021 22:34:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,260,1620716400"; 
   d="scan'208";a="632868491"
Received: from ubuntu18.png.intel.com ([10.88.229.69])
  by orsmga005.jf.intel.com with ESMTP; 21 Jul 2021 22:34:40 -0700
From:   nandhini.srikandan@intel.com
To:     fancer.lancer@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, mgross@linux.intel.com,
        kris.pan@intel.com, kenchappa.demakkanavar@intel.com,
        furong.zhou@intel.com, mallikarjunappa.sangannavar@intel.com,
        mahesh.r.vaidya@intel.com, nandhini.srikandan@intel.com,
        rashmi.a@intel.com
Subject: =?utf-8?q?=5B=E2=80=9CPATCH=E2=80=9D=202/2=5D=20spi=3A=20dw=3A=20Add=20support=20for=20Intel=20Thunder=20Bay=20SPI?=
Date:   Thu, 22 Jul 2021 13:33:58 +0800
Message-Id: <20210722053358.29682-3-nandhini.srikandan@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210722053358.29682-1-nandhini.srikandan@intel.com>
References: <20210722053358.29682-1-nandhini.srikandan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Nandhini Srikandan <nandhini.srikandan@intel.com>

Add support for Intel Thunder Bay SPI controller, which uses DesignWare
DWC_ssi core.
Bit 31 of CTRLR0 register is added for Thunder Bay, to
configure the device as a master or as a slave serial peripheral.
Bit 14(SSTE) of CTRLR0 register should be set(1) for Thunder Bay.
Added reset of SPI controller required for Thunder Bay.

Signed-off-by: Nandhini Srikandan <nandhini.srikandan@intel.com>
---
 drivers/spi/spi-dw-core.c |  6 ++++++
 drivers/spi/spi-dw-mmio.c | 20 ++++++++++++++++++++
 drivers/spi/spi-dw.h      | 15 +++++++++++++++
 3 files changed, 41 insertions(+)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index a305074c482e..eecf8dcd0677 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -302,6 +302,12 @@ static u32 dw_spi_prepare_cr0(struct dw_spi *dws, struct spi_device *spi)
 
 		if (dws->caps & DW_SPI_CAP_KEEMBAY_MST)
 			cr0 |= DWC_SSI_CTRLR0_KEEMBAY_MST;
+
+		if (dws->caps & DW_SPI_CAP_THUNDERBAY_MST)
+			cr0 |= DWC_SSI_CTRLR0_THUNDERBAY_MST;
+
+		if (dws->caps & DW_SPI_CAP_THUNDERBAY_SSTE)
+			cr0 |= DWC_SSI_CTRLR0_THUNDERBAY_SSTE;
 	}
 
 	return cr0;
diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
index 3379720cfcb8..ca9aad078752 100644
--- a/drivers/spi/spi-dw-mmio.c
+++ b/drivers/spi/spi-dw-mmio.c
@@ -222,6 +222,15 @@ static int dw_spi_keembay_init(struct platform_device *pdev,
 	return 0;
 }
 
+static int dw_spi_thunderbay_init(struct platform_device *pdev,
+				  struct dw_spi_mmio *dwsmmio)
+{
+	dwsmmio->dws.caps = DW_SPI_CAP_THUNDERBAY_MST | DW_SPI_CAP_THUNDERBAY_RST |
+			    DW_SPI_CAP_THUNDERBAY_SSTE | DW_SPI_CAP_DWC_SSI;
+
+	return 0;
+}
+
 static int dw_spi_canaan_k210_init(struct platform_device *pdev,
 				   struct dw_spi_mmio *dwsmmio)
 {
@@ -243,6 +252,7 @@ static int dw_spi_mmio_probe(struct platform_device *pdev)
 			 struct dw_spi_mmio *dwsmmio);
 	struct dw_spi_mmio *dwsmmio;
 	struct resource *mem;
+	struct reset_control *rst;
 	struct dw_spi *dws;
 	int ret;
 	int num_cs;
@@ -309,6 +319,15 @@ static int dw_spi_mmio_probe(struct platform_device *pdev)
 			goto out;
 	}
 
+	if (dws->caps & DW_SPI_CAP_THUNDERBAY_RST) {
+		rst = devm_reset_control_get_exclusive(&pdev->dev, NULL);
+		if (!IS_ERR(rst)) {
+			reset_control_assert(rst);
+			udelay(2);
+			reset_control_deassert(rst);
+		}
+	}
+
 	pm_runtime_enable(&pdev->dev);
 
 	ret = dw_spi_add_host(&pdev->dev, dws);
@@ -349,6 +368,7 @@ static const struct of_device_id dw_spi_mmio_of_match[] = {
 	{ .compatible = "renesas,rzn1-spi", .data = dw_spi_dw_apb_init},
 	{ .compatible = "snps,dwc-ssi-1.01a", .data = dw_spi_dwc_ssi_init},
 	{ .compatible = "intel,keembay-ssi", .data = dw_spi_keembay_init},
+	{ .compatible = "intel,thunderbay-ssi", .data = dw_spi_thunderbay_init},
 	{ .compatible = "microchip,sparx5-spi", dw_spi_mscc_sparx5_init},
 	{ .compatible = "canaan,k210-spi", dw_spi_canaan_k210_init},
 	{ /* end of table */}
diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index b665e040862c..bfe1d5edc25a 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -82,6 +82,18 @@
  */
 #define DWC_SSI_CTRLR0_KEEMBAY_MST	BIT(31)
 
+/*
+ * For Thunder Bay, CTRLR0[14] should be set to 1.
+ */
+#define DWC_SSI_CTRLR0_THUNDERBAY_SSTE	BIT(14)
+
+/*
+ * For Thunder Bay, CTRLR0[31] is used to select controller mode.
+ * 0: SSI is slave
+ * 1: SSI is master
+ */
+#define DWC_SSI_CTRLR0_THUNDERBAY_MST	BIT(31)
+
 /* Bit fields in CTRLR1 */
 #define SPI_NDF_MASK			GENMASK(15, 0)
 
@@ -125,6 +137,9 @@ enum dw_ssi_type {
 #define DW_SPI_CAP_KEEMBAY_MST		BIT(1)
 #define DW_SPI_CAP_DWC_SSI		BIT(2)
 #define DW_SPI_CAP_DFS32		BIT(3)
+#define DW_SPI_CAP_THUNDERBAY_MST	BIT(4)
+#define DW_SPI_CAP_THUNDERBAY_RST	BIT(5)
+#define DW_SPI_CAP_THUNDERBAY_SSTE	BIT(6)
 
 /* Slave spi_transfer/spi_mem_op related */
 struct dw_spi_cfg {
-- 
2.17.1

