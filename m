Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9473E772720
	for <lists+linux-spi@lfdr.de>; Mon,  7 Aug 2023 16:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbjHGOKT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 7 Aug 2023 10:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231776AbjHGOKR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 7 Aug 2023 10:10:17 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3848C9E
        for <linux-spi@vger.kernel.org>; Mon,  7 Aug 2023 07:10:16 -0700 (PDT)
Received: from dggpemm100009.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RKJ7n2cM4zVjjk;
        Mon,  7 Aug 2023 22:08:21 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm100009.china.huawei.com (7.185.36.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 7 Aug 2023 22:10:13 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 7 Aug
 2023 22:10:13 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next v2 08/21] spi: bcm63xx: switch to use modern name
Date:   Mon, 7 Aug 2023 22:07:04 +0800
Message-ID: <20230807140717.3484180-9-yangyingliang@huawei.com>
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
 drivers/spi/spi-bcm63xx.c | 68 +++++++++++++++++++--------------------
 1 file changed, 34 insertions(+), 34 deletions(-)

diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
index 07b5b71b2352..aac41bd05f98 100644
--- a/drivers/spi/spi-bcm63xx.c
+++ b/drivers/spi/spi-bcm63xx.c
@@ -186,7 +186,7 @@ static const unsigned int bcm63xx_spi_freq_table[SPI_CLK_MASK][2] = {
 static void bcm63xx_spi_setup_transfer(struct spi_device *spi,
 				      struct spi_transfer *t)
 {
-	struct bcm63xx_spi *bs = spi_master_get_devdata(spi->master);
+	struct bcm63xx_spi *bs = spi_controller_get_devdata(spi->controller);
 	u8 clk_cfg, reg;
 	int i;
 
@@ -217,7 +217,7 @@ static void bcm63xx_spi_setup_transfer(struct spi_device *spi,
 static int bcm63xx_txrx_bufs(struct spi_device *spi, struct spi_transfer *first,
 				unsigned int num_transfers)
 {
-	struct bcm63xx_spi *bs = spi_master_get_devdata(spi->master);
+	struct bcm63xx_spi *bs = spi_controller_get_devdata(spi->controller);
 	u16 msg_ctl;
 	u16 cmd;
 	unsigned int i, timeout = 0, prepend_len = 0, len = 0;
@@ -312,10 +312,10 @@ static int bcm63xx_txrx_bufs(struct spi_device *spi, struct spi_transfer *first,
 	return 0;
 }
 
-static int bcm63xx_spi_transfer_one(struct spi_master *master,
+static int bcm63xx_spi_transfer_one(struct spi_controller *host,
 					struct spi_message *m)
 {
-	struct bcm63xx_spi *bs = spi_master_get_devdata(master);
+	struct bcm63xx_spi *bs = spi_controller_get_devdata(host);
 	struct spi_transfer *t, *first = NULL;
 	struct spi_device *spi = m->spi;
 	int status = 0;
@@ -385,18 +385,18 @@ static int bcm63xx_spi_transfer_one(struct spi_master *master,
 	}
 exit:
 	m->status = status;
-	spi_finalize_current_message(master);
+	spi_finalize_current_message(host);
 
 	return 0;
 }
 
-/* This driver supports single master mode only. Hence
+/* This driver supports single host mode only. Hence
  * CMD_DONE is the only interrupt we care about
  */
 static irqreturn_t bcm63xx_spi_interrupt(int irq, void *dev_id)
 {
-	struct spi_master *master = (struct spi_master *)dev_id;
-	struct bcm63xx_spi *bs = spi_master_get_devdata(master);
+	struct spi_controller *host = (struct spi_controller *)dev_id;
+	struct bcm63xx_spi *bs = spi_controller_get_devdata(host);
 	u8 intr;
 
 	/* Read interupts and clear them immediately */
@@ -413,7 +413,7 @@ static irqreturn_t bcm63xx_spi_interrupt(int irq, void *dev_id)
 
 static size_t bcm63xx_spi_max_length(struct spi_device *spi)
 {
-	struct bcm63xx_spi *bs = spi_master_get_devdata(spi->master);
+	struct bcm63xx_spi *bs = spi_controller_get_devdata(spi->controller);
 
 	return bs->fifo_size;
 }
@@ -479,7 +479,7 @@ static int bcm63xx_spi_probe(struct platform_device *pdev)
 	const unsigned long *bcm63xx_spireg;
 	struct device *dev = &pdev->dev;
 	int irq, bus_num;
-	struct spi_master *master;
+	struct spi_controller *host;
 	struct clk *clk;
 	struct bcm63xx_spi *bs;
 	int ret;
@@ -525,16 +525,16 @@ static int bcm63xx_spi_probe(struct platform_device *pdev)
 	if (IS_ERR(reset))
 		return PTR_ERR(reset);
 
-	master = spi_alloc_master(dev, sizeof(*bs));
-	if (!master) {
+	host = spi_alloc_host(dev, sizeof(*bs));
+	if (!host) {
 		dev_err(dev, "out of memory\n");
 		return -ENOMEM;
 	}
 
-	bs = spi_master_get_devdata(master);
+	bs = spi_controller_get_devdata(host);
 	init_completion(&bs->done);
 
-	platform_set_drvdata(pdev, master);
+	platform_set_drvdata(pdev, host);
 	bs->pdev = pdev;
 
 	bs->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &r);
@@ -549,21 +549,21 @@ static int bcm63xx_spi_probe(struct platform_device *pdev)
 	bs->fifo_size = bs->reg_offsets[SPI_MSG_DATA_SIZE];
 
 	ret = devm_request_irq(&pdev->dev, irq, bcm63xx_spi_interrupt, 0,
-							pdev->name, master);
+			       pdev->name, host);
 	if (ret) {
 		dev_err(dev, "unable to request irq\n");
 		goto out_err;
 	}
 
-	master->dev.of_node = dev->of_node;
-	master->bus_num = bus_num;
-	master->num_chipselect = num_cs;
-	master->transfer_one_message = bcm63xx_spi_transfer_one;
-	master->mode_bits = MODEBITS;
-	master->bits_per_word_mask = SPI_BPW_MASK(8);
-	master->max_transfer_size = bcm63xx_spi_max_length;
-	master->max_message_size = bcm63xx_spi_max_length;
-	master->auto_runtime_pm = true;
+	host->dev.of_node = dev->of_node;
+	host->bus_num = bus_num;
+	host->num_chipselect = num_cs;
+	host->transfer_one_message = bcm63xx_spi_transfer_one;
+	host->mode_bits = MODEBITS;
+	host->bits_per_word_mask = SPI_BPW_MASK(8);
+	host->max_transfer_size = bcm63xx_spi_max_length;
+	host->max_message_size = bcm63xx_spi_max_length;
+	host->auto_runtime_pm = true;
 	bs->msg_type_shift = bs->reg_offsets[SPI_MSG_TYPE_SHIFT];
 	bs->msg_ctl_width = bs->reg_offsets[SPI_MSG_CTL_WIDTH];
 	bs->tx_io = (u8 *)(bs->regs + bs->reg_offsets[SPI_MSG_DATA]);
@@ -585,7 +585,7 @@ static int bcm63xx_spi_probe(struct platform_device *pdev)
 	pm_runtime_enable(&pdev->dev);
 
 	/* register and we are done */
-	ret = devm_spi_register_master(dev, master);
+	ret = devm_spi_register_controller(dev, host);
 	if (ret) {
 		dev_err(dev, "spi register failed\n");
 		goto out_pm_disable;
@@ -601,14 +601,14 @@ static int bcm63xx_spi_probe(struct platform_device *pdev)
 out_clk_disable:
 	clk_disable_unprepare(clk);
 out_err:
-	spi_master_put(master);
+	spi_controller_put(host);
 	return ret;
 }
 
 static void bcm63xx_spi_remove(struct platform_device *pdev)
 {
-	struct spi_master *master = platform_get_drvdata(pdev);
-	struct bcm63xx_spi *bs = spi_master_get_devdata(master);
+	struct spi_controller *host = platform_get_drvdata(pdev);
+	struct bcm63xx_spi *bs = spi_controller_get_devdata(host);
 
 	/* reset spi block */
 	bcm_spi_writeb(bs, 0, SPI_INT_MASK);
@@ -619,10 +619,10 @@ static void bcm63xx_spi_remove(struct platform_device *pdev)
 
 static int bcm63xx_spi_suspend(struct device *dev)
 {
-	struct spi_master *master = dev_get_drvdata(dev);
-	struct bcm63xx_spi *bs = spi_master_get_devdata(master);
+	struct spi_controller *host = dev_get_drvdata(dev);
+	struct bcm63xx_spi *bs = spi_controller_get_devdata(host);
 
-	spi_master_suspend(master);
+	spi_controller_suspend(host);
 
 	clk_disable_unprepare(bs->clk);
 
@@ -631,15 +631,15 @@ static int bcm63xx_spi_suspend(struct device *dev)
 
 static int bcm63xx_spi_resume(struct device *dev)
 {
-	struct spi_master *master = dev_get_drvdata(dev);
-	struct bcm63xx_spi *bs = spi_master_get_devdata(master);
+	struct spi_controller *host = dev_get_drvdata(dev);
+	struct bcm63xx_spi *bs = spi_controller_get_devdata(host);
 	int ret;
 
 	ret = clk_prepare_enable(bs->clk);
 	if (ret)
 		return ret;
 
-	spi_master_resume(master);
+	spi_controller_resume(host);
 
 	return 0;
 }
-- 
2.25.1

