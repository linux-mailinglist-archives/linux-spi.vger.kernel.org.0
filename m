Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1798B17A7CB
	for <lists+linux-spi@lfdr.de>; Thu,  5 Mar 2020 15:37:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbgCEOhm (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 5 Mar 2020 09:37:42 -0500
Received: from foss.arm.com ([217.140.110.172]:49414 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726142AbgCEOhm (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 5 Mar 2020 09:37:42 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ACF721045;
        Thu,  5 Mar 2020 06:37:41 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 302243F534;
        Thu,  5 Mar 2020 06:37:41 -0800 (PST)
Date:   Thu, 05 Mar 2020 14:37:39 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     andrew.smirnov@gmail.com, angelo@sysam.it, broonie@kernel.org,
        eha@deif.com, gustavo@embeddedor.com, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        mhosny@nvidia.com, weic@nvidia.com
Subject: Applied "spi: spi-fsl-dspi: Implement .max_message_size method for EOQ mode" to the spi tree
In-Reply-To:  <20200304220044.11193-7-olteanv@gmail.com>
Message-Id:  <applied-20200304220044.11193-7-olteanv@gmail.com>
X-Patchwork-Hint: ignore
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: spi-fsl-dspi: Implement .max_message_size method for EOQ mode

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

From a3185c38dc6cd664b2b576eb9d3e5d2f49101a10 Mon Sep 17 00:00:00 2001
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Thu, 5 Mar 2020 00:00:38 +0200
Subject: [PATCH] spi: spi-fsl-dspi: Implement .max_message_size method for EOQ
 mode

When it gets set, End Of Queue Flag halts the DSPI controller and forces
the chip select signal to deassert.

This operating mode is not ideal, but it is used for the DSPI
instantiations where there is no other notification from the controller
that the data in the FIFO has finished transmission. So in practice, it
means that transmitting buffers larger than the FIFO size will yield
unpredictable results.

The only controller that operates in EOQ mode is MCF5441X (Coldfire). I
would say that the way EOQ is used (and documented in the reference
manual, too) on this chip is incorrect, and I would personally migrate
it to TCFQ, but that's notably worse in terms of performance (it can
only use 1 entry of the 16-deep FIFO) and if this limitation didn't
bother any Coldfire DSPI user so far, it's likely that we just need to
throw an error for larger buffers to make sure that callers are aware
their transfers are getting truncated/split.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Link: https://lore.kernel.org/r/20200304220044.11193-7-olteanv@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-fsl-dspi.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index f37090ad7ad1..158cb48c0f4a 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -1084,6 +1084,22 @@ static int dspi_slave_abort(struct spi_master *master)
 	return 0;
 }
 
+/*
+ * EOQ mode will inevitably deassert its PCS signal on last word in a queue
+ * (hardware limitation), so we need to inform the spi_device that larger
+ * buffers than the FIFO size are going to have the chip select randomly
+ * toggling, so it has a chance to adapt its message sizes.
+ */
+static size_t dspi_max_message_size(struct spi_device *spi)
+{
+	struct fsl_dspi *dspi = spi_controller_get_devdata(spi->controller);
+
+	if (dspi->devtype_data->trans_mode == DSPI_EOQ_MODE)
+		return dspi->devtype_data->fifo_size;
+
+	return SIZE_MAX;
+}
+
 static int dspi_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
@@ -1105,6 +1121,7 @@ static int dspi_probe(struct platform_device *pdev)
 
 	ctlr->setup = dspi_setup;
 	ctlr->transfer_one_message = dspi_transfer_one_message;
+	ctlr->max_message_size = dspi_max_message_size;
 	ctlr->dev.of_node = pdev->dev.of_node;
 
 	ctlr->cleanup = dspi_cleanup;
-- 
2.20.1

