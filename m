Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8E577DD9A
	for <lists+linux-spi@lfdr.de>; Wed, 16 Aug 2023 11:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243457AbjHPJnk (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 16 Aug 2023 05:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243456AbjHPJna (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 16 Aug 2023 05:43:30 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F101E13E
        for <linux-spi@vger.kernel.org>; Wed, 16 Aug 2023 02:43:28 -0700 (PDT)
Received: from dggpemm500012.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RQjlp1PXrztRny;
        Wed, 16 Aug 2023 17:39:50 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500012.china.huawei.com (7.185.36.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 16 Aug 2023 17:43:26 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 16 Aug
 2023 17:43:26 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next 15/24] spi: rspi: switch to use modern name
Date:   Wed, 16 Aug 2023 17:40:04 +0800
Message-ID: <20230816094013.1275068-16-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230816094013.1275068-1-yangyingliang@huawei.com>
References: <20230816094013.1275068-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Change legacy name master/slave to modern name host/target.

No functional changed.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/spi/spi-rspi.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index 83bb16995e06..365434a448e4 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -71,7 +71,7 @@
 #define SPCR_SPE		0x40	/* Function Enable */
 #define SPCR_SPTIE		0x20	/* Transmit Interrupt Enable */
 #define SPCR_SPEIE		0x10	/* Error Interrupt Enable */
-#define SPCR_MSTR		0x08	/* Master/Slave Mode Select */
+#define SPCR_MSTR		0x08	/* Host/Target Mode Select */
 #define SPCR_MODFEN		0x04	/* Mode Fault Error Detection Enable */
 /* RSPI on SH only */
 #define SPCR_TXMD		0x02	/* TX Only Mode (vs. Full Duplex) */
@@ -1000,7 +1000,7 @@ static int rspi_prepare_message(struct spi_controller *ctlr,
 	if (spi->mode & SPI_LSB_FIRST)
 		rspi->spcmd |= SPCMD_LSBF;
 
-	/* Configure slave signal to assert */
+	/* Configure target signal to assert */
 	rspi->spcmd |= SPCMD_SSLA(spi_get_csgpiod(spi, 0) ? rspi->ctlr->unused_native_cs
 						: spi_get_chipselect(spi, 0));
 
@@ -1019,7 +1019,7 @@ static int rspi_prepare_message(struct spi_controller *ctlr,
 			return ret;
 	}
 
-	/* Enable SPI function in master mode */
+	/* Enable SPI function in host mode */
 	rspi_write8(rspi, rspi_read8(rspi, RSPI_SPCR) | SPCR_SPE, RSPI_SPCR);
 	return 0;
 }
@@ -1135,7 +1135,7 @@ static int rspi_request_dma(struct device *dev, struct spi_controller *ctlr,
 	unsigned int dma_tx_id, dma_rx_id;
 
 	if (dev->of_node) {
-		/* In the OF case we will get the slave IDs from the DT */
+		/* In the OF case we will get the target IDs from the DT */
 		dma_tx_id = 0;
 		dma_rx_id = 0;
 	} else if (rspi_pd && rspi_pd->dma_tx_id && rspi_pd->dma_rx_id) {
@@ -1294,7 +1294,7 @@ static int rspi_probe(struct platform_device *pdev)
 	const struct spi_ops *ops;
 	unsigned long clksrc;
 
-	ctlr = spi_alloc_master(&pdev->dev, sizeof(struct rspi_data));
+	ctlr = spi_alloc_host(&pdev->dev, sizeof(struct rspi_data));
 	if (ctlr == NULL)
 		return -ENOMEM;
 
-- 
2.25.1

