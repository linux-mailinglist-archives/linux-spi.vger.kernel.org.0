Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B900029FD46
	for <lists+linux-spi@lfdr.de>; Fri, 30 Oct 2020 06:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725837AbgJ3FcF (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 30 Oct 2020 01:32:05 -0400
Received: from mga18.intel.com ([134.134.136.126]:33553 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725767AbgJ3FcF (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 30 Oct 2020 01:32:05 -0400
IronPort-SDR: 0csXzzuiV8YU6FYu6vLxUk9BZXiSl3f/tM8hArW6FyP0BX+xOm5xjhHIwVsHlnef5LEDHkkW6Z
 GJfuK+4lAMoQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9789"; a="156337566"
X-IronPort-AV: E=Sophos;i="5.77,432,1596524400"; 
   d="scan'208";a="156337566"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2020 22:32:03 -0700
IronPort-SDR: U7JzXNFGMm3321XDN4ocnop87DuqIPOuI78sXgJRcayyMOsczPEsW3G1yna+VB3cf6MYPAbo3i
 F2WL/7ozEKHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,432,1596524400"; 
   d="scan'208";a="304838593"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by fmsmga007.fm.intel.com with ESMTP; 29 Oct 2020 22:32:00 -0700
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
Subject: [PATCH v6 1/6] spi: cadence-quadspi: Add QSPI support for Intel LGM SoC
Date:   Fri, 30 Oct 2020 13:31:48 +0800
Message-Id: <20201030053153.5319-2-vadivel.muruganx.ramuthevar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20201030053153.5319-1-vadivel.muruganx.ramuthevar@linux.intel.com>
References: <20201030053153.5319-1-vadivel.muruganx.ramuthevar@linux.intel.com>
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

