Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5EAA780899
	for <lists+linux-spi@lfdr.de>; Fri, 18 Aug 2023 11:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351929AbjHRJf4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 18 Aug 2023 05:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359278AbjHRJfZ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 18 Aug 2023 05:35:25 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4284E3AAC
        for <linux-spi@vger.kernel.org>; Fri, 18 Aug 2023 02:35:23 -0700 (PDT)
Received: from dggpemm100019.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RRxTV3TZVztRYv;
        Fri, 18 Aug 2023 17:31:42 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm100019.china.huawei.com (7.185.36.251) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 18 Aug 2023 17:35:21 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Fri, 18 Aug
 2023 17:35:20 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next v3 12/23] spi: rockchip-sfc: switch to use modern name
Date:   Fri, 18 Aug 2023 17:31:43 +0800
Message-ID: <20230818093154.1183529-13-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230818093154.1183529-1-yangyingliang@huawei.com>
References: <20230818093154.1183529-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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
 drivers/spi/spi-rockchip-sfc.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/spi/spi-rockchip-sfc.c b/drivers/spi/spi-rockchip-sfc.c
index bd550e76ab3d..0d7fadcd4ed3 100644
--- a/drivers/spi/spi-rockchip-sfc.c
+++ b/drivers/spi/spi-rockchip-sfc.c
@@ -487,7 +487,7 @@ static int rockchip_sfc_xfer_done(struct rockchip_sfc *sfc, u32 timeout_us)
 
 static int rockchip_sfc_exec_mem_op(struct spi_mem *mem, const struct spi_mem_op *op)
 {
-	struct rockchip_sfc *sfc = spi_master_get_devdata(mem->spi->master);
+	struct rockchip_sfc *sfc = spi_controller_get_devdata(mem->spi->controller);
 	u32 len = op->data.nbytes;
 	int ret;
 
@@ -523,7 +523,7 @@ static int rockchip_sfc_exec_mem_op(struct spi_mem *mem, const struct spi_mem_op
 
 static int rockchip_sfc_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op)
 {
-	struct rockchip_sfc *sfc = spi_master_get_devdata(mem->spi->master);
+	struct rockchip_sfc *sfc = spi_controller_get_devdata(mem->spi->controller);
 
 	op->data.nbytes = min(op->data.nbytes, sfc->max_iosize);
 
@@ -557,22 +557,22 @@ static irqreturn_t rockchip_sfc_irq_handler(int irq, void *dev_id)
 static int rockchip_sfc_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct spi_master *master;
+	struct spi_controller *host;
 	struct rockchip_sfc *sfc;
 	int ret;
 
-	master = devm_spi_alloc_master(&pdev->dev, sizeof(*sfc));
-	if (!master)
+	host = devm_spi_alloc_host(&pdev->dev, sizeof(*sfc));
+	if (!host)
 		return -ENOMEM;
 
-	master->flags = SPI_CONTROLLER_HALF_DUPLEX;
-	master->mem_ops = &rockchip_sfc_mem_ops;
-	master->dev.of_node = pdev->dev.of_node;
-	master->mode_bits = SPI_TX_QUAD | SPI_TX_DUAL | SPI_RX_QUAD | SPI_RX_DUAL;
-	master->max_speed_hz = SFC_MAX_SPEED;
-	master->num_chipselect = SFC_MAX_CHIPSELECT_NUM;
+	host->flags = SPI_CONTROLLER_HALF_DUPLEX;
+	host->mem_ops = &rockchip_sfc_mem_ops;
+	host->dev.of_node = pdev->dev.of_node;
+	host->mode_bits = SPI_TX_QUAD | SPI_TX_DUAL | SPI_RX_QUAD | SPI_RX_DUAL;
+	host->max_speed_hz = SFC_MAX_SPEED;
+	host->num_chipselect = SFC_MAX_CHIPSELECT_NUM;
 
-	sfc = spi_master_get_devdata(master);
+	sfc = spi_controller_get_devdata(host);
 	sfc->dev = dev;
 
 	sfc->regbase = devm_platform_ioremap_resource(pdev, 0);
@@ -640,7 +640,7 @@ static int rockchip_sfc_probe(struct platform_device *pdev)
 	sfc->max_iosize = rockchip_sfc_get_max_iosize(sfc);
 	sfc->version = rockchip_sfc_get_version(sfc);
 
-	ret = spi_register_master(master);
+	ret = spi_register_controller(host);
 	if (ret)
 		goto err_irq;
 
@@ -656,10 +656,10 @@ static int rockchip_sfc_probe(struct platform_device *pdev)
 
 static void rockchip_sfc_remove(struct platform_device *pdev)
 {
-	struct spi_master *master = platform_get_drvdata(pdev);
+	struct spi_controller *host = platform_get_drvdata(pdev);
 	struct rockchip_sfc *sfc = platform_get_drvdata(pdev);
 
-	spi_unregister_master(master);
+	spi_unregister_controller(host);
 
 	clk_disable_unprepare(sfc->clk);
 	clk_disable_unprepare(sfc->hclk);
-- 
2.25.1

