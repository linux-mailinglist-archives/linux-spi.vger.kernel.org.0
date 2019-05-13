Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC2121B606
	for <lists+linux-spi@lfdr.de>; Mon, 13 May 2019 14:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729353AbfEMMcK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 13 May 2019 08:32:10 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:59232 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729925AbfEMMcF (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 13 May 2019 08:32:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=fnonVj0BqdaJTpRu1iZEPcT/t2ZoLWuSPAwkZSwWYcc=; b=sC4X63XnH6o7
        HYZ+1P+shqMcdtiit296KcWpgJ7VKImbLrcjP8xqcvSvbZL+q0z4BNWetg9QuMQR9p6dmqHtgZRl8
        zlOwAYbwfK3lu7SZ1fAlIbfHZFIx2Eeqi7djBM1OjIQ33boobPPnbLJ4OkyuqYCZFCCG0nwixAN4s
        uDJTc=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hQA7U-0006aU-E1; Mon, 13 May 2019 12:31:52 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id CFAD31129234; Mon, 13 May 2019 13:31:51 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Hoan Nguyen An <na-hoan@jinso.co.jp>
Cc:     broonie@kernel.org, eric@anholt.net,
        linux-rpi-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, na-hoan@jinso.co.jp,
        stefan.wahren@i2se.com
Subject: Applied "spi: bcm2835: Remove spi_alloc_master() error printing" to the spi tree
In-Reply-To: <1557477738-20634-1-git-send-email-na-hoan@jinso.co.jp>
X-Patchwork-Hint: ignore
Message-Id: <20190513123151.CFAD31129234@debutante.sirena.org.uk>
Date:   Mon, 13 May 2019 13:31:51 +0100 (BST)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: bcm2835: Remove spi_alloc_master() error printing

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

From bfada2080b6439e997bfeae43ed73a3e41c351fd Mon Sep 17 00:00:00 2001
From: Hoan Nguyen An <na-hoan@jinso.co.jp>
Date: Fri, 10 May 2019 17:42:18 +0900
Subject: [PATCH] spi: bcm2835: Remove spi_alloc_master() error printing

Printing an error on memory allocation failure is unnecessary,
as the memory allocation core code already takes care of that.

Signed-off-by: Hoan Nguyen An <na-hoan@jinso.co.jp>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Martin Sperl <kernel@martin.sperl.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-bcm2835.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index eb67da697ef5..3a9b2187787a 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -992,10 +992,8 @@ static int bcm2835_spi_probe(struct platform_device *pdev)
 	int err;
 
 	master = spi_alloc_master(&pdev->dev, sizeof(*bs));
-	if (!master) {
-		dev_err(&pdev->dev, "spi_alloc_master() failed\n");
+	if (!master)
 		return -ENOMEM;
-	}
 
 	platform_set_drvdata(pdev, master);
 
-- 
2.20.1

