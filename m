Return-Path: <linux-spi+bounces-8128-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F5B0AB80E3
	for <lists+linux-spi@lfdr.de>; Thu, 15 May 2025 10:37:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A7B91BC2254
	for <lists+linux-spi@lfdr.de>; Thu, 15 May 2025 08:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE9E2063F3;
	Thu, 15 May 2025 08:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="dWsLvURQ"
X-Original-To: linux-spi@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92684288522;
	Thu, 15 May 2025 08:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747297903; cv=none; b=X0YX+gDEdOwUvPXvaAR+TjFIA005fAku74AykPfP1qyLa79UELLdkHsY3Av0nxJhu5v9X6GgcQgGZqvLEaCfaqAv/wpi0Wc53K+UFLOU894/qecqw3YL35BWqOnAUT1XP6i+CLaRPxWUjtyxTwLy9kFhlR6oI09563JAErJ1kRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747297903; c=relaxed/simple;
	bh=teRKCpcCZjRrySHJh7DujU1cBHibTtbcNpxnYm/ruiU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AHgiAltPM0RvM+QC/KjxEUiCc+TnzbFOSGCiAlVxkfX1oKTuY0EqbsZWAOr+Vtv6TbtCVxg3/ynLrA01qCrVNC1Barvo4h6Z03p0mBVSbj4N9OdoJmy1LS4QnrnZo/bFu/V6wTHu27InBaENfe3E2qFl3R8THdVAPfA+IyxboP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=dWsLvURQ; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id A7ED8A0780;
	Thu, 15 May 2025 10:31:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=h4hvPkDpasDOqzvoPlQR
	6fqCNAD2mH8pnt4CYS2HbjE=; b=dWsLvURQpoDW2UvfwTuTTPHei2Hr7aJjcOzc
	ENp2TBHvHS40f44EPaWQw+GbWeHXqq9AvEAddTkhZg752jEOuKdyq50BqWG8Cpyn
	c1x/u8XdHXL+MbYUoquXuyWKT+AWOXEshStedJns8SpqDNRIFWnfwvGv4gbZaQh7
	iFZwJDGEht0WdfgdfGkfhlWm55RgrU5aNjOV6oRlIr8DE6b9mtMsaKi9DvssFXyo
	tmUt5DggMCwI9roz7UlIeI2qKJ14hL5ieIkCe/dU6NlQV2bDi0bf9JJHsFQL5Ih0
	pAj0J1fN0fY+PKq4qlIy1dYBHTe8sqs9JJrhm7ktRrxm8y+Ew9rW7Qg735+JaGD0
	CHpdjSbPYwERDEyvW1ntlPdOvxV/4xp4OJGVd1gyY2tpDiHZkIjY0bRnDH9lAuOm
	67ofeW83oz1S2MTn3Fegzf8U6kjYzPL3dsI9hXDJ+xb4/85nDiEuL8FYtEW73ajB
	eYiJnYPrdno32oCnP70+0Iv2uyESSaNDC6cSNnjJin2BSa7WvUvGGJiT1WGeXfV3
	D91se+SqAd2hwdYNdVMB+AngwPCfnC9q6Ak97nN9A2Xh6AIOtbDphS3PD2C2eZrX
	zDQTsTWIy9I5xvwErbgdupsFCQv5A/JTUqUApVVAOhGFPKbP0180mtAQyJYYCStS
	+U/mKzw=
From: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>
To: <linux-spi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>, Mark Brown
	<broonie@kernel.org>, Nicolas Ferre <nicolas.ferre@microchip.com>, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, Claudiu Beznea
	<claudiu.beznea@tuxon.dev>
Subject: [PATCH v6 2/2] spi: atmel-quadspi: Use `devm_dma_request_chan()`
Date: Thu, 15 May 2025 10:31:30 +0200
Message-ID: <20250515083132.255410-3-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250515083132.255410-1-csokas.bence@prolan.hu>
References: <20250515083132.255410-1-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1747297898;VERSION=7990;MC=264603594;ID=2670053224;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A29BB64155D617062

Leave releasing of DMA channels up to the devm facilities. This way we can
eliminate the rest of the "goto ladder".

