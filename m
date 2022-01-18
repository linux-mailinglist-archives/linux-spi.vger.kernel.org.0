Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95BFE493133
	for <lists+linux-spi@lfdr.de>; Wed, 19 Jan 2022 00:11:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345305AbiARXLV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 18 Jan 2022 18:11:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238145AbiARXLU (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 18 Jan 2022 18:11:20 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D07C061574
        for <linux-spi@vger.kernel.org>; Tue, 18 Jan 2022 15:11:20 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id m1so1649060lfq.4
        for <linux-spi@vger.kernel.org>; Tue, 18 Jan 2022 15:11:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TmtLxdKacIbQUmzBQ1AZ9zIL3jfv6XOChKoVvBmb1cg=;
        b=ajaXLsNpYDwwtpw7tDFWnU1nKzJkmGNennBTY6+4ksvgN+yKOfjh+hB5O4I6tx8Sfz
         gA4/x1b1v6cquvORBDRQkQZSkpg6sFZX/3xQKxttKX+ZvNqezpMU8GBjWmEdDzR4Qo5J
         BNRuKamGOLGu2flE2PLnBEzg+h+DNk69uyQqGNGyqiIQMbUGgqVrSetrSXdcrWsicU0g
         BdyEi1pl9A3gsXz4Gt/3iZx1JUN7hkr9uMueIy6VOPwQYaK8zX7NhR+kIyaXUbJ0CpvG
         oZfGc5+cSMUsVVsSbcy3SPdwdnciFOAsP+lWQcRALEHsuYrPAzeUjO6pj9iDz9jHEXaK
         kkdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TmtLxdKacIbQUmzBQ1AZ9zIL3jfv6XOChKoVvBmb1cg=;
        b=lIuG2MTnekzSDRwbTEljelaTWkLhue8FfQiWKlbM2+8VTbk7kKbbcBiL4yAmEoTnOh
         rDQ0XpPhkl19fuHsx/osgHtBZkC84u7adZV6K9W0/owII8ZnqZbCeKDnjdi3KY5N2DF+
         KSUS8Ge6FHuJqHo6RCXivgvSisXKpQl1MI20O8K4wp2nS2M2R7/p0pkWR8vke4Yg61cv
         s319LQtNl+OrpQod4/polzILjTSPIjLQHilYzY6NR1wh/4Nt27/97Xa/lY2jkQ6l8dEw
         HjS/K5JWHYk6vqX8fOOl6tHi94PEuSfZMWCViE7En0cKpYBN2uvP/N1D/JGQ36k9XEWS
         uUHg==
X-Gm-Message-State: AOAM530bjrq6ONeqhOmsdE4b+mk0yaIpglWqBD4R4JvJYAfJbYmGR0GA
        JxoF2xq0bWK503otkzEbewqFrGDCTq7h6A==
X-Google-Smtp-Source: ABdhPJyd6ZVWGbaDQ9eV2CzVxTrt3Fj+EzF+md4AspsQKSbUnd/+vMwhfhvnYMEJPCXG/tnfAIZReg==
X-Received: by 2002:a2e:b5cf:: with SMTP id g15mr15393349ljn.194.1642547478670;
        Tue, 18 Jan 2022 15:11:18 -0800 (PST)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id k9sm1374938lfg.121.2022.01.18.15.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 15:11:17 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-samsung-soc@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>
Subject: [PATCH 1/3 v3] spi: s3c64xx: Delete unused boardfile helpers
Date:   Wed, 19 Jan 2022 00:09:13 +0100
Message-Id: <20220118230915.157797-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The helpers to use SPI host 1 and 2 are unused in the kernel
and taking up space and maintenance hours. New systems should
use device tree and not this, so delete the code.

Cc: linux-samsung-soc@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc: Sylwester Nawrocki <snawrocki@kernel.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v2->v3:
- No changes
ChangeLog v1->v2:
- Split out to separate patch
---
 arch/arm/mach-s3c/Kconfig                 | 12 ----
 arch/arm/mach-s3c/devs.c                  | 72 -----------------------
 arch/arm/mach-s3c/setup-spi-s3c64xx.c     |  9 ---
 arch/arm/mach-s3c/spi-core-s3c24xx.h      |  6 --
 include/linux/platform_data/spi-s3c64xx.h |  8 ---
 5 files changed, 107 deletions(-)

diff --git a/arch/arm/mach-s3c/Kconfig b/arch/arm/mach-s3c/Kconfig
index 25606e668cf9..1899fc3f44fd 100644
--- a/arch/arm/mach-s3c/Kconfig
+++ b/arch/arm/mach-s3c/Kconfig
@@ -191,18 +191,6 @@ config S3C64XX_DEV_SPI0
 	  Compile in platform device definitions for S3C64XX's type
 	  SPI controller 0
 
-config S3C64XX_DEV_SPI1
-	bool
-	help
-	  Compile in platform device definitions for S3C64XX's type
-	  SPI controller 1
-
-config S3C64XX_DEV_SPI2
-	bool
-	help
-	  Compile in platform device definitions for S3C64XX's type
-	  SPI controller 2
-
 config SAMSUNG_DEV_TS
 	bool
 	help
diff --git a/arch/arm/mach-s3c/devs.c b/arch/arm/mach-s3c/devs.c
index 06dec64848f9..9f086aee862b 100644
--- a/arch/arm/mach-s3c/devs.c
+++ b/arch/arm/mach-s3c/devs.c
@@ -1125,75 +1125,3 @@ void __init s3c64xx_spi0_set_platdata(int (*cfg_gpio)(void), int src_clk_nr,
 	s3c_set_platdata(&pd, sizeof(pd), &s3c64xx_device_spi0);
 }
 #endif /* CONFIG_S3C64XX_DEV_SPI0 */
-
-#ifdef CONFIG_S3C64XX_DEV_SPI1
-static struct resource s3c64xx_spi1_resource[] = {
-	[0] = DEFINE_RES_MEM(S3C_PA_SPI1, SZ_256),
-	[1] = DEFINE_RES_IRQ(IRQ_SPI1),
-};
-
-struct platform_device s3c64xx_device_spi1 = {
-	.name		= "s3c6410-spi",
-	.id		= 1,
-	.num_resources	= ARRAY_SIZE(s3c64xx_spi1_resource),
-	.resource	= s3c64xx_spi1_resource,
-	.dev = {
-		.dma_mask		= &samsung_device_dma_mask,
-		.coherent_dma_mask	= DMA_BIT_MASK(32),
-	},
-};
-
-void __init s3c64xx_spi1_set_platdata(int (*cfg_gpio)(void), int src_clk_nr,
-						int num_cs)
-{
-	struct s3c64xx_spi_info pd;
-
-	/* Reject invalid configuration */
-	if (!num_cs || src_clk_nr < 0) {
-		pr_err("%s: Invalid SPI configuration\n", __func__);
-		return;
-	}
-
-	pd.num_cs = num_cs;
-	pd.src_clk_nr = src_clk_nr;
-	pd.cfg_gpio = (cfg_gpio) ? cfg_gpio : s3c64xx_spi1_cfg_gpio;
-
-	s3c_set_platdata(&pd, sizeof(pd), &s3c64xx_device_spi1);
-}
-#endif /* CONFIG_S3C64XX_DEV_SPI1 */
-
-#ifdef CONFIG_S3C64XX_DEV_SPI2
-static struct resource s3c64xx_spi2_resource[] = {
-	[0] = DEFINE_RES_MEM(S3C_PA_SPI2, SZ_256),
-	[1] = DEFINE_RES_IRQ(IRQ_SPI2),
-};
-
-struct platform_device s3c64xx_device_spi2 = {
-	.name		= "s3c6410-spi",
-	.id		= 2,
-	.num_resources	= ARRAY_SIZE(s3c64xx_spi2_resource),
-	.resource	= s3c64xx_spi2_resource,
-	.dev = {
-		.dma_mask		= &samsung_device_dma_mask,
-		.coherent_dma_mask	= DMA_BIT_MASK(32),
-	},
-};
-
-void __init s3c64xx_spi2_set_platdata(int (*cfg_gpio)(void), int src_clk_nr,
-						int num_cs)
-{
-	struct s3c64xx_spi_info pd;
-
-	/* Reject invalid configuration */
-	if (!num_cs || src_clk_nr < 0) {
-		pr_err("%s: Invalid SPI configuration\n", __func__);
-		return;
-	}
-
-	pd.num_cs = num_cs;
-	pd.src_clk_nr = src_clk_nr;
-	pd.cfg_gpio = (cfg_gpio) ? cfg_gpio : s3c64xx_spi2_cfg_gpio;
-
-	s3c_set_platdata(&pd, sizeof(pd), &s3c64xx_device_spi2);
-}
-#endif /* CONFIG_S3C64XX_DEV_SPI2 */
diff --git a/arch/arm/mach-s3c/setup-spi-s3c64xx.c b/arch/arm/mach-s3c/setup-spi-s3c64xx.c
index efcf78d41585..497aff71c29c 100644
--- a/arch/arm/mach-s3c/setup-spi-s3c64xx.c
+++ b/arch/arm/mach-s3c/setup-spi-s3c64xx.c
@@ -16,12 +16,3 @@ int s3c64xx_spi0_cfg_gpio(void)
 	return 0;
 }
 #endif
