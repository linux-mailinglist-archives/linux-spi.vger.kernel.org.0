Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E27B91896
	for <lists+linux-spi@lfdr.de>; Sun, 18 Aug 2019 20:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbfHRSB2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 18 Aug 2019 14:01:28 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33949 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbfHRSB1 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 18 Aug 2019 14:01:27 -0400
Received: by mail-wm1-f67.google.com with SMTP id e8so1111888wme.1
        for <linux-spi@vger.kernel.org>; Sun, 18 Aug 2019 11:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AiTOhUrHkq+8s8kUOBabvrNc3e7/F8foJzYnk9wfp+o=;
        b=dVVZjP0YIKGge43LOWYDfB6U1NelgrDehaFg/sP/gK6sO+VdFEGupR9Mzru3vY2Lxv
         ja/+QY1UHQbGaG0u4cPzB5NLw6zmzMXBfvoDe8UkIZeNPZ4MQ0710vU994Tjr+yQo8T2
         h/jPAuXhbTYnAM10VG+TlWnk5xsdmgowL1tNK58Lqq8Hl239ZBkC4KQrjVDRAUsK2vvn
         jbhaJP4AWdbwjhtQs14M9pU1FGibxQzcd8SDS0LTL4OJxseQEXPkxYUV5aZIlVP8MN6D
         6+PzIscIPqkKZ+kOYSiE+xm60oYLV1UO/3Qguao1si4xR2PLi4JKWMzEuZlOdJyEugAc
         +a0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AiTOhUrHkq+8s8kUOBabvrNc3e7/F8foJzYnk9wfp+o=;
        b=Mi1/JwbtI24Wj59bQzE0V6pmLmEskVf93wEeMUGu+wkof1SRkbCXBa3vYKc45tsfu8
         cxJEuIway9ols1W+MqYGT5ZSN9N1VKg/qXWrj4WMJjq4R+otjp9c/EiTqROFlcsahmec
         7rull5tyq8itWrOmXl/ljkGdNApos+wexcBKL39P7/8PeZWWWi7NYJYyfwf9BTjA2Vj8
         xVKb4t8iy5H/+LN8/FId9eT3GKuAIRk59pAPSung6HWnpEHaz+EJS92O8vfTpfHo+O2a
         F1xHW0ufIUKHD8YkY/ejpp3vxax0TZAhUHE954wXHA2ZZLUjWu7nsLRiJz68GzLnEoeL
         W5Mw==
X-Gm-Message-State: APjAAAXy0kVzYbp+MTxD76VA/augW9dAoo8JBc+W0y8NV3mCvPJWg7rs
        vXh7o6i2vPonWw8Q+EH72KY=
X-Google-Smtp-Source: APXvYqyqW3SPqpa2m/lsZ+zjZgpLp+im5nrYbMfZsQdFC5//DG11yrVNr00ClqkNjAz+FNHAfwRhNg==
X-Received: by 2002:a7b:c649:: with SMTP id q9mr16324484wmk.108.1566151285807;
        Sun, 18 Aug 2019 11:01:25 -0700 (PDT)
Received: from localhost.localdomain ([188.25.91.80])
        by smtp.gmail.com with ESMTPSA id x6sm9372246wmf.6.2019.08.18.11.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2019 11:01:25 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH spi for-5.4 06/14] spi: spi-fsl-dspi: Reduce indentation in dspi_release_dma()
Date:   Sun, 18 Aug 2019 21:01:07 +0300
Message-Id: <20190818180115.31114-7-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190818180115.31114-1-olteanv@gmail.com>
References: <20190818180115.31114-1-olteanv@gmail.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

There is no point in surrounding an entire function block in an if
condition. Rather, exit early if the condition is false.

Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
---
 drivers/spi/spi-fsl-dspi.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index b0c546841260..c07525a9fd34 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -471,18 +471,19 @@ static void dspi_release_dma(struct fsl_dspi *dspi)
 	struct fsl_dspi_dma *dma = dspi->dma;
 	struct device *dev = &dspi->pdev->dev;
 
-	if (dma) {
-		if (dma->chan_tx) {
-			dma_unmap_single(dev, dma->tx_dma_phys,
-					DSPI_DMA_BUFSIZE, DMA_TO_DEVICE);
-			dma_release_channel(dma->chan_tx);
-		}
+	if (!dma)
+		return;
 
-		if (dma->chan_rx) {
-			dma_unmap_single(dev, dma->rx_dma_phys,
-					DSPI_DMA_BUFSIZE, DMA_FROM_DEVICE);
-			dma_release_channel(dma->chan_rx);
-		}
+	if (dma->chan_tx) {
+		dma_unmap_single(dev, dma->tx_dma_phys,
+				 DSPI_DMA_BUFSIZE, DMA_TO_DEVICE);
+		dma_release_channel(dma->chan_tx);
+	}
+
+	if (dma->chan_rx) {
+		dma_unmap_single(dev, dma->rx_dma_phys,
+				 DSPI_DMA_BUFSIZE, DMA_FROM_DEVICE);
+		dma_release_channel(dma->chan_rx);
 	}
 }
 
-- 
2.17.1

