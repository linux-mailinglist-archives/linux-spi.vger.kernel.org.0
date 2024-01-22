Return-Path: <linux-spi+bounces-570-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3065837029
	for <lists+linux-spi@lfdr.de>; Mon, 22 Jan 2024 19:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 959A51F28A3F
	for <lists+linux-spi@lfdr.de>; Mon, 22 Jan 2024 18:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 293DD5FDD2;
	Mon, 22 Jan 2024 18:08:24 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C65E5FEEE
	for <linux-spi@vger.kernel.org>; Mon, 22 Jan 2024 18:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705946904; cv=none; b=kQdJkfzz2DcN0D8d/HLnkNbeo8LDadgx9TL/m4J+Cnl3q+t2O04TIdYFYY8BbGCCHYCOKcE8tnVW8Br5sya3wjHMszlsFQiWVYA7JIN/B3sLFaH/gdL54U/MxFqLCg9A0XZicssTqDor9nts9rJLBjc/k7/Iib7Xn2xN1uVvtpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705946904; c=relaxed/simple;
	bh=j7ZdCt52bfgupTBsMJsdZqvductyF9ePTfbsKfhSWaw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L9LtcOmKWo0ka0+7smnGHNARXT2MJVpt6UrpRFqwqQcC1VRE99LslypeHB2cdn1C6yPoz6LZktD7yVbdAhc+NyOoagXInfqVmn6g1x8PpZSx/5fNgcGo0KXwEBJjyrjEGHJBBMp4QFfypDqncEwBZQFwPnk+GvdndmR6CqG4VOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rRyiT-0001le-S5; Mon, 22 Jan 2024 19:08:13 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rRyiT-001ePQ-FH; Mon, 22 Jan 2024 19:08:13 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rRyiT-005Zwz-1G;
	Mon, 22 Jan 2024 19:08:13 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: kernel@pengutronix.de,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org
Subject: [PATCH v2 04/33] Input: pxspad - follow renaming of SPI "master" to "controller"
Date: Mon, 22 Jan 2024 19:06:59 +0100
Message-ID:  <4ac573db17754d4e129e5e3ad7faba98f54e464e.1705944943.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1705944943.git.u.kleine-koenig@pengutronix.de>
References: <cover.1705944943.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1135; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=j7ZdCt52bfgupTBsMJsdZqvductyF9ePTfbsKfhSWaw=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlrq7HQKHmd8SNboMfBioS/1JHaq0PpguJzZP0n dSkJmhchFOJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZa6uxwAKCRCPgPtYfRL+ TktmCACmMb5YxlvAuRoGn28G50wh0HVTREKHav7qWM+YHIJgq/+khqbjYEIjg0SlYrp10GhnrKq QD2uf/GUJmENWm0UIrM3ir37pVsuWs8KI9wsXlyLN15zpEC1fSvV0QRYSU2Q2a5dPQD9hB5uKui jzNnPb4NUSrZa+JHMXvIpWEwNlvm16W3slCAWXs6M69Gbiqgmy92gC/W6OMe8MaOVI4Fc7lacA/ SqFDcrtQayzrq5sZ28M11GF+inlBbVlWt1otr19lYF6R8o7eZMEjUiYvqL/4gpG0iDuT+mzEKeo OV2BEpMVeeL1zMIXjpFJj8N9GRKMqJ8D17VBjdpU6H6t+M0u
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org

In commit 8caab75fd2c2 ("spi: Generalize SPI "master" to "controller"")
some functions and struct members were renamed. To not break all drivers
compatibility macros were provided.

To be able to remove these compatibility macros push the renaming into
this driver.

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/input/joystick/psxpad-spi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/joystick/psxpad-spi.c b/drivers/input/joystick/psxpad-spi.c
index de734a927b4d..c47fc5f34bd0 100644
--- a/drivers/input/joystick/psxpad-spi.c
+++ b/drivers/input/joystick/psxpad-spi.c
@@ -342,8 +342,8 @@ static int psxpad_spi_probe(struct spi_device *spi)
 	spi->mode = SPI_MODE_3;
 	spi->bits_per_word = 8;
 	/* (PlayStation 1/2 joypad might be possible works 250kHz/500kHz) */
-	spi->master->min_speed_hz = 125000;
-	spi->master->max_speed_hz = 125000;
+	spi->controller->min_speed_hz = 125000;
+	spi->controller->max_speed_hz = 125000;
 	spi_setup(spi);
 
 	/* pad settings */
-- 
2.43.0


