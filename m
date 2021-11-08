Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1642D447CDF
	for <lists+linux-spi@lfdr.de>; Mon,  8 Nov 2021 10:32:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238443AbhKHJey (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 8 Nov 2021 04:34:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238447AbhKHJex (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 8 Nov 2021 04:34:53 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B971C061764
        for <linux-spi@vger.kernel.org>; Mon,  8 Nov 2021 01:32:09 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mk10S-0007gM-Q1; Mon, 08 Nov 2021 10:32:00 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mk10Q-0005ZY-IF; Mon, 08 Nov 2021 10:31:58 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mk10Q-0001E2-HC; Mon, 08 Nov 2021 10:31:58 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-mtd@lists.infradead.org,
        kernel@pengutronix.de, linux-spi@vger.kernel.org
Subject: [PATCH 1/4] mtd: dataflash: Warn about failure to unregister mtd device
Date:   Mon,  8 Nov 2021 10:31:49 +0100
Message-Id: <20211108093153.63792-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=2VqFZIno/yGWsKtWn0NIvGoO0BsdZpAyUJM3JsTcgVQ=; m=7KSLr5cayipWkedCHz7+d6af4pRbjwTwvLxY0jhuRso=; p=dp+d9QTfUVIlCaBs3wY1yKyRjs7CL31c/ZsgBiAwaOo=; g=e364a11306a2fa96d20bff34d5a4eb2b8e9f1f6d
X-Patch-Sig: m=pgp; i=u.kleine-koenig@pengutronix.de; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmGI7ncACgkQwfwUeK3K7AmbDQf/ZUY 7/ChKRQDpyu4txJFq3DpQaEpdIKV1t/C8DVyqVOXaHcVWBRNkuHLxwJKKqBYfp/fMRQANwLyaCAcf qUgCnxzuvqHFrj4d4NSYtJGl/6UAMRmaRvaRtfNsaqiU3E0J6lf4DNKR5g9/0oCSSKQij/FWmYtAn z4J3u2AZ46TtqrI/ORKTz0gCX+KG/rl+IA3FpHJxECBvRvQwF7vqDJNscgFgTzGK0tljgsZgA0of6 fd1jrJnnudtJyyVA1kTZHpR1qC3VlfU859ng6hMfl3Sa7mu1pPPXTn3lAUcfReRkGPD9SzSBnBzaK ijplz+6fNtXdNsBc/wRsYdKHosWy74A==
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
 drivers/mtd/devices/mtd_dataflash.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/devices/mtd_dataflash.c b/drivers/mtd/devices/mtd_dataflash.c
index 9802e265fca8..293cab758299 100644
--- a/drivers/mtd/devices/mtd_dataflash.c
+++ b/drivers/mtd/devices/mtd_dataflash.c
@@ -912,14 +912,14 @@ static int dataflash_probe(struct spi_device *spi)
 static int dataflash_remove(struct spi_device *spi)
 {
 	struct dataflash	*flash = spi_get_drvdata(spi);
-	int			status;
 
 	dev_dbg(&spi->dev, "remove\n");
 
-	status = mtd_device_unregister(&flash->mtd);
-	if (status == 0)
-		kfree(flash);
-	return status;
+	WARN_ON(mtd_device_unregister(&flash->mtd));
+
+	kfree(flash);
+
+	return 0;
 }
 
 static struct spi_driver dataflash_driver = {

base-commit: 6b75d88fa81b122cce37ebf17428a849ccd3d0f1
-- 
2.30.2

