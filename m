Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43F37772470
	for <lists+linux-spi@lfdr.de>; Mon,  7 Aug 2023 14:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232673AbjHGMoM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 7 Aug 2023 08:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231430AbjHGMoL (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 7 Aug 2023 08:44:11 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 471C710FE
        for <linux-spi@vger.kernel.org>; Mon,  7 Aug 2023 05:44:10 -0700 (PDT)
Received: from dggpemm100017.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RKGCN4GSGz1Z1S9;
        Mon,  7 Aug 2023 20:41:20 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm100017.china.huawei.com (7.185.36.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 7 Aug 2023 20:44:08 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 7 Aug
 2023 20:44:08 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next 04/20] spi: falcon: switch to use modern name
Date:   Mon, 7 Aug 2023 20:40:49 +0800
Message-ID: <20230807124105.3429709-5-yangyingliang@huawei.com>
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
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Change legacy name master to modern name host or controller.

No functional changed.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/spi/spi-falcon.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/spi/spi-falcon.c b/drivers/spi/spi-falcon.c
index 8a8414cbb400..84279058f0f1 100644
--- a/drivers/spi/spi-falcon.c
+++ b/drivers/spi/spi-falcon.c
@@ -91,14 +91,14 @@
 
 struct falcon_sflash {
 	u32 sfcmd; /* for caching of opcode, direction, ... */
-	struct spi_master *master;
+	struct spi_controller *host;
 };
 
 int falcon_sflash_xfer(struct spi_device *spi, struct spi_transfer *t,
 		unsigned long flags)
 {
 	struct device *dev = &spi->dev;
-	struct falcon_sflash *priv = spi_master_get_devdata(spi->master);
+	struct falcon_sflash *priv = spi_controller_get_devdata(spi->controller);
 	const u8 *txp = t->tx_buf;
 	u8 *rxp = t->rx_buf;
 	unsigned int bytelen = ((8 * t->len + 7) / 8);
@@ -351,10 +351,10 @@ static int falcon_sflash_setup(struct spi_device *spi)
 	return 0;
 }
 
-static int falcon_sflash_xfer_one(struct spi_master *master,
+static int falcon_sflash_xfer_one(struct spi_controller *host,
 					struct spi_message *m)
 {
-	struct falcon_sflash *priv = spi_master_get_devdata(master);
+	struct falcon_sflash *priv = spi_controller_get_devdata(host);
 	struct spi_transfer *t;
 	unsigned long spi_flags;
 	unsigned long flags;
@@ -382,7 +382,7 @@ static int falcon_sflash_xfer_one(struct spi_master *master,
 	}
 
 	m->status = ret;
-	spi_finalize_current_message(master);
+	spi_finalize_current_message(host);
 
 	return 0;
 }
@@ -390,25 +390,25 @@ static int falcon_sflash_xfer_one(struct spi_master *master,
 static int falcon_sflash_probe(struct platform_device *pdev)
 {
 	struct falcon_sflash *priv;
-	struct spi_master *master;
+	struct spi_controller *host;
 	int ret;
 
-	master = spi_alloc_master(&pdev->dev, sizeof(*priv));
-	if (!master)
+	host = spi_alloc_host(&pdev->dev, sizeof(*priv));
+	if (!host)
 		return -ENOMEM;
 
-	priv = spi_master_get_devdata(master);
-	priv->master = master;
+	priv = spi_controller_get_devdata(host);
+	priv->host = host;
 
-	master->mode_bits = SPI_MODE_3;
-	master->flags = SPI_CONTROLLER_HALF_DUPLEX;
-	master->setup = falcon_sflash_setup;
-	master->transfer_one_message = falcon_sflash_xfer_one;
-	master->dev.of_node = pdev->dev.of_node;
+	host->mode_bits = SPI_MODE_3;
+	host->flags = SPI_CONTROLLER_HALF_DUPLEX;
+	host->setup = falcon_sflash_setup;
+	host->transfer_one_message = falcon_sflash_xfer_one;
+	host->dev.of_node = pdev->dev.of_node;
 
-	ret = devm_spi_register_master(&pdev->dev, master);
+	ret = devm_spi_register_controller(&pdev->dev, host);
 	if (ret)
-		spi_master_put(master);
+		spi_controller_put(host);
 	return ret;
 }
 
-- 
2.25.1

