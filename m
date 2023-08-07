Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF80877247B
	for <lists+linux-spi@lfdr.de>; Mon,  7 Aug 2023 14:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbjHGMoX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 7 Aug 2023 08:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233285AbjHGMoO (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 7 Aug 2023 08:44:14 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8C3D1701
        for <linux-spi@vger.kernel.org>; Mon,  7 Aug 2023 05:44:12 -0700 (PDT)
Received: from dggpemm100013.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RKGBg417sztS0x;
        Mon,  7 Aug 2023 20:40:43 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm100013.china.huawei.com (7.185.36.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 7 Aug 2023 20:44:09 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 7 Aug
 2023 20:44:09 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next 07/20] spi: fsl-espi: switch to use modern name
Date:   Mon, 7 Aug 2023 20:40:52 +0800
Message-ID: <20230807124105.3429709-8-yangyingliang@huawei.com>
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
 drivers/spi/spi-fsl-espi.c | 76 +++++++++++++++++++-------------------
 1 file changed, 38 insertions(+), 38 deletions(-)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index b3d2d3db5850..ea647ee94da8 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -148,7 +148,7 @@ static inline void fsl_espi_write_reg8(struct fsl_espi *espi, int offset,
 
 static int fsl_espi_check_message(struct spi_message *m)
 {
-	struct fsl_espi *espi = spi_master_get_devdata(m->spi->master);
+	struct fsl_espi *espi = spi_controller_get_devdata(m->spi->controller);
 	struct spi_transfer *t, *first;
 
 	if (m->frame_length > SPCOM_TRANLEN_MAX) {
@@ -323,7 +323,7 @@ static void fsl_espi_read_rx_fifo(struct fsl_espi *espi, u32 events)
 static void fsl_espi_setup_transfer(struct spi_device *spi,
 					struct spi_transfer *t)
 {
-	struct fsl_espi *espi = spi_master_get_devdata(spi->master);
+	struct fsl_espi *espi = spi_controller_get_devdata(spi->controller);
 	int bits_per_word = t ? t->bits_per_word : spi->bits_per_word;
 	u32 pm, hz = t ? t->speed_hz : spi->max_speed_hz;
 	struct fsl_espi_cs *cs = spi_get_ctldata(spi);
@@ -351,7 +351,7 @@ static void fsl_espi_setup_transfer(struct spi_device *spi,
 
 static int fsl_espi_bufs(struct spi_device *spi, struct spi_transfer *t)
 {
-	struct fsl_espi *espi = spi_master_get_devdata(spi->master);
+	struct fsl_espi *espi = spi_controller_get_devdata(spi->controller);
 	unsigned int rx_len = t->len;
 	u32 mask, spcom;
 	int ret;
@@ -396,7 +396,7 @@ static int fsl_espi_bufs(struct spi_device *spi, struct spi_transfer *t)
 
 static int fsl_espi_trans(struct spi_message *m, struct spi_transfer *trans)
 {
-	struct fsl_espi *espi = spi_master_get_devdata(m->spi->master);
+	struct fsl_espi *espi = spi_controller_get_devdata(m->spi->controller);
 	struct spi_device *spi = m->spi;
 	int ret;
 
@@ -432,7 +432,7 @@ static int fsl_espi_trans(struct spi_message *m, struct spi_transfer *trans)
 	return ret;
 }
 
-static int fsl_espi_do_one_msg(struct spi_master *master,
+static int fsl_espi_do_one_msg(struct spi_controller *host,
 			       struct spi_message *m)
 {
 	unsigned int rx_nbits = 0, delay_nsecs = 0;
@@ -470,7 +470,7 @@ static int fsl_espi_do_one_msg(struct spi_master *master,
 	if (m->status == -EINPROGRESS)
 		m->status = ret;
 
-	spi_finalize_current_message(master);
+	spi_finalize_current_message(host);
 
 	return ret;
 }
@@ -488,7 +488,7 @@ static int fsl_espi_setup(struct spi_device *spi)
 		spi_set_ctldata(spi, cs);
 	}
 
-	espi = spi_master_get_devdata(spi->master);
+	espi = spi_controller_get_devdata(spi->controller);
 
 	pm_runtime_get_sync(espi->dev);
 
@@ -584,8 +584,8 @@ static irqreturn_t fsl_espi_irq(s32 irq, void *context_data)
 #ifdef CONFIG_PM
 static int fsl_espi_runtime_suspend(struct device *dev)
 {
-	struct spi_master *master = dev_get_drvdata(dev);
-	struct fsl_espi *espi = spi_master_get_devdata(master);
+	struct spi_controller *host = dev_get_drvdata(dev);
+	struct fsl_espi *espi = spi_controller_get_devdata(host);
 	u32 regval;
 
 	regval = fsl_espi_read_reg(espi, ESPI_SPMODE);
@@ -597,8 +597,8 @@ static int fsl_espi_runtime_suspend(struct device *dev)
 
 static int fsl_espi_runtime_resume(struct device *dev)
 {
-	struct spi_master *master = dev_get_drvdata(dev);
-	struct fsl_espi *espi = spi_master_get_devdata(master);
+	struct spi_controller *host = dev_get_drvdata(dev);
+	struct fsl_espi *espi = spi_controller_get_devdata(host);
 	u32 regval;
 
 	regval = fsl_espi_read_reg(espi, ESPI_SPMODE);
@@ -616,8 +616,8 @@ static size_t fsl_espi_max_message_size(struct spi_device *spi)
 
 static void fsl_espi_init_regs(struct device *dev, bool initial)
 {
-	struct spi_master *master = dev_get_drvdata(dev);
-	struct fsl_espi *espi = spi_master_get_devdata(master);
+	struct spi_controller *host = dev_get_drvdata(dev);
+	struct fsl_espi *espi = spi_controller_get_devdata(host);
 	struct device_node *nc;
 	u32 csmode, cs, prop;
 	int ret;
@@ -629,10 +629,10 @@ static void fsl_espi_init_regs(struct device *dev, bool initial)
 	fsl_espi_write_reg(espi, ESPI_SPIE, 0xffffffff);
 
 	/* Init eSPI CS mode register */
-	for_each_available_child_of_node(master->dev.of_node, nc) {
+	for_each_available_child_of_node(host->dev.of_node, nc) {
 		/* get chip select */
 		ret = of_property_read_u32(nc, "reg", &cs);
-		if (ret || cs >= master->num_chipselect)
+		if (ret || cs >= host->num_chipselect)
 			continue;
 
 		csmode = CSMODE_INIT_VAL;
@@ -664,28 +664,28 @@ static void fsl_espi_init_regs(struct device *dev, bool initial)
 static int fsl_espi_probe(struct device *dev, struct resource *mem,
 			  unsigned int irq, unsigned int num_cs)
 {
-	struct spi_master *master;
+	struct spi_controller *host;
 	struct fsl_espi *espi;
 	int ret;
 
-	master = spi_alloc_master(dev, sizeof(struct fsl_espi));
-	if (!master)
+	host = spi_alloc_host(dev, sizeof(struct fsl_espi));
+	if (!host)
 		return -ENOMEM;
 
-	dev_set_drvdata(dev, master);
+	dev_set_drvdata(dev, host);
 
-	master->mode_bits = SPI_RX_DUAL | SPI_CPOL | SPI_CPHA | SPI_CS_HIGH |
-			    SPI_LSB_FIRST | SPI_LOOP;
-	master->dev.of_node = dev->of_node;
-	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 16);
-	master->setup = fsl_espi_setup;
-	master->cleanup = fsl_espi_cleanup;
-	master->transfer_one_message = fsl_espi_do_one_msg;
-	master->auto_runtime_pm = true;
-	master->max_message_size = fsl_espi_max_message_size;
-	master->num_chipselect = num_cs;
+	host->mode_bits = SPI_RX_DUAL | SPI_CPOL | SPI_CPHA | SPI_CS_HIGH |
+			  SPI_LSB_FIRST | SPI_LOOP;
+	host->dev.of_node = dev->of_node;
+	host->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 16);
+	host->setup = fsl_espi_setup;
+	host->cleanup = fsl_espi_cleanup;
+	host->transfer_one_message = fsl_espi_do_one_msg;
+	host->auto_runtime_pm = true;
+	host->max_message_size = fsl_espi_max_message_size;
+	host->num_chipselect = num_cs;
 
-	espi = spi_master_get_devdata(master);
+	espi = spi_controller_get_devdata(host);
 	spin_lock_init(&espi->lock);
 
 	espi->dev = dev;
@@ -696,8 +696,8 @@ static int fsl_espi_probe(struct device *dev, struct resource *mem,
 		goto err_probe;
 	}
 	/* determined by clock divider fields DIV16/PM in register SPMODEx */
-	master->min_speed_hz = DIV_ROUND_UP(espi->spibrg, 4 * 16 * 16);
-	master->max_speed_hz = DIV_ROUND_UP(espi->spibrg, 4);
+	host->min_speed_hz = DIV_ROUND_UP(espi->spibrg, 4 * 16 * 16);
+	host->max_speed_hz = DIV_ROUND_UP(espi->spibrg, 4);
 
 	init_completion(&espi->done);
 
@@ -720,7 +720,7 @@ static int fsl_espi_probe(struct device *dev, struct resource *mem,
 	pm_runtime_enable(dev);
 	pm_runtime_get_sync(dev);
 
-	ret = devm_spi_register_master(dev, master);
+	ret = devm_spi_register_controller(dev, host);
 	if (ret < 0)
 		goto err_pm;
 
@@ -736,7 +736,7 @@ static int fsl_espi_probe(struct device *dev, struct resource *mem,
 	pm_runtime_disable(dev);
 	pm_runtime_set_suspended(dev);
 err_probe:
-	spi_master_put(master);
+	spi_controller_put(host);
 	return ret;
 }
 
@@ -791,10 +791,10 @@ static void of_fsl_espi_remove(struct platform_device *dev)
 #ifdef CONFIG_PM_SLEEP
 static int of_fsl_espi_suspend(struct device *dev)
 {
-	struct spi_master *master = dev_get_drvdata(dev);
+	struct spi_controller *host = dev_get_drvdata(dev);
 	int ret;
 
-	ret = spi_master_suspend(master);
+	ret = spi_controller_suspend(host);
 	if (ret)
 		return ret;
 
@@ -803,7 +803,7 @@ static int of_fsl_espi_suspend(struct device *dev)
 
 static int of_fsl_espi_resume(struct device *dev)
 {
-	struct spi_master *master = dev_get_drvdata(dev);
+	struct spi_controller *host = dev_get_drvdata(dev);
 	int ret;
 
 	fsl_espi_init_regs(dev, false);
@@ -812,7 +812,7 @@ static int of_fsl_espi_resume(struct device *dev)
 	if (ret < 0)
 		return ret;
 
-	return spi_master_resume(master);
+	return spi_controller_resume(host);
 }
 #endif /* CONFIG_PM_SLEEP */
 
-- 
2.25.1

