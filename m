Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D922185D25
	for <lists+linux-spi@lfdr.de>; Sun, 15 Mar 2020 14:45:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728715AbgCONpn (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 15 Mar 2020 09:45:43 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38879 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728709AbgCONpn (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 15 Mar 2020 09:45:43 -0400
Received: by mail-lf1-f65.google.com with SMTP id n13so9906931lfh.5;
        Sun, 15 Mar 2020 06:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0i0vgiKfLOmpvuqPVA7m37qiPqNJFhGX4H4IYa6i4ig=;
        b=lWl9RmPxxkjrxxWHn9utIetUaSmb9LWP3dVx4LimFMdzM1pk4BlRSvi1ySK/IEufn0
         sX03MMuFa9fOc7XV7XzjU44uaC2qHvytzCv/+Eec+pOEMjXwSldTW15Lw7xTl6U3EYvo
         iOlegHCxdN/qHX4wOAJj25qdQSlTLnUA3Kq0WFs9COZnKCyu6bCfQ3jZ2QjOFu59reGJ
         xm9slFbDqTG90364EIv3Blcrj1s71u4H0URzNu+uwzEBwp7oqm0ryY4zNqFXWsrZdHBA
         mQdfbgd/THjSCD/WHIE/PmPFPFgduBAcck5FZUsO5830N8egRmhNMnThEqK2WibiCBSf
         C8iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=0i0vgiKfLOmpvuqPVA7m37qiPqNJFhGX4H4IYa6i4ig=;
        b=TNcW03yskj6IONqa1bnvGWYiEtqTBDu9XAZxBn3Duzw/mazdPwnvu8GMM3ALio7hLV
         NaHrm9823AfJ5dpuENyLPgVckZiM63ZfDOPvW2ZcgyxmWe1xNkoMYw/TVAP7JkllOdSB
         2j0+ZvyNTV5Zpp9oOd9oY1tsFwgKRW7yg9U424lRUvWqgl05ByYNSM2JayW9Fh00CjyI
         etIOjB3AdJoUmS2q6Dr/c5mg67CjSKVjwpSRkB340Tqo85/eRerNLqmU+l8WlPmI+u2g
         oZ3SowKcGB5eq+rEYqAiPuPjVNJMu0WW3wwjRRPcGe42AxlL7Md3HKYpxHBQrHwJRk1/
         mJNA==
X-Gm-Message-State: ANhLgQ3mOL1Ah66o806jISM+k5akmZOghjD+0hn0E8b7Wgy8NAQ9Ms1K
        eUSTcBwKNS+zWIMrc4mxS8g=
X-Google-Smtp-Source: ADFU+vus3KIMVrdLNQumK21IeQLFPAIhvE0B8wkk6LKoU2xSpSVPWgRyVc6zyWu+4lJgoeI03mbkew==
X-Received: by 2002:a19:80e:: with SMTP id 14mr13715743lfi.206.1584279940829;
        Sun, 15 Mar 2020 06:45:40 -0700 (PDT)
Received: from saturn.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id a9sm23025212lfb.21.2020.03.15.06.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2020 06:45:40 -0700 (PDT)
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
Subject: [PATCH v1 35/36] dt-bindings: display: convert lgphilips,lb035q02 to DT Schema
Date:   Sun, 15 Mar 2020 14:44:15 +0100
Message-Id: <20200315134416.16527-36-sam@ravnborg.org>
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
 .../display/panel/lgphilips,lb035q02.txt      | 33 ------------
 .../display/panel/lgphilips,lb035q02.yaml     | 54 +++++++++++++++++++
 2 files changed, 54 insertions(+), 33 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/panel/lgphilips,lb035q02.txt
 create mode 100644 Documentation/devicetree/bindings/display/panel/lgphilips,lb035q02.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/lgphilips,lb035q02.txt b/Documentation/devicetree/bindings/display/panel/lgphilips,lb035q02.txt
deleted file mode 100644
index 1a1e653e5407..000000000000
--- a/Documentation/devicetree/bindings/display/panel/lgphilips,lb035q02.txt
+++ /dev/null
@@ -1,33 +0,0 @@
-LG.Philips LB035Q02 Panel
-=========================
-
-Required properties:
-- compatible: "lgphilips,lb035q02"
-- enable-gpios: panel enable gpio
-
-Optional properties:
-- label: a symbolic name for the panel
-
-Required nodes:
-- Video port for DPI input
-
-Example
--------
-
-lcd-panel: panel@0 {
-	compatible = "lgphilips,lb035q02";
-	reg = <0>;
-	spi-max-frequency = <100000>;
-	spi-cpol;
-	spi-cpha;
-
-	label = "lcd";
-
-	enable-gpios = <&gpio7 7 0>;
-
-	port {
-		lcd_in: endpoint {
-			remote-endpoint = <&dpi_out>;
-		};
-	};
-};
diff --git a/Documentation/devicetree/bindings/display/panel/lgphilips,lb035q02.yaml b/Documentation/devicetree/bindings/display/panel/lgphilips,lb035q02.yaml
new file mode 100644
index 000000000000..09eba4090736
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/lgphilips,lb035q02.yaml
@@ -0,0 +1,54 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/lgphilips,lb035q02.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: LG.Philips LB035Q02 Panel
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
+    const: lgphilips,lb035q02
+
+  label: true
+  enable-gpios: true
+  port: true
+
+required:
+  - compatible
+  - enable-gpios
+  - port
+
+examples:
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        panel: panel@0 {
+            compatible = "lgphilips,lb035q02";
+            reg = <0>;
+            spi-max-frequency = <100000>;
+            spi-cpol;
+            spi-cpha;
+
+            label = "lcd";
+
+            enable-gpios = <&gpio7 7 0>;
+
+            port {
+                lcd_in: endpoint {
+                    remote-endpoint = <&dpi_out>;
+                };
+            };
+        };
+    };
+
+...
-- 
2.20.1