-
-#ifdef CONFIG_S3C64XX_DEV_SPI1
-int s3c64xx_spi1_cfg_gpio(void)
-{
-	s3c_gpio_cfgall_range(S3C64XX_GPC(4), 3,
-				S3C_GPIO_SFN(2), S3C_GPIO_PULL_UP);
-	return 0;
-}
-#endif
diff --git a/arch/arm/mach-s3c/spi-core-s3c24xx.h b/arch/arm/mach-s3c/spi-core-s3c24xx.h
index 057667469cc3..919c5fd0c9af 100644
--- a/arch/arm/mach-s3c/spi-core-s3c24xx.h
+++ b/arch/arm/mach-s3c/spi-core-s3c24xx.h
@@ -16,12 +16,6 @@ static inline void s3c24xx_spi_setname(char *name)
 #ifdef CONFIG_S3C64XX_DEV_SPI0
 	s3c64xx_device_spi0.name = name;
 #endif
-#ifdef CONFIG_S3C64XX_DEV_SPI1
-	s3c64xx_device_spi1.name = name;
-#endif
-#ifdef CONFIG_S3C64XX_DEV_SPI2
-	s3c64xx_device_spi2.name = name;
-#endif
 }
 
 #endif /* __PLAT_S3C_SPI_CORE_S3C24XX_H */
