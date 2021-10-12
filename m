Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2178042A88E
	for <lists+linux-spi@lfdr.de>; Tue, 12 Oct 2021 17:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237612AbhJLPmQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 12 Oct 2021 11:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237589AbhJLPmJ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 12 Oct 2021 11:42:09 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9119DC061772
        for <linux-spi@vger.kernel.org>; Tue, 12 Oct 2021 08:40:05 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1maJsn-0000Nb-27; Tue, 12 Oct 2021 17:40:01 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1maJsl-0004mD-Rx; Tue, 12 Oct 2021 17:39:59 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1maJse-0004Z3-JJ; Tue, 12 Oct 2021 17:39:52 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, kernel@pengutronix.de,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org
Subject: [PATCH v2 18/20] serial: sc16is7xx: Make sc16is7xx_remove() return void
Date:   Tue, 12 Oct 2021 17:39:43 +0200
Message-Id: <20211012153945.2651412-19-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211012153945.2651412-1-u.kleine-koenig@pengutronix.de>
References: <20211012153945.2651412-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=4Pou8jXQbhOkXAt6/muRjkP0OfJUPHt75pctr7W+qqQ=; m=FIxK0yiWgNMRKKImS8BCXtEUBZW2wFh2le6TX2NO04A=; p=Y2/spG10FZuOVKKCfBzsrca0ACgAG7pF66CtGegD8JQ=; g=4125ad5aa361e24225170e3f9083b1a39652127c
X-Patch-Sig: m=pgp; i=u.kleine-koenig@pengutronix.de; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmFlrC8ACgkQwfwUeK3K7AkSPAf+LMT SgAFO3tZNZZ1LDwGN+CELqcna7S0o6KZVS00mDiv8s1CojK3MIWyqch1Qt1dv03uGl6MUqIMNknYN CPS/0qOSDITDrdtaCQmyXaL03YjZcVdj7nH7PscGQfpvE2CgllPJZG5GJ4HRjN88uucr3iwtd6kId 4b4VXSYei502hNrn8MxaAtbyNbLEjbc6iSH+Bs6QEVHSG6a5tcwkgsH+VIuGhPXCepjei/FeW6gI/ utPuAxfrrEDaubt+MG6Go7cq34GUyVHjOLC5xSZU1sqYrP6qAMUCyJrLyfDqXXC5KSpZtrXm3ZJ2D YwkzB3dbDGyCUsp01wa3Mtbz7LNTamQ==
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
 drivers/tty/serial/sc16is7xx.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index acbb615dd28f..64e7e6c8145f 100644
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
@@ -1385,8 +1385,6 @@ static int sc16is7xx_remove(struct device *dev)
 	kthread_stop(s->kworker_task);
 
 	clk_disable_unprepare(s->clk);
-
-	return 0;
 }
 
 static const struct of_device_id __maybe_unused sc16is7xx_dt_ids[] = {
@@ -1444,7 +1442,9 @@ static int sc16is7xx_spi_probe(struct spi_device *spi)
 
 static int sc16is7xx_spi_remove(struct spi_device *spi)
 {
-	return sc16is7xx_remove(&spi->dev);
+	sc16is7xx_remove(&spi->dev);
+
+	return 0;
 }
 
 static const struct spi_device_id sc16is7xx_spi_id_table[] = {
@@ -1497,7 +1497,9 @@ static int sc16is7xx_i2c_probe(struct i2c_client *i2c,
 
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

