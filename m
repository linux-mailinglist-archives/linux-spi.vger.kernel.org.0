Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D63BA1B5FC
	for <lists+linux-spi@lfdr.de>; Mon, 13 May 2019 14:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729244AbfEMMcD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 13 May 2019 08:32:03 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:59144 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728755AbfEMMcC (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 13 May 2019 08:32:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=DyTZZDy5htEJd2c/YmV8wjqlvgY0f2BXhVkZBBNvqiE=; b=IV919rFLx6om
        DyIVwo56mxJ6+h6MnNq6mGysv0T4liq5xv+7APMr00Zo7QjeuiX8ECkHnjImlnqjUtpx8B2f7FCZk
        IwteVlmk2WbDvGa3N787pcjfzjPZOeTPDNYnLDE6dx/9zMnituqhl9af1OpalungI3u986EibQnVh
        cu78U=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hQA7T-0006aR-QN; Mon, 13 May 2019 12:31:51 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 6CC771129232; Mon, 13 May 2019 13:31:51 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Eric Anholt <eric@anholt.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: Applied "spi: bcm2835: only split transfers that exceed DLEN if DMA available" to the spi tree
In-Reply-To: <20190509144000.681-1-nsaenzjulienne@suse.de>
X-Patchwork-Hint: ignore
Message-Id: <20190513123151.6CC771129232@debutante.sirena.org.uk>
Date:   Mon, 13 May 2019 13:31:51 +0100 (BST)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: bcm2835: only split transfers that exceed DLEN if DMA available

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

From 3393f7d924510cfdb2ff9594eac2590d5de16d92 Mon Sep 17 00:00:00 2001
From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Date: Thu, 9 May 2019 16:39:59 +0200
Subject: [PATCH] spi: bcm2835: only split transfers that exceed DLEN if DMA
 available

There is no use for this when performing non DMA operations. So we
bypass the split.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-bcm2835.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index 3a9b2187787a..f87a023a445a 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -895,15 +895,17 @@ static int bcm2835_spi_prepare_message(struct spi_master *master,
 	u32 cs = bcm2835_rd(bs, BCM2835_SPI_CS);
 	int ret;
 
-	/*
-	 * DMA transfers are limited to 16 bit (0 to 65535 bytes) by the SPI HW
-	 * due to DLEN. Split up transfers (32-bit FIFO aligned) if the limit is
-	 * exceeded.
-	 */
-	ret = spi_split_transfers_maxsize(master, msg, 65532,
-					  GFP_KERNEL | GFP_DMA);
-	if (ret)
-		return ret;
+	if (master->can_dma) {
+		/*
+		 * DMA transfers are limited to 16 bit (0 to 65535 bytes) by
+		 * the SPI HW due to DLEN. Split up transfers (32-bit FIFO
+		 * aligned) if the limit is exceeded.
+		 */
+		ret = spi_split_transfers_maxsize(master, msg, 65532,
+						  GFP_KERNEL | GFP_DMA);
+		if (ret)
+			return ret;
+	}
 
 	cs &= ~(BCM2835_SPI_CS_CPOL | BCM2835_SPI_CS_CPHA);
 
-- 
2.20.1

