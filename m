Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8A69185CFF
	for <lists+linux-spi@lfdr.de>; Sun, 15 Mar 2020 14:45:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728690AbgCONpT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 15 Mar 2020 09:45:19 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39035 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728668AbgCONpT (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 15 Mar 2020 09:45:19 -0400
Received: by mail-lj1-f194.google.com with SMTP id f10so15604341ljn.6;
        Sun, 15 Mar 2020 06:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=95/tYrFLxFWhHQedTIuiprVnYZuYF3knH69CjqDuvg4=;
        b=kVkFO0dZn3WY2eMdLtNyuUxKYmVfl5GkIYSSGuVnSVLwfS7on2M58zQL/nGUG1V6W6
         KOPElrjpPlI3MYCbvm8oiDtkivrOfLK0wD5olkxHasi8wp5yStO5MJUKwxW4N2+56vEl
         9SJ6aj5TLkVhBTe+OnB68MnD2QYhQTYONHmVpzs6rbf+QYn7haf7iiAwe+Byt+M1gVYR
         aLQDOzcS6djblQkcKg6VbWUSbWcALHd+nu7VuNCO7/D1kzH0Aow495hmSMovYWMXmW0o
         92P+Qu03iJ57nRtDk9+6a6fHVx3kIdJIKOPbcu5k4SLWQ1l8rIzuVp/v9HKFf4m9xFkJ
         wU5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=95/tYrFLxFWhHQedTIuiprVnYZuYF3knH69CjqDuvg4=;
        b=oDiHdruZj/ttpWQpkoJ9RZi9eisZZ8/yTiCUDYXiyN/hzqIJo5hmOOsh9MvbBgwUfh
         zNc73OhzN7yfvXtqMDYpA9FvQyUcik2UnIskU1GHsU+JkSK/Y0xDovFZd334k4OPuaeE
         mlGqtMAiREH6wqypXCd6R1BuVgHHwr17WBMAFIvvWy8vvqotc8tYMhjcUmuqfV/51NTa
         srTAKOWnyv0F2GoIxKtNqbzpOpfrA1VkrO0nXQfxFNLfS/qf7/xXUXAPUId7KJPZlO8x
         gcL/f+oN9oOBZQNWf3WLBYQqrZdpYzUSRchCeap6fEuSUgOOlLcmPIUZ1vB+rH0KPg7H
         /szw==
X-Gm-Message-State: ANhLgQ0tRZFSL43JuGJ9SRt2ZiT3QQbqiOU1bAaKS3Tz1k4dqQopgGhK
        +ta2gUHBgX26vFeByFwl7C8=
X-Google-Smtp-Source: ADFU+vvAb04MLDJqI6lPeN8wJHT/HuiV0E9v6XPvtroLZweI21bVO9Nmr0Oyc6ieS+LchZ7g0jnh2Q==
X-Received: by 2002:a2e:870b:: with SMTP id m11mr3056178lji.109.1584279914394;
        Sun, 15 Mar 2020 06:45:14 -0700 (PDT)
Received: from saturn.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id a9sm23025212lfb.21.2020.03.15.06.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2020 06:45:13 -0700 (PDT)
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
Subject: [PATCH v1 22/36] dt-bindings: display: convert samsung,ld9040 to DT Schema
Date:   Sun, 15 Mar 2020 14:44:02 +0100
Message-Id: <20200315134416.16527-23-sam@ravnborg.org>
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
Cc: Andrzej Hajda <a.hajda@samsung.com>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
---
 .../bindings/display/panel/samsung,ld9040.txt |  66 ------------
 .../display/panel/samsung,ld9040.yaml         | 100 ++++++++++++++++++
 2 files changed, 100 insertions(+), 66 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/panel/samsung,ld9040.txt
 create mode 100644 Documentation/devicetree/bindings/display/panel/samsung,ld9040.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/samsung,ld9040.txt b/Documentation/devicetree/bindings/display/panel/samsung,ld9040.txt
deleted file mode 100644
index 354d4d1df4ff..000000000000
--- a/Documentation/devicetree/bindings/display/panel/samsung,ld9040.txt
+++ /dev/null
@@ -1,66 +0,0 @@
-Samsung LD9040 AMOLED LCD parallel RGB panel with SPI control bus
-
-Required properties:
-  - compatible: "samsung,ld9040"
-  - reg: address of the panel on SPI bus
-  - vdd3-supply: core voltage supply
-  - vci-supply: voltage supply for analog circuits
-  - reset-gpios: a GPIO spec for the reset pin
-  - display-timings: timings for the connected panel according to [1]
-
-The panel must obey rules for SPI slave device specified in document [2].
-
-Optional properties:
-  - power-on-delay: delay after turning regulators on [ms]
-  - reset-delay: delay after reset sequence [ms]
-  - panel-width-mm: physical panel width [mm]
-  - panel-height-mm: physical panel height [mm]
-
-The device node can contain one 'port' child node with one child
-'endpoint' node, according to the bindings defined in [3]. This
-node should describe panel's video bus.
-
-[1]: Documentation/devicetree/bindings/display/panel/display-timing.txt
-[2]: Documentation/devicetree/bindings/spi/spi-bus.txt
-[3]: Documentation/devicetree/bindings/media/video-interfaces.txt
-
-Example:
-
-	lcd@0 {
-		compatible = "samsung,ld9040";
-		reg = <0>;
-		vdd3-supply = <&ldo7_reg>;
-		vci-supply = <&ldo17_reg>;
-		reset-gpios = <&gpy4 5 0>;
-		spi-max-frequency = <1200000>;
-		spi-cpol;
-		spi-cpha;
-		power-on-delay = <10>;
-		reset-delay = <10>;
-		panel-width-mm = <90>;
-		panel-height-mm = <154>;
-
-		display-timings {
-			timing {
-				clock-frequency = <23492370>;
-				hactive = <480>;
-				vactive = <800>;
-				hback-porch = <16>;
-				hfront-porch = <16>;
-				vback-porch = <2>;
-				vfront-porch = <28>;
-				hsync-len = <2>;
-				vsync-len = <1>;
-				hsync-active = <0>;
-				vsync-active = <0>;
-				de-active = <0>;
-				pixelclk-active = <0>;
-			};
-		};
-
-		port {
-			lcd_ep: endpoint {
-				remote-endpoint = <&fimd_dpi_ep>;
-			};
-		};
-	};
diff --git a/Documentation/devicetree/bindings/display/panel/samsung,ld9040.yaml b/Documentation/devicetree/bindings/display/panel/samsung,ld9040.yaml
new file mode 100644
index 000000000000..b6e7e87411e8
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/samsung,ld9040.yaml
@@ -0,0 +1,100 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/samsung,ld9040.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung LD9040 AMOLED LCD parallel RGB panel with SPI control bus
+
+maintainers:
+  - Andrzej Hajda <a.hajda@samsung.com>
+
+allOf:
+  - $ref: ../../spi/spi-slave.yaml#
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    const: samsung,ld9040
+
+  display-timings: true
+  port: true
+  reg: true
+  reset-gpios: true
+
+  vdd3-supply:
+    description: core voltage supply
+
+  vci-supply:
+    description: voltage supply for analog circuits
+
+  power-on-delay:
+    description: delay after turning regulators on [ms]
+
+  reset-delay:
+    description: delay after reset sequence [ms]
+
+  panel-width-mm:
+    description: physical panel width [mm]
+
+  panel-height-mm:
+    description: physical panel height [mm]
+
+required:
+  - compatible
+  - reg
+  - vdd3-supply
+  - vci-supply
+  - reset-gpios
+  - display-timings
+
+examples:
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        lcd@0 {
+            compatible = "samsung,ld9040";
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            reg = <0>;
+            vdd3-supply = <&ldo7_reg>;
+            vci-supply = <&ldo17_reg>;
+            reset-gpios = <&gpy4 5 0>;
+            spi-max-frequency = <1200000>;
+            spi-cpol;
+            spi-cpha;
+            power-on-delay = <10>;
+            reset-delay = <10>;
+            panel-width-mm = <90>;
+            panel-height-mm = <154>;
+
+            display-timings {
+                timing {
+                    clock-frequency = <23492370>;
+                    hactive = <480>;
+                    vactive = <800>;
+                    hback-porch = <16>;
+                    hfront-porch = <16>;
+                    vback-porch = <2>;
+                    vfront-porch = <28>;
+                    hsync-len = <2>;
+                    vsync-len = <1>;
+                    hsync-active = <0>;
+                    vsync-active = <0>;
+                    de-active = <0>;
+                    pixelclk-active = <0>;
+                };
+            };
+
+            port {
+                lcd_ep: endpoint {
+                    remote-endpoint = <&fimd_dpi_ep>;
+                };
+            };
+        };
+    };
+
+...
-- 
2.20.1

