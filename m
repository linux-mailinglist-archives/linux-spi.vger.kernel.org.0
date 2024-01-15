Return-Path: <linux-spi+bounces-442-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B96F182E17A
	for <lists+linux-spi@lfdr.de>; Mon, 15 Jan 2024 21:21:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61D591F22CFC
	for <lists+linux-spi@lfdr.de>; Mon, 15 Jan 2024 20:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A168E1947C;
	Mon, 15 Jan 2024 20:21:11 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00B918C08
	for <linux-spi@vger.kernel.org>; Mon, 15 Jan 2024 20:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rPTSD-0004fz-Ve; Mon, 15 Jan 2024 21:21:05 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rPTSD-0005g8-Ic; Mon, 15 Jan 2024 21:21:05 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rPTSD-000N7J-1a;
	Mon, 15 Jan 2024 21:21:05 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Mark Brown <broonie@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-spi@vger.kernel.org,
	kernel@pengutronix.de,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org
Subject: [PATCH 04/33] Input: pxspad - follow renaming of SPI "master" to "controller"
Date: Mon, 15 Jan 2024 21:12:50 +0100
Message-ID:  <5e05e8f918ba1f026b9967b0aaff5403a35cbf13.1705348269.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1705348269.git.u.kleine-koenig@pengutronix.de>
References: <cover.1705348269.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1080; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=GBiDbTv4I8SusnZruVIRNdgTUy9UKrF5KoYuPLnKuME=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlpZHFMTn39PajEktNiUDzev913UA/1Q2crqck7 J6AuwTTOLOJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZaWRxQAKCRCPgPtYfRL+ TvUMB/0Y3lPe5wsQdiPSrJuDJcJiv/O7gL3o1T7GFQm2iQSpSL1A7BNk3INW8nRQ5CUnGad6SES N0WkbrKxKhkzFUESVvQT/kTi8/5WixTceU3MBgiDjxEMWD+x9wRDn158cQV/+HdP0HWaHaNEKqd 9U5IC+5mycpOdgYfL9GYSwlsgmWFL+BhR9gwmF65DtKcFa0NArGTQ3sfcLt4xPYPPKa3mbi/x43 baAe34n5A+RUfL1xEhB6coHzrsYBPxBUDi5z5HOkTbzdt5nA/TLIKsEXBX+3e2VXFVw1Px2j1NC PAMkpCnoUj91GwnApRfjiqJ8IIvU6NCPKvj2O3Qk4vzVENTF
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


