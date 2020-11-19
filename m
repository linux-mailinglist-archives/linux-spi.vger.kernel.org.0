Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5242B9600
	for <lists+linux-spi@lfdr.de>; Thu, 19 Nov 2020 16:21:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbgKSPVM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 19 Nov 2020 10:21:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728332AbgKSPVM (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 19 Nov 2020 10:21:12 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08BF0C0613CF
        for <linux-spi@vger.kernel.org>; Thu, 19 Nov 2020 07:21:12 -0800 (PST)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kflkE-00045H-I3; Thu, 19 Nov 2020 16:21:10 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1kflkE-00018o-6k; Thu, 19 Nov 2020 16:21:10 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 3/3] spi: Warn when a driver's remove callback returns an error
Date:   Thu, 19 Nov 2020 16:20:59 +0100
Message-Id: <20201119152059.2631650-3-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201119152059.2631650-1-u.kleine-koenig@pengutronix.de>
References: <20201119152059.2631650-1-u.kleine-koenig@pengutronix.de>
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

The driver core ignores the return value of struct device_driver::remove
(because in general there is nothing that can be done about that). So
add a warning when an spi driver returns an error.

This simplifies the quest to make struct device_driver::remove return void.
A consequent change would be to make struct spi_driver::remove return void,
but I'm keeping this quest for later (or someone else).

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/spi/spi.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index e8c0a000ee19..6b7c19bf7715 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -408,13 +408,20 @@ static int spi_probe(struct device *dev)
 static int spi_remove(struct device *dev)
 {
 	const struct spi_driver		*sdrv = to_spi_driver(dev->driver);
-	int ret = 0;
 
-	if (sdrv->remove)
+	if (sdrv->remove) {
+		int ret;
+
 		ret = sdrv->remove(to_spi_device(dev));
+		if (ret)
+			dev_warn(dev,
+				 "Failed to unbind driver (%pe), ignoring\n",
+				 ERR_PTR(ret));
+	}
+
 	dev_pm_domain_detach(dev, true);
 
-	return ret;
+	return 0;
 }
 
 static void spi_shutdown(struct device *dev)
-- 
2.28.0

