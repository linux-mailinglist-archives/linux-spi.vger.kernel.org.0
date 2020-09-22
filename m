Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F72C273E99
	for <lists+linux-spi@lfdr.de>; Tue, 22 Sep 2020 11:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgIVJdE (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 22 Sep 2020 05:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbgIVJdE (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 22 Sep 2020 05:33:04 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 831F5C061755
        for <linux-spi@vger.kernel.org>; Tue, 22 Sep 2020 02:33:04 -0700 (PDT)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1kKef0-0004VG-Vg; Tue, 22 Sep 2020 11:32:30 +0200
Received: from sha by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1kKef0-0000WQ-43; Tue, 22 Sep 2020 11:32:30 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     linux-spi@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Vladimir Oltean <olteanv@gmail.com>,
        Daniel Mack <daniel@zonque.org>, kernel@pengutronix.de,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 5/6] spi: pxa2xx: Use devm_spi_register_controller()
Date:   Tue, 22 Sep 2020 11:32:27 +0200
Message-Id: <20200922093228.24917-6-s.hauer@pengutronix.de>
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
later in pxa2xx_spi_remove() is a use-after-free bug. Register the
controller with devm_spi_register_controller() instead which makes
calling spi_unregister_controller() unnecessary.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/spi/spi-pxa2xx.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 814268405ab0..858b9b925024 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1892,7 +1892,7 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 
 	/* Register with the SPI framework */
 	platform_set_drvdata(pdev, drv_data);
-	status = spi_register_controller(controller);
+	status = devm_spi_register_controller(&pdev->dev, controller);
 	if (status != 0) {
 		dev_err(&pdev->dev, "problem registering spi controller\n");
 		goto out_error_pm_runtime_enabled;
@@ -1923,8 +1923,6 @@ static int pxa2xx_spi_remove(struct platform_device *pdev)
 
 	pm_runtime_get_sync(&pdev->dev);
 
-	spi_unregister_controller(drv_data->controller);
-
 	/* Disable the SSP at the peripheral and SOC level */
 	pxa2xx_spi_write(drv_data, SSCR0, 0);
 	clk_disable_unprepare(ssp->clk);
-- 
2.28.0

