Return-Path: <linux-spi+bounces-445-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F66282E17C
	for <lists+linux-spi@lfdr.de>; Mon, 15 Jan 2024 21:21:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C2A41C221A3
	for <lists+linux-spi@lfdr.de>; Mon, 15 Jan 2024 20:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A38DA1864D;
	Mon, 15 Jan 2024 20:21:12 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EB21947A
	for <linux-spi@vger.kernel.org>; Mon, 15 Jan 2024 20:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rPTSH-0004qu-27; Mon, 15 Jan 2024 21:21:09 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rPTSG-0005gx-Ed; Mon, 15 Jan 2024 21:21:08 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rPTSG-000N8D-1D;
	Mon, 15 Jan 2024 21:21:08 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Mark Brown <broonie@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-spi@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH 18/33] spi: cadence-quadspi: Don't emit error message on allocation error
Date: Mon, 15 Jan 2024 21:13:04 +0100
Message-ID:  <9ef43fafa33c50e3ece45b065bf860419fdf3523.1705348270.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=919; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=JvB30PH3Ov9f9numXa9egPytmZOqbhfvF+Hn9LRiENY=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlpZHVyGbAUuYmgPnkY/EbKJ/8jlr3v/ocTIYDx O8yyQ1acUCJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZaWR1QAKCRCPgPtYfRL+ Th0RCAC6RmYds/UbtzSPMqhQ5dKJ7rGV8MxSYogw8Aq8n9ZAnVKlFgFqI+1VOgXqT6wiDLSS72O RgnJk2oawFFJIkq9sEYKyZMp4+LvZ92vdHpGG00/bC7eIPjh4piicq/ixKFTERqsVwzQyltGdbC JSZTqEFmtsKRlMnz0zBdYwqfFB06LkF/uYvnU9M4v8+u7WfWwWsI5grR+bFARFrNHFcKDnRGgpA 17ceoUg4dVTQCUgtaVQ5P1p10slM2q7AMVvWDCCzrFmivuyQzrGD6KTgTCKma+yNbVTZhzIiQw/ UunnZvpWC6Bh74NGaEkZfZZUEpqwCVqb6Y5xhGZ4fLNUEsa2
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org

Drivers are not supposed to emit an error message when a memory
allocation fails, as the kernel is very loud in this case already
anyhow.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/spi/spi-cadence-quadspi.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index f94e0d370d46..eb6cc861b00b 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1712,10 +1712,9 @@ static int cqspi_probe(struct platform_device *pdev)
 	int irq;
 
 	host = devm_spi_alloc_host(&pdev->dev, sizeof(*cqspi));
-	if (!host) {
-		dev_err(&pdev->dev, "devm_spi_alloc_host failed\n");
+	if (!host)
 		return -ENOMEM;
-	}
+
 	host->mode_bits = SPI_RX_QUAD | SPI_RX_DUAL;
 	host->mem_ops = &cqspi_mem_ops;
 	host->mem_caps = &cqspi_mem_caps;
-- 
2.43.0


