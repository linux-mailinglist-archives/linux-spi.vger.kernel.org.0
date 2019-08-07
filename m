Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A90184D5C
	for <lists+linux-spi@lfdr.de>; Wed,  7 Aug 2019 15:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388501AbfHGNdd (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 7 Aug 2019 09:33:33 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:35382 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388343AbfHGNa7 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 7 Aug 2019 09:30:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=wePaec3SXHHqMOt41BBbfhloJLL9jiHqCk1ynwjjVM4=; b=N2cI1wuwFIsb
        GRs3MvvWLiSvHbPPe0a2GdzCh2TnxuwbSpxA3YELbdOSnD4K3YPixe2X7jKyMYsPzRbwNAka3swZd
        tDQXVwfjnoYcNbADy2Zr3NRkRpZpjirPUZI9w9ClgDzRqaOd2DsU483XNfBUtaph4X/jfP2yBpS/N
        0P35g=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1hvM1o-0007hK-7Z; Wed, 07 Aug 2019 13:30:56 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 9FA742742B9E; Wed,  7 Aug 2019 14:30:55 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     linux-renesas-soc@vger.kernel.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: Applied "spi: sh-msiof: Use devm_platform_ioremap_resource() helper" to the spi tree
In-Reply-To: <20190807085213.24666-1-geert+renesas@glider.be>
X-Patchwork-Hint: ignore
Message-Id: <20190807133055.9FA742742B9E@ypsilon.sirena.org.uk>
Date:   Wed,  7 Aug 2019 14:30:55 +0100 (BST)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: sh-msiof: Use devm_platform_ioremap_resource() helper

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.4

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

From 920d947af9cd528338bbfe989449489a9962142f Mon Sep 17 00:00:00 2001
From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 7 Aug 2019 10:52:13 +0200
Subject: [PATCH] spi: sh-msiof: Use devm_platform_ioremap_resource() helper

Use the devm_platform_ioremap_resource() helper instead of open-coding
the same operation.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20190807085213.24666-1-geert+renesas@glider.be
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-sh-msiof.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index f73f811c9ba7..8f134735291f 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -1297,7 +1297,6 @@ static void sh_msiof_release_dma(struct sh_msiof_spi_priv *p)
 
 static int sh_msiof_spi_probe(struct platform_device *pdev)
 {
-	struct resource	*r;
 	struct spi_controller *ctlr;
 	const struct sh_msiof_chipdata *chipdata;
 	struct sh_msiof_spi_info *info;
@@ -1350,8 +1349,7 @@ static int sh_msiof_spi_probe(struct platform_device *pdev)
 		goto err1;
 	}
 
-	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	p->mapbase = devm_ioremap_resource(&pdev->dev, r);
+	p->mapbase = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(p->mapbase)) {
 		ret = PTR_ERR(p->mapbase);
 		goto err1;
-- 
2.20.1

