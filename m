Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6276FF70
	for <lists+linux-spi@lfdr.de>; Mon, 22 Jul 2019 14:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730314AbfGVMW1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 22 Jul 2019 08:22:27 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:58918 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730247AbfGVMW0 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 22 Jul 2019 08:22:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=Wf3sAjChT9m/uM9BHvcggbNSqxCZl3youGE1GneacGk=; b=cbFraVBMUdBI
        bg+WL7bX8Vr0bHaZ3rtqNuMYlV+b2m2v05gPL61MSzY887yPFnPE6wtcfv6JdCjnlO0G/NY+DeeJh
        ukicigXskVpFi7S/nFo7i60Gz9L7h79A9zit+5HiDBbaB4IgrzyyBGe3N1n183KEazTDQiOYu+2ly
        bap6E=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hpXKf-0007gc-EG; Mon, 22 Jul 2019 12:22:21 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id D2B912740463; Mon, 22 Jul 2019 13:22:20 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Phil Edworthy <phil.edworthy@renesas.com>
Subject: Applied "spi: dw-mmio: Clock should be shut when error occurs" to the spi tree
In-Reply-To: <20190710114243.30101-1-andriy.shevchenko@linux.intel.com>
X-Patchwork-Hint: ignore
Message-Id: <20190722122220.D2B912740463@ypsilon.sirena.org.uk>
Date:   Mon, 22 Jul 2019 13:22:20 +0100 (BST)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: dw-mmio: Clock should be shut when error occurs

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

From 3da9834d9381dd99273f2ad4e6d096c9187dc4f2 Mon Sep 17 00:00:00 2001
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Wed, 10 Jul 2019 14:42:43 +0300
Subject: [PATCH] spi: dw-mmio: Clock should be shut when error occurs

When optional clock requesting fails, the main clock is still up and running,
we should shut it down in such caee.

Fixes: 560ee7e91009 ("spi: dw: Add support for an optional interface clock")
Cc: Phil Edworthy <phil.edworthy@renesas.com>
Cc: Gareth Williams <gareth.williams.jx@renesas.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Gareth Williams <gareth.williams.jx@renesas.com>
Link: https://lore.kernel.org/r/20190710114243.30101-1-andriy.shevchenko@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-dw-mmio.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
index 1c1cac92a9de..4fa7e7a52ebd 100644
--- a/drivers/spi/spi-dw-mmio.c
+++ b/drivers/spi/spi-dw-mmio.c
@@ -170,8 +170,10 @@ static int dw_spi_mmio_probe(struct platform_device *pdev)
 
 	/* Optional clock needed to access the registers */
 	dwsmmio->pclk = devm_clk_get_optional(&pdev->dev, "pclk");
-	if (IS_ERR(dwsmmio->pclk))
-		return PTR_ERR(dwsmmio->pclk);
+	if (IS_ERR(dwsmmio->pclk)) {
+		ret = PTR_ERR(dwsmmio->pclk);
+		goto out_clk;
+	}
 	ret = clk_prepare_enable(dwsmmio->pclk);
 	if (ret)
 		goto out_clk;
-- 
2.20.1

