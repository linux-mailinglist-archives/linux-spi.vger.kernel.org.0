Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55283F1B13
	for <lists+linux-spi@lfdr.de>; Wed,  6 Nov 2019 17:22:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732138AbfKFQWB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 6 Nov 2019 11:22:01 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:53442 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728462AbfKFQWB (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 6 Nov 2019 11:22:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=CGgaROaaaA1kcCTZbTkbd3PjQEAz1ZDGj0CbBNL/ZKE=; b=n8mwbBIFPWIV
        IOq+5KYrZVB8Jg7g8chQYCTOfBw/rr6xRDmiMJlW9868HE3dxkM0wSA85ils4VPrZq3V02tFU5qPW
        k7OqyYTYD750lvWwmNUjcAwJv0bqMfcfYK1pfuHtyJHNLONR/PUDegQ5KcT0QlHt2lRInvJFfS0vg
        y/pF8=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iSO4C-0001pP-Rb; Wed, 06 Nov 2019 16:21:56 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 5B0D82743035; Wed,  6 Nov 2019 16:21:56 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Pan Bian <bianpan2016@163.com>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: Applied "spi: img-spfi: fix potential double release" to the spi tree
In-Reply-To: <1573007769-20131-1-git-send-email-bianpan2016@163.com>
X-Patchwork-Hint: ignore
Message-Id: <20191106162156.5B0D82743035@ypsilon.sirena.org.uk>
Date:   Wed,  6 Nov 2019 16:21:56 +0000 (GMT)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: img-spfi: fix potential double release

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.5

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

From e9a8ba9769a0e354341bc6cc01b98aadcea1dfe9 Mon Sep 17 00:00:00 2001
From: Pan Bian <bianpan2016@163.com>
Date: Wed, 6 Nov 2019 10:36:09 +0800
Subject: [PATCH] spi: img-spfi: fix potential double release

The channels spfi->tx_ch and spfi->rx_ch are not set to NULL after they
are released. As a result, they will be released again, either on the
error handling branch in the same function or in the corresponding
remove function, i.e. img_spfi_remove(). This patch fixes the bug by
setting the two members to NULL.

Signed-off-by: Pan Bian <bianpan2016@163.com>
Link: https://lore.kernel.org/r/1573007769-20131-1-git-send-email-bianpan2016@163.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-img-spfi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-img-spfi.c b/drivers/spi/spi-img-spfi.c
index 439b01e4a2c8..f4a8f470aecc 100644
--- a/drivers/spi/spi-img-spfi.c
+++ b/drivers/spi/spi-img-spfi.c
@@ -673,6 +673,8 @@ static int img_spfi_probe(struct platform_device *pdev)
 			dma_release_channel(spfi->tx_ch);
 		if (spfi->rx_ch)
 			dma_release_channel(spfi->rx_ch);
+		spfi->tx_ch = NULL;
+		spfi->rx_ch = NULL;
 		dev_warn(spfi->dev, "Failed to get DMA channels, falling back to PIO mode\n");
 	} else {
 		master->dma_tx = spfi->tx_ch;
-- 
2.20.1

