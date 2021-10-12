Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1370342A894
	for <lists+linux-spi@lfdr.de>; Tue, 12 Oct 2021 17:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237516AbhJLPmY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 12 Oct 2021 11:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237554AbhJLPmQ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 12 Oct 2021 11:42:16 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC583C061570
        for <linux-spi@vger.kernel.org>; Tue, 12 Oct 2021 08:40:14 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1maJst-0000ht-RM; Tue, 12 Oct 2021 17:40:07 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1maJst-0004mQ-1I; Tue, 12 Oct 2021 17:40:07 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1maJsd-0004Ym-Ja; Tue, 12 Oct 2021 17:39:51 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Colin Ian King <colin.king@canonical.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Fabio Estevam <festevam@gmail.com>,
        Heiko Schocher <hs@denx.de>, Mark Brown <broonie@kernel.org>,
        kernel@pengutronix.de, linux-mtd@lists.infradead.org,
        linux-spi@vger.kernel.org
Subject: [PATCH v2 15/20] mtd: mchp48l640: Warn about failure to unregister mtd device
Date:   Tue, 12 Oct 2021 17:39:40 +0200
Message-Id: <20211012153945.2651412-16-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211012153945.2651412-1-u.kleine-koenig@pengutronix.de>
References: <20211012153945.2651412-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=KPueYbzN9LsEzHTCniRvcOu6N1K1tzW4s5WqwnR8va8=; m=aWXlVn4zGl3/VNxE8xQ1auTXzJiWk3xyQCYCHspYcNI=; p=FVG/f8D5OMv+6zHQi0LEySf59uooBM1A6otMYWx90Jo=; g=6463cff8dfe6da637770875deae96bedaf2afd8a
X-Patch-Sig: m=pgp; i=u.kleine-koenig@pengutronix.de; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmFlrCYACgkQwfwUeK3K7An3Nwf/WXu jfvNabwoFPSNIxb8bkOy5RAOhKb23xPLjHY4UjV+pX+ycBjJrnh4F4HTJGUCg+CVbiL6L8y9cTPS4 FmdhdkenR90XYefsNf7ZJdCfLxIWQu4A9W67wDs4VX6wU16g+D9G40Q2qQtjD4hmecoKIkvNxx9yR PrMfF++7OQQPIECqBy1mQpXvAJ+GI0qBhYnwJntJ3vjpJf4djt6wzwLM0vx1mw7SFD9E5UPAthfe+ VcB51aDJh0iehgoZ6usEprA9E9wcndz48jDsvC4DB6pYt1mAVc8/9GdAgfpk6zJHGi5Cq0EdnHwdi iqVWyiWwbXZkgjekoF7f/IRsvEuUK9Q==
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
 drivers/mtd/devices/mchp48l640.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/devices/mchp48l640.c b/drivers/mtd/devices/mchp48l640.c
index 99400d0fb8c1..b87f7eca3e64 100644
--- a/drivers/mtd/devices/mchp48l640.c
+++ b/drivers/mtd/devices/mchp48l640.c
@@ -344,8 +344,14 @@ static int mchp48l640_probe(struct spi_device *spi)
 static int mchp48l640_remove(struct spi_device *spi)
 {
 	struct mchp48l640_flash *flash = spi_get_drvdata(spi);
+	int ret;
+
+	ret = mtd_device_unregister(&flash->mtd);
+	if (ret)
+		dev_warn(&spi->dev, "Failed to unregister mtd device (%pe)\n",
+			 ERR_PTR(ret));
 
-	return mtd_device_unregister(&flash->mtd);
+	return 0;
 }
 
 static const struct of_device_id mchp48l640_of_table[] = {
-- 
2.30.2

