Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92E3C185CDB
	for <lists+linux-spi@lfdr.de>; Sun, 15 Mar 2020 14:44:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728660AbgCONox (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 15 Mar 2020 09:44:53 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37467 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728658AbgCONox (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 15 Mar 2020 09:44:53 -0400
Received: by mail-lf1-f67.google.com with SMTP id j11so11717524lfg.4;
        Sun, 15 Mar 2020 06:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DKFWNzm+inHvUnuFaBbTyPTrAd4h6YpCxucuZ+VVDvg=;
        b=nKQkRbs6p7IU6GKjqEAoG/cl1CtIpH+L/FrvbrTmJCLaV2cNEYHISe0/xnBO2pnCoi
         tm25uzNnyMFSpPnNrAbUugYBn7ixSlcl7XtqS6N2cD9nz7IJCm+CPPK9Dj4E/sQmm0Z1
         br7eDuzTfyk+VVm+L+T2vSOJ249dlsCTvZha1x60RHoCCaSyvaVnUZ8TGFxgFT5FY1Dz
         ndve/sIQpzM9HJ7ubT8+f3MoVRL5it674tni+OL0RzSOAwr7Ny7ChiPqwoAxtOFekX2n
         Ch0ZYff0Dm1FLo1o801LkUTwCVqZojTf/D+SpivzJR8GkiohK9wbY97Ult8LleZBvaYp
         5t2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=DKFWNzm+inHvUnuFaBbTyPTrAd4h6YpCxucuZ+VVDvg=;
        b=Pcm97/YocE1hRWudNzicDFnxItMhhOm2WyU1lunjPb/FZCwWeAwQVTv1L0XPbTraMY
         bGD749cYd1P8pbQHah5K/SwIoKJRJuO+Vtb6c9hJm9TiMZQs6Iq9zz5ULCwdh2QSRux2
         FWQ4Ufp6R6gl2SvWHaW3KftPEnEP3OTBiR/keVHmOUpQVMBW7+5/tExAsXkc3sGGiqAM
         zxBZ1aIPj2xT/L9ZaO8PCTtH6Y8H3UqBGa17rb6uZl/VUgkfbp3bKgzVVtikS/Wr1s6p
         mS9N/lSJMxKwVpJG5viuSi6ijd79hmo7NFMgYO/QUNpl1h0FG72PHAeRpBAeyLlj7gh6
         +J/Q==
X-Gm-Message-State: ANhLgQ3bEf3MaY0/su5Ux7WpRvDgmJTL9WhPppi9I15zf5UhpPgapmRt
        87fmjuIv5qPD8RevSvyIonw=
X-Google-Smtp-Source: ADFU+vs0IGyQy3vzYGDlnv9TvE4khDaBhV7yBGIAFb8i07P4mBDYkpaUXJBq/gHEcKsW7v9UOYK1uQ==
X-Received: by 2002:a19:a415:: with SMTP id q21mr13918816lfc.21.1584279889723;
        Sun, 15 Mar 2020 06:44:49 -0700 (PDT)
Received: from saturn.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id a9sm23025212lfb.21.2020.03.15.06.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2020 06:44:49 -0700 (PDT)
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
Subject: [PATCH v1 10/36] dt-bindings: display: convert innolux,p097pfg to DT Schema
Date:   Sun, 15 Mar 2020 14:43:50 +0100
Message-Id: <20200315134416.16527-11-sam@ravnborg.org>
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
Cc: Lin Huang <hl@rock-chips.com>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
---
 .../display/panel/innolux,p097pfg.txt         | 24 --------
 .../display/panel/innolux,p097pfg.yaml        | 56 +++++++++++++++++++
 2 files changed, 56 insertions(+), 24 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/panel/innolux,p097pfg.txt
 create mode 100644 Documentation/devicetree/bindings/display/panel/innolux,p097pfg.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/innolux,p097pfg.txt b/Documentation/devicetree/bindings/display/panel/innolux,p097pfg.txt
deleted file mode 100644
index d1cab3a8f0fb..000000000000
--- a/Documentation/devicetree/bindings/display/panel/innolux,p097pfg.txt
+++ /dev/null
@@ -1,24 +0,0 @@
-Innolux P097PFG 9.7" 1536x2048 TFT LCD panel
-
-Required properties:
-- compatible: should be "innolux,p097pfg"
-- reg: DSI virtual channel of the peripheral
-- avdd-supply: phandle of the regulator that provides positive voltage
-- avee-supply: phandle of the regulator that provides negative voltage
-- enable-gpios: panel enable gpio
-
-Optional properties:
-- backlight: phandle of the backlight device attached to the panel
-
-Example:
-
-	&mipi_dsi {
-		panel@0 {
-			compatible = "innolux,p079zca";
-			reg = <0>;
-			avdd-supply = <...>;
-			avee-supply = <...>;
-			backlight = <&backlight>;
-			enable-gpios = <&gpio1 13 GPIO_ACTIVE_HIGH>;
-		};
-	};
diff --git a/Documentation/devicetree/bindings/display/panel/innolux,p097pfg.yaml b/Documentation/devicetree/bindings/display/panel/innolux,p097pfg.yaml
new file mode 100644
index 000000000000..5a5f071627fb
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/innolux,p097pfg.yaml
@@ -0,0 +1,56 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/innolux,p097pfg.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Innolux P097PFG 9.7" 1536x2048 TFT LCD panel
+
+maintainers:
+  - Lin Huang <hl@rock-chips.com>
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    const: innolux,p097pfg
+
+  backlight: true
+  enable-gpios: true
+  reg: true
+
+  avdd-supply:
+    description: The regulator that provides positive voltage
+
+  avee-supply:
+    description: The regulator that provides negative voltage
+
+required:
+  - compatible
+  - reg
+  - avdd-supply
+  - avee-supply
+  - enable-gpios
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
+            compatible = "innolux,p097pfg";
+            reg = <0>;
+            avdd-supply = <&avdd>;
+            avee-supply = <&avee>;
+            backlight = <&backlight>;
+            enable-gpios = <&gpio1 13 GPIO_ACTIVE_HIGH>;
+        };
+    };
+
+...
-- 
2.20.1

