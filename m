Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C67F2DCD6D
	for <lists+linux-spi@lfdr.de>; Fri, 18 Oct 2019 20:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505762AbfJRSHQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 18 Oct 2019 14:07:16 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:45246 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2505742AbfJRSHP (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 18 Oct 2019 14:07:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=AGAwWMLdnTUc73N8GjjYlBFIh97VvTrIorQi++WDot4=; b=kyNF0xTukb5y
        rG6LDOhEQVhcwvY+3/JlEyVL+1tQz0mRh/ggp8a09UlahTU16pHIPdoBDYBNzMg3OinTI8NpdSVsM
        nJaXkv2qDu+UemIdalaGe7t9D8JXffvOoXZSbLBewUHo9h3hpfQF8FOz5z5wFpwKQIthWyEIclltZ
        irDpc=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iLWec-0004Hc-01; Fri, 18 Oct 2019 18:07:10 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 7A1482741DEA; Fri, 18 Oct 2019 19:07:09 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Applied "spi: pxa2xx: Convert to use device_get_match_data()" to the spi tree
In-Reply-To: <20191018105429.82782-4-andriy.shevchenko@linux.intel.com>
X-Patchwork-Hint: ignore
Message-Id: <20191018180709.7A1482741DEA@ypsilon.sirena.org.uk>
Date:   Fri, 18 Oct 2019 19:07:09 +0100 (BST)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: pxa2xx: Convert to use device_get_match_data()

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

From f2faa3ec79ac11db8c26b10f8c978d4d0f7392dd Mon Sep 17 00:00:00 2001
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Fri, 18 Oct 2019 13:54:28 +0300
Subject: [PATCH] spi: pxa2xx: Convert to use device_get_match_data()

Convert to use device_get_match_data() instead of open coded variant.

While here, switch of_property_read_bool() to device_property_read_bool().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://lore.kernel.org/r/20191018105429.82782-4-andriy.shevchenko@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-pxa2xx.c | 26 +++++++-------------------
 1 file changed, 7 insertions(+), 19 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 04ca80770e35..684a5585ac7f 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -22,6 +22,7 @@
 #include <linux/pci.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/property.h>
 #include <linux/slab.h>
 #include <linux/spi/pxa2xx_spi.h>
 #include <linux/spi/spi.h>
@@ -1512,34 +1513,21 @@ static struct pxa2xx_spi_controller *
 pxa2xx_spi_init_pdata(struct platform_device *pdev)
 {
 	struct pxa2xx_spi_controller *pdata;
-	struct acpi_device *adev;
 	struct ssp_device *ssp;
 	struct resource *res;
-	const struct acpi_device_id *adev_id = NULL;
 	const struct pci_device_id *pcidev_id = NULL;
-	const struct of_device_id *of_id = NULL;
 	enum pxa_ssp_type type;
+	const void *match;
 
-	adev = ACPI_COMPANION(&pdev->dev);
-
-	if (pdev->dev.of_node)
-		of_id = of_match_device(pdev->dev.driver->of_match_table,
-					&pdev->dev);
-	else if (dev_is_pci(pdev->dev.parent))
+	if (dev_is_pci(pdev->dev.parent))
 		pcidev_id = pci_match_id(pxa2xx_spi_pci_compound_match,
 					 to_pci_dev(pdev->dev.parent));
-	else if (adev)
-		adev_id = acpi_match_device(pdev->dev.driver->acpi_match_table,
-					    &pdev->dev);
-	else
-		return NULL;
 
-	if (adev_id)
-		type = (enum pxa_ssp_type)adev_id->driver_data;
+	match = device_get_match_data(&pdev->dev);
+	if (match)
+		type = (enum pxa_ssp_type)match;
 	else if (pcidev_id)
 		type = (enum pxa_ssp_type)pcidev_id->driver_data;
-	else if (of_id)
-		type = (enum pxa_ssp_type)of_id->data;
 	else
 		return NULL;
 
@@ -1572,7 +1560,7 @@ pxa2xx_spi_init_pdata(struct platform_device *pdev)
 	ssp->dev = &pdev->dev;
 	ssp->port_id = pxa2xx_spi_get_port_id(&pdev->dev);
 
-	pdata->is_slave = of_property_read_bool(pdev->dev.of_node, "spi-slave");
+	pdata->is_slave = device_property_read_bool(&pdev->dev, "spi-slave");
 	pdata->num_chipselect = 1;
 	pdata->enable_dma = true;
 	pdata->dma_burst_size = 1;
-- 
2.20.1

