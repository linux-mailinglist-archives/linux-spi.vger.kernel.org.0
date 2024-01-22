Return-Path: <linux-spi+bounces-568-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8D7837024
	for <lists+linux-spi@lfdr.de>; Mon, 22 Jan 2024 19:37:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E3571F27AA5
	for <lists+linux-spi@lfdr.de>; Mon, 22 Jan 2024 18:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ADFE5FEF3;
	Mon, 22 Jan 2024 18:08:23 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C131356478
	for <linux-spi@vger.kernel.org>; Mon, 22 Jan 2024 18:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705946903; cv=none; b=GhLeD8JBuQNqR+oEAuChN4x7T5HMlAWNU0FjTV0zAmDIHAGzQUCq4wYeFITE8l+Ohbjgx7v9Dr6AQW46hdtWthCbYJxPIZjDsWtxTetwXowFybJD4QDuVnqkw+Tasrs80wFPop5+9geGRX9obXRMR1c8Nc0x3TpoPNKfag8CK/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705946903; c=relaxed/simple;
	bh=1r57n6pCaby+lv1DE7k3IDX2x7vIaMkEPVZWkUjss+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eGUC4Zzt0w5e8naZorxUZDUBgPs1X2wBaPcmYejWg+cWDQSot/LX3AMam7/cNFOCtX9jF81PREjGnkL6mE81FjwWfYAXpClReVifra80XZ+Ssd+QF4bpULme9IK6PYo2SK/SjKBkR829v1xdfMtxPTkBHsQc1ee12EBXpooqojs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rRyiZ-00028N-LB; Mon, 22 Jan 2024 19:08:19 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rRyiZ-001eRB-1o; Mon, 22 Jan 2024 19:08:19 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rRyiY-005Zyt-3A;
	Mon, 22 Jan 2024 19:08:18 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: kernel@pengutronix.de,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 31/33] spi: fsl-lib: Follow renaming of SPI "master" to "controller"
Date: Mon, 22 Jan 2024 19:07:26 +0100
Message-ID:  <1a82f797d8362fe7bf7b876bfcfc0fb5b65b1be0.1705944943.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1854; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=1r57n6pCaby+lv1DE7k3IDX2x7vIaMkEPVZWkUjss+U=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlrq7nvzm68uTfzLJCoOEslXrl5nkgaUSS1TySW BgtYWIlXt6JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZa6u5wAKCRCPgPtYfRL+ TnhqB/98DHksZKV63AtdaFl/zmOZ3gSu8WEoJwTELMSowC+9S0JwTJUhSWc2pJQbD1/eWRT7K6J zYE7/7XzbJ3rcuThlDb60bubSUxMlunbW5jE6ox9Q8BdyJwTcPHSk4+ZlMJR8RFEGmrtMnMGCHM aG0pTQNy196Ljl18UahYkcrWePxYpQ08kJqJ4wC6qrlEdP48bDL6PUk5l+797BAfi5rXPvk46BP xAKq2S2xF6p4F4g3IpyYg0oi/YFfLOVRTf5rxfdA6uKCXXLrQa9X31BESTN0qM0iD7E0vTekz8X e+0RqmT631Jj0ZtEaF90Hn6RKqsUH/sGfBEDB0TO+jFEz5d/
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


