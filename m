Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6586EC3310
	for <lists+linux-spi@lfdr.de>; Tue,  1 Oct 2019 13:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387762AbfJALlz (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 1 Oct 2019 07:41:55 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:41208 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387636AbfJALlM (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 1 Oct 2019 07:41:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=yaTBvOc4ub9EBgFT0t4N5VA/W6AvqgGon1ddgd0Obko=; b=asOmVkcdJioS
        gwHRains2VilIGctACLH36Kwc3Q+tnLzkeg5IUKwlCN2sYyF9wwtqNX0lbrEiqDhI2loS/KSvxxYG
        2nZdX2IfAvhp+m4CW/p3IClasB4s/BSSrYEVlujiYCGrPGsszbSrwMV5Jm8qdBagCN/+pd7DcBNMo
        HcYhU=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iFGWg-0004Yo-Vi; Tue, 01 Oct 2019 11:41:07 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 6CD7D2742A30; Tue,  1 Oct 2019 12:41:06 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Markus Elfring <elfring@users.sourceforge.net>
Cc:     Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        kernel-janitors@vger.kernel.org, linux-spi@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>
Subject: Applied "spi: lantiq-ssc: Use devm_platform_ioremap_resource() in lantiq_ssc_probe()" to the spi tree
In-Reply-To: <230495a7-b754-bc6a-05e0-059a6b6c643d@web.de>
X-Patchwork-Hint: ignore
Message-Id: <20191001114106.6CD7D2742A30@ypsilon.sirena.org.uk>
Date:   Tue,  1 Oct 2019 12:41:06 +0100 (BST)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: lantiq-ssc: Use devm_platform_ioremap_resource() in lantiq_ssc_probe()

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

From 22262695f46b68659ba98a12e275df388c74968c Mon Sep 17 00:00:00 2001
From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 21 Sep 2019 14:16:49 +0200
Subject: [PATCH] spi: lantiq-ssc: Use devm_platform_ioremap_resource() in
 lantiq_ssc_probe()

Simplify this function implementation by using a known wrapper function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
Link: https://lore.kernel.org/r/230495a7-b754-bc6a-05e0-059a6b6c643d@web.de
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-lantiq-ssc.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/spi/spi-lantiq-ssc.c b/drivers/spi/spi-lantiq-ssc.c
index 9dfe8b04e688..1fd7ee53d451 100644
--- a/drivers/spi/spi-lantiq-ssc.c
+++ b/drivers/spi/spi-lantiq-ssc.c
@@ -797,7 +797,6 @@ static int lantiq_ssc_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct spi_master *master;
-	struct resource *res;
 	struct lantiq_ssc_spi *spi;
 	const struct lantiq_ssc_hwcfg *hwcfg;
 	const struct of_device_id *match;
@@ -812,12 +811,6 @@ static int lantiq_ssc_probe(struct platform_device *pdev)
 	}
 	hwcfg = match->data;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		dev_err(dev, "failed to get resources\n");
-		return -ENXIO;
-	}
-
 	rx_irq = platform_get_irq_byname(pdev, LTQ_SPI_RX_IRQ_NAME);
 	if (rx_irq < 0)
 		return -ENXIO;
@@ -839,8 +832,7 @@ static int lantiq_ssc_probe(struct platform_device *pdev)
 	spi->dev = dev;
 	spi->hwcfg = hwcfg;
 	platform_set_drvdata(pdev, spi);
-
-	spi->regbase = devm_ioremap_resource(dev, res);
+	spi->regbase = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(spi->regbase)) {
 		err = PTR_ERR(spi->regbase);
 		goto err_master_put;
-- 
2.20.1

