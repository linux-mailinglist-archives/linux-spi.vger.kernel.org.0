Return-Path: <linux-spi+bounces-466-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9EE482E19E
	for <lists+linux-spi@lfdr.de>; Mon, 15 Jan 2024 21:21:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47911283A48
	for <lists+linux-spi@lfdr.de>; Mon, 15 Jan 2024 20:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9629B1A287;
	Mon, 15 Jan 2024 20:21:21 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4163F19BC3
	for <linux-spi@vger.kernel.org>; Mon, 15 Jan 2024 20:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rPTSI-0004wZ-EL; Mon, 15 Jan 2024 21:21:10 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rPTSI-0005hV-0n; Mon, 15 Jan 2024 21:21:10 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rPTSH-000N8p-31;
	Mon, 15 Jan 2024 21:21:09 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Mark Brown <broonie@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-spi@vger.kernel.org,
	kernel@pengutronix.de,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: [PATCH 25/33] staging: fbtft: Follow renaming of SPI "master" to "controller"
Date: Mon, 15 Jan 2024 21:13:11 +0100
Message-ID:  <2923cec8eb74faac402829c4a23924172fb45afd.1705348270.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1528; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=lOy0ZmteWVnevRjqTgakjKZrayLKgyaWmhHjW/PK3Qc=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlpZHdnr1kpa5k34D1tGioHPl52Mnujy5CauC27 wH+AvA+PKeJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZaWR3QAKCRCPgPtYfRL+ TtG3B/wLStjmUoP56nH4s+nP5OOX/bzz3eKeekQFvQNDC2baOmKDIyyXNXGDwu/hhy7EduEnJyG Z8MUz7opl7TUi4HmFHmD8548sEBauUhC/U9w/96UPBlyeOU/4sA+p5HOizN3ug4UWOOVhqGJt2i ycYsBn5SiwITGQEwhNCt5tU5qjcojxtmjgsOEBI8xWq+jdQn2n2zwYkqoeAjzKuLtFyBVsUwmqI pIJ6m8BC6lVS5BWUlVfee/zbematoQqJZlM1WOG2AkADQsBdLAMVJwafzz93oEMNl2KMFjtKdAp DX8fUbcR6+HE4EeJrre1g2GsE7xeU13pxwhkyupDEeMIlLjg
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
 drivers/staging/fbtft/fbtft-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/fbtft-core.c
index 3626f429b002..68add4d598ae 100644
--- a/drivers/staging/fbtft/fbtft-core.c
+++ b/drivers/staging/fbtft/fbtft-core.c
@@ -794,7 +794,7 @@ int fbtft_register_framebuffer(struct fb_info *fb_info)
 	if (par->txbuf.buf && par->txbuf.len >= 1024)
 		sprintf(text1, ", %zu KiB buffer memory", par->txbuf.len >> 10);
 	if (spi)
-		sprintf(text2, ", spi%d.%d at %d MHz", spi->master->bus_num,
+		sprintf(text2, ", spi%d.%d at %d MHz", spi->controller->bus_num,
 			spi_get_chipselect(spi, 0), spi->max_speed_hz / 1000000);
 	dev_info(fb_info->dev,
 		 "%s frame buffer, %dx%d, %d KiB video memory%s, fps=%lu%s\n",
@@ -1215,7 +1215,7 @@ int fbtft_probe_common(struct fbtft_display *display,
 
 	/* 9-bit SPI setup */
 	if (par->spi && display->buswidth == 9) {
-		if (par->spi->master->bits_per_word_mask & SPI_BPW_MASK(9)) {
+		if (par->spi->controller->bits_per_word_mask & SPI_BPW_MASK(9)) {
 			par->spi->bits_per_word = 9;
 		} else {
 			dev_warn(&par->spi->dev,
-- 
2.43.0


