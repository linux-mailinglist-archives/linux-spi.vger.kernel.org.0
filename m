Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E972DC3308
	for <lists+linux-spi@lfdr.de>; Tue,  1 Oct 2019 13:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387743AbfJALlp (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 1 Oct 2019 07:41:45 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:41274 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387600AbfJALlO (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 1 Oct 2019 07:41:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=9NIlts5ITrK/8oZVl5gsv5OBvh8S90fAOctaSex1Ztk=; b=fd0dXYto4V/D
        ehOlK0fbO4lt2yZ+DyDyqD+KFMqaqYW5f4XwtWj5YkNT+E0UuJ4IBhvvnezFE3aPPzDr7PJEKm0Ew
        qjYPLssafBMkO+SNZ5iT7u5F6KFFSaNdC21633KR9VeEobiCA/bDeHfBj5/j1r9UozUr4zMrqN7j7
        Oomxo=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iFGWj-0004Zf-11; Tue, 01 Oct 2019 11:41:09 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 76E6B274299F; Tue,  1 Oct 2019 12:41:08 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Simon Horman <horms+renesas@verge.net.au>
Cc:     devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-renesas-soc@vger.kernel.org, linux-spi@vger.kernel.org,
        Magnus Damm <magnus.damm@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Yoshihiro Kaneko <ykaneko0929@gmail.com>
Subject: Applied "dt-bindings: hspi: Convert bindings to json-schema" to the spi tree
In-Reply-To: <20190916075352.32108-1-horms+renesas@verge.net.au>
X-Patchwork-Hint: ignore
Message-Id: <20191001114108.76E6B274299F@ypsilon.sirena.org.uk>
Date:   Tue,  1 Oct 2019 12:41:08 +0100 (BST)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   dt-bindings: hspi: Convert bindings to json-schema

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.5

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

From 85d27be81e39323c8e3c1151e4858b26d7e1b20d Mon Sep 17 00:00:00 2001
From: Simon Horman <horms+renesas@verge.net.au>
Date: Mon, 16 Sep 2019 09:53:52 +0200
Subject: [PATCH] dt-bindings: hspi: Convert bindings to json-schema

Convert Renesas HSPI bindings documentation to json-schema.
Also name bindings documentation file according to the compat string
being documented.

As a side effect of this change all currently supported/used compat
strings are listed while no while card compat string is documented.
This, in my opinion, is desirable as only supported hardware should
be documented.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/20190916075352.32108-1-horms+renesas@verge.net.au
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/spi/renesas,hspi.yaml | 57 +++++++++++++++++++
 .../devicetree/bindings/spi/sh-hspi.txt       | 26 ---------
 2 files changed, 57 insertions(+), 26 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/renesas,hspi.yaml
 delete mode 100644 Documentation/devicetree/bindings/spi/sh-hspi.txt

diff --git a/Documentation/devicetree/bindings/spi/renesas,hspi.yaml b/Documentation/devicetree/bindings/spi/renesas,hspi.yaml
new file mode 100644
index 000000000000..c429cf4bea5b
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/renesas,hspi.yaml
@@ -0,0 +1,57 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/renesas,hspi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas HSPI
+
+maintainers:
+  - Geert Uytterhoeven <geert+renesas@glider.be>
+
+allOf:
+  - $ref: spi-controller.yaml#
+
+properties:
+  compatible:
+    items:
+      - enum:
+        - renesas,hspi-r8a7778 # R-Car M1A
+        - renesas,hspi-r8a7779 # R-Car H1
+      - const: renesas,hspi
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  power-domains:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - '#address-cells'
+  - '#size-cells'
+
+examples:
+  - |
+    #include <dt-bindings/clock/r8a7778-clock.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    hspi0: spi@fffc7000 {
+        compatible = "renesas,hspi-r8a7778", "renesas,hspi";
+        reg = <0xfffc7000 0x18>;
+        interrupts = <0 63 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&mstp0_clks R8A7778_CLK_HSPI>;
+        power-domains = <&cpg_clocks>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+    };
+
diff --git a/Documentation/devicetree/bindings/spi/sh-hspi.txt b/Documentation/devicetree/bindings/spi/sh-hspi.txt
deleted file mode 100644
index b9d1e4d11a77..000000000000
--- a/Documentation/devicetree/bindings/spi/sh-hspi.txt
+++ /dev/null
@@ -1,26 +0,0 @@
-Renesas HSPI.
-
-Required properties:
-- compatible       : "renesas,hspi-<soctype>", "renesas,hspi" as fallback.
-		     Examples with soctypes are:
-		       - "renesas,hspi-r8a7778" (R-Car M1)
-		       - "renesas,hspi-r8a7779" (R-Car H1)
-- reg              : Offset and length of the register set for the device
-- interrupts       : Interrupt specifier
-- #address-cells   : Must be <1>
-- #size-cells      : Must be <0>
-
-Pinctrl properties might be needed, too.  See
-Documentation/devicetree/bindings/pinctrl/renesas,*.
-
-Example:
-
-	hspi0: spi@fffc7000 {
-		compatible = "renesas,hspi-r8a7778", "renesas,hspi";
-		reg = <0xfffc7000 0x18>;
-		interrupt-parent = <&gic>;
-		interrupts = <0 63 IRQ_TYPE_LEVEL_HIGH>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-	};
-
-- 
2.20.1

