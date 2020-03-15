Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42EE0185CC9
	for <lists+linux-spi@lfdr.de>; Sun, 15 Mar 2020 14:44:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728634AbgCONol (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 15 Mar 2020 09:44:41 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33741 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728643AbgCONok (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 15 Mar 2020 09:44:40 -0400
Received: by mail-lf1-f65.google.com with SMTP id c20so11745367lfb.0;
        Sun, 15 Mar 2020 06:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C9SsIXb80tx1XgE4QnEZlqaCxjB5IA7rL4pD0MP0x+E=;
        b=fm/YHgYqGltGK7GE1wbGY7G8zo4Ns0vW+iU7MUUX5G2g9lBIU6erjBD9k0egBK3Qew
         fl4A1fRxvOeYzHUaevzlUjY/CHHDcfr23RYzMS8kqSNgVlzb42Nexg/R5i7SLTlPhG3i
         b6wpkipTvQupy3cSYX5bpwmfRkrOVjFQpz18z+kA/sKAj6xV2OFina1wqSALEPBHaP2Y
         CQY80hqeEHQYylOcffvPeyftA5GfosbNh1ZeSaaEdpGAQN0sZZix4uABB+p+YWR8Ev1T
         Z1VHRukdseG8fsVZbM0DRFvijkD7duIFuiCTwHM4xOP5Ec3dq/FF6MejPV9zTtjj+ZyU
         nPyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=C9SsIXb80tx1XgE4QnEZlqaCxjB5IA7rL4pD0MP0x+E=;
        b=E8zSxI/+xPriQGzqIYiia9lrsSdRkP9cjd7qUF3yikOgLVZe5JieAhPGuLkYv11/0c
         sXWhSFkWlGyl3oNQ+Ru9F9rz2XiD/a93ojZ+S+DuCAVU/W1rDnb/L7rYoSm+Gq1DdnlA
         Cjcb8zZGDfiikzovoh9FzK7T+h2sDpM1jm9lD6iVuMeJ4RTbuwxtW7/SzKHYX9zN/B8Y
         SnbpfqWrGDp0RNYA9eo/cmt4J75pE3uy7t2F5k0iX0XT+TbHQN8Dj4v6WKIROu6PDXH5
         gAoutad6+XrHFqtPqUxESlj8Ax86rAq0qHi0c8yvC/uuOTxtq33z8qDkDUn3BgPrOeSB
         L9PQ==
X-Gm-Message-State: ANhLgQ1o/rIScxelA2LWJzcUp8J5a3rZ8Te1ht0PZ34le+myo3XB+u7Q
        U2nFF+rEPTpN193l8sMvMNs=
X-Google-Smtp-Source: ADFU+vsmUIw0h+Jwxkxf146YRyd9fkTD5JMB5Hpegdo28MUyCENYV8foz/uamg8NsejFR3yfyJtcXg==
X-Received: by 2002:a19:ca46:: with SMTP id h6mr2077077lfj.108.1584279876898;
        Sun, 15 Mar 2020 06:44:36 -0700 (PDT)
Received: from saturn.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id a9sm23025212lfb.21.2020.03.15.06.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2020 06:44:36 -0700 (PDT)
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
Subject: [PATCH v1 04/36] dt-bindings: display: convert arm,versatile-tft-panel to DT Schema
Date:   Sun, 15 Mar 2020 14:43:44 +0100
Message-Id: <20200315134416.16527-5-sam@ravnborg.org>
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
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
---
 .../display/panel/arm,versatile-tft-panel.txt | 31 -----------
 .../panel/arm,versatile-tft-panel.yaml        | 51 +++++++++++++++++++
 2 files changed, 51 insertions(+), 31 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/panel/arm,versatile-tft-panel.txt
 create mode 100644 Documentation/devicetree/bindings/display/panel/arm,versatile-tft-panel.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/arm,versatile-tft-panel.txt b/Documentation/devicetree/bindings/display/panel/arm,versatile-tft-panel.txt
deleted file mode 100644
index 0601a9e34703..000000000000
--- a/Documentation/devicetree/bindings/display/panel/arm,versatile-tft-panel.txt
+++ /dev/null
@@ -1,31 +0,0 @@
-ARM Versatile TFT Panels
-
-These panels are connected to the daughterboards found on the
-ARM Versatile reference designs.
-
-This device node must appear as a child to a "syscon"-compatible
-node.
-
-Required properties:
-- compatible: should be "arm,versatile-tft-panel"
-
-Required subnodes:
-- port: see display/panel/panel-common.yaml, graph.txt
-
-
-Example:
-
-sysreg@0 {
-	compatible = "arm,versatile-sysreg", "syscon", "simple-mfd";
-	reg = <0x00000 0x1000>;
-
-	panel: display@0 {
-		compatible = "arm,versatile-tft-panel";
-
-		port {
-			panel_in: endpoint {
-				remote-endpoint = <&foo>;
-			};
-		};
-	};
-};
diff --git a/Documentation/devicetree/bindings/display/panel/arm,versatile-tft-panel.yaml b/Documentation/devicetree/bindings/display/panel/arm,versatile-tft-panel.yaml
new file mode 100644
index 000000000000..8ad7305887b4
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/arm,versatile-tft-panel.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/arm,versatile-tft-panel.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ARM Versatile TFT Panels
+
+maintainers:
+  - Linus Walleij <linus.walleij@linaro.org>
+
+description: |
+  These panels are connected to the daughterboards found on the
+  ARM Versatile reference designs.
+
+  This device node must appear as a child to a "syscon"-compatible
+  node.
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    const: arm,versatile-tft-panel
+
+  port: true
+
+required:
+  - compatible
+  - port
+
+additionalProperties: false
+
+examples:
+  - |
+    sysreg {
+        compatible = "arm,versatile-sysreg", "syscon", "simple-mfd";
+        reg = <0x00000 0x1000>;
+
+        panel: display@0 {
+            compatible = "arm,versatile-tft-panel";
+
+            port {
+                panel_in: endpoint {
+                    remote-endpoint = <&foo>;
+                };
+            };
+        };
+    };
+
+...
-- 
2.20.1

