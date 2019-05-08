Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB3D3174A3
	for <lists+linux-spi@lfdr.de>; Wed,  8 May 2019 11:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbfEHJJY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 8 May 2019 05:09:24 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:57876 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbfEHJJY (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 8 May 2019 05:09:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=COXYRcFBUtXgmLe1rrJSb3TEPOb9/EzOUdDeaGoi6o0=; b=oAeisNZ57zz4
        COQDcdRFLZvXoyvnN5PB5bS0cJ3DdZ2+GGjXwwHp4Vp5e+f2mw4DbECyoMKOhgYUOTWnAcZpULWzs
        MDfx7VbaI1CXl0nw4Yl5QaYy4n1GhQpGG/vOTeDUz+zaAtdDlXf7t7QfckvulVQ13da+cwEseLIbL
        nC48Y=;
Received: from [61.199.190.11] (helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hOIZf-0007gb-Og; Wed, 08 May 2019 09:09:16 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 4A279440017; Wed,  8 May 2019 10:08:58 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Fabio Estevam <festevam@gmail.com>, linux-gpio@vger.kernel.org,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Applied "spi: ep93xx: Drop unused variable" to the spi tree
In-Reply-To: <20190503231829.4112-1-linus.walleij@linaro.org>
X-Patchwork-Hint: ignore
Message-Id: <20190508090858.4A279440017@finisterre.sirena.org.uk>
Date:   Wed,  8 May 2019 10:08:58 +0100 (BST)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: ep93xx: Drop unused variable

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

From e29eaa3c4b76d4dd46d7a92018de1ab2793794e1 Mon Sep 17 00:00:00 2001
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 4 May 2019 01:18:29 +0200
Subject: [PATCH] spi: ep93xx: Drop unused variable

My previous patch leaves a dangling variable in the driver.
get rid of it.

Fixes: 06a391b1621e ("spi: ep93xx: Convert to use CS GPIO descriptors")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-ep93xx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-ep93xx.c b/drivers/spi/spi-ep93xx.c
index 47e39251bad9..81889389280b 100644
--- a/drivers/spi/spi-ep93xx.c
+++ b/drivers/spi/spi-ep93xx.c
@@ -651,7 +651,6 @@ static int ep93xx_spi_probe(struct platform_device *pdev)
 	struct resource *res;
 	int irq;
 	int error;
-	int i;
 
 	info = dev_get_platdata(&pdev->dev);
 	if (!info) {
-- 
2.20.1

