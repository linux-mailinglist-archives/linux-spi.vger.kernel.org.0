Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAF621E0582
	for <lists+linux-spi@lfdr.de>; Mon, 25 May 2020 05:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388773AbgEYDqB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 24 May 2020 23:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388730AbgEYDqA (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 24 May 2020 23:46:00 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 083D7C061A0E;
        Sun, 24 May 2020 20:46:00 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id ci23so7969032pjb.5;
        Sun, 24 May 2020 20:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GfRuA4swEZrmalrNdqlTpHmV2cl0sSIm4Vls/KHgpHc=;
        b=b/s8P7WPUDewoqGZVXz5SBp8jQzfaawmkcFAeBHofbTFHfPjKTMllWSLGQ75XgH0w6
         U14KzKR3jeOQrIv6TmlitrHNXfMqesnU3Jsga5vkHwEXNO++5eM+ue6eCOO+Ce5PZg9N
         O+q0ajIM61pqMEeEqNfkTcQru0EaCWKO4PY1ZxHnodokXQC2Qa4+fPP2cZeDC9NYKyGx
         nwuJ5x2jmSq/ayXeZkDJt6ktT6xx0vxvrpImk7JDIq2k2yN4n1Pn65NhX6FoIWK4p7Ng
         A1kaiwWlu/NqHeLb0e6hTbNBDMs3VL95Fpge5YCi/M4Kgg+kRoMMmQx/NdjqqrnC47TN
         B4sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GfRuA4swEZrmalrNdqlTpHmV2cl0sSIm4Vls/KHgpHc=;
        b=DGXfa0RkXVbhMsQU0aFDjcc3Zb6AmPK7cDd9trkxGJPEHdHuZ/x/xo2u/ECYeQHUXo
         /SnvDMdz+kAxp60lnVme4WMMyQkbvbD8tvciORmufa4LW5yIhztYa1bR3L0aAw7qpI1R
         B+okrQVXCj3UfMEo9I4J8pgDwjRhYx/ZUwH/8138cpQnvtk4ysF5FeJOM/JDTxy8pz4u
         TuZvb9bNpbJ/IsciMZ6NuyAJF2HY0bEXWoPlGw/U1FaLsGWmIzNLq/vxiBtR7cb0AVFC
         I9TFiPVvEqbDRVk/L0gzrciPjkzznob1A7fL+fmnnDS/MG1RDJTts9GMuAC/AFbGjUaP
         e3Iw==
X-Gm-Message-State: AOAM533k4yVaQndiAWp1ev01udhgWhXuo7qkN5AHVq9580aVGnlwVpD+
        E2NvKY1YVkY0db6OfbYn0mc=
X-Google-Smtp-Source: ABdhPJxii5WiWaGwqt4iLc/zkIDoBNCEavl9Xso9CCancCAU55WqainDQzxqHBdPlE2arZkpe3Qoug==
X-Received: by 2002:a17:90b:8d1:: with SMTP id ds17mr17745374pjb.76.1590378359552;
        Sun, 24 May 2020 20:45:59 -0700 (PDT)
Received: from fmin-OptiPlex-7060.nreal.work ([103.206.191.44])
        by smtp.gmail.com with ESMTPSA id i98sm12152831pje.37.2020.05.24.20.45.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 May 2020 20:45:59 -0700 (PDT)
From:   dillon.minfei@gmail.com
To:     linus.walleij@linaro.org, broonie@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        dri-devel@lists.freedesktop.org, linux-clk@vger.kernel.org,
        dillon min <dillon.minfei@gmail.com>
Subject: [PATCH v5 2/8] ARM: dts: stm32: Add pin map for ltdc & spi5 on stm32f429-disco board
Date:   Mon, 25 May 2020 11:45:42 +0800
Message-Id: <1590378348-8115-3-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1590378348-8115-1-git-send-email-dillon.minfei@gmail.com>
References: <1590378348-8115-1-git-send-email-dillon.minfei@gmail.com>
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
index 392fa14..0eb107f 100644
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

