Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8ED1784F50
	for <lists+linux-spi@lfdr.de>; Wed, 23 Aug 2023 05:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232410AbjHWDdp (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 22 Aug 2023 23:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232431AbjHWDdm (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 22 Aug 2023 23:33:42 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33035CF2
        for <linux-spi@vger.kernel.org>; Tue, 22 Aug 2023 20:33:40 -0700 (PDT)
Received: from dggpemm500016.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RVsGJ53QXzrSfh;
        Wed, 23 Aug 2023 11:32:08 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500016.china.huawei.com (7.185.36.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 23 Aug 2023 11:33:38 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 23 Aug
 2023 11:33:37 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next v2 15/21] spi: mxic: switch to use modern name
Date:   Wed, 23 Aug 2023 11:29:57 +0800
Message-ID: <20230823033003.3407403-16-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230823033003.3407403-1-yangyingliang@huawei.com>
References: <20230823033003.3407403-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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
 drivers/spi/spi-mxic.c | 68 +++++++++++++++++++++---------------------
 1 file changed, 34 insertions(+), 34 deletions(-)

diff --git a/drivers/spi/spi-mxic.c b/drivers/spi/spi-mxic.c
index 00617fd4b2c3..60c9f3048ac9 100644
--- a/drivers/spi/spi-mxic.c
+++ b/drivers/spi/spi-mxic.c
@@ -390,7 +390,7 @@ static int mxic_spi_data_xfer(struct mxic_spi *mxic, const void *txbuf,
 static ssize_t mxic_spi_mem_dirmap_read(struct spi_mem_dirmap_desc *desc,
 					u64 offs, size_t len, void *buf)
 {
-	struct mxic_spi *mxic = spi_master_get_devdata(desc->mem->spi->master);
+	struct mxic_spi *mxic = spi_controller_get_devdata(desc->mem->spi->controller);
 	int ret;
 	u32 sts;
 
@@ -434,7 +434,7 @@ static ssize_t mxic_spi_mem_dirmap_write(struct spi_mem_dirmap_desc *desc,
 					 u64 offs, size_t len,
 					 const void *buf)
 {
-	struct mxic_spi *mxic = spi_master_get_devdata(desc->mem->spi->master);
+	struct mxic_spi *mxic = spi_controller_get_devdata(desc->mem->spi->controller);
 	u32 sts;
 	int ret;
 
@@ -493,7 +493,7 @@ static bool mxic_spi_mem_supports_op(struct spi_mem *mem,
 
 static int mxic_spi_mem_dirmap_create(struct spi_mem_dirmap_desc *desc)
 {
-	struct mxic_spi *mxic = spi_master_get_devdata(desc->mem->spi->master);
+	struct mxic_spi *mxic = spi_controller_get_devdata(desc->mem->spi->controller);
 
 	if (!mxic->linear.map)
 		return -EINVAL;
@@ -510,7 +510,7 @@ static int mxic_spi_mem_dirmap_create(struct spi_mem_dirmap_desc *desc)
 static int mxic_spi_mem_exec_op(struct spi_mem *mem,
 				const struct spi_mem_op *op)
 {
-	struct mxic_spi *mxic = spi_master_get_devdata(mem->spi->master);
+	struct mxic_spi *mxic = spi_controller_get_devdata(mem->spi->controller);
 	int i, ret;
 	u8 addr[8], cmd[2];
 
@@ -577,7 +577,7 @@ static const struct spi_controller_mem_caps mxic_spi_mem_caps = {
 
 static void mxic_spi_set_cs(struct spi_device *spi, bool lvl)
 {
-	struct mxic_spi *mxic = spi_master_get_devdata(spi->master);
+	struct mxic_spi *mxic = spi_controller_get_devdata(spi->controller);
 
 	if (!lvl) {
 		writel(readl(mxic->regs + HC_CFG) | HC_CFG_MAN_CS_EN,
@@ -592,11 +592,11 @@ static void mxic_spi_set_cs(struct spi_device *spi, bool lvl)
 	}
 }
 
-static int mxic_spi_transfer_one(struct spi_master *master,
+static int mxic_spi_transfer_one(struct spi_controller *host,
 				 struct spi_device *spi,
 				 struct spi_transfer *t)
 {
-	struct mxic_spi *mxic = spi_master_get_devdata(master);
+	struct mxic_spi *mxic = spi_controller_get_devdata(host);
 	unsigned int busw = OP_BUSW_1;
 	int ret;
 
@@ -632,7 +632,7 @@ static int mxic_spi_transfer_one(struct spi_master *master,
 	if (ret)
 		return ret;
 
-	spi_finalize_current_transfer(master);
+	spi_finalize_current_transfer(host);
 
 	return 0;
 }
@@ -713,8 +713,8 @@ static int mxic_spi_mem_ecc_probe(struct platform_device *pdev,
 
 static int __maybe_unused mxic_spi_runtime_suspend(struct device *dev)
 {
-	struct spi_master *master = dev_get_drvdata(dev);
-	struct mxic_spi *mxic = spi_master_get_devdata(master);
+	struct spi_controller *host = dev_get_drvdata(dev);
+	struct mxic_spi *mxic = spi_controller_get_devdata(host);
 
 	mxic_spi_clk_disable(mxic);
 	clk_disable_unprepare(mxic->ps_clk);
@@ -724,8 +724,8 @@ static int __maybe_unused mxic_spi_runtime_suspend(struct device *dev)
 
 static int __maybe_unused mxic_spi_runtime_resume(struct device *dev)
 {
-	struct spi_master *master = dev_get_drvdata(dev);
-	struct mxic_spi *mxic = spi_master_get_devdata(master);
+	struct spi_controller *host = dev_get_drvdata(dev);
+	struct mxic_spi *mxic = spi_controller_get_devdata(host);
 	int ret;
 
 	ret = clk_prepare_enable(mxic->ps_clk);
@@ -744,21 +744,21 @@ static const struct dev_pm_ops mxic_spi_dev_pm_ops = {
 
 static int mxic_spi_probe(struct platform_device *pdev)
 {
-	struct spi_master *master;
+	struct spi_controller *host;
 	struct resource *res;
 	struct mxic_spi *mxic;
 	int ret;
 
-	master = devm_spi_alloc_master(&pdev->dev, sizeof(struct mxic_spi));
-	if (!master)
+	host = devm_spi_alloc_host(&pdev->dev, sizeof(struct mxic_spi));
+	if (!host)
 		return -ENOMEM;
 
-	platform_set_drvdata(pdev, master);
+	platform_set_drvdata(pdev, host);
 
-	mxic = spi_master_get_devdata(master);
+	mxic = spi_controller_get_devdata(host);
 	mxic->dev = &pdev->dev;
 
-	master->dev.of_node = pdev->dev.of_node;
+	host->dev.of_node = pdev->dev.of_node;
 
 	mxic->ps_clk = devm_clk_get(&pdev->dev, "ps_clk");
 	if (IS_ERR(mxic->ps_clk))
@@ -786,19 +786,19 @@ static int mxic_spi_probe(struct platform_device *pdev)
 	}
 
 	pm_runtime_enable(&pdev->dev);
-	master->auto_runtime_pm = true;
+	host->auto_runtime_pm = true;
 
-	master->num_chipselect = 1;
-	master->mem_ops = &mxic_spi_mem_ops;
-	master->mem_caps = &mxic_spi_mem_caps;
+	host->num_chipselect = 1;
+	host->mem_ops = &mxic_spi_mem_ops;
+	host->mem_caps = &mxic_spi_mem_caps;
 
-	master->set_cs = mxic_spi_set_cs;
-	master->transfer_one = mxic_spi_transfer_one;
-	master->bits_per_word_mask = SPI_BPW_MASK(8);
-	master->mode_bits = SPI_CPOL | SPI_CPHA |
-			SPI_RX_DUAL | SPI_TX_DUAL |
-			SPI_RX_QUAD | SPI_TX_QUAD |
-			SPI_RX_OCTAL | SPI_TX_OCTAL;
+	host->set_cs = mxic_spi_set_cs;
+	host->transfer_one = mxic_spi_transfer_one;
+	host->bits_per_word_mask = SPI_BPW_MASK(8);
+	host->mode_bits = SPI_CPOL | SPI_CPHA |
+			  SPI_RX_DUAL | SPI_TX_DUAL |
+			  SPI_RX_QUAD | SPI_TX_QUAD |
+			  SPI_RX_OCTAL | SPI_TX_OCTAL;
 
 	mxic_spi_hw_init(mxic);
 
@@ -808,9 +808,9 @@ static int mxic_spi_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = spi_register_master(master);
+	ret = spi_register_controller(host);
 	if (ret) {
-		dev_err(&pdev->dev, "spi_register_master failed\n");
+		dev_err(&pdev->dev, "spi_register_controller failed\n");
 		pm_runtime_disable(&pdev->dev);
 		mxic_spi_mem_ecc_remove(mxic);
 	}
@@ -820,12 +820,12 @@ static int mxic_spi_probe(struct platform_device *pdev)
 
 static void mxic_spi_remove(struct platform_device *pdev)
 {
-	struct spi_master *master = platform_get_drvdata(pdev);
-	struct mxic_spi *mxic = spi_master_get_devdata(master);
+	struct spi_controller *host = platform_get_drvdata(pdev);
+	struct mxic_spi *mxic = spi_controller_get_devdata(host);
 
 	pm_runtime_disable(&pdev->dev);
 	mxic_spi_mem_ecc_remove(mxic);
-	spi_unregister_master(master);
+	spi_unregister_controller(host);
 }
 
 static const struct of_device_id mxic_spi_of_ids[] = {
-- 
2.25.1

