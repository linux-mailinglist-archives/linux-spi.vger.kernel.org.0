Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 329391C565A
	for <lists+linux-spi@lfdr.de>; Tue,  5 May 2020 15:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729028AbgEENHg (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 5 May 2020 09:07:36 -0400
Received: from mga02.intel.com ([134.134.136.20]:12710 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728268AbgEENHg (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 5 May 2020 09:07:36 -0400
IronPort-SDR: 4cOEtDb+Jnq5WaA0IttrZqdStLevdsIga65RcIIfLSiLHwIjZBDl6soedeX3YHGmtAWBWSd0Ga
 6U9QyCKMlH+A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2020 06:07:36 -0700
IronPort-SDR: Rn/jhVeeClFyI2gibk+6EymJUbGMJqHnEntQ0yBDFlt53S8h2zGocmngFuuxf76iL1LEztwJI1
 78pKW8fLrxWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,355,1583222400"; 
   d="scan'208";a="277868878"
Received: from wwanmoha-ilbpg2.png.intel.com ([10.88.227.42])
  by orsmga002.jf.intel.com with ESMTP; 05 May 2020 06:07:35 -0700
From:   Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
To:     broonie@kernel.org, robh+dt@kernel.org
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        andriy.shevchenko@linux.intel.com,
        wan.ahmad.zainie.wan.mohamad@intel.com
Subject: [PATCH v5 5/7] spi: dw: Add support for Intel Keem Bay SPI
Date:   Tue,  5 May 2020 21:06:16 +0800
Message-Id: <20200505130618.554-6-wan.ahmad.zainie.wan.mohamad@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200505130618.554-1-wan.ahmad.zainie.wan.mohamad@intel.com>
References: <20200505130618.554-1-wan.ahmad.zainie.wan.mohamad@intel.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add support for Intel Keem Bay SPI controller, which uses DesignWare
DWC_ssi core. Bit 31 of CTRLR0 register is added for Keem Bay, to
configure the device as a master or as a slave serial peripheral.

Signed-off-by: Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-dw-mmio.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
index 1df6f3deee2c..abd3bb5e52db 100644
--- a/drivers/spi/spi-dw-mmio.c
+++ b/drivers/spi/spi-dw-mmio.c
@@ -44,6 +44,13 @@ struct dw_spi_mmio {
 #define MSCC_SPI_MST_SW_MODE_SW_PIN_CTRL_MODE	BIT(13)
 #define MSCC_SPI_MST_SW_MODE_SW_SPI_CS(x)	(x << 5)
 
+/*
+ * For Keem Bay, CTRLR0[31] is used to select controller mode.
+ * 0: SSI is slave
+ * 1: SSI is master
+ */
+#define KEEMBAY_CTRLR0_SSIC_IS_MST		BIT(31)
+
 struct dw_spi_mscc {
 	struct regmap       *syscon;
 	void __iomem        *spi_mst;
@@ -155,6 +162,24 @@ static int dw_spi_dwc_ssi_init(struct platform_device *pdev,
 	return 0;
 }
 
+static u32 dw_spi_update_cr0_keembay(struct spi_controller *master,
+				     struct spi_device *spi,
+				     struct spi_transfer *transfer)
+{
+	u32 cr0 = dw_spi_update_cr0_v1_01a(master, spi, transfer);
+
+	return cr0 | KEEMBAY_CTRLR0_SSIC_IS_MST;
+}
+
+static int dw_spi_keembay_init(struct platform_device *pdev,
+			       struct dw_spi_mmio *dwsmmio)
+{
+	/* Register hook to configure CTRLR0 */
+	dwsmmio->dws.update_cr0 = dw_spi_update_cr0_keembay;
+
+	return 0;
+}
+
 static int dw_spi_mmio_probe(struct platform_device *pdev)
 {
 	int (*init_func)(struct platform_device *pdev,
@@ -254,6 +279,7 @@ static const struct of_device_id dw_spi_mmio_of_match[] = {
 	{ .compatible = "amazon,alpine-dw-apb-ssi", .data = dw_spi_alpine_init},
 	{ .compatible = "renesas,rzn1-spi", .data = dw_spi_dw_apb_init},
 	{ .compatible = "snps,dwc-ssi-1.01a", .data = dw_spi_dwc_ssi_init},
+	{ .compatible = "intel,keembay-ssi", .data = dw_spi_keembay_init},
 	{ /* end of table */}
 };
 MODULE_DEVICE_TABLE(of, dw_spi_mmio_of_match);
-- 
2.17.1

