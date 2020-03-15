Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2B12185D0A
	for <lists+linux-spi@lfdr.de>; Sun, 15 Mar 2020 14:45:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728696AbgCONpZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 15 Mar 2020 09:45:25 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39043 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728628AbgCONpZ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 15 Mar 2020 09:45:25 -0400
Received: by mail-lj1-f193.google.com with SMTP id f10so15604530ljn.6;
        Sun, 15 Mar 2020 06:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YjUy1ADd38ONuUoZQBzdcbnlxdYpv/fTDjjTTwszQr4=;
        b=GylaU3jU+HIKMfeaQ7IeuU+xs4umCfPUVuYcOIxrPFuj/ZoaGAtx58hYWArlZA7EOT
         SDvJNDyUrfLHLajV+sz/k4RTvtE9kp3csCoYbzSLCzYW704ESkcsi0KgQ69hDoUImWgM
         EUQQEB7r/5UV1oB/iSWNd37KO5mhbW92PtfiGUheYmBP13oqryI8JOhLZP2Md3qod3+w
         4hjjEXWUNuLXk2Jd2ZXKxU/5Gu23PSR2QZGsLGI5zdZzVZ4G76ndGj3+FQTKRMys5+xF
         LFg3F+ll2IZuKvh9rSjSrmfbA4kV/gR+L9BD1nzZIWwouuK3+qP/SUD29B0gzINCHZBS
         sFwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=YjUy1ADd38ONuUoZQBzdcbnlxdYpv/fTDjjTTwszQr4=;
        b=mGoEaW+IiwxiRLeVFAsq0sOADvphPqf0cmBXvGlLS3Me0vrXpJPkL/UKdjmq1i+cxo
         pku5q1TqfEOpdfj71GpR2DZQ3hqZ6MnTPJ85790RWlpWctkrNXOEmWkzcRLIhOy0uig4
         7ING4h2aAwJvfKQ7OyC7SLIP8GpNo7sGgKTrBSw0rBlXYkJYjo0iD3rCCCQpQFZ73Jnu
         v3FRExUjZXC89cHREij+CaAAwa6hQmuvqFCmRBOM3cMqpso1mE8u2vJSQMO/1VuURRu0
         TFfrCWygeMFRZChwAZQQ+YriiBr+Ri5Xb6ew+R1dXBPQ16nNRsZi5JrSi8K4fqmC02CY
         pt6w==
X-Gm-Message-State: ANhLgQ3cvqbr/ScLWVC/yf3b1W+LFPVOuatUZQbxv/msNskZJJdiod6+
        27S7o6mVCfo9z5V/uoj1SPg=
X-Google-Smtp-Source: ADFU+vuBCcTjGBb970zhwI+lTBV4D9X+F5N29JU57gnyuBXoYAnBstRC+Mb4jD/+P4F27+Qag9SyXg==
X-Received: by 2002:a2e:8991:: with SMTP id c17mr12506536lji.278.1584279922586;
        Sun, 15 Mar 2020 06:45:22 -0700 (PDT)
Received: from saturn.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id a9sm23025212lfb.21.2020.03.15.06.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2020 06:45:22 -0700 (PDT)
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
Subject: [PATCH v1 26/36] dt-bindings: display: convert sony,acx565akm to DT Schema
Date:   Sun, 15 Mar 2020 14:44:06 +0100
Message-Id: <20200315134416.16527-27-sam@ravnborg.org>
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
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
---
 .../bindings/display/panel/sony,acx565akm.txt | 30 -----------
 .../display/panel/sony,acx565akm.yaml         | 53 +++++++++++++++++++
 2 files changed, 53 insertions(+), 30 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/panel/sony,acx565akm.txt
 create mode 100644 Documentation/devicetree/bindings/display/panel/sony,acx565akm.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/sony,acx565akm.txt b/Documentation/devicetree/bindings/display/panel/sony,acx565akm.txt
deleted file mode 100644
index e12333280749..000000000000
--- a/Documentation/devicetree/bindings/display/panel/sony,acx565akm.txt
+++ /dev/null
@@ -1,30 +0,0 @@
-Sony ACX565AKM SDI Panel
-========================
-
-Required properties:
-- compatible: "sony,acx565akm"
-
-Optional properties:
-- label: a symbolic name for the panel
-- reset-gpios: panel reset gpio
-
-Required nodes:
-- Video port for SDI input
-
-Example
--------
-
-acx565akm@2 {
-	compatible = "sony,acx565akm";
-	spi-max-frequency = <6000000>;
-	reg = <2>;
-
-	label = "lcd";
-	reset-gpios = <&gpio3 26 GPIO_ACTIVE_HIGH>; /* 90 */
-
-	port {
-		lcd_in: endpoint {
-			remote-endpoint = <&sdi_out>;
-		};
-	};
-};
diff --git a/Documentation/devicetree/bindings/display/panel/sony,acx565akm.yaml b/Documentation/devicetree/bindings/display/panel/sony,acx565akm.yaml
new file mode 100644
index 000000000000..a0b1abb9f33d
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/sony,acx565akm.yaml
@@ -0,0 +1,53 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/sony,acx565akm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sony ACX565AKM SDI Panel
+
+maintainers:
+  - Tomi Valkeinen <tomi.valkeinen@ti.com>
+
+allOf:
+  - $ref: panel-common.yaml#
+  - $ref: ../../spi/spi-slave.yaml#
+
+properties:
+  compatible:
+    const: sony,acx565akm
+
+  label: true
+  reset-gpios: true
+  port: true
+
+required:
+  - compatible
+  - port
+
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        acx565akm@2 {
+            compatible = "sony,acx565akm";
+            spi-max-frequency = <6000000>;
+            reg = <2>;
+
+            label = "lcd";
+            reset-gpios = <&gpio3 26 GPIO_ACTIVE_HIGH>; /* 90 */
+
+            port {
+                lcd_in: endpoint {
+                    remote-endpoint = <&sdi_out>;
+                };
+            };
+        };
+    };
+
+...
-- 
2.20.1

