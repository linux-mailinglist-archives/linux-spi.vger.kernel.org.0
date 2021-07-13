Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 290F83C7709
	for <lists+linux-spi@lfdr.de>; Tue, 13 Jul 2021 21:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234586AbhGMTiK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 13 Jul 2021 15:38:10 -0400
Received: from mail-io1-f53.google.com ([209.85.166.53]:45902 "EHLO
        mail-io1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbhGMTiJ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 13 Jul 2021 15:38:09 -0400
Received: by mail-io1-f53.google.com with SMTP id y16so5586142iol.12;
        Tue, 13 Jul 2021 12:35:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uTODzrzCCYkqmU43lyE/fyW+NoXwq5Q/GjDtygunFEc=;
        b=iO4BUZUJLFNvKPuiI4UIbbTtndp02DH32Yp6aWMZ4IlVuuENjfPRBUhhZU/unQczXW
         L6dFNbxfgD2ICbhZJfBpqHYTSpLTspmq3ySBcqGkuc0cXTYf1PqnqRmcM8hI3xx/sMlB
         PNgjNJd9gqUN6ZN+uRrC63WlxpqSezTgJwU/7k/2h26y4iehZx50Ko22exX8i8NEE6h0
         80RBT1q//aapr11m3Aqja4SudjuqG7IvQpYmvUWWrp33nYMQ6KUkhh/ExL+u4faokJrL
         yk1Ew4rhOdVVlSaaMOI+luwfItLLwcOpj07+V10Qme8rufcdOmwIdytxdH3k0eWJl9Bz
         gOjg==
X-Gm-Message-State: AOAM532a9w4d1/n1UGaqv17ivr0i3bnddsxYvyir+8lAhsan6oXWOjSb
        R3JpT2pYAqFThSV2/zjTvoUM4gB8zw==
X-Google-Smtp-Source: ABdhPJy4/+C32k6S27yxBU2pwjcIfGXKihXQFOQZytH7CySUiWd9fjMmFBmQ8QxsNTWxPOytTbn37Q==
X-Received: by 2002:a6b:f813:: with SMTP id o19mr4273065ioh.49.1626204917690;
        Tue, 13 Jul 2021 12:35:17 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.248])
        by smtp.googlemail.com with ESMTPSA id b2sm7219964ioj.19.2021.07.13.12.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 12:35:17 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Saravanan Sekar <sravanhome@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Troy Kisky <troy.kisky@boundarydevices.com>,
        linux-hwmon@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-spi@vger.kernel.org
Subject: [PATCH] dt-bindings: Move fixed string 'patternProperties' to 'properties'
Date:   Tue, 13 Jul 2021 13:35:14 -0600
Message-Id: <20210713193514.690894-1-robh@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

There's no need for fixed strings to be under 'patternProperties', so move
them under 'properties' instead.

Cc: Jean Delvare <jdelvare@suse.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: Saravanan Sekar <sravanhome@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jagan Teki <jagan@amarulasolutions.com>
Cc: Troy Kisky <troy.kisky@boundarydevices.com>
Cc: linux-hwmon@vger.kernel.org
Cc: linux-phy@lists.infradead.org
Cc: linux-spi@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/hwmon/adt7475.yaml    | 22 ++++----
 .../bindings/phy/ti,phy-j721e-wiz.yaml        | 56 +++++++++----------
 .../bindings/regulator/mps,mpq7920.yaml       |  6 +-
 .../regulator/nxp,pf8x00-regulator.yaml       |  3 +-
 .../bindings/spi/spi-controller.yaml          | 32 +++++------
 5 files changed, 60 insertions(+), 59 deletions(-)

diff --git a/Documentation/devicetree/bindings/hwmon/adt7475.yaml b/Documentation/devicetree/bindings/hwmon/adt7475.yaml
index ad0ec9f35bd8..7d9c083632b9 100644
--- a/Documentation/devicetree/bindings/hwmon/adt7475.yaml
+++ b/Documentation/devicetree/bindings/hwmon/adt7475.yaml
@@ -39,17 +39,7 @@ properties:
   reg:
     maxItems: 1
 
-patternProperties:
-  "^adi,bypass-attenuator-in[0-4]$":
-    description: |
-      Configures bypassing the individual voltage input attenuator. If
-      set to 1 the attenuator is bypassed if set to 0 the attenuator is
-      not bypassed. If the property is absent then the attenuator
-      retains it's configuration from the bios/bootloader.
-    $ref: /schemas/types.yaml#/definitions/uint32
-    enum: [0, 1]
-
-  "^adi,pwm-active-state$":
+  adi,pwm-active-state:
     description: |
       Integer array, represents the active state of the pwm outputs If set to 0
       the pwm uses a logic low output for 100% duty cycle. If set to 1 the pwm
@@ -61,6 +51,16 @@ patternProperties:
       enum: [0, 1]
       default: 1
 
