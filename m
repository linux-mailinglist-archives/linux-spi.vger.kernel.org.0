Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40C4C185CCD
	for <lists+linux-spi@lfdr.de>; Sun, 15 Mar 2020 14:44:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728651AbgCONoo (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 15 Mar 2020 09:44:44 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39805 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728643AbgCONoo (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 15 Mar 2020 09:44:44 -0400
Received: by mail-lf1-f65.google.com with SMTP id j15so11738871lfk.6;
        Sun, 15 Mar 2020 06:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nXaJ0V5xklg8WgvlRTOBuhFm5WZEeNq3OBl1ct6iqI0=;
        b=JwHhcDs8Gen/1n/UVZV5wsKSKv/m4WzKhLlV0Bf6y3y8V7BEJVOG319xee4k5798UJ
         6TTvyDWh2G7TWv1ZJKAHCgEHHxMS3Z9/3nGt1eSoH6f22FiHM28os9pqUxC89lFFu9s9
         jT69grNbXIglNpWNdCFyThiWi761OvRa5esx6X7zHDAA/bNWlTgLIhUukMasiCiwlgRG
         actJvznHSieRm14QansgRts4MvGIMM3pZWA0I6dLOzMTuKLK03PSqQmA5PeFZd5/Ab0r
         5/3/wFQllg03HSWH8cMDeFpys6rc78Up4Q3KN7zQBP9/4Jzjt7Ta++V3fUdl4CmkUaVk
         rahg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=nXaJ0V5xklg8WgvlRTOBuhFm5WZEeNq3OBl1ct6iqI0=;
        b=LHvCiGw+rNXNsz20T+yvV2+EPcoxvPXYswRdstRD0DvWTvAqI0ihSz5Fzg/8ik9g0Q
         ySSkW7fCI0a53kIg9a0Kf4FwCqnljn0BhzUKuEsdUthEO7OoxjbSOfFdu+wSH5mVY6mV
         z6r6tu7HR1nWWHkqC0odGnDr0S1q+jBXOqZlwYsj81O0nTQvbns/8jXOThSecfYCXhRl
         ze6XY057ajOg7hAAT8Lej2tLImGhd+mKK277aNKm29+wm6z0xoeXF+idFGKanoR4Q6Cl
         TGjrRm8+Hs/fybf3jf0JoCQkKXfEXZpzVuwE9fTPcjfG2RnDvyNwCbC2d6FrtTftQGDk
         NrMQ==
X-Gm-Message-State: ANhLgQ24lQ0owDtHkzqoKyGOrB3FuQ1KIwOLfqNShubb7Ps4RB7hgYf2
        0qZQxCMd2nCZSSHOt1TSaso=
X-Google-Smtp-Source: ADFU+vujG7VKcDu/ERgRI3MOa9d6/ymCp4T4gMqsmUhDw1hRSsI6YFlzZD6tVoiK0x0fGWUEp6vJ7w==
X-Received: by 2002:ac2:46d9:: with SMTP id p25mr6090011lfo.174.1584279879157;
        Sun, 15 Mar 2020 06:44:39 -0700 (PDT)
Received: from saturn.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id a9sm23025212lfb.21.2020.03.15.06.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2020 06:44:38 -0700 (PDT)
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
Subject: [PATCH v1 05/36] dt-bindings: display: convert boe,himax8279d to DT Schema
Date:   Sun, 15 Mar 2020 14:43:45 +0100
Message-Id: <20200315134416.16527-6-sam@ravnborg.org>
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
Cc: Jerry Han <hanxu5@huaqin.corp-partner.google.com>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
---
 .../bindings/display/panel/boe,himax8279d.txt | 24 --------
 .../display/panel/boe,himax8279d.yaml         | 59 +++++++++++++++++++
 2 files changed, 59 insertions(+), 24 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/panel/boe,himax8279d.txt
 create mode 100644 Documentation/devicetree/bindings/display/panel/boe,himax8279d.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/boe,himax8279d.txt b/Documentation/devicetree/bindings/display/panel/boe,himax8279d.txt
deleted file mode 100644
index 3caea2172b1b..000000000000
--- a/Documentation/devicetree/bindings/display/panel/boe,himax8279d.txt
+++ /dev/null
@@ -1,24 +0,0 @@
-Boe Himax8279d 1200x1920 TFT LCD panel
-
-Required properties:
-- compatible: should be "boe,himax8279d8p" and one of: "boe,himax8279d10p"
-- reg: DSI virtual channel of the peripheral
-- enable-gpios: panel enable gpio
-- pp33-gpios: a GPIO phandle for the 3.3v pin that provides the supply voltage
-- pp18-gpios: a GPIO phandle for the 1.8v pin that provides the supply voltage
-
-Optional properties:
-- backlight: phandle of the backlight device attached to the panel
-
-Example:
-
-	&mipi_dsi {
-		panel {
-			compatible = "boe,himax8279d8p", "boe,himax8279d10p";
-			reg = <0>;
-			backlight = <&backlight>;
-			enable-gpios = <&gpio 45 GPIO_ACTIVE_HIGH>;
-			pp33-gpios = <&gpio 35 GPIO_ACTIVE_HIGH>;
-			pp18-gpios = <&gpio 36 GPIO_ACTIVE_HIGH>;
-		};
-	};
diff --git a/Documentation/devicetree/bindings/display/panel/boe,himax8279d.yaml b/Documentation/devicetree/bindings/display/panel/boe,himax8279d.yaml
new file mode 100644
index 000000000000..e42b6a8ae176
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/boe,himax8279d.yaml
@@ -0,0 +1,59 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/boe,himax8279d.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Boe Himax8279d 1200x1920 TFT LCD panel
+
+maintainers:
+  - Jerry Han <jerry.han.hq@gmail.com>
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    items:
+      - const: boe,himax8279d8p
+      - const: boe,himax8279d10p
+
+  backlight: true
+  enable-gpios: true
+  reg: true
+
+  pp33-gpios:
+    maxItems: 1
+    description: GPIO for the 3.3v pin that provides the supply voltage
+
+  pp18-gpios:
+    maxItems: 1
+    description: GPIO for the 1.8v pin that provides the supply voltage
+
+required:
+  - compatible
+  - reg
+  - enable-gpios
+  - pp33-gpios
+  - pp18-gpios
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
+        panel {
+            compatible = "boe,himax8279d8p", "boe,himax8279d10p";
+            reg = <0>;
+            backlight = <&backlight>;
+            enable-gpios = <&gpio 45 GPIO_ACTIVE_HIGH>;
+            pp33-gpios = <&gpio 35 GPIO_ACTIVE_HIGH>;
+            pp18-gpios = <&gpio 36 GPIO_ACTIVE_HIGH>;
+        };
+    };
+
+...
-- 
2.20.1

