Return-Path: <linux-spi+bounces-459-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B162482E190
	for <lists+linux-spi@lfdr.de>; Mon, 15 Jan 2024 21:21:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 603C42838DD
	for <lists+linux-spi@lfdr.de>; Mon, 15 Jan 2024 20:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F6E199C4;
	Mon, 15 Jan 2024 20:21:16 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E369B199BD
	for <linux-spi@vger.kernel.org>; Mon, 15 Jan 2024 20:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rPTSF-0004gq-2t; Mon, 15 Jan 2024 21:21:07 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rPTSE-0005gP-MC; Mon, 15 Jan 2024 21:21:06 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rPTSE-000N7d-1x;
	Mon, 15 Jan 2024 21:21:06 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Mark Brown <broonie@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-spi@vger.kernel.org,
	kernel@pengutronix.de,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org
Subject: [PATCH 09/33] media: v4l2-subdev: Follow renaming of SPI "master" to "controller"
Date: Mon, 15 Jan 2024 21:12:55 +0100
Message-ID:  <a71f64cbd6da8670498e03cf2762f69d26738c95.1705348269.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2489; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=8dv/wBsJwJ3/ohbuVOHTuYVGhoSkMc8iB3lWpL8EkJg=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlpZHLgzBKZildNpjvaT1coOoquLHRENs6MD3MT sOpsxNkZuaJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZaWRywAKCRCPgPtYfRL+ TnGdB/9j2Yxl1DMrTjLF1q3TTyxA0r2zPaE3U9TaNmiEYp8U68CJ8iR8VvI8/45+QL86/IgXP4F 0ndN7yjs5BurQMxvy6UngvV1fyYAqiflO+65SzTIUq/jSIWUL6/2629tV2mLsemYhIgcXkVHknI lI0MgAwvBNih03dFteaqintOYZqts+HQkW7+rHQJtfpxjAD7KSTu1SBkP3nIU4fnJvm70hffWR6 qB/ti+qS8scoFPxA4IhWaNBVrZYf6pu0c1FNI0EzvXvhF7WxZ9sUU+WN8TTADl828z1A2hMF+TQ Jov1zWObQLr6wbQu5ifeUHREWqNWUbPTMm3fxIv7IujfVmkT
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
v4l2_spi_new_subdev().

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/media/v4l2-core/v4l2-spi.c | 4 ++--
 include/media/v4l2-common.h        | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-spi.c b/drivers/media/v4l2-core/v4l2-spi.c
index eadecdff7349..a7092c3930d6 100644
--- a/drivers/media/v4l2-core/v4l2-spi.c
+++ b/drivers/media/v4l2-core/v4l2-spi.c
@@ -34,7 +34,7 @@ void v4l2_spi_subdev_init(struct v4l2_subdev *sd, struct spi_device *spi,
 EXPORT_SYMBOL_GPL(v4l2_spi_subdev_init);
 
 struct v4l2_subdev *v4l2_spi_new_subdev(struct v4l2_device *v4l2_dev,
-					struct spi_master *master,
+					struct spi_controller *ctlr,
 					struct spi_board_info *info)
 {
 	struct v4l2_subdev *sd = NULL;
@@ -45,7 +45,7 @@ struct v4l2_subdev *v4l2_spi_new_subdev(struct v4l2_device *v4l2_dev,
 	if (info->modalias[0])
 		request_module(info->modalias);
 
-	spi = spi_new_device(master, info);
+	spi = spi_new_device(ctlr, info);
 
 	if (!spi || !spi->dev.driver)
 		goto error;
diff --git a/include/media/v4l2-common.h b/include/media/v4l2-common.h
index acf5be24a5ca..739b0f0fc1a0 100644
--- a/include/media/v4l2-common.h
+++ b/include/media/v4l2-common.h
@@ -278,13 +278,13 @@ static inline void v4l2_i2c_subdev_unregister(struct v4l2_subdev *sd)
  *
  *
  * @v4l2_dev: pointer to &struct v4l2_device.
- * @master: pointer to struct spi_master.
+ * @ctlr: pointer to struct spi_controller.
  * @info: pointer to struct spi_board_info.
  *
  * returns a &struct v4l2_subdev pointer.
  */
 struct v4l2_subdev *v4l2_spi_new_subdev(struct v4l2_device *v4l2_dev,
-		struct spi_master *master, struct spi_board_info *info);
+		struct spi_controller *ctlr, struct spi_board_info *info);
 
 /**
  * v4l2_spi_subdev_init - Initialize a v4l2_subdev with data from an
@@ -308,7 +308,7 @@ void v4l2_spi_subdev_unregister(struct v4l2_subdev *sd);
 
 static inline struct v4l2_subdev *
 v4l2_spi_new_subdev(struct v4l2_device *v4l2_dev,
-		    struct spi_master *master, struct spi_board_info *info)
+		    struct spi_controller *ctlr, struct spi_board_info *info)
 {
 	return NULL;
 }
-- 
2.43.0


