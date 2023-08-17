Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA08F77F019
	for <lists+linux-spi@lfdr.de>; Thu, 17 Aug 2023 07:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348072AbjHQFHz (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 17 Aug 2023 01:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348070AbjHQFHd (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 17 Aug 2023 01:07:33 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 527C2269F
        for <linux-spi@vger.kernel.org>; Wed, 16 Aug 2023 22:07:31 -0700 (PDT)
Received: from dggpemm100011.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RRCdX1bSSz1GDrG;
        Thu, 17 Aug 2023 13:06:08 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm100011.china.huawei.com (7.185.36.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 17 Aug 2023 13:07:29 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Thu, 17 Aug
 2023 13:07:28 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next v2 06/23] spi: ppc4xx: switch to use modern name
Date:   Thu, 17 Aug 2023 13:03:15 +0800
Message-ID: <20230817050332.1274751-7-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230817050332.1274751-1-yangyingliang@huawei.com>
References: <20230817050332.1274751-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Change legacy name master to modern name host or controller.

No functional changed.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/spi/spi-ppc4xx.c | 44 ++++++++++++++++++++--------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/spi/spi-ppc4xx.c b/drivers/spi/spi-ppc4xx.c
index d725e915025d..03aab661be9d 100644
--- a/drivers/spi/spi-ppc4xx.c
+++ b/drivers/spi/spi-ppc4xx.c
@@ -126,7 +126,7 @@ struct ppc4xx_spi {
 	unsigned char *rx;
 
 	struct spi_ppc4xx_regs __iomem *regs; /* pointer to the registers */
-	struct spi_master *master;
+	struct spi_controller *host;
 	struct device *dev;
 };
 
@@ -143,7 +143,7 @@ static int spi_ppc4xx_txrx(struct spi_device *spi, struct spi_transfer *t)
 	dev_dbg(&spi->dev, "txrx: tx %p, rx %p, len %d\n",
 		t->tx_buf, t->rx_buf, t->len);
 
-	hw = spi_master_get_devdata(spi->master);
+	hw = spi_controller_get_devdata(spi->controller);
 
 	hw->tx = t->tx_buf;
 	hw->rx = t->rx_buf;
@@ -161,7 +161,7 @@ static int spi_ppc4xx_txrx(struct spi_device *spi, struct spi_transfer *t)
 
 static int spi_ppc4xx_setupxfer(struct spi_device *spi, struct spi_transfer *t)
 {
-	struct ppc4xx_spi *hw = spi_master_get_devdata(spi->master);
+	struct ppc4xx_spi *hw = spi_controller_get_devdata(spi->controller);
 	struct spi_ppc4xx_cs *cs = spi->controller_state;
 	int scr;
 	u8 cdm = 0;
@@ -340,7 +340,7 @@ static void spi_ppc4xx_enable(struct ppc4xx_spi *hw)
 static int spi_ppc4xx_of_probe(struct platform_device *op)
 {
 	struct ppc4xx_spi *hw;
-	struct spi_master *master;
+	struct spi_controller *host;
 	struct spi_bitbang *bbp;
 	struct resource resource;
 	struct device_node *np = op->dev.of_node;
@@ -349,20 +349,20 @@ static int spi_ppc4xx_of_probe(struct platform_device *op)
 	int ret;
 	const unsigned int *clk;
 
-	master = spi_alloc_master(dev, sizeof(*hw));
-	if (master == NULL)
+	host = spi_alloc_host(dev, sizeof(*hw));
+	if (host == NULL)
 		return -ENOMEM;
-	master->dev.of_node = np;
-	platform_set_drvdata(op, master);
-	hw = spi_master_get_devdata(master);
-	hw->master = master;
+	host->dev.of_node = np;
+	platform_set_drvdata(op, host);
+	hw = spi_controller_get_devdata(host);
+	hw->host = host;
 	hw->dev = dev;
 
 	init_completion(&hw->done);
 
 	/* Setup the state for the bitbang driver */
 	bbp = &hw->bitbang;
-	bbp->master = hw->master;
+	bbp->master = hw->host;
 	bbp->setup_transfer = spi_ppc4xx_setupxfer;
 	bbp->txrx_bufs = spi_ppc4xx_txrx;
 	bbp->use_dma = 0;
@@ -385,7 +385,7 @@ static int spi_ppc4xx_of_probe(struct platform_device *op)
 	if (opbnp == NULL) {
 		dev_err(dev, "OPB: cannot find node\n");
 		ret = -ENODEV;
-		goto free_master;
+		goto free_host;
 	}
 	/* Get the clock (Hz) for the OPB */
 	clk = of_get_property(opbnp, "clock-frequency", NULL);
@@ -393,7 +393,7 @@ static int spi_ppc4xx_of_probe(struct platform_device *op)
 		dev_err(dev, "OPB: no clock-frequency property set\n");
 		of_node_put(opbnp);
 		ret = -ENODEV;
-		goto free_master;
+		goto free_host;
 	}
 	hw->opb_freq = *clk;
 	hw->opb_freq >>= 2;
@@ -402,7 +402,7 @@ static int spi_ppc4xx_of_probe(struct platform_device *op)
 	ret = of_address_to_resource(np, 0, &resource);
 	if (ret) {
 		dev_err(dev, "error while parsing device node resource\n");
-		goto free_master;
+		goto free_host;
 	}
 	hw->mapbase = resource.start;
 	hw->mapsize = resource_size(&resource);
@@ -411,7 +411,7 @@ static int spi_ppc4xx_of_probe(struct platform_device *op)
 	if (hw->mapsize < sizeof(struct spi_ppc4xx_regs)) {
 		dev_err(dev, "too small to map registers\n");
 		ret = -EINVAL;
-		goto free_master;
+		goto free_host;
 	}
 
 	/* Request IRQ */
@@ -420,7 +420,7 @@ static int spi_ppc4xx_of_probe(struct platform_device *op)
 			  0, "spi_ppc4xx_of", (void *)hw);
 	if (ret) {
 		dev_err(dev, "unable to allocate interrupt\n");
-		goto free_master;
+		goto free_host;
 	}
 
 	if (!request_mem_region(hw->mapbase, hw->mapsize, DRIVER_NAME)) {
@@ -443,7 +443,7 @@ static int spi_ppc4xx_of_probe(struct platform_device *op)
 	dev->dma_mask = 0;
 	ret = spi_bitbang_start(bbp);
 	if (ret) {
-		dev_err(dev, "failed to register SPI master\n");
+		dev_err(dev, "failed to register SPI host\n");
 		goto unmap_regs;
 	}
 
@@ -457,8 +457,8 @@ static int spi_ppc4xx_of_probe(struct platform_device *op)
 	release_mem_region(hw->mapbase, hw->mapsize);
 request_mem_error:
 	free_irq(hw->irqnum, hw);
-free_master:
-	spi_master_put(master);
+free_host:
+	spi_controller_put(host);
 
 	dev_err(dev, "initialization failed\n");
 	return ret;
@@ -466,14 +466,14 @@ static int spi_ppc4xx_of_probe(struct platform_device *op)
 
 static void spi_ppc4xx_of_remove(struct platform_device *op)
 {
-	struct spi_master *master = platform_get_drvdata(op);
-	struct ppc4xx_spi *hw = spi_master_get_devdata(master);
+	struct spi_controller *host = platform_get_drvdata(op);
+	struct ppc4xx_spi *hw = spi_controller_get_devdata(host);
 
 	spi_bitbang_stop(&hw->bitbang);
 	release_mem_region(hw->mapbase, hw->mapsize);
 	free_irq(hw->irqnum, hw);
 	iounmap(hw->regs);
-	spi_master_put(master);
+	spi_controller_put(host);
 }
 
 static const struct of_device_id spi_ppc4xx_of_match[] = {
-- 
2.25.1

