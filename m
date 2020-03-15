Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA5B8185CD5
	for <lists+linux-spi@lfdr.de>; Sun, 15 Mar 2020 14:44:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728648AbgCONos (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 15 Mar 2020 09:44:48 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:42477 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728658AbgCONos (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 15 Mar 2020 09:44:48 -0400
Received: by mail-lf1-f66.google.com with SMTP id t21so11694178lfe.9;
        Sun, 15 Mar 2020 06:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OWdCcK1waThtoepd7BYaq8MoQGbRPjR7ssIGl9jD1xY=;
        b=YSDzbdm4qZdmbd9LTRerOaVNxCvdNWkRyn/yU3TbuIPImFjaM6FXupe/cBOTPgfatz
         ci66uHuB16rB+LKkyoRJlDaheIF3gaVQIk2rW+wtqmrIcj3s+LoLf7BXvY22wI3Ue02U
         9Xq8YK1Xc8E0Ppac1XGbHpoK9keUbfb0G3zs+cehLapMQT+I/maKaPKWMLcrYYr0XpDK
         MxHaTxvpC/oxqq29BwiXfTNBLkm2N179/isspU3vWjuxeJn263d0d96zPH4K+N07zBix
         CyAZBPVAPXO92Kpha7Ri2zuWPjgRKHC4PnNB5hFk2WmfZP5IibycdLeuMXsYyQ6ySjwm
         Zu0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=OWdCcK1waThtoepd7BYaq8MoQGbRPjR7ssIGl9jD1xY=;
        b=F/EYKmjVNVCZCtoFyrfKhix+AotVX/HhxghEsQl3fg/v8JwkKxsRyHOlsNSybbYtKR
         owauEX3G8+4O6u27SoQJZ7jTr6XF4nhHSpj3Rr2rIMhkcPIKaVQM8ISnu7JoZHD8+6kn
         OCkeU56vPO0hesYjtyCpk+cstx+0WYJ60/OAZq3gbnuvcnNo4BWkNnBDIRTAHJoKNv9d
         ZUdSM7GTV+UiPXEzxwTAsBpI9ZveoojNY6DEWkAaYwQyz/PzBZEk7lCdRtdCkufk81Cw
         PzaPe6EpXBwAAp+SxglUIDqvxhr1q5lklH1+rHFmAOaiFGoW2UG4mMoJlkc44KOvi4df
         J+wg==
X-Gm-Message-State: ANhLgQ2FPEk8owTCL/fIZeGVsnOM+M0Ook2ph3FuJRvc2gitNZoSIo7R
        5py2hKoFvRgm78eNDTAGPiI=
X-Google-Smtp-Source: ADFU+vvMNL4/OCBcGRfP86JCNs0Uu0s4FaODwXFU6z2OwE94xN979qCQv/xlOUmU0/daCIjp3W2TBQ==
X-Received: by 2002:a19:80e:: with SMTP id 14mr13714096lfi.206.1584279885499;
        Sun, 15 Mar 2020 06:44:45 -0700 (PDT)
Received: from saturn.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id a9sm23025212lfb.21.2020.03.15.06.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2020 06:44:45 -0700 (PDT)
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
Subject: [PATCH v1 08/36] dt-bindings: display: convert feiyang,fy07024di26a30d to DT Schema
Date:   Sun, 15 Mar 2020 14:43:48 +0100
Message-Id: <20200315134416.16527-9-sam@ravnborg.org>
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
Cc: Jagan Teki <jagan@amarulasolutions.com>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
---
 .../display/panel/feiyang,fy07024di26a30d.txt | 20 -------
 .../panel/feiyang,fy07024di26a30d.yaml        | 56 +++++++++++++++++++
 2 files changed, 56 insertions(+), 20 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/panel/feiyang,fy07024di26a30d.txt
 create mode 100644 Documentation/devicetree/bindings/display/panel/feiyang,fy07024di26a30d.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/feiyang,fy07024di26a30d.txt b/Documentation/devicetree/bindings/display/panel/feiyang,fy07024di26a30d.txt
deleted file mode 100644
index 82caa7b65ae8..000000000000
--- a/Documentation/devicetree/bindings/display/panel/feiyang,fy07024di26a30d.txt
+++ /dev/null
@@ -1,20 +0,0 @@
-Feiyang FY07024DI26A30-D 7" MIPI-DSI LCD Panel
-
-Required properties:
-- compatible: must be "feiyang,fy07024di26a30d"
-- reg: DSI virtual channel used by that screen
-- avdd-supply: analog regulator dc1 switch
-- dvdd-supply: 3v3 digital regulator
-- reset-gpios: a GPIO phandle for the reset pin
-
-Optional properties:
-- backlight: phandle for the backlight control.
-
-panel@0 {
-	compatible = "feiyang,fy07024di26a30d";
-	reg = <0>;
-	avdd-supply = <&reg_dc1sw>;
-	dvdd-supply = <&reg_dldo2>;
-	reset-gpios = <&pio 3 24 GPIO_ACTIVE_HIGH>; /* LCD-RST: PD24 */
-	backlight = <&backlight>;
-};
diff --git a/Documentation/devicetree/bindings/display/panel/feiyang,fy07024di26a30d.yaml b/Documentation/devicetree/bindings/display/panel/feiyang,fy07024di26a30d.yaml
new file mode 100644
index 000000000000..4bf4498d007a
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/feiyang,fy07024di26a30d.yaml
@@ -0,0 +1,56 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/feiyang,fy07024di26a30d.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Feiyang FY07024DI26A30-D 7" MIPI-DSI LCD Panel
+
+maintainers:
+  - Jagan Teki <jagan@amarulasolutions.com>
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    const: feiyang,fy07024di26a30d
+
+  backlight: true
+  reg : true
+  reset-gpios: true
+
+  avdd-supply:
+    description: analog regulator dc1 switch
+
+  dvdd-supply:
+    description: 3v3 digital regulator
+
+required:
+ - compatible
+ - reg
+ - reset-gpios
+ - avdd-supply
+ - dvdd-supply
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
+            compatible = "feiyang,fy07024di26a30d";
+            reg = <0>;
+            avdd-supply = <&reg_dc1sw>;
+            dvdd-supply = <&reg_dldo2>;
+            reset-gpios = <&pio 3 24 GPIO_ACTIVE_HIGH>; /* LCD-RST: PD24 */
+            backlight = <&backlight>;
+        };
+    };
+
+...
-- 
2.20.1

