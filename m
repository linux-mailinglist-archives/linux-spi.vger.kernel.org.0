Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 431E077247D
	for <lists+linux-spi@lfdr.de>; Mon,  7 Aug 2023 14:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233706AbjHGMo0 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 7 Aug 2023 08:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233617AbjHGMoR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 7 Aug 2023 08:44:17 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 511B11710
        for <linux-spi@vger.kernel.org>; Mon,  7 Aug 2023 05:44:14 -0700 (PDT)
Received: from dggpemm100010.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RKGCS0fX8z1Z1WP;
        Mon,  7 Aug 2023 20:41:24 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm100010.china.huawei.com (7.185.36.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 7 Aug 2023 20:44:11 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 7 Aug
 2023 20:44:11 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next 13/20] spi: bcmbca-hsspi: switch to use modern name
Date:   Mon, 7 Aug 2023 20:40:58 +0800
Message-ID: <20230807124105.3429709-14-yangyingliang@huawei.com>
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
 drivers/spi/spi-bcmbca-hsspi.c | 66 +++++++++++++++++-----------------
 1 file changed, 33 insertions(+), 33 deletions(-)

diff --git a/drivers/spi/spi-bcmbca-hsspi.c b/drivers/spi/spi-bcmbca-hsspi.c
index ca1b4741e9f4..9f64afd8164e 100644
--- a/drivers/spi/spi-bcmbca-hsspi.c
+++ b/drivers/spi/spi-bcmbca-hsspi.c
@@ -127,7 +127,7 @@ static ssize_t wait_mode_show(struct device *dev, struct device_attribute *attr,
 			 char *buf)
 {
 	struct spi_controller *ctrl = dev_get_drvdata(dev);
-	struct bcmbca_hsspi *bs = spi_master_get_devdata(ctrl);
+	struct bcmbca_hsspi *bs = spi_controller_get_devdata(ctrl);
 
 	return sprintf(buf, "%d\n", bs->wait_mode);
 }
