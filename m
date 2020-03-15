Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06CAB185D02
	for <lists+linux-spi@lfdr.de>; Sun, 15 Mar 2020 14:45:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728691AbgCONpT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 15 Mar 2020 09:45:19 -0400
Received: from mail-lf1-f53.google.com ([209.85.167.53]:43661 "EHLO
        mail-lf1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728628AbgCONpT (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 15 Mar 2020 09:45:19 -0400
Received: by mail-lf1-f53.google.com with SMTP id n20so8370218lfl.10;
        Sun, 15 Mar 2020 06:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TqzV4MPdGVVHtAbugCExEo6BeL07NygrdK5YIjL8Q/Q=;
        b=dXQt7AGuwc5V9REUW5Z/BBdiBkSKwLQwbg4RhHFwHmnsj9qqkS0N+eaRpnVv91Xswp
         3HPYvO6UiXicDHMvWI6VMzDyiZJyaPVTFn62wWXJz0GYD2bWymPB8Rrgu3sDZPN69sjg
         HygvkLiTtrJsI13b8EC3cegkkOeEdZQBrChneNlFCWJWEJB2iYfSD9/M87RZVjHbIF+A
         4aXL+6j5Is9ElbqjvDFJbePAQjfvyi4UFpr6Xm3uPL/6et7U4wxATqdFIXSSGwkcLVA/
         vk+BIXrB5sLR0fhIu8OAyKUstG2CZlxy1MVH3gn6nOqegxUfluR4UjU2Wr+d4GUOcRcv
         X/CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=TqzV4MPdGVVHtAbugCExEo6BeL07NygrdK5YIjL8Q/Q=;
        b=uQQ0A1TIwJ3xP/4xWwQa7NvIKOvw9O8b9y3jjYItvVYSV3xftAAJi3DAoGHIDIHsgB
         4bbYstOx8pH/OQBSfc6y+Nhy83zmnRw2i0NMcfdxCIglvZdOsL3HBclZLtMXCORcLJgJ
         g1GWDBLrYLr5JhtgNtwdKmlMB3Q0gF7SjlD6mphr6BJhUZylAs6uJjMEu7cLnDRNLy1u
         ff0t2cmgnnDWl3oygDU95p3XOuDSeb1lEzN/5wcuDfYekhy9xNl360BZxBpyOr3zsb8e
         0juj+LkMFd9n2hUY7v/l97UnEpiJWnD0ssk8S+bHVEgkLsUJGXZcnVC/z5QYHJThB/lb
         Kf6g==
X-Gm-Message-State: ANhLgQ2SK1Z5u0T2ySkc2vnggsoCDg3aTxFzMzHAoUjmUl0LYbK6J/6w
        jsYcIwwxWqq2oxVHf8Vf550=
X-Google-Smtp-Source: ADFU+vu0JOaLN+blho9UeRs33tMvv92CEXdqGXr+VM2Ib3fRjFMQUEshIV2D6NrmhTenUrlwSaDoeg==
X-Received: by 2002:a19:6716:: with SMTP id b22mr836381lfc.46.1584279916357;
        Sun, 15 Mar 2020 06:45:16 -0700 (PDT)
Received: from saturn.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id a9sm23025212lfb.21.2020.03.15.06.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2020 06:45:15 -0700 (PDT)
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
Subject: [PATCH v1 23/36] dt-bindings: display: convert samsung,s6e8aa0 to DT Schema
Date:   Sun, 15 Mar 2020 14:44:03 +0100
Message-Id: <20200315134416.16527-24-sam@ravnborg.org>
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
 .../display/panel/samsung,s6e8aa0.txt         | 56 -----------
 .../display/panel/samsung,s6e8aa0.yaml        | 96 +++++++++++++++++++
 2 files changed, 96 insertions(+), 56 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/panel/samsung,s6e8aa0.txt
 create mode 100644 Documentation/devicetree/bindings/display/panel/samsung,s6e8aa0.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/samsung,s6e8aa0.txt b/Documentation/devicetree/bindings/display/panel/samsung,s6e8aa0.txt
deleted file mode 100644
index 9e766c5f86da..000000000000
--- a/Documentation/devicetree/bindings/display/panel/samsung,s6e8aa0.txt
+++ /dev/null
@@ -1,56 +0,0 @@
-Samsung S6E8AA0 AMOLED LCD 5.3 inch panel
-
-Required properties:
-  - compatible: "samsung,s6e8aa0"
-  - reg: the virtual channel number of a DSI peripheral
-  - vdd3-supply: core voltage supply
-  - vci-supply: voltage supply for analog circuits
-  - reset-gpios: a GPIO spec for the reset pin
-  - display-timings: timings for the connected panel as described by [1]
-
-Optional properties:
-  - power-on-delay: delay after turning regulators on [ms]
-  - reset-delay: delay after reset sequence [ms]
-  - init-delay: delay after initialization sequence [ms]
-  - panel-width-mm: physical panel width [mm]
-  - panel-height-mm: physical panel height [mm]
-  - flip-horizontal: boolean to flip image horizontally
-  - flip-vertical: boolean to flip image vertically
-
-The device node can contain one 'port' child node with one child
-'endpoint' node, according to the bindings defined in [2]. This
-node should describe panel's video bus.
-
-[1]: Documentation/devicetree/bindings/display/panel/display-timing.txt
-[2]: Documentation/devicetree/bindings/media/video-interfaces.txt
-
-Example:
-
-	panel {
-		compatible = "samsung,s6e8aa0";
-		reg = <0>;
-		vdd3-supply = <&vcclcd_reg>;
-		vci-supply = <&vlcd_reg>;
-		reset-gpios = <&gpy4 5 0>;
-		power-on-delay= <50>;
-		reset-delay = <100>;
-		init-delay = <100>;
-		panel-width-mm = <58>;
-		panel-height-mm = <103>;
-		flip-horizontal;
-		flip-vertical;
-
-		display-timings {
-			timing0: timing-0 {
-				clock-frequency = <57153600>;
-				hactive = <720>;
-				vactive = <1280>;
-				hfront-porch = <5>;
-				hback-porch = <5>;
-				hsync-len = <5>;
-				vfront-porch = <13>;
-				vback-porch = <1>;
-				vsync-len = <2>;
-			};
-		};
-	};
diff --git a/Documentation/devicetree/bindings/display/panel/samsung,s6e8aa0.yaml b/Documentation/devicetree/bindings/display/panel/samsung,s6e8aa0.yaml
new file mode 100644
index 000000000000..67c99b0492e5
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/samsung,s6e8aa0.yaml
@@ -0,0 +1,96 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/samsung,s6e8aa0.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung S6E8AA0 AMOLED LCD 5.3 inch panel
+
+maintainers:
+  - Andrzej Hajda <a.hajda@samsung.com>
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    const: samsung,s6e8aa0
+
+  reg: true
+  reset-gpios: true
+  display-timings: true
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
+  init-delay:
+    description: delay after initialization sequence [ms]
+
+  panel-width-mm:
+    description: physical panel width [mm]
+
+  panel-height-mm:
+    description: physical panel height [mm]
+
+  flip-horizontal:
+    description: boolean to flip image horizontally
+
+  flip-vertical:
+    description: boolean to flip image vertically
+
+required:
+  - compatible
+  - reg
+  - vdd3-supply 
+  - vci-supply
+  - reset-gpios
+  - display-timings
+
+additionalProperties: false
+
+examples:
+  - |
+    dsi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        panel {
+            compatible = "samsung,s6e8aa0";
+            reg = <0>;
+            vdd3-supply = <&vcclcd_reg>;
+            vci-supply = <&vlcd_reg>;
+            reset-gpios = <&gpy4 5 0>;
+            power-on-delay= <50>;
+            reset-delay = <100>;
+            init-delay = <100>;
+            panel-width-mm = <58>;
+            panel-height-mm = <103>;
+            flip-horizontal;
+            flip-vertical;
+
+            display-timings {
+                timing0: timing-0 {
+                    clock-frequency = <57153600>;
+                    hactive = <720>;
+                    vactive = <1280>;
+                    hfront-porch = <5>;
+                    hback-porch = <5>;
+                    hsync-len = <5>;
+                    vfront-porch = <13>;
+                    vback-porch = <1>;
+                    vsync-len = <2>;
+                };
+            };
+        };
+    };
+
+...
-- 
2.20.1

