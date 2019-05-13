Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60D881B605
	for <lists+linux-spi@lfdr.de>; Mon, 13 May 2019 14:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729379AbfEMMcK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 13 May 2019 08:32:10 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:59202 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729922AbfEMMcF (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 13 May 2019 08:32:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=Vae6C+w3oMIyAVPxKocdPpyoUGNDEx0zcYD2LohFVm4=; b=XdrP9SZfvf5z
        NefTEMEOI+ptVdfkv0jbFzihALIYMB/1YGLclXFEp88tSWDFStrz7DipGNZ1ExBZthmLsCwf3QTtn
        9Nr9ws2oKXGAFywiKFfP24ISh4QN9c7k8lZEHMCPAvDv+Ga0HnS1Ni32FMfldBuxdtCt8lQFrlReW
        nnQUg=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hQA7U-0006aW-FI; Mon, 13 May 2019 12:31:52 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 0B6F31129232; Mon, 13 May 2019 13:31:52 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Hoan Nguyen An <na-hoan@jinso.co.jp>
Cc:     broonie@kernel.org, eric@anholt.net,
        linux-rpi-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, stefan.wahren@i2se.com
Subject: Applied "spi: bcm2835aux: Remove spi_alloc_master() error printing" to the spi tree
In-Reply-To: <1557480060-15311-1-git-send-email-na-hoan@jinso.co.jp>
X-Patchwork-Hint: ignore
Message-Id: <20190513123152.0B6F31129232@debutante.sirena.org.uk>
Date:   Mon, 13 May 2019 13:31:52 +0100 (BST)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: bcm2835aux: Remove spi_alloc_master() error printing

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

From bf93b9512645d2b2f42740ba4918b55d7b5f40a7 Mon Sep 17 00:00:00 2001
From: Hoan Nguyen An <na-hoan@jinso.co.jp>
Date: Fri, 10 May 2019 18:21:00 +0900
Subject: [PATCH] spi: bcm2835aux: Remove spi_alloc_master() error printing

Printing an error on memory allocation failure is unnecessary,
as the memory allocation core code already takes care of that.

Signed-off-by: Hoan Nguyen An <na-hoan@jinso.co.jp>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Martin Sperl <kernel@martin.sperl.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-bcm2835aux.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/spi/spi-bcm2835aux.c b/drivers/spi/spi-bcm2835aux.c
index bbf87adb3ff8..4523bacd583f 100644
--- a/drivers/spi/spi-bcm2835aux.c
+++ b/drivers/spi/spi-bcm2835aux.c
@@ -505,10 +505,8 @@ static int bcm2835aux_spi_probe(struct platform_device *pdev)
 	int err;
 
 	master = spi_alloc_master(&pdev->dev, sizeof(*bs));
-	if (!master) {
-		dev_err(&pdev->dev, "spi_alloc_master() failed\n");
+	if (!master)
 		return -ENOMEM;
-	}
 
 	platform_set_drvdata(pdev, master);
 	master->mode_bits = (SPI_CPOL | SPI_CS_HIGH | SPI_NO_CS);
-- 
2.20.1

