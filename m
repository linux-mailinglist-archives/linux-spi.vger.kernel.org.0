Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7B026FF75
	for <lists+linux-spi@lfdr.de>; Mon, 22 Jul 2019 14:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729059AbfGVMWl (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 22 Jul 2019 08:22:41 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:58882 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730297AbfGVMWZ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 22 Jul 2019 08:22:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=rbq4z9FIHUxfRqS1kr/ag+iCawHd1ro5ob0Hwbc6bws=; b=no7LZiAil3YZ
        1Wm0MIGdBM2BW72hSwNthuJRdgDI5UH63s6uX/jCq9o0lnZp6Gm8qp4RExJgQfcYIR2YmgJOIZRel
        BM6rxu9N5Lt44jqWgWwwH2k4eEMzKqWVrH4A2S5i3fMgDcbHdlHvuFZFWy9DXGkDkmvMKfUsywn3J
        TA24I=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hpXKf-0007ge-Sq; Mon, 22 Jul 2019 12:22:21 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 4CCCE27416CB; Mon, 22 Jul 2019 13:22:21 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Applied "spi: pxa2xx: Balance runtime PM enable/disable on error" to the spi tree
In-Reply-To: <20190719122713.3444318-1-lkundrak@v3.sk>
X-Patchwork-Hint: ignore
Message-Id: <20190722122221.4CCCE27416CB@ypsilon.sirena.org.uk>
Date:   Mon, 22 Jul 2019 13:22:21 +0100 (BST)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: pxa2xx: Balance runtime PM enable/disable on error

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

From 1274204542f683e1d8491ebe9cc86284d5a8ebcc Mon Sep 17 00:00:00 2001
From: Lubomir Rintel <lkundrak@v3.sk>
Date: Fri, 19 Jul 2019 14:27:13 +0200
Subject: [PATCH] spi: pxa2xx: Balance runtime PM enable/disable on error

Don't undo the PM initialization if we error out before we managed to
initialize it. The call to pm_runtime_disable() without being preceded
by pm_runtime_enable() would disturb the balance of the Force.

In practice, this happens if we fail to allocate any of the GPIOS ("cs",
"ready") due to -EPROBE_DEFER because we're getting probled before the
GPIO driver.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Link: https://lore.kernel.org/r/20190719122713.3444318-1-lkundrak@v3.sk
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-pxa2xx.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index fc7ab4b26880..22513caf2000 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1831,14 +1831,16 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 	status = devm_spi_register_controller(&pdev->dev, controller);
 	if (status != 0) {
 		dev_err(&pdev->dev, "problem registering spi controller\n");
-		goto out_error_clock_enabled;
+		goto out_error_pm_runtime_enabled;
 	}
 
 	return status;
 
-out_error_clock_enabled:
+out_error_pm_runtime_enabled:
 	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
+
+out_error_clock_enabled:
 	clk_disable_unprepare(ssp->clk);
 
 out_error_dma_irq_alloc:
-- 
2.20.1

