Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 932D32B19FB
	for <lists+linux-spi@lfdr.de>; Fri, 13 Nov 2020 12:23:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726433AbgKMLXl (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 13 Nov 2020 06:23:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbgKMLWv (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 13 Nov 2020 06:22:51 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 020D7C0617A6
        for <linux-spi@vger.kernel.org>; Fri, 13 Nov 2020 03:22:51 -0800 (PST)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1kdXAB-0000OI-5P; Fri, 13 Nov 2020 12:22:43 +0100
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1kdXA9-0000Mp-LA; Fri, 13 Nov 2020 12:22:41 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>,
        David Jander <david@protonic.nl>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: [PATCH v1] Input: touchscreen: ads7846.c: fix integer overflow on Rt calculation
Date:   Fri, 13 Nov 2020 12:22:40 +0100
Message-Id: <20201113112240.1360-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

In some rare cases the 32 bit Rt value will overflow if z2 and x is max,
z1 is minimal value and x_plate_ohms is relatively high (for example 800
ohm). This would happen on some screen age with low pressure.

There are two possible fixes:
- make Rt 64bit
- reorder calculation to avoid overflow

The second variant seems to be preferable, since 64 bit calculation on
32 bit system is a bit more expensive.

Fixes: ffa458c1bd9b6f653008d450f337602f3d52a646 ("spi: ads7846 driver")
Co-Developed-by: David Jander <david@protonic.nl>
Signed-off-by: David Jander <david@protonic.nl>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/input/touchscreen/ads7846.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index 652d9bcfdaee..78d7159e92fe 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -993,10 +993,11 @@ static void ads7846_report_state(struct ads7846 *ts)
 		/* compute touch pressure resistance using equation #2 */
 		Rt = z2;
 		Rt -= z1;
-		Rt *= x;
 		Rt *= ts->x_plate_ohms;
+		Rt = DIV_ROUND_CLOSEST(Rt, 16);
+		Rt *= x;
 		Rt /= z1;
-		Rt = (Rt + 2047) >> 12;
+		Rt = DIV_ROUND_CLOSEST(Rt, 256);
 	} else {
 		Rt = 0;
 	}
-- 
2.28.0

