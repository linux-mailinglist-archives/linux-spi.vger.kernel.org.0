Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBDEA17A7B7
	for <lists+linux-spi@lfdr.de>; Thu,  5 Mar 2020 15:37:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbgCEOgx (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 5 Mar 2020 09:36:53 -0500
Received: from foss.arm.com ([217.140.110.172]:49232 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726233AbgCEOgx (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 5 Mar 2020 09:36:53 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 07F1E1FB;
        Thu,  5 Mar 2020 06:36:53 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7E6073F534;
        Thu,  5 Mar 2020 06:36:52 -0800 (PST)
Date:   Thu, 05 Mar 2020 14:36:51 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "spi: spi-fsl-dspi: Make bus-num property optional" to the spi tree
In-Reply-To:  <20200305115546.31814-1-s.hauer@pengutronix.de>
Message-Id:  <applied-20200305115546.31814-1-s.hauer@pengutronix.de>
X-Patchwork-Hint: ignore
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: spi-fsl-dspi: Make bus-num property optional

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

From 29d2daf2c33ce9b1038f3fcd55e16a788c00fc86 Mon Sep 17 00:00:00 2001
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Thu, 5 Mar 2020 12:55:46 +0100
Subject: [PATCH] spi: spi-fsl-dspi: Make bus-num property optional

The SPI bus number is completely optional to Linux, so make the
corresponding device tree property optional as well.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Link: https://lore.kernel.org/r/20200305115546.31814-1-s.hauer@pengutronix.de
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt | 2 +-
 drivers/spi/spi-fsl-dspi.c                             | 8 ++------
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt b/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt
index 99b94cfe1623..30a79da9c039 100644
--- a/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt
+++ b/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt
@@ -19,11 +19,11 @@ Required properties:
 - pinctrl-0: pin control group to be used for this controller.
 - pinctrl-names: must contain a "default" entry.
 - spi-num-chipselects : the number of the chipselect signals.
-- bus-num : the slave chip chipselect signal number.
 
 Optional property:
 - big-endian: If present the dspi device's registers are implemented
   in big endian mode.
+- bus-num : the slave chip chipselect signal number.
 
 Optional SPI slave node properties:
 - fsl,spi-cs-sck-delay: a delay in nanoseconds between activating chip
diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index c357c3247232..74dc0df518fa 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -1108,7 +1108,7 @@ static int dspi_probe(struct platform_device *pdev)
 	const struct regmap_config *regmap_config;
 	struct fsl_dspi_platform_data *pdata;
 	struct spi_controller *ctlr;
-	int ret, cs_num, bus_num;
+	int ret, cs_num, bus_num = -1;
 	struct fsl_dspi *dspi;
 	struct resource *res;
 	void __iomem *base;
@@ -1145,11 +1145,7 @@ static int dspi_probe(struct platform_device *pdev)
 		}
 		ctlr->num_chipselect = cs_num;
 
-		ret = of_property_read_u32(np, "bus-num", &bus_num);
-		if (ret < 0) {
-			dev_err(&pdev->dev, "can't get bus-num\n");
-			goto out_ctlr_put;
-		}
+		of_property_read_u32(np, "bus-num", &bus_num);
 		ctlr->bus_num = bus_num;
 
 		if (of_property_read_bool(np, "spi-slave"))
-- 
2.20.1