diff --git a/include/linux/platform_data/spi-s3c64xx.h b/include/linux/platform_data/spi-s3c64xx.h
index 773daf7915a3..19d690f34670 100644
--- a/include/linux/platform_data/spi-s3c64xx.h
+++ b/include/linux/platform_data/spi-s3c64xx.h
@@ -52,17 +52,9 @@ struct s3c64xx_spi_info {
  */
 extern void s3c64xx_spi0_set_platdata(int (*cfg_gpio)(void), int src_clk_nr,
 						int num_cs);
-extern void s3c64xx_spi1_set_platdata(int (*cfg_gpio)(void), int src_clk_nr,
-						int num_cs);
-extern void s3c64xx_spi2_set_platdata(int (*cfg_gpio)(void), int src_clk_nr,
-						int num_cs);
 
 /* defined by architecture to configure gpio */
 extern int s3c64xx_spi0_cfg_gpio(void);
-extern int s3c64xx_spi1_cfg_gpio(void);
-extern int s3c64xx_spi2_cfg_gpio(void);
 
 extern struct s3c64xx_spi_info s3c64xx_spi0_pdata;
-extern struct s3c64xx_spi_info s3c64xx_spi1_pdata;
-extern struct s3c64xx_spi_info s3c64xx_spi2_pdata;
 #endif /*__SPI_S3C64XX_H */
-- 
2.34.1

