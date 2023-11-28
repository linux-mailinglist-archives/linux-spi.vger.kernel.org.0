Return-Path: <linux-spi+bounces-66-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A6297FB5AD
	for <lists+linux-spi@lfdr.de>; Tue, 28 Nov 2023 10:26:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55BDE282672
	for <lists+linux-spi@lfdr.de>; Tue, 28 Nov 2023 09:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103C746534;
	Tue, 28 Nov 2023 09:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-spi@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C0C1E1
	for <linux-spi@vger.kernel.org>; Tue, 28 Nov 2023 01:26:28 -0800 (PST)
Received: from dggpemm500018.china.huawei.com (unknown [172.30.72.55])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4SfcSB153tz1P8sJ;
	Tue, 28 Nov 2023 17:22:50 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500018.china.huawei.com (7.185.36.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 28 Nov 2023 17:26:26 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 28 Nov
 2023 17:26:26 +0800
From: Yang Yingliang <yangyingliang@huawei.com>
To: <linux-spi@vger.kernel.org>
CC: <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
	<yangyingliang@huawei.com>
Subject: [PATCH -next 19/26] spi: xcomm: switch to use modern name
Date: Tue, 28 Nov 2023 17:30:24 +0800
Message-ID: <20231128093031.3707034-20-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231128093031.3707034-1-yangyingliang@huawei.com>
References: <20231128093031.3707034-1-yangyingliang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected

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


