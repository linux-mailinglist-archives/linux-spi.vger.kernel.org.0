Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76C7044D225
	for <lists+linux-spi@lfdr.de>; Thu, 11 Nov 2021 07:54:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232034AbhKKG5d (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 11 Nov 2021 01:57:33 -0500
Received: from mga11.intel.com ([192.55.52.93]:34073 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231730AbhKKG53 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 11 Nov 2021 01:57:29 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10164"; a="230324766"
X-IronPort-AV: E=Sophos;i="5.87,225,1631602800"; 
   d="scan'208";a="230324766"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2021 22:54:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,225,1631602800"; 
   d="scan'208";a="642864959"
Received: from ubuntu18.png.intel.com ([10.88.229.69])
  by fmsmga001.fm.intel.com with ESMTP; 10 Nov 2021 22:54:38 -0800
From:   nandhini.srikandan@intel.com
To:     fancer.lancer@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, mgross@linux.intel.com,
        kris.pan@intel.com, kenchappa.demakkanavar@intel.com,
        furong.zhou@intel.com, mallikarjunappa.sangannavar@intel.com,
        mahesh.r.vaidya@intel.com, nandhini.srikandan@intel.com,
        rashmi.a@intel.com
Subject: [PATCH v3 5/5] spi: dw: Add support for Intel Thunder Bay SPI controller
Date:   Thu, 11 Nov 2021 14:52:01 +0800
Message-Id: <20211111065201.10249-6-nandhini.srikandan@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211111065201.10249-1-nandhini.srikandan@intel.com>
References: <20211111065201.10249-1-nandhini.srikandan@intel.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Nandhini Srikandan <nandhini.srikandan@intel.com>

Add support for Intel Thunder Bay SPI controller, which uses DesignWare
DWC_ssi core and also add common init function for both Keem Bay and
Thunder Bay.

Signed-off-by: Nandhini Srikandan <nandhini.srikandan@intel.com>
---
 drivers/spi/spi-dw-mmio.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
index 3379720cfcb8..c357680f4aa3 100644
--- a/drivers/spi/spi-dw-mmio.c
+++ b/drivers/spi/spi-dw-mmio.c
@@ -214,10 +214,10 @@ static int dw_spi_dwc_ssi_init(struct platform_device *pdev,
 	return 0;
 }
 
-static int dw_spi_keembay_init(struct platform_device *pdev,
-			       struct dw_spi_mmio *dwsmmio)
+static int dw_spi_intel_init(struct platform_device *pdev,
+			     struct dw_spi_mmio *dwsmmio)
 {
-	dwsmmio->dws.caps = DW_SPI_CAP_KEEMBAY_MST | DW_SPI_CAP_DWC_SSI;
+	dwsmmio->dws.caps = DW_SPI_CAP_DWC_SSI;
 
 	return 0;
 }
@@ -348,7 +348,8 @@ static const struct of_device_id dw_spi_mmio_of_match[] = {
 	{ .compatible = "amazon,alpine-dw-apb-ssi", .data = dw_spi_alpine_init},
 	{ .compatible = "renesas,rzn1-spi", .data = dw_spi_dw_apb_init},
 	{ .compatible = "snps,dwc-ssi-1.01a", .data = dw_spi_dwc_ssi_init},
-	{ .compatible = "intel,keembay-ssi", .data = dw_spi_keembay_init},
+	{ .compatible = "intel,keembay-ssi", .data = dw_spi_intel_init},
+	{ .compatible = "intel,thunderbay-ssi", .data = dw_spi_intel_init},
 	{ .compatible = "microchip,sparx5-spi", dw_spi_mscc_sparx5_init},
 	{ .compatible = "canaan,k210-spi", dw_spi_canaan_k210_init},
 	{ /* end of table */}
-- 
2.17.1