+patternProperties:
+  "^adi,bypass-attenuator-in[0-4]$":
+    description: |
+      Configures bypassing the individual voltage input attenuator. If
+      set to 1 the attenuator is bypassed if set to 0 the attenuator is
+      not bypassed. If the property is absent then the attenuator
+      retains it's configuration from the bios/bootloader.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1]
+
 required:
   - compatible
   - reg
diff --git a/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml b/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
index 5272b6f284ba..dcd63908aeae 100644
--- a/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
+++ b/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
@@ -77,6 +77,34 @@ properties:
       Type-C spec states minimum CC pin debounce of 100 ms and maximum
       of 200 ms. However, some solutions might need more than 200 ms.
 
+  refclk-dig:
+    type: object
+    description: |
+      WIZ node should have subnode for refclk_dig to select the reference
+      clock source for the reference clock used in the PHY and PMA digital
+      logic.
+    properties:
+      clocks:
+        minItems: 2
+        maxItems: 4
+        description: Phandle to two (Torrent) or four (Sierra) clock nodes representing
+          the inputs to refclk_dig
+
+      "#clock-cells":
+        const: 0
+
+      assigned-clocks:
+        maxItems: 1
+
+      assigned-clock-parents:
+        maxItems: 1
+
+    required:
+      - clocks
+      - "#clock-cells"
+      - assigned-clocks
+      - assigned-clock-parents
+
 patternProperties:
   "^pll[0|1]-refclk$":
     type: object
@@ -121,34 +149,6 @@ patternProperties:
       - clocks
       - "#clock-cells"
 
-  "^refclk-dig$":
-    type: object
-    description: |
-      WIZ node should have subnode for refclk_dig to select the reference
-      clock source for the reference clock used in the PHY and PMA digital
-      logic.
-    properties:
-      clocks:
-        minItems: 2
-        maxItems: 4
-        description: Phandle to two (Torrent) or four (Sierra) clock nodes representing
-          the inputs to refclk_dig
-
-      "#clock-cells":
-        const: 0
-
-      assigned-clocks:
-        maxItems: 1
-
-      assigned-clock-parents:
-        maxItems: 1
-
-    required:
-      - clocks
-      - "#clock-cells"
-      - assigned-clocks
-      - assigned-clock-parents
-
   "^serdes@[0-9a-f]+$":
     type: object
     description: |
diff --git a/Documentation/devicetree/bindings/regulator/mps,mpq7920.yaml b/Documentation/devicetree/bindings/regulator/mps,mpq7920.yaml
index 12b8963615c3..c2e8c54e5311 100644
--- a/Documentation/devicetree/bindings/regulator/mps,mpq7920.yaml
+++ b/Documentation/devicetree/bindings/regulator/mps,mpq7920.yaml
@@ -36,12 +36,12 @@ properties:
           switching frequency must be one of following corresponding value
           1.1MHz, 1.65MHz, 2.2MHz, 2.75MHz
 
-    patternProperties:
-      "^ldo[1-4]$":
+      ldortc:
         type: object
         $ref: regulator.yaml#
 
-      "^ldortc$":
+    patternProperties:
+      "^ldo[1-4]$":
         type: object
         $ref: regulator.yaml#
 
diff --git a/Documentation/devicetree/bindings/regulator/nxp,pf8x00-regulator.yaml b/Documentation/devicetree/bindings/regulator/nxp,pf8x00-regulator.yaml
index 8761437ed8ad..aabf50f5b39e 100644
--- a/Documentation/devicetree/bindings/regulator/nxp,pf8x00-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/nxp,pf8x00-regulator.yaml
@@ -83,7 +83,8 @@ properties:
 
         unevaluatedProperties: false
 
-      "^vsnvs$":
+    properties:
+      vsnvs:
         type: object
         $ref: regulator.yaml#
         description:
diff --git a/Documentation/devicetree/bindings/spi/spi-controller.yaml b/Documentation/devicetree/bindings/spi/spi-controller.yaml
index faef4f6f55b8..8246891602e7 100644
--- a/Documentation/devicetree/bindings/spi/spi-controller.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-controller.yaml
@@ -79,22 +79,7 @@ properties:
     description:
       The SPI controller acts as a slave, instead of a master.
 
-allOf:
-  - if:
-      not:
-        required:
-          - spi-slave
-    then:
-      properties:
-        "#address-cells":
-          const: 1
-    else:
-      properties:
-        "#address-cells":
-          const: 0
-
-patternProperties:
-  "^slave$":
+  slave:
     type: object
 
     properties:
@@ -105,6 +90,7 @@ patternProperties:
     required:
       - compatible
 
+patternProperties:
   "^.*@[0-9a-f]+$":
     type: object
 
@@ -180,6 +166,20 @@ patternProperties:
       - compatible
       - reg
 
+allOf:
+  - if:
+      not:
+        required:
+          - spi-slave
+    then:
+      properties:
+        "#address-cells":
+          const: 1
+    else:
+      properties:
+        "#address-cells":
+          const: 0
+
 additionalProperties: true
 
 examples:
-- 
2.27.0

