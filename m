Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A83436406B
	for <lists+linux-spi@lfdr.de>; Mon, 19 Apr 2021 13:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238496AbhDSLZe (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 19 Apr 2021 07:25:34 -0400
Received: from mga12.intel.com ([192.55.52.136]:5552 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238473AbhDSLZd (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 19 Apr 2021 07:25:33 -0400
IronPort-SDR: wNTYY+Ob7EWy4YFuWgZSPpDqcO13acW35W2Bz2D3Z/BEWyArCoEXCoCvQqq9isXX8OOHC7Jht9
 B7PfFQAH7WQQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9958"; a="174797845"
X-IronPort-AV: E=Sophos;i="5.82,234,1613462400"; 
   d="scan'208";a="174797845"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2021 04:25:03 -0700
IronPort-SDR: YGDJhRQoWE10EToqctjMg+7N5oc+aMwwLz7ACQ8jsFiLYhNrHKdlyb5Ure/bbdGTFlYz9MP6qh
 JQbqYeVZ8qkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,234,1613462400"; 
   d="scan'208";a="390632587"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 19 Apr 2021 04:24:59 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E3B8E13C; Mon, 19 Apr 2021 14:25:16 +0300 (EEST)
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
Subject: [PATCH v1 2/6] mmc: core: Convert mmc_of_parse_voltage() to use device property API
Date:   Mon, 19 Apr 2021 14:24:55 +0300
Message-Id: <20210419112459.25241-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210419112459.25241-1-andriy.shevchenko@linux.intel.com>
References: <20210419112459.25241-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

mmc_of_parse() for a few years has been using device property API.
Convert mmc_of_parse_voltage() as well.

At the same time switch users to new API.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mmc/core/host.c            | 46 +++++++++++++++++++++---------
 drivers/mmc/host/mmc_spi.c         |  8 +++---
 drivers/mmc/host/of_mmc_spi.c      |  3 +-
 drivers/mmc/host/sdhci-esdhc-imx.c |  2 +-
 drivers/mmc/host/sdhci-of-esdhc.c  |  2 +-
 include/linux/mmc/host.h           |  2 +-
 6 files changed, 41 insertions(+), 22 deletions(-)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index ce030c5aa53c..793c7425d0dd 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -379,44 +379,62 @@ EXPORT_SYMBOL(mmc_of_parse);
 
 /**
  * mmc_of_parse_voltage - return mask of supported voltages
- * @np: The device node need to be parsed.
+ * @host: host whose properties should be parsed.
  * @mask: mask of voltages available for MMC/SD/SDIO
  *
- * Parse the "voltage-ranges" DT property, returning zero if it is not
+ * Parse the "voltage-ranges" property, returning zero if it is not
  * found, negative errno if the voltage-range specification is invalid,
  * or one if the voltage-range is specified and successfully parsed.
  */
-int mmc_of_parse_voltage(struct device_node *np, u32 *mask)
+int mmc_of_parse_voltage(struct mmc_host *host, u32 *mask)
 {
-	const u32 *voltage_ranges;
+	const char *prop = "voltage-ranges";
+	struct device *dev = host->parent;
+	u32 *voltage_ranges;
 	int num_ranges, i;
+	int ret;
 
-	voltage_ranges = of_get_property(np, "voltage-ranges", &num_ranges);
-	if (!voltage_ranges) {
-		pr_debug("%pOF: voltage-ranges unspecified\n", np);
+	if (!device_property_present(dev, prop)) {
+		dev_dbg(dev, "%s unspecified\n", prop);
 		return 0;
 	}
-	num_ranges = num_ranges / sizeof(*voltage_ranges) / 2;
+
+	ret = device_property_count_u32(dev, prop);
+	if (ret < 0)
+		return ret;
+
+	num_ranges = ret / 2;
 	if (!num_ranges) {
-		pr_err("%pOF: voltage-ranges empty\n", np);
+		dev_err(dev, "%s empty\n", prop);
 		return -EINVAL;
 	}
 
+	voltage_ranges = kcalloc(2 * num_ranges, sizeof(*voltage_ranges), GFP_KERNEL);
+	if (!voltage_ranges)
+		return -ENOMEM;
+
+	ret = device_property_read_u32_array(dev, prop, voltage_ranges, 2 * num_ranges);
+	if (ret) {
+		kfree(voltage_ranges);
+		return ret;
+	}
+
 	for (i = 0; i < num_ranges; i++) {
 		const int j = i * 2;
 		u32 ocr_mask;
 
-		ocr_mask = mmc_vddrange_to_ocrmask(
-				be32_to_cpu(voltage_ranges[j]),
-				be32_to_cpu(voltage_ranges[j + 1]));
+		ocr_mask = mmc_vddrange_to_ocrmask(voltage_ranges[j + 0],
+						   voltage_ranges[j + 1]);
 		if (!ocr_mask) {
-			pr_err("%pOF: voltage-range #%d is invalid\n",
-				np, i);
+			dev_err(dev, "range #%d in %s is invalid\n", i, prop);
+			kfree(voltage_ranges);
 			return -EINVAL;
 		}
 		*mask |= ocr_mask;
 	}
 
+	kfree(voltage_ranges);
+
 	return 1;
 }
 EXPORT_SYMBOL(mmc_of_parse_voltage);
diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
index 02f4fd26e76a..9776a03a10f5 100644
--- a/drivers/mmc/host/mmc_spi.c
+++ b/drivers/mmc/host/mmc_spi.c
@@ -1397,6 +1397,8 @@ static int mmc_spi_probe(struct spi_device *spi)
 
 	host->ones = ones;
 
+	dev_set_drvdata(&spi->dev, mmc);
+
 	/* Platform data is used to hook up things like card sensing
 	 * and power switching gpios.
 	 */
@@ -1413,8 +1415,6 @@ static int mmc_spi_probe(struct spi_device *spi)
 			host->powerup_msecs = 250;
 	}
 
-	dev_set_drvdata(&spi->dev, mmc);
-
 	/* preallocate dma buffers */
 	host->data = kmalloc(sizeof(*host->data), GFP_KERNEL);
 	if (!host->data)
@@ -1494,8 +1494,8 @@ static int mmc_spi_probe(struct spi_device *spi)
 fail_dma:
 	kfree(host->data);
 fail_nobuf1:
-	mmc_free_host(mmc);
 	mmc_spi_put_pdata(spi);
+	mmc_free_host(mmc);
 nomem:
 	kfree(ones);
 	return status;
@@ -1518,8 +1518,8 @@ static int mmc_spi_remove(struct spi_device *spi)
 	kfree(host->ones);
 
 	spi->max_speed_hz = mmc->f_max;
-	mmc_free_host(mmc);
 	mmc_spi_put_pdata(spi);
+	mmc_free_host(mmc);
 	return 0;
 }
 
diff --git a/drivers/mmc/host/of_mmc_spi.c b/drivers/mmc/host/of_mmc_spi.c
index 3c4d950a4755..acd96ea399b8 100644
--- a/drivers/mmc/host/of_mmc_spi.c
+++ b/drivers/mmc/host/of_mmc_spi.c
@@ -54,6 +54,7 @@ static void of_mmc_spi_exit(struct device *dev, void *mmc)
 
 struct mmc_spi_platform_data *mmc_spi_get_pdata(struct spi_device *spi)
 {
+	struct mmc_host *mmc = dev_get_drvdata(&spi->dev);
 	struct device *dev = &spi->dev;
 	struct device_node *np = dev->of_node;
 	struct of_mmc_spi *oms;
@@ -65,7 +66,7 @@ struct mmc_spi_platform_data *mmc_spi_get_pdata(struct spi_device *spi)
 	if (!oms)
 		return NULL;
 
-	if (mmc_of_parse_voltage(np, &oms->pdata.ocr_mask) <= 0)
+	if (mmc_of_parse_voltage(mmc, &oms->pdata.ocr_mask) <= 0)
 		goto err_ocr;
 
 	oms->detect_irq = irq_of_parse_and_map(np, 0);
diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index a20459744d21..f39d85e8ea6d 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1486,7 +1486,7 @@ sdhci_esdhc_imx_probe_dt(struct platform_device *pdev,
 	if (of_property_read_u32(np, "fsl,delay-line", &boarddata->delay_line))
 		boarddata->delay_line = 0;
 
-	mmc_of_parse_voltage(np, &host->ocr_mask);
+	mmc_of_parse_voltage(host->mmc, &host->ocr_mask);
 
 	if (esdhc_is_usdhc(imx_data)) {
 		imx_data->pins_100mhz = pinctrl_lookup_state(imx_data->pinctrl,
diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index ab5ab969f711..a593b1fbd69e 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -1489,7 +1489,7 @@ static int sdhci_esdhc_probe(struct platform_device *pdev)
 	if (ret)
 		goto err;
 
-	mmc_of_parse_voltage(np, &host->ocr_mask);
+	mmc_of_parse_voltage(host->mmc, &host->ocr_mask);
 
 	ret = sdhci_add_host(host);
 	if (ret)
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 26a3c7bc29ae..ecd25a3b37f0 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -514,7 +514,7 @@ void mmc_free_host(struct mmc_host *);
 void mmc_of_parse_clk_phase(struct mmc_host *host,
 			    struct mmc_clk_phase_map *map);
 int mmc_of_parse(struct mmc_host *host);
-int mmc_of_parse_voltage(struct device_node *np, u32 *mask);
+int mmc_of_parse_voltage(struct mmc_host *host, u32 *mask);
 
 static inline void *mmc_priv(struct mmc_host *host)
 {
-- 
2.30.2

