Return-Path: <linux-spi+bounces-4987-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE0D986F08
	for <lists+linux-spi@lfdr.de>; Thu, 26 Sep 2024 10:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F6021C21D3E
	for <lists+linux-spi@lfdr.de>; Thu, 26 Sep 2024 08:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C131B1ABEC4;
	Thu, 26 Sep 2024 08:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="V6fVcQq1"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD9018C336;
	Thu, 26 Sep 2024 08:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727339911; cv=none; b=RfqmfoSVqtcjYqkl8nvC5d6A97UzVKqTXtzGbCWvmmn/TQUNXWUORINfRZXVlFnNR6Fq2PvGxjJQUL/cqOi6pG2P1zbHdBhcxgSxu7Wodl7CXuWZajlst4W7F6jp59vGtj6fKuMk1PhrP5wNElL+Li/plFkR7Zq9SA+P4kUjLyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727339911; c=relaxed/simple;
	bh=jfF+3esDPOf7Xtf2PXsc7BMS38CnLpnaXp2QKJo7kN4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z/gLLyFYPgjjgs11Zx+6/qbTPOlEZIw5OXV65+3PTQbm4NuO+fwWKYg7cye4ZEvJbNrXkY3AFMHxg5PBiKHsthY0vlG9do+o+JQCAklOsfDp2TFJm+kxG3C0+4+JQ4WFK9jBIRtkTEJR8sW0oiu00ntpa3FbA3DyN0GHdT8HnXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=V6fVcQq1; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1727339907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2zU9euMRPUNtRudXGXDojMT1hcsLIwDGY8GKYM1HzlQ=;
	b=V6fVcQq1T1VhWGqyYNepekEB48Eox0YqFTBqP0KZwgUcejt7l7F7b7Ex0dLG4eLXWXKlxR
	8n2vz5HiWTll95QqFpuJ8hMdnP2iq1/j0ev/oTNz8TWkCBkx/EgclMTxbm/hv3SViQe5m2
	hsf01WweWvYrRZYyR7yaEyPjfmt2G0kSzkvNOjQVmXourk8iqwsasWFIoFRPwlhkg9vY0r
	CsJHf7QUKHh+n+vm3J5D/hqvMVFHYehCnaBedpOyRMqmotsKS87Js+muTdC/A95Z+cZEJx
	mLJmEkb9s9U6BRczZtwuscinpM8ptsLJNXOSd+NFsumsxYYt8AyNcCSEqU9yVw==
To: linux-spi@vger.kernel.org,
	linux-rockchip@lists.infradead.org
Cc: broonie@kernel.org,
	heiko@sntech.de,
	oss@helene.moe,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] spi: rockchip-sfc: Use dev_err_probe() in the probe path
Date: Thu, 26 Sep 2024 10:38:16 +0200
Message-Id: <8f65c1ec7737af7f2a538fcae3618756a53ba3fa.1727337732.git.dsimic@manjaro.org>
In-Reply-To: <cover.1727337732.git.dsimic@manjaro.org>
References: <cover.1727337732.git.dsimic@manjaro.org>
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
 

