Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F14142A888
	for <lists+linux-spi@lfdr.de>; Tue, 12 Oct 2021 17:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237462AbhJLPmM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 12 Oct 2021 11:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237567AbhJLPmI (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 12 Oct 2021 11:42:08 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18FF9C061766
        for <linux-spi@vger.kernel.org>; Tue, 12 Oct 2021 08:40:02 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1maJsk-0000II-Bq; Tue, 12 Oct 2021 17:39:58 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1maJsj-0004kF-QI; Tue, 12 Oct 2021 17:39:57 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1maJsc-0004YK-Gg; Tue, 12 Oct 2021 17:39:50 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: [PATCH v2 08/20] mfd: mc13xxx: Make mc13xxx_common_exit() return void
Date:   Tue, 12 Oct 2021 17:39:33 +0200
Message-Id: <20211012153945.2651412-9-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211012153945.2651412-1-u.kleine-koenig@pengutronix.de>
References: <20211012153945.2651412-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=J0ahGtF24eL+BKixNT+eVqqWAgunLx1WrSLObTBrLHE=; m=iAYXBDyS7vtYm0Q4B+/bh1iHsdzFe765AJZBSjfwEOk=; p=TJRcqcmzluYBW46T1V2zGB+3lNMcmVPb0isZQJg7eQs=; g=eb89a423a41a45a2129a3976ae022c06593f26d7
X-Patch-Sig: m=pgp; i=u.kleine-koenig@pengutronix.de; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmFlrBAACgkQwfwUeK3K7AngyAf/Uku 9UVj6F4MAHMPRreuoef2rVCjDXTOodXnPRnIMMFD4UkjXv3xZq+OBgvNfSmBOA0ogWR6kVlIKAYMF HaUwynitP2D0mX1caehzcu0GMdgdJty1Nna8EaNfG4hsjoOo8YBwIVRBVxlfuHAF51TcdEv7SFxoi LxmNDUkuFC0hvCfWUm0DMU2xMUMQPiF1alKHSSQMFeNz0OH4AQ498VOhd77+fxyxRzzHcRyMQ/uf+ qLOwQ+4smg+fg9kG48ESXNacqRCpOWq/I1tng4ZJV7cUPZcpDANyaxiGmc9rxD/Xo5skmEklbZSVt A1+1bFZFnFl2O7Y8Zlz+6X0U/T+X8hQ==
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Up to now mc13xxx_common_exit() returns zero unconditionally. Make it
return void instead which makes it easier to see in the callers that
there is no error to handle.

Also the return value of i2c and spi remove callbacks is ignored anyway.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/mfd/mc13xxx-core.c | 4 +---
 drivers/mfd/mc13xxx-i2c.c  | 3 ++-
 drivers/mfd/mc13xxx-spi.c  | 3 ++-
 drivers/mfd/mc13xxx.h      | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/mfd/mc13xxx-core.c b/drivers/mfd/mc13xxx-core.c
index 1abe7432aad8..8a4f1d90dcfd 100644
--- a/drivers/mfd/mc13xxx-core.c
+++ b/drivers/mfd/mc13xxx-core.c
@@ -496,15 +496,13 @@ int mc13xxx_common_init(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(mc13xxx_common_init);
 
-int mc13xxx_common_exit(struct device *dev)
+void mc13xxx_common_exit(struct device *dev)
 {
 	struct mc13xxx *mc13xxx = dev_get_drvdata(dev);
 
 	mfd_remove_devices(dev);
 	regmap_del_irq_chip(mc13xxx->irq, mc13xxx->irq_data);
 	mutex_destroy(&mc13xxx->lock);
-
-	return 0;
 }
 EXPORT_SYMBOL_GPL(mc13xxx_common_exit);
 
diff --git a/drivers/mfd/mc13xxx-i2c.c b/drivers/mfd/mc13xxx-i2c.c
index 65b4dd8e5afb..fb937f66277e 100644
--- a/drivers/mfd/mc13xxx-i2c.c
+++ b/drivers/mfd/mc13xxx-i2c.c
@@ -87,7 +87,8 @@ static int mc13xxx_i2c_probe(struct i2c_client *client,
 
 static int mc13xxx_i2c_remove(struct i2c_client *client)
 {
-	return mc13xxx_common_exit(&client->dev);
+	mc13xxx_common_exit(&client->dev);
+	return 0;
 }
 
 static struct i2c_driver mc13xxx_i2c_driver = {
diff --git a/drivers/mfd/mc13xxx-spi.c b/drivers/mfd/mc13xxx-spi.c
index 286ddcf5ddc6..4d8913d647e6 100644
--- a/drivers/mfd/mc13xxx-spi.c
+++ b/drivers/mfd/mc13xxx-spi.c
@@ -168,7 +168,8 @@ static int mc13xxx_spi_probe(struct spi_device *spi)
 
 static int mc13xxx_spi_remove(struct spi_device *spi)
 {
-	return mc13xxx_common_exit(&spi->dev);
+	mc13xxx_common_exit(&spi->dev);
+	return 0;
 }
 
 static struct spi_driver mc13xxx_spi_driver = {
diff --git a/drivers/mfd/mc13xxx.h b/drivers/mfd/mc13xxx.h
index ce6eec52e8eb..bd5ba9a0e14f 100644
--- a/drivers/mfd/mc13xxx.h
+++ b/drivers/mfd/mc13xxx.h
@@ -44,6 +44,6 @@ struct mc13xxx {
 };
 
 int mc13xxx_common_init(struct device *dev);
-int mc13xxx_common_exit(struct device *dev);
+void mc13xxx_common_exit(struct device *dev);
 
 #endif /* __DRIVERS_MFD_MC13XXX_H */
-- 
2.30.2

