Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3794417A7C9
	for <lists+linux-spi@lfdr.de>; Thu,  5 Mar 2020 15:37:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbgCEOhi (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 5 Mar 2020 09:37:38 -0500
Received: from foss.arm.com ([217.140.110.172]:49396 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726142AbgCEOhh (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 5 Mar 2020 09:37:37 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4485E4B2;
        Thu,  5 Mar 2020 06:37:37 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BBEBC3F534;
        Thu,  5 Mar 2020 06:37:36 -0800 (PST)
Date:   Thu, 05 Mar 2020 14:37:35 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     andrew.smirnov@gmail.com, angelo@sysam.it, broonie@kernel.org,
        eha@deif.com, gustavo@embeddedor.com, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        mhosny@nvidia.com, weic@nvidia.com
Subject: Applied "spi: Do spi_take_timestamp_pre for as many times as necessary" to the spi tree
In-Reply-To:  <20200304220044.11193-8-olteanv@gmail.com>
Message-Id:  <applied-20200304220044.11193-8-olteanv@gmail.com>
X-Patchwork-Hint: ignore
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: Do spi_take_timestamp_pre for as many times as necessary

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

From 6a726824aaa3adaaf3bcfca3b471408e225f33d6 Mon Sep 17 00:00:00 2001
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Thu, 5 Mar 2020 00:00:39 +0200
Subject: [PATCH] spi: Do spi_take_timestamp_pre for as many times as necessary

When dealing with a SPI controller driver that is sending more than 1
byte at once (or the entire buffer at once), and the SPI peripheral
driver has requested timestamping for a byte in the middle of the
buffer, we find that spi_take_timestamp_pre never records a "pre"
timestamp.

This happens because the function currently expects to be called with
the "progress" argument >= to what the peripheral has requested to be
timestamped. But clearly there are cases when that isn't going to fly.

And since we can't change the past when we realize that the opportunity
to take a "pre" timestamp has just passed and there isn't going to be
another one, the approach taken is to keep recording the "pre" timestamp
on each call, overwriting the previously recorded one until the "post"
timestamp is also taken.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Link: https://lore.kernel.org/r/20200304220044.11193-8-olteanv@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi.c       | 19 +++++++------------
 include/linux/spi/spi.h |  3 +--
 2 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 292f26807b41..6c223f7d1ddc 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1515,17 +1515,15 @@ void spi_take_timestamp_pre(struct spi_controller *ctlr,
 	if (!xfer->ptp_sts)
 		return;
 
-	if (xfer->timestamped_pre)
+	if (xfer->timestamped)
 		return;
 
-	if (progress < xfer->ptp_sts_word_pre)
+	if (progress > xfer->ptp_sts_word_pre)
 		return;
 
 	/* Capture the resolution of the timestamp */
 	xfer->ptp_sts_word_pre = progress;
 
-	xfer->timestamped_pre = true;
-
 	if (irqs_off) {
 		local_irq_save(ctlr->irq_flags);
 		preempt_disable();
@@ -1554,7 +1552,7 @@ void spi_take_timestamp_post(struct spi_controller *ctlr,
 	if (!xfer->ptp_sts)
 		return;
 
-	if (xfer->timestamped_post)
+	if (xfer->timestamped)
 		return;
 
 	if (progress < xfer->ptp_sts_word_post)
@@ -1570,7 +1568,7 @@ void spi_take_timestamp_post(struct spi_controller *ctlr,
 	/* Capture the resolution of the timestamp */
 	xfer->ptp_sts_word_post = progress;
 
-	xfer->timestamped_post = true;
+	xfer->timestamped = true;
 }
 EXPORT_SYMBOL_GPL(spi_take_timestamp_post);
 
@@ -1675,12 +1673,9 @@ void spi_finalize_current_message(struct spi_controller *ctlr)
 		}
 	}
 
-	if (unlikely(ctlr->ptp_sts_supported)) {
-		list_for_each_entry(xfer, &mesg->transfers, transfer_list) {
-			WARN_ON_ONCE(xfer->ptp_sts && !xfer->timestamped_pre);
-			WARN_ON_ONCE(xfer->ptp_sts && !xfer->timestamped_post);
-		}
-	}
+	if (unlikely(ctlr->ptp_sts_supported))
+		list_for_each_entry(xfer, &mesg->transfers, transfer_list)
+			WARN_ON_ONCE(xfer->ptp_sts && !xfer->timestamped);
 
 	spi_unmap_msg(ctlr, mesg);
 
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 600e3793303e..87105272879b 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -933,8 +933,7 @@ struct spi_transfer {
 
 	struct ptp_system_timestamp *ptp_sts;
 
-	bool		timestamped_pre;
-	bool		timestamped_post;
+	bool		timestamped;
 
 	struct list_head transfer_list;
 };
-- 
2.20.1

