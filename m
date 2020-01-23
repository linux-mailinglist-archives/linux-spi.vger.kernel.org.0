Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24154146820
	for <lists+linux-spi@lfdr.de>; Thu, 23 Jan 2020 13:36:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbgAWMgc (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 23 Jan 2020 07:36:32 -0500
Received: from foss.arm.com ([217.140.110.172]:39016 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726170AbgAWMgc (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 23 Jan 2020 07:36:32 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 57A8D328;
        Thu, 23 Jan 2020 04:36:31 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CA11D3F6C4;
        Thu, 23 Jan 2020 04:36:30 -0800 (PST)
Date:   Thu, 23 Jan 2020 12:36:29 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     avifishman70@gmail.com, benjaminfair@google.com,
        broonie@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, mark.rutland@arm.com,
        openbmc@lists.ozlabs.org, robh+dt@kernel.org,
        Rob Herring <robh@kernel.org>, tali.perry1@gmail.com,
        venture@google.com, yuenn@google.com
Subject: Applied "dt-binding: spi: add NPCM PSPI reset binding" to the spi tree
In-Reply-To: <20200115162301.235926-4-tmaimon77@gmail.com>
Message-Id: <applied-20200115162301.235926-4-tmaimon77@gmail.com>
X-Patchwork-Hint: ignore
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   dt-binding: spi: add NPCM PSPI reset binding

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.6

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

From a5362b84bdff1def10c136e36ef2126f7f545b2c Mon Sep 17 00:00:00 2001
From: Tomer Maimon <tmaimon77@gmail.com>
Date: Wed, 15 Jan 2020 18:23:00 +0200
Subject: [PATCH] dt-binding: spi: add NPCM PSPI reset binding

Add NPCM Peripheral SPI reset binding documentation,
Removing unnecessary aliases use.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/20200115162301.235926-4-tmaimon77@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/spi/nuvoton,npcm-pspi.txt    | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/nuvoton,npcm-pspi.txt b/Documentation/devicetree/bindings/spi/nuvoton,npcm-pspi.txt
index 1fd9a4406a1d..b98203ca656d 100644
--- a/Documentation/devicetree/bindings/spi/nuvoton,npcm-pspi.txt
+++ b/Documentation/devicetree/bindings/spi/nuvoton,npcm-pspi.txt
@@ -12,6 +12,7 @@ Required properties:
  - clock-names: Should be "clk_apb5".
  - pinctrl-names : a pinctrl state named "default" must be defined.
  - pinctrl-0 : phandle referencing pin configuration of the device.
+ - resets : phandle to the reset control for this device.
  - cs-gpios: Specifies the gpio pins to be used for chipselects.
             See: Documentation/devicetree/bindings/spi/spi-bus.txt
 
@@ -19,16 +20,6 @@ Optional properties:
 - clock-frequency : Input clock frequency to the PSPI block in Hz.
 		    Default is 25000000 Hz.
 
-Aliases:
-- All the SPI controller nodes should be represented in the aliases node using
-  the following format 'spi{n}' withe the correct numbered in "aliases" node.
-
-Example:
-
-aliases {
-	spi0 = &spi0;
-};
-
 spi0: spi@f0200000 {
 	compatible = "nuvoton,npcm750-pspi";
 	reg = <0xf0200000 0x1000>;
@@ -39,5 +30,6 @@ spi0: spi@f0200000 {
 	interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
 	clocks = <&clk NPCM7XX_CLK_APB5>;
 	clock-names = "clk_apb5";
+	resets = <&rstc NPCM7XX_RESET_IPSRST2 NPCM7XX_RESET_PSPI1>
 	cs-gpios = <&gpio6 11 GPIO_ACTIVE_LOW>;
 };
-- 
2.20.1

