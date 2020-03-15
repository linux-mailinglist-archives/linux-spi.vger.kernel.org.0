Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D7A8185D10
	for <lists+linux-spi@lfdr.de>; Sun, 15 Mar 2020 14:45:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728695AbgCONp3 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 15 Mar 2020 09:45:29 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:42525 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728628AbgCONp3 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 15 Mar 2020 09:45:29 -0400
Received: by mail-lf1-f66.google.com with SMTP id t21so11695071lfe.9;
        Sun, 15 Mar 2020 06:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aR/Y4J4Ng2nITnp6C8iQx7gJZtioK1x7f06y6fKkYkk=;
        b=ZMRhjKqUaC80StOG54UvNQgF+2E0CQ3QZOhh5eJ/xi7zKaFNawvj7dSxdg11bFH2gA
         lwE020oqkVe2MCC2OXxDACEVJ31ssC2nyWfhXD3SOi51tc6UJxfjDc8Vh6b+22NMxReX
         qlDpVcdTszxMiuB089pkzcWwFGC6LN+80sCozrzJtRfNpT+gqIDPrYxRQ/d2okiGzYlh
         Fm/fjoIHFWZDhHGiZqniB2oH5BcnZoV6Yv4Fyl0TvnbiHTP5tQti///Wsm36aNjvNU3H
         5jr8HiMF5ORYQPTsamwC6osPs2L7BXDu0uthtdgUEwL/+AUSWbkpKilgLVD3HpUWqunf
         3V7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=aR/Y4J4Ng2nITnp6C8iQx7gJZtioK1x7f06y6fKkYkk=;
        b=alnH/IwiKzQqeVYBBXIzdtqx3bFNXteEpy3/pUvy6Siob0Kpcf+IXYr1G0x9epX+zZ
         3VBfbcw8Blsp/17WJtj/DonE6UuZB7NJ3Dtc3AzYVQQ2rDL8EJ4Y7g11vaTwk1cIvl55
         DOpyVs4WE3Mq6fd/MNwC6OhWkrHmNXLkyyXWBRAPEBieHlB4JMHGRCDmKL85Tx7YXMNP
         aMvv0pfRP4JRyG9832DIFVBk2DJpL5C1PDkV8HUUfWPMbjxfjnKeqUAEF5IT0a7jeJoQ
         deGaWvVEJulLKOmlYrJzEB61J5nLFt3G2Zg+aZW3icUGl63W9YqSvPpmvVkwl3XAvLiY
         L5Gg==
X-Gm-Message-State: ANhLgQ2K+L9ckplnKDxNlS/6nuEWRZrjtJIbRN1W3ovzTZ7rkIrA/J6l
        ZObj67XlRV5gZ7vrYrz0uhE=
X-Google-Smtp-Source: ADFU+vsiDKQKYVVpPhUH+Vnj06nnM5ycCAm89/6lk2djQ+UTdRQdN3NDg0MtLJIY1xx1om9ZRncTvQ==
X-Received: by 2002:a19:c34e:: with SMTP id t75mr13297771lff.197.1584279926572;
        Sun, 15 Mar 2020 06:45:26 -0700 (PDT)
Received: from saturn.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id a9sm23025212lfb.21.2020.03.15.06.45.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2020 06:45:26 -0700 (PDT)
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
Subject: [PATCH v1 28/36] dt-bindings: display: convert sitronix,st7789v to DT Schema
Date:   Sun, 15 Mar 2020 14:44:08 +0100
Message-Id: <20200315134416.16527-29-sam@ravnborg.org>
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
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
---
 .../display/panel/sitronix,st7789v.txt        | 37 ------------
 .../display/panel/sitronix,st7789v.yaml       | 58 +++++++++++++++++++
 2 files changed, 58 insertions(+), 37 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/panel/sitronix,st7789v.txt
 create mode 100644 Documentation/devicetree/bindings/display/panel/sitronix,st7789v.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/sitronix,st7789v.txt b/Documentation/devicetree/bindings/display/panel/sitronix,st7789v.txt
deleted file mode 100644
index c6995dde641b..000000000000
--- a/Documentation/devicetree/bindings/display/panel/sitronix,st7789v.txt
+++ /dev/null
@@ -1,37 +0,0 @@
-Sitronix ST7789V RGB panel with SPI control bus
-
-Required properties:
-  - compatible: "sitronix,st7789v"
-  - reg: Chip select of the panel on the SPI bus
-  - reset-gpios: a GPIO phandle for the reset pin
-  - power-supply: phandle of the regulator that provides the supply voltage
-
-Optional properties:
-  - backlight: phandle to the backlight used
-
-The generic bindings for the SPI slaves documented in [1] also applies
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
-panel@0 {
-	compatible = "sitronix,st7789v";
-	reg = <0>;
-	reset-gpios = <&pio 6 11 GPIO_ACTIVE_LOW>;
-	backlight = <&pwm_bl>;
-	spi-max-frequency = <100000>;
-	spi-cpol;
-	spi-cpha;
-
-	port {
-		panel_input: endpoint {
-			remote-endpoint = <&tcon0_out_panel>;
-		};
-	};
-};
diff --git a/Documentation/devicetree/bindings/display/panel/sitronix,st7789v.yaml b/Documentation/devicetree/bindings/display/panel/sitronix,st7789v.yaml
new file mode 100644
index 000000000000..493006a52c5e
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/sitronix,st7789v.yaml
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/sitronix,st7789v.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sitronix ST7789V RGB panel with SPI control bus
+
+maintainers:
+  - Maxime Ripard <mripard@kernel.org>
+
+allOf:
+  - $ref: panel-common.yaml#
+  - $ref: ../../spi/spi-slave.yaml#
+
+properties:
+  compatible:
+    const: sitronix,st7789v
+
+  reg: true
+  reset-gpios: true
+  power-supply: true
+  backlight: true
+  port: true
+
+required:
+  - compatible
+  - reg
+  - reset-gpios
+  - power-supply
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
+            compatible = "sitronix,st7789v";
+            reg = <0>;
+            reset-gpios = <&pio 6 11 GPIO_ACTIVE_LOW>;
+            backlight = <&pwm_bl>;
+            power-supply = <&power>;
+            spi-max-frequency = <100000>;
+            spi-cpol;
+            spi-cpha;
+
+            port {
+                panel_input: endpoint {
+                    remote-endpoint = <&tcon0_out_panel>;
+                };
+            };
+        };
+    };
+
+...
-- 
2.20.1

