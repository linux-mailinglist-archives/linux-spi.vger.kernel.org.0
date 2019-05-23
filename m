Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E50C27EAF
	for <lists+linux-spi@lfdr.de>; Thu, 23 May 2019 15:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730919AbfEWNtL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 23 May 2019 09:49:11 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:45154 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730706AbfEWNtL (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 23 May 2019 09:49:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=XNfOmz3mv1HI9Hoz2nuwSlZ+6AVMa+i0bbmtNTX06rY=; b=vYclXzO/lJeo
        5I3MA1p+mhNuW9aJRR1b0h4FIWti7rFeFjRJZVNr0v8sVisTaD2+tKTmUPrLGpvOv7Mmd9hzLneV+
        /ls7ALHv2GolE9ROmBJQcZR5dPmhsqRPbS87GCgKmL3oOAfmPmLjG76vVoCjv3+eZqcwgAIzi2V1W
        Egfiw=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hTo5k-0000FQ-CM; Thu, 23 May 2019 13:49:08 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id C162C1126D28; Thu, 23 May 2019 14:49:07 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: Applied "spi: dt-bindings: Convert spi-gpio binding to json-schema" to the spi tree
In-Reply-To: <20190521212325.16639-2-robh@kernel.org>
X-Patchwork-Hint: ignore
Message-Id: <20190523134907.C162C1126D28@debutante.sirena.org.uk>
Date:   Thu, 23 May 2019 14:49:07 +0100 (BST)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: dt-bindings: Convert spi-gpio binding to json-schema

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.3

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From 97266c4d05345f9b500d10c3caa1070249e895e7 Mon Sep 17 00:00:00 2001
From: Rob Herring <robh@kernel.org>
Date: Tue, 21 May 2019 16:23:25 -0500
Subject: [PATCH] spi: dt-bindings: Convert spi-gpio binding to json-schema

Convert the spi-gpio binding to DT schema format.

Cc: Mark Brown <broonie@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-spi@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/spi/spi-gpio.txt      | 43 -----------
 .../devicetree/bindings/spi/spi-gpio.yaml     | 72 +++++++++++++++++++
 2 files changed, 72 insertions(+), 43 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/spi/spi-gpio.txt
 create mode 100644 Documentation/devicetree/bindings/spi/spi-gpio.yaml

diff --git a/Documentation/devicetree/bindings/spi/spi-gpio.txt b/Documentation/devicetree/bindings/spi/spi-gpio.txt
deleted file mode 100644
index 52db562f17a4..000000000000
--- a/Documentation/devicetree/bindings/spi/spi-gpio.txt
+++ /dev/null
@@ -1,43 +0,0 @@
-SPI-GPIO devicetree bindings
-
-This represents a group of 3-n GPIO lines used for bit-banged SPI on dedicated
-GPIO lines.
-
-Required properties:
-
- - compatible: should be set to "spi-gpio"
- - #address-cells: should be set to <0x1>
- - ranges
- - sck-gpios: GPIO spec for the SCK line to use
- - miso-gpios: GPIO spec for the MISO line to use
- - mosi-gpios: GPIO spec for the MOSI line to use
- - cs-gpios: GPIOs to use for chipselect lines.
-             Not needed if num-chipselects = <0>.
- - num-chipselects: Number of chipselect lines. Should be <0> if a single device
-                    with no chip select is connected.
-
-Deprecated bindings:
-
-These legacy GPIO line bindings can alternatively be used to define the
-GPIO lines used, they should not be used in new device trees.
-
- - gpio-sck: GPIO spec for the SCK line to use
- - gpio-miso: GPIO spec for the MISO line to use
- - gpio-mosi: GPIO spec for the MOSI line to use
-
-Example:
-
-	spi {
-		compatible = "spi-gpio";
-		#address-cells = <0x1>;
-		ranges;
-
-		sck-gpios = <&gpio 95 0>;
-		miso-gpios = <&gpio 98 0>;
-		mosi-gpios = <&gpio 97 0>;
-		cs-gpios = <&gpio 125 0>;
-		num-chipselects = <1>;
-
-		/* clients */
-	};
-
diff --git a/Documentation/devicetree/bindings/spi/spi-gpio.yaml b/Documentation/devicetree/bindings/spi/spi-gpio.yaml
new file mode 100644
index 000000000000..55c4f1705f07
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-gpio.yaml
@@ -0,0 +1,72 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/spi-gpio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SPI-GPIO devicetree bindings
+
+maintainers:
+  - Rob Herring <robh@kernel.org>
+
+description:
+  This represents a group of 3-n GPIO lines used for bit-banged SPI on
+  dedicated GPIO lines.
+
+allOf:
+  - $ref: "/schemas/spi/spi-controller.yaml#"
+
+properties:
+  compatible:
+    const: spi-gpio
+
+  sck-gpios:
+    description: GPIO spec for the SCK line to use
+    maxItems: 1
+
+  miso-gpios:
+    description: GPIO spec for the MISO line to use
+    maxItems: 1
+
+  mosi-gpios:
+    description: GPIO spec for the MOSI line to use
+    maxItems: 1
+
+  cs-gpios:
+    description: GPIOs to use for chipselect lines.
+      Not needed if num-chipselects = <0>.
+    minItems: 1
+    maxItems: 1024
+
+  num-chipselects:
+    description: Number of chipselect lines. Should be <0> if a single device
+      with no chip select is connected.
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+
+  # Deprecated properties
+  gpio-sck: false
+  gpio-miso: false
+  gpio-mosi: false
+
+required:
+  - compatible
+  - num-chipselects
+  - sck-gpios
+
+examples:
+  - |
+    spi {
+      compatible = "spi-gpio";
+      #address-cells = <0x1>;
+      #size-cells = <0x0>;
+
+      sck-gpios = <&gpio 95 0>;
+      miso-gpios = <&gpio 98 0>;
+      mosi-gpios = <&gpio 97 0>;
+      cs-gpios = <&gpio 125 0>;
+      num-chipselects = <1>;
+
+      /* clients */
+    };
+
+...
-- 
2.20.1

