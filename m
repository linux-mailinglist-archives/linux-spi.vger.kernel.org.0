Return-Path: <linux-spi+bounces-595-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2765F837165
	for <lists+linux-spi@lfdr.de>; Mon, 22 Jan 2024 19:59:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4B98B2BD02
	for <lists+linux-spi@lfdr.de>; Mon, 22 Jan 2024 18:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FDB356772;
	Mon, 22 Jan 2024 18:08:44 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1452565BB5
	for <linux-spi@vger.kernel.org>; Mon, 22 Jan 2024 18:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705946924; cv=none; b=NIpjnzkJNNpbvKHCJ7q/RSRg7x0JPvaN61ei6RKee82qGIs8Lw8o0AC1TbQfasvV9s4VUNLUODVEeazcpQPEEFbjUrPyU7iicqWwzIU724qk7c5A1dVUYRRSBjjWGKCxTl6OaI1rpzNSj9EJj1vFrVhqfjYbO5zq2rjUbvgfigQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705946924; c=relaxed/simple;
	bh=lOy0ZmteWVnevRjqTgakjKZrayLKgyaWmhHjW/PK3Qc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g7M7uNjPawvf4U/QXed1EYFRt80qmp6SJS8gPUHnVCj7SQPs/1+4cAqcZCkkk8Sg/rMrRcr7Qs+4cZoUMawc3F58uKa9+t2sKl0tYSpEi5wFIjkxvX1WLEWqs5fgC1H5UD1FYkITy865WTS5c2XMJY+SYBvhS7RA1pHj+XAU0jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rRyiY-000241-Lm; Mon, 22 Jan 2024 19:08:18 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rRyiX-001eQl-Sf; Mon, 22 Jan 2024 19:08:17 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rRyiX-005ZyV-2Y;
	Mon, 22 Jan 2024 19:08:17 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: kernel@pengutronix.de,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Michal Simek <michal.simek@amd.com>,
	Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org
Subject: [PATCH v2 25/33] staging: fbtft: Follow renaming of SPI "master" to "controller"
Date: Mon, 22 Jan 2024 19:07:20 +0100
Message-ID:  <d486dbb16fafd93a00013a555658a44e975115fd.1705944943.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1528; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=lOy0ZmteWVnevRjqTgakjKZrayLKgyaWmhHjW/PK3Qc=; b=owGbwMvMwMXY3/A7olbonx/jabUkhtR16x44W9/NuexwblKQkcS2eVqdtoxbE2pDa9aufl5So 2JbWHW/k9GYhYGRi0FWTJHFvnFNplWVXGTn2n+XYQaxMoFMYeDiFICJaJuy/zPf0hzD7Xv4XKXA nQ6hKVGCW43/JecF+faw5V2NSIoNXsY1YXm5nNmKKXYS9S8/vzK3nqp7b/PuUv2k5Fr/uGi+iYk nRQOq5/1Ju/K3+FpTk6CUztH44uiXBidcPY35T7bUy7OLrlX7kmPMuK3qWlVDzGuZvLeyUys+CV jbmHIyudxnZTBm6Mr6J8NRU3ApZIrZUb0DvtxGJ3tbfiipm7WV3O01e1/XPOGttuSslTFNkw9fW fdbyTzk8m2bdvVZKRlHXymr7pNt/zLdkuNl7BH1axK6mlZ7c+e8FmvuvPv2cnWky+cFBw+kyu/f kx8wb/oBxd/OjJdPGrkpsT18+rHxpmd+6jLx6yzJbwsB
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


