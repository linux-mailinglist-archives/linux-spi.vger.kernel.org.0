Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 633E9A35F1
	for <lists+linux-spi@lfdr.de>; Fri, 30 Aug 2019 13:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728225AbfH3Lpj (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 30 Aug 2019 07:45:39 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:42894 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728202AbfH3Lpj (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 30 Aug 2019 07:45:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=NTN2gkQb9faS0WZoTP0or3zxwr8QhE5p1WXLXCwK6ZE=; b=FpqNpIh1QpdW
        fPCBWJ2h8XDY/8SC2nsU3UxI16xILF/oD7YCvO9hD9QREpJOzNh8xCnpfEnS4kQ4oS7N4kmCecEk6
        /uX0nm5sUOEwX8fsBAglPuAiBRocXfEvDjjwl7uSdOYj2JXf6ACe96NyOQsab0Lfw2L+KqW+XyBbZ
        cOiSg=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1i3fLQ-0006KQ-Pf; Fri, 30 Aug 2019 11:45:32 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 47E7B2742CA1; Fri, 30 Aug 2019 12:45:32 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     avifishman70@gmail.com, bbrezillon@kernel.org,
        benjaminfair@google.com, broonie@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        mark.rutland@arm.com, openbmc@lists.ozlabs.org, robh+dt@kernel.org,
        tali.perry1@gmail.com, venture@google.com, vigneshr@ti.com,
        yuenn@google.com
Subject: Applied "dt-binding: spi: add NPCM FIU controller" to the spi tree
In-Reply-To: <20190828142513.228556-2-tmaimon77@gmail.com>
X-Patchwork-Hint: ignore
Message-Id: <20190830114532.47E7B2742CA1@ypsilon.sirena.org.uk>
Date:   Fri, 30 Aug 2019 12:45:32 +0100 (BST)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   dt-binding: spi: add NPCM FIU controller

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.4

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

From 91d0c59f460fd61db977d35b0d7c057128e7f7b7 Mon Sep 17 00:00:00 2001
From: Tomer Maimon <tmaimon77@gmail.com>
Date: Wed, 28 Aug 2019 17:25:12 +0300
Subject: [PATCH] dt-binding: spi: add NPCM FIU controller

Added device tree binding documentation for Nuvoton BMC
NPCM Flash Interface Unit(FIU) SPI master controller
using SPI-MEM interface.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
Link: https://lore.kernel.org/r/20190828142513.228556-2-tmaimon77@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../bindings/spi/nuvoton,npcm-fiu.txt         | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/nuvoton,npcm-fiu.txt

diff --git a/Documentation/devicetree/bindings/spi/nuvoton,npcm-fiu.txt b/Documentation/devicetree/bindings/spi/nuvoton,npcm-fiu.txt
new file mode 100644
index 000000000000..a388005842ad
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/nuvoton,npcm-fiu.txt
@@ -0,0 +1,47 @@
+* Nuvoton FLASH Interface Unit (FIU) SPI Controller
+
+NPCM FIU supports single, dual and quad communication interface.
+
+The NPCM7XX supports three FIU modules,
+FIU0 and FIUx supports two chip selects,
+FIU3 support four chip select.
+
+Required properties:
+  - compatible : "nuvoton,npcm750-fiu" for the NPCM7XX BMC
+  - #address-cells : should be 1.
+  - #size-cells : should be 0.
+  - reg : the first contains the register location and length,
+          the second contains the memory mapping address and length
+  - reg-names: Should contain the reg names "control" and "memory"
+  - clocks : phandle of FIU reference clock.
+
+Required properties in case the pins can be muxed:
+  - pinctrl-names : a pinctrl state named "default" must be defined.
+  - pinctrl-0 : phandle referencing pin configuration of the device.
+
+Optional property:
+  - nuvoton,spix-mode: enable spix-mode for an expansion bus to an ASIC or CPLD.
+
+Aliases:
+- All the FIU controller nodes should be represented in the aliases node using
+  the following format 'fiu{n}' where n is a unique number for the alias.
+  In the NPCM7XX BMC:
+  		fiu0 represent fiu 0 controller
+  		fiu1 represent fiu 3 controller
+  		fiu2 represent fiu x controller
+
+Example:
+fiu3: spi@c00000000 {
+	compatible = "nuvoton,npcm750-fiu";
+	#address-cells = <1>;
+	#size-cells = <0>;
+	reg = <0xfb000000 0x1000>, <0x80000000 0x10000000>;
+	reg-names = "control", "memory";
+	clocks = <&clk NPCM7XX_CLK_AHB>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi3_pins>;
+	spi-nor@0 {
+			...
+	};
+};
+
-- 
2.20.1

