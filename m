Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF569428DCA
	for <lists+linux-spi@lfdr.de>; Mon, 11 Oct 2021 15:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235421AbhJKNaI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 11 Oct 2021 09:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235197AbhJKNaH (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 11 Oct 2021 09:30:07 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B63A7C061570
        for <linux-spi@vger.kernel.org>; Mon, 11 Oct 2021 06:28:07 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mZvLZ-0006g4-Rm; Mon, 11 Oct 2021 15:28:05 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mZvLY-0003ny-EI; Mon, 11 Oct 2021 15:28:04 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mZvLX-0000TQ-Cg; Mon, 11 Oct 2021 15:28:03 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        kernel@pengutronix.de, dri-devel@lists.freedesktop.org,
        linux-staging@lists.linux.dev,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 12/13] staging: fbtft: Make fbtft_remove_common() return void
Date:   Mon, 11 Oct 2021 15:27:53 +0200
Message-Id: <20211011132754.2479853-13-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211011132754.2479853-1-u.kleine-koenig@pengutronix.de>
References: <20211011132754.2479853-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=/RLR4bDyADQRwzANF6ER5sKrX+JFDYSh90Q0J5N84UY=; m=6FiNYI6au9uFB2IoKzr/cKU1LkGxlwoXSYCPM/+GX+Y=; p=19a0XOl3ZNoBogBHt63wtoEAqL9C5QZcMx0lWBBcXvs=; g=3740c58a50a748d6ac2559b325ee4fcd79372ba0
X-Patch-Sig: m=pgp; i=u.kleine-koenig@pengutronix.de; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmFkO4IACgkQwfwUeK3K7AmPFAgAi2j +ekzLBUvvkSW1V7aAZ7NxSqFgWZ8q7dgSdTwOKmsCZCyNbQsT02lQhdQnxam0NAMjaxhPzaEVAUf9 cjqtzjNApl7RfLYR7nGLh2XuJ4EqX7uUlOzAdeoEe3r1T4eqGrWC+7AfBINYA992Q6zFAZRqNXZrY PBfjEYtKmJ0IAO/Qx4tDgVISz0GQsn+8JJ01P4udY1sud6QjhaO+87wCpCXT7qwQa9q8WN+fIsSYs 0Ut+4ptQh7WDuG+Qb09CIIf4Bk9nAi/X3gofxHs97omC6x3ldQlraHCrNuUHUe77brVawa8/TR38j SEFRvmVk4U0dYlvaiuLXguJP8IRqcVA==
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

fbtft_remove_common() is only called with a non-NULL fb_info. (All
callers are in remove callbacks and the matching probe callbacks set
driver data accordingly.) So fbtft_remove_common() always returns zero.
Make it return void instead which makes it easier to see in the callers
that there is no error to handle.

Also the return value of platform and spi remove callbacks is ignored
anyway and not freeing resources in .remove() is a bad idea.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/staging/fbtft/fbtft-core.c | 8 +-------
 drivers/staging/fbtft/fbtft.h      | 6 ++++--
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/fbtft-core.c
index ed992ca605eb..9c9eab1182a6 100644
--- a/drivers/staging/fbtft/fbtft-core.c
+++ b/drivers/staging/fbtft/fbtft-core.c
@@ -1318,23 +1318,17 @@ EXPORT_SYMBOL(fbtft_probe_common);
  * @info: Framebuffer
  *
  * Unregisters and releases the framebuffer
- *
- * Return: 0 if successful, negative if error
  */
-int fbtft_remove_common(struct device *dev, struct fb_info *info)
+void fbtft_remove_common(struct device *dev, struct fb_info *info)
 {
 	struct fbtft_par *par;
 
-	if (!info)
-		return -EINVAL;
 	par = info->par;
 	if (par)
 		fbtft_par_dbg(DEBUG_DRIVER_INIT_FUNCTIONS, par,
 			      "%s()\n", __func__);
 	fbtft_unregister_framebuffer(info);
 	fbtft_framebuffer_release(info);
-
-	return 0;
 }
 EXPORT_SYMBOL(fbtft_remove_common);
 
diff --git a/drivers/staging/fbtft/fbtft.h b/drivers/staging/fbtft/fbtft.h
index 76f8c090a837..68eba6c71b0f 100644
--- a/drivers/staging/fbtft/fbtft.h
+++ b/drivers/staging/fbtft/fbtft.h
@@ -283,7 +283,8 @@ static int fbtft_driver_remove_spi(struct spi_device *spi)                 \
 {                                                                          \
 	struct fb_info *info = spi_get_drvdata(spi);                       \
 									   \
-	return fbtft_remove_common(&spi->dev, info);                       \
+	fbtft_remove_common(&spi->dev, info);                              \
+	return 0;                                                          \
 }                                                                          \
 									   \
 static int fbtft_driver_probe_pdev(struct platform_device *pdev)           \
@@ -295,7 +296,8 @@ static int fbtft_driver_remove_pdev(struct platform_device *pdev)          \
 {                                                                          \
 	struct fb_info *info = platform_get_drvdata(pdev);                 \
 									   \
-	return fbtft_remove_common(&pdev->dev, info);                      \
+	fbtft_remove_common(&pdev->dev, info);                             \
+	return 0;                                                          \
 }                                                                          \
 									   \
 static const struct of_device_id dt_ids[] = {                              \
-- 
2.30.2

