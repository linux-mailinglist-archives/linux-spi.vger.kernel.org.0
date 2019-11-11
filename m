Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 713B0F8076
	for <lists+linux-spi@lfdr.de>; Mon, 11 Nov 2019 20:49:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbfKKTtO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 11 Nov 2019 14:49:14 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50496 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727080AbfKKTtN (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 11 Nov 2019 14:49:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=84REvcwjrpVztiWS0w7fns355oyY2epT8nBgVsXKgpw=; b=kEFIHQp4fA0u
        Mdn9IbceTH6wxHJhAly7ch5YFvZS/zqIXMMkhZsX2nS+gp/N+9o0tBluJ4+/kiSV/Iylsz1R01h6G
        FgTJlqqdIyiEmUXWFZRSDffsRQaT5/IjpUVxqF5usptC0aWMgA63+ktJpWup7My6IvUy1Wrb/uV40
        OrRTg=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iUFgT-0005Ne-3Z; Mon, 11 Nov 2019 19:49:09 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 9E5AD27429EB; Mon, 11 Nov 2019 19:49:08 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     "Cc:"@sirena.co.uk, "Cc:"@sirena.co.uk,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Applied "spi: pxa2xx: Add missed security checks" to the spi tree
In-Reply-To: <20191109080943.30428-1-hslester96@gmail.com>
X-Patchwork-Hint: ignore
Message-Id: <20191111194908.9E5AD27429EB@ypsilon.sirena.org.uk>
Date:   Mon, 11 Nov 2019 19:49:08 +0000 (GMT)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: pxa2xx: Add missed security checks

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

From 5eb263ef08b5014cfc2539a838f39d2fd3531423 Mon Sep 17 00:00:00 2001
From: Chuhong Yuan <hslester96@gmail.com>
Date: Sat, 9 Nov 2019 16:09:43 +0800
Subject: [PATCH] spi: pxa2xx: Add missed security checks

pxa2xx_spi_init_pdata misses checks for devm_clk_get and
platform_get_irq.
Add checks for them to fix the bugs.

Since ssp->clk and ssp->irq are used in probe, they are mandatory here.
So we cannot use _optional() for devm_clk_get and platform_get_irq.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
Link: https://lore.kernel.org/r/20191109080943.30428-1-hslester96@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-pxa2xx.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 6eb6805ee51d..9bc710c1b9e5 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1557,7 +1557,13 @@ pxa2xx_spi_init_pdata(struct platform_device *pdev)
 #endif
 
 	ssp->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(ssp->clk))
+		return NULL;
+
 	ssp->irq = platform_get_irq(pdev, 0);
+	if (ssp->irq < 0)
+		return NULL;
+
 	ssp->type = type;
 	ssp->dev = &pdev->dev;
 	ssp->port_id = pxa2xx_spi_get_port_id(&pdev->dev);
-- 
2.20.1

