Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED3D6185CE4
	for <lists+linux-spi@lfdr.de>; Sun, 15 Mar 2020 14:44:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728669AbgCONo7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 15 Mar 2020 09:44:59 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36966 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728664AbgCONo7 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 15 Mar 2020 09:44:59 -0400
Received: by mail-lj1-f196.google.com with SMTP id r24so15637458ljd.4;
        Sun, 15 Mar 2020 06:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tSotertszjUMedRD2Vfuz3bf57eHMzv0dgtIHvRY4pE=;
        b=q84CQRrzbFaUgbclub7n9i8HE11jCelZdW91ikDPW0qWyoEOnVhHbVEoCzcN119m8r
         BJkHcDvXPHaGXFusmTLJhgMetrZbnv56W6y5k0/lp+btY5x1BXTajNbLaT4BTJ5gxbjK
         3iHK4ym/zPpJlGagQ75FkKKdCoBUzr8jpxJjs5OmgfNKxxdPuBLjqwL45HQ4FecWNWDi
         MxxHYdpfSA5Nb9s6g/fuiSLZBUt2eL+WltpgQU7m0Yw7mrj5gH4jAraDc1wSALW7aq/y
         unKBvJu1jPVc7MZ82c1v/bxjxrCI6YO7Q9SLdggaVSu9uAQxJm25eBSneLCE1l4JOAaB
         cy/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=tSotertszjUMedRD2Vfuz3bf57eHMzv0dgtIHvRY4pE=;
        b=q/vn7JGmWrg88hiXZxDY1GLW3FEa8DRiKEYrVGqwx3F+/w5eUKlhqyMansnhmJVGKP
         R15Mf2pckzZ5ZH3u5oLr96owzdnECjj+ZBPgHSU61e16Rlk965adm4ofbUNrFzLeL9w7
         UDMs3DR88Bkty1Ue1coF409ik1vYHGgrXfuHVAaWoabTKrxy4YJ0Qjk7tMStDmRAfCbm
         zK7X36Uhudz9HPHHNLiGugeWxmzy43Yxwo9BGInH2xmPo2OVsDAIqCLE6LITNsoDt6dE
         dJk0GcDXGCmNgDqtO+O7qhPPq1CoibORaIOgHsrovKqKQQSy/LAfQU8bgEXS6Z6y2LXc
         ZhUQ==
X-Gm-Message-State: ANhLgQ1qGF42inuaoUVBBHMUAmrcGO8bLKwegyfXsufrEAT7FhFpsWkd
        vMY420ovcqZOLlibAuPPBL0=
X-Google-Smtp-Source: ADFU+vupX6Yo38VsCs3py6kXA/mvB4+z4M+2UnehbCnmVP2r6tEA+pKmSkufcwFcSFL5CaCAEJ/R+g==
X-Received: by 2002:a2e:9091:: with SMTP id l17mr3120139ljg.154.1584279896075;
        Sun, 15 Mar 2020 06:44:56 -0700 (PDT)
Received: from saturn.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id a9sm23025212lfb.21.2020.03.15.06.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2020 06:44:55 -0700 (PDT)
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
Subject: [PATCH v1 13/36] dt-bindings: display: convert kingdisplay,kd035g6-54nt to DT Schema
Date:   Sun, 15 Mar 2020 14:43:53 +0100
Message-Id: <20200315134416.16527-14-sam@ravnborg.org>
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
Cc: Paul Cercueil <paul@crapouillou.net>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
---
 .../panel/kingdisplay,kd035g6-54nt.txt        | 42 -------------
 .../panel/kingdisplay,kd035g6-54nt.yaml       | 60 +++++++++++++++++++
 2 files changed, 60 insertions(+), 42 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/panel/kingdisplay,kd035g6-54nt.txt
 create mode 100644 Documentation/devicetree/bindings/display/panel/kingdisplay,kd035g6-54nt.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/kingdisplay,kd035g6-54nt.txt b/Documentation/devicetree/bindings/display/panel/kingdisplay,kd035g6-54nt.txt
deleted file mode 100644
index fa9596082e44..000000000000
--- a/Documentation/devicetree/bindings/display/panel/kingdisplay,kd035g6-54nt.txt
+++ /dev/null
@@ -1,42 +0,0 @@
-King Display KD035G6-54NT 3.5" (320x240 pixels) 24-bit TFT LCD panel
-
-Required properties:
-- compatible: should be "kingdisplay,kd035g6-54nt"
-- power-supply: See panel-common.txt
-- reset-gpios: See panel-common.txt
-
-Optional properties:
-- backlight: see panel-common.txt
-
-The generic bindings for the SPI slaves documented in [1] also apply.
-
-The device node can contain one 'port' child node with one child
-'endpoint' node, according to the bindings defined in [2]. This
-node should describe panel's video bus.
-
-[1]: Documentation/devicetree/bindings/spi/spi-bus.txt
-[2]: Documentation/devicetree/bindings/graph.txt
-
-Example:
-
-&spi {
-	panel@0 {
-		compatible = "kingdisplay,kd035g6-54nt";
-		reg = <0>;
-
-		spi-max-frequency = <3125000>;
-		spi-3wire;
-		spi-cs-high;
-
-		reset-gpios = <&gpe 2 GPIO_ACTIVE_LOW>;
-
-		backlight = <&backlight>;
-		power-supply = <&ldo6>;
-
-		port {
-			panel_input: endpoint {
-				remote-endpoint = <&panel_output>;
-			};
-		};
-	};
-};
diff --git a/Documentation/devicetree/bindings/display/panel/kingdisplay,kd035g6-54nt.yaml b/Documentation/devicetree/bindings/display/panel/kingdisplay,kd035g6-54nt.yaml
new file mode 100644
index 000000000000..31fc63294a9f
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/kingdisplay,kd035g6-54nt.yaml
@@ -0,0 +1,60 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/kingdisplay,kd035g6-54nt.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: King Display KD035G6-54NT 3.5" (320x240 pixels) 24-bit TFT LCD panel
+
+maintainers:
+  - Paul Cercueil <paul@crapouillou.net>
+
+allOf:
+  - $ref: ../../spi/spi-slave.yaml#
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    const: kingdisplay,kd035g6-54nt
+
+  backlight: true
+  port: true
+  power-supply: true
+  reg: true
+  reset-gpios: true
+
+required:
+  - compatible
+  - power-supply
+  - reset-gpios
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        panel@0 {
+            compatible = "kingdisplay,kd035g6-54nt";
+            reg = <0>;
+
+            spi-max-frequency = <3125000>;
+            spi-3wire;
+            spi-cs-high;
+
+            reset-gpios = <&gpe 2 GPIO_ACTIVE_LOW>;
+
+            backlight = <&backlight>;
+            power-supply = <&ldo6>;
+
+            port {
+                panel_input: endpoint {
+                    remote-endpoint = <&panel_output>;
+                };
+            };
+        };
+    };
+
+...
-- 
2.20.1

