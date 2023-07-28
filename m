Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2AD7668F9
	for <lists+linux-spi@lfdr.de>; Fri, 28 Jul 2023 11:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235477AbjG1JfS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 28 Jul 2023 05:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235480AbjG1JfM (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 28 Jul 2023 05:35:12 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8667F10EC
        for <linux-spi@vger.kernel.org>; Fri, 28 Jul 2023 02:35:11 -0700 (PDT)
Received: from dggpemm500012.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RC2TF1gDNzNmfZ;
        Fri, 28 Jul 2023 17:31:45 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500012.china.huawei.com (7.185.36.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 28 Jul 2023 17:35:08 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 28 Jul
 2023 17:35:08 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next 11/21] spi: cadence-xspi: switch to use modern name
Date:   Fri, 28 Jul 2023 17:32:11 +0800
Message-ID: <20230728093221.3312026-12-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230728093221.3312026-1-yangyingliang@huawei.com>
References: <20230728093221.3312026-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Change legacy name master to modern name host or controller.

No functional changed.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/spi/spi-cadence-xspi.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/spi/spi-cadence-xspi.c b/drivers/spi/spi-cadence-xspi.c
index 11d623cbba2e..b7e04b03be58 100644
--- a/drivers/spi/spi-cadence-xspi.c
+++ b/drivers/spi/spi-cadence-xspi.c
@@ -419,7 +419,7 @@ static int cdns_xspi_mem_op_execute(struct spi_mem *mem,
 				    const struct spi_mem_op *op)
 {
 	struct cdns_xspi_dev *cdns_xspi =
-		spi_master_get_devdata(mem->spi->master);
+		spi_controller_get_devdata(mem->spi->controller);
 	int ret = 0;
 
 	ret = cdns_xspi_mem_op(cdns_xspi, mem, op);
@@ -430,7 +430,7 @@ static int cdns_xspi_mem_op_execute(struct spi_mem *mem,
 static int cdns_xspi_adjust_mem_op_size(struct spi_mem *mem, struct spi_mem_op *op)
 {
 	struct cdns_xspi_dev *cdns_xspi =
-		spi_master_get_devdata(mem->spi->master);
+		spi_controller_get_devdata(mem->spi->controller);
 
 	op->data.nbytes = clamp_val(op->data.nbytes, 0, cdns_xspi->sdmasize);
 
@@ -527,26 +527,26 @@ static void cdns_xspi_print_phy_config(struct cdns_xspi_dev *cdns_xspi)
 static int cdns_xspi_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct spi_master *master = NULL;
+	struct spi_controller *host = NULL;
 	struct cdns_xspi_dev *cdns_xspi = NULL;
 	struct resource *res;
 	int ret;
 
-	master = devm_spi_alloc_master(dev, sizeof(*cdns_xspi));
-	if (!master)
+	host = devm_spi_alloc_host(dev, sizeof(*cdns_xspi));
+	if (!host)
 		return -ENOMEM;
 
-	master->mode_bits = SPI_3WIRE | SPI_TX_DUAL  | SPI_TX_QUAD  |
+	host->mode_bits = SPI_3WIRE | SPI_TX_DUAL  | SPI_TX_QUAD  |
 		SPI_RX_DUAL | SPI_RX_QUAD | SPI_TX_OCTAL | SPI_RX_OCTAL |
 		SPI_MODE_0  | SPI_MODE_3;
 
-	master->mem_ops = &cadence_xspi_mem_ops;
-	master->dev.of_node = pdev->dev.of_node;
-	master->bus_num = -1;
+	host->mem_ops = &cadence_xspi_mem_ops;
+	host->dev.of_node = pdev->dev.of_node;
+	host->bus_num = -1;
 
-	platform_set_drvdata(pdev, master);
+	platform_set_drvdata(pdev, host);
 
-	cdns_xspi = spi_master_get_devdata(master);
+	cdns_xspi = spi_controller_get_devdata(host);
 	cdns_xspi->pdev = pdev;
 	cdns_xspi->dev = &pdev->dev;
 	cdns_xspi->cur_cs = 0;
@@ -596,15 +596,15 @@ static int cdns_xspi_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	master->num_chipselect = 1 << cdns_xspi->hw_num_banks;
+	host->num_chipselect = 1 << cdns_xspi->hw_num_banks;
 
-	ret = devm_spi_register_master(dev, master);
+	ret = devm_spi_register_controller(dev, host);
 	if (ret) {
-		dev_err(dev, "Failed to register SPI master\n");
+		dev_err(dev, "Failed to register SPI host\n");
 		return ret;
 	}
 
-	dev_info(dev, "Successfully registered SPI master\n");
+	dev_info(dev, "Successfully registered SPI host\n");
 
 	return 0;
 }
-- 
2.25.1

