Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95B451797EA
	for <lists+linux-spi@lfdr.de>; Wed,  4 Mar 2020 19:29:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730205AbgCDS3f (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 4 Mar 2020 13:29:35 -0500
Received: from foss.arm.com ([217.140.110.172]:38322 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730075AbgCDS3e (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 4 Mar 2020 13:29:34 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3E6B131B;
        Wed,  4 Mar 2020 10:29:34 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B30553F6C4;
        Wed,  4 Mar 2020 10:29:33 -0800 (PST)
Date:   Wed, 04 Mar 2020 18:29:32 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     broonie@kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "spi: spi-fsl-dspi: Use specific compatible strings for all SoC instantiations" to the spi tree
In-Reply-To:  <20200302001958.11105-3-olteanv@gmail.com>
Message-Id:  <applied-20200302001958.11105-3-olteanv@gmail.com>
X-Patchwork-Hint: ignore
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: spi-fsl-dspi: Use specific compatible strings for all SoC instantiations

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

From d35054010b571486596f9da159f798fc38628683 Mon Sep 17 00:00:00 2001
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Mon, 2 Mar 2020 02:19:54 +0200
Subject: [PATCH] spi: spi-fsl-dspi: Use specific compatible strings for all
 SoC instantiations

Currently, the device tree bindings submitted in mainline for Layerscape
SoCs look like this:

LS1021A:
compatible = "fsl,ls1021a-v1.0-dspi";

LS1012A:
compatible = "fsl,ls1012a-dspi", "fsl,ls1021a-v1.0-dspi";

LS2085A:
compatible = "fsl,ls2085a-dspi";

LS2088A:
compatible = "fsl,ls2080a-dspi", "fsl,ls2085a-dspi";

LX2160A:
compatible = "fsl,lx2160a-dspi", "fsl,ls2085a-dspi";

LS1043A:
compatible = "fsl,ls1043a-dspi", "fsl,ls1021a-v1.0-dspi";

LS1046A:
compatible = "fsl,ls1021a-v1.0-dspi";

Due to a lack of a more specific compatible string, LS1012A, LS1043A and
LS1046A will fall under the LS1021A umbrella, and LS2088A and LX2160A
under the LS2085A umbrella.

They do work in those modes, but there are slight differences in the
hardware instantiations, mostly related to FIFO sizes (with the more
specific compatible strings, the FIFO size can be increased properly).

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Message-Id: <20200302001958.11105-3-olteanv@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-fsl-dspi.c | 108 +++++++++++++++++++++++++++++--------
 1 file changed, 85 insertions(+), 23 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 6ec2dcb8c57a..021c658886d4 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -133,27 +133,66 @@ struct fsl_dspi_devtype_data {
 	bool			xspi_mode;
 };
 
-static const struct fsl_dspi_devtype_data vf610_data = {
-	.trans_mode		= DSPI_DMA_MODE,
-	.max_clock_factor	= 2,
+enum {
+	LS1021A,
+	LS1012A,
+	LS1043A,
+	LS1046A,
+	LS2080A,
+	LS2085A,
+	LX2160A,
+	MCF5441X,
+	VF610,
 };
 
-static const struct fsl_dspi_devtype_data ls1021a_v1_data = {
-	.trans_mode		= DSPI_TCFQ_MODE,
-	.max_clock_factor	= 8,
-	.ptp_sts_supported	= true,
-	.xspi_mode		= true,
-};
-
-static const struct fsl_dspi_devtype_data ls2085a_data = {
-	.trans_mode		= DSPI_TCFQ_MODE,
-	.max_clock_factor	= 8,
-	.ptp_sts_supported	= true,
-};
-
-static const struct fsl_dspi_devtype_data coldfire_data = {
-	.trans_mode		= DSPI_EOQ_MODE,
-	.max_clock_factor	= 8,
+static const struct fsl_dspi_devtype_data devtype_data[] = {
+	[VF610] = {
+		.trans_mode		= DSPI_DMA_MODE,
+		.max_clock_factor	= 2,
+	},
+	[LS1021A] = {
+		.trans_mode		= DSPI_TCFQ_MODE,
+		.max_clock_factor	= 8,
+		.ptp_sts_supported	= true,
+		.xspi_mode		= true,
+	},
+	[LS1012A] = {
+		.trans_mode		= DSPI_TCFQ_MODE,
+		.max_clock_factor	= 8,
+		.ptp_sts_supported	= true,
+		.xspi_mode		= true,
+	},
+	[LS1043A] = {
+		.trans_mode		= DSPI_TCFQ_MODE,
+		.max_clock_factor	= 8,
+		.ptp_sts_supported	= true,
+		.xspi_mode		= true,
+	},
+	[LS1046A] = {
+		.trans_mode		= DSPI_TCFQ_MODE,
+		.max_clock_factor	= 8,
+		.ptp_sts_supported	= true,
+		.xspi_mode		= true,
+	},
+	[LS2080A] = {
+		.trans_mode		= DSPI_TCFQ_MODE,
+		.max_clock_factor	= 8,
+		.ptp_sts_supported	= true,
+	},
+	[LS2085A] = {
+		.trans_mode		= DSPI_TCFQ_MODE,
+		.max_clock_factor	= 8,
+		.ptp_sts_supported	= true,
+	},
+	[LX2160A] = {
+		.trans_mode		= DSPI_TCFQ_MODE,
+		.max_clock_factor	= 8,
+		.ptp_sts_supported	= true,
+	},
+	[MCF5441X] = {
+		.trans_mode		= DSPI_EOQ_MODE,
+		.max_clock_factor	= 8,
+	},
 };
 
 struct fsl_dspi_dma {
@@ -909,9 +948,31 @@ static void dspi_cleanup(struct spi_device *spi)
 }
 
 static const struct of_device_id fsl_dspi_dt_ids[] = {
-	{ .compatible = "fsl,vf610-dspi", .data = &vf610_data, },
-	{ .compatible = "fsl,ls1021a-v1.0-dspi", .data = &ls1021a_v1_data, },
-	{ .compatible = "fsl,ls2085a-dspi", .data = &ls2085a_data, },
+	{
+		.compatible = "fsl,vf610-dspi",
+		.data = &devtype_data[VF610],
+	}, {
+		.compatible = "fsl,ls1021a-v1.0-dspi",
+		.data = &devtype_data[LS1021A],
+	}, {
+		.compatible = "fsl,ls1012a-dspi",
+		.data = &devtype_data[LS1012A],
+	}, {
+		.compatible = "fsl,ls1043a-dspi",
+		.data = &devtype_data[LS1043A],
+	}, {
+		.compatible = "fsl,ls1046a-dspi",
+		.data = &devtype_data[LS1046A],
+	}, {
+		.compatible = "fsl,ls2080a-dspi",
+		.data = &devtype_data[LS2080A],
+	}, {
+		.compatible = "fsl,ls2085a-dspi",
+		.data = &devtype_data[LS2085A],
+	}, {
+		.compatible = "fsl,lx2160a-dspi",
+		.data = &devtype_data[LX2160A],
+	},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, fsl_dspi_dt_ids);
@@ -1064,7 +1125,8 @@ static int dspi_probe(struct platform_device *pdev)
 		ctlr->num_chipselect = pdata->cs_num;
 		ctlr->bus_num = pdata->bus_num;
 
-		dspi->devtype_data = &coldfire_data;
+		/* Only Coldfire uses platform data */
+		dspi->devtype_data = &devtype_data[MCF5441X];
 	} else {
 
 		ret = of_property_read_u32(np, "spi-num-chipselects", &cs_num);
-- 
2.20.1

