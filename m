Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D19DA44C4F2
	for <lists+linux-spi@lfdr.de>; Wed, 10 Nov 2021 17:18:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbhKJQUt (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 10 Nov 2021 11:20:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbhKJQUt (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 10 Nov 2021 11:20:49 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FD72C061766;
        Wed, 10 Nov 2021 08:18:01 -0800 (PST)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 9528C2223B;
        Wed, 10 Nov 2021 17:17:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1636561079;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=0KbCSSyNH49aqIdsyW4o+8LNdBhhF/Lc7J+N2qqCuVQ=;
        b=r7cjE2qCyfTrJTGykqrs1pw8KXFBxj+BqRl/SQsnRXwIGBwFgM6hv0tbHV9V3hVuyc27g9
        Q5gBOBz1p4CADCjv9QmV3Ld8ch+dH75IQnbFZh0ehyA2hVcKdBAEUVLjvYwViboqL2ckwc
        c5vJ+F4w3T3ULsxOt724UnfsgPTzgCM=
From:   Michael Walle <michael@walle.cc>
To:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        Vladimir Oltean <olteanv@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH] spi: fsl-dspi: use devm_spi_alloc_master()
Date:   Wed, 10 Nov 2021 17:17:54 +0100
Message-Id: <20211110161754.3312805-1-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Commit 530b5affc675 ("spi: fsl-dspi: fix use-after-free in remove path")
fixed the use-after-free by manually allocating memory. Nowadays, since
commit 5e844cc37a5c ("spi: Introduce device-managed SPI controller
allocation"), there is a devres version of spi_alloc_master() for exactly
this purpose. Revert the commit which introduced the manual allocation
and use the new devm_spi_alloc_master().

Signed-off-by: Michael Walle <michael@walle.cc>
---
Btw, using the devm_ version of spi_controller_register() doesn't seem to
be a good idea, see commit 8d559a64f00b ("spi: stm32: drop devres version
of spi_register_master").

 drivers/spi/spi-fsl-dspi.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index fd004c9db9dc..29f8a596c8ee 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -1227,17 +1227,11 @@ static int dspi_probe(struct platform_device *pdev)
 	void __iomem *base;
 	bool big_endian;
 
-	dspi = devm_kzalloc(&pdev->dev, sizeof(*dspi), GFP_KERNEL);
-	if (!dspi)
-		return -ENOMEM;
-
-	ctlr = spi_alloc_master(&pdev->dev, 0);
+	ctlr = devm_spi_alloc_master(&pdev->dev, sizeof(struct fsl_dspi));
 	if (!ctlr)
 		return -ENOMEM;
 
-	spi_controller_set_devdata(ctlr, dspi);
-	platform_set_drvdata(pdev, dspi);
-
+	dspi = spi_controller_get_devdata(ctlr);
 	dspi->pdev = pdev;
 	dspi->ctlr = ctlr;
 
@@ -1373,6 +1367,8 @@ static int dspi_probe(struct platform_device *pdev)
 	if (dspi->devtype_data->trans_mode != DSPI_DMA_MODE)
 		ctlr->ptp_sts_supported = true;
 
+	platform_set_drvdata(pdev, ctlr);
+
 	ret = spi_register_controller(ctlr);
 	if (ret != 0) {
 		dev_err(&pdev->dev, "Problem registering DSPI ctlr\n");
@@ -1396,7 +1392,8 @@ static int dspi_probe(struct platform_device *pdev)
 
 static int dspi_remove(struct platform_device *pdev)
 {
-	struct fsl_dspi *dspi = platform_get_drvdata(pdev);
+	struct spi_controller *ctlr = platform_get_drvdata(pdev);
+	struct fsl_dspi *dspi = spi_controller_get_devdata(ctlr);
 
 	/* Disconnect from the SPI framework */
 	spi_unregister_controller(dspi->ctlr);
-- 
2.30.2

