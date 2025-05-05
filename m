Return-Path: <linux-spi+bounces-7902-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B76DAA9BE8
	for <lists+linux-spi@lfdr.de>; Mon,  5 May 2025 20:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B03DD3BECC2
	for <lists+linux-spi@lfdr.de>; Mon,  5 May 2025 18:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E718B26D4C1;
	Mon,  5 May 2025 18:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="Etsucjkc"
X-Original-To: linux-spi@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A918E19CC22;
	Mon,  5 May 2025 18:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746470985; cv=none; b=O7FFlxB849Sm168qjZafjOCTIXCwXsDr4hhP0ztSnzXsmRiwbIHJUxQwPKMFRfjq+qSZXtSgc4WEP9Ug/fk9crIrN57XnLN5FpweDJyFbQAKSxxg4Rcw/NCkgWO76+tvrH1k7V23j+90umJobWtp7/semlqBMHgRyhZiEi5V+KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746470985; c=relaxed/simple;
	bh=0UX04jtlgTNdeY9qnlTEG0Y1NBKHXwDo+YBtMn+bcm4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=meySWt/yW5nAYdUIoqzZDGNo9z90BXuhy2DjoIfhlYXk07Q8fpXpxxqjONBxgjS75jrX7sgk8CFnqeyHx3vFb22KzSGgK22IV66zHp1n/+F+AhY6hwI4h+Dh3VAemnOz5XTjS4BZBZMGI8teXtE4+Lte9tRZKpb+3W1kgBcdw7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=Etsucjkc; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 7FD0BA0ACD;
	Mon,  5 May 2025 20:49:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=A8eEJvFMu/G8fSNsQRyZ
	7m8pQKvtChPB4Eaz2stzIqQ=; b=Etsucjkcd5P/kAVx7Ys7kErnTcIn23B0EUE0
	4CRXWX0ZQgdUaE2KbyFQh2Dsk5ldPEcXVFRsFd4+lS2SOHDIQjTu5+kiMMqF6PNQ
	6bSE+SE6WoKH2IdgB9zadLjJlfC3TvcW5SCrFYdDn4/gyEJrFiT0ErQw2Hsznuvr
	6E46cG/WTITq9UcD3qNcf+yHdoocAKHMVZNXTaHuOqPDXNeY0kRzPdFB3qiFmcMy
	c1sfg0RUxllma9YfAHwf12b8JcxE4RrgPzWYMgAAc2dK7vHwzW4dK7xCc5LalBdg
	7yKWxWFSpH2Mt4jsVgszd42OVoHFWrVNSPmYXewRqq/rOAfya6r2R95C8AM6b4JH
	nke/uLp0wiI3tWjRuZlURZ3R5ZLt8Em6ffWmfqAy8N7/ML6UHgX04sowG4rdvJb+
	k7iOTGZ6mKsiUkAbB9GlDcq8SpZYfx3LgkkU5M52wKv0loDfi/uCqtUAcC1BWVPc
	rcBy/zvGQGMRd5IYgXZUeAe1o2LC1akG6eO3Q4nLKdovVmCcUwxoxtVIv8l9x5HP
	W3B/SIv6hqFzaruHVCOTBbd2HvhGFAeYvAJmdUR4WS00+OZvDE+nusuV+Z38lXln
	1Ha0JIZQ4BOhOgN1qu8PIs627gTT+wypnZGG/Rq+7mslNcYWBSBM8BIyT+0leRj7
	xDPVDuU=
From: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>
To: <linux-spi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>, Mark Brown
	<broonie@kernel.org>, Nicolas Ferre <nicolas.ferre@microchip.com>, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, Claudiu Beznea
	<claudiu.beznea@tuxon.dev>
Subject: [PATCH v5 2/2] spi: atmel-quadspi: Use `devm_dma_request_chan()`
Date: Mon, 5 May 2025 20:49:34 +0200
Message-ID: <20250505184936.312274-3-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250505184936.312274-1-csokas.bence@prolan.hu>
References: <20250505184936.312274-1-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1746470980;VERSION=7990;MC=561884614;ID=217953;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D94853667166

Leave releasing of DMA channels up to the devm facilities. This way we can
eliminate the rest of the "goto ladder".

Signed-off-by: Bence Csókás <csokas.bence@prolan.hu>
---
 drivers/spi/atmel-quadspi.c | 44 ++++++++++---------------------------
 1 file changed, 11 insertions(+), 33 deletions(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index e7b61dc4ce67..ef1416bbdf89 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -1285,18 +1285,20 @@ static int atmel_qspi_dma_init(struct spi_controller *ctrl)
 	struct atmel_qspi *aq = spi_controller_get_devdata(ctrl);
 	int ret;
 
-	aq->rx_chan = dma_request_chan(&aq->pdev->dev, "rx");
+	aq->rx_chan = devm_dma_request_chan(&aq->pdev->dev, "rx");
 	if (IS_ERR(aq->rx_chan)) {
 		aq->rx_chan = NULL;
 		return dev_err_probe(&aq->pdev->dev, PTR_ERR(aq->rx_chan),
 				     "RX DMA channel is not available\n");
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
@@ -1307,20 +1309,6 @@ static int atmel_qspi_dma_init(struct spi_controller *ctrl)
 		 dma_chan_name(aq->tx_chan), dma_chan_name(aq->rx_chan));
 
 	return 0;
-
-release_rx_chan:
-	dma_release_channel(aq->rx_chan);
-	aq->rx_chan = NULL;
-	aq->tx_chan = NULL;
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
@@ -1425,14 +1413,13 @@ static int atmel_qspi_probe(struct platform_device *pdev)
 
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
@@ -1441,22 +1428,16 @@ static int atmel_qspi_probe(struct platform_device *pdev)
 
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
@@ -1506,9 +1487,6 @@ static void atmel_qspi_remove(struct platform_device *pdev)
 
 	ret = pm_runtime_get_sync(&pdev->dev);
 	if (ret >= 0) {
-		if (aq->caps->has_dma)
-			atmel_qspi_dma_release(aq);
-
 		if (aq->caps->has_gclk) {
 			ret = atmel_qspi_sama7g5_suspend(aq);
 			if (ret)
-- 
2.49.0



