Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5776B16B3C9
	for <lists+linux-spi@lfdr.de>; Mon, 24 Feb 2020 23:22:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbgBXWWa (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 24 Feb 2020 17:22:30 -0500
Received: from foss.arm.com ([217.140.110.172]:43584 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727219AbgBXWW3 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 24 Feb 2020 17:22:29 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2AB2330E;
        Mon, 24 Feb 2020 14:22:29 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A46033F534;
        Mon, 24 Feb 2020 14:22:28 -0800 (PST)
Date:   Mon, 24 Feb 2020 22:22:27 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Applied "spi: pxa2xx: Return error codes from pxa2xx_spi_init_pdata()" to the spi tree
In-Reply-To:  <20200224154556.11627-1-andriy.shevchenko@linux.intel.com>
Message-Id:  <applied-20200224154556.11627-1-andriy.shevchenko@linux.intel.com>
X-Patchwork-Hint: ignore
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: pxa2xx: Return error codes from pxa2xx_spi_init_pdata()

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

From 14af1df3b03309f6204661e12c40cdf71bc8f773 Mon Sep 17 00:00:00 2001
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Mon, 24 Feb 2020 17:45:55 +0200
Subject: [PATCH] spi: pxa2xx: Return error codes from pxa2xx_spi_init_pdata()

For better understanding what's going on on error path,
return distinguished error codes instead of NULL pointer.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://lore.kernel.org/r/20200224154556.11627-1-andriy.shevchenko@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-pxa2xx.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 4c7a71f0fb3e..934bfe2c8a90 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1548,18 +1548,18 @@ pxa2xx_spi_init_pdata(struct platform_device *pdev)
 	else if (pcidev_id)
 		type = (enum pxa_ssp_type)pcidev_id->driver_data;
 	else
-		return NULL;
+		return ERR_PTR(-EINVAL);
 
 	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
 	if (!pdata)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	ssp = &pdata->ssp;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	ssp->mmio_base = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(ssp->mmio_base))
-		return NULL;
+		return ERR_CAST(ssp->mmio_base);
 
 	ssp->phys_base = res->start;
 
@@ -1573,11 +1573,11 @@ pxa2xx_spi_init_pdata(struct platform_device *pdev)
 
 	ssp->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(ssp->clk))
-		return NULL;
+		return ERR_CAST(ssp->clk);
 
 	ssp->irq = platform_get_irq(pdev, 0);
 	if (ssp->irq < 0)
-		return NULL;
+		return ERR_PTR(ssp->irq);
 
 	ssp->type = type;
 	ssp->dev = &pdev->dev;
@@ -1634,9 +1634,9 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 	platform_info = dev_get_platdata(dev);
 	if (!platform_info) {
 		platform_info = pxa2xx_spi_init_pdata(pdev);
-		if (!platform_info) {
+		if (IS_ERR(platform_info)) {
 			dev_err(&pdev->dev, "missing platform data\n");
-			return -ENODEV;
+			return PTR_ERR(platform_info);
 		}
 	}
 
-- 
2.20.1

