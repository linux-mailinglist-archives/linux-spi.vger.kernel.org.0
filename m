Return-Path: <linux-spi+bounces-5033-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F49989474
	for <lists+linux-spi@lfdr.de>; Sun, 29 Sep 2024 11:24:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 326611C227D4
	for <lists+linux-spi@lfdr.de>; Sun, 29 Sep 2024 09:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 201AC16BE3A;
	Sun, 29 Sep 2024 09:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="y9+3+3CK"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2E6155747;
	Sun, 29 Sep 2024 09:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727601761; cv=none; b=Lm7pa6SZGIOUHi3Zx3d9agcmkwy7LMUdUtFrLXWaZlTauLgf8C74j9q1pC2Jz/UKEXjW4nMg44UgyObiISa2QKnFUXVCLktfpZjMH1qIhmBjHFgE9HJfG1T6THtUZVug1ZSsAoNjkCWS/lfbW/qhcCvb0ZaE/TNECs2gcIUPlVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727601761; c=relaxed/simple;
	bh=/0dqEeVI0kdnBedaeCOmkKYW/KlhzVR3w6RZjjLJeNI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=adXYZmv2mLkdu/VPF1Gt892YcDNIao4cMZHlwc2+wHB9wTG9h/eeyJPcLN1Gt7rjm+FqA5GuStARI95dhfz+2JVQwxdPVSd1FkUuS1HtHiff6sGwYyksuC2b2izt2mrtu3UeXRN0vV3OfEJ0oaOozu8bbetx5coHhG/1ooehcP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=y9+3+3CK; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1727601745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/j3wHuSvKpQWX/VU5AEDYXLGtmoTcj7Rhg34WD2kMcg=;
	b=y9+3+3CKvpL5upo6V6D/4Cky6G8PpQHlqXP+3orSUmVwZvXkY8RBwDQL/KUoauNBOsLXTg
	f9oi0ffdcFZLnN+RkJuyFUgdX8MTmOFiA8I7MFg5ryCyKDGo+hJwaD8n0hpOGjsUMUken6
	74JMlGOYIJK6YPsRG1685xGn3l8aCShV6HuSIxeZQUBowiHPTN02bu8sZ/UCyRNyQKn+Kx
	Hw9wnvdnIzoZG7IY9deGrTAhSe7Cflz0+0kvrYQ/z6yOoDo5KtrLerr0da5xtCxrCBO0d7
	gZ14dFkNMG3tnhURhpAsQV2Nnf7p5EpFP+EvV8rIaGm2syQXi9AAPlU1c8lr3g==
To: linux-spi@vger.kernel.org,
	linux-rockchip@lists.infradead.org
Cc: broonie@kernel.org,
	heiko@sntech.de,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	oss@helene.moe,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/5] spi: rockchip: Use dev_{err,warn}_probe() in the probe path
Date: Sun, 29 Sep 2024 11:21:17 +0200
Message-Id: <5b6bd142dab3ab93d7039db3e2fdcfea6bee2217.1727601608.git.dsimic@manjaro.org>
In-Reply-To: <cover.1727601608.git.dsimic@manjaro.org>
References: <cover.1727601608.git.dsimic@manjaro.org>
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
 

