Return-Path: <linux-spi+bounces-473-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E394782E1AC
	for <lists+linux-spi@lfdr.de>; Mon, 15 Jan 2024 21:22:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84E93B213A0
	for <lists+linux-spi@lfdr.de>; Mon, 15 Jan 2024 20:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 314751A29C;
	Mon, 15 Jan 2024 20:21:24 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D014F1A588
	for <linux-spi@vger.kernel.org>; Mon, 15 Jan 2024 20:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rPTSJ-00050q-KB; Mon, 15 Jan 2024 21:21:11 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rPTSJ-0005hp-3A; Mon, 15 Jan 2024 21:21:11 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rPTSJ-000N99-02;
	Mon, 15 Jan 2024 21:21:11 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Mark Brown <broonie@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-spi@vger.kernel.org,
	kernel@pengutronix.de,
	Kalle Valo <kvalo@kernel.org>,
	Dmitry Antipov <dmantipov@yandex.ru>,
	Michal Simek <michal.simek@amd.com>,
	Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
	libertas-dev@lists.infradead.org,
	linux-wireless@vger.kernel.org
Subject: [PATCH 30/33] wifi: libertas: Follow renaming of SPI "master" to "controller"
Date: Mon, 15 Jan 2024 21:13:16 +0100
Message-ID:  <ff935c49902f3961b602ae3b47bfe6dd2ceb8405.1705348270.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1120; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=CilgUXn9sYnDzeXUBV/K3zS5xmEAYPQmSA4m63seKdk=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlpZHi9oLLoowITBN5S7io8wKs2b+sTo+Tnck0X PYYVS9ioBuJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZaWR4gAKCRCPgPtYfRL+ Tuc6B/99UXFdbq9RRhmAcP+eXGKu3vvNAzW2hyj2PgdWq/5WkM97mQOeIMcksFoAnxE0HJNPI1u oCt3Zwlk0B8V56WfGHK/rcCsw6CDsu1zy/gZ8HzbQSoJbJZC7oSZeQKJOD/TAJ8SCjRv23xwpU+ scwrox96U29cCMeKG7r/nW+bQ+p1YGCM8ydB/M8e0/3MC14osg+wSUWK4UYmOEU6vnoQnsTxJHR xy1mPr+4Hx3iF0Y1200bnv3f2wfUcw+G68btaKOEF4nOmBGcFXK5YFmsX/ynn31/zJG3hO1eToX w6NNhTx64W8yRc+n/rD/nqCm1vRrRT5tBU0jWJN7kOsg7cBH
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
 drivers/net/wireless/marvell/libertas/if_spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/marvell/libertas/if_spi.c b/drivers/net/wireless/marvell/libertas/if_spi.c
index 8690b0114e23..b722a6587fd3 100644
--- a/drivers/net/wireless/marvell/libertas/if_spi.c
+++ b/drivers/net/wireless/marvell/libertas/if_spi.c
@@ -1052,7 +1052,7 @@ static int if_spi_init_card(struct if_spi_card *card)
 				"attached to SPI bus_num %d, chip_select %d. "
 				"spi->max_speed_hz=%d\n",
 				card->card_id, card->card_rev,
-				card->spi->master->bus_num,
+				card->spi->controller->bus_num,
 				spi_get_chipselect(card->spi, 0),
 				card->spi->max_speed_hz);
 		err = if_spi_prog_helper_firmware(card, helper);
-- 
2.43.0


