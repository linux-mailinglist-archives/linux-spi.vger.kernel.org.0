Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF8C185CC6
	for <lists+linux-spi@lfdr.de>; Sun, 15 Mar 2020 14:44:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728646AbgCONoh (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 15 Mar 2020 09:44:37 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42462 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728634AbgCONoh (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 15 Mar 2020 09:44:37 -0400
Received: by mail-lf1-f65.google.com with SMTP id t21so11693959lfe.9;
        Sun, 15 Mar 2020 06:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2nNoHF8rJC/nOf5M8UDCn0+951QJCRTbyZ2ThPvlf0w=;
        b=peaSA7XXfInnOlxZwHMfXxgxh99b4MF4RSH4zmci46aJTfHAih6Ks3JleLT1XNLKXG
         tfiESYeF9CeV4mxStON58h1mDB4iz2RF84TVh+5jyM/MK1olmp3EnXLQuyzW4rOJ/PHr
         T2RkT5PavJJhRaXkMvdxQjd8P0M3ZsZ0APYHq+DAwytpMGagy46rdlv4h/njIPy+iDuL
         LJT6BzKaAnOr6dhcwwhBcm4V3D9Y109REnC5uSzp+hGLeCkFiHEHYH8KIKhG9E9BQcQA
         C1n7QwXOVKK7UQDY/ZNCEnfslAIDSct4tK1Jkjxqgcqb9ngMMVpdYtv+uLbQTU6VXqJJ
         BOPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=2nNoHF8rJC/nOf5M8UDCn0+951QJCRTbyZ2ThPvlf0w=;
        b=A7DA4pl8SPhUDSah5+v7rrY2pJM+iz4mdtjHrmHlYxBQY+EHR0QpDmNJPPOSwaQEYb
         mDK8O301Blyo+uw/65bPpvo6JQnOH7zTP6DTmUezQT9rbCGP1pUOXTxMcQdcg2DvGWjO
         oX5W3Mvs0mOROq0uIe+ecl6s6kdkOQdFgtOA1tt8/whethK5YqMZ3g7qn4SSCfGd+TBB
         qyPIt5iQQVVEj/9JcDY6ms6mHz6ZTfIUQ4/B91t3kwUXaZ6sHJjBXzk2g9Mv8Fpa7amP
         9E4HPl+ZUkldpr3jGcFJAwtNucITfxzExU26n4C/buwo/gcJ+0qqVwtmnmmRY21OpDzK
         Wk8g==
X-Gm-Message-State: ANhLgQ2E+9imkSt2HTL5R6/xBM3/8TuM/fApAkhWTQaPmGaA6LkQOXon
        A7YuINOhcUH9svhsUvwnMqw=
X-Google-Smtp-Source: ADFU+vsRGsioJ1VqqB8qQWTmMk8FSUPBYKCqg6o0VA9Tjps9bftz2BrCNELrmgSTrx0twM5iMuyksg==
X-Received: by 2002:ac2:5e7b:: with SMTP id a27mr5597020lfr.61.1584279874961;
        Sun, 15 Mar 2020 06:44:34 -0700 (PDT)
Received: from saturn.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id a9sm23025212lfb.21.2020.03.15.06.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2020 06:44:34 -0700 (PDT)
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
Subject: [PATCH v1 03/36] dt-bindings: display: convert samsung,s6e63m0 to DT Schema
Date:   Sun, 15 Mar 2020 14:43:43 +0100
Message-Id: <20200315134416.16527-4-sam@ravnborg.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200315134416.16527-1-sam@ravnborg.org>
References: <20200315134416.16527-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The binding for this panel is a SPI slave.
Reference spi-slave.yaml
to avoid duplicating all properties.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Jonathan Bakker <xc-racer2@live.ca>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
---
 .../display/panel/samsung,s6e63m0.txt         | 33 -----------
 .../display/panel/samsung,s6e63m0.yaml        | 58 +++++++++++++++++++
 2 files changed, 58 insertions(+), 33 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/panel/samsung,s6e63m0.txt
 create mode 100644 Documentation/devicetree/bindings/display/panel/samsung,s6e63m0.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/samsung,s6e63m0.txt b/Documentation/devicetree/bindings/display/panel/samsung,s6e63m0.txt
deleted file mode 100644
index 9fb9ebeef8e4..000000000000
--- a/Documentation/devicetree/bindings/display/panel/samsung,s6e63m0.txt
+++ /dev/null
@@ -1,33 +0,0 @@
-Samsung s6e63m0 AMOLED LCD panel
-
-Required properties:
-  - compatible: "samsung,s6e63m0"
-  - reset-gpios: GPIO spec for reset pin
-  - vdd3-supply: VDD regulator
-  - vci-supply: VCI regulator
-
-The panel must obey rules for SPI slave device specified in document [1].
-
-The device node can contain one 'port' child node with one child
-'endpoint' node, according to the bindings defined in [2]. This
-node should describe panel's video bus.
-
-[1]: Documentation/devicetree/bindings/spi/spi-bus.txt
-[2]: Documentation/devicetree/bindings/media/video-interfaces.txt
-
-Example:
-
-		s6e63m0: display@0 {
-			compatible = "samsung,s6e63m0";
-			reg = <0>;
-			reset-gpio = <&mp05 5 1>;
-			vdd3-supply = <&ldo12_reg>;
-			vci-supply = <&ldo11_reg>;
-			spi-max-frequency = <1200000>;
-
-			port {
-				lcd_ep: endpoint {
-					remote-endpoint = <&fimd_ep>;
-				};
-			};
-		};
diff --git a/Documentation/devicetree/bindings/display/panel/samsung,s6e63m0.yaml b/Documentation/devicetree/bindings/display/panel/samsung,s6e63m0.yaml
new file mode 100644
index 000000000000..204ed76da84d
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/samsung,s6e63m0.yaml
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/samsung,s6e63m0.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung s6e63m0 AMOLED LCD panel
+
+maintainers:
+  - Jonathan Bakker <xc-racer2@live.ca>
+
+allOf:
+  - $ref: ../../spi/spi-slave.yaml#
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    const: samsung,s6e63m0
+
+  reg: true
+  reset-gpios: true
+  port: true
+
+  vdd3-supply:
+    description: VDD regulator
+
+  vci-supply:
+    description: VCI regulator
+
+required:
+  - compatible
+  - reset-gpios
+  - vdd3-supply
+  - vci-supply
+
+examples:
+  - |
+    spi {
+        reg = <0xf00 0x20>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+        display@0 {
+            compatible = "samsung,s6e63m0";
+            reg = <0>;
+            reset-gpios = <&mp05 5 1>;
+            vdd3-supply = <&ldo12_reg>;
+            vci-supply = <&ldo11_reg>;
+            spi-max-frequency = <1200000>;
+
+            port {
+                lcd_ep: endpoint {
+                    remote-endpoint = <&fimd_ep>;
+                };
+            };
+        };
+    };
+
+...
-- 
2.20.1

