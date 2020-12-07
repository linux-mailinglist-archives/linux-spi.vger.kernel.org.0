Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA1852D0BF7
	for <lists+linux-spi@lfdr.de>; Mon,  7 Dec 2020 09:48:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbgLGIrq (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 7 Dec 2020 03:47:46 -0500
Received: from bmailout2.hostsharing.net ([83.223.78.240]:50067 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbgLGIrq (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 7 Dec 2020 03:47:46 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 18FC728010393;
        Mon,  7 Dec 2020 09:46:48 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 11A8910DB; Mon,  7 Dec 2020 09:47:04 +0100 (CET)
Message-Id: <4b05c65cf6f1ea3251484fe9a00b4c65478a1ae3.1607286887.git.lukas@wunner.de>
In-Reply-To: <cover.1607286887.git.lukas@wunner.de>
References: <cover.1607286887.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Mon, 7 Dec 2020 09:17:17 +0100
Subject: [PATCH 17/17] spi: atmel-quadspi: Fix use-after-free on unbind
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org,
        Piotr Bugalski <bugalski.piotr@gmail.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

atmel_qspi_remove() accesses the driver's private data after calling
spi_unregister_controller() even though that function releases the last
reference on the spi_controller and thereby frees the private data.

Fix by switching over to the new devm_spi_alloc_master() helper which
keeps the private data accessible until the driver has unbound.

Fixes: 2d30ac5ed633 ("mtd: spi-nor: atmel-quadspi: Use spi-mem interface for atmel-quadspi driver")
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: <stable@vger.kernel.org> # v5.0+: 5e844cc37a5c: spi: Introduce device-managed SPI controller allocation
Cc: <stable@vger.kernel.org> # v5.0+
Cc: Piotr Bugalski <bugalski.piotr@gmail.com>
---
 drivers/spi/atmel-quadspi.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index b44521d4a245..1742ccc1ad0e 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -535,7 +535,7 @@ static int atmel_qspi_probe(struct platform_device *pdev)
 	struct resource *res;
 	int irq, err = 0;
 
-	ctrl = spi_alloc_master(&pdev->dev, sizeof(*aq));
+	ctrl = devm_spi_alloc_master(&pdev->dev, sizeof(*aq));
 	if (!ctrl)
 		return -ENOMEM;
 
@@ -557,8 +557,7 @@ static int atmel_qspi_probe(struct platform_device *pdev)
 	aq->regs = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(aq->regs)) {
 		dev_err(&pdev->dev, "missing registers\n");
-		err = PTR_ERR(aq->regs);
-		goto exit;
+		return PTR_ERR(aq->regs);
 	}
 
 	/* Map the AHB memory */
@@ -566,8 +565,7 @@ static int atmel_qspi_probe(struct platform_device *pdev)
 	aq->mem = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(aq->mem)) {
 		dev_err(&pdev->dev, "missing AHB memory\n");
-		err = PTR_ERR(aq->mem);
-		goto exit;
+		return PTR_ERR(aq->mem);
 	}
 
 	aq->mmap_size = resource_size(res);
@@ -579,15 +577,14 @@ static int atmel_qspi_probe(struct platform_device *pdev)
 
 	if (IS_ERR(aq->pclk)) {
 		dev_err(&pdev->dev, "missing peripheral clock\n");
-		err = PTR_ERR(aq->pclk);
-		goto exit;
+		return PTR_ERR(aq->pclk);
 	}
 
 	/* Enable the peripheral clock */
 	err = clk_prepare_enable(aq->pclk);
 	if (err) {
 		dev_err(&pdev->dev, "failed to enable the peripheral clock\n");
-		goto exit;
+		return err;
 	}
 
 	aq->caps = of_device_get_match_data(&pdev->dev);
@@ -638,8 +635,6 @@ static int atmel_qspi_probe(struct platform_device *pdev)
 	clk_disable_unprepare(aq->qspick);
 disable_pclk:
 	clk_disable_unprepare(aq->pclk);
-exit:
-	spi_controller_put(ctrl);
 
 	return err;
 }
-- 
2.29.2

