Return-Path: <linux-spi+bounces-444-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 33FA982E17F
	for <lists+linux-spi@lfdr.de>; Mon, 15 Jan 2024 21:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40828B20E9B
	for <lists+linux-spi@lfdr.de>; Mon, 15 Jan 2024 20:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D322199A2;
	Mon, 15 Jan 2024 20:21:12 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CAAA1864D
	for <linux-spi@vger.kernel.org>; Mon, 15 Jan 2024 20:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rPTSG-0004ob-JC; Mon, 15 Jan 2024 21:21:08 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rPTSG-0005gr-0y; Mon, 15 Jan 2024 21:21:08 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rPTSF-000N85-33;
	Mon, 15 Jan 2024 21:21:07 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Mark Brown <broonie@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-spi@vger.kernel.org,
	kernel@pengutronix.de,
	Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Guenter Roeck <groeck@chromium.org>,
	chrome-platform@lists.linux.dev
Subject: [PATCH 16/33] platform/chrome: cros_ec_spi: Follow renaming of SPI "master" to "controller"
Date: Mon, 15 Jan 2024 21:13:02 +0100
Message-ID:  <8ae71cbe62a853fcb7546e79bc319556855c3800.1705348269.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1795; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=JZwbpbkMvs4lQTImHxlzDToQ730IN3XwQ44L9olrdkQ=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlpZHTLSauBM7HX8UqoMkcUFLs7XMX2h0z7kY0E Pilkgd0mROJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZaWR0wAKCRCPgPtYfRL+ TjXpCACy+MtD+WbJd4fqp8ge0gBhaDUaN+u6Hyvd4CpQYDUdv1NpzEMDzxk0h63IE/8PoYediV2 +3ceGcwmezj70LdDnBTQ6NXZ6oqpmQ+O7f2jYEAUT7NUpFfRzgIthYOP4Llr4hTehgs4/10Kjpb eztrWPSsZ71WvsYlvQ1RN6ViwVpnIjMKAnlbbj6jx5uxndaifHIAy1nMY0PWhDBZtFGROU3dmYe a5IDhQCki35JDOFH3Lm2M35J/Ne610H7lRRhRW5gxkeWuw7nCuuAixOL69DHkNwIk6xy2eWZaDk JFxiZzUsqMG90YD4HiyKG8lUGLmtxIpbx4je0JXwQXjPTedF
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
 drivers/platform/chrome/cros_ec_spi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_spi.c b/drivers/platform/chrome/cros_ec_spi.c
index 3e88cc92e819..86a3d32a7763 100644
--- a/drivers/platform/chrome/cros_ec_spi.c
+++ b/drivers/platform/chrome/cros_ec_spi.c
@@ -409,7 +409,7 @@ static int do_cros_ec_pkt_xfer_spi(struct cros_ec_device *ec_dev,
 	if (!rx_buf)
 		return -ENOMEM;
 
-	spi_bus_lock(ec_spi->spi->master);
+	spi_bus_lock(ec_spi->spi->controller);
 
 	/*
 	 * Leave a gap between CS assertion and clocking of data to allow the
@@ -469,7 +469,7 @@ static int do_cros_ec_pkt_xfer_spi(struct cros_ec_device *ec_dev,
 
 	final_ret = terminate_request(ec_dev);
 
-	spi_bus_unlock(ec_spi->spi->master);
+	spi_bus_unlock(ec_spi->spi->controller);
 
 	if (!ret)
 		ret = final_ret;
@@ -554,7 +554,7 @@ static int do_cros_ec_cmd_xfer_spi(struct cros_ec_device *ec_dev,
 	if (!rx_buf)
 		return -ENOMEM;
 
-	spi_bus_lock(ec_spi->spi->master);
+	spi_bus_lock(ec_spi->spi->controller);
 
 	/* Transmit phase - send our message */
 	debug_packet(ec_dev->dev, "out", ec_dev->dout, len);
@@ -590,7 +590,7 @@ static int do_cros_ec_cmd_xfer_spi(struct cros_ec_device *ec_dev,
 
 	final_ret = terminate_request(ec_dev);
 
-	spi_bus_unlock(ec_spi->spi->master);
+	spi_bus_unlock(ec_spi->spi->controller);
 
 	if (!ret)
 		ret = final_ret;
-- 
2.43.0


