Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3C2942A890
	for <lists+linux-spi@lfdr.de>; Tue, 12 Oct 2021 17:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237513AbhJLPmQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 12 Oct 2021 11:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237579AbhJLPmJ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 12 Oct 2021 11:42:09 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 741BDC06176A
        for <linux-spi@vger.kernel.org>; Tue, 12 Oct 2021 08:40:03 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1maJsk-0000Ic-K5; Tue, 12 Oct 2021 17:39:58 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1maJsk-0004kc-2O; Tue, 12 Oct 2021 17:39:58 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1maJsc-0004Ya-W8; Tue, 12 Oct 2021 17:39:50 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Hennerich <michael.hennerich@analog.com>
Cc:     Mark Brown <broonie@kernel.org>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: [PATCH v2 11/20] misc: ad525x_dpot: Make ad_dpot_remove() return void
Date:   Tue, 12 Oct 2021 17:39:36 +0200
Message-Id: <20211012153945.2651412-12-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211012153945.2651412-1-u.kleine-koenig@pengutronix.de>
References: <20211012153945.2651412-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=EXMrVNkUbqY7V63T+YTPXXS2HlLbCtvatL19qm2WHtg=; m=BGTwvqK+RKGgnKfGCyGNhmDyuScjHEci5h4DxVv3qZM=; p=yQdEfF2PwN8/D0REJaPAIE32zm4eLHsNwhbjpfrb8sA=; g=815ab97c4c8e25de58d548a08c2b1645b2fa6f38
X-Patch-Sig: m=pgp; i=u.kleine-koenig@pengutronix.de; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmFlrBoACgkQwfwUeK3K7AmGcggAoNS 06dPcnO+6j1pP3ayFGgKUoNViSu9t9pTbqsP+nGynrmy0BmboLt4Or9PtUDkjBYhe1oTm/epKjODS KxGtdXdOk9tf7GMUqobiMj0M4FlGAVQNrXVFvQ/865TGqZpKJIHM4DSpjH8UPbuskxMt8DT6PRp7G hr4EWdwFTvkgMLAebwxOFBAr1U+QaJRTT6S93oanABwCl4/MiiYlSj1DniyFCueVIJDejeoSI3b0Y NFxptp7/yvI45y+lp/xxwjy5fDwquaH1mz9At5lDQbojbBpPbkxJzwleqC7uRc5eDHHuJAYwMz6qf V5aUXMHf5vbb9KEcNPIIHKo8JUctJ/Q==
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Up to now ad_dpot_remove() returns zero unconditionally. Make it return
void instead which makes it easier to see in the callers that there is
no error to handle.

Also the return value of i2c and spi remove callbacks is ignored anyway.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/misc/ad525x_dpot-i2c.c | 3 ++-
 drivers/misc/ad525x_dpot-spi.c | 3 ++-
 drivers/misc/ad525x_dpot.c     | 4 +---
 drivers/misc/ad525x_dpot.h     | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/ad525x_dpot-i2c.c b/drivers/misc/ad525x_dpot-i2c.c
index bd869ec5edba..0ee0c6d808c3 100644
--- a/drivers/misc/ad525x_dpot-i2c.c
+++ b/drivers/misc/ad525x_dpot-i2c.c
@@ -69,7 +69,8 @@ static int ad_dpot_i2c_probe(struct i2c_client *client,
 
 static int ad_dpot_i2c_remove(struct i2c_client *client)
 {
-	return ad_dpot_remove(&client->dev);
+	ad_dpot_remove(&client->dev);
+	return 0;
 }
 
 static const struct i2c_device_id ad_dpot_id[] = {
diff --git a/drivers/misc/ad525x_dpot-spi.c b/drivers/misc/ad525x_dpot-spi.c
index aea931dd272e..a9e75d80ad36 100644
--- a/drivers/misc/ad525x_dpot-spi.c
+++ b/drivers/misc/ad525x_dpot-spi.c
@@ -92,7 +92,8 @@ static int ad_dpot_spi_probe(struct spi_device *spi)
 
 static int ad_dpot_spi_remove(struct spi_device *spi)
 {
-	return ad_dpot_remove(&spi->dev);
+	ad_dpot_remove(&spi->dev);
+	return 0;
 }
 
 static const struct spi_device_id ad_dpot_spi_id[] = {
diff --git a/drivers/misc/ad525x_dpot.c b/drivers/misc/ad525x_dpot.c
index 5d8f3f6a95f2..756ef6912b5a 100644
--- a/drivers/misc/ad525x_dpot.c
+++ b/drivers/misc/ad525x_dpot.c
@@ -743,7 +743,7 @@ int ad_dpot_probe(struct device *dev,
 }
 EXPORT_SYMBOL(ad_dpot_probe);
 
-int ad_dpot_remove(struct device *dev)
+void ad_dpot_remove(struct device *dev)
 {
 	struct dpot_data *data = dev_get_drvdata(dev);
 	int i;
@@ -753,8 +753,6 @@ int ad_dpot_remove(struct device *dev)
 			ad_dpot_remove_files(dev, data->feat, i);
 
 	kfree(data);
-
-	return 0;
 }
 EXPORT_SYMBOL(ad_dpot_remove);
 
diff --git a/drivers/misc/ad525x_dpot.h b/drivers/misc/ad525x_dpot.h
index ee8dc9f5a45a..72a9d6801937 100644
--- a/drivers/misc/ad525x_dpot.h
+++ b/drivers/misc/ad525x_dpot.h
@@ -209,6 +209,6 @@ struct ad_dpot_bus_data {
 
 int ad_dpot_probe(struct device *dev, struct ad_dpot_bus_data *bdata,
 		  unsigned long devid, const char *name);
-int ad_dpot_remove(struct device *dev);
+void ad_dpot_remove(struct device *dev);
 
 #endif
-- 
2.30.2

