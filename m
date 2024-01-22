Return-Path: <linux-spi+bounces-580-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5158183703D
	for <lists+linux-spi@lfdr.de>; Mon, 22 Jan 2024 19:40:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73E341C2461C
	for <lists+linux-spi@lfdr.de>; Mon, 22 Jan 2024 18:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5CA6612E2;
	Mon, 22 Jan 2024 18:08:33 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDADD60DCF
	for <linux-spi@vger.kernel.org>; Mon, 22 Jan 2024 18:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705946913; cv=none; b=XKnxsgW8g0G0kFQIbG405jGmLCVJh9/GaA9Wgkk+KaAGIDix/iJlwErRDtXU0qBe2UDdiEPHPDnHk8O3OqfzmFLbQzpgDmUFzc71Un5mshDXV9FF9aicM0Xmrusgo2ZpU4ypFZivdc5eFEvMr6QeGQ91mRLHrp29gXGF6JdLCtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705946913; c=relaxed/simple;
	bh=zq/qJ/QhNsYPPrMwXZxXmfl47w4IeV+ODr7f9syERGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dGZCFwPlNsoUfb9HGDuxJ2oWKJLvP6Jairw0MTC9cgxugq2JAcrn9rI8QXnNZjVVbWtc6qr2AFKxxe1oGeZ3OY+NI4Z9ZT7Fg/VIYpBhhZewXhkZPRcXeK075dwPriMzMARq6Nm8ikRatrXjgVLRjgfCMw7XMsQsNJylv7TX9/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rRyiU-0001oO-Pk; Mon, 22 Jan 2024 19:08:14 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rRyiU-001ePe-CQ; Mon, 22 Jan 2024 19:08:14 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rRyiU-005ZxF-0y;
	Mon, 22 Jan 2024 19:08:14 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: kernel@pengutronix.de,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org
Subject: [PATCH v2 08/33] media: usb/msi2500: Follow renaming of SPI "master" to "controller"
Date: Mon, 22 Jan 2024 19:07:03 +0100
Message-ID:  <b666aa9ea77e06e63b1cbff8040d668761708b59.1705944943.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3895; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=zq/qJ/QhNsYPPrMwXZxXmfl47w4IeV+ODr7f9syERGc=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlrq7MyQtm95Z78AlId2rx6OCofZnNoQNH5RZaU cxk3NqKHv2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZa6uzAAKCRCPgPtYfRL+ Tm+eB/9b9pLwClCQ8kIXH0ADcGCwCmzGT0KvKnp6SPDiPdw2qE3OvUIe3IoNF54Mwy/6nQSWf7B P2ns8tvH/iJQrsGf45V8RaFx7Z6QTWB9Py4bwzinJbcap2Px6u8KRu5XQYvA8ObVsF7Q6mJ7Fvi MVtDqD3yg+coF6FtIUKBdXzq2gEX4X+8ZQl4PbVnbQec/MSN+pvk6az+RQcws0mg2h7fu2oOHNW UDCj6jmIo7Itl/SxOrdY2o4ker1tChVsYjwJ+YZroWHYI4Wyp2jtj4HvU40yV0qy56+pubFNg+u UAdn9fKy6h+wIh+7ExY9cher3uXGXlwkcbqpCmI3p660oGvE
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
 drivers/media/usb/msi2500/msi2500.c | 38 ++++++++++++++---------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/media/usb/msi2500/msi2500.c b/drivers/media/usb/msi2500/msi2500.c
