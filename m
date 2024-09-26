Return-Path: <linux-spi+bounces-4984-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93150986F01
	for <lists+linux-spi@lfdr.de>; Thu, 26 Sep 2024 10:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C42471C2265C
	for <lists+linux-spi@lfdr.de>; Thu, 26 Sep 2024 08:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9851A4F0C;
	Thu, 26 Sep 2024 08:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="FEmCfeSC"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B751C18C34C;
	Thu, 26 Sep 2024 08:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727339909; cv=none; b=FHrr4ZE/jzY7GMqJpa9clRowRgXOULSRWI3liI1t3wHSSiGQY90Qzwx4THNQ7sezCH7l4NWUOFVFBgfpOW2HZB403Y2Nvan9I/SYljz/OTI09w2+Hd/sxiNWjtQPDwd84XzRHHUKF67VLF+G319QJHpCs8RgrpuR/jCQiJYiw4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727339909; c=relaxed/simple;
	bh=INOYgtdHb4P3ihx77pkVNKM3sJqYlxQ8pkazFJrL5/w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f0y4QjcG29/6vOrWQcWQI90JcXerETUbDBXAVF6iC1IZ+SxLFOIMnZhQy1QPmDj+PyLPqaPXRW25nBF3ip/XZHBzr+shsTRepBR1pPXXYHIyZ8BYonH4TDtksRD0QbTXiwUcjcxC06SW2MIJ/tRVXfypuxpINrnR6vezX/z39z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=FEmCfeSC; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1727339906;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vl6o00F5vcnezSkxhr2a1kCj0/F15fsYEAmFewTFJWk=;
	b=FEmCfeSCYQKa24aRCe9Wn80zHbf3lmrairBcJwyLgmwEtoowPk6yvSOWg5N+V/dV3UlRo6
	XZOLV+aBXBQxC8/LTdqt2Zwcj5M2vn5rgobfw4C2pKkwvkB4qP1m7lS4OzZ4slIemM0pIy
	47jw1DHLwDKUbsqsV+j4L/JiHgWmBKmxQvD2pYvbdNhvZ9Yhs8iiK0GUHNtlx2QZJKWldY
	oKlpYWMDYuY3pp2Z9q0//56aVM7KEo1MA5yMqD0k79OHBVJwxAjQkJc8cKgaEZwEybykpU
	Pd8L6quiKpduC3LyeGYv8FEmGGTG7i0fvJeNaLSEivzqZosXZAyRPN2ypOSOqw==
To: linux-spi@vger.kernel.org,
	linux-rockchip@lists.infradead.org
Cc: broonie@kernel.org,
	heiko@sntech.de,
	oss@helene.moe,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] spi: rockchip-sfc: Perform trivial code cleanups
Date: Thu, 26 Sep 2024 10:38:13 +0200
Message-Id: <251242bfc9c4fdc01d930f093022ce0c9481d58e.1727337732.git.dsimic@manjaro.org>
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

Perform a couple of trivial code cleanups, to avoid unnecessary line wrapping
by using the 100-column width a bit better, and to drop a stray empty line.

No intended functional changes are introduced by these code cleanups.

Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---
 drivers/spi/spi-rockchip-sfc.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-rockchip-sfc.c b/drivers/spi/spi-rockchip-sfc.c
index 0d7fadcd4ed3..505d5089bf03 100644
--- a/drivers/spi/spi-rockchip-sfc.c
+++ b/drivers/spi/spi-rockchip-sfc.c
@@ -591,19 +591,17 @@ static int rockchip_sfc_probe(struct platform_device *pdev)
 		return PTR_ERR(sfc->hclk);
 	}
 
-	sfc->use_dma = !of_property_read_bool(sfc->dev->of_node,
-					      "rockchip,sfc-no-dma");
+	sfc->use_dma = !of_property_read_bool(sfc->dev->of_node, "rockchip,sfc-no-dma");
 
 	if (sfc->use_dma) {
 		ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
 		if (ret) {
 			dev_warn(dev, "Unable to set dma mask\n");
 			return ret;
 		}
 
 		sfc->buffer = dmam_alloc_coherent(dev, SFC_MAX_IOSIZE_VER3,
-						  &sfc->dma_buffer,
-						  GFP_KERNEL);
+						  &sfc->dma_buffer, GFP_KERNEL);
 		if (!sfc->buffer)
 			return -ENOMEM;
 	}
@@ -629,7 +627,6 @@ static int rockchip_sfc_probe(struct platform_device *pdev)
 			       0, pdev->name, sfc);
 	if (ret) {
 		dev_err(dev, "Failed to request irq\n");
-
 		goto err_irq;
 	}
 

