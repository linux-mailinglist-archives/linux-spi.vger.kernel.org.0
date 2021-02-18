Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4865631EC79
	for <lists+linux-spi@lfdr.de>; Thu, 18 Feb 2021 17:49:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbhBRQqK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 18 Feb 2021 11:46:10 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:9475 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232613AbhBRNCp (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 18 Feb 2021 08:02:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1613653364; x=1645189364;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1nqJ0Gg1qcZ3QqcAwBdTbK3n07OiNWC0tsX1jcaj+Ls=;
  b=MoloOZ2BJI+r98u4UTIwE0HUMccz7Axn5FElsAEOr/Tbw3eYkr0YQPFm
   XHTblqEzLyprWZ/UeQdfuCd6D+hZLTyrt/zANPPvmvJQ7oXAI3zdikTdE
   SraVeqLOJzZ7T7nF/gOXh5RbVr6fzXkXcYXzryKOoPREib8atNNpBjPm3
   EhvjG0+BOyYo+6MZCzC1fRUy405ZT0jWiV9z2crk/zyfujZYnw7zkCkWa
   5Ax21tUYTPjr65zqPJyCoeH7D/xCqf53y/WJTy57U6LS/g27nJjLeRau5
   j7ggQyKyGgvW/TgrlY2PKl6Z40b3zBypbBAXdSeM3bN7h++TlOVW0xmm9
   A==;
IronPort-SDR: Vwr9YfQLqS7VLCApeUuub6YYhDN5Nw+L+zilfNstPubdIlIxDD0wciFQrop9pesDPjaB+RFRT5
 vgSap0m0/EA4G2D9LD0JSMB/48lR4PyQbh+C2F8t8548MLxuB2QG3BJTnzHUJt1iZleIIXa9eN
 BS3Ym+dQG279bOVEPuRXEi1SR/WJ9UFfSUfKxtDOTX7mRKQ/FEDQRJ7eQKqukLbA9KMlNCB7lM
 o8S45aOKViWAJL/F67omfoNhoBaVs0RH9kSq5BTDe0virh44g+aqgwzOt2LygsYkGoGgB+bOfJ
 GQc=
X-IronPort-AV: E=Sophos;i="5.81,187,1610434800"; 
   d="scan'208";a="107103315"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 Feb 2021 06:01:07 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 18 Feb 2021 06:01:07 -0700
Received: from atudor-ThinkPad-T470p.amer.actel.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Thu, 18 Feb 2021 06:01:05 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <broonie@kernel.org>, <vigneshr@ti.com>
CC:     <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH] spi: spi-ti-qspi: Free DMA resources
Date:   Thu, 18 Feb 2021 15:01:04 +0200
Message-ID: <20210218130104.89506-1-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Release the RX channel and free the dma coherent memory when
devm_spi_register_master() fails

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/spi/spi-ti-qspi.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index 9417385c0921..e06aafe169e0 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -733,6 +733,17 @@ static int ti_qspi_runtime_resume(struct device *dev)
 	return 0;
 }
 
+static void ti_qspi_dma_cleanup(struct ti_qspi *qspi)
+{
+	if (qspi->rx_bb_addr)
+		dma_free_coherent(qspi->dev, QSPI_DMA_BUFFER_SIZE,
+				  qspi->rx_bb_addr,
+				  qspi->rx_bb_dma_addr);
+
+	if (qspi->rx_chan)
+		dma_release_channel(qspi->rx_chan);
+}
+
 static const struct of_device_id ti_qspi_match[] = {
 	{.compatible = "ti,dra7xxx-qspi" },
 	{.compatible = "ti,am4372-qspi" },
@@ -886,6 +897,8 @@ static int ti_qspi_probe(struct platform_device *pdev)
 	if (!ret)
 		return 0;
 
+	ti_qspi_dma_cleanup(qspi);
+
 	pm_runtime_disable(&pdev->dev);
 free_master:
 	spi_master_put(master);
@@ -904,12 +917,7 @@ static int ti_qspi_remove(struct platform_device *pdev)
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
-	if (qspi->rx_bb_addr)
-		dma_free_coherent(qspi->dev, QSPI_DMA_BUFFER_SIZE,
-				  qspi->rx_bb_addr,
-				  qspi->rx_bb_dma_addr);
-	if (qspi->rx_chan)
-		dma_release_channel(qspi->rx_chan);
+	ti_qspi_dma_cleanup(qspi);
 
 	return 0;
 }
-- 
2.25.1

