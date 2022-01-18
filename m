Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41FE449245C
	for <lists+linux-spi@lfdr.de>; Tue, 18 Jan 2022 12:11:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238812AbiARLLk (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 18 Jan 2022 06:11:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238730AbiARLLj (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 18 Jan 2022 06:11:39 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 191A0C06161C
        for <linux-spi@vger.kernel.org>; Tue, 18 Jan 2022 03:11:39 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id m3so55080693lfu.0
        for <linux-spi@vger.kernel.org>; Tue, 18 Jan 2022 03:11:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e7OWZMjHJ8cfIWekryz7JWM8gPOqJ2AqQvf5fPoO5X0=;
        b=VmbjQoXyHauKIJYYMpGQ8YeFHFxLoZ2+dIDreTH2r+z9C69+8QGR4N7V+M6A4RFS/c
         8xZlstwKvh6EmQUQC4Rmipa+ASry2UWUOwx1yPB+/7MKfvL9MYGKkr+9uN7x1+hwuNo8
         9JerPK7hC/CFkKGtP49rl1O6+rfiM4UH6Hoh8Pt9N5aRvZDLXofSCmjEDOcqm6w1c6lE
         6xqIvorGXgtLGg3tEQD9+avN9EQmdSTQEN53bv7G0s/1NsIPreNTqAmN9aiikzUPdB3F
         V/35KSIW0rbJjGUtgWEFL2PcFO5qnId/YQria9Ydhfw7j+ETG9Kvw5NleK+PVEQ+cKRl
         f0TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e7OWZMjHJ8cfIWekryz7JWM8gPOqJ2AqQvf5fPoO5X0=;
        b=xfeHfwaoEMc4UYpSuf7cBvATHpr+J7Ca4JxIK70+mvlSA5EcT9ceYzW4kw5ofqDqQb
         Tb1r09wxrkoHu5t+Gmnv6kBym3MpuL/npxinogjwlm1TZYlf72TH/2sxdwmVLJObZXtN
         1V8vt0WXDWOiYO5/aLMElunq/Swi8AL5wL1Ns1luX+qY7O+bWGgeRrJZoMj6Iv8y9k+6
         CY6zV4+8aJAI1l7XGLGm9+TKHgnuEYS+7IEW+FEfCGtItrjLTdRpDXwnk0nyNTDTLctT
         zooCQhfvzJ7xo5GKmW1rUf1pRTbXFLZA2suQ8ANwk33fpneX1FK6Ler9A0sOTfVcEwSM
         aAoQ==
X-Gm-Message-State: AOAM532yl48RFRrZh/00lP0IrCIDQti9P0ZpQQV4/L0kwKly7QhOIFUM
        x2boxllqIw4zKcb1+kmfbFBHew==
X-Google-Smtp-Source: ABdhPJz8gVrc5Eg5gCtFTJ0iE0vK9vvMuzMY6I/eZ45B25bJ3/CB0CrhJ5RhI4tqaiNcd6BiQMc/zQ==
X-Received: by 2002:a05:6512:461:: with SMTP id x1mr22039490lfd.622.1642504297468;
        Tue, 18 Jan 2022 03:11:37 -0800 (PST)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id o10sm918303lft.240.2022.01.18.03.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 03:11:36 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-samsung-soc@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>
Subject: [PATCH 2/3 v2] spi: s3c64xx: Drop custom gpio setup argument
Date:   Tue, 18 Jan 2022 12:09:27 +0100
Message-Id: <20220118110928.120640-2-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220118110928.120640-1-linus.walleij@linaro.org>
References: <20220118110928.120640-1-linus.walleij@linaro.org>
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
ChangeLog v1-v2:
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

