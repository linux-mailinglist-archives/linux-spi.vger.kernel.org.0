Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC6715BDA5
	for <lists+linux-spi@lfdr.de>; Thu, 13 Feb 2020 12:27:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729531AbgBML1z (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 13 Feb 2020 06:27:55 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:42261 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729428AbgBML1z (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 13 Feb 2020 06:27:55 -0500
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1j2Ceu-0006yd-6Y; Thu, 13 Feb 2020 12:27:52 +0100
Received: from ukl by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1j2Cet-0004yp-Qg; Thu, 13 Feb 2020 12:27:51 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     Jiri Kosina <trivial@kernel.org>, linux-spi@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH] trivial: spi: typo Emptry -> Empty
Date:   Thu, 13 Feb 2020 12:27:50 +0100
Message-Id: <20200213112750.17450-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Found while reading though spi.c

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/spi/spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index f9502dbbb5c1..93556567ccb9 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -92,7 +92,7 @@ static ssize_t driver_override_store(struct device *dev,
 	if (len) {
 		spi->driver_override = driver_override;
 	} else {
-		/* Emptry string, disable driver override */
+		/* Empty string, disable driver override */
 		spi->driver_override = NULL;
 		kfree(driver_override);
 	}
-- 
2.25.0

