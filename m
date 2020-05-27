Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E81C1E3A73
	for <lists+linux-spi@lfdr.de>; Wed, 27 May 2020 09:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387552AbgE0H2H (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 27 May 2020 03:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387523AbgE0H2H (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 27 May 2020 03:28:07 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200D1C061A0F;
        Wed, 27 May 2020 00:28:07 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id m1so5131422pgk.1;
        Wed, 27 May 2020 00:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PnARTlRhVkBUQkPqC454r4YU05zMHZz2LfM1l53WRb0=;
        b=j/De+h+QmNQ49bidmH96zLrOu2OBXrIIB6Y9QUEalQjZ1catzyle70SRBwOcwMWe+z
         iZIt54zFlbJqY6v33AGBhOtUxRV6Szu1l68EY9j0+rctjO15uFYPrWRUy3ghFb1xW7/H
         abClqYr3/WLdGWazduydiccGKMYgnyX/8lNoQoRJwJbpCE62LWArAo1EIY7SkaA1x3Hy
         nzV7QCUDYFaESm+gzjKIQGUvU0Na2CtsCyVwB+tlMQSf8mPIG7N0fY14a/SFd+dOWhAt
         0otXEMgwfJZ4aADjlvQwy4zZJ3PleE0M9x94oSgoEBNHkCtYi9ZFIcjq5FV59Ysyeooz
         E3Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PnARTlRhVkBUQkPqC454r4YU05zMHZz2LfM1l53WRb0=;
        b=k5c8ws95qjJysD3F5bf1OcPdXHekvibDm/OYNtt6a9hBsR+jUkGAptaw/DP5aPJEZU
         90b2ru64mn84nYqiGmvpS1byQELt5j5E5w55e6Su583LVrl6aTOb59spt/ruERrU9R8a
         d9SgpHorjLXioqMqEX2Dm4Y38wLVk9Re+BftdZ1fQJTjMJGGnuIfK+iaODy8FAwYQBzr
         c9wFfjUivOHE9urRh42Y/KtN39+fYo1+u2t9u0BUdnPWzosnWTgcW9YnKYkF/tp4VHp7
         vzNqs2XGvIor5WMdoRhV1UPvJulQCi5bTyKofbnUe/eKn3nQAoR009KpOdvQp8g3UFMB
         UUWQ==
X-Gm-Message-State: AOAM533phdLHm50hXa9Z3ro89/M4/ImmZPe6nc0+ec0bJT+gEyrxnGwZ
        o77l98WdaNRmWLW3pJ6x03A=
X-Google-Smtp-Source: ABdhPJx3SUGNW2XD8h8US9uScxTycxVHXeqpLbmx7fMrRID3k4oOipLAcBnlwkA/Q3ap+M2eKxw16w==
X-Received: by 2002:aa7:9ab6:: with SMTP id x22mr2661695pfi.136.1590564486694;
        Wed, 27 May 2020 00:28:06 -0700 (PDT)
Received: from fmin-OptiPlex-7060.nreal.work ([103.206.191.44])
        by smtp.gmail.com with ESMTPSA id q201sm1371842pfq.40.2020.05.27.00.28.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 May 2020 00:28:06 -0700 (PDT)
From:   dillon.minfei@gmail.com
To:     robh+dt@kernel.org, p.zabel@pengutronix.de,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        thierry.reding@gmail.com, sam@ravnborg.org, airlied@linux.ie,
        daniel@ffwll.ch, mturquette@baylibre.com, sboyd@kernel.org,
        andy.shevchenko@gmail.com, noralf@tronnes.org,
        linus.walleij@linaro.org, broonie@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        dri-devel@lists.freedesktop.org, linux-clk@vger.kernel.org,
        dillonhua@gmail.com, dillon min <dillon.minfei@gmail.com>
Subject: [PATCH v6 5/9] clk: stm32: Fix stm32f429's ltdc driver hang in set clock rate
Date:   Wed, 27 May 2020 15:27:29 +0800
Message-Id: <1590564453-24499-6-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1590564453-24499-1-git-send-email-dillon.minfei@gmail.com>
References: <1590564453-24499-1-git-send-email-dillon.minfei@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: dillon min <dillon.minfei@gmail.com>

This is due to misuse ‘PLL_VCO_SAI' and'PLL_SAI' in clk-stm32f4.c
'PLL_SAI' is 2, 'PLL_VCO_SAI' is 7(defined in
include/dt-bindings/clock/stm32fx-clock.h).

'post_div' point to 'post_div_data[]', 'post_div->pll_num'
is PLL_I2S or PLL_SAI.

'clks[PLL_VCO_SAI]' has valid 'struct clk_hw* ' return
from stm32f4_rcc_register_pll() but, at line 1777 of
driver/clk/clk-stm32f4.c, use the 'clks[post_div->pll_num]',
equal to 'clks[PLL_SAI]', this is invalid array member at that time.

Fixes: 517633ef630e ("clk: stm32f4: Add post divisor for I2S & SAI PLLs")
Signed-off-by: dillon min <dillon.minfei@gmail.com>
---

Hi Stephen Boyd,

This update include below changes since V5
1 separate '[PATCH v5 5/8]' patch to two submits
2 each one has a Fixes tags

best regards.

 drivers/clk/clk-stm32f4.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/clk-stm32f4.c b/drivers/clk/clk-stm32f4.c
index 18117ce5ff85..42ca2dd86aea 100644
--- a/drivers/clk/clk-stm32f4.c
+++ b/drivers/clk/clk-stm32f4.c
@@ -557,13 +557,13 @@ static const struct clk_div_table post_divr_table[] = {
 
 #define MAX_POST_DIV 3
 static const struct stm32f4_pll_post_div_data  post_div_data[MAX_POST_DIV] = {
-	{ CLK_I2SQ_PDIV, PLL_I2S, "plli2s-q-div", "plli2s-q",
+	{ CLK_I2SQ_PDIV, PLL_VCO_I2S, "plli2s-q-div", "plli2s-q",
 		CLK_SET_RATE_PARENT, STM32F4_RCC_DCKCFGR, 0, 5, 0, NULL},
 
-	{ CLK_SAIQ_PDIV, PLL_SAI, "pllsai-q-div", "pllsai-q",
+	{ CLK_SAIQ_PDIV, PLL_VCO_SAI, "pllsai-q-div", "pllsai-q",
 		CLK_SET_RATE_PARENT, STM32F4_RCC_DCKCFGR, 8, 5, 0, NULL },
 
-	{ NO_IDX, PLL_SAI, "pllsai-r-div", "pllsai-r", CLK_SET_RATE_PARENT,
+	{ NO_IDX, PLL_VCO_SAI, "pllsai-r-div", "pllsai-r", CLK_SET_RATE_PARENT,
 		STM32F4_RCC_DCKCFGR, 16, 2, 0, post_divr_table },
 };
 
-- 
2.7.4

