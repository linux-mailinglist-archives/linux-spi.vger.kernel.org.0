Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9BF492459
	for <lists+linux-spi@lfdr.de>; Tue, 18 Jan 2022 12:11:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238584AbiARLLe (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 18 Jan 2022 06:11:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238193AbiARLLe (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 18 Jan 2022 06:11:34 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75110C061574
        for <linux-spi@vger.kernel.org>; Tue, 18 Jan 2022 03:11:33 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id b14so50636868lff.3
        for <linux-spi@vger.kernel.org>; Tue, 18 Jan 2022 03:11:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RRz79mZLVjUUUzJxPLhP/RgT0yDELTK4sB0V9eSLjjI=;
        b=pRLWDaRrLpQEsPINRKVzipVp6k8+bo8/2C0mDraUXPLUJ5viPvZsrU+/F1+FP4whAS
         neN4fb/ta9Cp4+Fs8gVGpvtKLA+wdNl2jWJSB3HWjRjQZp8vdDhRorZGDk5spQ3nhEmI
         ot8Y7LZj012Mgn/nE3yHZsvofLClITwUq+S4YFcT3FWfp8J/gYii4SYbs+oSvOud0oFv
         FIztKMGFMwWezzy4pI5D8j9wJ4Os1ZuR3CkwCIZZdDzMCFrbANozd7mwkQyVU/Vxgm2P
         j6XGIA9uN+bbI54Hhm2Fpes7TAKPwfA7i+gbeMzNjCd/pgpkuk82UrznUgXUVwGvdEiz
         LFnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RRz79mZLVjUUUzJxPLhP/RgT0yDELTK4sB0V9eSLjjI=;
        b=jnFrzM1SMYaFOGWr+sjpsZ1MvH+28zYODA4UACNnfZmJdEs2YtrFkLdwHPU0ohcWm7
         P/FkQZd0o5QEEGZTReViEEKZTX/Tq+tzmYpqrfgH3FLKuII132QetbhrXNYGuS/1IIpP
         NARaIt8BuePScf5lX6HWy3XJUKxizeg2aG2KZpA55O0V82CKjwR9HDIncde8ab6bEXhb
         yJRt95cAHUiLm3D4RiVaFx7E56fGbu4uaW9SJWXqe7e7uB+M/0bgWMtCgy5B5856cpwa
         OlSZj1uSeaEAK/h+THWCAKhYzV87lmw6b5D5a145x+fbh5ia8g9bhVwEsXb6fZIR3Mxk
         ymnw==
X-Gm-Message-State: AOAM530zor429JREalBcS6jNUPypS1ed+Ur2XlM4WIQCzM5KmG5iM9X/
        XQ4GKO6gh9XAzJfiMua1yWE7Mg==
X-Google-Smtp-Source: ABdhPJyG0CUbwKdxMjpS/YqJt5rcCO1uGUR7+6Fp1FHjfRTUAwqma9+sep6MWoyd0eJWF8wHzWmNJQ==
X-Received: by 2002:a05:6512:1088:: with SMTP id j8mr20340673lfg.220.1642504291767;
        Tue, 18 Jan 2022 03:11:31 -0800 (PST)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id o10sm918303lft.240.2022.01.18.03.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 03:11:30 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-samsung-soc@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>
Subject: [PATCH 1/3 v2] spi: s3c64xx: Delete unused boardfile helpers
Date:   Tue, 18 Jan 2022 12:09:26 +0100
Message-Id: <20220118110928.120640-1-linus.walleij@linaro.org>
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
ChangeLog v1-v2:
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

