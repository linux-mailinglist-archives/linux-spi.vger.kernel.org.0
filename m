Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEB8A42A893
	for <lists+linux-spi@lfdr.de>; Tue, 12 Oct 2021 17:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237576AbhJLPmX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 12 Oct 2021 11:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237516AbhJLPmQ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 12 Oct 2021 11:42:16 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F03C061765
        for <linux-spi@vger.kernel.org>; Tue, 12 Oct 2021 08:40:14 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1maJst-0000hT-Hg; Tue, 12 Oct 2021 17:40:07 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1maJss-0004mN-PB; Tue, 12 Oct 2021 17:40:06 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1maJsd-0004Yg-AC; Tue, 12 Oct 2021 17:39:51 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        kernel@pengutronix.de, linux-mtd@lists.infradead.org,
        linux-spi@vger.kernel.org
Subject: [PATCH v2 13/20] mtd: dataflash: Warn about failure to unregister mtd device
Date:   Tue, 12 Oct 2021 17:39:38 +0200
Message-Id: <20211012153945.2651412-14-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211012153945.2651412-1-u.kleine-koenig@pengutronix.de>
References: <20211012153945.2651412-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=2VqFZIno/yGWsKtWn0NIvGoO0BsdZpAyUJM3JsTcgVQ=; m=aWXlVn4zGl3/VNxE8xQ1auTXzJiWk3xyQCYCHspYcNI=; p=16dswzFeECicSzBQSJ0SvtjK+opu7BN5qXI4WIJZwCw=; g=4c0006553a00ca9772c08d8155c3e429fb469b7b
X-Patch-Sig: m=pgp; i=u.kleine-koenig@pengutronix.de; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmFlrCAACgkQwfwUeK3K7Alhzgf7Bnt 6NQEigDpsGNLR4Myl4ULhsm8W+utz3BBsS3tu1LnZ0L+/KEVHfNOrQ1S+vkblFJ6JY0R69KN47agg y59Tdik0oGDpjLURzS6MdNk+Q4/5zZo6vX82yM08oabjCPkJh/FDMxB4P7MEVE0WDgyeXdGmqJdwH KqyUh4HH8dv8ZM/ph+H0TBSnPnY//97FeHPY8hLaOac4rWkk8yusOkaS3mz+05oXoQz4k7oKKHftH q9TzY9yMqAIIHGgRPze5NgG7Q4O4QyG7h0E0Sv2b2NFMIlTw87Ky3BsxvqbVTxa/u/t66ZODGiUgc oP+AB9hEZN4JtSTDgGIGBTUa8DyJk9A==
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

When an spi driver's remove function returns a non-zero error code
nothing happens apart from emitting a generic error message. Make this
error message more device specific and return zero instead.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/mtd/devices/mtd_dataflash.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/devices/mtd_dataflash.c b/drivers/mtd/devices/mtd_dataflash.c
index 9802e265fca8..2691b6b79df8 100644
--- a/drivers/mtd/devices/mtd_dataflash.c
+++ b/drivers/mtd/devices/mtd_dataflash.c
@@ -919,7 +919,10 @@ static int dataflash_remove(struct spi_device *spi)
 	status = mtd_device_unregister(&flash->mtd);
 	if (status == 0)
 		kfree(flash);
-	return status;
+	else
+		dev_warn(&spi->dev, "Failed to unregister mtd device (%pe)\n",
+			 ERR_PTR(status));
+	return 0;
 }
 
 static struct spi_driver dataflash_driver = {
-- 
2.30.2

