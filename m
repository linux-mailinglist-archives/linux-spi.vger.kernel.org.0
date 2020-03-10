Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9671806A9
	for <lists+linux-spi@lfdr.de>; Tue, 10 Mar 2020 19:35:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbgCJSfJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 10 Mar 2020 14:35:09 -0400
Received: from foss.arm.com ([217.140.110.172]:41010 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726283AbgCJSfJ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 10 Mar 2020 14:35:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EDAD030E;
        Tue, 10 Mar 2020 11:35:08 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6DA883F534;
        Tue, 10 Mar 2020 11:35:08 -0700 (PDT)
Date:   Tue, 10 Mar 2020 18:35:06 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: Applied "spi: spi-fsl-dspi: fix DMA mapping" to the spi tree
In-Reply-To:  <20200310073313.21277-1-michael@walle.cc>
Message-Id:  <applied-20200310073313.21277-1-michael@walle.cc>
X-Patchwork-Hint: ignore
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: spi-fsl-dspi: fix DMA mapping

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

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

From 22ee9de1ecfb4459a9b3a959994f6ccb4a3827a4 Mon Sep 17 00:00:00 2001
From: Michael Walle <michael@walle.cc>
Date: Tue, 10 Mar 2020 08:33:13 +0100
Subject: [PATCH] spi: spi-fsl-dspi: fix DMA mapping

Use the correct device to request the DMA mapping. Otherwise the IOMMU
doesn't get the mapping and it will generate a page fault.

The error messages look like:
[    3.008452] arm-smmu 5000000.iommu: Unhandled context fault: fsr=0x402, iova=0xf9800000, fsynr=0x3f0022, cbfrsynra=0x828, cb=8
[    3.020123] arm-smmu 5000000.iommu: Unhandled context fault: fsr=0x402, iova=0xf9800000, fsynr=0x3f0022, cbfrsynra=0x828, cb=8

This was tested on a custom board with a LS1028A SoC.

Signed-off-by: Michael Walle <michael@walle.cc>
Link: https://lore.kernel.org/r/20200310073313.21277-1-michael@walle.cc
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-fsl-dspi.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 0683a3fbd48c..50e3382f0c50 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -497,14 +497,16 @@ static int dspi_request_dma(struct fsl_dspi *dspi, phys_addr_t phy_addr)
 		goto err_tx_channel;
 	}
 
-	dma->tx_dma_buf = dma_alloc_coherent(dev, dspi->devtype_data->dma_bufsize,
+	dma->tx_dma_buf = dma_alloc_coherent(dma->chan_tx->device->dev,
+					     dspi->devtype_data->dma_bufsize,
 					     &dma->tx_dma_phys, GFP_KERNEL);
 	if (!dma->tx_dma_buf) {
 		ret = -ENOMEM;
 		goto err_tx_dma_buf;
 	}
 
-	dma->rx_dma_buf = dma_alloc_coherent(dev, dspi->devtype_data->dma_bufsize,
+	dma->rx_dma_buf = dma_alloc_coherent(dma->chan_rx->device->dev,
+					     dspi->devtype_data->dma_bufsize,
 					     &dma->rx_dma_phys, GFP_KERNEL);
 	if (!dma->rx_dma_buf) {
 		ret = -ENOMEM;
@@ -541,10 +543,12 @@ static int dspi_request_dma(struct fsl_dspi *dspi, phys_addr_t phy_addr)
 	return 0;
 
 err_slave_config:
-	dma_free_coherent(dev, dspi->devtype_data->dma_bufsize,
+	dma_free_coherent(dma->chan_rx->device->dev,
+			  dspi->devtype_data->dma_bufsize,
 			  dma->rx_dma_buf, dma->rx_dma_phys);
 err_rx_dma_buf:
-	dma_free_coherent(dev, dspi->devtype_data->dma_bufsize,
+	dma_free_coherent(dma->chan_tx->device->dev,
+			  dspi->devtype_data->dma_bufsize,
 			  dma->tx_dma_buf, dma->tx_dma_phys);
 err_tx_dma_buf:
 	dma_release_channel(dma->chan_tx);
@@ -560,20 +564,19 @@ static int dspi_request_dma(struct fsl_dspi *dspi, phys_addr_t phy_addr)
 static void dspi_release_dma(struct fsl_dspi *dspi)
 {
 	struct fsl_dspi_dma *dma = dspi->dma;
-	struct device *dev = &dspi->pdev->dev;
 
 	if (!dma)
 		return;
 
 	if (dma->chan_tx) {
-		dma_unmap_single(dev, dma->tx_dma_phys,
+		dma_unmap_single(dma->chan_tx->device->dev, dma->tx_dma_phys,
 				 dspi->devtype_data->dma_bufsize,
 				 DMA_TO_DEVICE);
 		dma_release_channel(dma->chan_tx);
 	}
 
 	if (dma->chan_rx) {
-		dma_unmap_single(dev, dma->rx_dma_phys,
+		dma_unmap_single(dma->chan_rx->device->dev, dma->rx_dma_phys,
 				 dspi->devtype_data->dma_bufsize,
 				 DMA_FROM_DEVICE);
 		dma_release_channel(dma->chan_rx);
-- 
2.20.1

