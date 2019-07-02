Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 301AA5D00C
	for <lists+linux-spi@lfdr.de>; Tue,  2 Jul 2019 15:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbfGBNFD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 2 Jul 2019 09:05:03 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:40604 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727133AbfGBNFC (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 2 Jul 2019 09:05:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=EXZcCEZ51ZisvJHtaBCKmIdJTSbF5mTt/3It5b3+/0s=; b=Sdx1KffC6Q07
        BdBYw5jsi3uIXUS8PUpC1FrUMHCcvFtyixsFOQdnjfv7tGBEkcAn4hE+aLqdAIir8P6xKliy50bBq
        j4m0ucYg27bYQCn0zxK4ouRyxM2yOdW9M36bij9+J+QdiOlpnv21l56Dzh3iLYSGZ/nOpvgk+cYwg
        dHA+g=;
Received: from [2001:470:1f1d:6b5:7e7a:91ff:fede:4a45] (helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hiISt-0002Oc-4C; Tue, 02 Jul 2019 13:04:55 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 6FCC0440046; Tue,  2 Jul 2019 14:04:54 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>
Cc:     alexandre.belloni@bootlin.com, broonie@kernel.org,
        Claudiu.Beznea@microchip.com, linux-arm-kernel@lists.infradead.org,
        linux-spi@vger.kernel.org, Ludovic.Desroches@microchip.com,
        Mark Brown <broonie@kernel.org>,
        Mark Deneen <mdeneen@gmail.com>, mdeneen@gmail.com,
        Nicolas.Ferre@microchip.com, Tudor.Ambarus@microchip.com
Subject: Applied "spi: atmel-quadspi: fix resume call" to the spi tree
In-Reply-To: <20190628153009.7571-3-tudor.ambarus@microchip.com>
X-Patchwork-Hint: ignore
Message-Id: <20190702130454.6FCC0440046@finisterre.sirena.org.uk>
Date:   Tue,  2 Jul 2019 14:04:54 +0100 (BST)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: atmel-quadspi: fix resume call

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

From 0db3a61b4b3ceaea68b748ee63cc88f110757b7f Mon Sep 17 00:00:00 2001
From: Tudor Ambarus <tudor.ambarus@microchip.com>
Date: Fri, 28 Jun 2019 15:30:34 +0000
Subject: [PATCH] spi: atmel-quadspi: fix resume call

When waking up from the Suspend-to-RAM state, the following error
was seen:

m25p80 spi2.0: flash operation timed out

The flash remained in an undefined state, returning 0xFFs.
Fix it by setting the Serial Clock Baud Rate, as it was set
before the conversion to SPIMEM.

Tested with sama5d2_xplained and mx25l25673g spi-nor in
Backup + Self-Refresh and Suspend modes.

Fixes: 0e6aae08e9ae ("spi: Add QuadSPI driver for Atmel SAMA5D2")
Reported-by: Mark Deneen <mdeneen@gmail.com>
Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/atmel-quadspi.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index 32eb7447c31a..6a7d7b553d95 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -151,6 +151,7 @@ struct atmel_qspi {
 	const struct atmel_qspi_caps *caps;
 	u32			pending;
 	u32			mr;
+	u32			scr;
 	struct completion	cmd_completion;
 };
 
@@ -382,7 +383,7 @@ static int atmel_qspi_setup(struct spi_device *spi)
 	struct spi_controller *ctrl = spi->master;
 	struct atmel_qspi *aq = spi_controller_get_devdata(ctrl);
 	unsigned long src_rate;
-	u32 scr, scbr;
+	u32 scbr;
 
 	if (ctrl->busy)
 		return -EBUSY;
@@ -399,8 +400,8 @@ static int atmel_qspi_setup(struct spi_device *spi)
 	if (scbr > 0)
 		scbr--;
 
-	scr = QSPI_SCR_SCBR(scbr);
-	writel_relaxed(scr, aq->regs + QSPI_SCR);
+	aq->scr = QSPI_SCR_SCBR(scbr);
+	writel_relaxed(aq->scr, aq->regs + QSPI_SCR);
 
 	return 0;
 }
@@ -584,6 +585,9 @@ static int __maybe_unused atmel_qspi_resume(struct device *dev)
 	clk_prepare_enable(aq->qspick);
 
 	atmel_qspi_init(aq);
+
+	writel_relaxed(aq->scr, aq->regs + QSPI_SCR);
+
 	return 0;
 }
 
-- 
2.20.1

