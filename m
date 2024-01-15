Return-Path: <linux-spi+bounces-450-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D16C82E183
	for <lists+linux-spi@lfdr.de>; Mon, 15 Jan 2024 21:21:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 373F52839AF
	for <lists+linux-spi@lfdr.de>; Mon, 15 Jan 2024 20:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775B619474;
	Mon, 15 Jan 2024 20:21:13 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04E118E10
	for <linux-spi@vger.kernel.org>; Mon, 15 Jan 2024 20:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rPTSG-0004jL-Lh; Mon, 15 Jan 2024 21:21:08 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rPTSF-0005ge-C4; Mon, 15 Jan 2024 21:21:07 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rPTSF-000N7p-0v;
	Mon, 15 Jan 2024 21:21:07 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Mark Brown <broonie@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-spi@vger.kernel.org,
	kernel@pengutronix.de,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	Amit Kumar Mahapatra via Alsa-devel <alsa-devel@alsa-project.org>,
	Rob Herring <robh@kernel.org>,
	linux-mtd@lists.infradead.org
Subject: [PATCH 12/33] mtd: dataflash: Follow renaming of SPI "master" to "controller"
Date: Mon, 15 Jan 2024 21:12:58 +0100
Message-ID:  <dadd7809d39bda45c346dc010a007eb8b7707ead.1705348269.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1009; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=NBOC25sdOvGb/9mPNsZnEncAlQwVHEMnCLFxkavQ8DQ=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlpZHO1546ROlSg4IwL5Nl4cW9AxZKJYgKHTTOm ptOAn78pR6JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZaWRzgAKCRCPgPtYfRL+ TtK2B/4m/EDE1YiTTcFS+L3STkuUIse8eSozSn4xhjWuyJm5huJdmM7H5+bFYSC5YIEObhnwPg4 xr2xzftWbnQ/VtNpnwuU6AOyigJkufWXmemQlmDtCPAWVdka+Tx6Y6yWq9plllSJqM8051TdNkD 1O2/1egsUrQyGP6l/brBKcGuUM9N9AeG68mqIl+mVuIg9TgZSIRuGgZh1jhBxBeV1zBnUw9oJ1f 4G6e6kpbwaqgMQ37sHv1+Y3dDjc51lhbBo+EHwLnuYpQyGdbkYUKB7X8gj8sOOYKWNlKS/FSgjW TV4eEGo/Ns6ugCeWovquJDEbF6zl0OqoRYWG/mS2YO+czJxz
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
 drivers/mtd/devices/mtd_dataflash.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/devices/mtd_dataflash.c b/drivers/mtd/devices/mtd_dataflash.c
index 0c1b93303618..ec52277e3dd5 100644
--- a/drivers/mtd/devices/mtd_dataflash.c
+++ b/drivers/mtd/devices/mtd_dataflash.c
@@ -638,7 +638,7 @@ static int add_dataflash_otp(struct spi_device *spi, char *name, int nr_pages,
 
 	/* name must be usable with cmdlinepart */
 	sprintf(priv->name, "spi%d.%d-%s",
-			spi->master->bus_num, spi_get_chipselect(spi, 0),
+			spi->controller->bus_num, spi_get_chipselect(spi, 0),
 			name);
 
 	device = &priv->mtd;
-- 
2.43.0


