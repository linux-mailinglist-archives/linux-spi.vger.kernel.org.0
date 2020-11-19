Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15F4C2B9790
	for <lists+linux-spi@lfdr.de>; Thu, 19 Nov 2020 17:17:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728187AbgKSQQP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 19 Nov 2020 11:16:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727741AbgKSQQO (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 19 Nov 2020 11:16:14 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D787EC0613CF
        for <linux-spi@vger.kernel.org>; Thu, 19 Nov 2020 08:16:12 -0800 (PST)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kfmbT-0004Lb-Eh; Thu, 19 Nov 2020 17:16:11 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1kfmbT-0003p4-32; Thu, 19 Nov 2020 17:16:11 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 1/3] spi: fix resource leak for drivers without .remove callback
Date:   Thu, 19 Nov 2020 17:16:02 +0100
Message-Id: <20201119161604.2633521-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Consider an spi driver with a .probe but without a .remove callback (e.g.
rtc-ds1347). The function spi_drv_probe() is called to bind a device and
so dev_pm_domain_attach() is called. As there is no remove callback
spi_drv_remove() isn't called at unbind time however and so calling
dev_pm_domain_detach() is missed and the pm domain keeps active.

To fix this always use both spi_drv_probe() and spi_drv_remove() and
make them handle the respective callback not being set. This has the
side effect that for a (hypothetical) driver that has neither .probe nor
remove the clk and pm domain setup is done.

Fixes: 33cf00e57082 ("spi: attach/detach SPI device to the ACPI power domain")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Changes since (implicit) v1:

 - make use of spi_drv_probe and spi_drv_remove unconditionally.

 drivers/spi/spi.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 0cab239d8e7f..5becf6c2c409 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -405,9 +405,11 @@ static int spi_drv_probe(struct device *dev)
 	if (ret)
 		return ret;
 
-	ret = sdrv->probe(spi);
-	if (ret)
-		dev_pm_domain_detach(dev, true);
+	if (sdrv->probe) {
+		ret = sdrv->probe(spi);
+		if (ret)
+			dev_pm_domain_detach(dev, true);
+	}
 
 	return ret;
 }
@@ -415,9 +417,10 @@ static int spi_drv_probe(struct device *dev)
 static int spi_drv_remove(struct device *dev)
 {
 	const struct spi_driver		*sdrv = to_spi_driver(dev->driver);
-	int ret;
+	int ret = 0;
 
-	ret = sdrv->remove(to_spi_device(dev));
+	if (sdrv->remove)
+		ret = sdrv->remove(to_spi_device(dev));
 	dev_pm_domain_detach(dev, true);
 
 	return ret;
@@ -442,10 +445,8 @@ int __spi_register_driver(struct module *owner, struct spi_driver *sdrv)
 {
 	sdrv->driver.owner = owner;
 	sdrv->driver.bus = &spi_bus_type;
-	if (sdrv->probe)
-		sdrv->driver.probe = spi_drv_probe;
-	if (sdrv->remove)
-		sdrv->driver.remove = spi_drv_remove;
+	sdrv->driver.probe = spi_drv_probe;
+	sdrv->driver.remove = spi_drv_remove;
 	if (sdrv->shutdown)
 		sdrv->driver.shutdown = spi_drv_shutdown;
 	return driver_register(&sdrv->driver);

base-commit: 09162bc32c880a791c6c0668ce0745cf7958f576
-- 
2.28.0

