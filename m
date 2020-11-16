Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02D352B3BB2
	for <lists+linux-spi@lfdr.de>; Mon, 16 Nov 2020 04:10:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbgKPDKR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 15 Nov 2020 22:10:17 -0500
Received: from mga18.intel.com ([134.134.136.126]:37810 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726742AbgKPDKR (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Sun, 15 Nov 2020 22:10:17 -0500
IronPort-SDR: mQXzsiIIIa+apSBXICJXEWqdYvS6SWO24LYMQWp4o725wgFDAjT9c3Dic4z1m3GKbutG40HTAo
 fBvapXJ4POoA==
X-IronPort-AV: E=McAfee;i="6000,8403,9806"; a="158472675"
X-IronPort-AV: E=Sophos;i="5.77,481,1596524400"; 
   d="scan'208";a="158472675"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2020 19:10:15 -0800
IronPort-SDR: mXT0HsBxJmnVtj13F+igXXbT3b9UWxONJCDC9E02eV9kV96n0dKSqsgKF9MPojMDSx9CkPz3DZ
 R9SjadXodpzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,481,1596524400"; 
   d="scan'208";a="324663391"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by orsmga003.jf.intel.com with ESMTP; 15 Nov 2020 19:10:12 -0800
From:   "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
To:     broonie@kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Cc:     linux-mtd@lists.infradead.org, vigneshr@ti.com, p.yadav@ti.com,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        Ramuthevar Vadivel Murugan 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Subject: [PATCH v7 1/6] spi: cadence-quadspi: Add QSPI support for Intel LGM SoC
Date:   Mon, 16 Nov 2020 11:09:58 +0800
Message-Id: <20201116031003.19062-2-vadivel.muruganx.ramuthevar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20201116031003.19062-1-vadivel.muruganx.ramuthevar@linux.intel.com>
References: <20201116031003.19062-1-vadivel.muruganx.ramuthevar@linux.intel.com>
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

