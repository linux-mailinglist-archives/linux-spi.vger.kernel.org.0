Return-Path: <linux-spi+bounces-453-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A382082E186
	for <lists+linux-spi@lfdr.de>; Mon, 15 Jan 2024 21:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52F0128389A
	for <lists+linux-spi@lfdr.de>; Mon, 15 Jan 2024 20:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA431199BE;
	Mon, 15 Jan 2024 20:21:13 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8011947B
	for <linux-spi@vger.kernel.org>; Mon, 15 Jan 2024 20:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rPTSF-0004h0-8r; Mon, 15 Jan 2024 21:21:07 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rPTSE-0005gT-SC; Mon, 15 Jan 2024 21:21:06 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rPTSE-000N7h-2Y;
	Mon, 15 Jan 2024 21:21:06 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Mark Brown <broonie@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-spi@vger.kernel.org,
	kernel@pengutronix.de,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 10/33] misc: gehc-achc: Follow renaming of SPI "master" to "controller"
Date: Mon, 15 Jan 2024 21:12:56 +0100
Message-ID:  <005f7bb9f5642332114b5a73603c2736d9d2814d.1705348269.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1529; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=+Bwcd8J9EIWwY/Wo93zN3hICZCIsRFvVUKS8EPmC1YE=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlpZHMPCMtR38pN77/2O+jL7cr+QMFZ7IQAG4HT dEKzr/0me6JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZaWRzAAKCRCPgPtYfRL+ Tvj3B/0fsurSMoftmHOUZ9bYtVVJR26tyJXXVruEHCAFZ6Jesqse/0MFFcCb545BAl0aYzur1dI rwp2kMZe+XeU8gmcSisyZ0sJYUi0Q/HTixnulAZJB1OFTixEpVMyjWyVVoQn14rJU7npEEWwibD kvDS9L/Sg32t/bsy4m+Y6u6jo0YC5T0dVEFUQIVBTiRcBDaUDoYxFYeyQExDwjJd1wspWz1N0oj 2wB3x8xW645SRF1Qzemh40Czb/02NEPG5kOGKOoErJnj4eNRrtY6rSpkR/9tWsFOUTER7JIkZ/c +f0Tf7KiBCdZtKWKNlu4ymkx+cbUdxygMfu6rID7IoQZLadA
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
 drivers/misc/gehc-achc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/gehc-achc.c b/drivers/misc/gehc-achc.c
index 4c9c5394da6f..b8fca4d393c6 100644
--- a/drivers/misc/gehc-achc.c
+++ b/drivers/misc/gehc-achc.c
@@ -65,7 +65,7 @@ static int ezport_start_programming(struct spi_device *spi, struct gpio_desc *re
 	struct spi_transfer release_cs = { };
 	int ret;
 
-	spi_bus_lock(spi->master);
+	spi_bus_lock(spi->controller);
 
 	/* assert chip select */
 	spi_message_init(&msg);
@@ -85,16 +85,16 @@ static int ezport_start_programming(struct spi_device *spi, struct gpio_desc *re
 	ret = spi_sync_locked(spi, &msg);
 
 fail:
-	spi_bus_unlock(spi->master);
+	spi_bus_unlock(spi->controller);
 	return ret;
 }
 
 static void ezport_stop_programming(struct spi_device *spi, struct gpio_desc *reset)
 {
 	/* reset without asserted chip select to return into normal mode */
-	spi_bus_lock(spi->master);
+	spi_bus_lock(spi->controller);
 	ezport_reset(reset);
-	spi_bus_unlock(spi->master);
+	spi_bus_unlock(spi->controller);
 }
 
 static int ezport_get_status_register(struct spi_device *spi)
-- 
2.43.0


