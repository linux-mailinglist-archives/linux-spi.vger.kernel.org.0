Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 709D9151ABC
	for <lists+linux-spi@lfdr.de>; Tue,  4 Feb 2020 13:48:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbgBDMsA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 4 Feb 2020 07:48:00 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:45732 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727126AbgBDMsA (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 4 Feb 2020 07:48:00 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 014ClwSM039039;
        Tue, 4 Feb 2020 06:47:58 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1580820478;
        bh=ZTYJ1Y/H4Bvtst5VFgLrUVIECr+vtmgG5tDGb7eDPZU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=UiMUWowUNgVnktney7M4Pg4afBfo4chSZqE16B3W03+zTRrWwZEoWr4iw9vfoshy8
         BuPpQVrD+AM3l3T/smnnVdbvQjB97wzpVRKb9IU9vDCe8V0KRQy7+t5hfWTkumbZj8
         7LtFOqs6Npl3/mymsT2BKBYXQIFV8G8R0s+wXbRI=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 014ClwZu014215;
        Tue, 4 Feb 2020 06:47:58 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 4 Feb
 2020 06:47:57 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 4 Feb 2020 06:47:57 -0600
Received: from a0132425.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 014Clgca095019;
        Tue, 4 Feb 2020 06:47:54 -0600
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Vignesh Raghavendra <vigneshr@ti.com>, <linux-spi@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] spi: spi-omap2-mcspi: Support probe deferral for DMA channels
Date:   Tue, 4 Feb 2020 18:18:16 +0530
Message-ID: <20200204124816.16735-3-vigneshr@ti.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200204124816.16735-1-vigneshr@ti.com>
References: <20200204124816.16735-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

