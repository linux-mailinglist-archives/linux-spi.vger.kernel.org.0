Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75B86772476
	for <lists+linux-spi@lfdr.de>; Mon,  7 Aug 2023 14:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232715AbjHGMoP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 7 Aug 2023 08:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233043AbjHGMoN (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 7 Aug 2023 08:44:13 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AF3A1710
        for <linux-spi@vger.kernel.org>; Mon,  7 Aug 2023 05:44:11 -0700 (PDT)
Received: from dggpemm100014.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RKGBf1KlsztRyR;
        Mon,  7 Aug 2023 20:40:42 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm100014.china.huawei.com (7.185.36.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 7 Aug 2023 20:44:09 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 7 Aug
 2023 20:44:08 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next 06/20] spi: fsl-dspi: switch to use modern name
Date:   Mon, 7 Aug 2023 20:40:51 +0800
Message-ID: <20230807124105.3429709-7-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230807124105.3429709-1-yangyingliang@huawei.com>
References: <20230807124105.3429709-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Change legacy name master/target to modern name host/target or controller.

No functional changed.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/spi/spi-fsl-dspi.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 150d2ebf234b..8318249f8a1f 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -23,7 +23,7 @@
 #define DRIVER_NAME			"fsl-dspi"
 
 #define SPI_MCR				0x00
-#define SPI_MCR_MASTER			BIT(31)
+#define SPI_MCR_HOST			BIT(31)
 #define SPI_MCR_PCSIS(x)		((x) << 16)
 #define SPI_MCR_CLR_TXF			BIT(11)
 #define SPI_MCR_CLR_RXF			BIT(10)
@@ -340,7 +340,7 @@ static u32 dspi_pop_tx_pushr(struct fsl_dspi *dspi)
 {
 	u16 cmd = dspi->tx_cmd, data = dspi_pop_tx(dspi);
 
-	if (spi_controller_is_slave(dspi->ctlr))
+	if (spi_controller_is_target(dspi->ctlr))
 		return data;
 
 	if (dspi->len > 0)
@@ -430,7 +430,7 @@ static int dspi_next_xfer_dma_submit(struct fsl_dspi *dspi)
 	dma_async_issue_pending(dma->chan_rx);
 	dma_async_issue_pending(dma->chan_tx);
 
-	if (spi_controller_is_slave(dspi->ctlr)) {
+	if (spi_controller_is_target(dspi->ctlr)) {
 		wait_for_completion_interruptible(&dspi->dma->cmd_rx_complete);
 		return 0;
 	}
@@ -1061,7 +1061,7 @@ static int dspi_setup(struct spi_device *spi)
 	if (spi->mode & SPI_CPHA)
 		chip->ctar_val |= SPI_CTAR_CPHA;
 
-	if (!spi_controller_is_slave(dspi->ctlr)) {
+	if (!spi_controller_is_target(dspi->ctlr)) {
 		chip->ctar_val |= SPI_CTAR_PCSSCK(pcssck) |
 				  SPI_CTAR_CSSCK(cssck) |
 				  SPI_CTAR_PASC(pasc) |
@@ -1216,8 +1216,8 @@ static int dspi_init(struct fsl_dspi *dspi)
 
 	if (dspi->devtype_data->trans_mode == DSPI_XSPI_MODE)
 		mcr |= SPI_MCR_XSPI;
-	if (!spi_controller_is_slave(dspi->ctlr))
-		mcr |= SPI_MCR_MASTER;
+	if (!spi_controller_is_target(dspi->ctlr))
+		mcr |= SPI_MCR_HOST;
 
 	regmap_write(dspi->regmap, SPI_MCR, mcr);
 	regmap_write(dspi->regmap, SPI_SR, SPI_SR_CLEAR);
@@ -1240,13 +1240,13 @@ static int dspi_init(struct fsl_dspi *dspi)
 	return 0;
 }
 
-static int dspi_slave_abort(struct spi_master *master)
+static int dspi_target_abort(struct spi_controller *host)
 {
-	struct fsl_dspi *dspi = spi_master_get_devdata(master);
+	struct fsl_dspi *dspi = spi_controller_get_devdata(host);
 
 	/*
 	 * Terminate all pending DMA transactions for the SPI working
-	 * in SLAVE mode.
+	 * in TARGET mode.
 	 */
 	if (dspi->devtype_data->trans_mode == DSPI_DMA_MODE) {
 		dmaengine_terminate_sync(dspi->dma->chan_rx);
@@ -1277,7 +1277,7 @@ static int dspi_probe(struct platform_device *pdev)
 	if (!dspi)
 		return -ENOMEM;
 
-	ctlr = spi_alloc_master(&pdev->dev, 0);
+	ctlr = spi_alloc_host(&pdev->dev, 0);
 	if (!ctlr)
 		return -ENOMEM;
 
@@ -1292,7 +1292,7 @@ static int dspi_probe(struct platform_device *pdev)
 	ctlr->dev.of_node = pdev->dev.of_node;
 
 	ctlr->cleanup = dspi_cleanup;
-	ctlr->slave_abort = dspi_slave_abort;
+	ctlr->target_abort = dspi_target_abort;
 	ctlr->mode_bits = SPI_CPOL | SPI_CPHA | SPI_LSB_FIRST;
 	ctlr->use_gpio_descriptors = true;
 
@@ -1317,7 +1317,7 @@ static int dspi_probe(struct platform_device *pdev)
 		ctlr->bus_num = bus_num;
 
 		if (of_property_read_bool(np, "spi-slave"))
-			ctlr->slave = true;
+			ctlr->target = true;
 
 		dspi->devtype_data = of_device_get_match_data(&pdev->dev);
 		if (!dspi->devtype_data) {
-- 
2.25.1

