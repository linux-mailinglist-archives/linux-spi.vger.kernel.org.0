Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1F061E3A69
	for <lists+linux-spi@lfdr.de>; Wed, 27 May 2020 09:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387474AbgE0H1w (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 27 May 2020 03:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387405AbgE0H1v (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 27 May 2020 03:27:51 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75ADBC03E97A;
        Wed, 27 May 2020 00:27:51 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id e11so10499687pfn.3;
        Wed, 27 May 2020 00:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3vUDSkp2rIRsyDWaQXlzdhkNXO48Q97985UUzAKneWQ=;
        b=AcbMLcq+gvdqJHFMAqIMip5RDOWtBG/2xVj6NMsQKpaoQojhzqFDwqdvqVoOwzB5Zr
         WcQuPzddk+kzGJvHz0WrluPPHJf8xlPg4ZCEEnASD0oMJVduLHeXSIaPwAiROQlWu8mQ
         KbPNzhA+31VVCvYE64GHl98FvW4qxS+scg8kcSlQQwnpcHWzjHQtGwCGtY7Pkg5W2uiN
         uK84MScZhZLntr2s4s0f/VToWnGFzHoPOXawK73jPR1XRLHfGd3C626Gz78uBxzTLAr8
         yrb5pvGBdloV4joyzvoVmuGjYhdc2L9dn/yFbviXjYbWcFNqYoTo0Xdl6hnAHowfFXg6
         EvFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3vUDSkp2rIRsyDWaQXlzdhkNXO48Q97985UUzAKneWQ=;
        b=pCUTzUAtIJRRuRYkx0qFOA9FFAt5+PHe1QgrU8ppQ7lwEWIo/9Y+HzLFXfOPvET4nF
         +s+WiiZPcVpFXPq9tdl0PHB83ALSRRKh1aLija2cVP8iGyTetUiNEmBL0hAGuDYcR+tk
         f0vf7vzdO4rgMKlwr9gIQI4uSHe18AQ1SmcROXlRmYs+w5XIyuQ8pd5gDpmEbCVgJGOp
         d10dojiuanF5rvHTysNv8/4b9axEOO/1bAszpkEIJhda/yS0PSPO0RJYlSOYx7XurFhc
         I89hqLOrygvPPBzFxzalJIQ/VIgPDMeWilJzLYVZHNEfosMWcMfz/G/fK0mkFkgDGVF4
         nvkg==
X-Gm-Message-State: AOAM532GjeSDICsD4WEyc/45nUJJGRERD5Sl01TnZKukn9iGufUTGeBd
        Zay7c6ll4z7VM0UhOTHHVB0=
X-Google-Smtp-Source: ABdhPJze/wPT6R5+UazOEAz3R2jeZcI2L+WGfkk4JCeSb/Zkk655KYlgpBVr7ZxJIUeTVWzm+ASI+g==
X-Received: by 2002:a63:e804:: with SMTP id s4mr2782856pgh.260.1590564471078;
        Wed, 27 May 2020 00:27:51 -0700 (PDT)
Received: from fmin-OptiPlex-7060.nreal.work ([103.206.191.44])
        by smtp.gmail.com with ESMTPSA id q201sm1371842pfq.40.2020.05.27.00.27.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 May 2020 00:27:50 -0700 (PDT)
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
Subject: [PATCH v6 2/9] ARM: dts: stm32: Add pin map for ltdc & spi5 on stm32f429-disco board
Date:   Wed, 27 May 2020 15:27:26 +0800
Message-Id: <1590564453-24499-3-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1590564453-24499-1-git-send-email-dillon.minfei@gmail.com>
References: <1590564453-24499-1-git-send-email-dillon.minfei@gmail.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: dillon min <dillon.minfei@gmail.com>

This patch adds the pin configuration for ltdc and spi5 controller
on stm32f429-disco board.

Signed-off-by: dillon min <dillon.minfei@gmail.com>
---
 arch/arm/boot/dts/stm32f4-pinctrl.dtsi | 67 ++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/arch/arm/boot/dts/stm32f4-pinctrl.dtsi b/arch/arm/boot/dts/stm32f4-pinctrl.dtsi
index 392fa143ce07..0eb107f968cd 100644
--- a/arch/arm/boot/dts/stm32f4-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stm32f4-pinctrl.dtsi
@@ -316,6 +316,73 @@
 				};
 			};
 
+			ltdc_pins_f429_disco: ltdc-1 {
+				pins {
+					pinmux = <STM32_PINMUX('C', 6,  AF14)>,
+						/* LCD_HSYNC */
+						 <STM32_PINMUX('A', 4,  AF14)>,
+						 /* LCD_VSYNC */
+						 <STM32_PINMUX('G', 7,  AF14)>,
+						 /* LCD_CLK */
+						 <STM32_PINMUX('C', 10, AF14)>,
+						 /* LCD_R2 */
+						 <STM32_PINMUX('B', 0,  AF9)>,
+						 /* LCD_R3 */
+						 <STM32_PINMUX('A', 11, AF14)>,
+						 /* LCD_R4 */
+						 <STM32_PINMUX('A', 12, AF14)>,
+						 /* LCD_R5 */
+						 <STM32_PINMUX('B', 1,  AF9)>,
+						 /* LCD_R6*/
+						 <STM32_PINMUX('G', 6,  AF14)>,
+						 /* LCD_R7 */
+						 <STM32_PINMUX('A', 6,  AF14)>,
+						 /* LCD_G2 */
+						 <STM32_PINMUX('G', 10, AF9)>,
+						 /* LCD_G3 */
+						 <STM32_PINMUX('B', 10, AF14)>,
+						 /* LCD_G4 */
+						 <STM32_PINMUX('D', 6,  AF14)>,
+						 /* LCD_B2 */
+						 <STM32_PINMUX('G', 11, AF14)>,
+						 /* LCD_B3*/
+						 <STM32_PINMUX('B', 11, AF14)>,
+						 /* LCD_G5 */
+						 <STM32_PINMUX('C', 7,  AF14)>,
+						 /* LCD_G6 */
+						 <STM32_PINMUX('D', 3,  AF14)>,
+						 /* LCD_G7 */
+						 <STM32_PINMUX('G', 12, AF9)>,
+						 /* LCD_B4 */
+						 <STM32_PINMUX('A', 3,  AF14)>,
+						 /* LCD_B5 */
+						 <STM32_PINMUX('B', 8,  AF14)>,
+						 /* LCD_B6 */
+						 <STM32_PINMUX('B', 9,  AF14)>,
+						 /* LCD_B7 */
+						 <STM32_PINMUX('F', 10, AF14)>;
+						 /* LCD_DE */
+					slew-rate = <2>;
+				};
+			};
+
+			spi5_pins: spi5-0 {
+				pins1 {
+					pinmux = <STM32_PINMUX('F', 7, AF5)>,
+						/* SPI5_CLK */
+						 <STM32_PINMUX('F', 9, AF5)>;
+						/* SPI5_MOSI */
+					bias-disable;
+					drive-push-pull;
+					slew-rate = <0>;
+				};
+				pins2 {
+					pinmux = <STM32_PINMUX('F', 8, AF5)>;
+						/* SPI5_MISO */
+					bias-disable;
+				};
+			};
+
 			dcmi_pins: dcmi-0 {
 				pins {
 					pinmux = <STM32_PINMUX('A', 4, AF13)>, /* DCMI_HSYNC */
-- 
2.7.4

