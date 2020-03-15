Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42823185D04
	for <lists+linux-spi@lfdr.de>; Sun, 15 Mar 2020 14:45:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728692AbgCONpV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 15 Mar 2020 09:45:21 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42516 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728688AbgCONpV (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 15 Mar 2020 09:45:21 -0400
Received: by mail-lf1-f68.google.com with SMTP id t21so11694874lfe.9;
        Sun, 15 Mar 2020 06:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ghUynx34Se1PWQlxUuq3M8AKFCN6cEMd2e8sZ7qxkGY=;
        b=pXX4HARMlo/xxLmk/Ribpq3UuFfXvqrQ9jU2j13Y9h6stHodmEt1h+dfHlxMt9L57z
         SEBzTJDGTz+G+YRegd+ZgxU8hAa2OaSfKgDZz30lTHQ96Bprky335XWloIRBjLb9gg2d
         lIQuIbWcAQNAhfOl5eo5MZgNdoQ0XaE2vDt5N3r2iT9MOBtm8xR/J0LyO3W8Sla21jZx
         yOf1Q+FyoqUDj/2FJ4Q7U26s5gxEJDyk4huESC2qjhA2e5dc903i5Inv23gUj+l40Ex/
         BDBJoJ0Ojk4RV00rd3B9eejNCkx1QjY9MGoixSN0TEJ0e8X0FriBJg1HOrL7Ckqy5mWD
         c15g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=ghUynx34Se1PWQlxUuq3M8AKFCN6cEMd2e8sZ7qxkGY=;
        b=c1diPGveL3ej1IiskBf6Vy8ct7aIpPteMHXfQiyccKCVYrvZ19VTI65Yd+ps+wcHHR
         cg6Ms3O6/X/+toqsOxAeAeQDRz6wu/eFzkzeG5vVTtc+zMVkYTK9DB+yRlKEHKzZJrm1
         Hk5nCxew9ptycsok21TDgegtH4JNcLQUM5eEOyL9E89tB87pyTpBd9bKXs3VtfeONxuT
         YvnDe+6PdQSYwNJ9Gjvcga4rJ+9y8F6GHBQnlWGIcLmH3zdXk9iEsFql4IR2Cw7R4EG6
         tW3UU5AEsMDpb65wGuZGdvgVG3S3yrjkZFvr6pYi9T/Wn0X6OtOv4y1h8kKVhvjnt9PI
         8/3Q==
X-Gm-Message-State: ANhLgQ2BeTfIVftV3qPB/ww2bTP3EGCc6i5Wbh91IzUj0LkC8lOZQ4fS
        HURaKc0DG7LQG6Nw3JMDA78=
X-Google-Smtp-Source: ADFU+vvqGwEF7vJ9mSozATwfYlatHSXGkxufLvaaOBHO7rJKVQZ4y8gUYwiG2PeFs0YD7kJuwer2lA==
X-Received: by 2002:ac2:5598:: with SMTP id v24mr13738225lfg.139.1584279918259;
        Sun, 15 Mar 2020 06:45:18 -0700 (PDT)
Received: from saturn.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id a9sm23025212lfb.21.2020.03.15.06.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2020 06:45:17 -0700 (PDT)
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
Subject: [PATCH v1 24/36] dt-bindings: display: convert toppoly panels to DT Schema
Date:   Sun, 15 Mar 2020 14:44:04 +0100
Message-Id: <20200315134416.16527-25-sam@ravnborg.org>
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
Cc: Marek Belisko <marek@goldelico.com>
Cc: H. Nikolaus Schaller <hns@goldelico.com>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
---
 .../bindings/display/panel/tpo,td.yaml        | 60 +++++++++++++++++++
 .../bindings/display/panel/tpo,td028ttec1.txt | 32 ----------
 .../bindings/display/panel/tpo,td043mtea1.txt | 33 ----------
 3 files changed, 60 insertions(+), 65 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/panel/tpo,td.yaml
 delete mode 100644 Documentation/devicetree/bindings/display/panel/tpo,td028ttec1.txt
 delete mode 100644 Documentation/devicetree/bindings/display/panel/tpo,td043mtea1.txt

diff --git a/Documentation/devicetree/bindings/display/panel/tpo,td.yaml b/Documentation/devicetree/bindings/display/panel/tpo,td.yaml
new file mode 100644
index 000000000000..9a79bcf87753
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/tpo,td.yaml
@@ -0,0 +1,60 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/tpo,td.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Toppoly TD Panels
+
+maintainers:
+  - Marek Belisko <marek@goldelico.com>
+  - H. Nikolaus Schaller <hns@goldelico.com>
+
+allOf:
+  - $ref: panel-common.yaml#
+  - $ref: ../../spi/spi-slave.yaml#
+
+properties:
+  compatible:
+    enum:
+        # Toppoly TD028TTEC1 Panel
+      - tpo,td028ttec1
+        # Toppoly TD043MTEA1 Panel
+      - tpo,td043mtea1
+
+  reg: true
+  label: true
+  reset-gpios: true
+  backlight: true
+  port: true
+
+required:
+  - compatible
+  - port
+
+examples:
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        panel: panel@0 {
+            compatible = "tpo,td043mtea1";
+            reg = <0>;
+            spi-max-frequency = <100000>;
+            spi-cpol;
+            spi-cpha;
+
+            label = "lcd";
+
+            reset-gpios = <&gpio7 7 0>;
+
+            port {
+                lcd_in: endpoint {
+                    remote-endpoint = <&dpi_out>;
+                };
+            };
+        };
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/display/panel/tpo,td028ttec1.txt b/Documentation/devicetree/bindings/display/panel/tpo,td028ttec1.txt
deleted file mode 100644
index 898e06ecf4ef..000000000000
--- a/Documentation/devicetree/bindings/display/panel/tpo,td028ttec1.txt
+++ /dev/null
@@ -1,32 +0,0 @@
-Toppoly TD028TTEC1 Panel
-========================
-
-Required properties:
-- compatible: "tpo,td028ttec1"
-
-Optional properties:
-- label: a symbolic name for the panel
-- backlight: phandle of the backlight device
-
-Required nodes:
-- Video port for DPI input
-
-Example
--------
-
-lcd-panel: td028ttec1@0 {
-	compatible = "tpo,td028ttec1";
-	reg = <0>;
-	spi-max-frequency = <100000>;
-	spi-cpol;
-	spi-cpha;
-
-	label = "lcd";
-	backlight = <&backlight>;
-	port {
-		lcd_in: endpoint {
-			remote-endpoint = <&dpi_out>;
-		};
-	};
-};
-
diff --git a/Documentation/devicetree/bindings/display/panel/tpo,td043mtea1.txt b/Documentation/devicetree/bindings/display/panel/tpo,td043mtea1.txt
deleted file mode 100644
index ec6d62975162..000000000000
--- a/Documentation/devicetree/bindings/display/panel/tpo,td043mtea1.txt
+++ /dev/null
@@ -1,33 +0,0 @@
-TPO TD043MTEA1 Panel
-====================
-
-Required properties:
-- compatible: "tpo,td043mtea1"
-- reset-gpios: panel reset gpio
-
-Optional properties:
-- label: a symbolic name for the panel
-
-Required nodes:
-- Video port for DPI input
-
-Example
--------
-
-lcd-panel: panel@0 {
-	compatible = "tpo,td043mtea1";
-	reg = <0>;
-	spi-max-frequency = <100000>;
-	spi-cpol;
-	spi-cpha;
-
-	label = "lcd";
-
-	reset-gpios = <&gpio7 7 0>;
-
-	port {
-		lcd_in: endpoint {
-			remote-endpoint = <&dpi_out>;
-		};
-	};
-};
-- 
2.20.1

