Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA039493135
	for <lists+linux-spi@lfdr.de>; Wed, 19 Jan 2022 00:11:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346416AbiARXLn (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 18 Jan 2022 18:11:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238171AbiARXLm (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 18 Jan 2022 18:11:42 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B6B3C061574
        for <linux-spi@vger.kernel.org>; Tue, 18 Jan 2022 15:11:42 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id bu18so1632708lfb.5
        for <linux-spi@vger.kernel.org>; Tue, 18 Jan 2022 15:11:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sWzwoy2NhWxinK1L1Kpa7t0njyZB5LkW29Ap5pIV68k=;
        b=fEzELm3mmGQaFQLkdnSZNhFKUZHeewK24hab6HHSnI+IVEO4G3II7EUHPr+rB1LsmR
         5bO6cV7b080xGfHteimd5ghDvU8QjfmwfnRU+hx7Hgn2rbNyP05m5yrM6oylVGzlmcOs
         OCQdKMiH0iKznsCZ3bqP41MHF21myRR1xuEZrthD+ihVjWz/7HUdV9iFSFw66+F2YSaa
         c71WyKmxP2eMqLAB/QcAPrqtRDMv84Mb86S8TXxuOp9U7+tksW1Foia8BDnTV/xKnR1u
         2UIUlUEgoV+kzb48Szy1kUVu+u/20W8/gRMaQWbjBVZSbbdHHAIyy61RDFkYe1JSrpPf
         bkCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sWzwoy2NhWxinK1L1Kpa7t0njyZB5LkW29Ap5pIV68k=;
        b=AWCgZwdhtLecTxyqK7IJMjNvj1pihQL+hu1ErnvODBfkZxXYjMxtn2etXu5ya1VOCm
         TsnkSMumCW/xguxQ0WQIIV3UzfO49eFbflIq5m1EqLp/PLTpf49fjBfSi17Gn3u9V+2K
         lC2nuknd+kw2UcM9sSkhTMToyVZKxH7qVluYV9vRcvbiGg47he9HXxw03GRTFKM86edL
         J6o77AzZRbv488G4331MTeNOAkP/WPY5oyRXBm/aG0rzdCV0Bre+GSz+onCnM9/vPAOu
         UfgeWwVDguDTpJ/jW1qJ9uBbevveQ6XqQUN1GvKFUqelT4CXdtSvUszt1FHhj3f1YPGv
         Ysdg==
X-Gm-Message-State: AOAM531LTcesFAG6zPq3oUXs2At6cXrQ6oCGz2bHDzhMgVuG0Nj0fA0+
        heacjumLkyHixaPc5QBiWWtrbg==
X-Google-Smtp-Source: ABdhPJwFLyg+Uh6H1ZWyYxf4JU+OndZSYvg+ynm69d0epTKHUZRG8zszKnMw8MThvRHsdGjaonDgtQ==
X-Received: by 2002:ac2:44cd:: with SMTP id d13mr23212744lfm.277.1642547500468;
        Tue, 18 Jan 2022 15:11:40 -0800 (PST)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id k9sm1374938lfg.121.2022.01.18.15.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 15:11:39 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-samsung-soc@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>
Subject: [PATCH 2/3 v3] spi: s3c64xx: Drop custom gpio setup argument
Date:   Wed, 19 Jan 2022 00:09:14 +0100
Message-Id: <20220118230915.157797-2-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220118230915.157797-1-linus.walleij@linaro.org>
References: <20220118230915.157797-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The SPI0 platform population function was taking a custom
gpio setup callback but the only user pass NULL as
argument so drop this argument.

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
 arch/arm/mach-s3c/devs.c                  | 5 ++---
 arch/arm/mach-s3c/mach-crag6410.c         | 2 +-
 include/linux/platform_data/spi-s3c64xx.h | 4 +---
 3 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-s3c/devs.c b/arch/arm/mach-s3c/devs.c
index 9f086aee862b..1e266fc24f9b 100644
--- a/arch/arm/mach-s3c/devs.c
+++ b/arch/arm/mach-s3c/devs.c
@@ -1107,8 +1107,7 @@ struct platform_device s3c64xx_device_spi0 = {
 	},
 };
 
-void __init s3c64xx_spi0_set_platdata(int (*cfg_gpio)(void), int src_clk_nr,
-						int num_cs)
+void __init s3c64xx_spi0_set_platdata(int src_clk_nr, int num_cs)
 {
 	struct s3c64xx_spi_info pd;
 
@@ -1120,7 +1119,7 @@ void __init s3c64xx_spi0_set_platdata(int (*cfg_gpio)(void), int src_clk_nr,
 
 	pd.num_cs = num_cs;
 	pd.src_clk_nr = src_clk_nr;
-	pd.cfg_gpio = (cfg_gpio) ? cfg_gpio : s3c64xx_spi0_cfg_gpio;
+	pd.cfg_gpio = s3c64xx_spi0_cfg_gpio;
 
 	s3c_set_platdata(&pd, sizeof(pd), &s3c64xx_device_spi0);
 }
diff --git a/arch/arm/mach-s3c/mach-crag6410.c b/arch/arm/mach-s3c/mach-crag6410.c
index 4a12c75d407f..41f0aba2d2fd 100644
--- a/arch/arm/mach-s3c/mach-crag6410.c
+++ b/arch/arm/mach-s3c/mach-crag6410.c
@@ -856,7 +856,7 @@ static void __init crag6410_machine_init(void)
 	i2c_register_board_info(1, i2c_devs1, ARRAY_SIZE(i2c_devs1));
 
 	samsung_keypad_set_platdata(&crag6410_keypad_data);
-	s3c64xx_spi0_set_platdata(NULL, 0, 2);
+	s3c64xx_spi0_set_platdata(0, 2);
 
 	pwm_add_table(crag6410_pwm_lookup, ARRAY_SIZE(crag6410_pwm_lookup));
 	platform_add_devices(crag6410_devices, ARRAY_SIZE(crag6410_devices));
diff --git a/include/linux/platform_data/spi-s3c64xx.h b/include/linux/platform_data/spi-s3c64xx.h
index 19d690f34670..10890a4b55b9 100644
--- a/include/linux/platform_data/spi-s3c64xx.h
+++ b/include/linux/platform_data/spi-s3c64xx.h
@@ -43,15 +43,13 @@ struct s3c64xx_spi_info {
 /**
  * s3c64xx_spi_set_platdata - SPI Controller configure callback by the board
  *				initialization code.
- * @cfg_gpio: Pointer to gpio setup function.
  * @src_clk_nr: Clock the SPI controller is to use to generate SPI clocks.
  * @num_cs: Number of elements in the 'cs' array.
  *
  * Call this from machine init code for each SPI Controller that
  * has some chips attached to it.
  */
-extern void s3c64xx_spi0_set_platdata(int (*cfg_gpio)(void), int src_clk_nr,
-						int num_cs);
+extern void s3c64xx_spi0_set_platdata(int src_clk_nr, int num_cs);
 
 /* defined by architecture to configure gpio */
 extern int s3c64xx_spi0_cfg_gpio(void);
-- 
2.34.1

