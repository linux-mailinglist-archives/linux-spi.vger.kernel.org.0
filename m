Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE9829A677
	for <lists+linux-spi@lfdr.de>; Tue, 27 Oct 2020 09:23:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2894657AbgJ0IXN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 27 Oct 2020 04:23:13 -0400
Received: from mga05.intel.com ([192.55.52.43]:45857 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2894646AbgJ0IXM (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 27 Oct 2020 04:23:12 -0400
IronPort-SDR: 9hu8Zy9D4BD7adXZB6CF8IAOQjFax2HwtgydSI5xiR/ACHBnPh3FfEEUl8XY99zEJP45Vt1zDW
 /asByAAvAAHQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9786"; a="252743856"
X-IronPort-AV: E=Sophos;i="5.77,423,1596524400"; 
   d="scan'208";a="252743856"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2020 01:23:11 -0700
IronPort-SDR: n/+N35TcP2mV5TX0XWomAdxWBA2ASaph8pFSoApTVPFjKdzQdhWco7FS/Rb4MJJHY8WB5k+loi
 NI2jOXjWop4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,423,1596524400"; 
   d="scan'208";a="524610018"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by fmsmga006.fm.intel.com with ESMTP; 27 Oct 2020 01:23:07 -0700
From:   "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
To:     broonie@kernel.org, vigneshr@ti.com, tudor.ambarus@microchip.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, miquel.raynal@bootlin.com,
        simon.k.r.goldschmidt@gmail.com, dinguyen@kernel.org,
        richard@nod.at, cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        Ramuthevar Vadivel Murugan 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Subject: [PATCH v4 3/6] spi: cadence-quadspi: Add multi-chipselect support for Intel LGM SoC
Date:   Tue, 27 Oct 2020 16:22:48 +0800
Message-Id: <20201027082251.30056-4-vadivel.muruganx.ramuthevar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20201027082251.30056-1-vadivel.muruganx.ramuthevar@linux.intel.com>
References: <20201027082251.30056-1-vadivel.muruganx.ramuthevar@linux.intel.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>

Add multiple chipselect support for Intel LGM SoCs,
currently QSPI-NOR and QSPI-NAND supported.

Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
---
 drivers/spi/spi-cadence-quadspi.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 6d6f7c440ece..c4440797db43 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -38,6 +38,7 @@
 
 /* Capabilities */
 #define CQSPI_SUPPORTS_OCTAL		BIT(0)
+#define CQSPI_SUPPORTS_MULTI_CHIPSELECT BIT(1)
 
 struct cqspi_st;
 
@@ -75,6 +76,7 @@ struct cqspi_st {
 	bool			is_decoded_cs;
 	u32			fifo_depth;
 	u32			fifo_width;
+	u32			num_chipselect;
 	bool			rclk_en;
 	u32			trigger_address;
 	u32			wr_delay;
@@ -1049,6 +1051,7 @@ static int cqspi_of_get_flash_pdata(struct platform_device *pdev,
 
 static int cqspi_of_get_pdata(struct cqspi_st *cqspi)
 {
+	const struct cqspi_driver_platdata *ddata;
 	struct device *dev = &cqspi->pdev->dev;
 	struct device_node *np = dev->of_node;
 
@@ -1070,6 +1073,15 @@ static int cqspi_of_get_pdata(struct cqspi_st *cqspi)
 		return -ENXIO;
 	}
 
+	ddata  = of_device_get_match_data(dev);
+	if (ddata->hwcaps_mask & CQSPI_SUPPORTS_MULTI_CHIPSELECT) {
+		if (of_property_read_u32(np, "num-chipselect",
+					 &cqspi->num_chipselect)) {
+			dev_err(dev, "couldn't determine number of cs\n");
+			return -ENXIO;
+		}
+	}
+
 	cqspi->rclk_en = of_property_read_bool(np, "cdns,rclk-en");
 
 	return 0;
@@ -1307,6 +1319,9 @@ static int cqspi_probe(struct platform_device *pdev)
 	cqspi->current_cs = -1;
 	cqspi->sclk = 0;
 
+	if (ddata->hwcaps_mask & CQSPI_SUPPORTS_MULTI_CHIPSELECT)
+		master->num_chipselect = cqspi->num_chipselect;
+
 	ret = cqspi_setup_flash(cqspi);
 	if (ret) {
 		dev_err(dev, "failed to setup flash parameters %d\n", ret);
@@ -1396,6 +1411,7 @@ static const struct cqspi_driver_platdata am654_ospi = {
 };
 
 static const struct cqspi_driver_platdata intel_lgm_qspi = {
+	.hwcaps_mask = CQSPI_SUPPORTS_MULTI_CHIPSELECT,
 	.quirks = CQSPI_DISABLE_DAC_MODE,
 };
 
-- 
2.11.0

