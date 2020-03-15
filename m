Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9040D185CE2
	for <lists+linux-spi@lfdr.de>; Sun, 15 Mar 2020 14:44:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728658AbgCONo4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 15 Mar 2020 09:44:56 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38471 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728664AbgCONo4 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 15 Mar 2020 09:44:56 -0400
Received: by mail-lj1-f195.google.com with SMTP id w1so15631933ljh.5;
        Sun, 15 Mar 2020 06:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fbZs3xCKO0rPyc/A/ruz0C0c57eblsfHWM6KLaBbzu0=;
        b=mtwGW4X5xdOlrVhAc/VLwG/7ziAXS7Fkgze/TQPojsuIjfXZLH/ntsYYxHp/lCvJ9C
         wOhHy+ppL+vxbK1AtRHhOxhYk96whG1LWzV0IiHtz70P7XsID90Z10HX46v2tus2/ao2
         oYJOizypDxrXOmVWk/74qJc+h33+35i3l6zxAMCJRklWKrprsFHPK9HF15p/StvnNbU9
         RslpirwYN6sWzmK7jjgg1gsxXT5V/JDJFjF31X9tEJ9H+KYlCVBmHbnM6Owfh++rcQWQ
         xvE6KyKJd05tfzlMhhaNtOsSsrtcrN21AXUE2mazJBZCWqeYj2tav0lFPPnQaJ4uosPc
         924A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=fbZs3xCKO0rPyc/A/ruz0C0c57eblsfHWM6KLaBbzu0=;
        b=ueLXTTotlNfO2AlYE3pkhOUTG8yTq838gF5n9gIoHAcxkFdWdgMhzU8xo6IK1y+Nv0
         Rvrz9cVIn1REkSmlpV62UGwjXMB9LyijkWUoDEtP35QkqPLQ/9WCV3g8qM1nLP7vklI9
         PW/tXNqyfBKUe+9aHSABSAbOSDnFkd8b47oy73difr7+G/rpTYi48XY7OyHPYZ7/rNo3
         GrSxHQKH4ya3HGmO+KI/SEqPRUsSeOUYSgcSHPE5DmO56HTZHVFp9HiLcLDHnL9Fui0r
         d9jkrY1cklk/jagPtKNViZ916zOSnGANMfXmHqmOWc57zJY54wd42sK+AAECdjZdWBAm
         47XA==
X-Gm-Message-State: ANhLgQ3PQLG1+19P3rBBjEMP85q6IsKs4sUD/8yE1QyIWSwTo5wvooto
        fK1NqOOpOXTgIOk3yYAmpNI=
X-Google-Smtp-Source: ADFU+vtdu+RtCfOyfUD8nHISljJPTE1xUWlvIyhAv6x8i0R2hy2i9EsS4Xv3x/wGemFSN33Ad6CKfA==
X-Received: by 2002:a2e:5ce:: with SMTP id 197mr14029954ljf.234.1584279893885;
        Sun, 15 Mar 2020 06:44:53 -0700 (PDT)
Received: from saturn.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id a9sm23025212lfb.21.2020.03.15.06.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2020 06:44:53 -0700 (PDT)
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
Subject: [PATCH v1 12/36] dt-bindings: display: convert jdi,lt070me05000 to DT Schema
Date:   Sun, 15 Mar 2020 14:43:52 +0100
Message-Id: <20200315134416.16527-13-sam@ravnborg.org>
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
Cc: Vinay Simha BN <simhavcs@gmail.com>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
---
 .../display/panel/jdi,lt070me05000.txt        | 31 ---------
 .../display/panel/jdi,lt070me05000.yaml       | 69 +++++++++++++++++++
 2 files changed, 69 insertions(+), 31 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/panel/jdi,lt070me05000.txt
 create mode 100644 Documentation/devicetree/bindings/display/panel/jdi,lt070me05000.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/jdi,lt070me05000.txt b/Documentation/devicetree/bindings/display/panel/jdi,lt070me05000.txt
deleted file mode 100644
index 4989c91d505f..000000000000
--- a/Documentation/devicetree/bindings/display/panel/jdi,lt070me05000.txt
+++ /dev/null
@@ -1,31 +0,0 @@
-JDI model LT070ME05000 1200x1920 7" DSI Panel
-
-Required properties:
-- compatible: should be "jdi,lt070me05000"
-- vddp-supply: phandle of the regulator that provides the supply voltage
-  Power IC supply (3-5V)
-- iovcc-supply: phandle of the regulator that provides the supply voltage
-  IOVCC , power supply for LCM (1.8V)
-- enable-gpios: phandle of gpio for enable line
-  LED_EN, LED backlight enable, High active
-- reset-gpios: phandle of gpio for reset line
-  This should be 8mA, gpio can be configured using mux, pinctrl, pinctrl-names
-  XRES, Reset, Low active
-- dcdc-en-gpios: phandle of the gpio for power ic line
-  Power IC supply enable, High active
-
-Example:
-
-	dsi0: qcom,mdss_dsi@4700000 {
-		panel@0 {
-			compatible = "jdi,lt070me05000";
-			reg = <0>;
-
-			vddp-supply = <&pm8921_l17>;
-			iovcc-supply = <&pm8921_lvs7>;
-
-			enable-gpios = <&pm8921_gpio 36 GPIO_ACTIVE_HIGH>;
-			reset-gpios = <&tlmm_pinmux 54 GPIO_ACTIVE_LOW>;
-			dcdc-en-gpios = <&pm8921_gpio 23 GPIO_ACTIVE_HIGH>;
-		};
-	};
diff --git a/Documentation/devicetree/bindings/display/panel/jdi,lt070me05000.yaml b/Documentation/devicetree/bindings/display/panel/jdi,lt070me05000.yaml
new file mode 100644
index 000000000000..e0abf68ecb19
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/jdi,lt070me05000.yaml
@@ -0,0 +1,69 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/jdi,lt070me05000.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: JDI model LT070ME05000 1200x1920 7" DSI Panel
+
+maintainers:
+  - Vinay Simha BN <simhavcs@gmail.com>
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    const: jdi,lt070me05000
+
+  enable-gpios: true
+  reg: true
+  reset-gpios: true
+
+  vddp-supply:
+    description: |
+      The regulator that provides the supply voltage Power IC supply (3-5V)
+
+  iovcc-supply:
+    description: |
+      The regulator that provides the supply voltage IOVCC,
+      power supply for LCM (1.8V)
+
+  dcdc-en-gpios:
+    description: |
+      phandle of the gpio for power ic line
+      Power IC supply enable, High active
+
+required:
+  - compatible
+  - reg
+  - vddp-supply
+  - iovcc-supply
+  - enable-gpios
+  - reset-gpios
+  - dcdc-en-gpios
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    dsi: qcom,mdss_dsi@4700000 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        panel@0 {
+            compatible = "jdi,lt070me05000";
+            reg = <0>;
+
+            vddp-supply = <&pm8921_l17>;
+            iovcc-supply = <&pm8921_lvs7>;
+
+            enable-gpios = <&pm8921_gpio 36 GPIO_ACTIVE_HIGH>;
+            reset-gpios = <&tlmm_pinmux 54 GPIO_ACTIVE_LOW>;
+            dcdc-en-gpios = <&pm8921_gpio 23 GPIO_ACTIVE_HIGH>;
+        };
+    };
+
+...
-- 
2.20.1

