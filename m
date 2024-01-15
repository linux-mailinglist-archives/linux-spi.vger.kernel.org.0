Return-Path: <linux-spi+bounces-447-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C78E982E17E
	for <lists+linux-spi@lfdr.de>; Mon, 15 Jan 2024 21:21:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C5E81F22D70
	for <lists+linux-spi@lfdr.de>; Mon, 15 Jan 2024 20:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A91199AD;
	Mon, 15 Jan 2024 20:21:13 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60F91947E
	for <linux-spi@vger.kernel.org>; Mon, 15 Jan 2024 20:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rPTSH-0004s6-Ei; Mon, 15 Jan 2024 21:21:09 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rPTSG-0005h7-SS; Mon, 15 Jan 2024 21:21:08 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rPTSG-000N8L-2b;
	Mon, 15 Jan 2024 21:21:08 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Mark Brown <broonie@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-spi@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH 20/33] spi: cavium: Follow renaming of SPI "master" to "controller"
Date: Mon, 15 Jan 2024 21:13:06 +0100
Message-ID:  <0319b271ad74070f1de212c84087db3abdea43c5.1705348270.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1886; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=/Yg1W2WDH9FF1Tn6OXe421fMQlr47i+9fDzZFse2hhA=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlpZHXM2asEBedHf8+o1NK4w6SAfRQULkHfyhPd HcB4AH55p2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZaWR1wAKCRCPgPtYfRL+ TnQSB/40Ih/KaEXh7VKC7cZYB4mQVLbFbI7N8ww02bPOKFX5In5a9eaGxMhok0v5rrv5N0a2qBq MX14hFiX6WZ2FockP0A6MSCUjDK7cQAZeYbSlku4HiMUbL+w2rojuMjr1CJfBGvqrHyfFpOMeEd cKeNrLtL+ada5aPIGcvWEPkw3k3CiRSqTqhgtlcV133a0hPuvfiJYednCYm9NBsfznBzr2x7Gzq kuPMg7d6xCMmBgT6m2yxWjLEPrE0QloHVk8a9yIudJg9g0ZsX/1aBqUFQzYMR2Dxt6RYTyLSDIQ deBpOsmzBcpgCfJTuuSnzDfb6nyv5O8o2qWd1mNNg/TyS3QD
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
 drivers/spi/spi-cavium.c | 6 +++---
 drivers/spi/spi-cavium.h | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-cavium.c b/drivers/spi/spi-cavium.c
index dfe224defd6e..26b8cd1c76e1 100644
--- a/drivers/spi/spi-cavium.c
+++ b/drivers/spi/spi-cavium.c
@@ -124,10 +124,10 @@ static int octeon_spi_do_transfer(struct octeon_spi *p,
 	return xfer->len;
 }
 
-int octeon_spi_transfer_one_message(struct spi_master *master,
+int octeon_spi_transfer_one_message(struct spi_controller *ctlr,
 				    struct spi_message *msg)
 {
-	struct octeon_spi *p = spi_master_get_devdata(master);
+	struct octeon_spi *p = spi_controller_get_devdata(ctlr);
 	unsigned int total_len = 0;
 	int status = 0;
 	struct spi_transfer *xfer;
@@ -145,6 +145,6 @@ int octeon_spi_transfer_one_message(struct spi_master *master,
 err:
 	msg->status = status;
 	msg->actual_length = total_len;
-	spi_finalize_current_message(master);
+	spi_finalize_current_message(ctlr);
 	return status;
 }
diff --git a/drivers/spi/spi-cavium.h b/drivers/spi/spi-cavium.h
index 1f3ac463a20b..af53a0c31476 100644
--- a/drivers/spi/spi-cavium.h
+++ b/drivers/spi/spi-cavium.h
@@ -28,7 +28,7 @@ struct octeon_spi {
 #define OCTEON_SPI_TX(x)	(x->regs.tx)
 #define OCTEON_SPI_DAT0(x)	(x->regs.data)
 
-int octeon_spi_transfer_one_message(struct spi_master *master,
+int octeon_spi_transfer_one_message(struct spi_controller *ctlr,
 				    struct spi_message *msg);
 
 /* MPI register descriptions */
-- 
2.43.0


