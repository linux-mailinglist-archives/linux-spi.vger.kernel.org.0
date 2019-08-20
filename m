Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA9595FA3
	for <lists+linux-spi@lfdr.de>; Tue, 20 Aug 2019 15:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729977AbfHTNOc (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 20 Aug 2019 09:14:32 -0400
Received: from mail-ed1-f100.google.com ([209.85.208.100]:45214 "EHLO
        mail-ed1-f100.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729980AbfHTNOa (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 20 Aug 2019 09:14:30 -0400
Received: by mail-ed1-f100.google.com with SMTP id x19so6264534eda.12
        for <linux-spi@vger.kernel.org>; Tue, 20 Aug 2019 06:14:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:message-id:date;
        bh=y8NEIzFuccJkqq1HoO15r1xFXDcAkdT8dzITlSKrNTM=;
        b=iIS7fr0fm5TmHKu9twmgZh2xpGIDPMkE0bInlUj5YEVSbaeKs9oEFqqORR3440Jl16
         sffBAtqCbQZQjkORKAQkNVA5fEOxa8xjIpftQrXuoqZcK1qaTSmecrdHcXfURxEKwi0N
         A1IAjanWEHW4AWJliGXZoQkk09twVYZ+VBh2HRO4kP0cNlN3uHVAeHisSb5ND1/EUVAh
         dzDy/nsYqj80V3feET5rvDeFAPu9n1dE7CneygF105C/kf9Ca5NMUc7IjZLUTbimorEy
         ABnhd9Ok+bniZL+mq1+T/wxgKIWwIzLnHQE0QFyjF3+GrQKRH3iChtwrhL0LBuZeRyNR
         c/5w==
X-Gm-Message-State: APjAAAWKTqAdompzukldUnr3BMZFR8EptqjkbiyRgz3182cD20QevROE
        Kc/4sPgiE19WemmeMGiR/UVSYXRnPLIcwOqyAsH1HgQBDCsaeqdxV5RSZpn9FBZkgQ==
X-Google-Smtp-Source: APXvYqyBQOcca5AeihdJS3MWnRtEoKRk0XV/3d8nQTf9bUm+5k0JKqqblMYJBh9ufnPl5sGDmnjbdOEaXdKE
X-Received: by 2002:a17:906:4882:: with SMTP id v2mr26419153ejq.100.1566306868520;
        Tue, 20 Aug 2019 06:14:28 -0700 (PDT)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk. [2a01:7e01::f03c:91ff:fed4:a3b6])
        by smtp-relay.gmail.com with ESMTPS id jp26sm114264ejb.84.2019.08.20.06.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 06:14:28 -0700 (PDT)
X-Relaying-Domain: sirena.org.uk
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1i03y0-0002M2-3i; Tue, 20 Aug 2019 13:14:28 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 3B6F5274314E; Tue, 20 Aug 2019 14:14:27 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     broonie@kernel.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: Applied "spi: spi-fsl-dspi: Reduce indentation in dspi_release_dma()" to the spi tree
In-Reply-To: <20190818180115.31114-7-olteanv@gmail.com>
X-Patchwork-Hint: ignore
Message-Id: <20190820131427.3B6F5274314E@ypsilon.sirena.org.uk>
Date:   Tue, 20 Aug 2019 14:14:27 +0100 (BST)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: spi-fsl-dspi: Reduce indentation in dspi_release_dma()

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.4

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From abbd0ef1f2542621e0f94a7273b7f7e458a38497 Mon Sep 17 00:00:00 2001
From: Vladimir Oltean <olteanv@gmail.com>
Date: Sun, 18 Aug 2019 21:01:07 +0300
Subject: [PATCH] spi: spi-fsl-dspi: Reduce indentation in dspi_release_dma()

There is no point in surrounding an entire function block in an if
condition. Rather, exit early if the condition is false.

Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
Link: https://lore.kernel.org/r/20190818180115.31114-7-olteanv@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.20.1

