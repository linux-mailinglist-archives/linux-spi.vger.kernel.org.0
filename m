Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4A364252CB
	for <lists+linux-spi@lfdr.de>; Thu,  7 Oct 2021 14:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241209AbhJGMQT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 7 Oct 2021 08:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241217AbhJGMQR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 7 Oct 2021 08:16:17 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9500C061746
        for <linux-spi@vger.kernel.org>; Thu,  7 Oct 2021 05:14:23 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mYSI2-0007I6-4x; Thu, 07 Oct 2021 14:14:22 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mYSI0-00061t-TG; Thu, 07 Oct 2021 14:14:20 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mYSI0-0006pQ-SX; Thu, 07 Oct 2021 14:14:20 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 1/4] spi: Move comment about chipselect check to the right place
Date:   Thu,  7 Oct 2021 14:14:12 +0200
Message-Id: <20211007121415.2401638-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211007121415.2401638-1-u.kleine-koenig@pengutronix.de>
References: <20211007121415.2401638-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=RO8Js/RY4wtW13o2/mIA4B1cAbdu/eA3mjTLtvg0faM=; m=QXq+ozx790KLm+6zhWDpGm/rzyC1Q7/5IR01B7CDfl8=; p=XG4l0jf9gMnlD95ZfXNCxiMMOQUuX2p9RVMubsl+YEE=; g=19757e9e5b1c6b4b74afc8cd15ae4c09136b05a8
X-Patch-Sig: m=pgp; i=u.kleine-koenig@pengutronix.de; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmFe5IoACgkQwfwUeK3K7AmzTgf+Puo xm7SbpGsM77U2v1ZrXTu4Ixhd4HZl7qISYPPzXHHBMfoG26XfsNXU6khIT5h/opgbt+9z8jMQnJ4I 6yVRtvwyI914sTQ297kkDAWM9bKLEAUYwPTGaV/QjP/pZ1gp+mIPFHOtm2NfVtX+taLDQDSH2UuNu 7LF9z+HIj2ZzbPBoCBRqTIAHqLScF9aSHdFi2qxOJFb7dq4UlHZ1rV3JDIbi2RjohVsF5PvDwHVTH 5tmm+WnfF+G8BVK/JKVREinrozp+OuILuQ2NvKGJEgx/Jma6yddqd9a3mPQRLL6iIIzjo0cBOF+6m 97u5NEUNkFxyQaVANj8cYt15cfRuG2A==
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The part of the comment about locking isn't that relevant compared to
the chip select check. So drop the sentence about locking.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/spi/spi.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index aea037c65985..ff4254dc64af 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -564,6 +564,11 @@ static int __spi_add_device(struct spi_device *spi)
 	struct device *dev = ctlr->dev.parent;
 	int status;
 
+	/*
+	 * We need to make sure there's no other device with this
+	 * chipselect **BEFORE** we call setup(), else we'll trash
+	 * its configuration.
+	 */
 	status = bus_for_each_dev(&spi_bus_type, NULL, spi, spi_dev_check);
 	if (status) {
 		dev_err(dev, "chipselect %d already in use\n",
@@ -632,10 +637,6 @@ int spi_add_device(struct spi_device *spi)
 	/* Set the bus ID string */
 	spi_dev_set_name(spi);
 
-	/* We need to make sure there's no other device with this
-	 * chipselect **BEFORE** we call setup(), else we'll trash
-	 * its configuration.  Lock against concurrent add() calls.
-	 */
 	mutex_lock(&spi_add_lock);
 	status = __spi_add_device(spi);
 	mutex_unlock(&spi_add_lock);
-- 
2.30.2

