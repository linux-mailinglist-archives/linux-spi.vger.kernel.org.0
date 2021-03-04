Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4B032CB02
	for <lists+linux-spi@lfdr.de>; Thu,  4 Mar 2021 04:45:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232940AbhCDDoI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 3 Mar 2021 22:44:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232950AbhCDDn7 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 3 Mar 2021 22:43:59 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49F7EC0613E7
        for <linux-spi@vger.kernel.org>; Wed,  3 Mar 2021 19:42:31 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id j12so17908789pfj.12
        for <linux-spi@vger.kernel.org>; Wed, 03 Mar 2021 19:42:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IGq13mVQnCL2F/Pzggff+qUxySDalGH8/got0UlrADY=;
        b=NFLF5gCiP73poABBCD/VLKTSuauriQYI1AX3hPVBG6qKHrlUluOU29ffVwXmS2B9H6
         WNaOioYIHow9eviRkVF2TW8c5nJgjptOZzEPgk650nGWSaLQhl1crN9nuTQYyBapQXMX
         FXN/7Sb80NYyheL7SuR12H6uprAjbmfDvQBIiRRyJPS09kLaQHWByt49D3Swv1AQZACr
         G7FWngXrQCMXvNuUxdFFJ3jUuwxp7vrOy6wTYqYbbydthA+faA0jP0IcnUNZeLs1I0D6
         cP9w6VfCBNtrLtm0oSH9bf3RUD6UPn9MA9BvK1WW/RfaC9Ow5nzhAwata7J7RgBz0e25
         jCwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IGq13mVQnCL2F/Pzggff+qUxySDalGH8/got0UlrADY=;
        b=PkZN994RHzSK5rPhGp+TZHRnOVkoYDBhBTR5lTq13Mb41HQqRqeegQNnw/U8WehnPM
         IacjpRljdtKfkvfGNmr2WbCRW+55jpukV0nJs0SJy5/Es9YCFGOoE4STxAhGL6PThhRN
         DzGwctIkTTAQSNg/0I0BdIEuh0D1pkHjSjkxB5mGy4voIBr4lBEBbsIO0tFAbuUkbchY
         9FwXOHsFDALn3vCPTu7JkcuNrpCwHLVeiAMWfVF2WknI5hYN+wFOBVBrsksmW6TiLYg7
         S/+MjhiKLke1Q9JaQrwZo+fBQMl1kEYJrEx7K+fmD+05KKKtRvW7bvvZOwkdaH6JoeHp
         EClQ==
X-Gm-Message-State: AOAM531S+B+um/tY7s3tSGsV+XzH+qe5wmGmYDvfOn4hi40RmQqQcmGc
        5esJsgPcHvydPoWx9f2eHRzpuQ==
X-Google-Smtp-Source: ABdhPJzzYbOaLC1HxWs4HSY+c8DGuLVJJnYy5MZRg/+FghJEGKqIJ5pIQ4ajr3SOJ2fCOxmhHigj5Q==
X-Received: by 2002:aa7:90c5:0:b029:1e3:5e84:4a7c with SMTP id k5-20020aa790c50000b02901e35e844a7cmr1841053pfk.71.1614829350720;
        Wed, 03 Mar 2021 19:42:30 -0800 (PST)
Received: from platform-dev1.pensando.io ([12.226.153.42])
        by smtp.gmail.com with ESMTPSA id h17sm2403989pfc.211.2021.03.03.19.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 19:42:30 -0800 (PST)
From:   Brad Larson <brad@pensando.io>
To:     linux-arm-kernel@lists.infradead.org
Cc:     arnd@arndb.de, linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        broonie@kernel.org, fancer.lancer@gmail.com,
        adrian.hunter@intel.com, ulf.hansson@linaro.org, olof@lixom.net,
        brad@pensando.io, linux-gpio@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/8] mmc: sdhci-cadence: Add Pensando Elba SoC support
