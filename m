Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DEB7174A0
	for <lists+linux-spi@lfdr.de>; Wed,  8 May 2019 11:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbfEHJJR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 8 May 2019 05:09:17 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:57658 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbfEHJJQ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 8 May 2019 05:09:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=f24yIUqKY62IUeKCB9wagap3Ak2+vXM3hqhMbChgSU4=; b=SG64waa3mliC
        f9LkGEKXMhvjLx9PwgFbIeoIFO90JDC0Hc0nypkmHCg6dI4hkIKbCq2tEuYVesAKzMy1cye0jhfs9
        pQG7JO3CI6xkiY+BRbmMwh2up+cr0/MfKb1nSpcbyzmchoxYfoJmPGbUhI8H3K2Tx5ah1T4bILDL2
        lPWV0=;
Received: from [61.199.190.11] (helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hOIZU-0007gI-Cp; Wed, 08 May 2019 09:09:09 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 3E3B3440036; Wed,  8 May 2019 10:08:55 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Martin Sperl <kernel@martin.sperl.org>
Cc:     Eric Anholt <eric@anholt.net>,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: Applied "spi: bcm2835: added comment about different bus behaviour of DMA mode" to the spi tree
In-Reply-To: <20190423201513.8073-4-kernel@martin.sperl.org>
X-Patchwork-Hint: ignore
Message-Id: <20190508090855.3E3B3440036@finisterre.sirena.org.uk>
Date:   Wed,  8 May 2019 10:08:55 +0100 (BST)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: bcm2835: added comment about different bus behaviour of DMA mode

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

From c41d62b06cb92289ab5db9d37a0f27fe6271fa34 Mon Sep 17 00:00:00 2001
From: Martin Sperl <kernel@martin.sperl.org>
Date: Tue, 23 Apr 2019 20:15:10 +0000
Subject: [PATCH] spi: bcm2835: added comment about different bus behaviour of
 DMA mode

The DMA mode behaves slightly different than polling or interrupt driven
mode, so just document the fact

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>

Changelog:
  V1 -> V2: applied feedback by Stefan Wahren
            new in V2
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-bcm2835.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index b7bb07c9507d..0d8c97502f14 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -800,7 +800,10 @@ static int bcm2835_spi_transfer_one(struct spi_master *master,
 	if (tfr->len < spi_used_hz / HZ_PER_BYTE)
 		return bcm2835_spi_transfer_one_poll(master, spi, tfr, cs);
 
-	/* run in dma mode if conditions are right */
+	/* run in dma mode if conditions are right
+	 * Note that unlike poll or interrupt mode DMA mode does not have
+	 * this 1 idle clock cycle pattern but runs the spi clock without gaps
+	 */
 	if (master->can_dma && bcm2835_spi_can_dma(master, spi, tfr))
 		return bcm2835_spi_transfer_one_dma(master, spi, tfr, cs);
 
-- 
2.20.1

