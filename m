Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4444428DE3
	for <lists+linux-spi@lfdr.de>; Mon, 11 Oct 2021 15:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236908AbhJKNaQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 11 Oct 2021 09:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236903AbhJKNaO (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 11 Oct 2021 09:30:14 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5EA3C061570
        for <linux-spi@vger.kernel.org>; Mon, 11 Oct 2021 06:28:14 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mZvLe-0006zS-QG; Mon, 11 Oct 2021 15:28:10 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mZvLe-0003q0-7R; Mon, 11 Oct 2021 15:28:10 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mZvLX-0000TD-0n; Mon, 11 Oct 2021 15:28:03 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        kernel@pengutronix.de, linux-serial@vger.kernel.org
Subject: [PATCH 10/13] serial: max310x: Make max310x_remove() return void
Date:   Mon, 11 Oct 2021 15:27:51 +0200
Message-Id: <20211011132754.2479853-11-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211011132754.2479853-1-u.kleine-koenig@pengutronix.de>
References: <20211011132754.2479853-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=X+8kXHVoMLlUbvR5fe1/gT2QigYKhx+Pwe/X6mIJSOE=; m=dpk5iT4UJQeM0ZBMzrFgdHLqDzvAfkfqyfi4buOfFCI=; p=HDDe0QrqWRt0vbskO76Khh8QYm1eskoN+UZ3rYfyYwc=; g=d3271e01aa79a69bc5924cb1e77423071fb1b679
X-Patch-Sig: m=pgp; i=u.kleine-koenig@pengutronix.de; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmFkO3wACgkQwfwUeK3K7AmJnwf9Ea1 vQnAeKXPnlIfoyEyyWQLrDc+YItsj00J0fg12+rklq7GFvjo6JOgBKFNq48qx0G5MHvu99kThTOus 08HsoBrd0KAWNyikfrNzwPGXrm0px235/iQ+Ub2LZ6sp+4VSErmEnLouqJNTn/FPInwvTCdDH9rP7 NbYcterOwYPgCaBewKZqRwKsOBDUAuVB2R0Akd+sA6N7qFu5yRi+mJ7XjMRwHPhbwpF9vSlsIR/QI hHnwUlG8H9pqHHK+t+y6Ke6nRUjkCZujtCP/lu3pj4ZAoEwd7OcHUOLKSg1piqwo1uE2js02q65i+ 4Ps/+jLM8XPWGsGfaZb78U1iL7DRALQ==
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
index 3df0788ddeb0..6816eeb1ffef 100644
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
+	return 0
 }
 
 static const struct spi_device_id max310x_id_table[] = {
-- 
2.30.2

