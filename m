Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23E4529E569
	for <lists+linux-spi@lfdr.de>; Thu, 29 Oct 2020 08:57:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbgJ2HYo (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 29 Oct 2020 03:24:44 -0400
Received: from mga09.intel.com ([134.134.136.24]:31205 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726754AbgJ2HYf (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 29 Oct 2020 03:24:35 -0400
IronPort-SDR: nPjjZSaxiElrJoY9dwW2yN7zdIctwT4bSMo2t1hSVoHHhEJHniZwV7uaatF0pRJVJnUF8/Hesh
 kEWd8zTMN5xA==
X-IronPort-AV: E=McAfee;i="6000,8403,9788"; a="168516528"
X-IronPort-AV: E=Sophos;i="5.77,429,1596524400"; 
   d="scan'208";a="168516528"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2020 23:20:24 -0700
IronPort-SDR: tZE6mmXUXYZjmK5aDnlo6P1wOk6y6+RhyQw2MA2agTbm9nmDfmuKrvQIiB3twv0xOXFZoe3lqy
 t36ePvgQucPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,429,1596524400"; 
   d="scan'208";a="469015690"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by orsmga004.jf.intel.com with ESMTP; 28 Oct 2020 23:20:20 -0700
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
Subject: [PATCH v5 1/6] spi: cadence-quadspi: Add QSPI support for Intel LGM SoC
Date:   Thu, 29 Oct 2020 14:20:09 +0800
Message-Id: <20201029062014.27620-2-vadivel.muruganx.ramuthevar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20201029062014.27620-1-vadivel.muruganx.ramuthevar@linux.intel.com>
References: <20201029062014.27620-1-vadivel.muruganx.ramuthevar@linux.intel.com>
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

