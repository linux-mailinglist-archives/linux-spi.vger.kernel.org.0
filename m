Return-Path: <linux-spi+bounces-5029-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5109598946B
	for <lists+linux-spi@lfdr.de>; Sun, 29 Sep 2024 11:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81B181C22CA1
	for <lists+linux-spi@lfdr.de>; Sun, 29 Sep 2024 09:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26DD143C49;
	Sun, 29 Sep 2024 09:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="sankRXs+"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF0A13B2B0;
	Sun, 29 Sep 2024 09:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727601756; cv=none; b=ENXQKED8HLauwOGzHvRaBNAR1uqGHXYx8dznPOy8hJI+Kc2Pb6x/VmkLLg68Nq9uIRjs7BnMHINM4EkiPmyCHY5UZECKve9mKoLkLHBb+5NepGsE0X+4X6sU98l1RKv4dS/E2U1Zjq3em+M3oypISMiHhMEnyq9ZlcDZMFnEdXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727601756; c=relaxed/simple;
	bh=eOSms0RrfzCYSAMEM6NoxcLBKIPZ26cWiwWq5KKyFPw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XrdUtBxftYCdFDq8PRCaqI1h6MqSmNIUmOFXjqfvhMSXa4uocFE8gzYuZ7paWXtQZtVbiKjHZs0HjIVCLtYrvdF+pYSroRb2YWY776l4e6B+CHihzn2qQFgQMN39c8a18+PIGc0Nnmnn4/Y5LA6oWxgC915cnFNmnFTxG2GPss0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=sankRXs+; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1727601743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kpp3peXn8LwBEdMA5eGMOZGlK98YLfThf9954gFiyVA=;
	b=sankRXs+6DVuPJrctyIP578YA8BSfh3sJjO/IiFILxyo2o2CvrQfig6OGOdYYvh3vn59kv
	O2JZdVyMIFw1jodU2i6HC8PnSAuq1xoERtfu+ZDnyJ6mob1CVuWQiCzov9oZF7bTXbTT6U
	izc/43if6sJwh00P6w/KIZjZCSjDMwu+8kcYnDjnTeGwY1sPLnvk7I0+9RhhqQIMU9AssH
	+7X0G8VNouC9b9ebFHXN2pEtkEb/KQpSm61a6zo53Fyz17Fnd/F7zIWpv3uLfJjd0RiwUM
	t4OxcOtdXmg2OVRBY3w4ZiB1Ac3A6jAg4Qp8x0UTKumFD9MAEgLqJa0IRb9rPg==
To: linux-spi@vger.kernel.org,
	linux-rockchip@lists.infradead.org
Cc: broonie@kernel.org,
	heiko@sntech.de,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	oss@helene.moe,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/5] spi: rockchip-sfc: Use dev_err_probe() in the probe path
Date: Sun, 29 Sep 2024 11:21:15 +0200
Message-Id: <398229ef316e64dc0c27944ea793dcddef1ead4e.1727601608.git.dsimic@manjaro.org>
In-Reply-To: <cover.1727601608.git.dsimic@manjaro.org>
References: <cover.1727601608.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Use function dev_err_probe() in the probe path instead of dev_err() where
appropriate, to make the code a bit more uniform and compact.

Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---
 drivers/spi/spi-rockchip-sfc.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-rockchip-sfc.c b/drivers/spi/spi-rockchip-sfc.c
index 505d5089bf03..7e0fb4944a34 100644
--- a/drivers/spi/spi-rockchip-sfc.c
+++ b/drivers/spi/spi-rockchip-sfc.c
@@ -580,16 +580,14 @@ static int rockchip_sfc_probe(struct platform_device *pdev)
 		return PTR_ERR(sfc->regbase);
 
 	sfc->clk = devm_clk_get(&pdev->dev, "clk_sfc");
-	if (IS_ERR(sfc->clk)) {
-		dev_err(&pdev->dev, "Failed to get sfc interface clk\n");
-		return PTR_ERR(sfc->clk);
-	}
+	if (IS_ERR(sfc->clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(sfc->clk),
+				     "Failed to get sfc interface clk\n");
 
 	sfc->hclk = devm_clk_get(&pdev->dev, "hclk_sfc");
-	if (IS_ERR(sfc->hclk)) {
-		dev_err(&pdev->dev, "Failed to get sfc ahb clk\n");
-		return PTR_ERR(sfc->hclk);
-	}
+	if (IS_ERR(sfc->hclk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(sfc->hclk),
+				     "Failed to get sfc ahb clk\n");
 
 	sfc->use_dma = !of_property_read_bool(sfc->dev->of_node, "rockchip,sfc-no-dma");
 

