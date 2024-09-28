Return-Path: <linux-spi+bounces-5016-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9250988DC7
	for <lists+linux-spi@lfdr.de>; Sat, 28 Sep 2024 06:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3819B1C21034
	for <lists+linux-spi@lfdr.de>; Sat, 28 Sep 2024 04:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5908B155C88;
	Sat, 28 Sep 2024 04:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="dq4vJao9"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BB7155392;
	Sat, 28 Sep 2024 04:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727496789; cv=none; b=jdmdb0PxEM5vk3g3PkCeaugin4RfHQY3QHUkRCPMNJUB+y1AsbBkZVYd0z0+nIKG5D4b55nOO/qvwWsC/WcKlgJlJIIFuZq/r3F0Zb213VaUOdA3iGUqMgpueUhKlxhbZrn4davUFQAe4THw91W7D6OJj+OymroT3YIado/WV0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727496789; c=relaxed/simple;
	bh=eOSms0RrfzCYSAMEM6NoxcLBKIPZ26cWiwWq5KKyFPw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O0WO0JSIhmCjNX4Hu0+qldQKR7sYpLusWa/pVUljoxFcf+FDLZh4/K6gj0UstMVlFM5+OjLh+X+a2HKV3TFSGvmcQoMG0ueHRHjs7Bs9foV7jF+WL9Jc+LA+i4tXzQPFlq7q58AOROEpKkFWQ41UimOI2hfvjG3ux/5uHtD718E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=dq4vJao9; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1727496779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kpp3peXn8LwBEdMA5eGMOZGlK98YLfThf9954gFiyVA=;
	b=dq4vJao9v1H1On37KKnAyjL/JXzcBBU0ER0bqG8NiLt3toH5r8EUbEipCsjWkgOZkMO29F
	3yWLBuMFI++RjdR2bvMkkH+Qro52jL71Twh84HI8swopZJIg1kWSIytbZ5pU+O64yq/6Ce
	glfpVze2l6wyxwNfR0HvCreslfe5C5iW/3VDhoZ8eLoeAsCRmxofFAncYE5tiD7HXeOHXh
	2GFLMOlsC0KeDdadlDip6Zf9hpZ7i66ndbEKVzhqbqXqLuQ/9g0nOU3RLcDJ5zTwPvizk/
	N6Z0muHXB6H+B2GevNkmVrGF3NiTPofohGHMUD9gsQadWUqCF56J/RU5aPg7tQ==
To: linux-spi@vger.kernel.org,
	linux-rockchip@lists.infradead.org
Cc: broonie@kernel.org,
	heiko@sntech.de,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	oss@helene.moe,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/5] spi: rockchip-sfc: Use dev_err_probe() in the probe path
Date: Sat, 28 Sep 2024 06:12:47 +0200
Message-Id: <398229ef316e64dc0c27944ea793dcddef1ead4e.1727496560.git.dsimic@manjaro.org>
In-Reply-To: <cover.1727496560.git.dsimic@manjaro.org>
References: <cover.1727496560.git.dsimic@manjaro.org>
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
 

