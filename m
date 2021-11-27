Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 716A2460224
	for <lists+linux-spi@lfdr.de>; Sat, 27 Nov 2021 23:40:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356559AbhK0WoM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 27 Nov 2021 17:44:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356566AbhK0WmM (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 27 Nov 2021 17:42:12 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF39C061395
        for <linux-spi@vger.kernel.org>; Sat, 27 Nov 2021 14:33:07 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id y196so11270006wmc.3
        for <linux-spi@vger.kernel.org>; Sat, 27 Nov 2021 14:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hN+6gbYdyGAjVnMlgQrBqQi/CF2WLkIegNLftvsH2gY=;
        b=DlVHEKe1sf9t1x3J3dV5oUzT5laj66uD+D8FcpDAJGtTw7W6R/G6/4i/1FsAegGaC4
         DW4mVPYOPZZa1fR+gJVNcxrDMoGaTpCFO3BS6HqLDhV685L/RFi8oZ3uCTMIVamCk/rH
         Gbm13j/4qRRRpYZNvl7glovJJVa4VSthBqDZ1Emi172S1esenJHvEmYHb1eH0HfsP46I
         EIUfXDANPd+JKuTHyKrw/fL7UZ2YD9yL22xJNnjsCng73w0MP+ZI7cfIWty5543aPlMg
         jYSBaNQJ2WS81kRXrTK+CKnleaWNOIepZa+TUGt8DNK8znwRi+QHw0uezn0wfC/HRYbd
         ewkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hN+6gbYdyGAjVnMlgQrBqQi/CF2WLkIegNLftvsH2gY=;
        b=7DxjXn0UuIQ21qmgh7Lj9fgMFnnXQSDyUEKPrzfNQ5fXoCQNksn9IUQsQaSt/LMacY
         A+xfJh8kIOs+rrMMexdIsl6ViCULMxFoxdHMlTyeOHQjivsVQedVeHYEpf5xy6WXhOO6
         TLNldoeL7Bkrq488kQ+uq0B40Ft0eehBYgeXakFNN7x4fXcla957VjMbT7+mVTJlqm9H
         Byav6eQ3vnF29fdNYVo9fbn9aUmxbzS2LXPDnOGM/BaOGo76sYppEjbl3tvezkDxkXf7
         FYVSLOq6yn6u0dzEscGZieMLyXpI3tbde8OqyVaZO4f8hiZzcJ4Y/a2YSKxQOG151riN
         A/2Q==
X-Gm-Message-State: AOAM530YbZtANCTCVt/AuFs06lQ9OettVxUhLPGqsQ9Cuj+ozbxODgg7
        7QITISMCoAFWrRFAHbkcf0zrEQ==
X-Google-Smtp-Source: ABdhPJxR6Q7r+leY9cj8FBiR+YQOouaiZQ2fWT9sTrdBPHYHb+gpo78GRNNQbc1FsqSfzm0h3WuhFg==
X-Received: by 2002:a05:600c:4f87:: with SMTP id n7mr25568893wmq.63.1638052386493;
        Sat, 27 Nov 2021 14:33:06 -0800 (PST)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id w4sm10078421wrs.88.2021.11.27.14.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Nov 2021 14:33:05 -0800 (PST)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jaewon Kim <jaewon02.kim@samsung.com>,
        Chanho Park <chanho61.park@samsung.com>,
        David Virag <virag.david003@gmail.com>,
        Youngmin Nam <youngmin.nam@samsung.com>,
        devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-i2c@vger.kernel.org
Subject: [PATCH 7/8] i2c: Make I2C_EXYNOS5=y impossible when EXYNOS_USI_V2=m
Date:   Sun, 28 Nov 2021 00:32:52 +0200
Message-Id: <20211127223253.19098-8-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211127223253.19098-1-semen.protsenko@linaro.org>
References: <20211127223253.19098-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

When HSI2C is encapsulated in USIv2 block (e.g. in Exynos850), USIv2
driver must be loaded first, as it's preparing USI hardware for
particular protocol use. Make it impossible for i2c-exynos5 driver to be
built-in when USIv2 driver is built as a module, to prevent incorrect
booting order for those drivers.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 drivers/i2c/busses/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index df89cb809330..e815a9dffb2c 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -613,6 +613,7 @@ config I2C_EXYNOS5
 	tristate "Exynos high-speed I2C driver"
 	depends on OF
 	depends on ARCH_EXYNOS || COMPILE_TEST
+	depends on EXYNOS_USI_V2 || !EXYNOS_USI_V2
 	default y if ARCH_EXYNOS
 	help
 	  High-speed I2C controller on Samsung Exynos5 and newer Samsung SoCs:
-- 
2.30.2

