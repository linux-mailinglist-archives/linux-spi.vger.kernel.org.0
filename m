Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4175364075
	for <lists+linux-spi@lfdr.de>; Mon, 19 Apr 2021 13:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238619AbhDSLZo (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 19 Apr 2021 07:25:44 -0400
Received: from mga02.intel.com ([134.134.136.20]:42345 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238543AbhDSLZh (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 19 Apr 2021 07:25:37 -0400
IronPort-SDR: zbbmBSk3Vh8WrJLBdvEle6br+/zAqWcwhaHGiqOXwu0eWTZ29WT6FFWoAzX49AJ1R78SIH8dEb
 N0hw1QwMD22w==
X-IronPort-AV: E=McAfee;i="6200,9189,9958"; a="182440445"
X-IronPort-AV: E=Sophos;i="5.82,234,1613462400"; 
   d="scan'208";a="182440445"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2021 04:25:06 -0700
IronPort-SDR: EmRQL1vW1CXPQXX7Ep5JqVxyjxNTf+NHB5aERjWSoOjAFGTYYnA8wVJBSzlK7ZZZK60cL4u5kf
 1qLryOMjfKdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,234,1613462400"; 
   d="scan'208";a="422657726"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 19 Apr 2021 04:25:02 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 1E7BC2B8; Mon, 19 Apr 2021 14:25:20 +0300 (EEST)
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
Subject: [PATCH v1 6/6] mmc: mmc_spi: Make of_mmc_spi.c resource provider agnostic
Date:   Mon, 19 Apr 2021 14:24:59 +0300
Message-Id: <20210419112459.25241-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210419112459.25241-1-andriy.shevchenko@linux.intel.com>
References: <20210419112459.25241-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

In order to use the same driver on non-OF platforms, make
of_mmc_spi.c resource provider agnostic.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mmc/host/Makefile     | 2 --
 drivers/mmc/host/of_mmc_spi.c | 6 ++----
 include/linux/spi/mmc_spi.h   | 9 ---------
 3 files changed, 2 insertions(+), 15 deletions(-)

diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index 6df5c4774260..14004cc09aaa 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -34,9 +34,7 @@ obj-$(CONFIG_MMC_TIFM_SD)	+= tifm_sd.o
 obj-$(CONFIG_MMC_MVSDIO)	+= mvsdio.o
 obj-$(CONFIG_MMC_DAVINCI)       += davinci_mmc.o
 obj-$(CONFIG_MMC_SPI)		+= mmc_spi.o
-ifeq ($(CONFIG_OF),y)
 obj-$(CONFIG_MMC_SPI)		+= of_mmc_spi.o
-endif
 obj-$(CONFIG_MMC_S3C)   	+= s3cmci.o
 obj-$(CONFIG_MMC_SDRICOH_CS)	+= sdricoh_cs.o
 obj-$(CONFIG_MMC_TMIO)		+= tmio_mmc.o
diff --git a/drivers/mmc/host/of_mmc_spi.c b/drivers/mmc/host/of_mmc_spi.c
index 009c3885f6ba..9d480a05f655 100644
--- a/drivers/mmc/host/of_mmc_spi.c
+++ b/drivers/mmc/host/of_mmc_spi.c
@@ -51,10 +51,9 @@ struct mmc_spi_platform_data *mmc_spi_get_pdata(struct spi_device *spi)
 {
 	struct mmc_host *mmc = dev_get_drvdata(&spi->dev);
 	struct device *dev = &spi->dev;
-	struct device_node *np = dev->of_node;
 	struct of_mmc_spi *oms;
 
-	if (dev->platform_data || !np)
+	if (dev->platform_data || !dev_fwnode(dev))
 		return dev->platform_data;
 
 	oms = kzalloc(sizeof(*oms), GFP_KERNEL);
@@ -83,10 +82,9 @@ EXPORT_SYMBOL(mmc_spi_get_pdata);
 void mmc_spi_put_pdata(struct spi_device *spi)
 {
 	struct device *dev = &spi->dev;
-	struct device_node *np = dev->of_node;
 	struct of_mmc_spi *oms = to_of_mmc_spi(dev);
 
-	if (!dev->platform_data || !np)
+	if (!dev->platform_data || !dev_fwnode(dev))
 		return;
 
 	kfree(oms);
diff --git a/include/linux/spi/mmc_spi.h b/include/linux/spi/mmc_spi.h
index 778ae8eb1f3e..9ad9a06e488d 100644
--- a/include/linux/spi/mmc_spi.h
+++ b/include/linux/spi/mmc_spi.h
@@ -35,16 +35,7 @@ struct mmc_spi_platform_data {
 	void (*setpower)(struct device *, unsigned int maskval);
 };
 
-#ifdef CONFIG_OF
 extern struct mmc_spi_platform_data *mmc_spi_get_pdata(struct spi_device *spi);
 extern void mmc_spi_put_pdata(struct spi_device *spi);
-#else
-static inline struct mmc_spi_platform_data *
-mmc_spi_get_pdata(struct spi_device *spi)
-{
-	return spi->dev.platform_data;
-}
-static inline void mmc_spi_put_pdata(struct spi_device *spi) {}
-#endif /* CONFIG_OF */
 
 #endif /* __LINUX_SPI_MMC_SPI_H */
-- 
2.30.2

