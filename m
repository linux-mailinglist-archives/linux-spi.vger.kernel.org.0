Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C77CB185CF2
	for <lists+linux-spi@lfdr.de>; Sun, 15 Mar 2020 14:45:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728681AbgCONpK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 15 Mar 2020 09:45:10 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41088 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728668AbgCONpK (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 15 Mar 2020 09:45:10 -0400
Received: by mail-lf1-f66.google.com with SMTP id q10so11696720lfo.8;
        Sun, 15 Mar 2020 06:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K4LBF/SfxFsUJUI8XynDjFJLvWIbs62fNsYASRbdYqg=;
        b=aoJebTvoPhClcIQs9YdHWM3SzN8T043UUVvQYFNL8UE17NuDGxf+Py6gqkcqFYFsEk
         T5nBFivS4rykT3XVNYc/7+tX7dCQV27ZdqAlkvzYrH/48ztoAudGFud7YIx+dmawq9Dx
         un8ulI1mFeNu4hlK4vUnbKS7ooVbnGNzKoWmAdar0teE0q158xIPaNieOGLvTqILBQS/
         Cs8JlXNRVtJKlcnthDW/Yw0S/txAH2kG/thS1zfMnVqNZecJlLw8buvJn0nTdzzr88Jy
         XgoQj1y6WPlO2swBt1s88x1sPetexxXX6SrDcIXa6ln/FPEp9Aj/+feIpGIpnkw5ob7L
         032w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=K4LBF/SfxFsUJUI8XynDjFJLvWIbs62fNsYASRbdYqg=;
        b=D/NEKrugTJaFi26hdefjBbm2FcSGjjMih1i+mfJWcH3L7tzObxJ8GAj7ziMar0iBbN
         BsoYGlDHCRXPYcl6xKB0bxokdqgORF8ZWpaTzpm3fYAskBT9lABMhekWbwXT95BWvgje
         94GEc+xCsIM4JlF2QxCfoZYZfBe4xlUR8Hq9HE87Sj3Gli+XyN9c250ofjZFDw1AlDqT
         6KLZ3hQuB56WwyF76lGr+D2NPxcjrrkRTf9qrlzdLqlEjl9BFEp+NObaTCozZ9KPwkO5
         e33X5nesp4IsyJi9KdjaCgRlviN7IW4q2tW4vN4/NKchGDel2dFUQdt5NWYSTMHnS9ed
         yXpg==
X-Gm-Message-State: ANhLgQ2UHFIKpVS/4BOgV0HCj7LvaIwiwJAQtGOaVK7IKTggoIWZnSqp
        clxrg+6/5eOwOFfYcfTKAi0=
X-Google-Smtp-Source: ADFU+vvWFtPKBW6qyBr5/W0wNmtivYBhs/ZHpF0VnBgS28zZBTjXkCXXsHcgk6/v8BGForf5E2kFNA==
X-Received: by 2002:a19:5509:: with SMTP id n9mr12784893lfe.51.1584279906102;
        Sun, 15 Mar 2020 06:45:06 -0700 (PDT)
Received: from saturn.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id a9sm23025212lfb.21.2020.03.15.06.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2020 06:45:05 -0700 (PDT)
From:   Sam Ravnborg <sam@ravnborg.org>
To:     dri-devel@lists.freedesktop.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Cc:     Alexandre Courbot <acourbot@nvidia.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Brian Masney <masneyb@onstation.org>,
        Chris Zhong <zyw@rock-chips.com>,
        Douglas Anderson <dianders@chromium.org>,
        Guido Gunther <agx@sigxcpu.org>, Heiko Schocher <hs@denx.de>,
        Nikolaus Schaller <hns@goldelico.com>,
        Hoegeun Kwon <hoegeun.kwon@samsung.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Jerry Han <hanxu5@huaqin.corp-partner.google.com>,
        Jonathan Bakker <xc-racer2@live.ca>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Lin Huang <hl@rock-chips.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-spi@vger.kernel.org, Marco Franchi <marco.franchi@nxp.com>,
        Marek Belisko <marek@goldelico.com>,
        Mark Brown <broonie@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Maxime Ripard <mripard@kernel.org>,
        Nickey Yang <nickey.yang@rock-chips.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Peter Rosin <peda@axentia.se>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Purism Kernel Team <kernel@puri.sm>,
        Robert Chiras <robert.chiras@nxp.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Sandeep Panda <spanda@codeaurora.org>,
        Stefan Mavrodiev <stefan@olimex.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Vinay Simha BN <simhavcs@gmail.com>,
        Werner Johansson <werner.johansson@sonymobile.com>
Subject: [PATCH v1 18/36] dt-bindings: display: convert raydium,rm67191 to DT Schema
Date:   Sun, 15 Mar 2020 14:43:58 +0100
Message-Id: <20200315134416.16527-19-sam@ravnborg.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200315134416.16527-1-sam@ravnborg.org>
References: <20200315134416.16527-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Robert Chiras <robert.chiras@nxp.com>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
---
 .../display/panel/raydium,rm67191.txt         | 41 ----------
 .../display/panel/raydium,rm67191.yaml        | 75 +++++++++++++++++++
 2 files changed, 75 insertions(+), 41 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/panel/raydium,rm67191.txt
 create mode 100644 Documentation/devicetree/bindings/display/panel/raydium,rm67191.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/raydium,rm67191.txt b/Documentation/devicetree/bindings/display/panel/raydium,rm67191.txt
deleted file mode 100644
index 10424695aa02..000000000000
--- a/Documentation/devicetree/bindings/display/panel/raydium,rm67191.txt
+++ /dev/null
@@ -1,41 +0,0 @@
-Raydium RM67171 OLED LCD panel with MIPI-DSI protocol
-
-Required properties:
-- compatible: 		"raydium,rm67191"
-- reg:			virtual channel for MIPI-DSI protocol
-			must be <0>
-- dsi-lanes:		number of DSI lanes to be used
-			must be <3> or <4>
-- port: 		input port node with endpoint definition as
-			defined in Documentation/devicetree/bindings/graph.txt;
-			the input port should be connected to a MIPI-DSI device
-			driver
-
-Optional properties:
-- reset-gpios:		a GPIO spec for the RST_B GPIO pin
-- v3p3-supply:		phandle to 3.3V regulator that powers the VDD_3V3 pin
-- v1p8-supply:		phandle to 1.8V regulator that powers the VDD_1V8 pin
-- width-mm:		see panel-common.txt
-- height-mm:		see panel-common.txt
-- video-mode:		0 - burst-mode
-			1 - non-burst with sync event
-			2 - non-burst with sync pulse
-
-Example:
-
-	panel@0 {
-		compatible = "raydium,rm67191";
-		reg = <0>;
-		pinctrl-0 = <&pinctrl_mipi_dsi_0_1_en>;
-		pinctrl-names = "default";
-		reset-gpios = <&gpio1 7 GPIO_ACTIVE_LOW>;
-		dsi-lanes = <4>;
-		width-mm = <68>;
-		height-mm = <121>;
-
-		port {
-			panel_in: endpoint {
-				remote-endpoint = <&mipi_out>;
-			};
-		};
-	};
diff --git a/Documentation/devicetree/bindings/display/panel/raydium,rm67191.yaml b/Documentation/devicetree/bindings/display/panel/raydium,rm67191.yaml
new file mode 100644
index 000000000000..b78b66a4336f
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/raydium,rm67191.yaml
@@ -0,0 +1,75 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/raydium,rm67191.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Raydium RM67171 OLED LCD panel with MIPI-DSI protocol
+
+maintainers:
+  - Robert Chiras <robert.chiras@nxp.com>
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    const: raydium,rm67191
+
+  reg: true
+  port: true
+  reset-gpios: true
+  width-mm: true
+  height-mm: true
+ 
+  dsi-lanes:
+    description: Number of DSI lanes to be used must be <3> or <4>
+    enum: [3, 4]
+
+  v3p3-supply:
+    description: phandle to 3.3V regulator that powers the VDD_3V3 pin
+
+  v1p8-supply:
+    description: phandle to 1.8V regulator that powers the VDD_1V8 pin
+
+  video-mode:
+    description: |
+      0 - burst-mode
+      1 - non-burst with sync event
+      2 - non-burst with sync pulse
+    enum: [0, 1, 2]
+
+required:
+  - compatible
+  - reg
+  - dsi-lanes
+  - port
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    dsi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        panel {
+            compatible = "raydium,rm67191";
+            reg = <0>;
+            reset-gpios = <&gpio1 7 GPIO_ACTIVE_LOW>;
+            dsi-lanes = <4>;
+            width-mm = <68>;
+            height-mm = <121>;
+            video-mode = <1>;
+
+            port {
+                panel_in: endpoint {
+                    remote-endpoint = <&mipi_out>;
+                };
+            };
+        };
+    };
+
+...
-- 
2.20.1

