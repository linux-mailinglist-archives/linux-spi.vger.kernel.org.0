Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 047767772F7
	for <lists+linux-spi@lfdr.de>; Thu, 10 Aug 2023 10:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234220AbjHJIdN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 10 Aug 2023 04:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234208AbjHJIdM (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 10 Aug 2023 04:33:12 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1EB5E7E
        for <linux-spi@vger.kernel.org>; Thu, 10 Aug 2023 01:33:10 -0700 (PDT)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RM0TZ6szyzJskT;
        Thu, 10 Aug 2023 16:29:38 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 10 Aug 2023 16:33:07 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 10 Aug
 2023 16:33:07 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next 08/21] spi: mpc52xx-psc: switch to use modern name
Date:   Thu, 10 Aug 2023 16:29:51 +0800
Message-ID: <20230810083004.3988597-9-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230810083004.3988597-1-yangyingliang@huawei.com>
References: <20230810083004.3988597-1-yangyingliang@huawei.com>
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
 drivers/spi/spi-mpc52xx-psc.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/spi/spi-mpc52xx-psc.c b/drivers/spi/spi-mpc52xx-psc.c
index 795c08594a4d..78405cb45c96 100644
--- a/drivers/spi/spi-mpc52xx-psc.c
+++ b/drivers/spi/spi-mpc52xx-psc.c
@@ -60,7 +60,7 @@ static int mpc52xx_psc_spi_transfer_setup(struct spi_device *spi,
 static void mpc52xx_psc_spi_activate_cs(struct spi_device *spi)
 {
 	struct mpc52xx_psc_spi_cs *cs = spi->controller_state;
-	struct mpc52xx_psc_spi *mps = spi_master_get_devdata(spi->master);
+	struct mpc52xx_psc_spi *mps = spi_controller_get_devdata(spi->controller);
 	struct mpc52xx_psc __iomem *psc = mps->psc;
 	u32 sicr;
 	u16 ccr;
@@ -104,7 +104,7 @@ static void mpc52xx_psc_spi_activate_cs(struct spi_device *spi)
 static int mpc52xx_psc_spi_transfer_rxtx(struct spi_device *spi,
 						struct spi_transfer *t)
 {
-	struct mpc52xx_psc_spi *mps = spi_master_get_devdata(spi->master);
+	struct mpc52xx_psc_spi *mps = spi_controller_get_devdata(spi->controller);
 	struct mpc52xx_psc __iomem *psc = mps->psc;
 	struct mpc52xx_psc_fifo __iomem *fifo = mps->fifo;
 	unsigned rb = 0;	/* number of bytes receieved */
@@ -263,7 +263,7 @@ static int mpc52xx_psc_spi_port_config(int psc_id, struct mpc52xx_psc_spi *mps)
 	out_8(&fifo->rfcntl, 0);
 	out_8(&psc->mode, MPC52xx_PSC_MODE_FFULL);
 
-	/* Configure 8bit codec mode as a SPI master and use EOF flags */
+	/* Configure 8bit codec mode as a SPI host and use EOF flags */
 	/* SICR_SIM_CODEC8|SICR_GENCLK|SICR_SPI|SICR_MSTR|SICR_USEEOF */
 	out_be32(&psc->sicr, 0x0180C800);
 	out_be16((u16 __iomem *)&psc->ccr, 0x070F); /* default SPI Clk 1MHz */
@@ -295,31 +295,31 @@ static int mpc52xx_psc_spi_of_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct mpc52xx_psc_spi *mps;
-	struct spi_master *master;
+	struct spi_controller *host;
 	u32 bus_num;
 	int ret;
 
-	master = devm_spi_alloc_master(dev, sizeof(*mps));
-	if (master == NULL)
+	host = devm_spi_alloc_host(dev, sizeof(*mps));
+	if (host == NULL)
 		return -ENOMEM;
 
-	dev_set_drvdata(dev, master);
-	mps = spi_master_get_devdata(master);
+	dev_set_drvdata(dev, host);
+	mps = spi_controller_get_devdata(host);
 
 	/* the spi->mode bits understood by this driver: */
-	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LSB_FIRST;
+	host->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LSB_FIRST;
 
 	ret = device_property_read_u32(dev, "cell-index", &bus_num);
 	if (ret || bus_num > 5)
 		return dev_err_probe(dev, ret ? : -EINVAL, "Invalid cell-index property\n");
-	master->bus_num = bus_num + 1;
+	host->bus_num = bus_num + 1;
 
-	master->num_chipselect = 255;
-	master->setup = mpc52xx_psc_spi_setup;
-	master->transfer_one_message = mpc52xx_psc_spi_transfer_one_message;
-	master->cleanup = mpc52xx_psc_spi_cleanup;
+	host->num_chipselect = 255;
+	host->setup = mpc52xx_psc_spi_setup;
+	host->transfer_one_message = mpc52xx_psc_spi_transfer_one_message;
+	host->cleanup = mpc52xx_psc_spi_cleanup;
 
-	device_set_node(&master->dev, dev_fwnode(dev));
+	device_set_node(&host->dev, dev_fwnode(dev));
 
 	mps->psc = devm_platform_get_and_ioremap_resource(pdev, 0, NULL);
 	if (IS_ERR(mps->psc))
@@ -337,13 +337,13 @@ static int mpc52xx_psc_spi_of_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = mpc52xx_psc_spi_port_config(master->bus_num, mps);
+	ret = mpc52xx_psc_spi_port_config(host->bus_num, mps);
 	if (ret < 0)
 		return dev_err_probe(dev, ret, "can't configure PSC! Is it capable of SPI?\n");
 
 	init_completion(&mps->done);
 
-	return devm_spi_register_master(dev, master);
+	return devm_spi_register_controller(dev, host);
 }
 
 static const struct of_device_id mpc52xx_psc_spi_of_match[] = {
-- 
2.25.1

