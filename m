Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC59D185CFC
	for <lists+linux-spi@lfdr.de>; Sun, 15 Mar 2020 14:45:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728687AbgCONpQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 15 Mar 2020 09:45:16 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39841 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728668AbgCONpQ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 15 Mar 2020 09:45:16 -0400
Received: by mail-lf1-f67.google.com with SMTP id j15so11739555lfk.6;
        Sun, 15 Mar 2020 06:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B3b7v3jOY+BEoITyEXppKyuNdMXph+o8yVRg4fC4u8I=;
        b=ZZRgEYtfMwf8hny9XTolYcMHHBBtuR8qClGcSjJfqHToyZOJ4RqB3R5wM/xen1SHXi
         WrTy0Ms+W5rCEdgJ0+hTMdsirV9opKmO+yk2INO0z6giusoSZTdgimlL431MUbxh+Jgy
         o1njPeOpjedD5wwPz1aEaqF0VZHUG9FyY34zAgtFNYQFpGyJtU04Huzd1+sHBnEMulwP
         aLyqdKw01/WCit7qD6wHV4D1pKuA8nbsyca92ZGxnwJ6hG5GTAF0wOaTDC9o/yQlQALl
         6IgfpxFFf1xSr0QGu0vSuLK+ss3lhgCiYH5kZnrLx9qW76tAzqGMYdTl65y9hybyD8Q5
         53Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=B3b7v3jOY+BEoITyEXppKyuNdMXph+o8yVRg4fC4u8I=;
        b=MZtFTHPKT7uI/6ecNR1xDtbXZ834WKmkA6NEoNSuwqYI2MQc9LPl2y3CXCno4spBnb
         +scbdYZ+7VfiqSc16++FXIASVnkZkYwhIfLA/iMLO7a68Ec/NlnK9op0M1rZt7Low/h+
         8ChiOaGPm4Au5JiLNj8la53tToF3xHlpg7P09JK0aH9LDNv5edNZBQbketiFCp0+OjX0
         bY2Cf+p0miF288qR5IA2/xDeeGFuhVmf5venppJ71YDybslBLaJqdyNi00e59WnpM98p
         +Cfi6NJox/vCNLoh7cDiclGnRjL7gUlxJBq/881WfKr0lubEXVYftm22LJBwh7YnN45D
         tCEA==
X-Gm-Message-State: ANhLgQ21set8FOQ4RFdzV7cf38IYHWsQ65jUHq1M33B9HWrj90cAWMZZ
        pNgwSdDw78WM6+yAXKv+N5o=
X-Google-Smtp-Source: ADFU+vs5SZ0RjLxx/mcXO1vlxdkNPH3sSNPKwNq5nPrIwT5rKIrQAIVis04WnsLYjPbxsvfuIfaWxA==
X-Received: by 2002:a19:9d0:: with SMTP id 199mr412715lfj.175.1584279912362;
        Sun, 15 Mar 2020 06:45:12 -0700 (PDT)
Received: from saturn.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id a9sm23025212lfb.21.2020.03.15.06.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2020 06:45:11 -0700 (PDT)
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
Subject: [PATCH v1 21/36] dt-bindings: display: convert samsung,s6d16d0 to DT Schema
Date:   Sun, 15 Mar 2020 14:44:01 +0100
Message-Id: <20200315134416.16527-22-sam@ravnborg.org>
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
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
---
 .../display/panel/samsung,s6d16d0.txt         | 30 ----------
 .../display/panel/samsung,s6d16d0.yaml        | 56 +++++++++++++++++++
 2 files changed, 56 insertions(+), 30 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/panel/samsung,s6d16d0.txt
 create mode 100644 Documentation/devicetree/bindings/display/panel/samsung,s6d16d0.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/samsung,s6d16d0.txt b/Documentation/devicetree/bindings/display/panel/samsung,s6d16d0.txt
deleted file mode 100644
index b94e366f451b..000000000000
--- a/Documentation/devicetree/bindings/display/panel/samsung,s6d16d0.txt
+++ /dev/null
@@ -1,30 +0,0 @@
-Samsung S6D16D0 4" 864x480 AMOLED panel
-
-Required properties:
-  - compatible: should be:
-    "samsung,s6d16d0",
-  - reg: the virtual channel number of a DSI peripheral
-  - vdd1-supply: I/O voltage supply
-  - reset-gpios: a GPIO spec for the reset pin (active low)
-
-The device node can contain one 'port' child node with one child
-'endpoint' node, according to the bindings defined in
-media/video-interfaces.txt. This node should describe panel's video bus.
-
-Example:
-&dsi {
-	...
-
-	panel@0 {
-		compatible = "samsung,s6d16d0";
-		reg = <0>;
-		vdd1-supply = <&foo>;
-		reset-gpios = <&foo_gpio 0 GPIO_ACTIVE_LOW>;
-
-		port {
-			panel_in: endpoint {
-				remote-endpoint = <&dsi_out>;
-			};
-		};
-	};
-};
diff --git a/Documentation/devicetree/bindings/display/panel/samsung,s6d16d0.yaml b/Documentation/devicetree/bindings/display/panel/samsung,s6d16d0.yaml
new file mode 100644
index 000000000000..66d147496bc3
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/samsung,s6d16d0.yaml
@@ -0,0 +1,56 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/samsung,s6d16d0.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung S6D16D0 4" 864x480 AMOLED panel
+
+maintainers:
+  - Linus Walleij <linus.walleij@linaro.org>
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    const: samsung,s6d16d0
+
+  port: true
+  reg: true
+  reset-gpios: true
+
+  vdd1-supply:
+    description: I/O voltage supply
+
+required:
+  - compatible
+  - reg
+  - vdd1-supply
+  - reset-gpios
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
+            compatible = "samsung,s6d16d0";
+            reg = <0>;
+            vdd1-supply = <&foo>;
+            reset-gpios = <&foo_gpio 0 GPIO_ACTIVE_LOW>;
+
+            port {
+                panel_in: endpoint {
+                    remote-endpoint = <&dsi_out>;
+                };
+            };
+        };
+    };
+
+...
-- 
2.20.1

