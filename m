Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82E002B9791
	for <lists+linux-spi@lfdr.de>; Thu, 19 Nov 2020 17:17:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728222AbgKSQQP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 19 Nov 2020 11:16:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727800AbgKSQQP (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 19 Nov 2020 11:16:15 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B80C0613D4
        for <linux-spi@vger.kernel.org>; Thu, 19 Nov 2020 08:16:13 -0800 (PST)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kfmbT-0004Lf-O3; Thu, 19 Nov 2020 17:16:11 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1kfmbT-0003p7-EW; Thu, 19 Nov 2020 17:16:11 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 2/3] spi: Use bus_type functions for probe, remove and shutdown
Date:   Thu, 19 Nov 2020 17:16:03 +0100
Message-Id: <20201119161604.2633521-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201119161604.2633521-1-u.kleine-koenig@pengutronix.de>
References: <20201119161604.2633521-1-u.kleine-koenig@pengutronix.de>
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

The eventual goal is to get rid of the callbacks in struct
device_driver. Other than not using driver callbacks there should be no
side effect of this patch.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/spi/spi.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 5becf6c2c409..e8c0a000ee19 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -374,16 +374,7 @@ static int spi_uevent(struct device *dev, struct kobj_uevent_env *env)
 	return add_uevent_var(env, "MODALIAS=%s%s", SPI_MODULE_PREFIX, spi->modalias);
 }
 
-struct bus_type spi_bus_type = {
-	.name		= "spi",
-	.dev_groups	= spi_dev_groups,
-	.match		= spi_match_device,
-	.uevent		= spi_uevent,
-};
-EXPORT_SYMBOL_GPL(spi_bus_type);
-
-
-static int spi_drv_probe(struct device *dev)
+static int spi_probe(struct device *dev)
 {
 	const struct spi_driver		*sdrv = to_spi_driver(dev->driver);
 	struct spi_device		*spi = to_spi_device(dev);
@@ -414,7 +405,7 @@ static int spi_drv_probe(struct device *dev)
 	return ret;
 }
 
-static int spi_drv_remove(struct device *dev)
+static int spi_remove(struct device *dev)
 {
 	const struct spi_driver		*sdrv = to_spi_driver(dev->driver);
 	int ret = 0;
@@ -426,13 +417,25 @@ static int spi_drv_remove(struct device *dev)
 	return ret;
 }
 
-static void spi_drv_shutdown(struct device *dev)
+static void spi_shutdown(struct device *dev)
 {
 	const struct spi_driver		*sdrv = to_spi_driver(dev->driver);
 
-	sdrv->shutdown(to_spi_device(dev));
+	if (sdrv->shutdown)
+		sdrv->shutdown(to_spi_device(dev));
 }
 
+struct bus_type spi_bus_type = {
+	.name		= "spi",
+	.dev_groups	= spi_dev_groups,
+	.match		= spi_match_device,
+	.uevent		= spi_uevent,
+	.probe		= spi_probe,
+	.remove		= spi_remove,
+	.shutdown	= spi_shutdown,
+};
+EXPORT_SYMBOL_GPL(spi_bus_type);
+
 /**
  * __spi_register_driver - register a SPI driver
  * @owner: owner module of the driver to register
@@ -445,10 +448,6 @@ int __spi_register_driver(struct module *owner, struct spi_driver *sdrv)
 {
 	sdrv->driver.owner = owner;
 	sdrv->driver.bus = &spi_bus_type;
-	sdrv->driver.probe = spi_drv_probe;
-	sdrv->driver.remove = spi_drv_remove;
-	if (sdrv->shutdown)
-		sdrv->driver.shutdown = spi_drv_shutdown;
 	return driver_register(&sdrv->driver);
 }
 EXPORT_SYMBOL_GPL(__spi_register_driver);
-- 
2.28.0

