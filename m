Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5311185CF8
	for <lists+linux-spi@lfdr.de>; Sun, 15 Mar 2020 14:45:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728678AbgCONpN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 15 Mar 2020 09:45:13 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42504 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728668AbgCONpN (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 15 Mar 2020 09:45:13 -0400
Received: by mail-lf1-f67.google.com with SMTP id t21so11694680lfe.9;
        Sun, 15 Mar 2020 06:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K6Ojd94vjUcgSndzfprDVKF+JSlxG4uGRfRXsYpGzQ0=;
        b=RUApmchfSYmoxx2BhNKgiY6eJuIK9Qg6fULrj7j1NQ0ylBx6Jri/OwL8H7UafwANxG
         Y/CDNBHoSvUo6GE9N6kgf6dCCw0FmmI3q/x6FzpEQUfdtSixzhvwm9Jj7wR7MeEX773q
         0ghaVjexNXypxQMBQ39t6WlP+qMv2fz9Inx1PaZ42d4dRwV/2tQKnBMNAbNTnR103BPx
         U6kmRlmC29jHgKLxdWQuGpYvZLlgqBWE1jScq40JTEjjA+O5kXrh9CHm6W4QTImg0CAh
         tQrN3ZpxeGIgMaIaauZ06tw5PdPX18vabtO1txh7fnQwWrWkSofW21y9bLOh2dVKCsfD
         vTfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=K6Ojd94vjUcgSndzfprDVKF+JSlxG4uGRfRXsYpGzQ0=;
        b=Uf+fS4srhTYWM13D/k0P4FD5VRfOTYyJcIGYMCVkWt/4wVf5tLQG14e6VkVQghrx6T
         g8mp4j7VzizX0RCyAShy2wmLxKSiFpCrQd3odZvyuEZROS0EN+vtPkSCM5SMzSyc9pwF
         04OEqyJjw30L936J8TXRKj+TGEAyVXyCmAwSRLHZXVs3RYPn8XBC1C5NYzNjT2zKyVah
         3/8bJR3eQoXoFH29/JmOQ5ePcyWN5qPXeZtoYiN9sxcJWxSofTlqWEBvXHk2jMoopYRu
         aoy172Kb7lZDOrzCDXwjo+PnZhHgqxw4UNcWVZ3ayiDO1Ag/iFkF+OqOESTQ1ur920tD
         6tmw==
X-Gm-Message-State: ANhLgQ1eHGIOmEDA1Of6FdpQMy5R61D03Emjo70fshK/vKoXnKwljUHq
        StjIUGy2BUsfNY2vd9j92sE=
X-Google-Smtp-Source: ADFU+vvUDD8EF4KsOZd/MppSFwwUy3nri8pTIr+LWp70LAZWTpH+hOHiq0AvEfYZ7bRx03u/qweGHQ==
X-Received: by 2002:a05:6512:1085:: with SMTP id j5mr14336324lfg.183.1584279910323;
        Sun, 15 Mar 2020 06:45:10 -0700 (PDT)
Received: from saturn.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id a9sm23025212lfb.21.2020.03.15.06.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2020 06:45:09 -0700 (PDT)
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
Subject: [PATCH v1 20/36] dt-bindings: display: convert samsung AMOLED to DT Schema
Date:   Sun, 15 Mar 2020 14:44:00 +0100
Message-Id: <20200315134416.16527-21-sam@ravnborg.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200315134416.16527-1-sam@ravnborg.org>
References: <20200315134416.16527-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

For samsung there was two AMOLED panels with the same
description.
Collect them in one binding file.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Hoegeun Kwon <hoegeun.kwon@samsung.com>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
---
 .../panel/samsung,amoled-mipi-dsi.yaml        | 65 +++++++++++++++++++
 .../display/panel/samsung,s6e3ha2.txt         | 31 ---------
 .../display/panel/samsung,s6e63j0x03.txt      | 24 -------
 3 files changed, 65 insertions(+), 55 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/panel/samsung,amoled-mipi-dsi.yaml
 delete mode 100644 Documentation/devicetree/bindings/display/panel/samsung,s6e3ha2.txt
 delete mode 100644 Documentation/devicetree/bindings/display/panel/samsung,s6e63j0x03.txt

diff --git a/Documentation/devicetree/bindings/display/panel/samsung,amoled-mipi-dsi.yaml b/Documentation/devicetree/bindings/display/panel/samsung,amoled-mipi-dsi.yaml
new file mode 100644
index 000000000000..96bdde9298e0
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/samsung,amoled-mipi-dsi.yaml
@@ -0,0 +1,65 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/samsung,amoled-mipi-dsi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung AMOLED MIPI-DSI panels
+
+maintainers:
+  - Hoegeun Kwon <hoegeun.kwon@samsung.com>
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    enum:
+        # Samsung S6E63J0X03 1.63" 320x320 AMOLED panel
+      - samsung,s6e63j0x03
+        # Samsung S6E3HA2 5.7" 1440x2560 AMOLED panel
+      - samsung,s6e3ha2
+        # Samsung S6E3HF2 5.65" 1600x2560 AMOLED panel
+      - samsung,s6e3hf2
+
+  reg: true
+  reset-gpios: true
+  enable-gpios: true
+  te-gpios: true
+
+  vdd3-supply:
+    description: I/O voltage supply
+
+  vci-supply:
+    description: voltage supply for analog circuits
+
+required:
+  - compatible
+  - reg
+  - vdd3-supply
+  - vci-supply
+  - reset-gpios
+  - enable-gpios
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
+        panel@0 {
+            compatible = "samsung,s6e3ha2";
+            reg = <0>;
+            vdd3-supply = <&ldo27_reg>;
+            vci-supply = <&ldo28_reg>;
+            reset-gpios = <&gpg0 0 GPIO_ACTIVE_LOW>;
+            enable-gpios = <&gpf1 5 GPIO_ACTIVE_HIGH>;
+            te-gpios = <&gpf1 3 GPIO_ACTIVE_HIGH>;
+        };
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/display/panel/samsung,s6e3ha2.txt b/Documentation/devicetree/bindings/display/panel/samsung,s6e3ha2.txt
deleted file mode 100644
index 4acea25c244b..000000000000
--- a/Documentation/devicetree/bindings/display/panel/samsung,s6e3ha2.txt
+++ /dev/null
@@ -1,31 +0,0 @@
-Samsung S6E3HA2 5.7" 1440x2560 AMOLED panel
-Samsung S6E3HF2 5.65" 1600x2560 AMOLED panel
-
-Required properties:
-  - compatible: should be one of:
-    "samsung,s6e3ha2",
-    "samsung,s6e3hf2".
-  - reg: the virtual channel number of a DSI peripheral
-  - vdd3-supply: I/O voltage supply
-  - vci-supply: voltage supply for analog circuits
-  - reset-gpios: a GPIO spec for the reset pin (active low)
-  - enable-gpios: a GPIO spec for the panel enable pin (active high)
-
-Optional properties:
-  - te-gpios: a GPIO spec for the tearing effect synchronization signal
-    gpio pin (active high)
-
-Example:
-&dsi {
-	...
-
-	panel@0 {
-		compatible = "samsung,s6e3ha2";
-		reg = <0>;
-		vdd3-supply = <&ldo27_reg>;
-		vci-supply = <&ldo28_reg>;
-		reset-gpios = <&gpg0 0 GPIO_ACTIVE_LOW>;
-		enable-gpios = <&gpf1 5 GPIO_ACTIVE_HIGH>;
-		te-gpios = <&gpf1 3 GPIO_ACTIVE_HIGH>;
-	};
-};
diff --git a/Documentation/devicetree/bindings/display/panel/samsung,s6e63j0x03.txt b/Documentation/devicetree/bindings/display/panel/samsung,s6e63j0x03.txt
deleted file mode 100644
index 3f1a8392af7f..000000000000
--- a/Documentation/devicetree/bindings/display/panel/samsung,s6e63j0x03.txt
+++ /dev/null
@@ -1,24 +0,0 @@
-Samsung S6E63J0X03 1.63" 320x320 AMOLED panel (interface: MIPI-DSI command mode)
-
-Required properties:
-  - compatible: "samsung,s6e63j0x03"
-  - reg: the virtual channel number of a DSI peripheral
-  - vdd3-supply: I/O voltage supply
-  - vci-supply: voltage supply for analog circuits
-  - reset-gpios: a GPIO spec for the reset pin (active low)
-  - te-gpios: a GPIO spec for the tearing effect synchronization signal
-    gpio pin (active high)
-
-Example:
-&dsi {
-	...
-
-	panel@0 {
-		compatible = "samsung,s6e63j0x03";
-		reg = <0>;
-		vdd3-supply = <&ldo16_reg>;
-		vci-supply = <&ldo20_reg>;
-		reset-gpios = <&gpe0 1 GPIO_ACTIVE_LOW>;
-		te-gpios = <&gpx0 6 GPIO_ACTIVE_HIGH>;
-	};
-};
-- 
2.20.1

