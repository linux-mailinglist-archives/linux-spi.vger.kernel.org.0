Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5527C1D761A
	for <lists+linux-spi@lfdr.de>; Mon, 18 May 2020 13:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbgERLJy (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 18 May 2020 07:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbgERLJx (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 18 May 2020 07:09:53 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B99C061A0C;
        Mon, 18 May 2020 04:09:53 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id n15so4872543pjt.4;
        Mon, 18 May 2020 04:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eu8Y+3kRQM/USnH5yzkkCNIQbKXjIgArtceSXqO2K04=;
        b=SYCy2JXfMKollyID3Ho5YgxpSh0LrBqOCbp1W+NTv8ArKSBhVfYnQQb5iD59P6vNKf
         bydaSGrCkSIlhCtG4x087JQUpKyomjDGQsbkpt0QSZ55xcfyAdHNQWceSUghV7umH8ZF
         HICfOfpfRpe3el3WU62lDKmnXkRVAHxvEZAvv7ITQraEgZxhcAtAaA4bQrtYRWMLDNLA
         aGoZ/PsT9bWgY97v+7hzdu8CgXroeqSNVd1AqcuRXc/AIW834eIp55svDvNoaHfMnac5
         0kCEu2FPZ1ZSQAFyUlRgvUgnAyWrPGGoEIjihvBARV62OLS+Q6pyz5q+W/gKlz2zN02l
         dQag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eu8Y+3kRQM/USnH5yzkkCNIQbKXjIgArtceSXqO2K04=;
        b=OWU59UGB6TQgw/71PUiCXoRBrVLoKrQAXNlRy+YIDgE5EkRbktCkj2bAeZd0sl4N7N
         XsvnnYzDBP9XbQNOE8hTFzvYqUBszXIsjFb3L6EerVbHnh4u37qiCjnly6QYkwwB02II
         E8nD626XA9AYnQiLshFQdVUY4D1Chjwj6efmzYMt3DA83ly7he2NulPQvmuteqJDKIbo
         cPcb36JZoN0Az3NGmMm3uGGVsLEU0SQtM3NdTcME6tXyo3YTdTdK2IQMdGqTsf7mY+05
         mJZlDnLuintDR65UhKaUxLeeYm+48+slTSTYFOZannLW7qO0tiw3vpg15BlePApZ6SRV
         ZP2w==
X-Gm-Message-State: AOAM531YWsSNPJxuB+2Pmii+4d6t8K9TaBCYuDgiJ0Mbt6WZgltVz0pW
        lVRf6Dyee83+G0fng6x1234=
X-Google-Smtp-Source: ABdhPJxZv32MXI2NS/zMY/o4Uo1RotZrCRnG98wKQmtgtBkpDu5mj+G3hzWv/6hhWrtYNHG+vIHrag==
X-Received: by 2002:a17:90a:8c01:: with SMTP id a1mr8944191pjo.127.1589800193350;
        Mon, 18 May 2020 04:09:53 -0700 (PDT)
Received: from fmin-OptiPlex-7060.nreal.work ([103.206.190.146])
        by smtp.gmail.com with ESMTPSA id a15sm8290630pju.3.2020.05.18.04.09.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 May 2020 04:09:53 -0700 (PDT)
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
Subject: [PATCH v4 4/8] ARM: dts: stm32: Add pin map for ltdc on stm32f429-disco board
Date:   Mon, 18 May 2020 19:09:21 +0800
Message-Id: <1589800165-3271-5-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1589800165-3271-1-git-send-email-dillon.minfei@gmail.com>
References: <1589800165-3271-1-git-send-email-dillon.minfei@gmail.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: dillon min <dillon.minfei@gmail.com>

This patch adds the pin configuration for ltdc controller
on stm32f429-disco board.

Signed-off-by: dillon min <dillon.minfei@gmail.com>
---
 arch/arm/boot/dts/stm32f4-pinctrl.dtsi | 50 ++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/arch/arm/boot/dts/stm32f4-pinctrl.dtsi b/arch/arm/boot/dts/stm32f4-pinctrl.dtsi
index 54c1b27..0eb107f 100644
--- a/arch/arm/boot/dts/stm32f4-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stm32f4-pinctrl.dtsi
@@ -316,6 +316,56 @@
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
 			spi5_pins: spi5-0 {
 				pins1 {
 					pinmux = <STM32_PINMUX('F', 7, AF5)>,
-- 
2.7.4

