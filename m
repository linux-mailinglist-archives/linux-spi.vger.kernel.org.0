Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEDC3275869
	for <lists+linux-spi@lfdr.de>; Wed, 23 Sep 2020 15:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgIWNKf (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 23 Sep 2020 09:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbgIWNKe (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 23 Sep 2020 09:10:34 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B0A3C0613CE
        for <linux-spi@vger.kernel.org>; Wed, 23 Sep 2020 06:10:33 -0700 (PDT)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1kL4XX-0005V1-Q9; Wed, 23 Sep 2020 15:10:31 +0200
Received: from sha by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1kL4XX-0006C8-5Z; Wed, 23 Sep 2020 15:10:31 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     linux-spi@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>,
        Vladimir Oltean <olteanv@gmail.com>, kernel@pengutronix.de,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH] spi: fsl-dspi: fix use-after-free in remove path
Date:   Wed, 23 Sep 2020 15:10:26 +0200
Message-Id: <20200923131026.20707-1-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

spi_unregister_controller() not only unregisters the controller, but
also frees the controller. This will free the driver data with it, so
we must not access it later dspi_remove().

Solve this by allocating the driver data separately from the SPI
controller.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---

This fixes the issue reported at https://marc.info/?l=linux-spi&m=160068648808293&w=2
for the fsl-dspi driver in the way Mark suggested. A whole lot of other SPI drivers
are affected by this issue and need a similar fix. Here is a fix for the driver
I currently care about.

 drivers/spi/spi-fsl-dspi.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 91c6affe139c..aae9f9a7aea6 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -1273,11 +1273,14 @@ static int dspi_probe(struct platform_device *pdev)
 	void __iomem *base;
 	bool big_endian;
 
-	ctlr = spi_alloc_master(&pdev->dev, sizeof(struct fsl_dspi));
+	dspi = devm_kzalloc(&pdev->dev, sizeof(*dspi), GFP_KERNEL);
+	if (!dspi)
+		return -ENOMEM;
+
+	ctlr = spi_alloc_master(&pdev->dev, 0);
 	if (!ctlr)
 		return -ENOMEM;
 
-	dspi = spi_controller_get_devdata(ctlr);
 	dspi->pdev = pdev;
 	dspi->ctlr = ctlr;
 
@@ -1414,7 +1417,7 @@ static int dspi_probe(struct platform_device *pdev)
 	if (dspi->devtype_data->trans_mode != DSPI_DMA_MODE)
 		ctlr->ptp_sts_supported = true;
 
-	platform_set_drvdata(pdev, ctlr);
+	platform_set_drvdata(pdev, dspi);
 
 	ret = spi_register_controller(ctlr);
 	if (ret != 0) {
@@ -1437,8 +1440,7 @@ static int dspi_probe(struct platform_device *pdev)
 
 static int dspi_remove(struct platform_device *pdev)
 {
-	struct spi_controller *ctlr = platform_get_drvdata(pdev);
-	struct fsl_dspi *dspi = spi_controller_get_devdata(ctlr);
+	struct fsl_dspi *dspi = platform_get_drvdata(pdev);
 
 	/* Disconnect from the SPI framework */
 	spi_unregister_controller(dspi->ctlr);
-- 
2.28.0

