Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1555B273E95
	for <lists+linux-spi@lfdr.de>; Tue, 22 Sep 2020 11:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbgIVJck (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 22 Sep 2020 05:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbgIVJck (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 22 Sep 2020 05:32:40 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A0B6C0613CF
        for <linux-spi@vger.kernel.org>; Tue, 22 Sep 2020 02:32:40 -0700 (PDT)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1kKef0-0004VC-Vc; Tue, 22 Sep 2020 11:32:30 +0200
Received: from sha by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1kKef0-0000WD-21; Tue, 22 Sep 2020 11:32:30 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     linux-spi@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Vladimir Oltean <olteanv@gmail.com>,
        Daniel Mack <daniel@zonque.org>, kernel@pengutronix.de,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 1/6] spi: fsl-dspi: Use devm_spi_register_controller()
Date:   Tue, 22 Sep 2020 11:32:23 +0200
Message-Id: <20200922093228.24917-2-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200922093228.24917-1-s.hauer@pengutronix.de>
References: <20200922093228.24917-1-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Calling spi_unregister_controller() during driver remove results in
freeing the SPI controller and the associated driver data. Using it
later in dspi_remove() is a use-after-free bug. Register the controller
with devm_spi_register_controller() instead which makes calling
spi_unregister_controller() unnecessary.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/spi/spi-fsl-dspi.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 91c6affe139c..a6c100b89360 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -1416,7 +1416,7 @@ static int dspi_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, ctlr);
 
-	ret = spi_register_controller(ctlr);
+	ret = devm_spi_register_controller(&pdev->dev, ctlr);
 	if (ret != 0) {
 		dev_err(&pdev->dev, "Problem registering DSPI ctlr\n");
 		goto out_free_irq;
@@ -1440,9 +1440,6 @@ static int dspi_remove(struct platform_device *pdev)
 	struct spi_controller *ctlr = platform_get_drvdata(pdev);
 	struct fsl_dspi *dspi = spi_controller_get_devdata(ctlr);
 
-	/* Disconnect from the SPI framework */
-	spi_unregister_controller(dspi->ctlr);
-
 	/* Disable RX and TX */
 	regmap_update_bits(dspi->regmap, SPI_MCR,
 			   SPI_MCR_DIS_TXF | SPI_MCR_DIS_RXF,
-- 
2.28.0

