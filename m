Return-Path: <linux-spi+bounces-454-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8606082E187
	for <lists+linux-spi@lfdr.de>; Mon, 15 Jan 2024 21:21:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AE561F223F4
	for <lists+linux-spi@lfdr.de>; Mon, 15 Jan 2024 20:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33DE21947B;
	Mon, 15 Jan 2024 20:21:14 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB685199A1
	for <linux-spi@vger.kernel.org>; Mon, 15 Jan 2024 20:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rPTSH-0004v8-U7; Mon, 15 Jan 2024 21:21:09 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rPTSH-0005hM-Fr; Mon, 15 Jan 2024 21:21:09 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rPTSH-000N8h-1J;
	Mon, 15 Jan 2024 21:21:09 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Mark Brown <broonie@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-spi@vger.kernel.org,
	kernel@pengutronix.de,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 23/33] spi: slave-mt27xx: Follow renaming of SPI "master" to "controller"
Date: Mon, 15 Jan 2024 21:13:09 +0100
Message-ID:  <ce0557861684ad5b6c51cf8f537c69b5a59947f1.1705348270.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1009; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=9RamQld7ehDahTK1UAe+GkwrSp24P4ucFsRrUBlQgRI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlpZHaQqGDl7ik5LslfQtscg1JcQlYlHu/HR25p /4gsc45q1+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZaWR2gAKCRCPgPtYfRL+ Tn0oB/9yfU3PrYZgymgA3AjxI3ghhDkjbhz19h9alePBnaKB2qt3J/u/318cz1uV5grRhFgxBAW udtVfwAn/Ls6FT17y0F0k6viqivc1r4PKbUYMUZycFyx/gsoJyh4sQc3+UG4lky+G9CgXInAqUQ cX3yeENuM7DcLWR6q/bqfPr1MKGs1/vWmYAWt5oYAW/4T6K5syMJs1huJhAqXiJaxzhRmky4lRM dFsknCqm8cIn+mHi6VmZvofo4ZD5aRzHt69G3yqz2X4KOkJv76OkA1CcSvK7ys+udvFyPWNa61L 71AO8dSpzIzuHujiofr7V71fWSzLy/nkH25pFTN5j78CcBsQ
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
 drivers/spi/spi-slave-mt27xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-slave-mt27xx.c b/drivers/spi/spi-slave-mt27xx.c
index 6d6772974783..f1ddf4c099a3 100644
--- a/drivers/spi/spi-slave-mt27xx.c
+++ b/drivers/spi/spi-slave-mt27xx.c
@@ -297,7 +297,7 @@ static int mtk_spi_slave_transfer_one(struct spi_controller *ctlr,
 
 static int mtk_spi_slave_setup(struct spi_device *spi)
 {
-	struct mtk_spi_slave *mdata = spi_controller_get_devdata(spi->master);
+	struct mtk_spi_slave *mdata = spi_controller_get_devdata(spi->controller);
 	u32 reg_val;
 
 	reg_val = DMA_DONE_EN | DATA_DONE_EN |
-- 
2.43.0


