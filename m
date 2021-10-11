Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67E90428DD1
	for <lists+linux-spi@lfdr.de>; Mon, 11 Oct 2021 15:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236901AbhJKNaM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 11 Oct 2021 09:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235427AbhJKNaL (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 11 Oct 2021 09:30:11 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45574C06161C
        for <linux-spi@vger.kernel.org>; Mon, 11 Oct 2021 06:28:11 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mZvLZ-0006g3-Rl; Mon, 11 Oct 2021 15:28:05 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mZvLX-0003nv-7f; Mon, 11 Oct 2021 15:28:03 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mZvLX-0000TG-6f; Mon, 11 Oct 2021 15:28:03 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        kernel@pengutronix.de, linux-serial@vger.kernel.org
Subject: [PATCH 11/13] serial: sc16is7xx: Make sc16is7xx_remove() return void
Date:   Mon, 11 Oct 2021 15:27:52 +0200
Message-Id: <20211011132754.2479853-12-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211011132754.2479853-1-u.kleine-koenig@pengutronix.de>
References: <20211011132754.2479853-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=4Pou8jXQbhOkXAt6/muRjkP0OfJUPHt75pctr7W+qqQ=; m=FIxK0yiWgNMRKKImS8BCXtEUBZW2wFh2le6TX2NO04A=; p=xcjGL8QM0ju7yd9mMj+VQ44EbtM+ByszDKF/lE8HgZk=; g=225f2b3f7950dae6086a79241ab3e42afbf56a88
X-Patch-Sig: m=pgp; i=u.kleine-koenig@pengutronix.de; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmFkO38ACgkQwfwUeK3K7An3SAf+Md4 Byw4aGyMFodFj61gn6trVIWdl0YwUf/cldCbo5kouYfhoQ/q0VDF986ma948oRxpbmHTJeL3+bghL 8DEdVh0gqiMUJ4ltygAQu2hx54UcgUfUiGH9o8RZQVXFK6PtZxAxOGeBIeFRfXFZms4JBNRhY4pvh 2jUY6WIPbl3I/Se2Jvhg4GpNKqLffJTqbehGbab7yECiuSjizieTXSIwbqyGEE61UMFw2PwWB2WRM 1ErBDscPmzQb5bOSU6grlxe1keHL2ZRh3Futtljmf9khvC4YIq+mA5U1irDPu1NGhQkJGm88VGCwv XArVECtjmsWKT1QjX/tzgMmdua9RzpA==
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Up to now sc16is7xx_remove() returns zero unconditionally. Make it
return void instead which makes it easier to see in the callers that
there is no error to handle.

Also the return value of spi remove callbacks is ignored anyway.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/tty/serial/sc16is7xx.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index acbb615dd28f..f8cbe451107b 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -1365,7 +1365,7 @@ static int sc16is7xx_probe(struct device *dev,
 	return ret;
 }
 
-static int sc16is7xx_remove(struct device *dev)
+static void sc16is7xx_remove(struct device *dev)
 {
 	struct sc16is7xx_port *s = dev_get_drvdata(dev);
 	int i;
@@ -1444,7 +1444,9 @@ static int sc16is7xx_spi_probe(struct spi_device *spi)
 
 static int sc16is7xx_spi_remove(struct spi_device *spi)
 {
-	return sc16is7xx_remove(&spi->dev);
+	sc16is7xx_remove(&spi->dev);
+
+	return 0;
 }
 
 static const struct spi_device_id sc16is7xx_spi_id_table[] = {
@@ -1497,7 +1499,9 @@ static int sc16is7xx_i2c_probe(struct i2c_client *i2c,
 
 static int sc16is7xx_i2c_remove(struct i2c_client *client)
 {
-	return sc16is7xx_remove(&client->dev);
+	sc16is7xx_remove(&client->dev);
+
+	return 0;
 }
 
 static const struct i2c_device_id sc16is7xx_i2c_id_table[] = {
-- 
2.30.2

