Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 107502901F1
	for <lists+linux-spi@lfdr.de>; Fri, 16 Oct 2020 11:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405764AbgJPJcQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 16 Oct 2020 05:32:16 -0400
Received: from mga07.intel.com ([134.134.136.100]:44810 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405685AbgJPJcO (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 16 Oct 2020 05:32:14 -0400
IronPort-SDR: v3iy7ApjClUBPxbRgfuVF0SH3NYbxCyBkPDy7TSIABhVrw3eSNWb40au6LAg6bf0fbODlWnAWO
 XK3mPzW8i0xg==
X-IronPort-AV: E=McAfee;i="6000,8403,9775"; a="230763033"
X-IronPort-AV: E=Sophos;i="5.77,382,1596524400"; 
   d="scan'208";a="230763033"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2020 02:32:12 -0700
IronPort-SDR: Mp6Tp/RETcAlV94DqN0Aos0Zaq8oC3zpLNY589c/nNqmrGOFmO/hSoZd8NsJSSjHbdFJzrYj5Q
 LNNcHfajz46g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,382,1596524400"; 
   d="scan'208";a="522175941"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by fmsmga005.fm.intel.com with ESMTP; 16 Oct 2020 02:32:09 -0700
From:   "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
To:     vigneshr@ti.com, tudor.ambarus@microchip.com, broonie@kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, miquel.raynal@bootlin.com,
        simon.k.r.goldschmidt@gmail.com, dinguyen@kernel.org,
        richard@nod.at, cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        Ramuthevar Vadivel Murugan 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Subject: [PATCH v1 6/6] spi: cadence-quadspi: Add multi-chipselect support for Intel LGM SoC
Date:   Fri, 16 Oct 2020 17:31:38 +0800
Message-Id: <20201016093138.28871-7-vadivel.muruganx.ramuthevar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20201016093138.28871-1-vadivel.muruganx.ramuthevar@linux.intel.com>
References: <20201016093138.28871-1-vadivel.muruganx.ramuthevar@linux.intel.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>

Add multiple chipselect support for Intel LGM SoCs,
currently QSPI-NOR and QSPI-NAND supported.

Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
---
 drivers/spi/spi-cadence-quadspi.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 3d017b484114..3bf6d3697631 100644
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
@@ -1070,6 +1072,14 @@ static int cqspi_of_get_pdata(struct cqspi_st *cqspi)
 		return -ENXIO;
 	}
 
+	if (!cqspi->use_direct_mode) {
+		if (of_property_read_u32(np, "num-chipselect",
+					 &cqspi->num_chipselect)) {
+			dev_err(dev, "couldn't determine number of cs\n");
+			return -ENXIO;
+		}
+	}
+
 	cqspi->rclk_en = of_property_read_bool(np, "cdns,rclk-en");
 
 	return 0;
@@ -1307,6 +1317,9 @@ static int cqspi_probe(struct platform_device *pdev)
 	cqspi->current_cs = -1;
 	cqspi->sclk = 0;
 
+	if (ddata->hwcaps_mask & CQSPI_SUPPORTS_MULTI_CHIPSELECT)
+		master->num_chipselect = cqspi->num_chipselect;
+
 	ret = cqspi_setup_flash(cqspi);
 	if (ret) {
 		dev_err(dev, "failed to setup flash parameters %d\n", ret);
@@ -1396,6 +1409,7 @@ static const struct cqspi_driver_platdata am654_ospi = {
 };
 
 static const struct cqspi_driver_platdata intel_lgm_qspi = {
+	.hwcaps_mask = CQSPI_SUPPORTS_MULTI_CHIPSELECT,
 	.quirks = CQSPI_DISABLE_DAC_MODE,
 };
 
-- 
2.11.0

