Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A50001593DB
	for <lists+linux-spi@lfdr.de>; Tue, 11 Feb 2020 16:52:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730586AbgBKPvm (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 11 Feb 2020 10:51:42 -0500
Received: from foss.arm.com ([217.140.110.172]:48880 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730453AbgBKPvm (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 11 Feb 2020 10:51:42 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8139430E;
        Tue, 11 Feb 2020 07:51:41 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D52893F68E;
        Tue, 11 Feb 2020 07:51:40 -0800 (PST)
Date:   Tue, 11 Feb 2020 15:51:39 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     aisheng.dong@nxp.com, andrew.smirnov@gmail.com, angus@akkea.ca,
        broonie@kernel.org, cosmin.stoica@nxp.com, daniel.baluta@nxp.com,
        devicetree@vger.kernel.org, festevam@gmail.com,
        gary.bisson@boundarydevices.com, jun.li@nxp.com,
        kernel@pengutronix.de, leonard.crestez@nxp.com,
        linux-arm-kernel@lists.infradead.org, Linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        l.stach@pengutronix.de, manivannan.sadhasivam@linaro.org,
        marcel.ziswiler@toradex.com, Mark Brown <broonie@kernel.org>,
        mark.rutland@arm.com, pramod.kumar_1@nxp.com, rabeeh@solid-run.com,
        rjones@gateworks.com, robh+dt@kernel.org,
        Rob Herring <robh@kernel.org>,
        sebastien.szymanski@armadeus.com, s.hauer@pengutronix.de,
        shawnguo@kernel.org
Subject: Applied "dt-bindings: spi: imx: Add i.MX8MM/i.MX8MN/i.MX8MP compatible" to the spi tree
In-Reply-To: <1581425307-18567-1-git-send-email-Anson.Huang@nxp.com>
Message-Id: <applied-1581425307-18567-1-git-send-email-Anson.Huang@nxp.com>
X-Patchwork-Hint: ignore
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   dt-bindings: spi: imx: Add i.MX8MM/i.MX8MN/i.MX8MP compatible

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.7

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

From 1565e8e8ef0bbccabf62152b93c6505b8041b1e5 Mon Sep 17 00:00:00 2001
From: Anson Huang <Anson.Huang@nxp.com>
Date: Tue, 11 Feb 2020 20:48:24 +0800
Subject: [PATCH] dt-bindings: spi: imx: Add i.MX8MM/i.MX8MN/i.MX8MP compatible

Add compatible for imx8mm/imx8mn/imx8mp.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Acked-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/1581425307-18567-1-git-send-email-Anson.Huang@nxp.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt b/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt
index 2d3264140cc5..33bc58f4cf4b 100644
--- a/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt
+++ b/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt
@@ -10,7 +10,10 @@ Required properties:
   - "fsl,imx35-cspi" for SPI compatible with the one integrated on i.MX35
   - "fsl,imx51-ecspi" for SPI compatible with the one integrated on i.MX51
   - "fsl,imx53-ecspi" for SPI compatible with the one integrated on i.MX53 and later Soc
-  - "fsl,imx8mq-ecspi" for SPI compatible with the one integrated on i.MX8M
+  - "fsl,imx8mq-ecspi" for SPI compatible with the one integrated on i.MX8MQ
+  - "fsl,imx8mm-ecspi" for SPI compatible with the one integrated on i.MX8MM
+  - "fsl,imx8mn-ecspi" for SPI compatible with the one integrated on i.MX8MN
+  - "fsl,imx8mp-ecspi" for SPI compatible with the one integrated on i.MX8MP
 - reg : Offset and length of the register set for the device
 - interrupts : Should contain CSPI/eCSPI interrupt
 - clocks : Clock specifiers for both ipg and per clocks.
-- 
2.20.1

