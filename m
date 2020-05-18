Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE9F1D762C
	for <lists+linux-spi@lfdr.de>; Mon, 18 May 2020 13:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727890AbgERLKJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 18 May 2020 07:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgERLKJ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 18 May 2020 07:10:09 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 150C6C061A0C;
        Mon, 18 May 2020 04:10:09 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id k19so4083227pll.9;
        Mon, 18 May 2020 04:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=27PbOaMbBVWFDUpgZSoSDpOzKD3UMVb1DqVNCc5DcEA=;
        b=UitJdb8yW4cB8fRlc3JjAg8ulOAxElgqba+leJ02+HWVzReNhP+SfMJBe/0xauSVLz
         J3xwJzestItkmbiQMMeFDV/pf3IenhubvFo/kqCQMM25hEUDc+q1gRD7qFfwaCJdXxXF
         QBnLnPy3C27eIHvNI9H3Dm3ss/YWxQS4b3E484IH/w3olmmX7HwQKSmV9e5WZt2mKF+E
         gIrtK4ma7ItLVGMwwXo3uAJhNpUja6iXYZ9+9HIy7gBanA0QY163aGyLYGFlEMbj6aTi
         uCSy+MN4Kb9zZzK0nxDeuTB0BWf4+FjvyW1wrsr2a1cRIfSxrO/QyK/TgNMgm8wWnf0Y
         +4tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=27PbOaMbBVWFDUpgZSoSDpOzKD3UMVb1DqVNCc5DcEA=;
        b=hmtUeIrVnobN7PA5KZY2xKwIgd7TxJbinEwqxBCzBumNtpzvFcasatEIMyrmFI/gm7
         M4RMZeEYluctsN/2VYQ2/o/7DULMd9TRc0JqkFEMEXovhESggYyOS4hDIZNFG3691y8D
         rjHeFqqWMcS2OPxk2/hNeYpYVpJsv6CSgTQDW5o8eDrkTKX04ckQDjTxzXWeI4TA6NS9
         N5i293qAi5jvJRL/Z2Nj96h3NBPzpjpZCPHvU/7rNB8oUyp/4fomDArFjxLi2ntJxEwB
         KqASifTgOPRKuMSDApaDo8H/+VfTwBs2Uov98FrYfOg43Goil4WHlmTDOiYk0/ol8V0h
         58nw==
X-Gm-Message-State: AOAM533dkh1puzghrJFH8Cb3Ml6mpOIsaRSiPu/VRTJZpcj7MYNAOQwg
        BEQqN3ZAOmqzjzSA4zAGwys=
X-Google-Smtp-Source: ABdhPJxxao0Kj7GXRQc9ppHfrOHRFrIZdWBFk8KcyBMOwQTFUDcMlXar/bj1RDMz8W105aJ1ZHFVug==
X-Received: by 2002:a17:90a:ba18:: with SMTP id s24mr19917130pjr.192.1589800208703;
        Mon, 18 May 2020 04:10:08 -0700 (PDT)
Received: from fmin-OptiPlex-7060.nreal.work ([103.206.190.146])
        by smtp.gmail.com with ESMTPSA id a15sm8290630pju.3.2020.05.18.04.10.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 May 2020 04:10:08 -0700 (PDT)
From:   dillon.minfei@gmail.com
To:     robh+dt@kernel.org, p.zabel@pengutronix.de,
        mcoquelin.stm32@gmail.com, broonie@kernel.org,
        devicetree@vger.kernel.org, alexandre.torgue@st.com,
        thierry.reding@gmail.com, sam@ravnborg.org, airlied@linux.ie,
        daniel@ffwll.ch, mturquette@baylibre.com, sboyd@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        dri-devel@lists.freedesktop.org, linux-clk@vger.kernel.org,
        dillon min <dillon.minfei@gmail.com>
Subject: [PATCH v4 7/8] clk: stm32: Fix stm32f429's ltdc driver hang in set clock rate.
Date:   Mon, 18 May 2020 19:09:24 +0800
Message-Id: <1589800165-3271-8-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1589800165-3271-1-git-send-email-dillon.minfei@gmail.com>
References: <1589800165-3271-1-git-send-email-dillon.minfei@gmail.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: dillon min <dillon.minfei@gmail.com>

fix duplicated ltdc clock register to 'clk_core' case ltdc's clock
turn off by clk_disable_unused()

ltdc set clock rate crashed:
   'post_div_data[]''s pll_num is PLL_I2S, PLL_SAI (number is 1,2). but,
    as pll_num is offset of 'clks[]' input to clk_register_pll_div(), which
    is FCLK, CLK_LSI, defined in 'include/dt-bindings/clock/stm32fx-clock.h'
    so, this is a null object at the register time.
    then, in ltdc's clock is_enabled(), enable(), will call to_clk_gate().
    will return a null object, cause kernel crashed.
    need change pll_num to PLL_VCO_I2S, PLL_VCO_SAI for 'post_div_data[]'

duplicated ltdc clock
   'stm32f429_gates[]' has a member 'ltdc' register to 'clk_core', but no
    upper driver use it, ltdc driver use the lcd-tft defined in
   'stm32f429_aux_clk[]'. after system startup, as stm32f429_gates[]'s ltdc
   enable_count is zero, so turn off by clk_disable_unused()

Signed-off-by: dillon min <dillon.minfei@gmail.com>
---
Hi Stephen Boyd:

thanks for reviewing, this patch fix the wrong use of clk ignore unused.

thanks.

Changes since V3:
1 drop last wrong changes about 'CLK_IGNORE_UNUSED' patch
2 fix PLL_SAI mismatch with PLL_VCO_SAI
 drivers/clk/clk-stm32f4.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/clk-stm32f4.c b/drivers/clk/clk-stm32f4.c
index 18117ce..fa62e99 100644
--- a/drivers/clk/clk-stm32f4.c
+++ b/drivers/clk/clk-stm32f4.c
@@ -129,7 +129,6 @@ static const struct stm32f4_gate_data stm32f429_gates[] __initconst = {
 	{ STM32F4_RCC_APB2ENR, 20,	"spi5",		"apb2_div" },
 	{ STM32F4_RCC_APB2ENR, 21,	"spi6",		"apb2_div" },
 	{ STM32F4_RCC_APB2ENR, 22,	"sai1",		"apb2_div" },
-	{ STM32F4_RCC_APB2ENR, 26,	"ltdc",		"apb2_div" },
 };
 
 static const struct stm32f4_gate_data stm32f469_gates[] __initconst = {
@@ -557,13 +556,13 @@ static const struct clk_div_table post_divr_table[] = {
 
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

