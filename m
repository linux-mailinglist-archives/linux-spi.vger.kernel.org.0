Return-Path: <linux-spi+bounces-470-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53CF082E1A1
	for <lists+linux-spi@lfdr.de>; Mon, 15 Jan 2024 21:22:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E22D82839DF
	for <lists+linux-spi@lfdr.de>; Mon, 15 Jan 2024 20:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F021A58A;
	Mon, 15 Jan 2024 20:21:22 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D15519BDE
	for <linux-spi@vger.kernel.org>; Mon, 15 Jan 2024 20:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rPTSH-0004hQ-3u; Mon, 15 Jan 2024 21:21:09 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rPTSF-0005gZ-33; Mon, 15 Jan 2024 21:21:07 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rPTSF-000N7l-02;
	Mon, 15 Jan 2024 21:21:07 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Mark Brown <broonie@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-spi@vger.kernel.org,
	kernel@pengutronix.de,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Yang Yingliang <yangyingliang@huawei.com>,
	linux-mmc@vger.kernel.org
Subject: [PATCH 11/33] mmc: mmc_spi: Follow renaming of SPI "master" to "controller"
Date: Mon, 15 Jan 2024 21:12:57 +0100
Message-ID:  <2fbecfecf3daaf71a23f2b3c4cc8b738a521fb5b.1705348269.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1575; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=RZvYfTlU/4VH1OArpbwo3y/uz1FTbk44tCVZsUBiwns=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlpZHNaEO8X/EFYRsBBCDuYpPFclmRsvJHLmRJG msWKxLO7EaJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZaWRzQAKCRCPgPtYfRL+ Tom5B/9k0LOFrE+3EyUqbULWNrXdSqYfYkYKbLJxYdpML0y4/Qc2uIN0/6q04sYkKAHpM0Xp8fv sNAZbhmogxw2hbs+HMswln/XCCRCx+gwG2iuCDFF8BBf3QueFe/WURvqkU97szLFrQ4xENLjUYo ReBy/0rwnpqmHvwFzU/G9ORwQ6RvjJe2IM0szqrMGtY8oInQrhWGpPXRbJqzyr2hbsfyDcie8Ab P3wvw9NhKp3ogI+pEtoDgMzWLyLMBsszcngGUq2WPiKf1yZzC7DTGPp2uBfcdtbEnlIveksKk53 xxn+kEkluM2VIMDQrgKbK7WdWK4l2+Zh6Oib5s06HhWYygR8
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
 drivers/mmc/host/mmc_spi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
index b8dda8160c4e..bf35761f783a 100644
--- a/drivers/mmc/host/mmc_spi.c
+++ b/drivers/mmc/host/mmc_spi.c
@@ -935,7 +935,7 @@ static void mmc_spi_request(struct mmc_host *mmc, struct mmc_request *mrq)
 #endif
 
 	/* request exclusive bus access */
-	spi_bus_lock(host->spi->master);
+	spi_bus_lock(host->spi->controller);
 
 crc_recover:
 	/* issue command; then optionally data and stop */
@@ -967,7 +967,7 @@ static void mmc_spi_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	}
 
 	/* release the bus */
-	spi_bus_unlock(host->spi->master);
+	spi_bus_unlock(host->spi->controller);
 
 	mmc_request_done(host->mmc, mrq);
 }
@@ -1157,7 +1157,7 @@ static int mmc_spi_probe(struct spi_device *spi)
 	/* We rely on full duplex transfers, mostly to reduce
 	 * per-transfer overheads (by making fewer transfers).
 	 */
-	if (spi->master->flags & SPI_CONTROLLER_HALF_DUPLEX)
+	if (spi->controller->flags & SPI_CONTROLLER_HALF_DUPLEX)
 		return -EINVAL;
 
 	/* MMC and SD specs only seem to care that sampling is on the
-- 
2.43.0


