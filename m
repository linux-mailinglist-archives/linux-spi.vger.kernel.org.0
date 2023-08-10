Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE3F777305
	for <lists+linux-spi@lfdr.de>; Thu, 10 Aug 2023 10:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234233AbjHJIdU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 10 Aug 2023 04:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234232AbjHJIdU (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 10 Aug 2023 04:33:20 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D77FED
        for <linux-spi@vger.kernel.org>; Thu, 10 Aug 2023 01:33:19 -0700 (PDT)
Received: from dggpemm500004.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RM0XN27SGzkX9y;
        Thu, 10 Aug 2023 16:32:04 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500004.china.huawei.com (7.185.36.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 10 Aug 2023 16:33:08 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 10 Aug
 2023 16:33:07 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next 09/21] spi: mpc52xx: switch to use modern name
Date:   Thu, 10 Aug 2023 16:29:52 +0800
Message-ID: <20230810083004.3988597-10-yangyingliang@huawei.com>
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
 drivers/spi/spi-mpc52xx.c | 56 +++++++++++++++++++--------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/spi/spi-mpc52xx.c b/drivers/spi/spi-mpc52xx.c
index ab7df5f64342..4a6c984b6bff 100644
--- a/drivers/spi/spi-mpc52xx.c
+++ b/drivers/spi/spi-mpc52xx.c
@@ -62,7 +62,7 @@ MODULE_LICENSE("GPL");
 
 /* Driver internal data */
 struct mpc52xx_spi {
-	struct spi_master *master;
+	struct spi_controller *host;
 	void __iomem *regs;
 	int irq0;	/* MODF irq */
 	int irq1;	/* SPIF irq */
@@ -152,7 +152,7 @@ mpc52xx_spi_fsmstate_idle(int irq, struct mpc52xx_spi *ms, u8 status, u8 data)
 	u8 ctrl1;
 
 	if (status && irq)
-		dev_err(&ms->master->dev, "spurious irq, status=0x%.2x\n",
+		dev_err(&ms->host->dev, "spurious irq, status=0x%.2x\n",
 			status);
 
 	/* Check if there is another transfer waiting. */
@@ -235,7 +235,7 @@ static int mpc52xx_spi_fsmstate_transfer(int irq, struct mpc52xx_spi *ms,
 		return FSM_CONTINUE;
 	} else if (status & SPI_STATUS_MODF) {
 		ms->modf_count++;
-		dev_err(&ms->master->dev, "mode fault\n");
+		dev_err(&ms->host->dev, "mode fault\n");
 		mpc52xx_spi_chipsel(ms, 0);
 		ms->message->status = -EIO;
 		if (ms->message->complete)
@@ -280,7 +280,7 @@ static int
 mpc52xx_spi_fsmstate_wait(int irq, struct mpc52xx_spi *ms, u8 status, u8 data)
 {
 	if (status && irq)
-		dev_err(&ms->master->dev, "spurious irq, status=0x%.2x\n",
+		dev_err(&ms->host->dev, "spurious irq, status=0x%.2x\n",
 			status);
 
 	if (((int)mftb()) - ms->timestamp < 0)
@@ -361,12 +361,12 @@ static void mpc52xx_spi_wq(struct work_struct *work)
 }
 
 /*
- * spi_master ops
+ * spi_controller ops
  */
 
 static int mpc52xx_spi_transfer(struct spi_device *spi, struct spi_message *m)
 {
-	struct mpc52xx_spi *ms = spi_master_get_devdata(spi->master);
+	struct mpc52xx_spi *ms = spi_controller_get_devdata(spi->controller);
 	unsigned long flags;
 
 	m->actual_length = 0;
@@ -385,7 +385,7 @@ static int mpc52xx_spi_transfer(struct spi_device *spi, struct spi_message *m)
  */
 static int mpc52xx_spi_probe(struct platform_device *op)
 {
-	struct spi_master *master;
+	struct spi_controller *host;
 	struct mpc52xx_spi *ms;
 	struct gpio_desc *gpio_cs;
 	void __iomem *regs;
@@ -406,7 +406,7 @@ static int mpc52xx_spi_probe(struct platform_device *op)
 	out_8(regs + SPI_PORTDATA, 0x8);	/* Deassert /SS signal */
 
 	/* Clear the status register and re-read it to check for a MODF
-	 * failure.  This driver cannot currently handle multiple masters
+	 * failure.  This driver cannot currently handle multiple hosts
 	 * on the SPI bus.  This fault will also occur if the SPI signals
 	 * are not connected to any pins (port_config setting) */
 	in_8(regs + SPI_STATUS);
@@ -419,22 +419,22 @@ static int mpc52xx_spi_probe(struct platform_device *op)
 		goto err_init;
 	}
 
-	dev_dbg(&op->dev, "allocating spi_master struct\n");
-	master = spi_alloc_master(&op->dev, sizeof(*ms));
-	if (!master) {
+	dev_dbg(&op->dev, "allocating spi_controller struct\n");
+	host = spi_alloc_host(&op->dev, sizeof(*ms));
+	if (!host) {
 		rc = -ENOMEM;
 		goto err_alloc;
 	}
 
-	master->transfer = mpc52xx_spi_transfer;
-	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_LSB_FIRST;
-	master->bits_per_word_mask = SPI_BPW_MASK(8);
-	master->dev.of_node = op->dev.of_node;
+	host->transfer = mpc52xx_spi_transfer;
+	host->mode_bits = SPI_CPOL | SPI_CPHA | SPI_LSB_FIRST;
+	host->bits_per_word_mask = SPI_BPW_MASK(8);
+	host->dev.of_node = op->dev.of_node;
 
-	platform_set_drvdata(op, master);
+	platform_set_drvdata(op, host);
 
-	ms = spi_master_get_devdata(master);
-	ms->master = master;
+	ms = spi_controller_get_devdata(host);
+	ms->host = host;
 	ms->regs = regs;
 	ms->irq0 = irq_of_parse_and_map(op->dev.of_node, 0);
 	ms->irq1 = irq_of_parse_and_map(op->dev.of_node, 1);
@@ -442,7 +442,7 @@ static int mpc52xx_spi_probe(struct platform_device *op)
 	ms->ipb_freq = mpc5xxx_get_bus_frequency(&op->dev);
 	ms->gpio_cs_count = gpiod_count(&op->dev, NULL);
 	if (ms->gpio_cs_count > 0) {
-		master->num_chipselect = ms->gpio_cs_count;
+		host->num_chipselect = ms->gpio_cs_count;
 		ms->gpio_cs = kmalloc_array(ms->gpio_cs_count,
 					    sizeof(*ms->gpio_cs),
 					    GFP_KERNEL);
@@ -489,24 +489,24 @@ static int mpc52xx_spi_probe(struct platform_device *op)
 	if (!ms->irq0)
 		dev_info(&op->dev, "using polled mode\n");
 
-	dev_dbg(&op->dev, "registering spi_master struct\n");
-	rc = spi_register_master(master);
+	dev_dbg(&op->dev, "registering spi_controller struct\n");
+	rc = spi_register_controller(host);
 	if (rc)
 		goto err_register;
 
-	dev_info(&ms->master->dev, "registered MPC5200 SPI bus\n");
+	dev_info(&ms->host->dev, "registered MPC5200 SPI bus\n");
 
 	return rc;
 
  err_register:
-	dev_err(&ms->master->dev, "initialization failed\n");
+	dev_err(&ms->host->dev, "initialization failed\n");
  err_gpio:
 	while (i-- > 0)
 		gpiod_put(ms->gpio_cs[i]);
 
 	kfree(ms->gpio_cs);
  err_alloc_gpio:
-	spi_master_put(master);
+	spi_controller_put(host);
  err_alloc:
  err_init:
 	iounmap(regs);
@@ -515,8 +515,8 @@ static int mpc52xx_spi_probe(struct platform_device *op)
 
 static void mpc52xx_spi_remove(struct platform_device *op)
 {
-	struct spi_master *master = spi_master_get(platform_get_drvdata(op));
-	struct mpc52xx_spi *ms = spi_master_get_devdata(master);
+	struct spi_controller *host = spi_controller_get(platform_get_drvdata(op));
+	struct mpc52xx_spi *ms = spi_controller_get_devdata(host);
 	int i;
 
 	free_irq(ms->irq0, ms);
@@ -526,9 +526,9 @@ static void mpc52xx_spi_remove(struct platform_device *op)
 		gpiod_put(ms->gpio_cs[i]);
 
 	kfree(ms->gpio_cs);
-	spi_unregister_master(master);
+	spi_unregister_controller(host);
 	iounmap(ms->regs);
-	spi_master_put(master);
+	spi_controller_put(host);
 }
 
 static const struct of_device_id mpc52xx_spi_match[] = {
-- 
2.25.1

