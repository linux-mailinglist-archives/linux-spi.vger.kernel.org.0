Return-Path: <linux-spi+bounces-6234-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6A3A02D38
	for <lists+linux-spi@lfdr.de>; Mon,  6 Jan 2025 17:02:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 780937A083B
	for <lists+linux-spi@lfdr.de>; Mon,  6 Jan 2025 16:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F0F2AF06;
	Mon,  6 Jan 2025 16:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="YJKu8mY5"
X-Original-To: linux-spi@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71F7282F5;
	Mon,  6 Jan 2025 16:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736179359; cv=none; b=hX+avE+IcDoulY/UYHc3jHSMfb9GGd3ErNhoXosJuEShdhQtI6Tz3I7wjO1eK2u8+07pXGFwRrO+SPs1YuVaEgsTsKMCvxDCCwM6Dr2HnbiUFqKnvEznMumwkSdF8LuXkpa4SVO+R3fOyZRS/C5NJf7TVV4KqusOb/eL58PTrcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736179359; c=relaxed/simple;
	bh=Dx1Rs7t3i37b34UPDMFTd8PmCXN7S1lavyWqJ6XMHwg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OkfTAjFEIF7/lHhW2TlU80JnYAUuQ5rCm4heDy1YhvU1xWmoS1nuKT5XewVC+6rNq8WoeXuYz0G+m5tvLJcwyC4CMZG73MvTv6c+1E/0//TArNn8C2OBzyjiYQYVf4PP4e3L3x9EOH9jfUi0snhg5+EhsRSYdHx1jWjPMq+dzgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=YJKu8mY5; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id CF80EA0F58;
	Mon,  6 Jan 2025 17:02:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=IDylzkpcXQemmYGkj+LuUTlUnvPEmFKvHAQHgm5c9sY=; b=
	YJKu8mY5cLcSJq3YHF+Rg4ipJnoTAly9lz/2r1VphjU/aHrUFJVddan7I5exO20p
	v9rGbp7V5p/AodOutV5mPyk3Ae/Emd/Av9el7QvthC99LKdJpzR0GcVe/i4cDdsY
	Juh8kYdvYrcxPsUSa4QUHVTcZJFOsF+anqFqwK3+hzzkUCpm6JpqyMZKB5MFG4C0
	7b7L+J9fd3odSlFutu3nxGeMJE0GKquzegekp4nYULkWXo0lJLqA2X5st+oB6wev
	bUEM2t8hG7ircIJi7ZbD+lJYIhkc21LgGLcTSq5hOjuIwbyVgp3M3sHkGZ2c+1pW
	g/eAQCKs0XS1HEUoxpkh9FTV4UqiDdoh+BVBvT8Y+H35jXOCfmWyn1mwEpMOn3jy
	fLmBWMLXQCOl+cLqGXx6jrHKUA7wjrUbm5WDraRmIg3SiKroufE852nOuz4xAg5l
	eU0bJjZkZPtOv3ymYm0EsbENFsCGSjQeVq+VXx3vHuXelSvDw4YNs+l5sjv52c4J
	N3xuMynWPhWslXyV/O9/4GsJDBPt9OXD2W+bMG+LzCQvlxWMcz0l2RiU2R3Wn5f6
	Gj/svlsH1nu8S79clDr7anh72uTV659kNgxc2k+iKUhVxPN2asR/VnNGUxQXJzzz
	thD7tHz475e2Kl1grfsqQmuFDTb+ConiNE7cl8qlwJM=
From: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>
To: <linux-spi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>, Mark Brown
	<broonie@kernel.org>, Nicolas Ferre <nicolas.ferre@microchip.com>, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, Claudiu Beznea
	<claudiu.beznea@tuxon.dev>
Subject: [PATCH resubmit] spi: atmel-quadspi: Use devm_ clock management
Date: Mon, 6 Jan 2025 16:54:16 +0100
Message-ID: <20250106155416.1959803-1-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1736179354;VERSION=7982;MC=3965097876;ID=214303;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A29ACD94852657067

Clean up error handling by using the new devm_
clock handling functions. This should make it
easier to add new code, as we can eliminate the
"goto ladder" in probe().

Signed-off-by: Bence Csókás <csokas.bence@prolan.hu>
---

Notes:
    Resubmit: rebased to current spi-next

 drivers/spi/atmel-quadspi.c | 42 ++++++++++---------------------------
 1 file changed, 11 insertions(+), 31 deletions(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index f46da363574f..93604ffb7106 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -1386,50 +1386,37 @@ static int atmel_qspi_probe(struct platform_device *pdev)
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
@@ -1469,10 +1456,6 @@ static int atmel_qspi_probe(struct platform_device *pdev)
 dma_release:
 	if (aq->caps->has_dma)
 		atmel_qspi_dma_release(aq);
-disable_qspick:
-	clk_disable_unprepare(aq->qspick);
-disable_pclk:
-	clk_disable_unprepare(aq->pclk);
 
 	return err;
 }
@@ -1511,7 +1494,6 @@ static int atmel_qspi_sama7g5_suspend(struct atmel_qspi *aq)
 	if (ret)
 		return ret;
 
-	clk_disable_unprepare(aq->pclk);
 	return 0;
 }
 
@@ -1536,8 +1518,6 @@ static void atmel_qspi_remove(struct platform_device *pdev)
 		}
 
 		atmel_qspi_write(QSPI_CR_QSPIDIS, aq, QSPI_CR);
-		clk_disable(aq->qspick);
-		clk_disable(aq->pclk);
 	} else {
 		/*
 		 * atmel_qspi_runtime_{suspend,resume} just disable and enable
@@ -1547,9 +1527,6 @@ static void atmel_qspi_remove(struct platform_device *pdev)
 		dev_warn(&pdev->dev, "Failed to resume device on remove\n");
 	}
 
-	clk_unprepare(aq->qspick);
-	clk_unprepare(aq->pclk);
-
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	pm_runtime_put_noidle(&pdev->dev);
@@ -1565,8 +1542,11 @@ static int __maybe_unused atmel_qspi_suspend(struct device *dev)
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