dma_request_channel() can return -EPROBE_DEFER, if DMA driver is not
ready. Currently driver just falls back to PIO mode on probe deferral.
Fix this by requesting all required channels during probe and
propagating EPROBE_DEFER error code.

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 drivers/spi/spi-omap2-mcspi.c | 77 +++++++++++++++++------------------
 1 file changed, 38 insertions(+), 39 deletions(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index e9bc9cf984d6..e9e256718ef4 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -975,20 +975,12 @@ static int omap2_mcspi_setup_transfer(struct spi_device *spi,
  * Note that we currently allow DMA only if we get a channel
  * for both rx and tx. Otherwise we'll do PIO for both rx and tx.
  */
-static int omap2_mcspi_request_dma(struct spi_device *spi)
+static int omap2_mcspi_request_dma(struct omap2_mcspi *mcspi,
+				   struct omap2_mcspi_dma *mcspi_dma)
 {
-	struct spi_master	*master = spi->master;
-	struct omap2_mcspi	*mcspi;
-	struct omap2_mcspi_dma	*mcspi_dma;
 	int ret = 0;
 
-	mcspi = spi_master_get_devdata(master);
-	mcspi_dma = mcspi->dma_channels + spi->chip_select;
-
-	init_completion(&mcspi_dma->dma_rx_completion);
-	init_completion(&mcspi_dma->dma_tx_completion);
-
-	mcspi_dma->dma_rx = dma_request_chan(&master->dev,
+	mcspi_dma->dma_rx = dma_request_chan(mcspi->dev,
 					     mcspi_dma->dma_rx_ch_name);
 	if (IS_ERR(mcspi_dma->dma_rx)) {
 		ret = PTR_ERR(mcspi_dma->dma_rx);
@@ -996,7 +988,7 @@ static int omap2_mcspi_request_dma(struct spi_device *spi)
 		goto no_dma;
 	}
 
-	mcspi_dma->dma_tx = dma_request_chan(&master->dev,
+	mcspi_dma->dma_tx = dma_request_chan(mcspi->dev,
 					     mcspi_dma->dma_tx_ch_name);
 	if (IS_ERR(mcspi_dma->dma_tx)) {
 		ret = PTR_ERR(mcspi_dma->dma_tx);
@@ -1005,20 +997,40 @@ static int omap2_mcspi_request_dma(struct spi_device *spi)
 		mcspi_dma->dma_rx = NULL;
 	}
 
+	init_completion(&mcspi_dma->dma_rx_completion);
+	init_completion(&mcspi_dma->dma_tx_completion);
+
 no_dma:
 	return ret;
 }
 
+static void omap2_mcspi_release_dma(struct spi_master *master)
+{
+	struct omap2_mcspi *mcspi = spi_master_get_devdata(master);
+	struct omap2_mcspi_dma	*mcspi_dma;
+	int i;
+
+	for (i = 0; i < master->num_chipselect; i++) {
+		mcspi_dma = &mcspi->dma_channels[i];
+
+		if (mcspi_dma->dma_rx) {
+			dma_release_channel(mcspi_dma->dma_rx);
+			mcspi_dma->dma_rx = NULL;
+		}
+		if (mcspi_dma->dma_tx) {
+			dma_release_channel(mcspi_dma->dma_tx);
+			mcspi_dma->dma_tx = NULL;
+		}
+	}
+}
+
 static int omap2_mcspi_setup(struct spi_device *spi)
 {
 	int			ret;
 	struct omap2_mcspi	*mcspi = spi_master_get_devdata(spi->master);
 	struct omap2_mcspi_regs	*ctx = &mcspi->ctx;
-	struct omap2_mcspi_dma	*mcspi_dma;
 	struct omap2_mcspi_cs	*cs = spi->controller_state;
 
-	mcspi_dma = &mcspi->dma_channels[spi->chip_select];
-
 	if (!cs) {
 		cs = kzalloc(sizeof *cs, GFP_KERNEL);
 		if (!cs)
@@ -1043,13 +1055,6 @@ static int omap2_mcspi_setup(struct spi_device *spi)
 		}
 	}
 
-	if (!mcspi_dma->dma_rx || !mcspi_dma->dma_tx) {
-		ret = omap2_mcspi_request_dma(spi);
-		if (ret)
-			dev_warn(&spi->dev, "not using DMA for McSPI (%d)\n",
-				 ret);
-	}
-
 	ret = pm_runtime_get_sync(mcspi->dev);
 	if (ret < 0) {
 		pm_runtime_put_noidle(mcspi->dev);
@@ -1066,12 +1071,8 @@ static int omap2_mcspi_setup(struct spi_device *spi)
 
 static void omap2_mcspi_cleanup(struct spi_device *spi)
 {
-	struct omap2_mcspi	*mcspi;
-	struct omap2_mcspi_dma	*mcspi_dma;
 	struct omap2_mcspi_cs	*cs;
 
-	mcspi = spi_master_get_devdata(spi->master);
-
 	if (spi->controller_state) {
 		/* Unlink controller state from context save list */
 		cs = spi->controller_state;
@@ -1080,19 +1081,6 @@ static void omap2_mcspi_cleanup(struct spi_device *spi)
 		kfree(cs);
 	}
 
-	if (spi->chip_select < spi->master->num_chipselect) {
-		mcspi_dma = &mcspi->dma_channels[spi->chip_select];
-
-		if (mcspi_dma->dma_rx) {
-			dma_release_channel(mcspi_dma->dma_rx);
-			mcspi_dma->dma_rx = NULL;
-		}
-		if (mcspi_dma->dma_tx) {
-			dma_release_channel(mcspi_dma->dma_tx);
-			mcspi_dma->dma_tx = NULL;
-		}
-	}
-
 	if (gpio_is_valid(spi->cs_gpio))
 		gpio_free(spi->cs_gpio);
 }
@@ -1303,6 +1291,9 @@ static bool omap2_mcspi_can_dma(struct spi_master *master,
 	if (spi_controller_is_slave(master))
 		return true;
 
+	master->dma_rx = mcspi_dma->dma_rx;
+	master->dma_tx = mcspi_dma->dma_tx;
+
 	return (xfer->len >= DMA_MIN_BYTES);
 }
 
@@ -1490,6 +1481,11 @@ static int omap2_mcspi_probe(struct platform_device *pdev)
 	for (i = 0; i < master->num_chipselect; i++) {
 		sprintf(mcspi->dma_channels[i].dma_rx_ch_name, "rx%d", i);
 		sprintf(mcspi->dma_channels[i].dma_tx_ch_name, "tx%d", i);
+
+		status = omap2_mcspi_request_dma(mcspi,
+						 &mcspi->dma_channels[i]);
+		if (status == -EPROBE_DEFER)
+			goto free_master;
 	}
 
 	status = platform_get_irq(pdev, 0);
@@ -1527,6 +1523,7 @@ static int omap2_mcspi_probe(struct platform_device *pdev)
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 free_master:
+	omap2_mcspi_release_dma(master);
 	spi_master_put(master);
 	return status;
 }
@@ -1536,6 +1533,8 @@ static int omap2_mcspi_remove(struct platform_device *pdev)
 	struct spi_master *master = platform_get_drvdata(pdev);
 	struct omap2_mcspi *mcspi = spi_master_get_devdata(master);
 
+	omap2_mcspi_release_dma(master);
+
 	pm_runtime_dont_use_autosuspend(mcspi->dev);
 	pm_runtime_put_sync(mcspi->dev);
 	pm_runtime_disable(&pdev->dev);
-- 
2.25.0

