Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68173E4840
	for <lists+linux-spi@lfdr.de>; Fri, 25 Oct 2019 12:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409013AbfJYKMY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 25 Oct 2019 06:12:24 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37734 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409087AbfJYKMX (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 25 Oct 2019 06:12:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=FCyaW1h6YmYfLVUrS2i2UstE8axQ1ggqDbIlUuO3a8w=; b=UDCFhcfEyPZw
        AnRsfjDN2F0VIkH41SmS/d2YpiXasbdDvygscSgjHvB6uJeKtUZWnOLDj0vEnEPdJzSwocZgAMwMo
        VWcX8xsmmjwUvkEmPd+Wwob8EpWgF7oJtEWTh1hPn942TO+D6pufilT04iDrYHLxK3zJocu8E35Yr
        Hlve0=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iNwZv-0006fG-CT; Fri, 25 Oct 2019 10:12:19 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id D8076274326E; Fri, 25 Oct 2019 11:12:18 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Applied "spi: pxa2xx: Introduce temporary variables to increase readability" to the spi tree
In-Reply-To: <20191021103625.4250-1-andriy.shevchenko@linux.intel.com>
X-Patchwork-Hint: ignore
Message-Id: <20191025101218.D8076274326E@ypsilon.sirena.org.uk>
Date:   Fri, 25 Oct 2019 11:12:18 +0100 (BST)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: pxa2xx: Introduce temporary variables to increase readability

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

From 6fb7427d84f6ed064776434436485cfb0f6711e9 Mon Sep 17 00:00:00 2001
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Mon, 21 Oct 2019 13:36:24 +0300
Subject: [PATCH] spi: pxa2xx: Introduce temporary variables to increase
 readability

The current conditional for PCI ID matching is hard to read.
Introduce couple of temporary variables to increase readability
of the code.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://lore.kernel.org/r/20191021103625.4250-1-andriy.shevchenko@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-pxa2xx.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 443c1f4d2a9a..6eb6805ee51d 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1516,13 +1516,14 @@ pxa2xx_spi_init_pdata(struct platform_device *pdev)
 	struct pxa2xx_spi_controller *pdata;
 	struct ssp_device *ssp;
 	struct resource *res;
+	struct device *parent = pdev->dev.parent;
+	struct pci_dev *pcidev = dev_is_pci(parent) ? to_pci_dev(parent) : NULL;
 	const struct pci_device_id *pcidev_id = NULL;
 	enum pxa_ssp_type type;
 	const void *match;
 
-	if (dev_is_pci(pdev->dev.parent))
-		pcidev_id = pci_match_id(pxa2xx_spi_pci_compound_match,
-					 to_pci_dev(pdev->dev.parent));
+	if (pcidev)
+		pcidev_id = pci_match_id(pxa2xx_spi_pci_compound_match, pcidev);
 
 	match = device_get_match_data(&pdev->dev);
 	if (match)
@@ -1549,8 +1550,8 @@ pxa2xx_spi_init_pdata(struct platform_device *pdev)
 
 #ifdef CONFIG_PCI
 	if (pcidev_id) {
-		pdata->tx_param = pdev->dev.parent;
-		pdata->rx_param = pdev->dev.parent;
+		pdata->tx_param = parent;
+		pdata->rx_param = parent;
 		pdata->dma_filter = pxa2xx_spi_idma_filter;
 	}
 #endif
-- 
2.20.1

