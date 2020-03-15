Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFAF9185D20
	for <lists+linux-spi@lfdr.de>; Sun, 15 Mar 2020 14:45:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728711AbgCONpl (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 15 Mar 2020 09:45:41 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36245 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728709AbgCONpl (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 15 Mar 2020 09:45:41 -0400
Received: by mail-lf1-f67.google.com with SMTP id s1so11709082lfd.3;
        Sun, 15 Mar 2020 06:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qBUTf9GpIdfXPTFTOtKhRJPsPUGuxMdiWCVmQGYT+2k=;
        b=Ws97P9zpToL4JcvpOFuzbNwuodP493lrUIGqjz7Zcvs5p1A1/gKzilbW1uym66jyLE
         ymvI8jhc9OblLE25BPqkdYMIgojPct7I1RJIH8jos/4GD8pzzT7Anik8FH2g/8Nf2jkP
         1ZeKH2CuFjRedUyUfdqmv81EUOyhQLeChEURQvA9P4ZF5GVf8xR5XJIYupNmYYWHrtpb
         M2WiYmSyD935LzvIqFZmiGbSjOW1WoJjabQlueBLHI0q+OO5TVYTbFuTZRJHiQXaWFht
         MYgttYKSf3dVIGDtITV1xogzvEc2JenZJaNpYY8jQHi5NdA0qTJDgolpkkhO8xP5US/b
         /3FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=qBUTf9GpIdfXPTFTOtKhRJPsPUGuxMdiWCVmQGYT+2k=;
        b=ifM2W28a4peQfwOPD0+iQhc/Pp78cNeTML+QWKIysQkCvlh2elb3UJt5ViXb4yVgQb
         f5z0ITc0ibx0wmcBimzxwOywLhrAKljHeBV53RgzE96s6ohvDj29k+BblJDwvfWcG3+Z
         HyoEEE6fQQxEpTUele+HIhjIxAIuPjPVlqhnQ4ca3B1c/K86y0j63zn59WdWvXnHB01W
         1yQpojacydv6gs1idy55fSdPFg2AMgRI3HC8tUZMjoMyiljs9NMJSzJkSLNvtkRwxzaW
         l8JKJ20q1AsKJl5TkKacaS+hto0GRy2793dwlfpWGIdBBjUPmx83MH84lVXkpixWlpji
         mF0w==
X-Gm-Message-State: ANhLgQ3Nu+6j8brniZ28CaC0lv5+kKNpkN0SER1oPQY5PH0AwV2auZxv
        1uJEDzjcXjasUp0oRduWojs=
X-Google-Smtp-Source: ADFU+vvTQEq/cvWDAYSQIlZsIN9Cs1P+wx3lsx1bi54HOkveLS6awGenZ0u5wIN3aYPyVsmSKYSUxQ==
X-Received: by 2002:a05:6512:31d3:: with SMTP id j19mr13911445lfe.178.1584279938846;
        Sun, 15 Mar 2020 06:45:38 -0700 (PDT)
Received: from saturn.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id a9sm23025212lfb.21.2020.03.15.06.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2020 06:45:38 -0700 (PDT)
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
Subject: [PATCH v1 34/36] dt-bindings: display: convert seiko,43wvf1g to DT Schema
Date:   Sun, 15 Mar 2020 14:44:14 +0100
Message-Id: <20200315134416.16527-35-sam@ravnborg.org>
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
Cc: Marco Franchi <marco.franchi@nxp.com>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
---
 .../bindings/display/panel/seiko,43wvf1g.txt  | 23 ---------
 .../bindings/display/panel/seiko,43wvf1g.yaml | 49 +++++++++++++++++++
 2 files changed, 49 insertions(+), 23 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/panel/seiko,43wvf1g.txt
 create mode 100644 Documentation/devicetree/bindings/display/panel/seiko,43wvf1g.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/seiko,43wvf1g.txt b/Documentation/devicetree/bindings/display/panel/seiko,43wvf1g.txt
deleted file mode 100644
index aae57ef36cdd..000000000000
--- a/Documentation/devicetree/bindings/display/panel/seiko,43wvf1g.txt
+++ /dev/null
@@ -1,23 +0,0 @@
-Seiko Instruments Inc. 4.3" WVGA (800 x RGB x 480) TFT with Touch-Panel
-
-Required properties:
-- compatible: should be "sii,43wvf1g".
-- "dvdd-supply": 3v3 digital regulator.
-- "avdd-supply": 5v analog regulator.
-
-Optional properties:
-- backlight: phandle for the backlight control.
-
-Example:
-
-	panel {
-		compatible = "sii,43wvf1g";
-		backlight = <&backlight_display>;
-		dvdd-supply = <&reg_lcd_3v3>;
-		avdd-supply = <&reg_lcd_5v>;
-		port {
-			panel_in: endpoint {
-				remote-endpoint = <&display_out>;
-			};
-		};
-	};
diff --git a/Documentation/devicetree/bindings/display/panel/seiko,43wvf1g.yaml b/Documentation/devicetree/bindings/display/panel/seiko,43wvf1g.yaml
new file mode 100644
index 000000000000..9195de40b21b
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/seiko,43wvf1g.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/seiko,43wvf1g.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Seiko Instruments Inc. 4.3" WVGA (800 x RGB x 480) TFT with Touch-Panel
+
+maintainers:
+  - Marco Franchi <marco.franchi@nxp.com>
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    const: sii,43wvf1g
+
+  backlight: true
+  port: true
+
+  dvdd-supply:
+    description: 3v3 digital regulator
+
+  avdd-supply:
+    description: 5v analog regulator
+
+required:
+  - compatible
+  - dvdd-supply
+  - avdd-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    panel {
+        compatible = "sii,43wvf1g";
+        backlight = <&backlight_display>;
+        dvdd-supply = <&reg_lcd_3v3>;
+        avdd-supply = <&reg_lcd_5v>;
+        port {
+            panel_in: endpoint {
+                remote-endpoint = <&display_out>;
+            };
+        };
+    };
+
+...
-- 
2.20.1

