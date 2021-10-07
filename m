Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2C1B4252CF
	for <lists+linux-spi@lfdr.de>; Thu,  7 Oct 2021 14:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241223AbhJGMQU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 7 Oct 2021 08:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241229AbhJGMQR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 7 Oct 2021 08:16:17 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC50C061764
        for <linux-spi@vger.kernel.org>; Thu,  7 Oct 2021 05:14:23 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mYSI2-0007I7-4x; Thu, 07 Oct 2021 14:14:22 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mYSI1-00061w-2f; Thu, 07 Oct 2021 14:14:21 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mYSI1-0006pd-1w; Thu, 07 Oct 2021 14:14:21 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 2/4] spi: Remove unused function spi_busnum_to_master()
Date:   Thu,  7 Oct 2021 14:14:13 +0200
Message-Id: <20211007121415.2401638-3-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211007121415.2401638-1-u.kleine-koenig@pengutronix.de>
References: <20211007121415.2401638-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=seI7kng597p6yauS1Yfc9aaB0ADLcuW8ZPWWhzuRkIo=; m=DkjHBGzJK5Unen0optfR9makm8IBN5FCsxVP+JN4IG0=; p=EAHU6Haob3rPHSd3nHXbiiO5Z76pylwaJCFSDocTwbE=; g=376bedd755ba66b2b341f8d2878fb3b622ba0d9c
X-Patch-Sig: m=pgp; i=u.kleine-koenig@pengutronix.de; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmFe5I4ACgkQwfwUeK3K7AlPSwf+Oyt 4UJ57197W0isAr9xzw12QsJdhM4TAVTu230LMyhF2wx73xCfoyFl9+zdwvDtxAkgOUX+NaeEUKefL axsMSYgy0BCbCF9JBoRM7CK/64959Km41ndiqQLqKv4JVP1GVs9hPYL98X9CWPd5Cf6wvDhFX2mQD XLftfaLeJiiuKFg/Fau0CqoCvPHnMX4bVrNwDViwQWQJU6betpjeTQao13V1vZLlenJQMQUzW/UiK 4GCUJg+Ij0SkCu0UCXh62H85RojqOb4UbOUi95QBo+YG9qq7uzi9QLwUaEw6dSLYq04Hnx2byAVbs bwBmMFPPbttGkN4CBfOCX120ElilICg==
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The last user is gone since commit

	2962db71c703 ("staging/fbtft: Remove fbtft_device")

in 2019.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 Documentation/spi/spi-summary.rst |  8 -------
 drivers/spi/spi.c                 | 35 -------------------------------
 include/linux/spi/spi.h           |  2 --
 3 files changed, 45 deletions(-)

diff --git a/Documentation/spi/spi-summary.rst b/Documentation/spi/spi-summary.rst
index d4239025461d..aab5d07cb3d7 100644
--- a/Documentation/spi/spi-summary.rst
+++ b/Documentation/spi/spi-summary.rst
@@ -336,14 +336,6 @@ certainly includes SPI devices hooked up through the card connectors!
 Non-static Configurations
 ^^^^^^^^^^^^^^^^^^^^^^^^^
 
-Developer boards often play by different rules than product boards, and one
-example is the potential need to hotplug SPI devices and/or controllers.
-
-For those cases you might need to use spi_busnum_to_master() to look
-up the spi bus master, and will likely need spi_new_device() to provide the
-board info based on the board that was hotplugged.  Of course, you'd later
-call at least spi_unregister_device() when that board is removed.
-
 When Linux includes support for MMC/SD/SDIO/DataFlash cards through SPI, those
 configurations will also be dynamic.  Fortunately, such devices all support
 basic device identification probes, so they should hotplug normally.
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index ff4254dc64af..cc4ac42aa93d 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -3033,41 +3033,6 @@ int spi_controller_resume(struct spi_controller *ctlr)
 }
 EXPORT_SYMBOL_GPL(spi_controller_resume);
 
-static int __spi_controller_match(struct device *dev, const void *data)
-{
-	struct spi_controller *ctlr;
-	const u16 *bus_num = data;
-
-	ctlr = container_of(dev, struct spi_controller, dev);
-	return ctlr->bus_num == *bus_num;
-}
-
-/**
- * spi_busnum_to_master - look up master associated with bus_num
- * @bus_num: the master's bus number
- * Context: can sleep
- *
- * This call may be used with devices that are registered after
- * arch init time.  It returns a refcounted pointer to the relevant
- * spi_controller (which the caller must release), or NULL if there is
- * no such master registered.
- *
- * Return: the SPI master structure on success, else NULL.
- */
-struct spi_controller *spi_busnum_to_master(u16 bus_num)
-{
-	struct device		*dev;
-	struct spi_controller	*ctlr = NULL;
-
-	dev = class_find_device(&spi_master_class, NULL, &bus_num,
-				__spi_controller_match);
-	if (dev)
-		ctlr = container_of(dev, struct spi_controller, dev);
-	/* reference got in class_find_device */
-	return ctlr;
-}
-EXPORT_SYMBOL_GPL(spi_busnum_to_master);
-
 /*-------------------------------------------------------------------------*/
 
 /* Core methods for SPI resource management */
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 8371bca13729..f8e322a46616 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -760,8 +760,6 @@ extern int devm_spi_register_controller(struct device *dev,
 					struct spi_controller *ctlr);
 extern void spi_unregister_controller(struct spi_controller *ctlr);
 
-extern struct spi_controller *spi_busnum_to_master(u16 busnum);
-
 /*
  * SPI resource management while processing a SPI message
  */
-- 
2.30.2

