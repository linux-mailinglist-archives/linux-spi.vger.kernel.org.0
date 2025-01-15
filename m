Return-Path: <linux-spi+bounces-6358-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B54A12809
	for <lists+linux-spi@lfdr.de>; Wed, 15 Jan 2025 17:03:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D726164179
	for <lists+linux-spi@lfdr.de>; Wed, 15 Jan 2025 16:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A82A115622E;
	Wed, 15 Jan 2025 16:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="edZQ9IAh"
X-Original-To: linux-spi@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8329315539A;
	Wed, 15 Jan 2025 16:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736956978; cv=none; b=jy5KCtrOPJtlYYyyD6EuioURjNb5lBmKgyI6kQV+tLvv2i17Vge1ximythOEd6euLAmPh4PWh7HhIONvX2Fd0rDP4uoBqAu+VXMNfd5brxGs1Zppvp1Fwktqrc46lmtErjnylKBehhERNPSTENeU5iNDWFkY8w96lA6uqkB9gCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736956978; c=relaxed/simple;
	bh=8nH00K0F8hPYVSrUztWzL6dhLAEbSlSNn4G4HIuxWHg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TsLzN9I7pVodnhyVOqP5B0vE3suXqemEqTWtBgbUvc3vHQGXe+hAoiDU3Frw7TMb5fobqrIg0Ap28gJFOvWUgXTkjAMD3o7pjeBsbvDclSepgVDO40snXU8kptoqTyksaYdSUjRX7mndB4m02bcc9twM8XMwSI6YOt/xWklvlB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=edZQ9IAh; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 26D09A0955;
	Wed, 15 Jan 2025 17:02:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=1cpdHJxpiKdoCJBJhkUL
	0M4SqzQhG4ymd2U7r+mGgSU=; b=edZQ9IAhPDOS3UkLhGpv/S4GZ65IsKanX2Fh
	U/l+weMXuV4dRCoiyL5GaM9y/a7ZZl8/DOEkVT/sld+4O13tVzLqppepWx+MiDDV
	5dJV+JPRDDEL9BKCRSLYVtl7c2+kVzw49ti2c3k7kUN3cG57XcduKclUFeJ7SJi3
	KabjLMQ8xDgaGP/9tj9x5SY8dRUrhZltrrIGpBGtrOVmq+32N4MqxXoMZei8AIn6
	DjDse6qGvGTKirMQVnpPGklZ9ESUj7jk1u3iKETVb8KJu+95IhheDG4XBX2zn2Nj
	EbgNBUU7doWlPMD9x85S2BfQCPnY/uf9ZefYMkKbZNDm3Y1lc84ugR29/b0pw/B4
	pJZiGMtz6YIgHjtWLa8wawkEQNxvxhiv2j/9c2IFqVEicbdnzysv0TG/WAQwUK2y
	H3Mo16uIFjo8yZ1dCYowfG4Ff1B+WnoNsARLWIqWHVtK3dPQ4zF6uY09hYfZRI7+
	OeJM2rA/nNqM4VhQ3c2r4CBzWWbeLFzz6lejrra1wOEWeAb71lO7SbV8WQ2ZDBm3
	xc3SVaEXf7vKMwwfIt3uu7sp/6lI83zqwZaNKtNwh3D6M8w2ore3V7Eea14U2au+
	FYAX33X+wLVQw0BHrE6wdZxarCgzseWl/8y8n8uTQOSDZgU/8jQw3A85djffh3Gx
	P7JXb5Y=
From: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>
To: <linux-spi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>, Mark Brown
	<broonie@kernel.org>, Nicolas Ferre <nicolas.ferre@microchip.com>, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, Claudiu Beznea
	<claudiu.beznea@tuxon.dev>
Subject: [PATCH 3/4] spi: atmel-quadspi: Use `devm_dma_request_chan()`
Date: Wed, 15 Jan 2025 17:02:40 +0100
Message-ID: <20250115160244.1102881-3-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250115160244.1102881-1-csokas.bence@prolan.hu>
References: <20250115160244.1102881-1-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1736956968;VERSION=7983;MC=1121942183;ID=287149;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A29ACD94852647067

Leave releasing of DMA channels up to the devm
facilities. This way we can eliminate the rest
of the "goto ladder".

Signed-off-by: Bence Csókás <csokas.bence@prolan.hu>
---
 drivers/spi/atmel-quadspi.c | 44 ++++++++++---------------------------
 1 file changed, 11 insertions(+), 33 deletions(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index abdc49d9d940..b1fb4426c78d 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -1288,18 +1288,20 @@ static int atmel_qspi_dma_init(struct spi_controller *ctrl)
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
@@ -1310,20 +1312,6 @@ static int atmel_qspi_dma_init(struct spi_controller *ctrl)
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
@@ -1428,14 +1416,13 @@ static int atmel_qspi_probe(struct platform_device *pdev)
 
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
@@ -1445,7 +1432,7 @@ static int atmel_qspi_probe(struct platform_device *pdev)
 
 	err = atmel_qspi_init(aq);
 	if (err)
-		goto dma_release;
+		return err;
 
 	err = spi_register_controller(ctrl);
 	if (err) {
@@ -1453,18 +1440,12 @@ static int atmel_qspi_probe(struct platform_device *pdev)
 		pm_runtime_disable(&pdev->dev);
 		pm_runtime_set_suspended(&pdev->dev);
 		pm_runtime_dont_use_autosuspend(&pdev->dev);
-		goto dma_release;
+		return err;
 	}
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
@@ -1514,9 +1495,6 @@ static void atmel_qspi_remove(struct platform_device *pdev)
 
 	ret = pm_runtime_get_sync(&pdev->dev);
 	if (ret >= 0) {
-		if (aq->caps->has_dma)
-			atmel_qspi_dma_release(aq);
-
 		if (aq->caps->has_gclk) {
 			ret = atmel_qspi_sama7g5_suspend(aq);
 			if (ret)
-- 
2.48.0



