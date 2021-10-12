Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0384942A871
	for <lists+linux-spi@lfdr.de>; Tue, 12 Oct 2021 17:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237484AbhJLPl6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 12 Oct 2021 11:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237462AbhJLPl5 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 12 Oct 2021 11:41:57 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 237A9C061745
        for <linux-spi@vger.kernel.org>; Tue, 12 Oct 2021 08:39:56 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1maJsd-0008NS-Up; Tue, 12 Oct 2021 17:39:52 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1maJsc-0004ih-1B; Tue, 12 Oct 2021 17:39:50 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1maJsc-0004Y8-0I; Tue, 12 Oct 2021 17:39:50 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, kernel@pengutronix.de,
        linux-input@vger.kernel.org, linux-spi@vger.kernel.org
Subject: [PATCH v2 06/20] input: touchscreen: tsc200x: Make tsc200x_remove() return void
Date:   Tue, 12 Oct 2021 17:39:31 +0200
Message-Id: <20211012153945.2651412-7-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211012153945.2651412-1-u.kleine-koenig@pengutronix.de>
References: <20211012153945.2651412-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=94oorPupYOLS40HYKqyvmBk6HGvbhR+NJnei2QkNFGk=; m=Bsn3NLP3I1exqSpvJBONKOIhA7oOcADEshibx4agNIQ=; p=XrMASlvC85yGCSzZ81aLygEbijEM+OrmhchqNjTkj3k=; g=d5cc911828fc149b672baef67a39ff26315a5a39
X-Patch-Sig: m=pgp; i=u.kleine-koenig@pengutronix.de; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmFlrAoACgkQwfwUeK3K7AkMDAf/TYq JLQRB8P0IbWTquAN/H8sAzdf2o7/37Hhn/ane5ZSaO1+1/tPr9idW9Jdu9J1G45oPlCB9cmkBVUWM ljZEbyPT8JAxVBKgaabtLTnLwLBSQXLlxOegQTbocsY2uN1FLEyJoRbsbBz1Uyi2n6ftrq/CGK++D TZZL7XLBRkf9s4Z9kAjF0byjb1QHhzBkCU63HYB8d+xH8iMeOYvTcoYsNd9esukKNLksnAQVTe9V7 rA1zX7t3Cd5WhtUWPU8lFkRmdfng6PrlONTSaVojdFEb4uLdyJaLKZiMvR/xnknm1MC1QjhO4DSeK O2DFaY/OtnJUGBcFUVePzu0iK9u0wDg==
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Up to now tsc200x_remove() returns zero unconditionally. Make it return
void instead which makes it easier to see in the callers that there is
no error to handle.

Also the return value of i2c and spi remove callbacks is ignored anyway.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/input/touchscreen/tsc2004.c      | 4 +++-
 drivers/input/touchscreen/tsc2005.c      | 4 +++-
 drivers/input/touchscreen/tsc200x-core.c | 4 +---
 drivers/input/touchscreen/tsc200x-core.h | 2 +-
 4 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/input/touchscreen/tsc2004.c b/drivers/input/touchscreen/tsc2004.c
index 0272cedcc726..9fdd870c4c0b 100644
--- a/drivers/input/touchscreen/tsc2004.c
+++ b/drivers/input/touchscreen/tsc2004.c
@@ -45,7 +45,9 @@ static int tsc2004_probe(struct i2c_client *i2c,
 
 static int tsc2004_remove(struct i2c_client *i2c)
 {
-	return tsc200x_remove(&i2c->dev);
+	tsc200x_remove(&i2c->dev);
+
+	return 0;
 }
 
 static const struct i2c_device_id tsc2004_idtable[] = {
diff --git a/drivers/input/touchscreen/tsc2005.c b/drivers/input/touchscreen/tsc2005.c
index 923496bbb368..a2f55920b9b2 100644
--- a/drivers/input/touchscreen/tsc2005.c
+++ b/drivers/input/touchscreen/tsc2005.c
@@ -66,7 +66,9 @@ static int tsc2005_probe(struct spi_device *spi)
 
 static int tsc2005_remove(struct spi_device *spi)
 {
-	return tsc200x_remove(&spi->dev);
+	tsc200x_remove(&spi->dev);
+
+	return 0;
 }
 
 #ifdef CONFIG_OF
diff --git a/drivers/input/touchscreen/tsc200x-core.c b/drivers/input/touchscreen/tsc200x-core.c
index b8d720d52013..27810f6c69f6 100644
--- a/drivers/input/touchscreen/tsc200x-core.c
+++ b/drivers/input/touchscreen/tsc200x-core.c
@@ -577,15 +577,13 @@ int tsc200x_probe(struct device *dev, int irq, const struct input_id *tsc_id,
 }
 EXPORT_SYMBOL_GPL(tsc200x_probe);
 
-int tsc200x_remove(struct device *dev)
+void tsc200x_remove(struct device *dev)
 {
 	struct tsc200x *ts = dev_get_drvdata(dev);
 
 	sysfs_remove_group(&dev->kobj, &tsc200x_attr_group);
 
 	regulator_disable(ts->vio);
-
-	return 0;
 }
 EXPORT_SYMBOL_GPL(tsc200x_remove);
 
diff --git a/drivers/input/touchscreen/tsc200x-core.h b/drivers/input/touchscreen/tsc200x-core.h
index a43c08ccfd3d..4ded34425b21 100644
--- a/drivers/input/touchscreen/tsc200x-core.h
+++ b/drivers/input/touchscreen/tsc200x-core.h
@@ -74,6 +74,6 @@ extern const struct dev_pm_ops tsc200x_pm_ops;
 int tsc200x_probe(struct device *dev, int irq, const struct input_id *tsc_id,
 		  struct regmap *regmap,
 		  int (*tsc200x_cmd)(struct device *dev, u8 cmd));
-int tsc200x_remove(struct device *dev);
+void tsc200x_remove(struct device *dev);
 
 #endif
-- 
2.30.2

