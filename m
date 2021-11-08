Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 486BC447CDD
	for <lists+linux-spi@lfdr.de>; Mon,  8 Nov 2021 10:32:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238427AbhKHJex (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 8 Nov 2021 04:34:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238443AbhKHJex (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 8 Nov 2021 04:34:53 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35151C061746
        for <linux-spi@vger.kernel.org>; Mon,  8 Nov 2021 01:32:09 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mk10S-0007gP-Q1; Mon, 08 Nov 2021 10:32:00 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mk10R-0005Zh-0a; Mon, 08 Nov 2021 10:31:59 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mk10Q-0001EZ-Vh; Mon, 08 Nov 2021 10:31:58 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-mtd@lists.infradead.org,
        kernel@pengutronix.de, linux-spi@vger.kernel.org
Subject: [PATCH 4/4] mtd: sst25l: Warn about failure to unregister mtd device
Date:   Mon,  8 Nov 2021 10:31:52 +0100
Message-Id: <20211108093153.63792-4-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211108093153.63792-1-u.kleine-koenig@pengutronix.de>
References: <20211108093153.63792-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=chTrsNwtyvGFDidu8JfqkR8D1NeBCtiv8G0Xdn/Msdg=; m=7KSLr5cayipWkedCHz7+d6af4pRbjwTwvLxY0jhuRso=; p=GyFyjTLYPEwkTCbq/a6e00IrkhK4nCV0ABnVgGp+m+w=; g=6b042ce343cc284fe221ab7a9db5771a78afa793
X-Patch-Sig: m=pgp; i=u.kleine-koenig@pengutronix.de; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmGI7oUACgkQwfwUeK3K7AlbVAf+JKt +Jh1O3wHjvHkmmzbNPD9RLyL8VD2Uw0RBt7eWa80liNL4AYJP8MxcmZ7GmECL0UGgDKh/1aEOKvhj ywLbU0w6kaploF2/XU4WuYQUqWjRfm0cnihU6+dNz5x8zTbj18/YVwjOSb92eutPYg3SbgjlSdeqt qbf8XN6vitfl2utFti32McIfA4bRwZkGu2tzbVeF2ZJ5iz5cednguwT0O2MHBn4e1H2rhWJ2QfCno DcCffcYS2f6M2o+rVoLHcpxiMYw/eLTuprG9JFIP1oLEg+GaPoy7lUaSFPlnKLDaXK12JGkGXyHwd HzV6nXRbijB639b4mLtWy0/pR2Nl37Q==
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
 drivers/mtd/devices/sst25l.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/devices/sst25l.c b/drivers/mtd/devices/sst25l.c
index b81c3f0b85f9..7f124c1bfa40 100644
--- a/drivers/mtd/devices/sst25l.c
+++ b/drivers/mtd/devices/sst25l.c
@@ -402,7 +402,9 @@ static int sst25l_remove(struct spi_device *spi)
 {
 	struct sst25l_flash *flash = spi_get_drvdata(spi);
 
-	return mtd_device_unregister(&flash->mtd);
+	WARN_ON(mtd_device_unregister(&flash->mtd));
+
+	return 0;
 }
 
 static struct spi_driver sst25l_driver = {
-- 
2.30.2

