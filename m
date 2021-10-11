Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17A68428DCC
	for <lists+linux-spi@lfdr.de>; Mon, 11 Oct 2021 15:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236883AbhJKNaL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 11 Oct 2021 09:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235427AbhJKNaK (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 11 Oct 2021 09:30:10 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FBD3C061570
        for <linux-spi@vger.kernel.org>; Mon, 11 Oct 2021 06:28:10 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mZvLZ-0006fl-Rm; Mon, 11 Oct 2021 15:28:05 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mZvLV-0003nm-Pk; Mon, 11 Oct 2021 15:28:01 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mZvLV-0000SY-Or; Mon, 11 Oct 2021 15:28:01 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Michael Hennerich <michael.hennerich@analog.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        kernel@pengutronix.de, linux-input@vger.kernel.org
Subject: [PATCH 03/13] hwmon: max31722: Warn about failure to put device in stand-by in .remove()
Date:   Mon, 11 Oct 2021 15:27:44 +0200
Message-Id: <20211011132754.2479853-4-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211011132754.2479853-1-u.kleine-koenig@pengutronix.de>
References: <20211011132754.2479853-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=VzmQt12yOkne619FyHfm2Mxhtg4zmARLaeg/MgRfc80=; m=aWXlVn4zGl3/VNxE8xQ1auTXzJiWk3xyQCYCHspYcNI=; p=bBkC2gJ5XT8B1VAvVS6dFZGhwZYy9lCY9z6NFqcALPQ=; g=d02ecae4dfa3faae03d9f4b8b4e5ec93f10e7ffd
X-Patch-Sig: m=pgp; i=u.kleine-koenig@pengutronix.de; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmFkO2cACgkQwfwUeK3K7AkJkQf/d8U yHMvMyz0ffMQjQqW0ADJLpB09mX0yAHgIaaD4LM5FukQm4eIXs4cEegpUVbDEmv6gkX46ywqsYIyL 7ViGaPQvWOoKtazVkw/TURoUQQtyA5BCMEkbt/EiODDmVjFv2cWZ1cVEJrixcM+HRJKX8ItVBps9N 7DylYuo97rM8xeiO9WKhUNQWgMdhO6HFknydofJzV23cwjwdTbmdRgcsiy+3sNQb7CwN7WfsPKlQM gygO4cB2Snbqpo/rHigiIFO9u2MwgghN/F/IhsonfsaLPNpb3XVet7SuKygejaa0J2nvOHRC0MKD7 wEbm9VTQ9Q3ZmabMsuc4hHyv+VrzIWQ==
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
 drivers/hwmon/max31722.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/max31722.c b/drivers/hwmon/max31722.c
index 613338cbcb17..4cf4fe6809a3 100644
--- a/drivers/hwmon/max31722.c
+++ b/drivers/hwmon/max31722.c
@@ -103,10 +103,16 @@ static int max31722_probe(struct spi_device *spi)
 static int max31722_remove(struct spi_device *spi)
 {
 	struct max31722_data *data = spi_get_drvdata(spi);
+	int ret;
 
 	hwmon_device_unregister(data->hwmon_dev);
 
-	return max31722_set_mode(data, MAX31722_MODE_STANDBY);
+	ret = max31722_set_mode(data, MAX31722_MODE_STANDBY);
+	if (ret)
+		/* There is nothing we can do about this ... */
+		dev_warn(&spi->dev, "Failed to put device in stand-by mode\n");
+
+	return 0;
 }
 
 static int __maybe_unused max31722_suspend(struct device *dev)
-- 
2.30.2

