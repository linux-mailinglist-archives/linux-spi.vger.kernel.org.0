Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD42185D23
	for <lists+linux-spi@lfdr.de>; Sun, 15 Mar 2020 14:45:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728714AbgCONpl (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 15 Mar 2020 09:45:41 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45374 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728705AbgCONpl (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 15 Mar 2020 09:45:41 -0400
Received: by mail-lf1-f68.google.com with SMTP id b13so11702043lfb.12;
        Sun, 15 Mar 2020 06:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oOzyULiNbeFY2/JVqESTmUOi0tZ1RaKtlAJLXAU+LTo=;
        b=jVKh2KC4mKUFqX3k/JW6TS/U7j/YIxHjIFQ7M43CDa5qqWOHKX1aj/xt+WV+FnuBb+
         IPf6kD5dUG264S3EVkYQ2trKmgL74MyI3Zva5tWaFzkW9BdJo84tJsgm9jE9LXb3GsFJ
         BIoEnmvTYCCqmx2Tr5rs5Krsf34i+LhnaXhCRgVXjXkGVnmM77duQGYgcEupqC8qYPBo
         LewMeyxMNxfZZWElHlwUbn4GcVJjkoJmhI8G/QjtLu/DJXL+TUyACsBc4yhdAYdLhQ1Y
         Jexqjsdd1nIKjW8bFDNiS23SJ0+NS84BttZafjMQ52X4gpE4a3SdZpNgPad7Gw235hKN
         dsnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=oOzyULiNbeFY2/JVqESTmUOi0tZ1RaKtlAJLXAU+LTo=;
        b=SKW021NFenzuTmfGZnP4r+AJeZlziDdzVw6Gx1J897PVQ5mL3tYRKl9iPHDZ30EbXf
         wHDxHFArpGlbGKNbPcyArp46M+A3kK1jfvVB0el1NHpp6rx6rHqhCCdZTs2OU7AFnhjB
         qbMaSkes4cPI7AsKEf21OAQyzmnlmlCNV+PbHqVDX0NbA6AwuSs/kyZAad8E1C2YY8zK
         gxC6Z1mdMaBNf5M6Yc1kzUXke6QUOhmPdRLyAd2bjFw8pwoKtnmxkqdkrhHFfQVHhcaC
         K7DaMBs1TH6hBVB4PJStwTAoGZekGPGqoATye/fvIv5ngzobZmXIdZV6YKTw1qIUDZwm
         ZVOg==
X-Gm-Message-State: ANhLgQ0nK5VRVyLN1R1aVq4dJ5kSBSR5sNcR4dmPbkUXaJWeW0O3eNHh
        WzB7XMxpyJ4ZB3U7gIzigNs=
X-Google-Smtp-Source: ADFU+vtr+LHEQowdAfWSKJxhIwCC8cDfNuCiUTXYchSZ2Y3hSfen41VNdYjJLibo6depjha7ND3oEw==
X-Received: by 2002:ac2:5465:: with SMTP id e5mr12479598lfn.210.1584279936692;
        Sun, 15 Mar 2020 06:45:36 -0700 (PDT)
Received: from saturn.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id a9sm23025212lfb.21.2020.03.15.06.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2020 06:45:36 -0700 (PDT)
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
Subject: [PATCH v1 33/36] dt-bindings: display: convert sharp,lq150x1lg11 to DT Schema
Date:   Sun, 15 Mar 2020 14:44:13 +0100
Message-Id: <20200315134416.16527-34-sam@ravnborg.org>
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
Cc: Peter Rosin <peda@axentia.se>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
---
 .../display/panel/sharp,lq150x1lg11.txt       | 36 ------------
 .../display/panel/sharp,lq150x1lg11.yaml      | 58 +++++++++++++++++++
 2 files changed, 58 insertions(+), 36 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/panel/sharp,lq150x1lg11.txt
 create mode 100644 Documentation/devicetree/bindings/display/panel/sharp,lq150x1lg11.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/sharp,lq150x1lg11.txt b/Documentation/devicetree/bindings/display/panel/sharp,lq150x1lg11.txt
deleted file mode 100644
index 0f57c3143506..000000000000
--- a/Documentation/devicetree/bindings/display/panel/sharp,lq150x1lg11.txt
+++ /dev/null
@@ -1,36 +0,0 @@
-Sharp 15" LQ150X1LG11 XGA TFT LCD panel
-
-Required properties:
-- compatible: should be "sharp,lq150x1lg11"
-- power-supply: regulator to provide the VCC supply voltage (3.3 volts)
-
-Optional properties:
-- backlight: phandle of the backlight device
-- rlud-gpios: a single GPIO for the RL/UD (rotate 180 degrees) pin.
-- sellvds-gpios: a single GPIO for the SELLVDS pin.
-
-If rlud-gpios and/or sellvds-gpios are not specified, the RL/UD and/or SELLVDS
-pins are assumed to be handled appropriately by the hardware.
-
-Example:
-
-	backlight: backlight {
-		compatible = "pwm-backlight";
-		pwms = <&pwm 0 100000>;                      /* VBR */
-
-		brightness-levels = <0 20 40 60 80 100>;
-		default-brightness-level = <2>;
-
-		power-supply = <&vdd_12v_reg>;               /* VDD */
-		enable-gpios = <&gpio 42 GPIO_ACTIVE_HIGH>;  /* XSTABY */
-	};
-
-	panel {
-		compatible = "sharp,lq150x1lg11";
-
-		power-supply = <&vcc_3v3_reg>;               /* VCC */
-
-		backlight = <&backlight>;
-		rlud-gpios = <&gpio 17 GPIO_ACTIVE_HIGH>;    /* RL/UD */
-		sellvds-gpios = <&gpio 18 GPIO_ACTIVE_HIGH>; /* SELLVDS */
-	};
diff --git a/Documentation/devicetree/bindings/display/panel/sharp,lq150x1lg11.yaml b/Documentation/devicetree/bindings/display/panel/sharp,lq150x1lg11.yaml
new file mode 100644
index 000000000000..92f2d12f4f4c
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/sharp,lq150x1lg11.yaml
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/sharp,lq150x1lg11.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sharp 15" LQ150X1LG11 XGA TFT LCD panel
+
+maintainers:
+  - Peter Rosin <peda@axentia.se>
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    const: sharp,lq150x1lg11
+
+  power-supply: true
+  backlight: true
+
+  rlud-gpios:
+    maxItems: 1
+    description: |
+      GPIO for the RL/UD (rotate 180 degrees) pin.
+      If rlud-gpios and/or sellvds-gpios are not specified,
+      the RL/UD and/or SELLVDS pins are assumed to be handled
+      appropriately by the hardware.
+
+  sellvds-gpios:
+    maxItems: 1
+    description: |
+      GPIO for the SELLVDS pin.
+      If rlud-gpios and/or sellvds-gpios are not specified,
+      the RL/UD and/or SELLVDS pins are assumed to be handled
+      appropriately by the hardware.
+
+required:
+  - compatible
+  - power-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    panel {
+        compatible = "sharp,lq150x1lg11";
+
+        power-supply = <&vcc_3v3_reg>;               /* VCC */
+
+        backlight = <&backlight>;
+        rlud-gpios = <&gpio 17 GPIO_ACTIVE_HIGH>;    /* RL/UD */
+        sellvds-gpios = <&gpio 18 GPIO_ACTIVE_HIGH>; /* SELLVDS */
+    };
+
+...
-- 
2.20.1

