Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D97DB185CD0
	for <lists+linux-spi@lfdr.de>; Sun, 15 Mar 2020 14:44:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728643AbgCONop (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 15 Mar 2020 09:44:45 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45286 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728649AbgCONop (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 15 Mar 2020 09:44:45 -0400
Received: by mail-lj1-f195.google.com with SMTP id e18so15606081ljn.12;
        Sun, 15 Mar 2020 06:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pgEXQsDcjOHsYIv9nRQRc/r4cOy9yFXdgKqPV0CnCk8=;
        b=oHWDnNCQT47agrp2O3QeiJSxC/Xin3q9XIDhN9NkD5V0vzdx5EhSYeLMHHZWqK1znH
         vR2G2kdbnxstwPI79gskId/5hTb0WpW817qpWYTsk3vd6OUdPM+NF3es9i1UdRNgHgnS
         vMzfav/4a35ffNF0z1780uLQY/dXPnDk+8gujM+3oP9pEJStYJCWH7vhJg+smmFYSnnZ
         mq5HWaLWPh9+f/kwQlz5CkYDaD0sEoRHskgWut9RABQMXaJkQR4B+DFZFahiOZaN7Hos
         /SWx6qJGiaNHwgHGp+IjwxUeAawKwEpCJN3p97fdMShWx8oWTos+enqtq0hvPMuZ4Rqx
         gs2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=pgEXQsDcjOHsYIv9nRQRc/r4cOy9yFXdgKqPV0CnCk8=;
        b=a/MfPEe1vfb53C0kkstPfJ5Yr9QrBJYZSIRBTu+ofESJ/Pn8p3OpNXDjLVd1tfIzE2
         AJ3yp6pRDkz3j52oTR576fS2CKsGnrQUZAKYEgsAmI/eKgkSrcAejuKfpd2SfT7NNzxN
         RUqSnAcBnDJ2mhmJ9VBhJWeuB7Uu1dgrqKXm+Skjn4fDuVZBVJcyi/9Cw9jSZ8Dj1kIO
         BF/iMeciT0d2h4PLijzc83m69dmCSocsDkxl8qLR544kxmlc9MTdRYfmu1JdgzI/QBn0
         JK7LEDnyfgJepjYiyTdWHv7AGL2HEOTQ5wa3eE2SQHJhTFuvokD3mHLiOEBopAMhQKaQ
         8fUQ==
X-Gm-Message-State: ANhLgQ3HSDH4XOARoTOZH7Trt+RHxZgRWOEqFQTclpB3i9PYZpAQlYii
        uk7O4JIkNMiES2Wr0lTgbdw=
X-Google-Smtp-Source: ADFU+vuCyi5ubtfFG28TZfhRyYRqzodmur8BQI0nkoClJCFFJcM5vZi+/T5l7TzlRyRKvba6IPp8uQ==
X-Received: by 2002:a2e:92d6:: with SMTP id k22mr1256904ljh.18.1584279883480;
        Sun, 15 Mar 2020 06:44:43 -0700 (PDT)
Received: from saturn.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id a9sm23025212lfb.21.2020.03.15.06.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2020 06:44:43 -0700 (PDT)
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
Subject: [PATCH v1 07/36] dt-bindings: display: convert ilitek,ili9881c to DT Schema
Date:   Sun, 15 Mar 2020 14:43:47 +0100
Message-Id: <20200315134416.16527-8-sam@ravnborg.org>
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
 .../display/panel/ilitek,ili9881c.txt         | 20 --------
 .../display/panel/ilitek,ili9881c.yaml        | 50 +++++++++++++++++++
 2 files changed, 50 insertions(+), 20 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.txt
 create mode 100644 Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.txt b/Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.txt
deleted file mode 100644
index 4a041acb4e18..000000000000
--- a/Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.txt
+++ /dev/null
@@ -1,20 +0,0 @@
-Ilitek ILI9881c based MIPI-DSI panels
-
-Required properties:
-  - compatible: must be "ilitek,ili9881c" and one of:
-    * "bananapi,lhr050h41"
-  - reg: DSI virtual channel used by that screen
-  - power-supply: phandle to the power regulator
-  - reset-gpios: a GPIO phandle for the reset pin
-
-Optional properties:
-  - backlight: phandle to the backlight used
-
-Example:
-panel@0 {
-	compatible = "bananapi,lhr050h41", "ilitek,ili9881c";
-	reg = <0>;
-	power-supply = <&reg_display>;
-	reset-gpios = <&r_pio 0 5 GPIO_ACTIVE_LOW>; /* PL05 */
-	backlight = <&pwm_bl>;
-};
diff --git a/Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.yaml b/Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.yaml
new file mode 100644
index 000000000000..a39332276bab
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/ilitek,ili9881c.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Ilitek ILI9881c based MIPI-DSI panels
+
+maintainers:
+  - Maxime Ripard <mripard@kernel.org>
+
+properties:
+  compatible:
+    items:
+      - enum:
+        - bananapi,lhr050h41
+
+      - const: ilitek,ili9881c
+
+  backlight: true
+  power-supply: true
+  reg: true
+  reset-gpios: true
+
+required:
+  - compatible
+  - power-supply
+  - reg
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
+            compatible = "bananapi,lhr050h41", "ilitek,ili9881c";
+            reg = <0>;
+            power-supply = <&reg_display>;
+            reset-gpios = <&r_pio 0 5 GPIO_ACTIVE_LOW>; /* PL05 */
+            backlight = <&pwm_bl>;
+        };
+    };
+
+...
-- 
2.20.1