index 9759996ee6a4..5138486abfa0 100644
--- a/drivers/media/usb/msi2500/msi2500.c
+++ b/drivers/media/usb/msi2500/msi2500.c
@@ -107,7 +107,7 @@ struct msi2500_dev {
 	struct video_device vdev;
 	struct v4l2_device v4l2_dev;
 	struct v4l2_subdev *v4l2_subdev;
-	struct spi_master *master;
+	struct spi_controller *ctlr;
 
 	/* videobuf2 queue and queued buffers list */
 	struct vb2_queue vb_queue;
@@ -574,7 +574,7 @@ static void msi2500_disconnect(struct usb_interface *intf)
 	dev->udev = NULL;
 	v4l2_device_disconnect(&dev->v4l2_dev);
 	video_unregister_device(&dev->vdev);
-	spi_unregister_master(dev->master);
+	spi_unregister_controller(dev->ctlr);
 	mutex_unlock(&dev->v4l2_lock);
 	mutex_unlock(&dev->vb_queue_lock);
 
@@ -1136,10 +1136,10 @@ static void msi2500_video_release(struct v4l2_device *v)
 	kfree(dev);
 }
 
-static int msi2500_transfer_one_message(struct spi_master *master,
+static int msi2500_transfer_one_message(struct spi_controller *ctlr,
 					struct spi_message *m)
 {
-	struct msi2500_dev *dev = spi_master_get_devdata(master);
+	struct msi2500_dev *dev = spi_controller_get_devdata(ctlr);
 	struct spi_transfer *t;
 	int ret = 0;
 	u32 data;
@@ -1154,7 +1154,7 @@ static int msi2500_transfer_one_message(struct spi_master *master,
 	}
 
 	m->status = ret;
-	spi_finalize_current_message(master);
+	spi_finalize_current_message(ctlr);
 	return ret;
 }
 
@@ -1163,7 +1163,7 @@ static int msi2500_probe(struct usb_interface *intf,
 {
 	struct msi2500_dev *dev;
 	struct v4l2_subdev *sd;
-	struct spi_master *master;
+	struct spi_controller *ctlr;
 	int ret;
 	static struct spi_board_info board_info = {
 		.modalias		= "msi001",
@@ -1220,30 +1220,30 @@ static int msi2500_probe(struct usb_interface *intf,
 	}
 
 	/* SPI master adapter */
-	master = spi_alloc_master(dev->dev, 0);
-	if (master == NULL) {
+	ctlr = spi_alloc_master(dev->dev, 0);
+	if (ctlr == NULL) {
 		ret = -ENOMEM;
 		goto err_unregister_v4l2_dev;
 	}
 
-	dev->master = master;
-	master->bus_num = -1;
-	master->num_chipselect = 1;
-	master->transfer_one_message = msi2500_transfer_one_message;
-	spi_master_set_devdata(master, dev);
-	ret = spi_register_master(master);
+	dev->ctlr = ctlr;
+	ctlr->bus_num = -1;
+	ctlr->num_chipselect = 1;
+	ctlr->transfer_one_message = msi2500_transfer_one_message;
+	spi_controller_set_devdata(ctlr, dev);
+	ret = spi_register_controller(ctlr);
 	if (ret) {
-		spi_master_put(master);
+		spi_controller_put(ctlr);
 		goto err_unregister_v4l2_dev;
 	}
 
 	/* load v4l2 subdevice */
-	sd = v4l2_spi_new_subdev(&dev->v4l2_dev, master, &board_info);
+	sd = v4l2_spi_new_subdev(&dev->v4l2_dev, ctlr, &board_info);
 	dev->v4l2_subdev = sd;
 	if (sd == NULL) {
 		dev_err(dev->dev, "cannot get v4l2 subdevice\n");
 		ret = -ENODEV;
-		goto err_unregister_master;
+		goto err_unregister_controller;
 	}
 
 	/* Register controls */
@@ -1276,8 +1276,8 @@ static int msi2500_probe(struct usb_interface *intf,
 	return 0;
 err_free_controls:
 	v4l2_ctrl_handler_free(&dev->hdl);
-err_unregister_master:
-	spi_unregister_master(dev->master);
+err_unregister_controller:
+	spi_unregister_controller(dev->ctlr);
 err_unregister_v4l2_dev:
 	v4l2_device_unregister(&dev->v4l2_dev);
 err_free_mem:
-- 
2.43.0


