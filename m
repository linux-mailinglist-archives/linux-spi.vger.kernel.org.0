Return-Path: <linux-spi+bounces-5028-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C23298946A
	for <lists+linux-spi@lfdr.de>; Sun, 29 Sep 2024 11:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15DE7281C13
	for <lists+linux-spi@lfdr.de>; Sun, 29 Sep 2024 09:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB2813D635;
	Sun, 29 Sep 2024 09:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="HQbCpQ/R"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A035813B286;
	Sun, 29 Sep 2024 09:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727601756; cv=none; b=XcoAH7f2dNcaULElJnfWgZoCxpNKQpwXJzgGvsIrDPxkB5a0oDxZZpt3j0loVQgWUugjBD02kgJwRIN8N0Zmdn6q1dBHRo4Pp/3xz4JANlLTaqEWj3eLBC3Z25F0EyLDcFkZRcIIwqzMdqX9oc7gTqGRuJZg7/Ebpk9VSBDEudw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727601756; c=relaxed/simple;
	bh=OJMCpEnmFHPuM97NunQ+AwWatqDlRkg/lqivaMWdtgA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q3bpthXI0xeMbGzifnE0UzSgZcnzXUxldAU1ePKrOb2pFycQr0/0WvNGu9vAEmrMgoOtfUgEJ9bn24HV3ReQdYlkDmNT7i3OoVNX4lT829KEopqYbaDWXxeipzqFUu35n1jb/mekepGhotOIQVWRiNdgvwfr+/Tny360gVsWgW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=HQbCpQ/R; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1727601743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PzI75TzRgrrI3vePx8GcUC6PxrksxLdMlke7DoZMVao=;
	b=HQbCpQ/RLj2Kp2p9oflWM9AiYfwkk25jxB8t/6ManAXd35xxAskihaDNPf9r5hNlWpHbWT
	8pvCA/9oB9Ttjv20Wo9j2VmKxUddfWjL6M6jth95jROPwbaCQRxsvaCRNwDlrqzEAnfqgn
	8QH/SeraHdj4IgJ0dtbw/vRnfrnjb5aQ6uGYEWDp6WdGnk+CWTrBqYp1PV4n2Q9STrpIAI
	4JhfVybR9lrXyY91VS8/xooezte5b4eSc/HRs4LHXJmWCeHEGOH5fwQKhQNjmBImSyaGWA
	uLRf8BAfw4JULF2sMsJ710o+2ogIvlQtBC4dIbLR+fE+3RrLVb/qouD8mBqUsQ==
To: linux-spi@vger.kernel.org,
	linux-rockchip@lists.infradead.org
Cc: broonie@kernel.org,
	heiko@sntech.de,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	oss@helene.moe,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/5] spi: rockchip-sfc: Perform trivial code cleanups
Date: Sun, 29 Sep 2024 11:21:14 +0200
Message-Id: <4dcd5d9cc4a20c9c6ad504d945475b767399b32f.1727601608.git.dsimic@manjaro.org>
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

Perform a couple of trivial code cleanups, to avoid unnecessary line wrapping
by using the 100-column width a bit better, and to drop a stray empty line.

No intended functional changes are introduced by these code cleanups.

Reviewed-by: Heiko Stuebner <heiko@sntech.de>
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
 

