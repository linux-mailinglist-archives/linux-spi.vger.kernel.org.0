Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA81185D29
	for <lists+linux-spi@lfdr.de>; Sun, 15 Mar 2020 14:45:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728718AbgCONpp (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 15 Mar 2020 09:45:45 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37015 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728705AbgCONpp (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 15 Mar 2020 09:45:45 -0400
Received: by mail-lj1-f193.google.com with SMTP id r24so15638780ljd.4;
        Sun, 15 Mar 2020 06:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rXa6VlRbgpah7LGY3OOOT1LELVwF4SMk1lCdqSipX50=;
        b=JEX8bQmXM2HZhTbkCQ80v+cnbaFzXX500vFGdipdZrMPTIncu7Zk9aAbtZodRA5mEU
         xE94qnXXbDpHnmNE/X4glWhLvCT5TDmfCyMz69rYajFROeZsSDRef05yRFmjgQZL21x/
         JdnUDqO6e+tFbnycrUsK+gNEugrhR5iuxaTUNXNbcf2znQkft20+OEUcOEZTi/1EwZBX
         lcIogDiMypdqvxb+35hdouMy91Hf7uYs1PECsDZGFhJYtYdB7ZsnAcnKfIDl/pGuNNR8
         jlGh9ZtdVUU2SRfukvdAsppnB6DANtBfXwH17Q+LIqeS3nZVJIUdAuI43G9ia3c1vzD9
         dNxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=rXa6VlRbgpah7LGY3OOOT1LELVwF4SMk1lCdqSipX50=;
        b=OLjh5ri9UTdvuzutxjMud9aPfuJITzfIvvI9bTmNNxmyeQ2Pp6Zs/+qgNaw+Ffrxrl
         q3sQ2yZ29JQYu/f5FkQ3B0IL716RtkOUwR64YqgapwYSMtPDOg9rqcBTX9wFOBMgKL7/
         fQDAMEVQrI/c6dd2+ZFGNlHY9jemjqJyy6/+kVms98+fTLLpx5a5YQsFNBoFK0DgXz+Q
         pmNQkhpGfYZ+DSycMIESysJiej4oqbLhvUaobqKyQAmjaGLtJaD1wHpby4/9l1k9A09L
         WDkkkpGiFbLlzknKhnapprWOTQq+bttE173fNa/wEveP0cSPEIgcseabqM4LMvizwZls
         i0Mw==
X-Gm-Message-State: ANhLgQ0VZV/28ECb60u8FulYsMo8zgqgul+cczJGaIiLm6R63B8EfJNW
        hwqYK1rvT9/yuzfJS0BthKo=
X-Google-Smtp-Source: ADFU+vsX8ITn47HEixar4GwQHDh7QX0PW82O0+yT17UZn/149C5hjTybfpBiqRCc67jzM5E7hgDrFw==
X-Received: by 2002:a2e:6c03:: with SMTP id h3mr829049ljc.8.1584279943011;
        Sun, 15 Mar 2020 06:45:43 -0700 (PDT)
Received: from saturn.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id a9sm23025212lfb.21.2020.03.15.06.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2020 06:45:42 -0700 (PDT)
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
Subject: [PATCH v1 36/36] dt-bindings: display: convert olimex,lcd-olinuxino to DT Schema
Date:   Sun, 15 Mar 2020 14:44:16 +0100
Message-Id: <20200315134416.16527-37-sam@ravnborg.org>
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
Cc: Stefan Mavrodiev <stefan@olimex.com>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
---
 .../display/panel/olimex,lcd-olinuxino.txt    | 42 -----------
 .../display/panel/olimex,lcd-olinuxino.yaml   | 70 +++++++++++++++++++
 2 files changed, 70 insertions(+), 42 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/panel/olimex,lcd-olinuxino.txt
 create mode 100644 Documentation/devicetree/bindings/display/panel/olimex,lcd-olinuxino.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/olimex,lcd-olinuxino.txt b/Documentation/devicetree/bindings/display/panel/olimex,lcd-olinuxino.txt
deleted file mode 100644
index a89f9c830a85..000000000000
--- a/Documentation/devicetree/bindings/display/panel/olimex,lcd-olinuxino.txt
+++ /dev/null
@@ -1,42 +0,0 @@
-Binding for Olimex Ltd. LCD-OLinuXino bridge panel.
-
-This device can be used as bridge between a host controller and LCD panels.
-Currently supported LCDs are:
-  - LCD-OLinuXino-4.3TS
-  - LCD-OLinuXino-5
-  - LCD-OLinuXino-7
-  - LCD-OLinuXino-10
-
-The panel itself contains:
-  - AT24C16C EEPROM holding panel identification and timing requirements
-  - AR1021 resistive touch screen controller (optional)
-  - FT5x6 capacitive touch screnn controller (optional)
-  - GT911/GT928 capacitive touch screen controller (optional)
-
-The above chips share same I2C bus. The EEPROM is factory preprogrammed with
-device information (id, serial, etc.) and timing requirements.
-
-Touchscreen bingings can be found in these files:
-  - input/touchscreen/goodix.txt
-  - input/touchscreen/edt-ft5x06.txt
-  - input/touchscreen/ar1021.txt
-
-Required properties:
-  - compatible: should be "olimex,lcd-olinuxino"
-  - reg: address of the configuration EEPROM, should be <0x50>
-  - power-supply: phandle of the regulator that provides the supply voltage
-
-Optional properties:
-  - enable-gpios: GPIO pin to enable or disable the panel
-  - backlight: phandle of the backlight device attacked to the panel
-
-Example:
-&i2c2 {
-	panel@50 {
-		compatible = "olimex,lcd-olinuxino";
-		reg = <0x50>;
-		power-supply = <&reg_vcc5v0>;
-		enable-gpios = <&pio 7 8 GPIO_ACTIVE_HIGH>;
-		backlight = <&backlight>;
-	};
-};
diff --git a/Documentation/devicetree/bindings/display/panel/olimex,lcd-olinuxino.yaml b/Documentation/devicetree/bindings/display/panel/olimex,lcd-olinuxino.yaml
new file mode 100644
index 000000000000..22d664abd552
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/olimex,lcd-olinuxino.yaml
@@ -0,0 +1,70 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/olimex,lcd-olinuxino.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Binding for Olimex Ltd. LCD-OLinuXino bridge panel.
+
+maintainers:
+  - Stefan Mavrodiev <stefan@olimex.com>
+
+description: |
+  This device can be used as bridge between a host controller and LCD panels.
+  Currently supported LCDs are:
+    - LCD-OLinuXino-4.3TS
+    - LCD-OLinuXino-5
+    - LCD-OLinuXino-7
+    - LCD-OLinuXino-10
+
+  The panel itself contains:
+    - AT24C16C EEPROM holding panel identification and timing requirements
+    - AR1021 resistive touch screen controller (optional)
+    - FT5x6 capacitive touch screnn controller (optional)
+    - GT911/GT928 capacitive touch screen controller (optional)
+
+  The above chips share same I2C bus. The EEPROM is factory preprogrammed with
+  device information (id, serial, etc.) and timing requirements.
+
+  Touchscreen bingings can be found in these files:
+    - input/touchscreen/goodix.yaml
+    - input/touchscreen/edt-ft5x06.txt
+    - input/touchscreen/ar1021.txt
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    const: olimex,lcd-olinuxino
+
+  backlight: true
+  enable-gpios: true
+  power-supply: true
+  reg: true
+
+required:
+  - compatible
+  - reg
+  - power-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    i2c2 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        panel@50 {
+            compatible = "olimex,lcd-olinuxino";
+            reg = <0x50>;
+            power-supply = <&reg_vcc5v0>;
+            enable-gpios = <&pio 7 8 GPIO_ACTIVE_HIGH>;
+            backlight = <&backlight>;
+        };
+    };
+
+...
-- 
2.20.1

