Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F35742A870
	for <lists+linux-spi@lfdr.de>; Tue, 12 Oct 2021 17:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237494AbhJLPl6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 12 Oct 2021 11:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237484AbhJLPl5 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 12 Oct 2021 11:41:57 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F18AC061749
        for <linux-spi@vger.kernel.org>; Tue, 12 Oct 2021 08:39:56 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1maJsd-0008NP-Up; Tue, 12 Oct 2021 17:39:52 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1maJsb-0004iY-5t; Tue, 12 Oct 2021 17:39:49 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1maJsb-0004Xa-4r; Tue, 12 Oct 2021 17:39:49 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>, kernel@pengutronix.de,
        linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org
Subject: [PATCH v2 02/20] gpio: max730x: Make __max730x_remove() return void
Date:   Tue, 12 Oct 2021 17:39:27 +0200
Message-Id: <20211012153945.2651412-3-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211012153945.2651412-1-u.kleine-koenig@pengutronix.de>
References: <20211012153945.2651412-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=tqcLhBG6DHD9svNAkG7NX2lapdSljmx+R8lQuV0tyGU=; m=glB6j2gf38uOQhExkc8b6Ih2Xw+z3n90qct7TLl53sM=; p=r2yVQD05AL+Evhwa0VXFPaN8Mh5hwPH1743xH+oyVXE=; g=fe2da4bd8c15949a113d004f924867e64330ca3f
X-Patch-Sig: m=pgp; i=u.kleine-koenig@pengutronix.de; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmFlq/4ACgkQwfwUeK3K7AnyGAf8D4Y /1vPk7Isyb+yrfTxAk/QvVR5qLbSLluQxbVa5yiO1pHGEfyJ+EQEdc2UOkCrJGguN1WWux7LldQP5 PFNK5rOpEHK3gVznK9Je8KN7ULKB1BzpWNZfbsN4e1uG4U6sfs4kgOH4YDnS1dSy6/YNRB9VqFdhl FlEXktFPFjL4+IvPliipW5ltkK3MkmrTRxWXIynSgBvovI+khRFY+ULoO0hlQGjsnk8tZ+VGJMJKR 80SeADe/NBtdwSWLOIDHsxZwQmuPCRBR7EinTFYeAb6hMqPWJq5xpW+5tvlIK38Apnh0cUlBuglt0 3QAD4e5PXSdgkz3V5AuOplU6bQA3l9Q==
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

An spi or i2c remove callback is only called for devices that probed
successfully. In this case this implies that __max730x_probe() set a
non-NULL driver data. So the check ts == NULL is never true. With this
check dropped, __max730x_remove() returns zero unconditionally. Make it
return void instead which makes it easier to see in the callers that
there is no error to handle.

Also the return value of i2c and spi remove callbacks is ignored anyway.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/gpio/gpio-max7300.c | 4 +++-
 drivers/gpio/gpio-max7301.c | 4 +++-
 drivers/gpio/gpio-max730x.c | 6 +-----
 include/linux/spi/max7301.h | 2 +-
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpio/gpio-max7300.c b/drivers/gpio/gpio-max7300.c
index 19cc2ed6a3f5..b2b547dd6e84 100644
--- a/drivers/gpio/gpio-max7300.c
+++ b/drivers/gpio/gpio-max7300.c
@@ -50,7 +50,9 @@ static int max7300_probe(struct i2c_client *client,
 
 static int max7300_remove(struct i2c_client *client)
 {
-	return __max730x_remove(&client->dev);
+	__max730x_remove(&client->dev);
+
+	return 0;
 }
 
 static const struct i2c_device_id max7300_id[] = {
diff --git a/drivers/gpio/gpio-max7301.c b/drivers/gpio/gpio-max7301.c
index 1307c243b4e9..5862d73bf325 100644
--- a/drivers/gpio/gpio-max7301.c
+++ b/drivers/gpio/gpio-max7301.c
@@ -66,7 +66,9 @@ static int max7301_probe(struct spi_device *spi)
 
 static int max7301_remove(struct spi_device *spi)
 {
-	return __max730x_remove(&spi->dev);
+	__max730x_remove(&spi->dev);
+
+	return 0;
 }
 
 static const struct spi_device_id max7301_id[] = {
diff --git a/drivers/gpio/gpio-max730x.c b/drivers/gpio/gpio-max730x.c
index b8c1fe20f49a..bb5cf14ae4c8 100644
--- a/drivers/gpio/gpio-max730x.c
+++ b/drivers/gpio/gpio-max730x.c
@@ -220,18 +220,14 @@ int __max730x_probe(struct max7301 *ts)
 }
 EXPORT_SYMBOL_GPL(__max730x_probe);
 
-int __max730x_remove(struct device *dev)
+void __max730x_remove(struct device *dev)
 {
 	struct max7301 *ts = dev_get_drvdata(dev);
 
-	if (ts == NULL)
-		return -ENODEV;
-
 	/* Power down the chip and disable IRQ output */
 	ts->write(dev, 0x04, 0x00);
 	gpiochip_remove(&ts->chip);
 	mutex_destroy(&ts->lock);
-	return 0;
 }
 EXPORT_SYMBOL_GPL(__max730x_remove);
 
diff --git a/include/linux/spi/max7301.h b/include/linux/spi/max7301.h
index 21449067aedb..e392c53758bc 100644
--- a/include/linux/spi/max7301.h
+++ b/include/linux/spi/max7301.h
@@ -31,6 +31,6 @@ struct max7301_platform_data {
 	u32		input_pullup_active;
 };
 
-extern int __max730x_remove(struct device *dev);
+extern void __max730x_remove(struct device *dev);
 extern int __max730x_probe(struct max7301 *ts);
 #endif
-- 
2.30.2

