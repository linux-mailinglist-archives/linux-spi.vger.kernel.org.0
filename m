Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 605751797DF
	for <lists+linux-spi@lfdr.de>; Wed,  4 Mar 2020 19:29:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbgCDS3M (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 4 Mar 2020 13:29:12 -0500
Received: from foss.arm.com ([217.140.110.172]:38278 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725795AbgCDS3M (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 4 Mar 2020 13:29:12 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9401E31B;
        Wed,  4 Mar 2020 10:29:11 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 161153F6C4;
        Wed,  4 Mar 2020 10:29:10 -0800 (PST)
Date:   Wed, 04 Mar 2020 18:29:09 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     broonie@kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "spi: spi-fsl-dspi: Add specific compatibles for all Layerscape SoCs" to the spi tree
In-Reply-To:  <20200302001958.11105-2-olteanv@gmail.com>
Message-Id:  <applied-20200302001958.11105-2-olteanv@gmail.com>
X-Patchwork-Hint: ignore
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: spi-fsl-dspi: Add specific compatibles for all Layerscape SoCs

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

From 50b62071deab48c1a69c471f9a7d0c8ff9ef23eb Mon Sep 17 00:00:00 2001
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Mon, 2 Mar 2020 02:19:53 +0200
Subject: [PATCH] spi: spi-fsl-dspi: Add specific compatibles for all
 Layerscape SoCs

Make the second compatible string optional for LS1012A, LS1088A and
LS2080A. Old versions of the spi-fsl-dspi.c driver still need to probe
on the old, generic compatible string for these controllers (such as
"fsl,ls1021a-v1.0-dspi") which provides less functionality.

Document the device tree bindings for LS1043A and LS1046A, whose
bindings are already in use in fsl-ls1043a.dtsi and fsl-ls1046a.dtsi.

Introduce new compatible strings for LS1028A and LX2160A. There will be
no second compatible string for these.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Message-Id: <20200302001958.11105-2-olteanv@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/spi/spi-fsl-dspi.txt    | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt b/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt
index 162e024b95a0..99b94cfe1623 100644
--- a/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt
+++ b/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt
@@ -1,12 +1,17 @@
 ARM Freescale DSPI controller
 
 Required properties:
-- compatible : "fsl,vf610-dspi", "fsl,ls1021a-v1.0-dspi",
-		"fsl,ls2085a-dspi"
-		or
-		"fsl,ls2080a-dspi" followed by "fsl,ls2085a-dspi"
-		"fsl,ls1012a-dspi" followed by "fsl,ls1021a-v1.0-dspi"
-		"fsl,ls1088a-dspi" followed by "fsl,ls1021a-v1.0-dspi"
+- compatible : must be one of:
+	"fsl,vf610-dspi",
+	"fsl,ls1021a-v1.0-dspi",
+	"fsl,ls1012a-dspi" (optionally followed by "fsl,ls1021a-v1.0-dspi"),
+	"fsl,ls1028a-dspi",
+	"fsl,ls1043a-dspi" (optionally followed by "fsl,ls1021a-v1.0-dspi"),
+	"fsl,ls1046a-dspi" (optionally followed by "fsl,ls1021a-v1.0-dspi"),
+	"fsl,ls1088a-dspi" (optionally followed by "fsl,ls1021a-v1.0-dspi"),
+	"fsl,ls2080a-dspi" (optionally followed by "fsl,ls2085a-dspi"),
+	"fsl,ls2085a-dspi",
+	"fsl,lx2160a-dspi",
 - reg : Offset and length of the register set for the device
 - interrupts : Should contain SPI controller interrupt
 - clocks: from common clock binding: handle to dspi clock.
-- 
2.20.1

