Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E096D772725
	for <lists+linux-spi@lfdr.de>; Mon,  7 Aug 2023 16:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232070AbjHGOKW (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 7 Aug 2023 10:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232017AbjHGOKS (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 7 Aug 2023 10:10:18 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C52BE53
        for <linux-spi@vger.kernel.org>; Mon,  7 Aug 2023 07:10:17 -0700 (PDT)
Received: from dggpemm100004.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RKJ601s9ZztRyG;
        Mon,  7 Aug 2023 22:06:48 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm100004.china.huawei.com (7.185.36.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 7 Aug 2023 22:10:15 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 7 Aug
 2023 22:10:14 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next v2 13/21] spi: clps711x: switch to use modern name
Date:   Mon, 7 Aug 2023 22:07:09 +0800
Message-ID: <20230807140717.3484180-14-yangyingliang@huawei.com>
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
 drivers/spi/spi-clps711x.c | 42 +++++++++++++++++++-------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/spi/spi-clps711x.c b/drivers/spi/spi-clps711x.c
index c005ed26a3e1..5552ccd716fc 100644
--- a/drivers/spi/spi-clps711x.c
+++ b/drivers/spi/spi-clps711x.c
@@ -33,10 +33,10 @@ struct spi_clps711x_data {
 	int			len;
 };
 
-static int spi_clps711x_prepare_message(struct spi_master *master,
+static int spi_clps711x_prepare_message(struct spi_controller *host,
 					struct spi_message *msg)
 {
-	struct spi_clps711x_data *hw = spi_master_get_devdata(master);
+	struct spi_clps711x_data *hw = spi_controller_get_devdata(host);
 	struct spi_device *spi = msg->spi;
 
 	/* Setup mode for transfer */
@@ -45,11 +45,11 @@ static int spi_clps711x_prepare_message(struct spi_master *master,
 				  SYSCON3_ADCCKNSEN : 0);
 }
 
-static int spi_clps711x_transfer_one(struct spi_master *master,
+static int spi_clps711x_transfer_one(struct spi_controller *host,
 				     struct spi_device *spi,
 				     struct spi_transfer *xfer)
 {
-	struct spi_clps711x_data *hw = spi_master_get_devdata(master);
+	struct spi_clps711x_data *hw = spi_controller_get_devdata(host);
 	u8 data;
 
 	clk_set_rate(hw->spi_clk, xfer->speed_hz ? : spi->max_speed_hz);
@@ -68,8 +68,8 @@ static int spi_clps711x_transfer_one(struct spi_master *master,
 
 static irqreturn_t spi_clps711x_isr(int irq, void *dev_id)
 {
-	struct spi_master *master = dev_id;
-	struct spi_clps711x_data *hw = spi_master_get_devdata(master);
+	struct spi_controller *host = dev_id;
+	struct spi_clps711x_data *hw = spi_controller_get_devdata(host);
 	u8 data;
 
 	/* Handle RX */
@@ -83,7 +83,7 @@ static irqreturn_t spi_clps711x_isr(int irq, void *dev_id)
 		writel(data | SYNCIO_FRMLEN(hw->bpw) | SYNCIO_TXFRMEN,
 		       hw->syncio);
 	} else
-		spi_finalize_current_transfer(master);
+		spi_finalize_current_transfer(host);
 
 	return IRQ_HANDLED;
 }
@@ -92,26 +92,26 @@ static int spi_clps711x_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
 	struct spi_clps711x_data *hw;
-	struct spi_master *master;
+	struct spi_controller *host;
 	int irq, ret;
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
 		return irq;
 
-	master = spi_alloc_master(&pdev->dev, sizeof(*hw));
-	if (!master)
+	host = spi_alloc_host(&pdev->dev, sizeof(*hw));
+	if (!host)
 		return -ENOMEM;
 
-	master->use_gpio_descriptors = true;
-	master->bus_num = -1;
-	master->mode_bits = SPI_CPHA | SPI_CS_HIGH;
-	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(1, 8);
-	master->dev.of_node = pdev->dev.of_node;
-	master->prepare_message = spi_clps711x_prepare_message;
-	master->transfer_one = spi_clps711x_transfer_one;
+	host->use_gpio_descriptors = true;
+	host->bus_num = -1;
+	host->mode_bits = SPI_CPHA | SPI_CS_HIGH;
+	host->bits_per_word_mask = SPI_BPW_RANGE_MASK(1, 8);
+	host->dev.of_node = pdev->dev.of_node;
+	host->prepare_message = spi_clps711x_prepare_message;
+	host->transfer_one = spi_clps711x_transfer_one;
 
-	hw = spi_master_get_devdata(master);
+	hw = spi_controller_get_devdata(host);
 
 	hw->spi_clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(hw->spi_clk)) {
@@ -138,16 +138,16 @@ static int spi_clps711x_probe(struct platform_device *pdev)
 	readl(hw->syncio);
 
 	ret = devm_request_irq(&pdev->dev, irq, spi_clps711x_isr, 0,
-			       dev_name(&pdev->dev), master);
+			       dev_name(&pdev->dev), host);
 	if (ret)
 		goto err_out;
 
-	ret = devm_spi_register_master(&pdev->dev, master);
+	ret = devm_spi_register_controller(&pdev->dev, host);
 	if (!ret)
 		return 0;
 
 err_out:
-	spi_master_put(master);
+	spi_controller_put(host);
 
 	return ret;
 }
-- 
2.25.1