Signed-off-by: Bence Csókás <csokas.bence@prolan.hu>
---
 drivers/spi/atmel-quadspi.c | 48 ++++++++++---------------------------
 1 file changed, 13 insertions(+), 35 deletions(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index 2f6797324227..fc555c0ce52e 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -1285,18 +1285,21 @@ static int atmel_qspi_dma_init(struct spi_controller *ctrl)
 	struct atmel_qspi *aq = spi_controller_get_devdata(ctrl);
 	int ret;
 
-	aq->rx_chan = dma_request_chan(&aq->pdev->dev, "rx");
+	aq->rx_chan = devm_dma_request_chan(&aq->pdev->dev, "rx");
 	if (IS_ERR(aq->rx_chan)) {
 		ret = dev_err_probe(&aq->pdev->dev, PTR_ERR(aq->rx_chan),
 				    "RX DMA channel is not available\n");
-		goto null_rx_chan;
+		aq->rx_chan = NULL;
+		return ret;
 	}
 
-	aq->tx_chan = dma_request_chan(&aq->pdev->dev, "tx");
+	aq->tx_chan = devm_dma_request_chan(&aq->pdev->dev, "tx");
 	if (IS_ERR(aq->tx_chan)) {
 		ret = dev_err_probe(&aq->pdev->dev, PTR_ERR(aq->tx_chan),
 				    "TX DMA channel is not available\n");
-		goto release_rx_chan;
+		aq->rx_chan = NULL;
+		aq->tx_chan = NULL;
+		return ret;
 	}
 
 	ctrl->dma_rx = aq->rx_chan;
@@ -1307,21 +1310,6 @@ static int atmel_qspi_dma_init(struct spi_controller *ctrl)
 		 dma_chan_name(aq->tx_chan), dma_chan_name(aq->rx_chan));
 
 	return 0;
-
-release_rx_chan:
-	dma_release_channel(aq->rx_chan);
-	aq->tx_chan = NULL;
-null_rx_chan:
-	aq->rx_chan = NULL;
-	return ret;
-}
-
-static void atmel_qspi_dma_release(struct atmel_qspi *aq)
-{
-	if (aq->rx_chan)
-		dma_release_channel(aq->rx_chan);
-	if (aq->tx_chan)
-		dma_release_channel(aq->tx_chan);
 }
 
 static const struct atmel_qspi_ops atmel_qspi_ops = {
@@ -1426,14 +1414,13 @@ static int atmel_qspi_probe(struct platform_device *pdev)
 
 	/* Request the IRQ */
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		err = irq;
-		goto dma_release;
-	}
+	if (irq < 0)
+		return irq;
+
 	err = devm_request_irq(&pdev->dev, irq, atmel_qspi_interrupt,
 			       0, dev_name(&pdev->dev), aq);
 	if (err)
-		goto dma_release;
+		return err;
 
 	pm_runtime_set_autosuspend_delay(&pdev->dev, 500);
 	pm_runtime_use_autosuspend(&pdev->dev);
@@ -1442,22 +1429,16 @@ static int atmel_qspi_probe(struct platform_device *pdev)
 
 	err = atmel_qspi_init(aq);
 	if (err)
-		goto dma_release;
+		return err;
 
 	err = spi_register_controller(ctrl);
 	if (err)
-		goto dma_release;
+		return err;
 
 	pm_runtime_mark_last_busy(&pdev->dev);
 	pm_runtime_put_autosuspend(&pdev->dev);
 
 	return 0;
-
-dma_release:
-	if (aq->caps->has_dma)
-		atmel_qspi_dma_release(aq);
-
-	return err;
 }
 
 static int atmel_qspi_sama7g5_suspend(struct atmel_qspi *aq)
@@ -1507,9 +1488,6 @@ static void atmel_qspi_remove(struct platform_device *pdev)
 
 	ret = pm_runtime_get_sync(&pdev->dev);
 	if (ret >= 0) {
-		if (aq->caps->has_dma)
-			atmel_qspi_dma_release(aq);
-
 		if (aq->caps->has_gclk) {
 			ret = atmel_qspi_sama7g5_suspend(aq);
 			if (ret)
-- 
2.43.0



