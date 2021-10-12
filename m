Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56D1C42A872
	for <lists+linux-spi@lfdr.de>; Tue, 12 Oct 2021 17:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237486AbhJLPl7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 12 Oct 2021 11:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237463AbhJLPl5 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 12 Oct 2021 11:41:57 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1388EC061570
        for <linux-spi@vger.kernel.org>; Tue, 12 Oct 2021 08:39:56 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1maJsd-0008NQ-Up; Tue, 12 Oct 2021 17:39:52 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1maJsb-0004ib-Ab; Tue, 12 Oct 2021 17:39:49 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1maJsb-0004Xk-9i; Tue, 12 Oct 2021 17:39:49 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>, kernel@pengutronix.de,
        linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org
Subject: [PATCH v2 03/20] gpio: mc33880: Drop if with an always false condition
Date:   Tue, 12 Oct 2021 17:39:28 +0200
Message-Id: <20211012153945.2651412-4-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211012153945.2651412-1-u.kleine-koenig@pengutronix.de>
References: <20211012153945.2651412-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=U928Zsjke4PePvMRBLGBdH7AFPIzISeqQDiRVuernkA=; m=KxvpK5Ffg66PylsxXar0DvY3vkY/yY2nG7ASvrBO71A=; p=CeVmNWRKcwk9K6MjZI6ZUG5Bs+V4ag4EumMETP3nWgo=; g=d918bff0a84daefa24b904c36ae4cfaf68e06a4f
X-Patch-Sig: m=pgp; i=u.kleine-koenig@pengutronix.de; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmFlrAEACgkQwfwUeK3K7AnyWAf/cY7 yIK3QC8W2j0EfS6xGFjlrb+SfAplc0oqDaUPqZQC2ZAoLPzzEQ/ToYVRaa7pvxDaQGDzA1zCJW6Zm GgQlxiRoDQjrYRswm323xiICx5ecoy5l/sdVEJ1kXl5gIsVaDC70yYV/b6BiCIQiAoo8WofQcThJV Rx2SY2ABGCtwiPvugTbVuMDdA87UfYSaKseBBa4QzoJhaU9A2zMFitBmrI9V+NjkTLgdlxJtq+i// fnOjLcdeu6Z/LRjIf3QW2PQhf+3pagEBk0SV/IEejaVOtKkU9w9BX98YREH3zAZc30CApRlv1wF9h pF8risKiCCfCChA2ivow4xtXn/989Ew==
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

An spi remove callback is only called for devices that probed
successfully. In this case this implies that mc33880_probe() set a
non-NULL driver data. So the check for mc being NULL is never true and
the check can be dropped.

Also the return value ofspi remove callbacks is ignored anyway.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/gpio/gpio-mc33880.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpio/gpio-mc33880.c b/drivers/gpio/gpio-mc33880.c
index f8194f7c6186..31d2be1bebc8 100644
--- a/drivers/gpio/gpio-mc33880.c
+++ b/drivers/gpio/gpio-mc33880.c
@@ -139,8 +139,6 @@ static int mc33880_remove(struct spi_device *spi)
 	struct mc33880 *mc;
 
 	mc = spi_get_drvdata(spi);
-	if (!mc)
-		return -ENODEV;
 
 	gpiochip_remove(&mc->chip);
 	mutex_destroy(&mc->lock);
-- 
2.30.2

