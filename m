Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F39C3772721
	for <lists+linux-spi@lfdr.de>; Mon,  7 Aug 2023 16:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231776AbjHGOKU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 7 Aug 2023 10:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231942AbjHGOKS (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 7 Aug 2023 10:10:18 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0FB383
        for <linux-spi@vger.kernel.org>; Mon,  7 Aug 2023 07:10:15 -0700 (PDT)
Received: from dggpemm100008.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RKJ8b5Mljzfbp0;
        Mon,  7 Aug 2023 22:09:03 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm100008.china.huawei.com (7.185.36.125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 7 Aug 2023 22:10:13 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 7 Aug
 2023 22:10:12 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next v2 07/21] spi: bcm63xx-hsspi: switch to use modern name
Date:   Mon, 7 Aug 2023 22:07:03 +0800
Message-ID: <20230807140717.3484180-8-yangyingliang@huawei.com>
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
 drivers/spi/spi-bcm63xx-hsspi.c | 86 ++++++++++++++++-----------------
 1 file changed, 43 insertions(+), 43 deletions(-)

diff --git a/drivers/spi/spi-bcm63xx-hsspi.c b/drivers/spi/spi-bcm63xx-hsspi.c
index 9e218e143263..1ca857c2a4aa 100644
--- a/drivers/spi/spi-bcm63xx-hsspi.c
+++ b/drivers/spi/spi-bcm63xx-hsspi.c
@@ -149,7 +149,7 @@ static ssize_t wait_mode_show(struct device *dev, struct device_attribute *attr,
 			 char *buf)
 {
 	struct spi_controller *ctrl = dev_get_drvdata(dev);
-	struct bcm63xx_hsspi *bs = spi_master_get_devdata(ctrl);
+	struct bcm63xx_hsspi *bs = spi_controller_get_devdata(ctrl);
 
 	return sprintf(buf, "%d\n", bs->wait_mode);
 }
@@ -158,7 +158,7 @@ static ssize_t wait_mode_store(struct device *dev, struct device_attribute *attr
 			  const char *buf, size_t count)
 {
 	struct spi_controller *ctrl = dev_get_drvdata(dev);
-	struct bcm63xx_hsspi *bs = spi_master_get_devdata(ctrl);
+	struct bcm63xx_hsspi *bs = spi_controller_get_devdata(ctrl);
 	u32 val;
 
 	if (kstrtou32(buf, 10, &val))
@@ -185,7 +185,7 @@ static ssize_t xfer_mode_show(struct device *dev, struct device_attribute *attr,
 			 char *buf)
 {
 	struct spi_controller *ctrl = dev_get_drvdata(dev);
-	struct bcm63xx_hsspi *bs = spi_master_get_devdata(ctrl);
+	struct bcm63xx_hsspi *bs = spi_controller_get_devdata(ctrl);
 
 	return sprintf(buf, "%d\n", bs->xfer_mode);
 }
@@ -194,7 +194,7 @@ static ssize_t xfer_mode_store(struct device *dev, struct device_attribute *attr
 			  const char *buf, size_t count)
 {
 	struct spi_controller *ctrl = dev_get_drvdata(dev);
-	struct bcm63xx_hsspi *bs = spi_master_get_devdata(ctrl);
+	struct bcm63xx_hsspi *bs = spi_controller_get_devdata(ctrl);
 	u32 val;
 
 	if (kstrtou32(buf, 10, &val))
@@ -262,12 +262,12 @@ static int bcm63xx_hsspi_wait_cmd(struct bcm63xx_hsspi *bs)
 	return rc;
 }
 
-static bool bcm63xx_prepare_prepend_transfer(struct spi_master *master,
+static bool bcm63xx_prepare_prepend_transfer(struct spi_controller *host,
 					  struct spi_message *msg,
 					  struct spi_transfer *t_prepend)
 {
 
-	struct bcm63xx_hsspi *bs = spi_master_get_devdata(master);
+	struct bcm63xx_hsspi *bs = spi_controller_get_devdata(host);
 	bool tx_only = false;
 	struct spi_transfer *t;
 
@@ -348,7 +348,7 @@ static bool bcm63xx_prepare_prepend_transfer(struct spi_master *master,
 static int bcm63xx_hsspi_do_prepend_txrx(struct spi_device *spi,
 					 struct spi_transfer *t)
 {
-	struct bcm63xx_hsspi *bs = spi_master_get_devdata(spi->master);
+	struct bcm63xx_hsspi *bs = spi_controller_get_devdata(spi->controller);
 	unsigned int chip_select = spi_get_chipselect(spi, 0);
 	u16 opcode = 0, val;
 	const u8 *tx = t->tx_buf;
@@ -467,7 +467,7 @@ static void bcm63xx_hsspi_set_clk(struct bcm63xx_hsspi *bs,
 
 static int bcm63xx_hsspi_do_txrx(struct spi_device *spi, struct spi_transfer *t)
 {
-	struct bcm63xx_hsspi *bs = spi_master_get_devdata(spi->master);
+	struct bcm63xx_hsspi *bs = spi_controller_get_devdata(spi->controller);
 	unsigned int chip_select = spi_get_chipselect(spi, 0);
 	u16 opcode = 0, val;
 	int pending = t->len;
@@ -541,7 +541,7 @@ static int bcm63xx_hsspi_do_txrx(struct spi_device *spi, struct spi_transfer *t)
 
 static int bcm63xx_hsspi_setup(struct spi_device *spi)
 {
-	struct bcm63xx_hsspi *bs = spi_master_get_devdata(spi->master);
+	struct bcm63xx_hsspi *bs = spi_controller_get_devdata(spi->controller);
 	u32 reg;
 
 	reg = __raw_readl(bs->regs +
@@ -579,7 +579,7 @@ static int bcm63xx_hsspi_setup(struct spi_device *spi)
 static int bcm63xx_hsspi_do_dummy_cs_txrx(struct spi_device *spi,
 				      struct spi_message *msg)
 {
-	struct bcm63xx_hsspi *bs = spi_master_get_devdata(spi->master);
+	struct bcm63xx_hsspi *bs = spi_controller_get_devdata(spi->controller);
 	int status = -EINVAL;
 	int dummy_cs;
 	bool keep_cs = false;
@@ -653,10 +653,10 @@ static int bcm63xx_hsspi_do_dummy_cs_txrx(struct spi_device *spi,
 	return status;
 }
 
-static int bcm63xx_hsspi_transfer_one(struct spi_master *master,
+static int bcm63xx_hsspi_transfer_one(struct spi_controller *host,
 				      struct spi_message *msg)
 {
-	struct bcm63xx_hsspi *bs = spi_master_get_devdata(master);
+	struct bcm63xx_hsspi *bs = spi_controller_get_devdata(host);
 	struct spi_device *spi = msg->spi;
 	int status = -EINVAL;
 	bool prependable = false;
@@ -665,7 +665,7 @@ static int bcm63xx_hsspi_transfer_one(struct spi_master *master,
 	mutex_lock(&bs->msg_mutex);
 
 	if (bs->xfer_mode != HSSPI_XFER_MODE_DUMMYCS)
-		prependable = bcm63xx_prepare_prepend_transfer(master, msg, &t_prepend);
+		prependable = bcm63xx_prepare_prepend_transfer(host, msg, &t_prepend);
 
 	if (prependable) {
 		status = bcm63xx_hsspi_do_prepend_txrx(spi, &t_prepend);
@@ -681,7 +681,7 @@ static int bcm63xx_hsspi_transfer_one(struct spi_master *master,
 
 	mutex_unlock(&bs->msg_mutex);
 	msg->status = status;
-	spi_finalize_current_message(master);
+	spi_finalize_current_message(host);
 
 	return 0;
 }
@@ -723,7 +723,7 @@ static irqreturn_t bcm63xx_hsspi_interrupt(int irq, void *dev_id)
 
 static int bcm63xx_hsspi_probe(struct platform_device *pdev)
 {
-	struct spi_master *master;
+	struct spi_controller *host;
 	struct bcm63xx_hsspi *bs;
 	void __iomem *regs;
 	struct device *dev = &pdev->dev;
@@ -779,13 +779,13 @@ static int bcm63xx_hsspi_probe(struct platform_device *pdev)
 		}
 	}
 
-	master = spi_alloc_master(&pdev->dev, sizeof(*bs));
-	if (!master) {
+	host = spi_alloc_host(&pdev->dev, sizeof(*bs));
+	if (!host) {
 		ret = -ENOMEM;
 		goto out_disable_pll_clk;
 	}
 
-	bs = spi_master_get_devdata(master);
+	bs = spi_controller_get_devdata(host);
 	bs->pdev = pdev;
 	bs->clk = clk;
 	bs->pll_clk = pll_clk;
@@ -796,17 +796,17 @@ static int bcm63xx_hsspi_probe(struct platform_device *pdev)
 	bs->prepend_buf = devm_kzalloc(dev, HSSPI_BUFFER_LEN, GFP_KERNEL);
 	if (!bs->prepend_buf) {
 		ret = -ENOMEM;
-		goto out_put_master;
+		goto out_put_host;
 	}
 
 	mutex_init(&bs->bus_mutex);
 	mutex_init(&bs->msg_mutex);
 	init_completion(&bs->done);
 
-	master->mem_ops = &bcm63xx_hsspi_mem_ops;
-	master->dev.of_node = dev->of_node;
+	host->mem_ops = &bcm63xx_hsspi_mem_ops;
+	host->dev.of_node = dev->of_node;
 	if (!dev->of_node)
-		master->bus_num = HSSPI_BUS_NUM;
+		host->bus_num = HSSPI_BUS_NUM;
 
 	of_property_read_u32(dev->of_node, "num-cs", &num_cs);
 	if (num_cs > 8) {
@@ -814,18 +814,18 @@ static int bcm63xx_hsspi_probe(struct platform_device *pdev)
 			 num_cs);
 		num_cs = HSSPI_SPI_MAX_CS;
 	}
-	master->num_chipselect = num_cs;
-	master->setup = bcm63xx_hsspi_setup;
-	master->transfer_one_message = bcm63xx_hsspi_transfer_one;
-	master->max_transfer_size = bcm63xx_hsspi_max_message_size;
-	master->max_message_size = bcm63xx_hsspi_max_message_size;
+	host->num_chipselect = num_cs;
+	host->setup = bcm63xx_hsspi_setup;
+	host->transfer_one_message = bcm63xx_hsspi_transfer_one;
+	host->max_transfer_size = bcm63xx_hsspi_max_message_size;
+	host->max_message_size = bcm63xx_hsspi_max_message_size;
 
-	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH |
+	host->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH |
 			    SPI_RX_DUAL | SPI_TX_DUAL;
-	master->bits_per_word_mask = SPI_BPW_MASK(8);
-	master->auto_runtime_pm = true;
+	host->bits_per_word_mask = SPI_BPW_MASK(8);
+	host->auto_runtime_pm = true;
 
-	platform_set_drvdata(pdev, master);
+	platform_set_drvdata(pdev, host);
 
 	/* Initialize the hardware */
 	__raw_writel(0, bs->regs + HSSPI_INT_MASK_REG);
@@ -844,7 +844,7 @@ static int bcm63xx_hsspi_probe(struct platform_device *pdev)
 				       pdev->name, bs);
 
 		if (ret)
-			goto out_put_master;
+			goto out_put_host;
 	}
 
 	pm_runtime_enable(&pdev->dev);
@@ -856,7 +856,7 @@ static int bcm63xx_hsspi_probe(struct platform_device *pdev)
 	}
 
 	/* register and we are done */
-	ret = devm_spi_register_master(dev, master);
+	ret = devm_spi_register_controller(dev, host);
 	if (ret)
 		goto out_sysgroup_disable;
 
@@ -868,8 +868,8 @@ static int bcm63xx_hsspi_probe(struct platform_device *pdev)
 	sysfs_remove_group(&pdev->dev.kobj, &bcm63xx_hsspi_group);
 out_pm_disable:
 	pm_runtime_disable(&pdev->dev);
-out_put_master:
-	spi_master_put(master);
+out_put_host:
+	spi_controller_put(host);
 out_disable_pll_clk:
 	clk_disable_unprepare(pll_clk);
 out_disable_clk:
@@ -880,8 +880,8 @@ static int bcm63xx_hsspi_probe(struct platform_device *pdev)
 
 static void bcm63xx_hsspi_remove(struct platform_device *pdev)
 {
-	struct spi_master *master = platform_get_drvdata(pdev);
-	struct bcm63xx_hsspi *bs = spi_master_get_devdata(master);
+	struct spi_controller *host = platform_get_drvdata(pdev);
+	struct bcm63xx_hsspi *bs = spi_controller_get_devdata(host);
 
 	/* reset the hardware and block queue progress */
 	__raw_writel(0, bs->regs + HSSPI_INT_MASK_REG);
@@ -893,10 +893,10 @@ static void bcm63xx_hsspi_remove(struct platform_device *pdev)
 #ifdef CONFIG_PM_SLEEP
 static int bcm63xx_hsspi_suspend(struct device *dev)
 {
-	struct spi_master *master = dev_get_drvdata(dev);
-	struct bcm63xx_hsspi *bs = spi_master_get_devdata(master);
+	struct spi_controller *host = dev_get_drvdata(dev);
+	struct bcm63xx_hsspi *bs = spi_controller_get_devdata(host);
 
-	spi_master_suspend(master);
+	spi_controller_suspend(host);
 	clk_disable_unprepare(bs->pll_clk);
 	clk_disable_unprepare(bs->clk);
 
@@ -905,8 +905,8 @@ static int bcm63xx_hsspi_suspend(struct device *dev)
 
 static int bcm63xx_hsspi_resume(struct device *dev)
 {
-	struct spi_master *master = dev_get_drvdata(dev);
-	struct bcm63xx_hsspi *bs = spi_master_get_devdata(master);
+	struct spi_controller *host = dev_get_drvdata(dev);
+	struct bcm63xx_hsspi *bs = spi_controller_get_devdata(host);
 	int ret;
 
 	ret = clk_prepare_enable(bs->clk);
@@ -921,7 +921,7 @@ static int bcm63xx_hsspi_resume(struct device *dev)
 		}
 	}
 
-	spi_master_resume(master);
+	spi_controller_resume(host);
 
 	return 0;
 }
-- 
2.25.1

