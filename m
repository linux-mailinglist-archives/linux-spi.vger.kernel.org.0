Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F034977271E
	for <lists+linux-spi@lfdr.de>; Mon,  7 Aug 2023 16:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232024AbjHGOKT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 7 Aug 2023 10:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231859AbjHGOKR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 7 Aug 2023 10:10:17 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82BE7E79
        for <linux-spi@vger.kernel.org>; Mon,  7 Aug 2023 07:10:15 -0700 (PDT)
Received: from dggpemm100012.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RKJ5w14mgzNmm7;
        Mon,  7 Aug 2023 22:06:44 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm100012.china.huawei.com (7.185.36.212) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 7 Aug 2023 22:10:11 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 7 Aug
 2023 22:10:11 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next v2 04/21] spi: bcm-qspi: switch to use modern name
Date:   Mon, 7 Aug 2023 22:07:00 +0800
Message-ID: <20230807140717.3484180-5-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230807140717.3484180-1-yangyingliang@huawei.com>
References: <20230807140717.3484180-1-yangyingliang@huawei.com>
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
 drivers/spi/spi-bcm-qspi.c | 64 +++++++++++++++++++-------------------
 1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/drivers/spi/spi-bcm-qspi.c b/drivers/spi/spi-bcm-qspi.c
index d91dfbe47aa5..ef08fcac2f6d 100644
--- a/drivers/spi/spi-bcm-qspi.c
+++ b/drivers/spi/spi-bcm-qspi.c
@@ -220,7 +220,7 @@ struct qspi_trans {
 
 struct bcm_qspi {
 	struct platform_device *pdev;
-	struct spi_master *master;
+	struct spi_controller *host;
 	struct clk *clk;
 	u32 base_clk;
 	u32 max_speed_hz;
@@ -732,7 +732,7 @@ static bool bcm_qspi_mspi_transfer_is_last(struct bcm_qspi *qspi,
 					   struct qspi_trans *qt)
 {
 	if (qt->mspi_last_trans &&
-	    spi_transfer_is_last(qspi->master, qt->trans))
+	    spi_transfer_is_last(qspi->host, qt->trans))
 		return true;
 	else
 		return false;
@@ -979,7 +979,7 @@ static int write_to_hw(struct bcm_qspi *qspi, struct spi_device *spi)
 		mspi_cdram |= ((tp.trans->bits_per_word <= 8) ? 0 :
 			       MSPI_CDRAM_BITSE_BIT);
 
-		/* set 3wrire halfduplex mode data from master to slave */
+		/* set 3wrire halfduplex mode data from host to target */
 		if ((spi->mode & SPI_3WIRE) && tp.trans->tx_buf)
 			mspi_cdram |= MSPI_CDRAM_OUTP;
 
@@ -1035,7 +1035,7 @@ static int write_to_hw(struct bcm_qspi *qspi, struct spi_device *spi)
 static int bcm_qspi_bspi_exec_mem_op(struct spi_device *spi,
 				     const struct spi_mem_op *op)
 {
-	struct bcm_qspi *qspi = spi_master_get_devdata(spi->master);
+	struct bcm_qspi *qspi = spi_controller_get_devdata(spi->controller);
 	u32 addr = 0, len, rdlen, len_words, from = 0;
 	int ret = 0;
 	unsigned long timeo = msecs_to_jiffies(100);
@@ -1118,11 +1118,11 @@ static int bcm_qspi_bspi_exec_mem_op(struct spi_device *spi,
 	return ret;
 }
 
-static int bcm_qspi_transfer_one(struct spi_master *master,
+static int bcm_qspi_transfer_one(struct spi_controller *host,
 				 struct spi_device *spi,
 				 struct spi_transfer *trans)
 {
-	struct bcm_qspi *qspi = spi_master_get_devdata(master);
+	struct bcm_qspi *qspi = spi_controller_get_devdata(host);
 	int slots;
 	unsigned long timeo = msecs_to_jiffies(100);
 
@@ -1150,8 +1150,8 @@ static int bcm_qspi_transfer_one(struct spi_master *master,
 static int bcm_qspi_mspi_exec_mem_op(struct spi_device *spi,
 				     const struct spi_mem_op *op)
 {
-	struct spi_master *master = spi->master;
-	struct bcm_qspi *qspi = spi_master_get_devdata(master);
+	struct spi_controller *host = spi->controller;
+	struct bcm_qspi *qspi = spi_controller_get_devdata(host);
 	struct spi_transfer t[2];
 	u8 cmd[6] = { };
 	int ret, i;
@@ -1171,7 +1171,7 @@ static int bcm_qspi_mspi_exec_mem_op(struct spi_device *spi,
 	t[0].tx_nbits = op->cmd.buswidth;
 	/* lets mspi know that this is not last transfer */
 	qspi->trans_pos.mspi_last_trans = false;
-	ret = bcm_qspi_transfer_one(master, spi, &t[0]);
+	ret = bcm_qspi_transfer_one(host, spi, &t[0]);
 
 	/* rx */
 	qspi->trans_pos.mspi_last_trans = true;
@@ -1181,7 +1181,7 @@ static int bcm_qspi_mspi_exec_mem_op(struct spi_device *spi,
 		t[1].len = op->data.nbytes;
 		t[1].rx_nbits =  op->data.buswidth;
 		t[1].bits_per_word = spi->bits_per_word;
-		ret = bcm_qspi_transfer_one(master, spi, &t[1]);
+		ret = bcm_qspi_transfer_one(host, spi, &t[1]);
 	}
 
 	return ret;
@@ -1191,7 +1191,7 @@ static int bcm_qspi_exec_mem_op(struct spi_mem *mem,
 				const struct spi_mem_op *op)
 {
 	struct spi_device *spi = mem->spi;
-	struct bcm_qspi *qspi = spi_master_get_devdata(spi->master);
+	struct bcm_qspi *qspi = spi_controller_get_devdata(spi->controller);
 	int ret = 0;
 	bool mspi_read = false;
 	u32 addr = 0, len;
@@ -1486,7 +1486,7 @@ int bcm_qspi_probe(struct platform_device *pdev,
 	const struct bcm_qspi_data *data;
 	struct device *dev = &pdev->dev;
 	struct bcm_qspi *qspi;
-	struct spi_master *master;
+	struct spi_controller *host;
 	struct resource *res;
 	int irq, ret = 0, num_ints = 0;
 	u32 val;
@@ -1504,13 +1504,13 @@ int bcm_qspi_probe(struct platform_device *pdev,
 
 	data = of_id->data;
 
-	master = devm_spi_alloc_master(dev, sizeof(struct bcm_qspi));
-	if (!master) {
-		dev_err(dev, "error allocating spi_master\n");
+	host = devm_spi_alloc_host(dev, sizeof(struct bcm_qspi));
+	if (!host) {
+		dev_err(dev, "error allocating spi_controller\n");
 		return -ENOMEM;
 	}
 
-	qspi = spi_master_get_devdata(master);
+	qspi = spi_controller_get_devdata(host);
 
 	qspi->clk = devm_clk_get_optional(&pdev->dev, NULL);
 	if (IS_ERR(qspi->clk))
@@ -1520,23 +1520,23 @@ int bcm_qspi_probe(struct platform_device *pdev,
 	qspi->trans_pos.trans = NULL;
 	qspi->trans_pos.byte = 0;
 	qspi->trans_pos.mspi_last_trans = true;
-	qspi->master = master;
+	qspi->host = host;
 
-	master->bus_num = -1;
-	master->mode_bits = SPI_CPHA | SPI_CPOL | SPI_RX_DUAL | SPI_RX_QUAD |
+	host->bus_num = -1;
+	host->mode_bits = SPI_CPHA | SPI_CPOL | SPI_RX_DUAL | SPI_RX_QUAD |
 				SPI_3WIRE;
-	master->setup = bcm_qspi_setup;
-	master->transfer_one = bcm_qspi_transfer_one;
-	master->mem_ops = &bcm_qspi_mem_ops;
-	master->cleanup = bcm_qspi_cleanup;
-	master->dev.of_node = dev->of_node;
-	master->num_chipselect = NUM_CHIPSELECT;
-	master->use_gpio_descriptors = true;
+	host->setup = bcm_qspi_setup;
+	host->transfer_one = bcm_qspi_transfer_one;
+	host->mem_ops = &bcm_qspi_mem_ops;
+	host->cleanup = bcm_qspi_cleanup;
+	host->dev.of_node = dev->of_node;
+	host->num_chipselect = NUM_CHIPSELECT;
+	host->use_gpio_descriptors = true;
 
 	qspi->big_endian = of_device_is_big_endian(dev->of_node);
 
 	if (!of_property_read_u32(dev->of_node, "num-cs", &val))
-		master->num_chipselect = val;
+		host->num_chipselect = val;
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "hif_mspi");
 	if (!res)
@@ -1659,9 +1659,9 @@ int bcm_qspi_probe(struct platform_device *pdev,
 	qspi->xfer_mode.addrlen = -1;
 	qspi->xfer_mode.hp = -1;
 
-	ret = spi_register_master(master);
+	ret = spi_register_controller(host);
 	if (ret < 0) {
-		dev_err(dev, "can't register master\n");
+		dev_err(dev, "can't register host\n");
 		goto qspi_reg_err;
 	}
 
@@ -1682,7 +1682,7 @@ void bcm_qspi_remove(struct platform_device *pdev)
 {
 	struct bcm_qspi *qspi = platform_get_drvdata(pdev);
 
-	spi_unregister_master(qspi->master);
+	spi_unregister_controller(qspi->host);
 	bcm_qspi_hw_uninit(qspi);
 	clk_disable_unprepare(qspi->clk);
 	kfree(qspi->dev_ids);
@@ -1700,7 +1700,7 @@ static int __maybe_unused bcm_qspi_suspend(struct device *dev)
 		qspi->s3_strap_override_ctrl =
 			bcm_qspi_read(qspi, BSPI, BSPI_STRAP_OVERRIDE_CTRL);
 
-	spi_master_suspend(qspi->master);
+	spi_controller_suspend(qspi->host);
 	clk_disable_unprepare(qspi->clk);
 	bcm_qspi_hw_uninit(qspi);
 
@@ -1721,7 +1721,7 @@ static int __maybe_unused bcm_qspi_resume(struct device *dev)
 
 	ret = clk_prepare_enable(qspi->clk);
 	if (!ret)
-		spi_master_resume(qspi->master);
+		spi_controller_resume(qspi->host);
 
 	return ret;
 }
-- 
2.25.1

