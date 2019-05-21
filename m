Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7075025909
	for <lists+linux-spi@lfdr.de>; Tue, 21 May 2019 22:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728107AbfEUUdT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 21 May 2019 16:33:19 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:38914 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728085AbfEUUdS (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 21 May 2019 16:33:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=R9ESEBbgE1Ke5f52DriCNwd7u6OrgoEHPxqSKIIaXM0=; b=YrJMa7YtwHTW
        C7MNFw82NgjFHgm6ePumonEHUkbvUOZ9fpMfKR/r2BTHSqjz9FWa0rrQee3DH/xbSWiMh+zuQHow7
        paa4n+tFdGZ2OshyT9vg4dIpkJJuooMAQliUgC63oDZjd5RhT5RyTwu9j39rNsZZtLbYoz4jrM0fq
        5mTXk=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hTBRg-00022j-Go; Tue, 21 May 2019 20:33:12 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id F1B061126D13; Tue, 21 May 2019 21:33:08 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Applied "spi: sun6i: Add YAML schemas" to the spi tree
In-Reply-To: <682af95d93f4065ee7ab6a5d6f226c848f6a7da8.1558363790.git-series.maxime.ripard@bootlin.com>
X-Patchwork-Hint: ignore
Message-Id: <20190521203308.F1B061126D13@debutante.sirena.org.uk>
Date:   Tue, 21 May 2019 21:33:08 +0100 (BST)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: sun6i: Add YAML schemas

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

From 101e6fce89b4707429185527e15d97c7e8f62ec5 Mon Sep 17 00:00:00 2001
From: Maxime Ripard <maxime.ripard@bootlin.com>
Date: Mon, 20 May 2019 16:50:35 +0200
Subject: [PATCH] spi: sun6i: Add YAML schemas

Switch the DT binding to a YAML schema to enable the DT validation.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../bindings/spi/allwinner,sun6i-a31-spi.yaml | 106 ++++++++++++++++++
 .../devicetree/bindings/spi/spi-sun6i.txt     |  44 --------
 2 files changed, 106 insertions(+), 44 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml
 delete mode 100644 Documentation/devicetree/bindings/spi/spi-sun6i.txt

diff --git a/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml b/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml
new file mode 100644
index 000000000000..bda7a5befd8b
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml
@@ -0,0 +1,106 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/allwinner,sun6i-a31-spi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Allwinner A31 SPI Controller Device Tree Bindings
+
+allOf:
+  - $ref: "spi-controller.yaml"
+
+maintainers:
+  - Chen-Yu Tsai <wens@csie.org>
+  - Maxime Ripard <maxime.ripard@bootlin.com>
+
+properties:
+  "#address-cells": true
+  "#size-cells": true
+
+  compatible:
+    enum:
+      - allwinner,sun6i-a31-spi
+      - allwinner,sun8i-h3-spi
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: Bus Clock
+      - description: Module Clock
+
+  clock-names:
+    items:
+      - const: ahb
+      - const: mod
+
+  resets:
+    maxItems: 1
+
+  dmas:
+    items:
+      - description: RX DMA Channel
+      - description: TX DMA Channel
+
+  dma-names:
+    items:
+      - const: rx
+      - const: tx
+
+  num-cs: true
+
+patternProperties:
+  "^.*@[0-9a-f]+":
+    properties:
+      reg:
+        items:
+          minimum: 0
+          maximum: 4
+
+      spi-rx-bus-width:
+        const: 1
+
+      spi-tx-bus-width:
+        const: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    spi1: spi@1c69000 {
+        compatible = "allwinner,sun6i-a31-spi";
+        reg = <0x01c69000 0x1000>;
+        interrupts = <0 66 4>;
+        clocks = <&ahb1_gates 21>, <&spi1_clk>;
+        clock-names = "ahb", "mod";
+        resets = <&ahb1_rst 21>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+    };
+
+  - |
+    spi0: spi@1c68000 {
+        compatible = "allwinner,sun8i-h3-spi";
+        reg = <0x01c68000 0x1000>;
+        interrupts = <0 65 4>;
+        clocks = <&ccu 30>, <&ccu 82>;
+        clock-names = "ahb", "mod";
+        dmas = <&dma 23>, <&dma 23>;
+        dma-names = "rx", "tx";
+        resets = <&ccu 15>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/spi/spi-sun6i.txt b/Documentation/devicetree/bindings/spi/spi-sun6i.txt
deleted file mode 100644
index 435a8e0731ac..000000000000
--- a/Documentation/devicetree/bindings/spi/spi-sun6i.txt
+++ /dev/null
@@ -1,44 +0,0 @@
-Allwinner A31/H3 SPI controller
-
-Required properties:
-- compatible: Should be "allwinner,sun6i-a31-spi" or "allwinner,sun8i-h3-spi".
-- reg: Should contain register location and length.
-- interrupts: Should contain interrupt.
-- clocks: phandle to the clocks feeding the SPI controller. Two are
-          needed:
-  - "ahb": the gated AHB parent clock
-  - "mod": the parent module clock
-- clock-names: Must contain the clock names described just above
-- resets: phandle to the reset controller asserting this device in
-          reset
-
-Optional properties:
-- dmas: DMA specifiers for rx and tx dma. See the DMA client binding,
-	Documentation/devicetree/bindings/dma/dma.txt
-- dma-names: DMA request names should include "rx" and "tx" if present.
-
-Example:
-
-spi1: spi@1c69000 {
-	compatible = "allwinner,sun6i-a31-spi";
-	reg = <0x01c69000 0x1000>;
-	interrupts = <0 66 4>;
-	clocks = <&ahb1_gates 21>, <&spi1_clk>;
-	clock-names = "ahb", "mod";
-	resets = <&ahb1_rst 21>;
-};
-
-spi0: spi@1c68000 {
-	compatible = "allwinner,sun8i-h3-spi";
-	reg = <0x01c68000 0x1000>;
-	interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;
-	clocks = <&ccu CLK_BUS_SPI0>, <&ccu CLK_SPI0>;
-	clock-names = "ahb", "mod";
-	dmas = <&dma 23>, <&dma 23>;
-	dma-names = "rx", "tx";
-	pinctrl-names = "default";
-	pinctrl-0 = <&spi0_pins>;
-	resets = <&ccu RST_BUS_SPI0>;
-	#address-cells = <1>;
-	#size-cells = <0>;
-};
-- 
2.20.1

