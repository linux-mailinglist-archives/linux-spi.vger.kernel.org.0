Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3282926495A
	for <lists+linux-spi@lfdr.de>; Thu, 10 Sep 2020 18:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725945AbgIJQKT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 10 Sep 2020 12:10:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:56388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731467AbgIJQHQ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 10 Sep 2020 12:07:16 -0400
Received: from localhost.localdomain (unknown [194.230.155.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7ABEA206A1;
        Thu, 10 Sep 2020 16:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599754035;
        bh=MKkXukV8EeYZX4MPiNOE6v88lPWyv1nk40pneoL9Dvc=;
        h=From:To:Cc:Subject:Date:From;
        b=YV2va4k8GgatPE4HjkQT6wxJMB018tzsU6wdlU112HCu8qtIQXQMZLx3sTUYfFctD
         5RKV10u/yvdA1+Ll/x8FC67sYpi1JLs/iyRQDYrhi/Kmkfv9iZnGTEJ9/KgeQsYW52
         2zWYvCiGSDi2Ft9CiL2uqOAWhSwDk7pawAKzIfW4=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Mark Brown <broonie@kernel.org>, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH REBASE] spi: sprd: Simplify with dev_err_probe()
Date:   Thu, 10 Sep 2020 18:07:06 +0200
Message-Id: <20200910160706.5883-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Common pattern of handling deferred probe can be simplified with
dev_err_probe().  Less code and the error value gets printed.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Acked-by: Chunyan Zhang <zhang.lyra@gmail.com>

---

Rebased on broonie/spi.git, for-5.10
---
 drivers/spi/spi-sprd-adi.c |  5 +----
 drivers/spi/spi-sprd.c     | 17 +++++------------
 2 files changed, 6 insertions(+), 16 deletions(-)

diff --git a/drivers/spi/spi-sprd-adi.c b/drivers/spi/spi-sprd-adi.c
index 127b8bd25831..392ec5cfa3d6 100644
--- a/drivers/spi/spi-sprd-adi.c
+++ b/drivers/spi/spi-sprd-adi.c
@@ -504,10 +504,7 @@ static int sprd_adi_probe(struct platform_device *pdev)
 			dev_info(&pdev->dev, "no hardware spinlock supplied\n");
 			break;
 		default:
-			dev_err(&pdev->dev,
-				"failed to find hwlock id, %d\n", ret);
-			fallthrough;
-		case -EPROBE_DEFER:
+			dev_err_probe(&pdev->dev, ret, "failed to find hwlock id\n");
 			goto put_ctlr;
 		}
 	}
diff --git a/drivers/spi/spi-sprd.c b/drivers/spi/spi-sprd.c
index 0443fec3a6ab..635738f54c73 100644
--- a/drivers/spi/spi-sprd.c
+++ b/drivers/spi/spi-sprd.c
@@ -553,22 +553,15 @@ static int sprd_spi_dma_tx_config(struct sprd_spi *ss, struct spi_transfer *t)
 static int sprd_spi_dma_request(struct sprd_spi *ss)
 {
 	ss->dma.dma_chan[SPRD_SPI_RX] = dma_request_chan(ss->dev, "rx_chn");
-	if (IS_ERR_OR_NULL(ss->dma.dma_chan[SPRD_SPI_RX])) {
-		if (PTR_ERR(ss->dma.dma_chan[SPRD_SPI_RX]) == -EPROBE_DEFER)
-			return PTR_ERR(ss->dma.dma_chan[SPRD_SPI_RX]);
-
-		dev_err(ss->dev, "request RX DMA channel failed!\n");
-		return PTR_ERR(ss->dma.dma_chan[SPRD_SPI_RX]);
-	}
+	if (IS_ERR_OR_NULL(ss->dma.dma_chan[SPRD_SPI_RX]))
+		return dev_err_probe(ss->dev, PTR_ERR(ss->dma.dma_chan[SPRD_SPI_RX]),
+				     "request RX DMA channel failed!\n");
 
 	ss->dma.dma_chan[SPRD_SPI_TX]  = dma_request_chan(ss->dev, "tx_chn");
 	if (IS_ERR_OR_NULL(ss->dma.dma_chan[SPRD_SPI_TX])) {
 		dma_release_channel(ss->dma.dma_chan[SPRD_SPI_RX]);
-		if (PTR_ERR(ss->dma.dma_chan[SPRD_SPI_TX]) == -EPROBE_DEFER)
-			return PTR_ERR(ss->dma.dma_chan[SPRD_SPI_TX]);
-
-		dev_err(ss->dev, "request TX DMA channel failed!\n");
-		return PTR_ERR(ss->dma.dma_chan[SPRD_SPI_TX]);
+		return dev_err_probe(ss->dev, PTR_ERR(ss->dma.dma_chan[SPRD_SPI_TX]),
+				     "request TX DMA channel failed!\n");
 	}
 
 	return 0;
-- 
2.17.1

