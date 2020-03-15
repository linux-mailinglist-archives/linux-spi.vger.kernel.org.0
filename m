Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E633185D1A
	for <lists+linux-spi@lfdr.de>; Sun, 15 Mar 2020 14:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728707AbgCONpg (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 15 Mar 2020 09:45:36 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35159 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728701AbgCONpg (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 15 Mar 2020 09:45:36 -0400
Received: by mail-lf1-f68.google.com with SMTP id 5so4602111lfr.2;
        Sun, 15 Mar 2020 06:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=toNvd5WCF3GFjyOE6moNJQWMcvQ9HoQ7rB2BNOsqJDw=;
        b=tpI7Glt5hnpU4DaQC7X+FIHxMbU2wT+uyBW3nSDxWJMZc2f7D0qNvdS6sofzEUKxBI
         6FOemqXL6eGmbN2b1gZ+6zPGMqqgrahUx8RyW7D1InHNeONtx4acIqIrvG1RhBJf4LvL
         Utk9f4vmHuR5HWDRluxHcuc1xuQi4Ywhd+ZXORgInjl5G3+v4lBVochLJeF4N4zgXEfi
         M7Mv9WLiL5FZtuI77NDMITpOSkxnf+k0veDQGfJlulwzIHbLl+4wW147EuQ9xodvL6tS
         1jzYm0O9IFkzLZNVvQ/rJy/KXko98ms2CFwanD5qd/9B3C1o8sgoZ4lEPztesCuWjY7A
         5o6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=toNvd5WCF3GFjyOE6moNJQWMcvQ9HoQ7rB2BNOsqJDw=;
        b=c8AM4m4d584xVDuv+2NOYaw49QPTVKveWbif6NSSZrTStJEhAPdPp8WGANCU+Pm2Mw
         dpYjkmIAeKcO+IWHo71YWZDqlVj1DxUmA6wmBL0gCANTw6w1dhZbDqImAt4t+fPwab7q
         9u2sQBkzpoorrdnCmLXUyV7hMNfpXDlOkGuU5Ep0pUSGp7D2mXHR6zaBH47G+P2xi8DH
         9eqZ37eDmOxQteKlcBFw0FLiO7zjZ95Vvwqs7x3QYyomU+gba30cgLalZk7Xq7QBLUQd
         ehxYBbyGuDw441gkjkXxEniRyMbUdPxGfOUOPr0R2YTmNSc1d6V7toHMfHn8UI1mk09k
         CMOQ==
X-Gm-Message-State: ANhLgQ0BLNDV51W1NY9uHyUY6zzR7we5249drak4M/jfMPh3jMldQzkL
        IS/qn+CjFvueJbAxP+yHARM=
X-Google-Smtp-Source: ADFU+vtO0ISVT9WRNKB1NwfMIOS6r4vjvczsImL2D5nQyMFJBkIyabieO2xRhae4WYedOTQRWxrJww==
X-Received: by 2002:ac2:46d9:: with SMTP id p25mr6091534lfo.174.1584279932730;
        Sun, 15 Mar 2020 06:45:32 -0700 (PDT)
Received: from saturn.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id a9sm23025212lfb.21.2020.03.15.06.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2020 06:45:32 -0700 (PDT)
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
Subject: [PATCH v1 31/36] dt-bindings: display: convert sharp,lq101r1sx01 to DT Schema
Date:   Sun, 15 Mar 2020 14:44:11 +0100
Message-Id: <20200315134416.16527-32-sam@ravnborg.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200315134416.16527-1-sam@ravnborg.org>
References: <20200315134416.16527-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This bindings describes a panel with a secondary channel.

A few of the properties are only required for the
main (non-secondary) node.
This is properly described in the binding.

A few properties are only valid for the main node,
this is not described in the binding.
I failed to find a way to describe it.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
---
 .../display/panel/sharp,lq101r1sx01.txt       | 49 ------------
 .../display/panel/sharp,lq101r1sx01.yaml      | 78 +++++++++++++++++++
 2 files changed, 78 insertions(+), 49 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/panel/sharp,lq101r1sx01.txt
 create mode 100644 Documentation/devicetree/bindings/display/panel/sharp,lq101r1sx01.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/sharp,lq101r1sx01.txt b/Documentation/devicetree/bindings/display/panel/sharp,lq101r1sx01.txt
deleted file mode 100644
index f522bb8e47e1..000000000000
--- a/Documentation/devicetree/bindings/display/panel/sharp,lq101r1sx01.txt
+++ /dev/null
@@ -1,49 +0,0 @@
-Sharp Microelectronics 10.1" WQXGA TFT LCD panel
-
-This panel requires a dual-channel DSI host to operate. It supports two modes:
-- left-right: each channel drives the left or right half of the screen
-- even-odd: each channel drives the even or odd lines of the screen
-
-Each of the DSI channels controls a separate DSI peripheral. The peripheral
-driven by the first link (DSI-LINK1), left or even, is considered the primary
-peripheral and controls the device. The 'link2' property contains a phandle
-to the peripheral driven by the second link (DSI-LINK2, right or odd).
-
-Note that in video mode the DSI-LINK1 interface always provides the left/even
-pixels and DSI-LINK2 always provides the right/odd pixels. In command mode it
-is possible to program either link to drive the left/even or right/odd pixels
-but for the sake of consistency this binding assumes that the same assignment
-is chosen as for video mode.
-
-Required properties:
-- compatible: should be "sharp,lq101r1sx01"
-- reg: DSI virtual channel of the peripheral
-
-Required properties (for DSI-LINK1 only):
-- link2: phandle to the DSI peripheral on the secondary link. Note that the
-  presence of this property marks the containing node as DSI-LINK1.
-- power-supply: phandle of the regulator that provides the supply voltage
-
-Optional properties (for DSI-LINK1 only):
-- backlight: phandle of the backlight device attached to the panel
-
-Example:
-
-	dsi@54300000 {
-		panel: panel@0 {
-			compatible = "sharp,lq101r1sx01";
-			reg = <0>;
-
-			link2 = <&secondary>;
-
-			power-supply = <...>;
-			backlight = <...>;
-		};
-	};
-
-	dsi@54400000 {
-		secondary: panel@0 {
-			compatible = "sharp,lq101r1sx01";
-			reg = <0>;
-		};
-	};
diff --git a/Documentation/devicetree/bindings/display/panel/sharp,lq101r1sx01.yaml b/Documentation/devicetree/bindings/display/panel/sharp,lq101r1sx01.yaml
new file mode 100644
index 000000000000..81bbd8872110
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/sharp,lq101r1sx01.yaml
@@ -0,0 +1,78 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/sharp,lq101r1sx01.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sharp Microelectronics 10.1" WQXGA TFT LCD panel
+
+maintainers:
+  - Thierry Reding <treding@nvidia.com>
+
+description: |
+  This panel requires a dual-channel DSI host to operate. It supports two modes:
+  - left-right: each channel drives the left or right half of the screen
+  - even-odd: each channel drives the even or odd lines of the screen
+
+  Each of the DSI channels controls a separate DSI peripheral. The peripheral
+  driven by the first link (DSI-LINK1), left or even, is considered the primary
+  peripheral and controls the device. The 'link2' property contains a phandle
+  to the peripheral driven by the second link (DSI-LINK2, right or odd).
+
+  Note that in video mode the DSI-LINK1 interface always provides the left/even
+  pixels and DSI-LINK2 always provides the right/odd pixels. In command mode it
+  is possible to program either link to drive the left/even or right/odd pixels
+  but for the sake of consistency this binding assumes that the same assignment
+  is chosen as for video mode.
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    const: sharp,lq101r1sx01
+
+  reg: true
+  power-supply: true
+  backlight: true
+
+  link2:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: |
+      phandle to the DSI peripheral on the secondary link. Note that the
+      presence of this property marks the containing node as DSI-LINK1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    dsi0 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        panel: panel@0 {
+            compatible = "sharp,lq101r1sx01";
+            reg = <0>;
+
+            link2 = <&secondary>;
+
+            power-supply = <&power>;
+            backlight = <&backlight>;
+        };
+    };
+
+    dsi1 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        secondary: panel@0 {
+            compatible = "sharp,lq101r1sx01";
+            reg = <0>;
+        };
+    };
+
+...
-- 
2.20.1

