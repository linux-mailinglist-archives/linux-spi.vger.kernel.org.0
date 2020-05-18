Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7E981D7624
	for <lists+linux-spi@lfdr.de>; Mon, 18 May 2020 13:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgERLKF (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 18 May 2020 07:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgERLKF (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 18 May 2020 07:10:05 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01811C061A0C;
        Mon, 18 May 2020 04:10:04 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id y18so4788708pfl.9;
        Mon, 18 May 2020 04:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=I1T/MSXgatC2plQLGmWEDShQlFTEnK6nXGcY9iM2hHM=;
        b=iLYajPKb4u2/NWaM0uZuIIE0Zgslm6lKb1y7vbs2KEVZmA5magKDWvcJaUjMVGG+Hq
         HtA7x5myFIX4Z4h80DOZFCe/VoYeirGoypijZ4/g7WZ7lvx1ubsUYNofLiJhE1wIPAhS
         3vih8uOhCFix1mDfEuK9yq+iHbVagLjCIBoienMxcwEIl1Lc8SaBOHhbQCmo6UYA0X2K
         nPPIsaiO4+H/UuvWhNm1AEtIIELfckw275sb9XmSEP5HNnY39X5zXHA34nbxGxOeIH5p
         97482nu6JWh6jXjVTCm8W087b5N2UPqd28djYacnRa8xQf8+F9jwruj10kyiX0vGDrp9
         ucag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=I1T/MSXgatC2plQLGmWEDShQlFTEnK6nXGcY9iM2hHM=;
        b=KIGcavmUFM8YEyR9beWNvTowW7/LIBOe1g24van2xvvkjqstRazZFj+dJ1YtWH6svE
         e5qMDjlG3gJikSsiFbglYizP6hsbPo/Vo5/Z8cXPsiEjMfruhaOaBDqmQ+6mDvOaMr2i
         xxhI0yzYRpB5r4roX+oXZV40CUdipxxi1Z4aMbqw9uQfqYJhBST+26MZ1aTxViFbusVs
         dCT0K+q5cdY+0DGpwLp2uF1FRHkUEHoMCJn1/Dw5GH7aKAD11+FZHOxCX1eFj1XqyuDr
         8Jb3i66i1iDXBZZKjIYUORn7RfaCZdMNyxbf3hGdEzqb+eY01dVl8v2MRdt/UDD32G6Z
         meWA==
X-Gm-Message-State: AOAM530WmUDWLnaPay+CCFL92i3M4WdDrxSmUB3E1xPD6xKL5j8Ogr4+
        lL3OwjM8FPW6fzsWq+Av39s=
X-Google-Smtp-Source: ABdhPJzTp8verXSiF/j8yXN0XwsCs3i8VyAOtQYBHq+u7MVM7vRjm0APUV2Qcp5rZcERI/eLfvhwIg==
X-Received: by 2002:a63:5f41:: with SMTP id t62mr14754996pgb.252.1589800203620;
        Mon, 18 May 2020 04:10:03 -0700 (PDT)
Received: from fmin-OptiPlex-7060.nreal.work ([103.206.190.146])
        by smtp.gmail.com with ESMTPSA id a15sm8290630pju.3.2020.05.18.04.09.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 May 2020 04:10:03 -0700 (PDT)
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
Subject: [PATCH v4 6/8] ARM: dts: stm32: enable ltdc binding with ili9341 on stm32429-disco board
Date:   Mon, 18 May 2020 19:09:23 +0800
Message-Id: <1589800165-3271-7-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1589800165-3271-1-git-send-email-dillon.minfei@gmail.com>
References: <1589800165-3271-1-git-send-email-dillon.minfei@gmail.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: dillon min <dillon.minfei@gmail.com>

Enable the ltdc & ili9341 on stm32429-disco board.

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

