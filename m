Return-Path: <linux-spi+bounces-6125-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 797A49F7D28
	for <lists+linux-spi@lfdr.de>; Thu, 19 Dec 2024 15:29:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 311A7188D0FD
	for <lists+linux-spi@lfdr.de>; Thu, 19 Dec 2024 14:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A39B225419;
	Thu, 19 Dec 2024 14:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="blEovQ/R"
X-Original-To: linux-spi@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C7D1805E;
	Thu, 19 Dec 2024 14:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734618551; cv=none; b=VSCfCT+5hULISnlGa8OHlth+f9DQK4pC6rwDIVaqDKOJAjXyqeZr1fYNRK5uxnHynn/aKovTh2+Hdty9rLPVHR91mqSNS0eJdTBY9ktglOFqAvQ6hUwX/EGPrBZ0qDw7taYt1jRCQHcdeKYR5VUHaeKOBUieQw/prV5Z1++XgqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734618551; c=relaxed/simple;
	bh=27dQ56padz+fxVEccsDFeNmWC7err52WWdcvu6WFUeM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AE4E9G8xOZBTGNcgTOC4dM4++xhQD4pxxlYLyN5/8mB6MyjBZnBf+K4/jO4bi4O9ynvXp6/dUgAwYxK5VyfbsSHqI8wFlmADALF9xq/fwKlRjQBSS/DMAq1zg8VrAxOWezAZGhmS5duziz7FRep7xLxSf+FIWdfhT4+b2V+YApg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=blEovQ/R; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 0D818A0B52;
	Thu, 19 Dec 2024 15:29:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=q9p5YdpLAC9lMQUDXh/sWTJskhLlLdzk78ldCkop8bo=; b=
	blEovQ/RKCiuzsjrEjdoPNH3dWFhQW/jYvPbBTCAZ07Mi1rHNMTICB2TuY+b/X13
	97cafat1dlz9gJjWZjf4NDBd/VGCxydltuCYYUtcAPUudL2dK2kttkc/iUGg5WCk
	qsapgjez0Jx8JaUjlbKZPn3TIw2xDws5w/q3r0GkQlmuv+RlQtRu5Ri8RsSkBTcP
	gKgwi+7UlpXgH2PuqZneVt7AWkNAwc6PKqR2P+C7XWw7J3neE0QWBXG/80hoJieh
	93skyYwPx/kOQFcQtCIQeFc9gK/1VoSzpvTBLIKYWCkSYxzgzD+FNLRP+CCI7Cmf
	tIvxXevFq6iS4M9H1lvIS1htUzFD2XEuoCu7db2t+snZuXWyErx3vdYloaaAxp77
	CR1fu8DmYKQ4O/yvqyfhKdvjXI1Jc7YX3T2O4Llt0X+3cquxd1saf7gh8UVWrCAV
	canmA9OOTxD0Jl07TeIcebW5CXY4jFmmlGvispb0tHU+HsrpcXjhUChZ8+DvNXN5
	grGOc+zWT9uZMSOqN99nMPdI6hUoEH7nBfqxrQ7+JOL/iWtbThapDen0MhIViM5F
	2tb94pyF0krWOwvgKlk5fM79D8XYc4+Y8m4TtAGN/3WAaLE6pgZHxR4iNptNk5Mr
	wGJmqQ5ahjG0I8TQwQy4ZDpy7VJ4N2z79YbylEBm47g=
From: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>
To: <linux-spi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>, Mark Brown
	<broonie@kernel.org>, Nicolas Ferre <nicolas.ferre@microchip.com>, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, Claudiu Beznea
	<claudiu.beznea@tuxon.dev>
Subject: [PATCH] spi: atmel-quadspi: Use devm_ clock management
Date: Thu, 19 Dec 2024 15:28:51 +0100
Message-ID: <20241219142851.430959-1-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1734618544;VERSION=7982;MC=3504418844;ID=84880;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A29ACD948556D7361

Clean up error handling by using the new devm_
clock handling functions. This should make it
easier to add new code, as we can eliminate the
"goto ladder" in probe().

