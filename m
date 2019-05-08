Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85FC2174A2
	for <lists+linux-spi@lfdr.de>; Wed,  8 May 2019 11:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbfEHJJV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 8 May 2019 05:09:21 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:57772 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbfEHJJU (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 8 May 2019 05:09:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=gn9t97HPmXoC1ozrtx5IXyGRI/WtGcItZCxC3ipx6kg=; b=f5Xv34rnSStV
        LPqwpDfxk6OfOfkWm3BfmOJZnWrHm6jj6qeOdYeKPGG/k7GqBk+7DNy1QeLfVgGPVLvCgoAX7knU4
        bCWRz6HlT/+ElaSgN8OkiwlfwKizpJiUIy1feqa8t4Cs29PFapon7tQ5YFs9JWjSdbThozUNisuPp
        Ekryk=;
Received: from [61.199.190.11] (helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hOIZa-0007gM-9P; Wed, 08 May 2019 09:09:11 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 7596B440010; Wed,  8 May 2019 10:08:56 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Martin Sperl <kernel@martin.sperl.org>
Cc:     Eric Anholt <eric@anholt.net>,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: Applied "spi: bcm2835: bcm2835_spi_transfer_one_poll remove unnecessary argument" to the spi tree
In-Reply-To: <20190423201513.8073-2-kernel@martin.sperl.org>
X-Patchwork-Hint: ignore
Message-Id: <20190508090856.7596B440010@finisterre.sirena.org.uk>
Date:   Wed,  8 May 2019 10:08:56 +0100 (BST)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: bcm2835: bcm2835_spi_transfer_one_poll remove unnecessary argument

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.3

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

From 9ac3f90db46b7805a37df2bc419faf369025d64a Mon Sep 17 00:00:00 2001
From: Martin Sperl <kernel@martin.sperl.org>
Date: Tue, 23 Apr 2019 20:15:08 +0000
Subject: [PATCH] spi: bcm2835: bcm2835_spi_transfer_one_poll remove
 unnecessary argument

Remove the unnecessary argument of xfer_time_us when calling
bcm2835_spi_transfer_one_poll.

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>

Changelog:
  V1 -> V2: applied feedback by Stefan Wahren
            reorganized patchset
	    added extra rational, descriptions
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-bcm2835.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index 8aa22713c483..6c73e694794a 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -697,8 +697,7 @@ static void bcm2835_dma_init(struct spi_master *master, struct device *dev)
 static int bcm2835_spi_transfer_one_poll(struct spi_master *master,
 					 struct spi_device *spi,
 					 struct spi_transfer *tfr,
-					 u32 cs,
-					 unsigned long long xfer_time_us)
+					 u32 cs)
 {
 	struct bcm2835_spi *bs = spi_master_get_devdata(master);
 	unsigned long timeout;
@@ -799,8 +798,7 @@ static int bcm2835_spi_transfer_one(struct spi_master *master,
 
 	/* for short requests run polling*/
 	if (xfer_time_us <= BCM2835_SPI_POLLING_LIMIT_US)
-		return bcm2835_spi_transfer_one_poll(master, spi, tfr,
-						     cs, xfer_time_us);
+		return bcm2835_spi_transfer_one_poll(master, spi, tfr, cs);
 
 	/* run in dma mode if conditions are right */
 	if (master->can_dma && bcm2835_spi_can_dma(master, spi, tfr))
-- 
2.20.1

