Return-Path: <linux-spi+bounces-1017-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A70AD84905D
	for <lists+linux-spi@lfdr.de>; Sun,  4 Feb 2024 21:31:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ED752819D2
	for <lists+linux-spi@lfdr.de>; Sun,  4 Feb 2024 20:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABCAF2BB14;
	Sun,  4 Feb 2024 20:31:35 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from fgw20-7.mail.saunalahti.fi (fgw20-7.mail.saunalahti.fi [62.142.5.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8E325561
	for <linux-spi@vger.kernel.org>; Sun,  4 Feb 2024 20:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707078695; cv=none; b=HYndV59iKGJ/p7nec76+eP8Fz+DTwV6dIb64wRIL1098riOUFkhxM6Hlqb+FvkRzERCTiurn59Hn/7uc7dIVpiXPnRmF2svhVOmok+rE/V83+Xy4rS9EJHlxgxtceJz7BYW+H0kX9i1fId1SOnHuAS6kI7+vaF2Vv9fhQnNSy4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707078695; c=relaxed/simple;
	bh=XLDi5/MAVt+bIe/YQBcfp7eO7Bz7U9KmRyihYGtcmdA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iAGvLoz3avUjw6IejwzAmw0QuPhl76Z4f+XNd/lpSKsXFQBraw8qg/of8/PDm0Mahb+CzQVgZ+Yn5j2V4og19Qd+y7zBNiURe79Cj4PeOAvZXgYmfCGtlJ4Q0TPk0nn9YceYMZvbj2QysrbuDXU1L8NhcO6YMtxH4k+i+cgKTSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-30.elisa-laajakaista.fi [88.113.26.30])
	by fgw20.mail.saunalahti.fi (Halon) with ESMTP
	id 61e52b80-c39c-11ee-b3cf-005056bd6ce9;
	Sun, 04 Feb 2024 22:31:31 +0200 (EET)
From: andy.shevchenko@gmail.com
To: Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Vladimir Oltean <olteanv@gmail.com>,
	Minjie Du <duminjie@vivo.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v2 2/2] spi: fsl-dspi: Unify error messaging in dspi_request_dma()
Date: Sun,  4 Feb 2024 22:29:19 +0200
Message-ID: <20240204203127.1186621-3-andy.shevchenko@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240204203127.1186621-1-andy.shevchenko@gmail.com>
References: <20240204203127.1186621-1-andy.shevchenko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use dev_err_probe() for all messages in dspi_request_dma() for the sake of
making them uniform. While at it, fix indentation issue reported by Vladimir
Oltean.

Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/spi/spi-fsl-dspi.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 0b5ea7a7da71..38defdcf9370 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -502,15 +502,12 @@ static int dspi_request_dma(struct fsl_dspi *dspi, phys_addr_t phy_addr)
 		return -ENOMEM;
 
 	dma->chan_rx = dma_request_chan(dev, "rx");
-	if (IS_ERR(dma->chan_rx)) {
-		return dev_err_probe(dev, PTR_ERR(dma->chan_rx),
-			"rx dma channel not available\n");
-	}
+	if (IS_ERR(dma->chan_rx))
+		return dev_err_probe(dev, PTR_ERR(dma->chan_rx), "rx dma channel not available\n");
 
 	dma->chan_tx = dma_request_chan(dev, "tx");
 	if (IS_ERR(dma->chan_tx)) {
-		ret = PTR_ERR(dma->chan_tx);
-		dev_err_probe(dev, ret, "tx dma channel not available\n");
+		ret = dev_err_probe(dev, PTR_ERR(dma->chan_tx), "tx dma channel not available\n");
 		goto err_tx_channel;
 	}
 
@@ -541,14 +538,14 @@ static int dspi_request_dma(struct fsl_dspi *dspi, phys_addr_t phy_addr)
 	cfg.direction = DMA_DEV_TO_MEM;
 	ret = dmaengine_slave_config(dma->chan_rx, &cfg);
 	if (ret) {
-		dev_err(dev, "can't configure rx dma channel\n");
+		dev_err_probe(dev, ret, "can't configure rx dma channel\n");
 		goto err_slave_config;
 	}
 
 	cfg.direction = DMA_MEM_TO_DEV;
 	ret = dmaengine_slave_config(dma->chan_tx, &cfg);
 	if (ret) {
-		dev_err(dev, "can't configure tx dma channel\n");
+		dev_err_probe(dev, ret, "can't configure tx dma channel\n");
 		goto err_slave_config;
 	}
 
-- 
2.43.0


