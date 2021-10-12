Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC28842A884
	for <lists+linux-spi@lfdr.de>; Tue, 12 Oct 2021 17:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237542AbhJLPmK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 12 Oct 2021 11:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237537AbhJLPmC (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 12 Oct 2021 11:42:02 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA44C061753
        for <linux-spi@vger.kernel.org>; Tue, 12 Oct 2021 08:40:00 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1maJse-0008NW-M2; Tue, 12 Oct 2021 17:39:52 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1maJsd-0004in-Ps; Tue, 12 Oct 2021 17:39:51 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1maJsd-0004Yp-Om; Tue, 12 Oct 2021 17:39:51 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Mark Brown <broonie@kernel.org>, kernel@pengutronix.de,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org
Subject: [PATCH v2 16/20] mtd: sst25l: Warn about failure to unregister mtd device
Date:   Tue, 12 Oct 2021 17:39:41 +0200
Message-Id: <20211012153945.2651412-17-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211012153945.2651412-1-u.kleine-koenig@pengutronix.de>
References: <20211012153945.2651412-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=chTrsNwtyvGFDidu8JfqkR8D1NeBCtiv8G0Xdn/Msdg=; m=aWXlVn4zGl3/VNxE8xQ1auTXzJiWk3xyQCYCHspYcNI=; p=TyuS/iMN/2qfQLKMz56PvUq4wtcc0B7f+zs42TknICw=; g=c6b8458784ebb8ccbecde25a4af573d5e8fd863b
X-Patch-Sig: m=pgp; i=u.kleine-koenig@pengutronix.de; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmFlrCkACgkQwfwUeK3K7AnDkQf+Nb3 3j5Jgm1majYjJ+sScbZ2HOkWGFVOQWeTvYfeytVvtxml2BbCSUhRa60oI3pnRl8KZpf1LSPtBx0Lv gw0p6PqXhs0kpkFsu1zukS4yPR4O6U+11E+3KrCQvgpXZtpIEuMYwdqirjME5jbPloH2LftzFCXeT C85UknBWop/d3AD0ivfVGL7M8x7iMrhPacg6H8/x6CoOp9UyiWor0X9qahA3FpnSQBd1SmA8HhPoO 2jnNcag0IBYeCs08IYABkj1kdMk3CFurya0dEyMO774G3TwA+fP+nWl2cZRZKf6iKGPzY98B9xCVZ sh77HoYmLIWw5+szDsL7QgTVpm7ueDA==
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
 drivers/mtd/devices/sst25l.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/devices/sst25l.c b/drivers/mtd/devices/sst25l.c
index b81c3f0b85f9..04062a1f54c1 100644
--- a/drivers/mtd/devices/sst25l.c
+++ b/drivers/mtd/devices/sst25l.c
@@ -401,8 +401,14 @@ static int sst25l_probe(struct spi_device *spi)
 static int sst25l_remove(struct spi_device *spi)
 {
 	struct sst25l_flash *flash = spi_get_drvdata(spi);
+	int ret;
+
+	ret = mtd_device_unregister(&flash->mtd);
+	if (ret)
+		dev_warn(&spi->dev, "Failed to unregister mtd device (%pe)\n",
+			 ERR_PTR(ret));
 
-	return mtd_device_unregister(&flash->mtd);
+	return 0;
 }
 
 static struct spi_driver sst25l_driver = {
-- 
2.30.2

