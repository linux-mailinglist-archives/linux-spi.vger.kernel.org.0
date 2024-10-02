Return-Path: <linux-spi+bounces-5091-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74FE098E09E
	for <lists+linux-spi@lfdr.de>; Wed,  2 Oct 2024 18:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 988161C23821
	for <lists+linux-spi@lfdr.de>; Wed,  2 Oct 2024 16:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D656A1D0E0D;
	Wed,  2 Oct 2024 16:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b0DHXdJS"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA1E1CF2B6;
	Wed,  2 Oct 2024 16:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727886418; cv=none; b=rlCeUDjUz73kf4diitI0XgNuwagp+9z7ZFPsTQv49G9VBc1ritT63IkXpKByeILrHSq9uCXzHN60FGs0Ey2XgwaWRuf7uhxoa3esJ4MNpWoCH8riZDeBu/vLizUV8Gwm0YXV9gm4i+KqRt5+9dJOQXCB+7+LalVhGlbbGWpVreI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727886418; c=relaxed/simple;
	bh=lMVHe8SRVDClb2Na8aSZ48nsQgW9ULWJPaBreNnxRIU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=K8IraYFuJra5Q/RYpb+f1z3inCMCH3whN+89SaoWFKhZ8dV44s04hVW+OVPkRy4mXNJBDYNCs3yv50lzqH5aqYVGi79dA8rV0vt9E6BXmu6Wx1a5AK/12CvUvm7BXy96Y2WR8T6zGBelXhQdAlNxXGsrt5SltMgQsMZ1NniW/W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b0DHXdJS; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5398f3be400so4797085e87.0;
        Wed, 02 Oct 2024 09:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727886415; x=1728491215; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C/ijsoZNLuIwPR396i1gI0b/SFMI/hxV4hjgGBBm/0E=;
        b=b0DHXdJSbffMITKaPPDReryAPog4DbvfFWWSrMl8GGCnHjGOEBRgC47+WnHVEML0Q8
         syCBtLnPaLUa3X1Bd7x5I5+ymSVTJAE5oKFza/Aw1veLt0L1DG/8W2oDShhiLmMlG/ZS
         esCCALA9MsjcQf7amp1Bx+Ld6MOaWcYNOYaXrvb8lFKw+h8wL5UMaWaAupgaridp642U
         8sGaxNotaOigkXSPndjb1GR2w0YeJK9+ciC3C/+PC9Qgc07Gc/YoT4yfmE3kSDstcwtf
         QAZrVuOVHmAe4NyPINIwR+hD42pFAwRIdyHLBfyvo6+Orcpp/aqsYNNU+HB/LfAtKNYE
         HJCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727886415; x=1728491215;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C/ijsoZNLuIwPR396i1gI0b/SFMI/hxV4hjgGBBm/0E=;
        b=Bv1XroE2/JT86fPKEHz8nFPiByCaapXk1scKVqS33WwiHwRBATnHfZ79ti3KJlQ4Ys
         YQbAGk0fD3rsz6CgaE4A3uzsQ8EPkvJg7krgGXdPSgdQlKTwxCljxU8R8chweQV8tZsr
         tBsh+TOOy+5DWSCzqhWDPCE+utqWnU8zuQHl9S0Ou74iOqRomTd2s++53ZmFtbndz44V
         0WgGnHN5JpBgTwPbshqeuPcd3Z/ukbeZdtEW2/r2cpH7ecTlAmtc4trzAgOO//pdtaaw
         /U5NIKIFtYH83MKuJlXRxqAYan4HGq83HC3c5TpN0iVFFLyscyWg5l9L3sCv+lpXvcnj
         XOjA==
X-Forwarded-Encrypted: i=1; AJvYcCUUfEZaoTkwC0XqIoeJHngKnphPPjfj4oSV1VSPKMKEK8COv0uG7n7V9tpn7xQc5sao5zd+bFkE9fVdeKY=@vger.kernel.org, AJvYcCUmDUaoSjZNelGAVUt3QATTn0un5hN67Y2DEpy1oKJ3dKZBNipsfnBp0aW+VBis2Rkg8ftzkas/he66@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/e6bLSNYQMXUZK0SRJGxqeyk99lmAFXjrV22KfOAXEcjM/R1Y
	KDOrubaPeG3BEVFAt0Nz70wP12kvJgZPijPuZVtqQKeytTOFi9StiNNJCPkS
X-Google-Smtp-Source: AGHT+IG53Q5adwH4aJi6SxeF1eNCQIgtCWq4rnbahNuAMDGzVZbnr+JtUG2IwgTSDGYNMJ0suHgVTA==
X-Received: by 2002:a05:6512:402a:b0:536:9f72:c427 with SMTP id 2adb3069b0e04-539a0685057mr2157450e87.28.1727886414725;
        Wed, 02 Oct 2024 09:26:54 -0700 (PDT)
Received: from localhost (craw-09-b2-v4wan-169726-cust2117.vm24.cable.virginm.net. [92.238.24.70])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c2947afesm887305666b.120.2024.10.02.09.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 09:26:53 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] spi: spi-ti-qspi: remove redundant assignment to variable ret
Date: Wed,  2 Oct 2024 17:26:52 +0100
Message-Id: <20241002162652.957102-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Variable ret is being assigned a value but it is never read, instead
the variable is being reassigned later in the exit path via label
no_dma. Remove the redundant assignment.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/spi/spi-ti-qspi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index 0b8f496c6bf4..dfd4a7948c03 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -861,11 +861,10 @@ static int ti_qspi_probe(struct platform_device *pdev)
 	qspi->rx_chan = dma_request_chan_by_mask(&mask);
 	if (IS_ERR(qspi->rx_chan)) {
 		dev_err(qspi->dev,
 			"No Rx DMA available, trying mmap mode\n");
 		qspi->rx_chan = NULL;
-		ret = 0;
 		goto no_dma;
 	}
 	qspi->rx_bb_addr = dma_alloc_coherent(qspi->dev,
 					      QSPI_DMA_BUFFER_SIZE,
 					      &qspi->rx_bb_dma_addr,
-- 
2.39.5


