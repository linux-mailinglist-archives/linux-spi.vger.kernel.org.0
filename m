Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA9D8364078
	for <lists+linux-spi@lfdr.de>; Mon, 19 Apr 2021 13:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238639AbhDSLZo (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 19 Apr 2021 07:25:44 -0400
Received: from mga05.intel.com ([192.55.52.43]:39485 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238087AbhDSLZh (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 19 Apr 2021 07:25:37 -0400
IronPort-SDR: YEPCT3euedHbJ1OYmVbj7DtQ+k+P3X0cWE/IeYeAlzrnEbiL9iXjkkrmjoyGbtK5kB4AZkZUcy
 BK0zdO8k/nJg==
X-IronPort-AV: E=McAfee;i="6200,9189,9958"; a="280632663"
X-IronPort-AV: E=Sophos;i="5.82,234,1613462400"; 
   d="scan'208";a="280632663"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2021 04:25:06 -0700
IronPort-SDR: Ji0kWO+86DKcA/iebLwOxA9FA1uLhGHlOiR8QcUV7NllFz+EXDF3YSkzS2Hv1PA/7LwwinrkGM
 t91Cl3TpkWig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,234,1613462400"; 
   d="scan'208";a="454267724"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 19 Apr 2021 04:25:02 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 8BE0A1FC; Mon, 19 Apr 2021 14:25:19 +0300 (EEST)
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
Subject: [PATCH v1 5/6] mmc: mmc_spi: Use already parsed IRQ
Date:   Mon, 19 Apr 2021 14:24:58 +0300
Message-Id: <20210419112459.25241-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210419112459.25241-1-andriy.shevchenko@linux.intel.com>
References: <20210419112459.25241-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

SPI core already parses and maps IRQ for us if provided.
Use it instead of double parsing in mmc_spi_get_pdata().

Due to above, change condition, since SPI core can hold
an error pointer as invalid IRQ.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mmc/host/of_mmc_spi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/of_mmc_spi.c b/drivers/mmc/host/of_mmc_spi.c
index 0b038f5c392a..009c3885f6ba 100644
--- a/drivers/mmc/host/of_mmc_spi.c
+++ b/drivers/mmc/host/of_mmc_spi.c
@@ -64,8 +64,8 @@ struct mmc_spi_platform_data *mmc_spi_get_pdata(struct spi_device *spi)
 	if (mmc_of_parse_voltage(mmc, &oms->pdata.ocr_mask) < 0)
 		goto err_ocr;
 
-	oms->detect_irq = irq_of_parse_and_map(np, 0);
-	if (oms->detect_irq != 0) {
+	oms->detect_irq = spi->irq;
+	if (oms->detect_irq > 0) {
 		oms->pdata.init = of_mmc_spi_init;
 		oms->pdata.exit = of_mmc_spi_exit;
 	} else {
-- 
2.30.2

