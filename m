Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8C7185CDE
	for <lists+linux-spi@lfdr.de>; Sun, 15 Mar 2020 14:44:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728665AbgCONoz (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 15 Mar 2020 09:44:55 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35381 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728658AbgCONoz (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 15 Mar 2020 09:44:55 -0400
Received: by mail-lj1-f196.google.com with SMTP id u12so15626856ljo.2;
        Sun, 15 Mar 2020 06:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=85+JPdL0riE6y9vKE6MRhU8yOWIkV4ii4OdHXgpGAjY=;
        b=iQA17Ulo+My4nZO1xTunXJ/1o8QZU5pyq+Jatgtep5c1GDb/OVWO9pxqOeCI6+kQFM
         8qNt9KvDpO0B1n/luViP2nBRN/mjstvu1YU+nol/eCvDjlxh1RruBN0fEBHFJRBMIHUx
         w8/mS0Qq2f6nrNBc2QLfkxFBWhewJyyg9h5jC9qoQp5jz+P7fwdarLVEEDvTtXsZpm45
         SRuZaVWvVSQ6w3jtViQsNbmwUivJjPamVPlpVGcxLubwNe2+5mmJ26kG1uEiIEHpKfVf
         p5rr3p1Zz3AlIrRLjfKR8aC5DaCqu5kR2uMWF51QbTyfuIIAtAMXhGOqvGLQTLJM1GEe
         CNqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=85+JPdL0riE6y9vKE6MRhU8yOWIkV4ii4OdHXgpGAjY=;
        b=ny+Ax2e8QAfu14HPg8ep6dlqx5WxO/U1+AtRPpJYGdFDdWEry+dfXRjUmJ+O5QsqqC
         GeOe8Bc9IzU4lm8eme74HwT1RKfg7CA2L7ctSG9p0rRn/C2StcYJHrNQ0A3gDSlIBeEd
         ttDG+GzqLvtDZM6QsPVz3AlMyuX6L6K7eEsJgzjc9QSRQeA+WL9fq9Qgg8WMNl8UaSaU
         3dtf7DJoCeY6awbwW+TckGIRDRtV9QwSVZzWNPkWUqAS5fE1OF98Ay2U3DbfPYdJaoMt
         GigAkpECCa6GsYj/2qIjXbX63XuzvZej295jIyd1wqr6fZGJriWtoT9KVN4ZhaztJ0yS
         M59w==
X-Gm-Message-State: ANhLgQ2LyV4bZqCzlzMSXNI3SLZdENscC+wmfm94jT+7QyuBH33AZUEK
        vio9YoUK+iNDx7hEqhu3Wso=
X-Google-Smtp-Source: ADFU+vsxRHkh8Taf7X9qBubBFsYa1RVHoV8i/HWKAno4brv64JuVSrPLYD3RFxAPK17fcRd3Yw9fmA==
X-Received: by 2002:a2e:b602:: with SMTP id r2mr14217474ljn.45.1584279891718;
        Sun, 15 Mar 2020 06:44:51 -0700 (PDT)
Received: from saturn.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id a9sm23025212lfb.21.2020.03.15.06.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2020 06:44:51 -0700 (PDT)
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
Subject: [PATCH v1 11/36] dt-bindings: display: convert innolux,p120zdg-bf1 to DT Schema
Date:   Sun, 15 Mar 2020 14:43:51 +0100
Message-Id: <20200315134416.16527-12-sam@ravnborg.org>
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
Cc: Sandeep Panda <spanda@codeaurora.org>
Cc: Douglas Anderson <dianders@chromium.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
---
 .../display/panel/innolux,p120zdg-bf1.txt     | 22 ----------
 .../display/panel/innolux,p120zdg-bf1.yaml    | 43 +++++++++++++++++++
 2 files changed, 43 insertions(+), 22 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/panel/innolux,p120zdg-bf1.txt
 create mode 100644 Documentation/devicetree/bindings/display/panel/innolux,p120zdg-bf1.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/innolux,p120zdg-bf1.txt b/Documentation/devicetree/bindings/display/panel/innolux,p120zdg-bf1.txt
deleted file mode 100644
index 513f03466aba..000000000000
--- a/Documentation/devicetree/bindings/display/panel/innolux,p120zdg-bf1.txt
+++ /dev/null
@@ -1,22 +0,0 @@
-Innolux P120ZDG-BF1 12.02 inch eDP 2K display panel
-
-This binding is compatible with the simple-panel binding, which is specified
-in simple-panel.txt in this directory.
-
-Required properties:
-- compatible: should be "innolux,p120zdg-bf1"
-- power-supply: regulator to provide the supply voltage
-
-Optional properties:
-- enable-gpios: GPIO pin to enable or disable the panel
-- backlight: phandle of the backlight device attached to the panel
-- no-hpd: If HPD isn't hooked up; add this property.
-
-Example:
-	panel_edp: panel-edp {
-		compatible = "innolux,p120zdg-bf1";
-		enable-gpios = <&msmgpio 31 GPIO_ACTIVE_LOW>;
-		power-supply = <&pm8916_l2>;
-		backlight = <&backlight>;
-		no-hpd;
-	};
diff --git a/Documentation/devicetree/bindings/display/panel/innolux,p120zdg-bf1.yaml b/Documentation/devicetree/bindings/display/panel/innolux,p120zdg-bf1.yaml
new file mode 100644
index 000000000000..42f97b7b86b2
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/innolux,p120zdg-bf1.yaml
@@ -0,0 +1,43 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/innolux,p120zdg-bf1.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Innolux P120ZDG-BF1 12.02 inch eDP 2K display panel
+
+maintainers:
+  - Sandeep Panda <spanda@codeaurora.org>
+  - Douglas Anderson <dianders@chromium.org>
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    const: innolux,p120zdg-bf1
+
+  enable-gpios: true
+  power-supply: true
+  backlight: true
+  no-hpd: true
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
+    panel_edp: panel-edp {
+        compatible = "innolux,p120zdg-bf1";
+        enable-gpios = <&msmgpio 31 GPIO_ACTIVE_LOW>;
+        power-supply = <&pm8916_l2>;
+        backlight = <&backlight>;
+        no-hpd;
+    };
+
+...
-- 
2.20.1

