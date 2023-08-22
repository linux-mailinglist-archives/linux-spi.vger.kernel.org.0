Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD8F78377D
	for <lists+linux-spi@lfdr.de>; Tue, 22 Aug 2023 03:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232075AbjHVBiz (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 21 Aug 2023 21:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232077AbjHVBis (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 21 Aug 2023 21:38:48 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24D0112C
        for <linux-spi@vger.kernel.org>; Mon, 21 Aug 2023 18:38:46 -0700 (PDT)
Received: from dggpemm100010.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RVBjd6D7GztS1m;
        Tue, 22 Aug 2023 09:35:01 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm100010.china.huawei.com (7.185.36.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 22 Aug 2023 09:38:44 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 22 Aug
 2023 09:38:44 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next 19/24] spi: xcomm: switch to use modern name
Date:   Tue, 22 Aug 2023 09:35:06 +0800
Message-ID: <20230822013511.4161475-20-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230822013511.4161475-1-yangyingliang@huawei.com>
References: <20230822013511.4161475-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

Change legacy name master to modern name host or controller.

No functional changed.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/spi/spi-xcomm.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/spi/spi-xcomm.c b/drivers/spi/spi-xcomm.c
index a3d57554f5ba..63354dd3110f 100644
--- a/drivers/spi/spi-xcomm.c
+++ b/drivers/spi/spi-xcomm.c
@@ -132,10 +132,10 @@ static int spi_xcomm_txrx_bufs(struct spi_xcomm *spi_xcomm,
 	return t->len;
 }
 
-static int spi_xcomm_transfer_one(struct spi_master *master,
+static int spi_xcomm_transfer_one(struct spi_controller *host,
 	struct spi_message *msg)
 {
-	struct spi_xcomm *spi_xcomm = spi_master_get_devdata(master);
+	struct spi_xcomm *spi_xcomm = spi_controller_get_devdata(host);
 	unsigned int settings = spi_xcomm->settings;
 	struct spi_device *spi = msg->spi;
 	unsigned cs_change = 0;
@@ -197,7 +197,7 @@ static int spi_xcomm_transfer_one(struct spi_master *master,
 		spi_xcomm_chipselect(spi_xcomm, spi, false);
 
 	msg->status = status;
-	spi_finalize_current_message(master);
+	spi_finalize_current_message(host);
 
 	return status;
 }
@@ -205,27 +205,27 @@ static int spi_xcomm_transfer_one(struct spi_master *master,
 static int spi_xcomm_probe(struct i2c_client *i2c)
 {
 	struct spi_xcomm *spi_xcomm;
-	struct spi_master *master;
+	struct spi_controller *host;
 	int ret;
 
-	master = spi_alloc_master(&i2c->dev, sizeof(*spi_xcomm));
-	if (!master)
+	host = spi_alloc_host(&i2c->dev, sizeof(*spi_xcomm));
+	if (!host)
 		return -ENOMEM;
 
-	spi_xcomm = spi_master_get_devdata(master);
+	spi_xcomm = spi_controller_get_devdata(host);
 	spi_xcomm->i2c = i2c;
 
-	master->num_chipselect = 16;
-	master->mode_bits = SPI_CPHA | SPI_CPOL | SPI_3WIRE;
-	master->bits_per_word_mask = SPI_BPW_MASK(8);
-	master->flags = SPI_CONTROLLER_HALF_DUPLEX;
-	master->transfer_one_message = spi_xcomm_transfer_one;
-	master->dev.of_node = i2c->dev.of_node;
-	i2c_set_clientdata(i2c, master);
+	host->num_chipselect = 16;
+	host->mode_bits = SPI_CPHA | SPI_CPOL | SPI_3WIRE;
+	host->bits_per_word_mask = SPI_BPW_MASK(8);
+	host->flags = SPI_CONTROLLER_HALF_DUPLEX;
+	host->transfer_one_message = spi_xcomm_transfer_one;
+	host->dev.of_node = i2c->dev.of_node;
+	i2c_set_clientdata(i2c, host);
 
-	ret = devm_spi_register_master(&i2c->dev, master);
+	ret = devm_spi_register_controller(&i2c->dev, host);
 	if (ret < 0)
-		spi_master_put(master);
+		spi_controller_put(host);
 
 	return ret;
 }
-- 
2.25.1

