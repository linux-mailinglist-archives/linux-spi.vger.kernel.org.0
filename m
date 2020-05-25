Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 332901E0587
	for <lists+linux-spi@lfdr.de>; Mon, 25 May 2020 05:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388809AbgEYDqF (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 24 May 2020 23:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388730AbgEYDqD (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 24 May 2020 23:46:03 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2569BC061A0E;
        Sun, 24 May 2020 20:46:03 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id q8so8287284pfu.5;
        Sun, 24 May 2020 20:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TecVBwOuGZ/BbCjVyBAZuzQGGC9DlsbNm1sr3li0idE=;
        b=oOnEvJIc5RIC+XycPQbNKIOqu3rZrB9GkscAVQFQ0bIPFUXhXArjacXi2Bv9R8irzo
         xJ4obbevslcs+GawkyTJuMZcaQxb8t70SgchuEOmzRv9VmCoagv+xoE3hH8+uxrGu+u7
         Tr/nTMpuhzI8FeOPEYF4CiVdLMO4Yo+CU/rEyl2ZyF/zXXNC8cydBxXGjcTypHEmgeax
         OY8v4Xebai1cj4X0S4d58nwAtcOIGFv4+K0Qo3tuY/twGNB5zfVMY5LFwteks12B1qoP
         WJ2FZXvTm78wjDBDexzekBDJehJ6XUiQNlj1HScpmMzEEio3Xpd63nu3vsmTHMjSstN4
         gkgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TecVBwOuGZ/BbCjVyBAZuzQGGC9DlsbNm1sr3li0idE=;
        b=e5EQCYJxKWV7reWZb0ezMTVLhW4RH9e2Ll1rHSSHvtIlybhLJqLWd/00A8JLc1Jc8Z
         7jm373Hm/KZyZuPUsgfdc9gi1iacmb3UPNkV8ICrfBXY8m1unaEY6bFJDJaz7/MniyuM
         pA1sxF5EhDrB+/b6nBzawC7Z/U+SLVDI03COn47puDyeSZA0Rq1upHLooK8h8FoSfCzO
         Ec7AnBliW7qfh7CDu1qL+F6tANXJxVsnxrq+Lh4QqNftqZkMhvnTouJBU3npgNBwIJQP
         QOIQxhRonakAQMn2w6Yi8Eki1inheqDSdZorFXKEpxPlFdXFx0mcTjoZq3xK9B3Xa27Z
         rqnQ==
X-Gm-Message-State: AOAM533XlAjRvgRV/69lwFXLeb9aHjWX32lA1tiK/KzMbLZv2csZCZwm
        9ETWniQ8XrfNCgUlkmsOhSM=
X-Google-Smtp-Source: ABdhPJzcQZcr90XePIuYsKAB+iyE3OReyvFJzMWSlexKfctfg9uLTc3FLbdM/Zb/mh6AWJtg+8RtAA==
X-Received: by 2002:a62:e305:: with SMTP id g5mr15607365pfh.144.1590378362742;
        Sun, 24 May 2020 20:46:02 -0700 (PDT)
Received: from fmin-OptiPlex-7060.nreal.work ([103.206.191.44])
        by smtp.gmail.com with ESMTPSA id i98sm12152831pje.37.2020.05.24.20.45.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 May 2020 20:46:02 -0700 (PDT)
From:   dillon.minfei@gmail.com
To:     linus.walleij@linaro.org, broonie@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        dri-devel@lists.freedesktop.org, linux-clk@vger.kernel.org,
        dillon min <dillon.minfei@gmail.com>
Subject: [PATCH v5 3/8] ARM: dts: stm32: enable ltdc binding with ili9341, gyro l3gd20 on stm32429-disco board
Date:   Mon, 25 May 2020 11:45:43 +0800
Message-Id: <1590378348-8115-4-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1590378348-8115-1-git-send-email-dillon.minfei@gmail.com>
References: <1590378348-8115-1-git-send-email-dillon.minfei@gmail.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: dillon min <dillon.minfei@gmail.com>

Enable the ltdc & ili9341, gyro l3gd20 on stm32429-disco board.

Signed-off-by: dillon min <dillon.minfei@gmail.com>
---
 arch/arm/boot/dts/stm32f429-disco.dts | 48 +++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/arm/boot/dts/stm32f429-disco.dts b/arch/arm/boot/dts/stm32f429-disco.dts
index 30c0f67..365d16f 100644
--- a/arch/arm/boot/dts/stm32f429-disco.dts
+++ b/arch/arm/boot/dts/stm32f429-disco.dts
@@ -49,6 +49,8 @@
 #include "stm32f429.dtsi"
 #include "stm32f429-pinctrl.dtsi"
 #include <dt-bindings/input/input.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/gpio/gpio.h>
 
 / {
 	model = "STMicroelectronics STM32F429i-DISCO board";
@@ -127,3 +129,49 @@
 	pinctrl-names = "default";
 	status = "okay";
 };
+
+&ltdc {
+	status = "okay";
+	pinctrl-0 = <&ltdc_pins_f429_disco>;
+	pinctrl-names = "default";
+
+	port {
+		ltdc_out_rgb: endpoint {
+			remote-endpoint = <&panel_in_rgb>;
+		};
+	};
+};
+
+&spi5 {
+	status = "okay";
+	pinctrl-0 = <&spi5_pins>;
+	pinctrl-names = "default";
+	#address-cells = <1>;
+	#size-cells = <0>;
+	cs-gpios = <&gpioc 1 GPIO_ACTIVE_LOW>, <&gpioc 2 GPIO_ACTIVE_LOW>;
+
+	l3gd20: l3gd20@0 {
+		compatible = "st,l3gd20-gyro";
+		spi-max-frequency = <10000000>;
+		st,drdy-int-pin = <2>;
+		interrupt-parent = <&gpioa>;
+		interrupts = <1 IRQ_TYPE_EDGE_RISING>,
+				<2 IRQ_TYPE_EDGE_RISING>;
+		reg = <0>;
+		status = "okay";
+	};
+
+	display: display@1{
+		/* Connect panel-ilitek-9341 to ltdc */
+		compatible = "st,sf-tc240t-9370-t";
+		reg = <1>;
+		spi-3wire;
+		spi-max-frequency = <10000000>;
+		dc-gpios = <&gpiod 13 0>;
+		port {
+			panel_in_rgb: endpoint {
+			remote-endpoint = <&ltdc_out_rgb>;
+			};
+		};
+	};
+};
-- 
2.7.4

