Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD6267772F5
	for <lists+linux-spi@lfdr.de>; Thu, 10 Aug 2023 10:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234206AbjHJIdL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 10 Aug 2023 04:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234208AbjHJIdL (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 10 Aug 2023 04:33:11 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F70E56
        for <linux-spi@vger.kernel.org>; Thu, 10 Aug 2023 01:33:10 -0700 (PDT)
Received: from dggpemm500006.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RM0XB4SV5zkX9K;
        Thu, 10 Aug 2023 16:31:54 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
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
Subject: [PATCH -next 07/21] spi: mpc512x-psc: switch to use modern name
Date:   Thu, 10 Aug 2023 16:29:50 +0800
Message-ID: <20230810083004.3988597-8-yangyingliang@huawei.com>
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
 drivers/spi/spi-mpc512x-psc.c | 54 +++++++++++++++++------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/drivers/spi/spi-mpc512x-psc.c b/drivers/spi/spi-mpc512x-psc.c
index 5cecca1bef02..7b4150f68165 100644
--- a/drivers/spi/spi-mpc512x-psc.c
+++ b/drivers/spi/spi-mpc512x-psc.c
@@ -85,7 +85,7 @@ static int mpc512x_psc_spi_transfer_setup(struct spi_device *spi,
 static void mpc512x_psc_spi_activate_cs(struct spi_device *spi)
 {
 	struct mpc512x_psc_spi_cs *cs = spi->controller_state;
-	struct mpc512x_psc_spi *mps = spi_master_get_devdata(spi->master);
+	struct mpc512x_psc_spi *mps = spi_controller_get_devdata(spi->controller);
 	u32 sicr;
 	u32 ccr;
 	int speed;
@@ -143,7 +143,7 @@ static void mpc512x_psc_spi_deactivate_cs(struct spi_device *spi)
 static int mpc512x_psc_spi_transfer_rxtx(struct spi_device *spi,
 					 struct spi_transfer *t)
 {
-	struct mpc512x_psc_spi *mps = spi_master_get_devdata(spi->master);
+	struct mpc512x_psc_spi *mps = spi_controller_get_devdata(spi->controller);
 	struct mpc512x_psc_fifo __iomem *fifo = mps->fifo;
 	size_t tx_len = t->len;
 	size_t rx_len = t->len;
@@ -280,7 +280,7 @@ static int mpc512x_psc_spi_transfer_rxtx(struct spi_device *spi,
 	return 0;
 }
 
-static int mpc512x_psc_spi_msg_xfer(struct spi_master *master,
+static int mpc512x_psc_spi_msg_xfer(struct spi_controller *host,
 				    struct spi_message *m)
 {
 	struct spi_device *spi;
@@ -320,15 +320,15 @@ static int mpc512x_psc_spi_msg_xfer(struct spi_master *master,
 
 	mpc512x_psc_spi_transfer_setup(spi, NULL);
 
-	spi_finalize_current_message(master);
+	spi_finalize_current_message(host);
 	return status;
 }
 
-static int mpc512x_psc_spi_prep_xfer_hw(struct spi_master *master)
+static int mpc512x_psc_spi_prep_xfer_hw(struct spi_controller *host)
 {
-	struct mpc512x_psc_spi *mps = spi_master_get_devdata(master);
+	struct mpc512x_psc_spi *mps = spi_controller_get_devdata(host);
 
-	dev_dbg(&master->dev, "%s()\n", __func__);
+	dev_dbg(&host->dev, "%s()\n", __func__);
 
 	/* Zero MR2 */
 	in_8(psc_addr(mps, mr2));
@@ -340,12 +340,12 @@ static int mpc512x_psc_spi_prep_xfer_hw(struct spi_master *master)
 	return 0;
 }
 
-static int mpc512x_psc_spi_unprep_xfer_hw(struct spi_master *master)
+static int mpc512x_psc_spi_unprep_xfer_hw(struct spi_controller *host)
 {
-	struct mpc512x_psc_spi *mps = spi_master_get_devdata(master);
+	struct mpc512x_psc_spi *mps = spi_controller_get_devdata(host);
 	struct mpc512x_psc_fifo __iomem *fifo = mps->fifo;
 
-	dev_dbg(&master->dev, "%s()\n", __func__);
+	dev_dbg(&host->dev, "%s()\n", __func__);
 
 	/* disable transmitter/receiver and fifo interrupt */
 	out_8(psc_addr(mps, command), MPC52xx_PSC_TX_DISABLE | MPC52xx_PSC_RX_DISABLE);
@@ -380,7 +380,7 @@ static void mpc512x_psc_spi_cleanup(struct spi_device *spi)
 	kfree(spi->controller_state);
 }
 
-static int mpc512x_psc_spi_port_config(struct spi_master *master,
+static int mpc512x_psc_spi_port_config(struct spi_controller *host,
 				       struct mpc512x_psc_spi *mps)
 {
 	struct mpc512x_psc_fifo __iomem *fifo = mps->fifo;
@@ -408,7 +408,7 @@ static int mpc512x_psc_spi_port_config(struct spi_master *master,
 	sicr =	0x01000000 |	/* SIM = 0001 -- 8 bit */
 		0x00800000 |	/* GenClk = 1 -- internal clk */
 		0x00008000 |	/* SPI = 1 */
-		0x00004000 |	/* MSTR = 1   -- SPI master */
+		0x00004000 |	/* HST = 1   -- SPI host */
 		0x00000800;	/* UseEOF = 1 -- SS low until EOF */
 
 	out_be32(psc_addr(mps, sicr), sicr);
@@ -459,28 +459,28 @@ static int mpc512x_psc_spi_of_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct mpc512x_psc_spi *mps;
-	struct spi_master *master;
+	struct spi_controller *host;
 	int ret;
 	void *tempp;
 	struct clk *clk;
 
-	master = devm_spi_alloc_master(dev, sizeof(*mps));
-	if (master == NULL)
+	host = devm_spi_alloc_host(dev, sizeof(*mps));
+	if (host == NULL)
 		return -ENOMEM;
 
-	dev_set_drvdata(dev, master);
-	mps = spi_master_get_devdata(master);
+	dev_set_drvdata(dev, host);
+	mps = spi_controller_get_devdata(host);
 	mps->type = (int)device_get_match_data(dev);
 
-	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LSB_FIRST;
-	master->setup = mpc512x_psc_spi_setup;
-	master->prepare_transfer_hardware = mpc512x_psc_spi_prep_xfer_hw;
-	master->transfer_one_message = mpc512x_psc_spi_msg_xfer;
-	master->unprepare_transfer_hardware = mpc512x_psc_spi_unprep_xfer_hw;
-	master->use_gpio_descriptors = true;
-	master->cleanup = mpc512x_psc_spi_cleanup;
+	host->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LSB_FIRST;
+	host->setup = mpc512x_psc_spi_setup;
+	host->prepare_transfer_hardware = mpc512x_psc_spi_prep_xfer_hw;
+	host->transfer_one_message = mpc512x_psc_spi_msg_xfer;
+	host->unprepare_transfer_hardware = mpc512x_psc_spi_unprep_xfer_hw;
+	host->use_gpio_descriptors = true;
+	host->cleanup = mpc512x_psc_spi_cleanup;
 
-	device_set_node(&master->dev, dev_fwnode(dev));
+	device_set_node(&host->dev, dev_fwnode(dev));
 
 	tempp = devm_platform_get_and_ioremap_resource(pdev, 0, NULL);
 	if (IS_ERR(tempp))
@@ -509,11 +509,11 @@ static int mpc512x_psc_spi_of_probe(struct platform_device *pdev)
 	if (IS_ERR(clk))
 		return PTR_ERR(clk);
 
-	ret = mpc512x_psc_spi_port_config(master, mps);
+	ret = mpc512x_psc_spi_port_config(host, mps);
 	if (ret < 0)
 		return ret;
 
-	return devm_spi_register_master(dev, master);
+	return devm_spi_register_controller(dev, host);
 }
 
 static const struct of_device_id mpc512x_psc_spi_of_match[] = {
-- 
2.25.1

