Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A931142A88D
	for <lists+linux-spi@lfdr.de>; Tue, 12 Oct 2021 17:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237609AbhJLPmP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 12 Oct 2021 11:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237586AbhJLPmJ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 12 Oct 2021 11:42:09 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 190A5C06176F
        for <linux-spi@vger.kernel.org>; Tue, 12 Oct 2021 08:40:05 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1maJsl-0000JF-BY; Tue, 12 Oct 2021 17:39:59 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1maJsk-0004lk-Iw; Tue, 12 Oct 2021 17:39:58 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1maJsd-0004Yj-Eg; Tue, 12 Oct 2021 17:39:51 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Mark Brown <broonie@kernel.org>, kernel@pengutronix.de,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org
Subject: [PATCH v2 14/20] mtd: mchp23k256: Warn about failure to unregister mtd device
Date:   Tue, 12 Oct 2021 17:39:39 +0200
Message-Id: <20211012153945.2651412-15-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211012153945.2651412-1-u.kleine-koenig@pengutronix.de>
References: <20211012153945.2651412-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=oQ0rhox5HEbwbc0e75w1kKEc23U+uF8p5JmZ7F33OK0=; m=aWXlVn4zGl3/VNxE8xQ1auTXzJiWk3xyQCYCHspYcNI=; p=qd3VQORiTd+2PycmNSRq+P7NPYQTqLjcNuVof7YmoX0=; g=e977070b7429d85799af28daa3a1f14654179392
X-Patch-Sig: m=pgp; i=u.kleine-koenig@pengutronix.de; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmFlrCMACgkQwfwUeK3K7AkE9wgAjcV V25oLZh1d0i5sng1FwvkK7nUZrkAggWQIZnkEIvV87joBYdT9N3wcykRaiPSqPqlfvDLpSdPbAYJV YQDkg6CmVGTDbhevroZRbc2I2mA+Nt534QSMFfI8HQbpvKDnQ5ofK5cRwSWyIUqP3iMAmYbqajPJO 2am5RkRd0bMcfqleNz3EkRZJh0VRa8+QV9RoorgZcVD9Te0P/Pc4DAIdQoYUq30/Ds+KHlygdZ8K/ Lsrvg58v220dWxA11N6s6LUgs+dxW+evdpSCf9CBWJWSF2wS26AjH7mNvbfSfUc1quNeI1y7sAmgH 4Z+KdkTnr0/E6PMEl7/F0wC+EvzJrnA==
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
 drivers/mtd/devices/mchp23k256.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/devices/mchp23k256.c b/drivers/mtd/devices/mchp23k256.c
index 77c872fd3d83..23213009ebf4 100644
--- a/drivers/mtd/devices/mchp23k256.c
+++ b/drivers/mtd/devices/mchp23k256.c
@@ -212,8 +212,15 @@ static int mchp23k256_probe(struct spi_device *spi)
 static int mchp23k256_remove(struct spi_device *spi)
 {
 	struct mchp23k256_flash *flash = spi_get_drvdata(spi);
+	int ret;
 
-	return mtd_device_unregister(&flash->mtd);
+	ret = mtd_device_unregister(&flash->mtd);
+	if (ret)
+		/* There is nothing we can do about this ... */
+		dev_warn(&spi->dev, "Failed to unregister mtd device (%pe)\n",
+			 ERR_PTR(ret));
+
+	return 0;
 }
 
 static const struct of_device_id mchp23k256_of_table[] = {
-- 
2.30.2

