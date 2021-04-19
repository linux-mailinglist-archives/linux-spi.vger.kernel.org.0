Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59A7736406E
	for <lists+linux-spi@lfdr.de>; Mon, 19 Apr 2021 13:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238539AbhDSLZg (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 19 Apr 2021 07:25:36 -0400
Received: from mga14.intel.com ([192.55.52.115]:45894 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238476AbhDSLZe (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 19 Apr 2021 07:25:34 -0400
IronPort-SDR: 4aO9E10Yd9e0jnuv3hsacL1J9PRl0bj3HTBu2wtjy9e5NZ9Us3vDjXSfXNcsPoQR/vdxSlT6+/
 dKw46UlzOtwQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9958"; a="194867412"
X-IronPort-AV: E=Sophos;i="5.82,234,1613462400"; 
   d="scan'208";a="194867412"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2021 04:25:04 -0700
IronPort-SDR: reVk2Wkqo6o5Klxv3OkJlKBRcpNRK76gAEuV9YL/TIWPlSi1jMDGU+CiNDfJraMbZAd631vMnF
 xWuZyc5U0sRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,234,1613462400"; 
   d="scan'208";a="613365712"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 19 Apr 2021 04:25:00 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 5209D17E; Mon, 19 Apr 2021 14:25:18 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Haibo Chen <haibo.chen@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Yangbo Lu <yangbo.lu@nxp.com>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 3/6] mmc: mmc_spi: Set up polling even if voltage-ranges is not present
Date:   Mon, 19 Apr 2021 14:24:56 +0300
Message-Id: <20210419112459.25241-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210419112459.25241-1-andriy.shevchenko@linux.intel.com>
References: <20210419112459.25241-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

When voltage-ranges property is not present the driver assumes that
it is 3.3v (3.2v..3.4v). But at the same time it disallows polling.

Fix that by dropping the comparison to 0 when no property is provided.

While at it, mark voltage-ranges property optional as it was initially.

Fixes: 9c43df57910b ("mmc_spi: Add support for OpenFirmware bindings")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 Documentation/devicetree/bindings/mmc/mmc-spi-slot.txt | 6 +++---
 drivers/mmc/host/of_mmc_spi.c                          | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/mmc-spi-slot.txt b/Documentation/devicetree/bindings/mmc/mmc-spi-slot.txt
index 75486cca8054..5e74db69f581 100644
--- a/Documentation/devicetree/bindings/mmc/mmc-spi-slot.txt
+++ b/Documentation/devicetree/bindings/mmc/mmc-spi-slot.txt
@@ -5,11 +5,11 @@ by mmc.txt and the properties used by the mmc_spi driver.
 
 Required properties:
 - spi-max-frequency : maximum frequency for this device (Hz).
-- voltage-ranges : two cells are required, first cell specifies minimum
-  slot voltage (mV), second cell specifies maximum slot voltage (mV).
-  Several ranges could be specified.
 
 Optional properties:
+- voltage-ranges : two cells are required, first cell specifies minimum
+  slot voltage (mV), second cell specifies maximum slot voltage (mV).
+  Several ranges could be specified. If not provided, 3.2v..3.4v is assumed.
 - gpios : may specify GPIOs in this order: Card-Detect GPIO,
   Write-Protect GPIO. Note that this does not follow the
   binding from mmc.txt, for historical reasons.
diff --git a/drivers/mmc/host/of_mmc_spi.c b/drivers/mmc/host/of_mmc_spi.c
index acd96ea399b8..843ec3db891b 100644
--- a/drivers/mmc/host/of_mmc_spi.c
+++ b/drivers/mmc/host/of_mmc_spi.c
@@ -66,7 +66,7 @@ struct mmc_spi_platform_data *mmc_spi_get_pdata(struct spi_device *spi)
 	if (!oms)
 		return NULL;
 
-	if (mmc_of_parse_voltage(mmc, &oms->pdata.ocr_mask) <= 0)
+	if (mmc_of_parse_voltage(mmc, &oms->pdata.ocr_mask) < 0)
 		goto err_ocr;
 
 	oms->detect_irq = irq_of_parse_and_map(np, 0);
-- 
2.30.2

