Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2878F1797E5
	for <lists+linux-spi@lfdr.de>; Wed,  4 Mar 2020 19:29:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729600AbgCDS3Z (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 4 Mar 2020 13:29:25 -0500
Received: from foss.arm.com ([217.140.110.172]:38300 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725795AbgCDS3Z (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 4 Mar 2020 13:29:25 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 47EE031B;
        Wed,  4 Mar 2020 10:29:25 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BF2923F6C4;
        Wed,  4 Mar 2020 10:29:24 -0800 (PST)
Date:   Wed, 04 Mar 2020 18:29:23 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     broonie@kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "spi: spi-fsl-dspi: LS2080A and LX2160A support XSPI mode" to the spi tree
In-Reply-To:  <20200302001958.11105-5-olteanv@gmail.com>
Message-Id:  <applied-20200302001958.11105-5-olteanv@gmail.com>
X-Patchwork-Hint: ignore
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: spi-fsl-dspi: LS2080A and LX2160A support XSPI mode

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

From ca5052c8bfab7a44efd2161ce2a9d67dfc126aa6 Mon Sep 17 00:00:00 2001
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Mon, 2 Mar 2020 02:19:56 +0200
Subject: [PATCH] spi: spi-fsl-dspi: LS2080A and LX2160A support XSPI mode

XSPI allows for 2 extra features:
- Command cycling (use a single TX command with more than 1 word in the
  TX FIFO).
- Increased word size (from 16 bits to 32 bits)

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Message-Id: <20200302001958.11105-5-olteanv@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-fsl-dspi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 55ccb3d0f683..d21cc5cdc8a4 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -179,6 +179,7 @@ static const struct fsl_dspi_devtype_data devtype_data[] = {
 		.trans_mode		= DSPI_TCFQ_MODE,
 		.max_clock_factor	= 8,
 		.ptp_sts_supported	= true,
+		.xspi_mode		= true,
 		.fifo_size		= 4,
 	},
 	[LS2085A] = {
@@ -191,6 +192,7 @@ static const struct fsl_dspi_devtype_data devtype_data[] = {
 		.trans_mode		= DSPI_TCFQ_MODE,
 		.max_clock_factor	= 8,
 		.ptp_sts_supported	= true,
+		.xspi_mode		= true,
 		.fifo_size		= 4,
 	},
 	[MCF5441X] = {
-- 
2.20.1