@@ -136,7 +136,7 @@ static ssize_t wait_mode_store(struct device *dev, struct device_attribute *attr
 			  const char *buf, size_t count)
 {
 	struct spi_controller *ctrl = dev_get_drvdata(dev);
-	struct bcmbca_hsspi *bs = spi_master_get_devdata(ctrl);
+	struct bcmbca_hsspi *bs = spi_controller_get_devdata(ctrl);
 	u32 val;
 
 	if (kstrtou32(buf, 10, &val))
@@ -250,7 +250,7 @@ static int bcmbca_hsspi_wait_cmd(struct bcmbca_hsspi *bs, unsigned int cs)
 static int bcmbca_hsspi_do_txrx(struct spi_device *spi, struct spi_transfer *t,
 								struct spi_message *msg)
 {
-	struct bcmbca_hsspi *bs = spi_master_get_devdata(spi->master);
+	struct bcmbca_hsspi *bs = spi_controller_get_devdata(spi->controller);
 	unsigned int chip_select = spi_get_chipselect(spi, 0);
 	u16 opcode = 0, val;
 	int pending = t->len;
@@ -328,7 +328,7 @@ static int bcmbca_hsspi_do_txrx(struct spi_device *spi, struct spi_transfer *t,
 
 static int bcmbca_hsspi_setup(struct spi_device *spi)
 {
-	struct bcmbca_hsspi *bs = spi_master_get_devdata(spi->master);
+	struct bcmbca_hsspi *bs = spi_controller_get_devdata(spi->controller);
 	u32 reg;
 
 	reg = __raw_readl(bs->regs +
@@ -366,10 +366,10 @@ static int bcmbca_hsspi_setup(struct spi_device *spi)
 	return 0;
 }
 
-static int bcmbca_hsspi_transfer_one(struct spi_master *master,
+static int bcmbca_hsspi_transfer_one(struct spi_controller *host,
 				      struct spi_message *msg)
 {
-	struct bcmbca_hsspi *bs = spi_master_get_devdata(master);
+	struct bcmbca_hsspi *bs = spi_controller_get_devdata(host);
 	struct spi_transfer *t;
 	struct spi_device *spi = msg->spi;
 	int status = -EINVAL;
@@ -409,7 +409,7 @@ static int bcmbca_hsspi_transfer_one(struct spi_master *master,
 		bcmbca_hsspi_set_cs(bs, spi_get_chipselect(spi, 0), false);
 
 	msg->status = status;
-	spi_finalize_current_message(master);
+	spi_finalize_current_message(host);
 
 	return 0;
 }
@@ -431,7 +431,7 @@ static irqreturn_t bcmbca_hsspi_interrupt(int irq, void *dev_id)
 
 static int bcmbca_hsspi_probe(struct platform_device *pdev)
 {
-	struct spi_master *master;
+	struct spi_controller *host;
 	struct bcmbca_hsspi *bs;
 	struct resource *res_mem;
 	void __iomem *spim_ctrl;
@@ -487,13 +487,13 @@ static int bcmbca_hsspi_probe(struct platform_device *pdev)
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
@@ -507,9 +507,9 @@ static int bcmbca_hsspi_probe(struct platform_device *pdev)
 	mutex_init(&bs->msg_mutex);
 	init_completion(&bs->done);
 
-	master->dev.of_node = dev->of_node;
+	host->dev.of_node = dev->of_node;
 	if (!dev->of_node)
-		master->bus_num = HSSPI_BUS_NUM;
+		host->bus_num = HSSPI_BUS_NUM;
 
 	of_property_read_u32(dev->of_node, "num-cs", &num_cs);
 	if (num_cs > 8) {
@@ -517,15 +517,15 @@ static int bcmbca_hsspi_probe(struct platform_device *pdev)
 			 num_cs);
 		num_cs = HSSPI_SPI_MAX_CS;
 	}
-	master->num_chipselect = num_cs;
-	master->setup = bcmbca_hsspi_setup;
-	master->transfer_one_message = bcmbca_hsspi_transfer_one;
-	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH |
-	    SPI_RX_DUAL | SPI_TX_DUAL;
-	master->bits_per_word_mask = SPI_BPW_MASK(8);
-	master->auto_runtime_pm = true;
+	host->num_chipselect = num_cs;
+	host->setup = bcmbca_hsspi_setup;
+	host->transfer_one_message = bcmbca_hsspi_transfer_one;
+	host->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH |
+			  SPI_RX_DUAL | SPI_TX_DUAL;
+	host->bits_per_word_mask = SPI_BPW_MASK(8);
+	host->auto_runtime_pm = true;
 
-	platform_set_drvdata(pdev, master);
+	platform_set_drvdata(pdev, host);
 
 	/* Initialize the hardware */
 	__raw_writel(0, bs->regs + HSSPI_INT_MASK_REG);
@@ -543,7 +543,7 @@ static int bcmbca_hsspi_probe(struct platform_device *pdev)
 		ret = devm_request_irq(dev, irq, bcmbca_hsspi_interrupt, IRQF_SHARED,
 			       pdev->name, bs);
 		if (ret)
-			goto out_put_master;
+			goto out_put_host;
 	}
 
 	pm_runtime_enable(&pdev->dev);
@@ -555,7 +555,7 @@ static int bcmbca_hsspi_probe(struct platform_device *pdev)
 	}
 
 	/* register and we are done */
-	ret = devm_spi_register_master(dev, master);
+	ret = devm_spi_register_controller(dev, host);
 	if (ret)
 		goto out_sysgroup_disable;
 
@@ -567,8 +567,8 @@ static int bcmbca_hsspi_probe(struct platform_device *pdev)
 	sysfs_remove_group(&pdev->dev.kobj, &bcmbca_hsspi_group);
 out_pm_disable:
 	pm_runtime_disable(&pdev->dev);
-out_put_master:
-	spi_master_put(master);
+out_put_host:
+	spi_controller_put(host);
 out_disable_pll_clk:
 	clk_disable_unprepare(pll_clk);
 out_disable_clk:
@@ -578,8 +578,8 @@ static int bcmbca_hsspi_probe(struct platform_device *pdev)
 
 static void bcmbca_hsspi_remove(struct platform_device *pdev)
 {
-	struct spi_master *master = platform_get_drvdata(pdev);
-	struct bcmbca_hsspi *bs = spi_master_get_devdata(master);
+	struct spi_controller *host = platform_get_drvdata(pdev);
+	struct bcmbca_hsspi *bs = spi_controller_get_devdata(host);
 
 	/* reset the hardware and block queue progress */
 	__raw_writel(0, bs->regs + HSSPI_INT_MASK_REG);
@@ -591,10 +591,10 @@ static void bcmbca_hsspi_remove(struct platform_device *pdev)
 #ifdef CONFIG_PM_SLEEP
 static int bcmbca_hsspi_suspend(struct device *dev)
 {
-	struct spi_master *master = dev_get_drvdata(dev);
-	struct bcmbca_hsspi *bs = spi_master_get_devdata(master);
+	struct spi_controller *host = dev_get_drvdata(dev);
+	struct bcmbca_hsspi *bs = spi_controller_get_devdata(host);
 
-	spi_master_suspend(master);
+	spi_controller_suspend(host);
 	clk_disable_unprepare(bs->pll_clk);
 	clk_disable_unprepare(bs->clk);
 
@@ -603,8 +603,8 @@ static int bcmbca_hsspi_suspend(struct device *dev)
 
 static int bcmbca_hsspi_resume(struct device *dev)
 {
-	struct spi_master *master = dev_get_drvdata(dev);
-	struct bcmbca_hsspi *bs = spi_master_get_devdata(master);
+	struct spi_controller *host = dev_get_drvdata(dev);
+	struct bcmbca_hsspi *bs = spi_controller_get_devdata(host);
 	int ret;
 
 	ret = clk_prepare_enable(bs->clk);
@@ -619,7 +619,7 @@ static int bcmbca_hsspi_resume(struct device *dev)
 		}
 	}
 
-	spi_master_resume(master);
+	spi_controller_resume(host);
 
 	return 0;
 }
-- 
2.25.1

