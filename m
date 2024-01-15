Return-Path: <linux-spi+bounces-456-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A77DF82E18A
	for <lists+linux-spi@lfdr.de>; Mon, 15 Jan 2024 21:21:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B79441C2217B
	for <lists+linux-spi@lfdr.de>; Mon, 15 Jan 2024 20:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489DD199B4;
	Mon, 15 Jan 2024 20:21:15 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E322B199A7
	for <linux-spi@vger.kernel.org>; Mon, 15 Jan 2024 20:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rPTSF-0004gJ-1s; Mon, 15 Jan 2024 21:21:07 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rPTSE-0005gF-0n; Mon, 15 Jan 2024 21:21:06 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rPTSD-000N7R-31;
	Mon, 15 Jan 2024 21:21:05 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Mark Brown <broonie@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-spi@vger.kernel.org,
	kernel@pengutronix.de,
	Martin Tuma <martin.tuma@digiteqautomotive.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org
Subject: [PATCH 06/33] media: mgb4: Follow renaming of SPI "master" to "controller"
Date: Mon, 15 Jan 2024 21:12:52 +0100
Message-ID:  <6c6e38ee916b4268c617d2603cfbe01ae083ecea.1705348269.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2348; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=4C8mVjjwqhWf+4WdiL4NlvZ9H3+K1pvg3P28tB4o1uc=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlpZHH5rDjpY1VmdWiDAQem7qxFjYU8vcYl2qSi CSQxQiiXTqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZaWRxwAKCRCPgPtYfRL+ To00CACbgUXdEtDsyTMH2odsg+JW8cYfMu5k3mW0q8B3yBXKEOZixdJRcAwaDnbuYA1RkA754WO ekpMim4hEqyHhltCIa/RvFkJr5FxqZR+6jQk6EAdFBvpB8yEI83F/mmvBPtJMP6K6xf+0XzvBE1 FkWeaN1TaXB2VXVy0cTD6pZuuNWL6SCsAaQSKDSTNGF/6CKCloKRcKkM7fS0VFwlhoZj783zugu d11yIeYqha3O4H9nq9GLZA8KSNeshSK2JDk93/T8l0iwsmobD+ZeaBLDuOnUhVlXf8J/uvfct/r I91PSrZJOoe53CHExqT3sA09vMf5EeTrv7us21LRJ8IwrKzd
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
 drivers/media/pci/mgb4/mgb4_core.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/media/pci/mgb4/mgb4_core.c b/drivers/media/pci/mgb4/mgb4_core.c
index 5bfb8a06202e..9bcf10a77fd3 100644
--- a/drivers/media/pci/mgb4/mgb4_core.c
+++ b/drivers/media/pci/mgb4/mgb4_core.c
@@ -144,7 +144,7 @@ static int match_spi_adap(struct device *dev, void *data)
 	return to_spi_device(dev) ? 1 : 0;
 }
 
-static struct spi_master *get_spi_adap(struct platform_device *pdev)
+static struct spi_controller *get_spi_adap(struct platform_device *pdev)
 {
 	struct device *dev;
 
@@ -152,7 +152,7 @@ static struct spi_master *get_spi_adap(struct platform_device *pdev)
 	dev = device_find_child(&pdev->dev, NULL, match_spi_adap);
 	mutex_unlock(&pdev->dev.mutex);
 
-	return dev ? container_of(dev, struct spi_master, dev) : NULL;
+	return dev ? container_of(dev, struct spi_controller, dev) : NULL;
 }
 
 static int init_spi(struct mgb4_dev *mgbdev, u32 devid)
@@ -179,7 +179,7 @@ static int init_spi(struct mgb4_dev *mgbdev, u32 devid)
 	};
 	struct pci_dev *pdev = mgbdev->pdev;
 	struct device *dev = &pdev->dev;
-	struct spi_master *master;
+	struct spi_controller *ctlr;
 	struct spi_device *spi_dev;
 	u32 irq;
 	int rv, id;
@@ -207,8 +207,8 @@ static int init_spi(struct mgb4_dev *mgbdev, u32 devid)
 		return PTR_ERR(mgbdev->spi_pdev);
 	}
 
-	master = get_spi_adap(mgbdev->spi_pdev);
-	if (!master) {
+	ctlr = get_spi_adap(mgbdev->spi_pdev);
+	if (!ctlr) {
 		dev_err(dev, "failed to get SPI adapter\n");
 		rv = -EINVAL;
 		goto err_pdev;
@@ -242,8 +242,8 @@ static int init_spi(struct mgb4_dev *mgbdev, u32 devid)
 
 	spi_info.platform_data = &mgbdev->flash_data;
 
-	spi_dev = spi_new_device(master, &spi_info);
-	put_device(&master->dev);
+	spi_dev = spi_new_device(ctlr, &spi_info);
+	put_device(&ctlr->dev);
 	if (!spi_dev) {
 		dev_err(dev, "failed to create MTD device\n");
 		rv = -EINVAL;
-- 
2.43.0


