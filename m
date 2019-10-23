Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51C5CE22D2
	for <lists+linux-spi@lfdr.de>; Wed, 23 Oct 2019 20:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404472AbfJWS4X (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 23 Oct 2019 14:56:23 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:59616 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389598AbfJWS4W (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 23 Oct 2019 14:56:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=Jk714AkzzaO8F+/J4eKn0uyP10QaLAvge3ULNRNlzZc=; b=xmcJZ4/4V1UZ
        T1/5eI8s/uBbldJjFeTW4NayLeew7RBmCCyR67sLf52VKunJ/6Atuv8LEe08v2G+GkJUiR6QEFd2k
        IusIvWE/N0xITZgp9eF4mQuqdTUuSJItvMQZAxLZcSfd6FBBuO49Dk69ywX7Ingx6lQlXozNLw+ve
        3009M=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iNLnt-0001Ci-WB; Wed, 23 Oct 2019 18:56:18 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 770E32743021; Wed, 23 Oct 2019 19:56:17 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Applied "spi: pxa2xx: Drop extra check of platform_get_resource() returned value" to the spi tree
In-Reply-To: <20191021103625.4250-2-andriy.shevchenko@linux.intel.com>
X-Patchwork-Hint: ignore
Message-Id: <20191023185617.770E32743021@ypsilon.sirena.org.uk>
Date:   Wed, 23 Oct 2019 19:56:17 +0100 (BST)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: pxa2xx: Drop extra check of platform_get_resource() returned value

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

From 77c544d243f3b0d1ae3487ebb170c07c79734fe7 Mon Sep 17 00:00:00 2001
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Mon, 21 Oct 2019 13:36:25 +0300
Subject: [PATCH] spi: pxa2xx: Drop extra check of platform_get_resource()
 returned value

The devm_ioremap_resource() has already a check for resource pointer
being NULL. No need to double check this.

Drop extra check of platform_get_resource() returned value.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://lore.kernel.org/r/20191021103625.4250-2-andriy.shevchenko@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-pxa2xx.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 068c21037679..4249bcaf77bd 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1545,17 +1545,15 @@ pxa2xx_spi_init_pdata(struct platform_device *pdev)
 	if (!pdata)
 		return NULL;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res)
-		return NULL;
-
 	ssp = &pdata->ssp;
 
-	ssp->phys_base = res->start;
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	ssp->mmio_base = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(ssp->mmio_base))
 		return NULL;
 
+	ssp->phys_base = res->start;
+
 #ifdef CONFIG_PCI
 	if (pcidev_id) {
 		pdata->tx_param = pdev->dev.parent;
-- 
2.20.1