Date:   Wed,  3 Mar 2021 19:41:38 -0800
Message-Id: <20210304034141.7062-6-brad@pensando.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210304034141.7062-1-brad@pensando.io>
References: <20210304034141.7062-1-brad@pensando.io>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add support for Pensando Elba SoC which explicitly controls
byte-lane enables on writes.  Refactor to allow platform
specific write ops.

Signed-off-by: Brad Larson <brad@pensando.io>
---
 drivers/mmc/host/Kconfig              |  15 +++
 drivers/mmc/host/Makefile             |   1 +
 drivers/mmc/host/sdhci-cadence-elba.c | 137 ++++++++++++++++++++++++++
 drivers/mmc/host/sdhci-cadence.c      |  78 +++++++--------
 drivers/mmc/host/sdhci-cadence.h      |  68 +++++++++++++
 5 files changed, 257 insertions(+), 42 deletions(-)
 create mode 100644 drivers/mmc/host/sdhci-cadence-elba.c
 create mode 100644 drivers/mmc/host/sdhci-cadence.h

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index b236dfe2e879..65ea323c06f2 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -250,6 +250,21 @@ config MMC_SDHCI_CADENCE
 
 	  If unsure, say N.
 
+config MMC_SDHCI_CADENCE_ELBA
+	tristate "SDHCI support for the Pensando/Cadence SD/SDIO/eMMC controller"
+	depends on ARCH_PENSANDO_ELBA_SOC
+	depends on MMC_SDHCI
+	depends on OF
+	depends on MMC_SDHCI_CADENCE
+	depends on MMC_SDHCI_PLTFM
+	select MMC_SDHCI_IO_ACCESSORS
+	help
+	  This selects the Pensando/Cadence SD/SDIO/eMMC controller.
+
+	  If you have a controller with this interface, say Y or M here.
+
+	  If unsure, say N.
+
 config MMC_SDHCI_CNS3XXX
 	tristate "SDHCI support on the Cavium Networks CNS3xxx SoC"
 	depends on ARCH_CNS3XXX || COMPILE_TEST
diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index 6df5c4774260..f2a6d50e64de 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -80,6 +80,7 @@ obj-$(CONFIG_MMC_REALTEK_USB)	+= rtsx_usb_sdmmc.o
 
 obj-$(CONFIG_MMC_SDHCI_PLTFM)		+= sdhci-pltfm.o
 obj-$(CONFIG_MMC_SDHCI_CADENCE)		+= sdhci-cadence.o
+obj-$(CONFIG_MMC_SDHCI_CADENCE_ELBA)	+= sdhci-cadence-elba.o
 obj-$(CONFIG_MMC_SDHCI_CNS3XXX)		+= sdhci-cns3xxx.o
 obj-$(CONFIG_MMC_SDHCI_ESDHC_MCF)       += sdhci-esdhc-mcf.o
 obj-$(CONFIG_MMC_SDHCI_ESDHC_IMX)	+= sdhci-esdhc-imx.o
