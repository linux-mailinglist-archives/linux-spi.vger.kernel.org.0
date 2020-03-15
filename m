Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A994C185CEF
	for <lists+linux-spi@lfdr.de>; Sun, 15 Mar 2020 14:45:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728676AbgCONpG (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 15 Mar 2020 09:45:06 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46544 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728668AbgCONpG (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 15 Mar 2020 09:45:06 -0400
Received: by mail-lj1-f193.google.com with SMTP id d23so15558028ljg.13;
        Sun, 15 Mar 2020 06:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nu/r+Huhn6AYJOGmQ6c5zAmhio2Nquq+BTmg7Je8VJM=;
        b=m1HCMOwaFHZJcQOdFpg0mAHY0vsRfDWBU9O9sekPG3fDXSGhoFCaa1kbavjJru4FZP
         ORqnY6LlsdmHLqRG9KAzOcbOMDWIA05+DxP7C5ob8WPsAZckqD2joyrVST3aA3q4vVH2
         kZNHEtfjjbdShYc5WkQPWyqEGBGLRYui3eCHUgQxJjqwYpedh9ndLBBkXoLnGuVBuQF8
         x+PwZj0juwgKKy3/8t4rN7IQrW7vkZNju3+7sYmGAy+k0I8Ji2zejZNg38kudL/ywxn1
         jHiea+QwEm0Sfj5Yu2Tal1gQFsIxBck1aFy1M8B0b+QcOuTSGA9Ogjy/VvUogpMiNJzb
         c0GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=nu/r+Huhn6AYJOGmQ6c5zAmhio2Nquq+BTmg7Je8VJM=;
        b=pWYtFrheIniCcySLj/abBm9XyaVWK0dk04ztgX6CSWcFzsaiIg3Q/l7t3QmiDMAMqv
         XZAmdzeW+ECtY0gCZsm8P6f+cRaElpVgZAzbODZ+dUTfP5QT0mglk+sNgTACFiWFhk4k
         lvIXFehoytf/T04Uez4TRgNvgqXFwxeuoxarhP099jJCKZmKInlVM91rzzKJWm5B7POA
         kw0K4VwzXo8Fn4IiTlOKoqLlrqrvVLcHryUwsoNNWh7zTxvdgLiyCZHWqeUZPQ7spJ8z
         jHczrUa7nbbSx36esN8VCiscLveEb5Jiw0iIwwPS2qB/JdOIZnqkX3dinBjyjGAtp4ct
         P3iA==
X-Gm-Message-State: ANhLgQ1jMuGkRzyMOtchi9pDPHvwEMDu+tWLKOUwVB5wfj9VVdd5e9Oz
        LOXqac40URMBQDGf3tn+h8XxwCOwOR0=
X-Google-Smtp-Source: ADFU+vvlJTe4GHQcEV/ZdV0DbLDKFm/ZvBiA+whjD5EOIPP7wCtCV7p8oGshivkflNE/azzSGlNeVw==
X-Received: by 2002:a2e:87d7:: with SMTP id v23mr12712633ljj.10.1584279902237;
        Sun, 15 Mar 2020 06:45:02 -0700 (PDT)
Received: from saturn.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id a9sm23025212lfb.21.2020.03.15.06.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2020 06:45:01 -0700 (PDT)
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
Subject: [PATCH v1 16/36] dt-bindings: display: convert lg,lg4573 to DT Schema
Date:   Sun, 15 Mar 2020 14:43:56 +0100
Message-Id: <20200315134416.16527-17-sam@ravnborg.org>
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
Cc: Heiko Schocher <hs@denx.de>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
---
 .../bindings/display/panel/lg,lg4573.txt      | 19 ---------
 .../bindings/display/panel/lg,lg4573.yaml     | 41 +++++++++++++++++++
 2 files changed, 41 insertions(+), 19 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/panel/lg,lg4573.txt
 create mode 100644 Documentation/devicetree/bindings/display/panel/lg,lg4573.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/lg,lg4573.txt b/Documentation/devicetree/bindings/display/panel/lg,lg4573.txt
deleted file mode 100644
index 824441f4e95a..000000000000
--- a/Documentation/devicetree/bindings/display/panel/lg,lg4573.txt
+++ /dev/null
@@ -1,19 +0,0 @@
-LG LG4573 TFT Liquid Crystal Display with SPI control bus
-
-Required properties:
-  - compatible: "lg,lg4573"
-  - reg: address of the panel on the SPI bus
-
-The panel must obey rules for SPI slave device specified in document [1].
-
-[1]: Documentation/devicetree/bindings/spi/spi-bus.txt
-
-Example:
-
-	lcd_panel: display@0 {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		compatible = "lg,lg4573";
-		spi-max-frequency = <10000000>;
-		reg = <0>;
-	};
diff --git a/Documentation/devicetree/bindings/display/panel/lg,lg4573.yaml b/Documentation/devicetree/bindings/display/panel/lg,lg4573.yaml
new file mode 100644
index 000000000000..b5b475cf8406
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/lg,lg4573.yaml
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/lg,lg4573.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: LG LG4573 TFT Liquid Crystal Display with SPI control bus
+
+maintainers:
+  - Heiko Schocher <hs@denx.de>
+
+allOf:
+  - $ref: ../../spi/spi-slave.yaml#
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    const: lg,lg4573
+
+  reg: true
+  spi-max-frequency: true
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    spi {
+        compatible = "fsl,imx6q-ecspi", "fsl,imx51-ecspi";
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        lcd_panel: display@0 {
+            compatible = "lg,lg4573";
+            spi-max-frequency = <10000000>;
+            reg = <0>;
+        };
+    };
+
+...
-- 
2.20.1

