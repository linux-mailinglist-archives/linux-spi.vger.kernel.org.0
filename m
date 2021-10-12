Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D19842A880
	for <lists+linux-spi@lfdr.de>; Tue, 12 Oct 2021 17:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237569AbhJLPmI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 12 Oct 2021 11:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237516AbhJLPmC (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 12 Oct 2021 11:42:02 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F96BC061749
        for <linux-spi@vger.kernel.org>; Tue, 12 Oct 2021 08:40:00 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1maJsi-0000Af-3J; Tue, 12 Oct 2021 17:39:56 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1maJsh-0004jq-GW; Tue, 12 Oct 2021 17:39:55 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1maJse-0004Z0-EV; Tue, 12 Oct 2021 17:39:52 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, kernel@pengutronix.de,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org
Subject: [PATCH v2 17/20] serial: max310x: Make max310x_remove() return void
Date:   Tue, 12 Oct 2021 17:39:42 +0200
Message-Id: <20211012153945.2651412-18-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211012153945.2651412-1-u.kleine-koenig@pengutronix.de>
References: <20211012153945.2651412-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=X+8kXHVoMLlUbvR5fe1/gT2QigYKhx+Pwe/X6mIJSOE=; m=dpk5iT4UJQeM0ZBMzrFgdHLqDzvAfkfqyfi4buOfFCI=; p=jl7BJx7UNvJ6kdZKTi6IywhHgXu7PYGvkRZwcI69alQ=; g=2d5080d5848c1455a8b7930e10f4aa7e2d5d4674
X-Patch-Sig: m=pgp; i=u.kleine-koenig@pengutronix.de; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmFlrCwACgkQwfwUeK3K7AnvBQf/Tgu FBpEIBn09cjtcI2Mbyuj3PtePB60usUV774JUBckB/pk27+HIZnAHQeZWarD5TFcTBX4hbeIDAJlp Ck/7mokoMRtq7xGlJW87yRAcS47NQORh9EdDQNR0/CXoBHk6gcBj0Of+jEI4nxw6nRKdConVB7ovo JRnI3LG7sUD/ZakPby+W8zedld/x/46WA/6V0rjHtEdql77QsoBrIA2UW2fIwJwXz40QiHw4WxdA5 VDNZMsvzoUsksqFSDDQB1V8T2oeE77eI4TnaboNCwrG5FxKRUuw/G7ib5s0b50Z+xseWDyQgk0VCT +XVbEQUTa2EqcWeB/KyVwgt6LMSl2/A==
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Up to now max310x_remove() returns zero unconditionally. Make it return
void instead which makes it easier to see in the callers that there is
no error to handle.

Also the return value of spi remove callbacks is ignored anyway.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/tty/serial/max310x.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 3df0788ddeb0..dde0824b2fa5 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -1426,7 +1426,7 @@ static int max310x_probe(struct device *dev, const struct max310x_devtype *devty
 	return ret;
 }
 
-static int max310x_remove(struct device *dev)
+static void max310x_remove(struct device *dev)
 {
 	struct max310x_port *s = dev_get_drvdata(dev);
 	int i;
@@ -1441,8 +1441,6 @@ static int max310x_remove(struct device *dev)
 	}
 
 	clk_disable_unprepare(s->clk);
-
-	return 0;
 }
 
 static const struct of_device_id __maybe_unused max310x_dt_ids[] = {
@@ -1491,7 +1489,8 @@ static int max310x_spi_probe(struct spi_device *spi)
 
 static int max310x_spi_remove(struct spi_device *spi)
 {
-	return max310x_remove(&spi->dev);
+	max310x_remove(&spi->dev);
+	return 0;
 }
 
 static const struct spi_device_id max310x_id_table[] = {
-- 
2.30.2

