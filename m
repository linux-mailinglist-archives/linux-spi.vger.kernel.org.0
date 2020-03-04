Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A773C1797E1
	for <lists+linux-spi@lfdr.de>; Wed,  4 Mar 2020 19:29:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730128AbgCDS3Q (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 4 Mar 2020 13:29:16 -0500
Received: from foss.arm.com ([217.140.110.172]:38286 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725795AbgCDS3Q (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 4 Mar 2020 13:29:16 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1588831B;
        Wed,  4 Mar 2020 10:29:16 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8B4DE3F6C4;
        Wed,  4 Mar 2020 10:29:15 -0800 (PST)
Date:   Wed, 04 Mar 2020 18:29:14 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     broonie@kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "spi: spi-fsl-dspi: Convert the instantiations that support it to DMA" to the spi tree
In-Reply-To:  <20200302001958.11105-7-olteanv@gmail.com>
Message-Id:  <applied-20200302001958.11105-7-olteanv@gmail.com>
X-Patchwork-Hint: ignore
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: spi-fsl-dspi: Convert the instantiations that support it to DMA

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

From 0feaf8f5afe057c397a440e76865b3d746dc9f7e Mon Sep 17 00:00:00 2001
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Mon, 2 Mar 2020 02:19:58 +0200
Subject: [PATCH] spi: spi-fsl-dspi: Convert the instantiations that support it
 to DMA

The A-011218 eDMA/DSPI erratum affects most of the older Layerscape SoCs
with DSPI, and its workaround is a bit intrusive.

After this patch, there are no users of TCFQ mode that don't also
support XSPI (previously there was LS2085A).

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Message-Id: <20200302001958.11105-7-olteanv@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-fsl-dspi.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index c26a42f8ecbc..c357c3247232 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -147,42 +147,49 @@ static const struct fsl_dspi_devtype_data devtype_data[] = {
 		.fifo_size		= 4,
 	},
 	[LS1021A] = {
+		/* Has A-011218 DMA erratum */
 		.trans_mode		= DSPI_TCFQ_MODE,
 		.max_clock_factor	= 8,
 		.xspi_mode		= true,
 		.fifo_size		= 4,
 	},
 	[LS1012A] = {
+		/* Has A-011218 DMA erratum */
 		.trans_mode		= DSPI_TCFQ_MODE,
 		.max_clock_factor	= 8,
 		.xspi_mode		= true,
 		.fifo_size		= 16,
 	},
 	[LS1043A] = {
+		/* Has A-011218 DMA erratum */
 		.trans_mode		= DSPI_TCFQ_MODE,
 		.max_clock_factor	= 8,
 		.xspi_mode		= true,
 		.fifo_size		= 16,
 	},
 	[LS1046A] = {
+		/* Has A-011218 DMA erratum */
 		.trans_mode		= DSPI_TCFQ_MODE,
 		.max_clock_factor	= 8,
 		.xspi_mode		= true,
 		.fifo_size		= 16,
 	},
 	[LS2080A] = {
-		.trans_mode		= DSPI_TCFQ_MODE,
+		.trans_mode		= DSPI_DMA_MODE,
+		.dma_bufsize		= 8,
 		.max_clock_factor	= 8,
 		.xspi_mode		= true,
 		.fifo_size		= 4,
 	},
 	[LS2085A] = {
-		.trans_mode		= DSPI_TCFQ_MODE,
+		.trans_mode		= DSPI_DMA_MODE,
+		.dma_bufsize		= 8,
 		.max_clock_factor	= 8,
 		.fifo_size		= 4,
 	},
 	[LX2160A] = {
-		.trans_mode		= DSPI_TCFQ_MODE,
+		.trans_mode		= DSPI_DMA_MODE,
+		.dma_bufsize		= 8,
 		.max_clock_factor	= 8,
 		.xspi_mode		= true,
 		.fifo_size		= 4,
-- 
2.20.1

