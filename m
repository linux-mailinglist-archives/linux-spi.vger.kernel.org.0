Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3796A2B8B2E
	for <lists+linux-spi@lfdr.de>; Thu, 19 Nov 2020 06:58:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbgKSF4D (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 19 Nov 2020 00:56:03 -0500
Received: from mga02.intel.com ([134.134.136.20]:15558 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725802AbgKSF4D (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 19 Nov 2020 00:56:03 -0500
IronPort-SDR: l9esvW2kW7Ix5KfB7j6CmjYZ0vySf5e2UMqAbm6WrDXyrrF5Y42q7egOwZ08wAZm4wWCbqdx1B
 PS3LXMgRnBJQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9809"; a="158271218"
X-IronPort-AV: E=Sophos;i="5.77,489,1596524400"; 
   d="scan'208";a="158271218"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2020 21:56:02 -0800
IronPort-SDR: 1bCCA+NdNA2ugfiPUE/ENQRYXB7aH4UUYJubJYaBUuS7yYt+RkYHnv1B0XKC3HdSzC3PIpFdkk
 twdA1BwOXQXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,489,1596524400"; 
   d="scan'208";a="325857376"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by orsmga003.jf.intel.com with ESMTP; 18 Nov 2020 21:56:00 -0800
From:   "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
To:     broonie@kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Cc:     linux-mtd@lists.infradead.org, vigneshr@ti.com, p.yadav@ti.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        Ramuthevar Vadivel Murugan 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Subject: [PATCH v8 1/6] spi: cadence-quadspi: Add QSPI support for Intel LGM SoC
Date:   Thu, 19 Nov 2020 13:55:49 +0800
Message-Id: <20201119055551.26493-2-vadivel.muruganx.ramuthevar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20201119055551.26493-1-vadivel.muruganx.ramuthevar@linux.intel.com>
References: <20201119055551.26493-1-vadivel.muruganx.ramuthevar@linux.intel.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>

Add QSPI controller support for Intel LGM SoC.

Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
---
 drivers/spi/Kconfig               | 2 +-
 drivers/spi/spi-cadence-quadspi.c | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index d2c976e55b8b..926da61eee5a 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -203,7 +203,7 @@ config SPI_CADENCE
 
 config SPI_CADENCE_QUADSPI
 	tristate "Cadence Quad SPI controller"
-	depends on OF && (ARM || ARM64 || COMPILE_TEST)
+	depends on OF && (ARM || ARM64 || X86 || COMPILE_TEST)
 	help
 	  Enable support for the Cadence Quad SPI Flash controller.
 
diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 40938cf3806d..d7b10c46fa70 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1401,6 +1401,9 @@ static const struct of_device_id cqspi_dt_ids[] = {
 		.compatible = "ti,am654-ospi",
 		.data = &am654_ospi,
 	},
+	{
+		.compatible = "intel,lgm-qspi",
+	},
 	{ /* end of table */ }
 };
 
-- 
2.11.0

