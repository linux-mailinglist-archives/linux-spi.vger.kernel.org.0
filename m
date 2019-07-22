Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34C6D6FF6F
	for <lists+linux-spi@lfdr.de>; Mon, 22 Jul 2019 14:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730310AbfGVMW0 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 22 Jul 2019 08:22:26 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:58884 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730299AbfGVMWZ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 22 Jul 2019 08:22:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=IQTPYa+utONSAk9ETNFN4gEE4puO9t3HMi6ZegvvSSg=; b=t7pCBKw/b4yI
        CuIEXY0iE3gGn/bbnIluROklOuSNGKVcHtQy5jwSgb/ExctHLzRKFVV1Ji2v+3aFSIcppZ07vCRq4
        XcWOYiR7x7MCMEg11lQLL4bVROF4RnMNF3O4b018WQsstDuY6qjEtoTbPdLbJRsvpBSv31LxJjHnT
        lH5yg=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hpXKf-0007gd-Ni; Mon, 22 Jul 2019 12:22:21 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 1DDE8274046A; Mon, 22 Jul 2019 13:22:21 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "spi: dw-mmio: Use devm_platform_ioremap_resource()" to the spi tree
In-Reply-To: <20190710114230.30047-1-andriy.shevchenko@linux.intel.com>
X-Patchwork-Hint: ignore
Message-Id: <20190722122221.1DDE8274046A@ypsilon.sirena.org.uk>
Date:   Mon, 22 Jul 2019 13:22:21 +0100 (BST)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: dw-mmio: Use devm_platform_ioremap_resource()

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

From 0521050215d0daae5d84b212fbe9fc16462f58f6 Mon Sep 17 00:00:00 2001
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Wed, 10 Jul 2019 14:42:30 +0300
Subject: [PATCH] spi: dw-mmio: Use devm_platform_ioremap_resource()

Use the new helper that wraps the calls to platform_get_resource()
and devm_ioremap_resource() together.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://lore.kernel.org/r/20190710114230.30047-1-andriy.shevchenko@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-dw-mmio.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
index 18c06568805e..1c1cac92a9de 100644
--- a/drivers/spi/spi-dw-mmio.c
+++ b/drivers/spi/spi-dw-mmio.c
@@ -138,7 +138,6 @@ static int dw_spi_mmio_probe(struct platform_device *pdev)
 			 struct dw_spi_mmio *dwsmmio);
 	struct dw_spi_mmio *dwsmmio;
 	struct dw_spi *dws;
-	struct resource *mem;
 	int ret;
 	int num_cs;
 
@@ -150,8 +149,7 @@ static int dw_spi_mmio_probe(struct platform_device *pdev)
 	dws = &dwsmmio->dws;
 
 	/* Get basic io resource and map it */
-	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	dws->regs = devm_ioremap_resource(&pdev->dev, mem);
+	dws->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(dws->regs)) {
 		dev_err(&pdev->dev, "SPI region map failed\n");
 		return PTR_ERR(dws->regs);
-- 
2.20.1

