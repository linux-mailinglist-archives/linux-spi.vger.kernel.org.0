Return-Path: <linux-spi+bounces-458-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 204A082E18F
	for <lists+linux-spi@lfdr.de>; Mon, 15 Jan 2024 21:21:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1FE12838F8
	for <lists+linux-spi@lfdr.de>; Mon, 15 Jan 2024 20:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29EDF199C1;
	Mon, 15 Jan 2024 20:21:16 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07C7199C4
	for <linux-spi@vger.kernel.org>; Mon, 15 Jan 2024 20:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rPTSK-00052K-7k; Mon, 15 Jan 2024 21:21:12 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rPTSJ-0005hs-8V; Mon, 15 Jan 2024 21:21:11 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rPTSJ-000N9D-0b;
	Mon, 15 Jan 2024 21:21:11 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Mark Brown <broonie@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-spi@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH 31/33] spi: fsl-lib: Follow renaming of SPI "master" to "controller"
Date: Mon, 15 Jan 2024 21:13:17 +0100
Message-ID:  <4913c9c4d2db846ab5facc44c016b90a9b06d4f9.1705348270.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1854; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=1r57n6pCaby+lv1DE7k3IDX2x7vIaMkEPVZWkUjss+U=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlpZHjiyJ1ISvsJLkPmHkHRonR2C5EuArozYI7+ 6F6Ehdx9AOJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZaWR4wAKCRCPgPtYfRL+ TppfCACR/bZ1MoZufrsGp+zGP2m+xrYx8CHRQFsuSRSCBo6y22Nt9/E0HLPf7JQVCbQGujf75Bi TbTmkp7uiNCVgzHjowUNRXwLWIscIbbY4OGKSf8hQQWlmoODuaDdzli7w8IhBUVhng41wgFOoQ+ UoTuloJoFx05gCBBB9snaimUEt4oVjfIzNsxsvc61fSOPjks1cBOBz/mcQGsG3NHPHZgsqLP9CM 4/teyVinCIgUR7hIPE1XBiG3LbuJCX3TCWlHmzisgOsZC1Nc2OVsVuTaDb3bJOEsFPH4YBaTHuu ZOCnDWJoOT+E6kdDmuslpNjUNDglymd9n4cTutnZBdeq49GO
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
 drivers/spi/spi-fsl-lib.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-fsl-lib.c b/drivers/spi/spi-fsl-lib.c
index 885757c29fbb..4fc2c56555b5 100644
--- a/drivers/spi/spi-fsl-lib.c
+++ b/drivers/spi/spi-fsl-lib.c
@@ -82,18 +82,18 @@ void mpc8xxx_spi_probe(struct device *dev, struct resource *mem,
 			unsigned int irq)
 {
 	struct fsl_spi_platform_data *pdata = dev_get_platdata(dev);
-	struct spi_master *master;
+	struct spi_controller *ctlr;
 	struct mpc8xxx_spi *mpc8xxx_spi;
 
-	master = dev_get_drvdata(dev);
+	ctlr = dev_get_drvdata(dev);
 
 	/* the spi->mode bits understood by this driver: */
-	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH
+	ctlr->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH
 			| SPI_LSB_FIRST | SPI_LOOP;
 
-	master->dev.of_node = dev->of_node;
+	ctlr->dev.of_node = dev->of_node;
 
-	mpc8xxx_spi = spi_master_get_devdata(master);
+	mpc8xxx_spi = spi_controller_get_devdata(ctlr);
 	mpc8xxx_spi->dev = dev;
 	mpc8xxx_spi->get_rx = mpc8xxx_spi_rx_buf_u8;
 	mpc8xxx_spi->get_tx = mpc8xxx_spi_tx_buf_u8;
@@ -104,8 +104,8 @@ void mpc8xxx_spi_probe(struct device *dev, struct resource *mem,
 	mpc8xxx_spi->rx_shift = 0;
 	mpc8xxx_spi->tx_shift = 0;
 
-	master->bus_num = pdata->bus_num;
-	master->num_chipselect = pdata->max_chipselect;
+	ctlr->bus_num = pdata->bus_num;
+	ctlr->num_chipselect = pdata->max_chipselect;
 
 	init_completion(&mpc8xxx_spi->done);
 }
-- 
2.43.0


