Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 385941E0549
	for <lists+linux-spi@lfdr.de>; Mon, 25 May 2020 05:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388784AbgEYDl0 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 24 May 2020 23:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388397AbgEYDlZ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 24 May 2020 23:41:25 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF8ADC061A0E;
        Sun, 24 May 2020 20:41:24 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id f21so5115978pgg.12;
        Sun, 24 May 2020 20:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TecVBwOuGZ/BbCjVyBAZuzQGGC9DlsbNm1sr3li0idE=;
        b=QvwUoGSuDZI63M9mn4vBZYR6xz8xAH3VHV5RbxNhdUbFv/U8Ov8jfGdflulavz+0WZ
         qn68Vk0lu71CEX9OGs4+MKvbDf/Ar+ANm9y5umPi9zmijBjN/L9m7TPJC2x8GEpBrLTx
         MtAmyIwYQmGgE8wW1oyErjZhXBE3+4RW5rSQVe19dvn6zXpHN5xM6gCLNw3e5ShOIePL
         EBfhSGztPSl4/o2NB8WyTY+Hpmg/imm0D5l7FPJJVQ++7BrB5tsfdiZzzGcbRuK/rQDh
         gSgGSXEVBQc+l2Aj8p4zMIZ9pgJTISpwslah9WeJImGDSfyMAnK0aABmjeZDfYJkxjwo
         yx/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TecVBwOuGZ/BbCjVyBAZuzQGGC9DlsbNm1sr3li0idE=;
        b=phvBXqI3IKsPblfzZ1d80qU43hDA5HZLNaAdMX9kY2iImDsOAqfiiq0NEZ1N23u69N
         jy7n7M0CqbLpLGCSHDLFt4u7ev+SR+mwZyaEOWoHw7cqI+Js+/TIe+2AJy4oSsTJzwYG
         bNaI+CF4uO0jNQVl8yoHYu7BVNLM0Xml4ty589ICYL2+njQpttxCqe2c9sqWmxNkZhfF
         9VGB5uD+1g2C6XZ/HRLnK/hjLuWeipH79Asyx26EuVxxDVgcQ9p+n8lYsk+KF7WJfDbB
         3F7udhv2GQ64Cc1Ogw7mhOLf10nCBdgl1dwYYlXkizzmtqbizy1UMIEn/pm5DRtrME85
         72+Q==
X-Gm-Message-State: AOAM532EqqRclKvZzEE7yPiFrPKm3h9aRnzY56rQh2eIPNtcQxplVJX2
        l2tEAxOC3g1u+gi4bVUWI/4=
X-Google-Smtp-Source: ABdhPJy5ws0szZe0UGhHCEkCIdbOEeMkcDKZOuy9zGQFq2wn8JF4wLX/np8i7COUtqGKNVkzvHrg1w==
X-Received: by 2002:a63:3609:: with SMTP id d9mr24436404pga.354.1590378084548;
        Sun, 24 May 2020 20:41:24 -0700 (PDT)
Received: from fmin-OptiPlex-7060.nreal.work ([103.206.191.44])
        by smtp.gmail.com with ESMTPSA id 7sm11981695pfc.203.2020.05.24.20.41.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 May 2020 20:41:24 -0700 (PDT)
From:   dillon.minfei@gmail.com
To:     robh+dt@kernel.org, p.zabel@pengutronix.de,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        thierry.reding@gmail.com, sam@ravnborg.org, airlied@linux.ie,
        daniel@ffwll.ch, mturquette@baylibre.com, sboyd@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        dri-devel@lists.freedesktop.org, linux-clk@vger.kernel.org,
        dillon min <dillon.minfei@gmail.com>
Subject: [PATCH v5 3/8] ARM: dts: stm32: enable ltdc binding with ili9341, gyro l3gd20 on stm32429-disco board
Date:   Mon, 25 May 2020 11:40:57 +0800
Message-Id: <1590378062-7965-4-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1590378062-7965-1-git-send-email-dillon.minfei@gmail.com>
References: <broonie@kernel.org>
 <1590378062-7965-1-git-send-email-dillon.minfei@gmail.com>
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

