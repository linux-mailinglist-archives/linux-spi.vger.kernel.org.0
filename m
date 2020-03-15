Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDC71185D16
	for <lists+linux-spi@lfdr.de>; Sun, 15 Mar 2020 14:45:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728628AbgCONpd (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 15 Mar 2020 09:45:33 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35422 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728701AbgCONpc (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 15 Mar 2020 09:45:32 -0400
Received: by mail-lj1-f193.google.com with SMTP id u12so15627948ljo.2;
        Sun, 15 Mar 2020 06:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=azOZ7kPdKDKE87CbcQj8S1GR4y4K/OoMeP9jpkMqrjY=;
        b=T2ZA2c+5tlbhyLrAiFFqt/rd0/VzWau2iJzhn8+bRFM4+1dTv0fJfFPfVvTAxKXbI1
         kbqJwQsojD1BcX513aT3h94W4/2KP42h/h81z7rFV/PoaQlxecxhB7v57J0jLeDGOp1q
         3uX29T4nJHY/sz5ErLpFRPkO93Z0x0MizZgzyC7EuR0MDLCZWKuHhWP5zwfdFm+F2EV6
         /yQi9+LGvupDi4oN7V/B4Yq6gtfhIS4ZEtaHTAog3lq2qmnFdkfKb5mg5nPI89r6RV/A
         FZ+O1zW81w4Cz+WhYTwxR1rbigqr4BD/tUVgNXCw9vS6jR44dZqTMpy6c1edpwst4ZmT
         qSvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=azOZ7kPdKDKE87CbcQj8S1GR4y4K/OoMeP9jpkMqrjY=;
        b=XVkvCAiDltpbAJqUrQACJbShTlfRROzOrmrKIFhr0Y3LyjGtvPq7e+PdBqSeWtBJ8r
         3kqXCIreMtj3TYOT/mdCJ5LGp8cESKrTIuPSuBRHlXP1bBtc+UpgBbIxhOjtN9urHNy0
         lpNnmVanP/VNDshFrrN6I1OkwyE8XxJTKR2hPmsh5Vq4srIsIB934HAJt/9oZbJJFDmg
         pQ/vPxO6saNijNuTYsnOC1RvrAMLHyo9nNT3wCO3qms1ZscCXQnjSNinDjlXTs2/zxnD
         sDc8cCX3O58lzpmwU1NEppVAeoqasbHzlAtK4c/8YzmwL1VMN8w38V7zFwiNya7eLfi1
         e4EQ==
X-Gm-Message-State: ANhLgQ17LdgmxoAUQxyOII+ZhLYKAVarscpGFbzb0zn9J+5ofQ2LLW2H
        3Fu+3JqyAxMtibsEuhj8zo8=
X-Google-Smtp-Source: ADFU+vs5LuCj6JNUC3blwIOkeUFcSwpV+vRt0L6KH2EvF6B7qKXUZVTzXMthHRmmuB8/H9vgT3/euA==
X-Received: by 2002:a2e:8095:: with SMTP id i21mr14054517ljg.193.1584279930756;
        Sun, 15 Mar 2020 06:45:30 -0700 (PDT)
Received: from saturn.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id a9sm23025212lfb.21.2020.03.15.06.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2020 06:45:30 -0700 (PDT)
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
Subject: [PATCH v1 30/36] dt-bindings: display: convert sharp,ls043t1le01 to DT Schema
Date:   Sun, 15 Mar 2020 14:44:10 +0100
Message-Id: <20200315134416.16527-31-sam@ravnborg.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200315134416.16527-1-sam@ravnborg.org>
References: <20200315134416.16527-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The txt binding specified the property "power-supply".
But the example and the actual implementation in the linux-kernel
uses "avdd-supply".
So the binding is adjusted to use avdd-supply as this seems
to be the correct choice.
There are no DT files in the linux kernel to check.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Werner Johansson <werner.johansson@sonymobile.com>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
---
 .../display/panel/sharp,ls043t1le01.txt       | 22 --------
 .../display/panel/sharp,ls043t1le01.yaml      | 51 +++++++++++++++++++
 2 files changed, 51 insertions(+), 22 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/panel/sharp,ls043t1le01.txt
 create mode 100644 Documentation/devicetree/bindings/display/panel/sharp,ls043t1le01.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/sharp,ls043t1le01.txt b/Documentation/devicetree/bindings/display/panel/sharp,ls043t1le01.txt
deleted file mode 100644
index 3770a111968b..000000000000
--- a/Documentation/devicetree/bindings/display/panel/sharp,ls043t1le01.txt
+++ /dev/null
@@ -1,22 +0,0 @@
-Sharp Microelectronics 4.3" qHD TFT LCD panel
-
-Required properties:
-- compatible: should be "sharp,ls043t1le01-qhd"
-- reg: DSI virtual channel of the peripheral
-- power-supply: phandle of the regulator that provides the supply voltage
-
-Optional properties:
-- backlight: phandle of the backlight device attached to the panel
-- reset-gpios: a GPIO spec for the reset pin
-
-Example:
-
-	mdss_dsi@fd922800 {
-		panel@0 {
-			compatible = "sharp,ls043t1le01-qhd";
-			reg = <0>;
-			avdd-supply = <&pm8941_l22>;
-			backlight = <&pm8941_wled>;
-			reset-gpios = <&pm8941_gpios 19 GPIO_ACTIVE_HIGH>;
-		};
-	};
diff --git a/Documentation/devicetree/bindings/display/panel/sharp,ls043t1le01.yaml b/Documentation/devicetree/bindings/display/panel/sharp,ls043t1le01.yaml
new file mode 100644
index 000000000000..a90d0d8bf7c9
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/sharp,ls043t1le01.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/sharp,ls043t1le01.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sharp Microelectronics 4.3" qHD TFT LCD panel
+
+maintainers:
+  - Werner Johansson <werner.johansson@sonymobile.com>
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    const: sharp,ls043t1le01-qhd
+
+  reg: true
+  backlight: true
+  reset-gpios: true
+  port: true
+
+  avdd-supply:
+    description: handle of the regulator that provides the supply voltage
+
+required:
+  - compatible
+  - reg
+  - avdd-supply
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
+            compatible = "sharp,ls043t1le01-qhd";
+            reg = <0>;
+            avdd-supply = <&pm8941_l22>;
+            backlight = <&pm8941_wled>;
+            reset-gpios = <&pm8941_gpios 19 GPIO_ACTIVE_HIGH>;
+        };
+    };
+
+...
-- 
2.20.1

