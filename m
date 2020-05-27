Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42E8B1E3A79
	for <lists+linux-spi@lfdr.de>; Wed, 27 May 2020 09:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387566AbgE0H2N (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 27 May 2020 03:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387523AbgE0H2M (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 27 May 2020 03:28:12 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50C86C061A0F;
        Wed, 27 May 2020 00:28:12 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id j21so11375403pgb.7;
        Wed, 27 May 2020 00:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PCXZ/XVMi8KpMlGOTwhqCP9MMMe9ESFVI+WU4Q3c6Jk=;
        b=I8hUHZ6SxFDEwHdk7/zeDaW/Z2P4AkgiDIFUitVnXJXeTb+IOLeTPT06lLpHqELqho
         cHkEkrWucnwxAI4w9z7QW+3XmUv+zgx2u7kPK3azIIIrFymuAxKAL2rCyR9HUboYPkld
         wqT/JAKpZN3Rkjfb3iniOF3m8C5DPT+SsWECsI3JVppNGION1BhqoLc424/hjUYe+gdf
         MRftOfeBuYnUlGuwdnwN/mCbfPthTvj4rWFgrDhEMnFAMYruktb7ow5C9Bp8aE97DvLs
         KQvPaaw1ZLWNhbSOq9Ad9O1TOPc/aVPRXPBgmT6xw+CPz2EOWGz/sLi6nJLgN5uQ6Lj+
         DJNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PCXZ/XVMi8KpMlGOTwhqCP9MMMe9ESFVI+WU4Q3c6Jk=;
        b=B4GjnkveWqg9Rwd7MMGOBNKm0btiln8IF++JsLZAZc05qa2/4+iA/9Z4S4QHHY9nIQ
         HwtONYf8UbMlRjVOOhco06ZpU4kRx68Y+478vbiueTiqAaMUpWk9KgVnEdTLoBKL2Qs/
         XVhwZ8YS+GlCOpmu1nk0L7XDkSBqJcTZNM+H4ZJQCq2lPuJKhekSzFOxZ5yPbD06fqOV
         DrCiYP3BRgNqBoA7i9n0SMMHHLSMmjYgMSYGl42WgdirvhEQqiVVJXMF7hteYAwdzL40
         fiDcv+8mBVTNzBI+Hyj7cOcrLAjKebbk7dcimZbkRCanpmroz3WeTZUgQ1MoZXsh+5bM
         un4A==
X-Gm-Message-State: AOAM532Nk75pixx+KRdxDFPrG32bB3uGCtrOm9SA4OJ4kZK4p/dNR8T1
        sPoKlf+c3gb0MTD+/iilJpg=
X-Google-Smtp-Source: ABdhPJxPJhhSE88EJXZgUaSI8AhIFjINE/wSKKHD3Ql/J86dwwqEQCn2uj2TmRHGyg8Y6hFAjyIJXA==
X-Received: by 2002:a63:4b41:: with SMTP id k1mr2609543pgl.452.1590564491949;
        Wed, 27 May 2020 00:28:11 -0700 (PDT)
Received: from fmin-OptiPlex-7060.nreal.work ([103.206.191.44])
        by smtp.gmail.com with ESMTPSA id q201sm1371842pfq.40.2020.05.27.00.28.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 May 2020 00:28:11 -0700 (PDT)
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
Subject: [PATCH v6 6/9] clk: stm32: Fix ltdc's clock turn off by clk_disable_unused() after kernel startup
Date:   Wed, 27 May 2020 15:27:30 +0800
Message-Id: <1590564453-24499-7-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1590564453-24499-1-git-send-email-dillon.minfei@gmail.com>
References: <1590564453-24499-1-git-send-email-dillon.minfei@gmail.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: dillon min <dillon.minfei@gmail.com>

stm32's clk driver register two ltdc gate clk to clk core by
clk_hw_register_gate() and clk_hw_register_composite()

first: 'stm32f429_gates[]', clk name is 'ltdc', which no user to use.
second: 'stm32f429_aux_clk[]', clk name is 'lcd-tft', used by ltdc driver

both of them point to the same offset of stm32's RCC register. after
kernel enter console, clk core turn off ltdc's clk as 'stm32f429_gates[]'
is no one to use. but, actually 'stm32f429_aux_clk[]' is in use.

Fixes: daf2d117cbca ("clk: stm32f4: Add lcd-tft clock")
Signed-off-by: dillon min <dillon.minfei@gmail.com>
---

Changes since V5:
separate '[PATCH v5 5/8]' to two, add Fixes tags.

 drivers/clk/clk-stm32f4.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clk/clk-stm32f4.c b/drivers/clk/clk-stm32f4.c
index 42ca2dd86aea..fa62e990c539 100644
--- a/drivers/clk/clk-stm32f4.c
+++ b/drivers/clk/clk-stm32f4.c
@@ -129,7 +129,6 @@ static const struct stm32f4_gate_data stm32f429_gates[] __initconst = {
 	{ STM32F4_RCC_APB2ENR, 20,	"spi5",		"apb2_div" },
 	{ STM32F4_RCC_APB2ENR, 21,	"spi6",		"apb2_div" },
 	{ STM32F4_RCC_APB2ENR, 22,	"sai1",		"apb2_div" },
-	{ STM32F4_RCC_APB2ENR, 26,	"ltdc",		"apb2_div" },
 };
 
 static const struct stm32f4_gate_data stm32f469_gates[] __initconst = {
-- 
2.7.4

