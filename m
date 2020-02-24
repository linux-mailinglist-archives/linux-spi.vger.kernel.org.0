Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 296D716B3C8
	for <lists+linux-spi@lfdr.de>; Mon, 24 Feb 2020 23:22:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbgBXWWZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 24 Feb 2020 17:22:25 -0500
Received: from foss.arm.com ([217.140.110.172]:43572 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727219AbgBXWWZ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 24 Feb 2020 17:22:25 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BAE0930E;
        Mon, 24 Feb 2020 14:22:24 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 404503F534;
        Mon, 24 Feb 2020 14:22:24 -0800 (PST)
Date:   Mon, 24 Feb 2020 22:22:22 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Applied "spi: pxa2xx: drv_data can't be NULL in ->remove()" to the spi tree
In-Reply-To:  <20200224154556.11627-2-andriy.shevchenko@linux.intel.com>
Message-Id:  <applied-20200224154556.11627-2-andriy.shevchenko@linux.intel.com>
X-Patchwork-Hint: ignore
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: pxa2xx: drv_data can't be NULL in ->remove()

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

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

From 3d24b2a470466aa901ba8354468fc1899259fd84 Mon Sep 17 00:00:00 2001
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Mon, 24 Feb 2020 17:45:56 +0200
Subject: [PATCH] spi: pxa2xx: drv_data can't be NULL in ->remove()

There is no need for drv_data check against NULL, since it won't happen.
Remove useless check.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://lore.kernel.org/r/20200224154556.11627-2-andriy.shevchenko@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-pxa2xx.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 934bfe2c8a90..8e8e18023ded 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1884,11 +1884,7 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 static int pxa2xx_spi_remove(struct platform_device *pdev)
 {
 	struct driver_data *drv_data = platform_get_drvdata(pdev);
-	struct ssp_device *ssp;
-
-	if (!drv_data)
-		return 0;
-	ssp = drv_data->ssp;
+	struct ssp_device *ssp = drv_data->ssp;
 
 	pm_runtime_get_sync(&pdev->dev);
 
-- 
2.20.1

