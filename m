Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB88A1820E7
	for <lists+linux-spi@lfdr.de>; Wed, 11 Mar 2020 19:35:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730883AbgCKSfn (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 11 Mar 2020 14:35:43 -0400
Received: from foss.arm.com ([217.140.110.172]:53494 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730641AbgCKSfn (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 11 Mar 2020 14:35:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5D62B7FA;
        Wed, 11 Mar 2020 11:35:42 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D552B3F6CF;
        Wed, 11 Mar 2020 11:35:41 -0700 (PDT)
Date:   Wed, 11 Mar 2020 18:35:40 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Chuanhong Guo <gch981213@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        "moderated list:ARM/Mediatek SoC, open list
        <linux-kernel@vger.kernel.org>, Richard Weinberger <richard@nod.at>, Rob
        Herring <robh+dt@kernel.org>, support" 
        <linux-arm-kernel@lists.infradead.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Applied "dt-bindings: convert mtk-quadspi binding doc for spi-mtk-nor" to the spi tree
In-Reply-To:  <20200306085052.28258-4-gch981213@gmail.com>
Message-Id:  <applied-20200306085052.28258-4-gch981213@gmail.com>
X-Patchwork-Hint: ignore
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   dt-bindings: convert mtk-quadspi binding doc for spi-mtk-nor

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

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

From efe72129f32cac0dee5a221399813b620e310b32 Mon Sep 17 00:00:00 2001
From: Chuanhong Guo <gch981213@gmail.com>
Date: Fri, 6 Mar 2020 16:50:51 +0800
Subject: [PATCH] dt-bindings: convert mtk-quadspi binding doc for spi-mtk-nor

spi-mtk-nor is a driver to replace mtk-quadspi and they have almost
the same device-tree bindings. Reuse this binding documentation and
convert it for new driver:

1. "Mediatek SoCs" -> "Mediatek ARM SoCs" because MTK MIPS SoCs
   use different controllers.
2. document "interrupts" as a required property because it's
   available on all SoCs with this controller and new driver takes
   advantages of it. It's implemented as optional only to maintain
   backward compatibility.
3. add a dummy interrupt binding in example.

Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
Link: https://lore.kernel.org/r/20200306085052.28258-4-gch981213@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../{mtd/mtk-quadspi.txt => spi/spi-mtk-nor.txt}  | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)
 rename Documentation/devicetree/bindings/{mtd/mtk-quadspi.txt => spi/spi-mtk-nor.txt} (75%)

diff --git a/Documentation/devicetree/bindings/mtd/mtk-quadspi.txt b/Documentation/devicetree/bindings/spi/spi-mtk-nor.txt
similarity index 75%
rename from Documentation/devicetree/bindings/mtd/mtk-quadspi.txt
rename to Documentation/devicetree/bindings/spi/spi-mtk-nor.txt
index a12e3b5c495d..984ae7fd4f94 100644
--- a/Documentation/devicetree/bindings/mtd/mtk-quadspi.txt
+++ b/Documentation/devicetree/bindings/spi/spi-mtk-nor.txt
@@ -1,4 +1,4 @@
-* Serial NOR flash controller for MediaTek SoCs
+* Serial NOR flash controller for MediaTek ARM SoCs
 
 Required properties:
 - compatible: 	  For mt8173, compatible should be "mediatek,mt8173-nor",
@@ -13,6 +13,7 @@ Required properties:
 		  "mediatek,mt7629-nor", "mediatek,mt8173-nor"
 		  "mediatek,mt8173-nor"
 - reg: 		  physical base address and length of the controller's register
+- interrupts:	  Interrupt number used by the controller.
 - clocks: 	  the phandle of the clocks needed by the nor controller
 - clock-names: 	  the names of the clocks
 		  the clocks should be named "spi" and "sf". "spi" is used for spi bus,
@@ -22,20 +23,16 @@ Required properties:
 - #address-cells: should be <1>
 - #size-cells:	  should be <0>
 
-The SPI flash must be a child of the nor_flash node and must have a
-compatible property. Also see jedec,spi-nor.txt.
-
-Required properties:
-- compatible:	  May include a device-specific string consisting of the manufacturer
-		  and name of the chip. Must also include "jedec,spi-nor" for any
-		  SPI NOR flash that can be identified by the JEDEC READ ID opcode (0x9F).
-- reg :		  Chip-Select number
+There should be only one spi slave device following generic spi bindings.
+It's not recommended to use this controller for devices other than SPI NOR
+flash due to limited transfer capability of this controller.
 
 Example:
 
 nor_flash: spi@1100d000 {
 	compatible = "mediatek,mt8173-nor";
 	reg = <0 0x1100d000 0 0xe0>;
+	interrupts = <&spi_flash_irq>;
 	clocks = <&pericfg CLK_PERI_SPI>,
 		 <&topckgen CLK_TOP_SPINFI_IFR_SEL>;
 	clock-names = "spi", "sf";
-- 
2.20.1

