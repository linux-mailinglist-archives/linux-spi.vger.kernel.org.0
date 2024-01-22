Return-Path: <linux-spi+bounces-588-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 93ACE8371E0
	for <lists+linux-spi@lfdr.de>; Mon, 22 Jan 2024 20:07:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04AE1B24B4D
	for <lists+linux-spi@lfdr.de>; Mon, 22 Jan 2024 18:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF1661694;
	Mon, 22 Jan 2024 18:08:39 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238BA629FD
	for <linux-spi@vger.kernel.org>; Mon, 22 Jan 2024 18:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705946919; cv=none; b=Q55srtJWjBQN665hOUIRBgl46KDBPHQlBhv2PiFgmxOe/FkcBsqktc805OiY3pYv4Kapx3SSKpWUBSxZWY1uzk8W3FEESI1yaZVs6mu+JLSdvX/v5ycith3quJ+tCGboUm3UqYIUpHmuYciD119m/lXXPdzDHMzZPJ3hZqnXiSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705946919; c=relaxed/simple;
	bh=RZvYfTlU/4VH1OArpbwo3y/uz1FTbk44tCVZsUBiwns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FCCCjk2zBCISfT4PbWZQHUJ+PNBDeGO24UptTfVbnDFI4OD1Up856TfIk5qeVTTYBwsdczVrH98hsah4YFCp4/oGfweKiHhMJwoeB2w7ivc0uaACZNx1rbOd+cP9tpC/Ie3kbd7TVFACl50KlDWie0y1Ry/Sr0yUM9qDS3MFyHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rRyiV-0001q8-HH; Mon, 22 Jan 2024 19:08:15 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rRyiV-001ePq-0v; Mon, 22 Jan 2024 19:08:15 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rRyiU-005ZxR-33;
	Mon, 22 Jan 2024 19:08:14 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: kernel@pengutronix.de,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Yang Yingliang <yangyingliang@huawei.com>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org
Subject: [PATCH v2 11/33] mmc: mmc_spi: Follow renaming of SPI "master" to "controller"
Date: Mon, 22 Jan 2024 19:07:06 +0100
Message-ID:  <13ba99e2578d4448fd85f516fbe328f5d05eda05.1705944943.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1575; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=RZvYfTlU/4VH1OArpbwo3y/uz1FTbk44tCVZsUBiwns=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlrq7PRw7TChDVEykUOUq5M7YoRpsevn+zMTYJs hN9mKylAViJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZa6uzwAKCRCPgPtYfRL+ TiN0B/wOu1KLBD9+KdV1G22LTlGmGCJ+mdVJ2VljDSCHlKk6wX+Xlfg9aNuMzu7NuiQBYi+k6kF 2ooN3LdUgNfSWMdMl4uh5UloS99FziZ3YZ5YYLvcffLhCT6E57IWNB9/bD7RfxQ/24u//kf7Bqr j7IUqPWyPUX+K5JIfQSNQTI5NI1Rgbd51gjdAzphXn5of6QD+bOUSffOiP7APFcgDatPQ0Zbq3S grvQjUAMI7kiZWF421cO22SoVODsu6hnVMpjTF2RRNXl+YCg6TL8mSIqcYlYDurIZKJLu3/7bIS Hk3q4BnvSgHvKxVwmP9oovvhCAGCmOLZ+d5Qacoljqigp9j1
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