diff --git a/drivers/mmc/host/sdhci-cadence-elba.c b/drivers/mmc/host/sdhci-cadence-elba.c
new file mode 100644
index 000000000000..e128e83e9be9
--- /dev/null
+++ b/drivers/mmc/host/sdhci-cadence-elba.c
@@ -0,0 +1,137 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2020-2021 Pensando Systems, Inc.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/iopoll.h>
+#include <linux/module.h>
+#include <linux/mmc/host.h>
+#include <linux/mmc/mmc.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+
+#include "sdhci-pltfm.h"
+#include "sdhci-cadence.h"
+
+// delay regs address
+#define SDIO_REG_HRS4		0x10
+#define REG_DELAY_HS		0x00
+#define REG_DELAY_DEFAULT	0x01
+#define REG_DELAY_UHSI_SDR50	0x04
+#define REG_DELAY_UHSI_DDR50	0x05
+
+static void elba_write_l(struct sdhci_host *host, u32 val, int reg)
+{
+	struct sdhci_cdns_priv *priv = sdhci_cdns_priv(host);
+	unsigned long flags;
+
+	spin_lock_irqsave(&priv->wrlock, flags);
+	writel(0x78, priv->ctl_addr);
+	writel(val, host->ioaddr + reg);
+	spin_unlock_irqrestore(&priv->wrlock, flags);
+}
+
+static void elba_write_w(struct sdhci_host *host, u16 val, int reg)
+{
+	struct sdhci_cdns_priv *priv = sdhci_cdns_priv(host);
+	unsigned long flags;
+	u32 m = (reg & 0x3);
+	u32 msk = (0x3 << (m));
+
+	spin_lock_irqsave(&priv->wrlock, flags);
+	writel(msk << 3, priv->ctl_addr);
+	writew(val, host->ioaddr + reg);
+	spin_unlock_irqrestore(&priv->wrlock, flags);
+}
+
+static void elba_write_b(struct sdhci_host *host, u8 val, int reg)
+{
+	struct sdhci_cdns_priv *priv = sdhci_cdns_priv(host);
+	unsigned long flags;
+	u32 m = (reg & 0x3);
+	u32 msk = (0x1 << (m));
+
+	spin_lock_irqsave(&priv->wrlock, flags);
+	writel(msk << 3, priv->ctl_addr);
+	writeb(val, host->ioaddr + reg);
+	spin_unlock_irqrestore(&priv->wrlock, flags);
+}
+
+static void elba_priv_write_l(struct sdhci_cdns_priv *priv,
+		u32 val, void __iomem *reg)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&priv->wrlock, flags);
+	writel(0x78, priv->ctl_addr);
+	writel(val, reg);
+	spin_unlock_irqrestore(&priv->wrlock, flags);
+}
+
+static const struct sdhci_ops sdhci_elba_ops = {
+	.write_l = elba_write_l,
+	.write_w = elba_write_w,
+	.write_b = elba_write_b,
+	.set_clock = sdhci_set_clock,
+	.get_timeout_clock = sdhci_cdns_get_timeout_clock,
+	.set_bus_width = sdhci_set_bus_width,
+	.reset = sdhci_reset,
+	.set_uhs_signaling = sdhci_cdns_set_uhs_signaling,
+};
+
+static void sd4_set_dlyvr(struct sdhci_host *host,
+			  unsigned char addr, unsigned char data)
+{
+	unsigned long dlyrv_reg;
+
+	dlyrv_reg = ((unsigned long)data << 8);
+	dlyrv_reg |= addr;
+
+	// set data and address
+	writel(dlyrv_reg, host->ioaddr + SDIO_REG_HRS4);
+	dlyrv_reg |= (1uL << 24uL);
+	// send write request
+	writel(dlyrv_reg, host->ioaddr + SDIO_REG_HRS4);
+	dlyrv_reg &= ~(1uL << 24);
+	// clear write request
+	writel(dlyrv_reg, host->ioaddr + SDIO_REG_HRS4);
+}
+
+static void phy_config(struct sdhci_host *host)
+{
+	sd4_set_dlyvr(host, REG_DELAY_DEFAULT, 0x04);
+	sd4_set_dlyvr(host, REG_DELAY_HS, 0x04);
+	sd4_set_dlyvr(host, REG_DELAY_UHSI_SDR50, 0x06);
+	sd4_set_dlyvr(host, REG_DELAY_UHSI_DDR50, 0x16);
+}
+
+static int elba_drv_init(struct platform_device *pdev)
+{
+	struct sdhci_host *host = platform_get_drvdata(pdev);
+	struct sdhci_cdns_priv *priv = sdhci_cdns_priv(host);
+	struct resource *iomem;
+	void __iomem *ioaddr;
+
+	host->mmc->caps |= (MMC_CAP_1_8V_DDR | MMC_CAP_8_BIT_DATA);
+	iomem = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	if (!iomem)
+		return -ENOMEM;
+	ioaddr = devm_ioremap_resource(&pdev->dev, iomem);
+	if (IS_ERR(ioaddr))
+		return PTR_ERR(ioaddr);
+	priv->ctl_addr = ioaddr;
+	priv->priv_write_l = elba_priv_write_l;
+	spin_lock_init(&priv->wrlock);
+	writel(0x78, priv->ctl_addr);
+	phy_config(host);
+	return 0;
+}
+
+const struct sdhci_cdns_drv_data sdhci_elba_drv_data = {
+	.init = elba_drv_init,
+	.pltfm_data = {
+		.ops = &sdhci_elba_ops,
+	},
+};
diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
index 6f2de54a5987..3c6bc93d3314 100644
--- a/drivers/mmc/host/sdhci-cadence.c
+++ b/drivers/mmc/host/sdhci-cadence.c
@@ -14,6 +14,7 @@
 #include <linux/of_device.h>
 
 #include "sdhci-pltfm.h"
