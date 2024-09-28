Return-Path: <linux-spi+bounces-5019-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8995988DCD
	for <lists+linux-spi@lfdr.de>; Sat, 28 Sep 2024 06:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BCE91F21289
	for <lists+linux-spi@lfdr.de>; Sat, 28 Sep 2024 04:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB612199957;
	Sat, 28 Sep 2024 04:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="dGdOAyY2"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1435165F04;
	Sat, 28 Sep 2024 04:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727496791; cv=none; b=ZtaEpCsZ+T0dtAEizY0hVr95g//aBLcQgo5UWQwqEVPrqIx7uCwxxr6JVOqGOUGUYUlGoWTMYHr4Q4f95IAHweFsuENFKCoG24sBuQyJURkQe24Vvcs7cRGkdX1TADOFVG+duJmDN907plODgRzolq7BoleEdB9JISUD7saKp+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727496791; c=relaxed/simple;
	bh=/0dqEeVI0kdnBedaeCOmkKYW/KlhzVR3w6RZjjLJeNI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gOT0fNUO9zecVSHIx+O3fcIZImgp7XMADofvtpkW4SXlcoqYnbmTKj2zVp8eBteEbjof9yJKonTB3oLiDKF1F8ZdZ8swGkuFUfLl4AcsIYQm7ML97NzTjtG+nRibLxzZjbC1BAjgMobo9aoBwhjx++/39waXDxzLYQofaSI8jTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=dGdOAyY2; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1727496781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/j3wHuSvKpQWX/VU5AEDYXLGtmoTcj7Rhg34WD2kMcg=;
	b=dGdOAyY2RpRJ/zO5zBPDSKb+SEjR9m2ong/UfCBAPqC3XoUki1n9i3k5oNsBnqVvNxLFJ6
	57ju1SsECm5VXqR3TjmEqIRCZs2FOR0Fjo7u7E/QO4VcVUfaISg5a77WD73kFUMGkIJ996
	xO+bGaU883XhiKl+t60UvIQQYvGBYWsGF8Axpg8URy9d4m7gtNP53SORnpQuCuqHVdFDQz
	FUUgr9wSfjtukAq1vs/VIV5n1g9NE45GLf9FsPcWQ2BRMhPM4xIQXrwrCbN37krgFT49dB
	q4RIe9D3/ecNUgJpEoDbgXzC3lWiDQf8H96OyvTzASWNj51I27gVwd6RiAk5SQ==
To: linux-spi@vger.kernel.org,
	linux-rockchip@lists.infradead.org
Cc: broonie@kernel.org,
	heiko@sntech.de,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	oss@helene.moe,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/5] spi: rockchip: Use dev_{err,warn}_probe() in the probe path
Date: Sat, 28 Sep 2024 06:12:49 +0200
Message-Id: <b42b681563a75693f7d6bf0a36c8f8db6ba2cc1c.1727496560.git.dsimic@manjaro.org>
In-Reply-To: <cover.1727496560.git.dsimic@manjaro.org>
References: <cover.1727496560.git.dsimic@manjaro.org>
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
appropriate, to make the code a bit more uniform and compact.  Use the new
function dev_warn_probe() to improve error handling for the TX and RX DMA
channel requests, which are actually optional, and tweak the logged warnings
a bit to additionally describe their optional nature.

Previously, deferred requests for the TX and RX DMA channels produced no
debug messages, and the final error messages didn't include the error codes,
which are all highly useful when debugging permanently failed DMA channel
requests, such as when the required drivers aren't enabled.

Suggested-by: Hélene Vulquin <oss@helene.moe>
Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---
 drivers/spi/spi-rockchip.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 81f2a966c124..055cd6066466 100644
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
 
@@ -817,8 +817,7 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 
 	rs->fifo_len = get_fifo_len(rs);
 	if (!rs->fifo_len) {
-		dev_err(&pdev->dev, "Failed to get fifo length\n");
-		ret = -EINVAL;
+		ret = dev_err_probe(&pdev->dev, -EINVAL, "Failed to get fifo length\n");
 		goto err_put_ctlr;
 	}
 
@@ -858,22 +857,21 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 
 	ctlr->dma_tx = dma_request_chan(rs->dev, "tx");
 	if (IS_ERR(ctlr->dma_tx)) {
-		/* Check tx to see if we need defer probing driver */
-		if (PTR_ERR(ctlr->dma_tx) == -EPROBE_DEFER) {
-			ret = -EPROBE_DEFER;
+		/* Check tx to see if we need to defer driver probing */
+		ret = dev_warn_probe(rs->dev, PTR_ERR(ctlr->dma_tx),
+				     "Failed to request optional TX DMA channel\n");
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
+		ret = dev_warn_probe(rs->dev, PTR_ERR(ctlr->dma_rx),
+				     "Failed to request optional RX DMA channel\n");
+		if (ret == -EPROBE_DEFER)
 			goto err_free_dma_tx;
-		}
-		dev_warn(rs->dev, "Failed to request RX DMA channel\n");
 		ctlr->dma_rx = NULL;
 	}
 

