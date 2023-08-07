Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8D0772481
	for <lists+linux-spi@lfdr.de>; Mon,  7 Aug 2023 14:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233285AbjHGMo2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 7 Aug 2023 08:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjHGMoV (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 7 Aug 2023 08:44:21 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0BCC170B
        for <linux-spi@vger.kernel.org>; Mon,  7 Aug 2023 05:44:13 -0700 (PDT)
Received: from dggpemm100007.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RKGBg02XjzNmnr;
        Mon,  7 Aug 2023 20:40:43 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm100007.china.huawei.com (7.185.36.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 7 Aug 2023 20:44:10 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 7 Aug
 2023 20:44:10 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next 10/20] spi: fsl-spi: switch to use modern name
Date:   Mon, 7 Aug 2023 20:40:55 +0800
Message-ID: <20230807124105.3429709-11-yangyingliang@huawei.com>
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
 drivers/spi/spi-fsl-spi.c | 76 +++++++++++++++++++--------------------
 1 file changed, 38 insertions(+), 38 deletions(-)

diff --git a/drivers/spi/spi-fsl-spi.c b/drivers/spi/spi-fsl-spi.c
index 9933842ab727..97faf984801f 100644
--- a/drivers/spi/spi-fsl-spi.c
+++ b/drivers/spi/spi-fsl-spi.c
@@ -88,7 +88,7 @@ static int fsl_spi_get_type(struct device *dev)
 
 static void fsl_spi_change_mode(struct spi_device *spi)
 {
-	struct mpc8xxx_spi *mspi = spi_master_get_devdata(spi->master);
+	struct mpc8xxx_spi *mspi = spi_controller_get_devdata(spi->controller);
 	struct spi_mpc8xxx_cs *cs = spi->controller_state;
 	struct fsl_spi_reg __iomem *reg_base = mspi->reg_base;
 	__be32 __iomem *mode = &reg_base->mode;
@@ -183,7 +183,7 @@ static int fsl_spi_setup_transfer(struct spi_device *spi,
 	u32 hz = 0;
 	struct spi_mpc8xxx_cs	*cs = spi->controller_state;
 
-	mpc8xxx_spi = spi_master_get_devdata(spi->master);
+	mpc8xxx_spi = spi_controller_get_devdata(spi->controller);
 
 	if (t) {
 		bits_per_word = t->bits_per_word;
@@ -252,7 +252,7 @@ static int fsl_spi_cpu_bufs(struct mpc8xxx_spi *mspi,
 static int fsl_spi_bufs(struct spi_device *spi, struct spi_transfer *t,
 			    bool is_dma_mapped)
 {
-	struct mpc8xxx_spi *mpc8xxx_spi = spi_master_get_devdata(spi->master);
+	struct mpc8xxx_spi *mpc8xxx_spi = spi_controller_get_devdata(spi->controller);
 	struct fsl_spi_reg __iomem *reg_base;
 	unsigned int len = t->len;
 	u8 bits_per_word;
@@ -385,7 +385,7 @@ static int fsl_spi_setup(struct spi_device *spi)
 		spi_set_ctldata(spi, cs);
 		initial_setup = true;
 	}
-	mpc8xxx_spi = spi_master_get_devdata(spi->master);
+	mpc8xxx_spi = spi_controller_get_devdata(spi->controller);
 
 	reg_base = mpc8xxx_spi->reg_base;
 
@@ -479,7 +479,7 @@ static irqreturn_t fsl_spi_irq(s32 irq, void *context_data)
 
 static void fsl_spi_grlib_cs_control(struct spi_device *spi, bool on)
 {
-	struct mpc8xxx_spi *mpc8xxx_spi = spi_master_get_devdata(spi->master);
+	struct mpc8xxx_spi *mpc8xxx_spi = spi_controller_get_devdata(spi->controller);
 	struct fsl_spi_reg __iomem *reg_base = mpc8xxx_spi->reg_base;
 	u32 slvsel;
 	u16 cs = spi_get_chipselect(spi, 0);
@@ -493,8 +493,8 @@ static void fsl_spi_grlib_cs_control(struct spi_device *spi, bool on)
 
 static void fsl_spi_grlib_probe(struct device *dev)
 {
-	struct spi_master *master = dev_get_drvdata(dev);
-	struct mpc8xxx_spi *mpc8xxx_spi = spi_master_get_devdata(master);
+	struct spi_controller *host = dev_get_drvdata(dev);
+	struct mpc8xxx_spi *mpc8xxx_spi = spi_controller_get_devdata(host);
 	struct fsl_spi_reg __iomem *reg_base = mpc8xxx_spi->reg_base;
 	int mbits;
 	u32 capabilities;
@@ -511,8 +511,8 @@ static void fsl_spi_grlib_probe(struct device *dev)
 		mpc8xxx_spi->native_chipselects = SPCAP_SSSZ(capabilities);
 		mpc8xxx_spi_write_reg(&reg_base->slvsel, 0xffffffff);
 	}
-	master->num_chipselect = mpc8xxx_spi->native_chipselects;
-	master->set_cs = fsl_spi_grlib_cs_control;
+	host->num_chipselect = mpc8xxx_spi->native_chipselects;
+	host->set_cs = fsl_spi_grlib_cs_control;
 }
 
 static void fsl_spi_cs_control(struct spi_device *spi, bool on)
@@ -526,35 +526,35 @@ static void fsl_spi_cs_control(struct spi_device *spi, bool on)
 	iowrite32be(on ? 0 : SPI_BOOT_SEL_BIT, pinfo->immr_spi_cs);
 }
 
-static struct spi_master *fsl_spi_probe(struct device *dev,
+static struct spi_controller *fsl_spi_probe(struct device *dev,
 		struct resource *mem, unsigned int irq)
 {
 	struct fsl_spi_platform_data *pdata = dev_get_platdata(dev);
-	struct spi_master *master;
+	struct spi_controller *host;
 	struct mpc8xxx_spi *mpc8xxx_spi;
 	struct fsl_spi_reg __iomem *reg_base;
 	u32 regval;
 	int ret = 0;
 
-	master = spi_alloc_master(dev, sizeof(struct mpc8xxx_spi));
-	if (master == NULL) {
+	host = spi_alloc_host(dev, sizeof(struct mpc8xxx_spi));
+	if (host == NULL) {
 		ret = -ENOMEM;
 		goto err;
 	}
 
-	dev_set_drvdata(dev, master);
+	dev_set_drvdata(dev, host);
 
 	mpc8xxx_spi_probe(dev, mem, irq);
 
-	master->setup = fsl_spi_setup;
-	master->cleanup = fsl_spi_cleanup;
-	master->prepare_message = fsl_spi_prepare_message;
-	master->transfer_one = fsl_spi_transfer_one;
-	master->unprepare_message = fsl_spi_unprepare_message;
-	master->use_gpio_descriptors = true;
-	master->set_cs = fsl_spi_cs_control;
+	host->setup = fsl_spi_setup;
+	host->cleanup = fsl_spi_cleanup;
+	host->prepare_message = fsl_spi_prepare_message;
+	host->transfer_one = fsl_spi_transfer_one;
+	host->unprepare_message = fsl_spi_unprepare_message;
+	host->use_gpio_descriptors = true;
+	host->set_cs = fsl_spi_cs_control;
 
-	mpc8xxx_spi = spi_master_get_devdata(master);
+	mpc8xxx_spi = spi_controller_get_devdata(host);
 	mpc8xxx_spi->max_bits_per_word = 32;
 	mpc8xxx_spi->type = fsl_spi_get_type(dev);
 
@@ -572,13 +572,13 @@ static struct spi_master *fsl_spi_probe(struct device *dev,
 		fsl_spi_grlib_probe(dev);
 
 	if (mpc8xxx_spi->flags & SPI_CPM_MODE)
-		master->bits_per_word_mask =
+		host->bits_per_word_mask =
 			(SPI_BPW_RANGE_MASK(4, 8) | SPI_BPW_MASK(16) | SPI_BPW_MASK(32));
 	else
-		master->bits_per_word_mask =
+		host->bits_per_word_mask =
 			(SPI_BPW_RANGE_MASK(4, 16) | SPI_BPW_MASK(32));
 
-	master->bits_per_word_mask &=
+	host->bits_per_word_mask &=
 		SPI_BPW_RANGE_MASK(1, mpc8xxx_spi->max_bits_per_word);
 
 	if (mpc8xxx_spi->flags & SPI_QE_CPU_MODE)
@@ -615,19 +615,19 @@ static struct spi_master *fsl_spi_probe(struct device *dev,
 
 	mpc8xxx_spi_write_reg(&reg_base->mode, regval);
 
-	ret = devm_spi_register_master(dev, master);
+	ret = devm_spi_register_controller(dev, host);
 	if (ret < 0)
 		goto err_probe;
 
 	dev_info(dev, "at 0x%p (irq = %d), %s mode\n", reg_base,
 		 mpc8xxx_spi->irq, mpc8xxx_spi_strmode(mpc8xxx_spi->flags));
 
-	return master;
+	return host;
 
 err_probe:
 	fsl_spi_cpm_free(mpc8xxx_spi);
 err_cpm_init:
-	spi_master_put(master);
+	spi_controller_put(host);
 err:
 	return ERR_PTR(ret);
 }
@@ -636,7 +636,7 @@ static int of_fsl_spi_probe(struct platform_device *ofdev)
 {
 	struct device *dev = &ofdev->dev;
 	struct device_node *np = ofdev->dev.of_node;
-	struct spi_master *master;
+	struct spi_controller *host;
 	struct resource mem;
 	int irq, type;
 	int ret;
@@ -689,9 +689,9 @@ static int of_fsl_spi_probe(struct platform_device *ofdev)
 		goto unmap_out;
 	}
 
-	master = fsl_spi_probe(dev, &mem, irq);
+	host = fsl_spi_probe(dev, &mem, irq);
 
-	return PTR_ERR_OR_ZERO(master);
+	return PTR_ERR_OR_ZERO(host);
 
 unmap_out:
 #if IS_ENABLED(CONFIG_FSL_SOC)
@@ -703,8 +703,8 @@ static int of_fsl_spi_probe(struct platform_device *ofdev)
 
 static void of_fsl_spi_remove(struct platform_device *ofdev)
 {
-	struct spi_master *master = platform_get_drvdata(ofdev);
-	struct mpc8xxx_spi *mpc8xxx_spi = spi_master_get_devdata(master);
+	struct spi_controller *host = platform_get_drvdata(ofdev);
+	struct mpc8xxx_spi *mpc8xxx_spi = spi_controller_get_devdata(host);
 
 	fsl_spi_cpm_free(mpc8xxx_spi);
 }
@@ -730,7 +730,7 @@ static int plat_mpc8xxx_spi_probe(struct platform_device *pdev)
 {
 	struct resource *mem;
 	int irq;
-	struct spi_master *master;
+	struct spi_controller *host;
 
 	if (!dev_get_platdata(&pdev->dev))
 		return -EINVAL;
@@ -743,14 +743,14 @@ static int plat_mpc8xxx_spi_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return irq;
 
-	master = fsl_spi_probe(&pdev->dev, mem, irq);
-	return PTR_ERR_OR_ZERO(master);
+	host = fsl_spi_probe(&pdev->dev, mem, irq);
+	return PTR_ERR_OR_ZERO(host);
 }
 
 static void plat_mpc8xxx_spi_remove(struct platform_device *pdev)
 {
-	struct spi_master *master = platform_get_drvdata(pdev);
-	struct mpc8xxx_spi *mpc8xxx_spi = spi_master_get_devdata(master);
+	struct spi_controller *host = platform_get_drvdata(pdev);
+	struct mpc8xxx_spi *mpc8xxx_spi = spi_controller_get_devdata(host);
 
 	fsl_spi_cpm_free(mpc8xxx_spi);
 }
-- 
2.25.1

