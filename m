Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A323F1C3902
	for <lists+linux-spi@lfdr.de>; Mon,  4 May 2020 14:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728633AbgEDMNH (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 4 May 2020 08:13:07 -0400
Received: from mga01.intel.com ([192.55.52.88]:41917 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728592AbgEDMNG (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 4 May 2020 08:13:06 -0400
IronPort-SDR: EHA1nLvqQ1yhIZGU+Sh5TEjkOgbrbwuM5MVS4Ma0xaGV+VnRa3of6GhjOiOP6JFlLLVl55sLwg
 W1LCA0RJurqw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2020 05:13:06 -0700
IronPort-SDR: 5lsyzGarHbp9U4uXs8inPp2oQ2NGKwfe6GbaQVdt4gPxO3nl2RLp5bbTThUO72wG800Zm92+La
 /ANFEUuUdzLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,351,1583222400"; 
   d="scan'208";a="295480513"
Received: from wwanmoha-ilbpg2.png.intel.com ([10.88.227.42])
  by orsmga008.jf.intel.com with ESMTP; 04 May 2020 05:13:04 -0700
From:   Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
To:     broonie@kernel.org, robh+dt@kernel.org
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        andriy.shevchenko@linux.intel.com,
        wan.ahmad.zainie.wan.mohamad@intel.com
Subject: [PATCH v3 4/7] spi: dw: Add support for Intel Keem Bay SPI
Date:   Mon,  4 May 2020 20:11:48 +0800
Message-Id: <20200504121151.1085-5-wan.ahmad.zainie.wan.mohamad@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200504121151.1085-1-wan.ahmad.zainie.wan.mohamad@intel.com>
References: <20200504121151.1085-1-wan.ahmad.zainie.wan.mohamad@intel.com>
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

