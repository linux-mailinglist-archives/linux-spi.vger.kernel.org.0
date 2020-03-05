Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A767717A7D8
	for <lists+linux-spi@lfdr.de>; Thu,  5 Mar 2020 15:38:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbgCEOh4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 5 Mar 2020 09:37:56 -0500
Received: from foss.arm.com ([217.140.110.172]:49486 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726676AbgCEOhz (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 5 Mar 2020 09:37:55 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EB9401045;
        Thu,  5 Mar 2020 06:37:54 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6FA103F534;
        Thu,  5 Mar 2020 06:37:54 -0800 (PST)
Date:   Thu, 05 Mar 2020 14:37:52 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     andrew.smirnov@gmail.com, angelo@sysam.it, broonie@kernel.org,
        eha@deif.com, gustavo@embeddedor.com, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        mhosny@nvidia.com, weic@nvidia.com
Subject: Applied "spi: spi-fsl-dspi: Don't mask off undefined bits" to the spi tree
In-Reply-To:  <20200304220044.11193-4-olteanv@gmail.com>
Message-Id:  <applied-20200304220044.11193-4-olteanv@gmail.com>
X-Patchwork-Hint: ignore
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: spi-fsl-dspi: Don't mask off undefined bits

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

From 5542bd797190d5d77f1ad3a6df9628f26d117b31 Mon Sep 17 00:00:00 2001
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Thu, 5 Mar 2020 00:00:35 +0200
Subject: [PATCH] spi: spi-fsl-dspi: Don't mask off undefined bits

This is a useless operation, and if the driver needs to do that, there's
something deeply wrong going on.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Link: https://lore.kernel.org/r/20200304220044.11193-4-olteanv@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-fsl-dspi.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 63ec1d634d08..b92c2b84a94b 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -274,9 +274,6 @@ static void dspi_push_rx(struct fsl_dspi *dspi, u32 rxdata)
 	if (!dspi->rx)
 		return;
 
-	/* Mask off undefined bits */
-	rxdata &= (1 << dspi->bits_per_word) - 1;
-
 	memcpy(dspi->rx, &rxdata, dspi->bytes_per_word);
 	dspi->rx += dspi->bytes_per_word;
 }
-- 
2.20.1

