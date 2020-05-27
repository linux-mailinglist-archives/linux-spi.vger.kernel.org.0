Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54E7A1E3A6A
	for <lists+linux-spi@lfdr.de>; Wed, 27 May 2020 09:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387506AbgE0H15 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 27 May 2020 03:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387405AbgE0H15 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 27 May 2020 03:27:57 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1CF6C061A0F;
        Wed, 27 May 2020 00:27:56 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id q8so11464095pfu.5;
        Wed, 27 May 2020 00:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Onz0m4658GcwNr7+Ki8b+efZhD5UwVfFPAClpApbxu0=;
        b=qzfCjtCaNGhfLciJD54Qh0tr4HfhlWRrFOV4JqFKlMpPdMNiyfoPVd6vh8IKAjR6+w
         C3AxBzG4tFG5AdOMu96Ur6YY/V4j6KirRzrwgdy+q8SsNNRhQfzTBZoCGK0nKcuEH6jf
         Y/1G+YUZWV57/XbaDHtNSoP/ya1KgxF23wSVZw1hqxBtOWbPFu+RM6v7DXRgrfPD1r8W
         egyo5asIcWN8twWGCbqUEZlLLLsGpR65xSoNRDxh/XVqIUb9qytoVqhE11VAR5QECjzV
         gXBuGjBHyEzOYijY7L1lKKXkAOwdAVLV4/NtmD2MMusXDm23palSzGptNSoAQQiEXOQE
         VrKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Onz0m4658GcwNr7+Ki8b+efZhD5UwVfFPAClpApbxu0=;
        b=smFfq5HEXoIwUtqyL1zQbWmVEgLK4hAmIUPfGiyYNFp7QEaYFxjzPUGyu4hx3ta6N1
         7vO6obt1upbdslSyt4ttcqJbkzfODsB1ujUo22qIodnXXax2JlItqIwIgjmrmvqx5i5L
         x/WxnJvgpGxuPnDI50jncrwPJjIqylS92FwgLi/jUCY0yf93VjdIJJTTKSDKjHt3eBKN
         NCHF/47EKciGsAav314MFyumFBMGEe5vPZ/161ddTEvToRfpB4VXcMbI58SgBmsRG+J3
         u5jR53HEL5MblR5KX9UzMlzCTQztQSbOiPOBWhVSd2QHJpIh/9LpysDz1wiH9NmLe7LR
         8+7Q==
X-Gm-Message-State: AOAM531HqYroBrAfkIo0dg33XZW8paLhH4Fg3Iw66tHuQpu4qBiuA921
        4vZ+lskjeOsdB3xYRS+WCWo=
X-Google-Smtp-Source: ABdhPJxrq6LGGhU2T5g5A4vxN18i9oicAGxndDihLIS9MQThMQYthUtoVFwyJepniaGtO+w8ZQMX1g==
X-Received: by 2002:a63:dc44:: with SMTP id f4mr2832593pgj.442.1590564476259;
        Wed, 27 May 2020 00:27:56 -0700 (PDT)
Received: from fmin-OptiPlex-7060.nreal.work ([103.206.191.44])
        by smtp.gmail.com with ESMTPSA id q201sm1371842pfq.40.2020.05.27.00.27.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 May 2020 00:27:55 -0700 (PDT)
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
Subject: [PATCH v6 3/9] ARM: dts: stm32: enable ltdc binding with ili9341, gyro l3gd20 on stm32429-disco board
Date:   Wed, 27 May 2020 15:27:27 +0800
Message-Id: <1590564453-24499-4-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1590564453-24499-1-git-send-email-dillon.minfei@gmail.com>
References: <1590564453-24499-1-git-send-email-dillon.minfei@gmail.com>
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
index 30c0f6717871..365d16fd3934 100644
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

