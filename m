Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0A8D447CDE
	for <lists+linux-spi@lfdr.de>; Mon,  8 Nov 2021 10:32:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238442AbhKHJex (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 8 Nov 2021 04:34:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238445AbhKHJex (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 8 Nov 2021 04:34:53 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B460C061570
        for <linux-spi@vger.kernel.org>; Mon,  8 Nov 2021 01:32:09 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mk10S-0007gO-Q1; Mon, 08 Nov 2021 10:32:00 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mk10Q-0005Ze-S4; Mon, 08 Nov 2021 10:31:58 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mk10Q-0001EO-Ql; Mon, 08 Nov 2021 10:31:58 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-mtd@lists.infradead.org,
        kernel@pengutronix.de, linux-spi@vger.kernel.org
Subject: [PATCH 3/4] mtd: mchp48l640: Warn about failure to unregister mtd device
Date:   Mon,  8 Nov 2021 10:31:51 +0100
Message-Id: <20211108093153.63792-3-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211108093153.63792-1-u.kleine-koenig@pengutronix.de>
References: <20211108093153.63792-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=KPueYbzN9LsEzHTCniRvcOu6N1K1tzW4s5WqwnR8va8=; m=7KSLr5cayipWkedCHz7+d6af4pRbjwTwvLxY0jhuRso=; p=hGZdSTOrMcSxD0z98kFDa/PL7nWvDIhwAQlm55SyVEI=; g=055d2b75ea63c5577b57932fc070711b7ba69e95
X-Patch-Sig: m=pgp; i=u.kleine-koenig@pengutronix.de; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmGI7oEACgkQwfwUeK3K7AnCygf8Dvv 9ndtG9tZ7CfbWkaaldDLo9S8zeI9cjSH1ILmHhH5XoB1+01J+bSPIA2T4VVrhjTKn0ze+QygwTjxy Z/c7rsPvfJQqA7q7eBJqvcH0R5k3nK7VR42MKtLVLmE0NyyBtwfH5TawTRFEMsWULtj080rK3hZjz B+Zc2qMFm45vTEd0x+WDVru3VuPHOodiNfy7J2UGOg6J53v8Tz6wm3WjWqoeX2bmLjUR9Z4J8LQyD ACxuGKYP5vANDkeRdlZRkFJxu0X9YzCuRqwOz1AveL2jSLIvJo34PW20xiMPZqrAXiqMT9+vE4OFk 3cZaItlaSbGQ7D6cVimnFy/lvux7l7A==
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

mtd_device_unregister() shouldn't fail. Wail loudly if it does anyhow.

This matches how other drivers (e.g. nand/raw/nandsim.c) use
mtd_device_unregister().

By returning 0 in the spi remove callback a generic error message by the
spi framework (and nothing else) is suppressed.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/mtd/devices/mchp48l640.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/devices/mchp48l640.c b/drivers/mtd/devices/mchp48l640.c
index 99400d0fb8c1..231a10790196 100644
--- a/drivers/mtd/devices/mchp48l640.c
+++ b/drivers/mtd/devices/mchp48l640.c
@@ -345,7 +345,9 @@ static int mchp48l640_remove(struct spi_device *spi)
 {
 	struct mchp48l640_flash *flash = spi_get_drvdata(spi);
 
-	return mtd_device_unregister(&flash->mtd);
+	WARN_ON(mtd_device_unregister(&flash->mtd));
+
+	return 0;
 }
 
 static const struct of_device_id mchp48l640_of_table[] = {
-- 
2.30.2

