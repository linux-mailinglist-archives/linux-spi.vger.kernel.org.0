Return-Path: <linux-spi+bounces-4986-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AFC0986F06
	for <lists+linux-spi@lfdr.de>; Thu, 26 Sep 2024 10:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4CCA1F2335C
	for <lists+linux-spi@lfdr.de>; Thu, 26 Sep 2024 08:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D05721AAE29;
	Thu, 26 Sep 2024 08:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="mk9/5BNb"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A3E1A4E8D;
	Thu, 26 Sep 2024 08:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727339910; cv=none; b=M0VR4700TNuxcSm6BbpwSqRTwUWBdjujLF1yqYQ7L4K5Khv+XHPbWK9Nikq71GVS2Am23Uqelz+oDoeGsRxXbPu+wC9WlpTtpLo5Bq3pjHLvwBnsG+U4DGseKHPqLFsDb1eEU1IfrFM3GVCDCPD/YOAtAbg7sEhXWZGTL9IYN5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727339910; c=relaxed/simple;
	bh=ZUr3C+dmENEQuq/f/vTTi0Iv3DwIa5vkkcjtmcCkImQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UIIm6VpSvZlb/tTqSH+qKZcfabUGx2x+NNddjTd7uAojtGSH6hvc/iCrPMmY6j0vFQURifizbVNjPdZjK8md7oLOvaQCyy45bP4quSfbUqcAzBdTScE5JkxZMdUimWP1mCvsIxq679lh+0MvbMuHSSseEr7RV8v8zDHqQYJj/84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=mk9/5BNb; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1727339907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8DgRQOFCytjI9FkTJ+0ouOWyTm9ikdd+11U8xTNi5DM=;
	b=mk9/5BNbLd8di80h3Sj4QuyCqmD58BFew1dpSOO93UBPKQWUMJldotxP+aBSqEac4q6FpN
	capubeEq8cs5yCcU/nHPdPu6gLT9c4kgIXLT4fXyGNair8+UMfshd6HsnlyLzUIADF/mc0
	xjtZfowXp9IejsxfH4ihCw0TZlbjbLaZNsjJs/0WBHifN4zj8NK1oYGeJwH6WD6+CHANMk
	6Ho0uvNONEloVtAQVQej4lYKQwBitmY/h9a2woSiv/GfFgn/wVLGud0ZSblDAa9dgdNvPB
	xyyt5ul/Qj0I1fWCwQ1t9d9LmH6zgC9ZuDtKUqe48otBXkdelBiXAx+PEXhXiw==
To: linux-spi@vger.kernel.org,
	linux-rockchip@lists.infradead.org
Cc: broonie@kernel.org,
	heiko@sntech.de,
	oss@helene.moe,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] spi: rockchip: Use dev_err_probe() in the probe path
Date: Thu, 26 Sep 2024 10:38:15 +0200
Message-Id: <8bc905ff3c47ed458d8c65a031822ba6b9df8a07.1727337732.git.dsimic@manjaro.org>
In-Reply-To: <cover.1727337732.git.dsimic@manjaro.org>
References: <cover.1727337732.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Use function dev_err_probe() in the probe path instead of dev_err() where
appropriate, to make the code a bit more uniform and compact, and to improve
error handling for the TX and RX DMA channel requests.

Previously, deferred requests for the TX and RX DMA channels produced no
debug messages, and the final error messages didn't include the error codes,
which are all highly useful when debugging permanently failed DMA channel
requests, such as when the required drivers aren't enabled.

Suggested-by: Hélene Vulquin <oss@helene.moe>
Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---
 drivers/spi/spi-rockchip.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 28879fed03f8..6b5c67a357bb 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -773,15 +773,15 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 
 	rs->apb_pclk = devm_clk_get_enabled(&pdev->dev, "apb_pclk");
 	if (IS_ERR(rs->apb_pclk)) {
-		dev_err(&pdev->dev, "Failed to get apb_pclk\n");
-		ret = PTR_ERR(rs->apb_pclk);
+		ret = dev_err_probe(&pdev->dev, PTR_ERR(rs->apb_pclk),
+				    "Failed to get apb_pclk\n");
 		goto err_put_ctlr;
 	}
 
 	rs->spiclk = devm_clk_get_enabled(&pdev->dev, "spiclk");
 	if (IS_ERR(rs->spiclk)) {
-		dev_err(&pdev->dev, "Failed to get spi_pclk\n");
-		ret = PTR_ERR(rs->spiclk);
+		ret = dev_err_probe(&pdev->dev, PTR_ERR(rs->spiclk),
+				    "Failed to get spi_pclk\n");
 		goto err_put_ctlr;
 	}
 
@@ -853,22 +853,21 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 
 	ctlr->dma_tx = dma_request_chan(rs->dev, "tx");
 	if (IS_ERR(ctlr->dma_tx)) {
-		/* Check tx to see if we need defer probing driver */
-		if (PTR_ERR(ctlr->dma_tx) == -EPROBE_DEFER) {
-			ret = -EPROBE_DEFER;
+		/* Check tx to see if we need to defer driver probing */
+		ret = dev_err_probe(rs->dev, PTR_ERR(ctlr->dma_tx),
+				    "Failed to request TX DMA channel\n");
+		if (ret == -EPROBE_DEFER)
 			goto err_disable_pm_runtime;
-		}
-		dev_warn(rs->dev, "Failed to request TX DMA channel\n");
 		ctlr->dma_tx = NULL;
 	}
 
 	ctlr->dma_rx = dma_request_chan(rs->dev, "rx");
 	if (IS_ERR(ctlr->dma_rx)) {
-		if (PTR_ERR(ctlr->dma_rx) == -EPROBE_DEFER) {
-			ret = -EPROBE_DEFER;
+		/* Check rx to see if we need to defer driver probing */
+		ret = dev_err_probe(rs->dev, PTR_ERR(ctlr->dma_rx),
+				    "Failed to request RX DMA channel\n");
+		if (ret == -EPROBE_DEFER)
 			goto err_free_dma_tx;
-		}
-		dev_warn(rs->dev, "Failed to request RX DMA channel\n");
 		ctlr->dma_rx = NULL;
 	}
 