Signed-off-by: Bence Csókás <csokas.bence@prolan.hu>
---
 drivers/spi/atmel-quadspi.c | 42 ++++++++++---------------------------
 1 file changed, 11 insertions(+), 31 deletions(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index 73cf0c3f1477..0353f8e1384d 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -1381,50 +1381,37 @@ static int atmel_qspi_probe(struct platform_device *pdev)
 	aq->mmap_phys_base = (dma_addr_t)res->start;
 
 	/* Get the peripheral clock */
-	aq->pclk = devm_clk_get(&pdev->dev, "pclk");
+	aq->pclk = devm_clk_get_enabled(&pdev->dev, "pclk");
 	if (IS_ERR(aq->pclk))
-		aq->pclk = devm_clk_get(&pdev->dev, NULL);
+		aq->pclk = devm_clk_get_enabled(&pdev->dev, NULL);
 
 	if (IS_ERR(aq->pclk))
 		return dev_err_probe(&pdev->dev, PTR_ERR(aq->pclk),
 				     "missing peripheral clock\n");
 
-	/* Enable the peripheral clock */
-	err = clk_prepare_enable(aq->pclk);
-	if (err)
-		return dev_err_probe(&pdev->dev, err,
-				     "failed to enable the peripheral clock\n");
-
 	if (aq->caps->has_qspick) {
 		/* Get the QSPI system clock */
-		aq->qspick = devm_clk_get(&pdev->dev, "qspick");
+		aq->qspick = devm_clk_get_enabled(&pdev->dev, "qspick");
 		if (IS_ERR(aq->qspick)) {
 			dev_err(&pdev->dev, "missing system clock\n");
 			err = PTR_ERR(aq->qspick);
-			goto disable_pclk;
+			return err;
 		}
 
-		/* Enable the QSPI system clock */
-		err = clk_prepare_enable(aq->qspick);
-		if (err) {
-			dev_err(&pdev->dev,
-				"failed to enable the QSPI system clock\n");
-			goto disable_pclk;
-		}
 	} else if (aq->caps->has_gclk) {
 		/* Get the QSPI generic clock */
 		aq->gclk = devm_clk_get(&pdev->dev, "gclk");
 		if (IS_ERR(aq->gclk)) {
 			dev_err(&pdev->dev, "missing Generic clock\n");
 			err = PTR_ERR(aq->gclk);
-			goto disable_pclk;
+			return err;
 		}
 	}
 
 	if (aq->caps->has_dma) {
 		err = atmel_qspi_dma_init(ctrl);
 		if (err == -EPROBE_DEFER)
-			goto disable_qspick;
+			return err;
 	}
 
 	/* Request the IRQ */
@@ -1464,10 +1451,6 @@ static int atmel_qspi_probe(struct platform_device *pdev)
 dma_release:
 	if (aq->caps->has_dma)
 		atmel_qspi_dma_release(aq);
-disable_qspick:
-	clk_disable_unprepare(aq->qspick);
-disable_pclk:
-	clk_disable_unprepare(aq->pclk);
 
 	return err;
 }
@@ -1506,7 +1489,6 @@ static int atmel_qspi_sama7g5_suspend(struct atmel_qspi *aq)
 	if (ret)
 		return ret;
 
-	clk_disable_unprepare(aq->pclk);
 	return 0;
 }
 
@@ -1531,8 +1513,6 @@ static void atmel_qspi_remove(struct platform_device *pdev)
 		}
 
 		atmel_qspi_write(QSPI_CR_QSPIDIS, aq, QSPI_CR);
-		clk_disable(aq->qspick);
-		clk_disable(aq->pclk);
 	} else {
 		/*
 		 * atmel_qspi_runtime_{suspend,resume} just disable and enable
@@ -1542,9 +1522,6 @@ static void atmel_qspi_remove(struct platform_device *pdev)
 		dev_warn(&pdev->dev, "Failed to resume device on remove\n");
 	}
 
-	clk_unprepare(aq->qspick);
-	clk_unprepare(aq->pclk);
-
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	pm_runtime_put_noidle(&pdev->dev);
@@ -1560,8 +1537,11 @@ static int __maybe_unused atmel_qspi_suspend(struct device *dev)
 	if (ret < 0)
 		return ret;
 
-	if (aq->caps->has_gclk)
-		return atmel_qspi_sama7g5_suspend(aq);
+	if (aq->caps->has_gclk) {
+		ret = atmel_qspi_sama7g5_suspend(aq);
+		clk_disable_unprepare(aq->pclk);
+		return ret;
+	}
 
 	atmel_qspi_write(QSPI_CR_QSPIDIS, aq, QSPI_CR);
 
-- 
2.34.1



