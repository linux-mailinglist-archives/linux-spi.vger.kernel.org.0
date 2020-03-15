Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1A50185CF7
	for <lists+linux-spi@lfdr.de>; Sun, 15 Mar 2020 14:45:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728682AbgCONpM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 15 Mar 2020 09:45:12 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40927 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728678AbgCONpL (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 15 Mar 2020 09:45:11 -0400
Received: by mail-lj1-f193.google.com with SMTP id 19so15583876ljj.7;
        Sun, 15 Mar 2020 06:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XpTic8bHFV4I2QRBLLyv5Etu38BCHVfgf52KExnVTHY=;
        b=aGT9u9LwB7v2ZdTjUHmtOiQvrzOKN/N+YS1NEIbrIkZaK0KGfiNf4mE6vi6QL0JJQr
         lo4NjwMwCGnECd7symMBrYLtOjJN4+TiFLiW0Ipc3yfs/M2uiDsB2S+eACosjcMsp4XL
         wUUYjD6G+Bla06Q0QgOJlT+yibhJQlNO6yvOI81gn/uUtgzf/xk80DjO+GHNhsxOL67i
         eIMQLhvl+KbncWjiraiRQO9RKWdmJ3ihVq/qsSt0AxQeYIYqCNKNcSLLAGYK1kR6pWNa
         VjMUkMECbtqobX22JvYR9FDCypmp27L0+m3ARx/93vSntX6rJsq1H4TXReDdLiPBAGKS
         FP+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=XpTic8bHFV4I2QRBLLyv5Etu38BCHVfgf52KExnVTHY=;
        b=o+AkDrPUW64cBruXup1N9RIFcbk3fiXTuY2uX175FiDeF9Dt2/Mxuf2KNE8wFHR6gi
         vmE4itpitgrE1Lc9MaB4I5VLOnhwMZInu2cr01W3biY1AriSwOXVtOFBpX7QrM1pTwlN
         EPIrBAsxkTrUB9AvWnIu7i6UE3EaaBmDBTxO+4Lap+7cuZUIJwLtiGCALB0SNcojORTk
         PHUvXFwNWZUXvLpn9+FTXHEPaLIJIpqbWWkMZjuPfEtUN/jWjEpMEInYjeoXDLBkhWu3
         wgrwfcR0dpxdfYfW+MnXzFVVpVPXgBlheZ0DvS0rDwFnvYYTZbV7uX4qnAnkebhYDNOB
         sD3Q==
X-Gm-Message-State: ANhLgQ34/E7OVJMza01FHFKPDlejxan2hvUNsN0aE/orwK2+5/6i/2xC
        MuzDV8kEaDB4zi6jEvzhN5g=
X-Google-Smtp-Source: ADFU+vs7RfZvDNQqHBt03aZvYEYM1TFpw6pNdW4Vncu222rT0CwpTUFR2i865Gq0liUDqaX3wFXI4Q==
X-Received: by 2002:a05:651c:288:: with SMTP id b8mr1882259ljo.98.1584279908314;
        Sun, 15 Mar 2020 06:45:08 -0700 (PDT)
Received: from saturn.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id a9sm23025212lfb.21.2020.03.15.06.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2020 06:45:07 -0700 (PDT)
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
Subject: [PATCH v1 19/36] dt-bindings: display: convert rocktech,jh057n00900 to DT Schema
Date:   Sun, 15 Mar 2020 14:43:59 +0100
Message-Id: <20200315134416.16527-20-sam@ravnborg.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200315134416.16527-1-sam@ravnborg.org>
References: <20200315134416.16527-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: "Guido Günther" <agx@sigxcpu.org>
Cc: Purism Kernel Team <kernel@puri.sm>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
---
 .../display/panel/rocktech,jh057n00900.txt    | 23 --------
 .../display/panel/rocktech,jh057n00900.yaml   | 57 +++++++++++++++++++
 2 files changed, 57 insertions(+), 23 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.txt
 create mode 100644 Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.txt b/Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.txt
deleted file mode 100644
index a372c5d84695..000000000000
--- a/Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.txt
+++ /dev/null
@@ -1,23 +0,0 @@
-Rocktech jh057n00900 5.5" 720x1440 TFT LCD panel
-
-Required properties:
-- compatible: should be "rocktech,jh057n00900"
-- reg: DSI virtual channel of the peripheral
-- reset-gpios: panel reset gpio
-- backlight: phandle of the backlight device attached to the panel
-- vcc-supply: phandle of the regulator that provides the vcc supply voltage.
-- iovcc-supply: phandle of the regulator that provides the iovcc supply
-  voltage.
-
-Example:
-
-	&mipi_dsi {
-		panel@0 {
-			compatible = "rocktech,jh057n00900";
-			reg = <0>;
-			backlight = <&backlight>;
-			reset-gpios = <&gpio3 13 GPIO_ACTIVE_LOW>;
-			vcc-supply = <&reg_2v8_p>;
-			iovcc-supply = <&reg_1v8_p>;
-		};
-	};
diff --git a/Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.yaml b/Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.yaml
new file mode 100644
index 000000000000..827417bbff63
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.yaml
@@ -0,0 +1,57 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/rocktech,jh057n00900.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Rocktech jh057n00900 5.5" 720x1440 TFT LCD panel
+
+maintainers:
+  - Guido Günther <agx@sigxcpu.org>
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    const: rocktech,jh057n00900
+
+  reg: true
+  reset-gpios: true
+  backlight: true
+
+  vcc-supply:
+    description: The regulator that provides the vcc supply voltage
+
+  iovcc-supply:
+    description: The regulator that provides the iovcc supply voltage
+
+required:
+  - compatible
+  - reg
+  - reset-gpios
+  - backlight
+  - vcc-supply
+  - iovcc-supply
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
+            compatible = "rocktech,jh057n00900";
+            reg = <0>;
+            backlight = <&backlight>;
+            reset-gpios = <&gpio3 13 GPIO_ACTIVE_LOW>;
+            vcc-supply = <&reg_2v8_p>;
+            iovcc-supply = <&reg_1v8_p>;
+        };
+    };
+
+...
-- 
2.20.1