+#include "sdhci-cadence.h"
 
 /* HRS - Host Register Set (specific to Cadence) */
 #define SDHCI_CDNS_HRS04		0x10		/* PHY access port */
@@ -59,23 +60,6 @@
  */
 #define SDHCI_CDNS_MAX_TUNING_LOOP	40
 
-struct sdhci_cdns_phy_param {
-	u8 addr;
-	u8 data;
-};
-
-struct sdhci_cdns_priv {
-	void __iomem *hrs_addr;
-	bool enhanced_strobe;
-	unsigned int nr_phy_params;
-	struct sdhci_cdns_phy_param phy_params[];
-};
-
-struct sdhci_cdns_phy_cfg {
-	const char *property;
-	u8 addr;
-};
-
 static const struct sdhci_cdns_phy_cfg sdhci_cdns_phy_cfgs[] = {
 	{ "cdns,phy-input-delay-sd-highspeed", SDHCI_CDNS_PHY_DLY_SD_HS, },
 	{ "cdns,phy-input-delay-legacy", SDHCI_CDNS_PHY_DLY_SD_DEFAULT, },
@@ -104,17 +88,17 @@ static int sdhci_cdns_write_phy_reg(struct sdhci_cdns_priv *priv,
 
 	tmp = FIELD_PREP(SDHCI_CDNS_HRS04_WDATA, data) |
 	      FIELD_PREP(SDHCI_CDNS_HRS04_ADDR, addr);
-	writel(tmp, reg);
+	sdhci_cdns_priv_writel(priv, tmp, reg);
 
 	tmp |= SDHCI_CDNS_HRS04_WR;
-	writel(tmp, reg);
+	sdhci_cdns_priv_writel(priv, tmp, reg);
 
 	ret = readl_poll_timeout(reg, tmp, tmp & SDHCI_CDNS_HRS04_ACK, 0, 10);
 	if (ret)
 		return ret;
 
 	tmp &= ~SDHCI_CDNS_HRS04_WR;
-	writel(tmp, reg);
+	sdhci_cdns_priv_writel(priv, tmp, reg);
 
 	ret = readl_poll_timeout(reg, tmp, !(tmp & SDHCI_CDNS_HRS04_ACK),
 				 0, 10);
@@ -167,14 +151,7 @@ static int sdhci_cdns_phy_init(struct sdhci_cdns_priv *priv)
 	return 0;
 }
 
-static void *sdhci_cdns_priv(struct sdhci_host *host)
-{
-	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-
-	return sdhci_pltfm_priv(pltfm_host);
-}
-
-static unsigned int sdhci_cdns_get_timeout_clock(struct sdhci_host *host)
+unsigned int sdhci_cdns_get_timeout_clock(struct sdhci_host *host)
 {
 	/*
 	 * Cadence's spec says the Timeout Clock Frequency is the same as the
@@ -191,7 +168,7 @@ static void sdhci_cdns_set_emmc_mode(struct sdhci_cdns_priv *priv, u32 mode)
 	tmp = readl(priv->hrs_addr + SDHCI_CDNS_HRS06);
 	tmp &= ~SDHCI_CDNS_HRS06_MODE;
 	tmp |= FIELD_PREP(SDHCI_CDNS_HRS06_MODE, mode);
-	writel(tmp, priv->hrs_addr + SDHCI_CDNS_HRS06);
+	sdhci_cdns_priv_writel(priv, tmp, priv->hrs_addr + SDHCI_CDNS_HRS06);
 }
 
 static u32 sdhci_cdns_get_emmc_mode(struct sdhci_cdns_priv *priv)
@@ -223,7 +200,7 @@ static int sdhci_cdns_set_tune_val(struct sdhci_host *host, unsigned int val)
 	 */
 	for (i = 0; i < 2; i++) {
 		tmp |= SDHCI_CDNS_HRS06_TUNE_UP;
-		writel(tmp, reg);
+		sdhci_cdns_priv_writel(priv, tmp, reg);
 
 		ret = readl_poll_timeout(reg, tmp,
 					 !(tmp & SDHCI_CDNS_HRS06_TUNE_UP),
@@ -275,7 +252,7 @@ static int sdhci_cdns_execute_tuning(struct sdhci_host *host, u32 opcode)
 	return sdhci_cdns_set_tune_val(host, end_of_streak - max_streak / 2);
 }
 
-static void sdhci_cdns_set_uhs_signaling(struct sdhci_host *host,
+void sdhci_cdns_set_uhs_signaling(struct sdhci_host *host,
 					 unsigned int timing)
 {
 	struct sdhci_cdns_priv *priv = sdhci_cdns_priv(host);
@@ -318,13 +295,17 @@ static const struct sdhci_ops sdhci_cdns_ops = {
 	.set_uhs_signaling = sdhci_cdns_set_uhs_signaling,
 };
 
-static const struct sdhci_pltfm_data sdhci_cdns_uniphier_pltfm_data = {
-	.ops = &sdhci_cdns_ops,
-	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
+static const struct sdhci_cdns_drv_data sdhci_cdns_uniphier_drv_data = {
+	.pltfm_data = {
+		.ops = &sdhci_cdns_ops,
+		.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
+	},
 };
 
-static const struct sdhci_pltfm_data sdhci_cdns_pltfm_data = {
-	.ops = &sdhci_cdns_ops,
+static const struct sdhci_cdns_drv_data sdhci_cdns_drv_data = {
+	.pltfm_data = {
+		.ops = &sdhci_cdns_ops,
+	},
 };
 
 static void sdhci_cdns_hs400_enhanced_strobe(struct mmc_host *mmc,
@@ -350,7 +331,7 @@ static void sdhci_cdns_hs400_enhanced_strobe(struct mmc_host *mmc,
 static int sdhci_cdns_probe(struct platform_device *pdev)
 {
 	struct sdhci_host *host;
-	const struct sdhci_pltfm_data *data;
+	const struct sdhci_cdns_drv_data *data;
 	struct sdhci_pltfm_host *pltfm_host;
 	struct sdhci_cdns_priv *priv;
 	struct clk *clk;
@@ -369,10 +350,10 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
 
 	data = of_device_get_match_data(dev);
 	if (!data)
-		data = &sdhci_cdns_pltfm_data;
+		data = &sdhci_cdns_drv_data;
 
 	nr_phy_params = sdhci_cdns_phy_param_count(dev->of_node);
-	host = sdhci_pltfm_init(pdev, data,
+	host = sdhci_pltfm_init(pdev, &data->pltfm_data,
 				struct_size(priv, phy_params, nr_phy_params));
 	if (IS_ERR(host)) {
 		ret = PTR_ERR(host);
@@ -389,11 +370,18 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
 	host->ioaddr += SDHCI_CDNS_SRS_BASE;
 	host->mmc_host_ops.hs400_enhanced_strobe =
 				sdhci_cdns_hs400_enhanced_strobe;
-	sdhci_enable_v4_mode(host);
-	__sdhci_read_caps(host, &version, NULL, NULL);
 
 	sdhci_get_of_property(pdev);
 
+	if (data->init) {
+		ret = data->init(pdev);
+		if (ret)
+			goto free;
+	}
+
+	sdhci_enable_v4_mode(host);
+	__sdhci_read_caps(host, &version, NULL, NULL);
+
 	ret = mmc_of_parse(host->mmc);
 	if (ret)
 		goto free;
@@ -453,8 +441,14 @@ static const struct dev_pm_ops sdhci_cdns_pm_ops = {
 static const struct of_device_id sdhci_cdns_match[] = {
 	{
 		.compatible = "socionext,uniphier-sd4hc",
-		.data = &sdhci_cdns_uniphier_pltfm_data,
+		.data = &sdhci_cdns_uniphier_drv_data,
 	},
+#ifdef CONFIG_MMC_SDHCI_CADENCE_ELBA
+	{
+		.compatible = "pensando,elba-emmc",
+		.data = &sdhci_elba_drv_data
+	},
+#endif
 	{ .compatible = "cdns,sd4hc" },
 	{ /* sentinel */ }
 };
diff --git a/drivers/mmc/host/sdhci-cadence.h b/drivers/mmc/host/sdhci-cadence.h
new file mode 100644
index 000000000000..bf48e8d13430
--- /dev/null
+++ b/drivers/mmc/host/sdhci-cadence.h
@@ -0,0 +1,68 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2016 Socionext Inc.
+ *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
+ */
+
+#ifndef _SDHCI_CADENCE_H_
+#define _SDHCI_CADENCE_H_
+
+struct sdhci_cdns_phy_param {
+	u8 addr;
+	u8 data;
+};
+
+struct sdhci_cdns_priv {
+	void __iomem *hrs_addr;
+#ifdef CONFIG_MMC_SDHCI_CADENCE_ELBA
+	void __iomem *ctl_addr;	/* write control */
+	spinlock_t wrlock;	/* write lock */
+#endif
+	bool enhanced_strobe;
+	void (*priv_write_l)(struct sdhci_cdns_priv *priv, u32 val,
+			     void __iomem *reg); /* for cadence-elba.c */
+	unsigned int nr_phy_params;
+	struct sdhci_cdns_phy_param phy_params[];
+};
+
+struct sdhci_cdns_phy_cfg {
+	const char *property;
+	u8 addr;
+};
+
+struct sdhci_cdns_drv_data {
+	int (*init)(struct platform_device *pdev);
+	const struct sdhci_pltfm_data pltfm_data;
+};
+
+static inline void *sdhci_cdns_priv(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+
+	return sdhci_pltfm_priv(pltfm_host);
+}
+
+/*
+ * The Pensando Elba SoC explicitly controls byte-lane enables on writes,
+ * which includes writes to the HRS registers.
+ * sdhci_cdns_priv_writel() is used in the common sdhci-cadence.c code
+ * to write HRS registers, and this function dispatches to the specific
+ * code.
+ */
+static inline void sdhci_cdns_priv_writel(struct sdhci_cdns_priv *priv,
+		u32 val, void __iomem *reg)
+{
+	if (unlikely(priv->priv_write_l))
+		priv->priv_write_l(priv, val, reg);
+	else
+		writel(val, reg);
+}
+
+#ifdef CONFIG_MMC_SDHCI_CADENCE_ELBA
+extern const struct sdhci_cdns_drv_data sdhci_elba_drv_data;
+#endif
+
+unsigned int sdhci_cdns_get_timeout_clock(struct sdhci_host *host);
+void sdhci_cdns_set_uhs_signaling(struct sdhci_host *host, unsigned int timing);
+
+#endif
-- 
2.17.1

