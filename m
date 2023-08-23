Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF6EA784F44
	for <lists+linux-spi@lfdr.de>; Wed, 23 Aug 2023 05:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232297AbjHWDdj (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 22 Aug 2023 23:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232314AbjHWDdi (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 22 Aug 2023 23:33:38 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D0CE4D
        for <linux-spi@vger.kernel.org>; Tue, 22 Aug 2023 20:33:35 -0700 (PDT)
Received: from dggpemm100002.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RVsDN6M69zLpJk;
        Wed, 23 Aug 2023 11:30:28 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm100002.china.huawei.com (7.185.36.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 23 Aug 2023 11:33:33 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 23 Aug
 2023 11:33:33 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next v2 02/21] spi: lp-8841: switch to use modern name
Date:   Wed, 23 Aug 2023 11:29:44 +0800
Message-ID: <20230823033003.3407403-3-yangyingliang@huawei.com>
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Change legacy name master/slave to modern name host/target or controller.

No functional changed.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/spi/spi-lp8841-rtc.c | 56 ++++++++++++++++++------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/spi/spi-lp8841-rtc.c b/drivers/spi/spi-lp8841-rtc.c
index b357461f1b8b..382e2a69f7a7 100644
--- a/drivers/spi/spi-lp8841-rtc.c
+++ b/drivers/spi/spi-lp8841-rtc.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * SPI master driver for ICP DAS LP-8841 RTC
+ * SPI host driver for ICP DAS LP-8841 RTC
  *
  * Copyright (C) 2016 Sergei Ianovich
  *
@@ -73,13 +73,13 @@ bitbang_txrx_be_cpha0_lsb(struct spi_lp8841_rtc *data,
 	/* clock starts at inactive polarity */
 	for (; likely(bits); bits--) {
 
-		/* setup LSB (to slave) on leading edge */
+		/* setup LSB (to target) on leading edge */
 		if ((flags & SPI_CONTROLLER_NO_TX) == 0)
 			setmosi(data, (word & 1));
 
 		usleep_range(usecs, usecs + 1);	/* T(setup) */
 
-		/* sample LSB (from slave) on trailing edge */
+		/* sample LSB (from target) on trailing edge */
 		word >>= 1;
 		if ((flags & SPI_CONTROLLER_NO_RX) == 0)
 			word |= (getmiso(data) << 31);
@@ -95,11 +95,11 @@ bitbang_txrx_be_cpha0_lsb(struct spi_lp8841_rtc *data,
 }
 
 static int
-spi_lp8841_rtc_transfer_one(struct spi_master *master,
+spi_lp8841_rtc_transfer_one(struct spi_controller *host,
 			    struct spi_device *spi,
 			    struct spi_transfer *t)
 {
-	struct spi_lp8841_rtc	*data = spi_master_get_devdata(master);
+	struct spi_lp8841_rtc	*data = spi_controller_get_devdata(host);
 	unsigned		count = t->len;
 	const u8		*tx = t->tx_buf;
 	u8			*rx = t->rx_buf;
@@ -128,7 +128,7 @@ spi_lp8841_rtc_transfer_one(struct spi_master *master,
 		ret = -EINVAL;
 	}
 
-	spi_finalize_current_transfer(master);
+	spi_finalize_current_transfer(host);
 
 	return ret;
 }
@@ -136,7 +136,7 @@ spi_lp8841_rtc_transfer_one(struct spi_master *master,
 static void
 spi_lp8841_rtc_set_cs(struct spi_device *spi, bool enable)
 {
-	struct spi_lp8841_rtc *data = spi_master_get_devdata(spi->master);
+	struct spi_lp8841_rtc *data = spi_controller_get_devdata(spi->controller);
 
 	data->state = 0;
 	writeb(data->state, data->iomem);
@@ -182,48 +182,48 @@ static int
 spi_lp8841_rtc_probe(struct platform_device *pdev)
 {
 	int				ret;
-	struct spi_master		*master;
+	struct spi_controller		*host;
 	struct spi_lp8841_rtc		*data;
 
-	master = spi_alloc_master(&pdev->dev, sizeof(*data));
-	if (!master)
+	host = spi_alloc_host(&pdev->dev, sizeof(*data));
+	if (!host)
 		return -ENOMEM;
-	platform_set_drvdata(pdev, master);
+	platform_set_drvdata(pdev, host);
 
-	master->flags = SPI_CONTROLLER_HALF_DUPLEX;
-	master->mode_bits = SPI_CS_HIGH | SPI_3WIRE | SPI_LSB_FIRST;
+	host->flags = SPI_CONTROLLER_HALF_DUPLEX;
+	host->mode_bits = SPI_CS_HIGH | SPI_3WIRE | SPI_LSB_FIRST;
 
-	master->bus_num = pdev->id;
-	master->num_chipselect = 1;
-	master->setup = spi_lp8841_rtc_setup;
-	master->set_cs = spi_lp8841_rtc_set_cs;
-	master->transfer_one = spi_lp8841_rtc_transfer_one;
-	master->bits_per_word_mask = SPI_BPW_MASK(8);
+	host->bus_num = pdev->id;
+	host->num_chipselect = 1;
+	host->setup = spi_lp8841_rtc_setup;
+	host->set_cs = spi_lp8841_rtc_set_cs;
+	host->transfer_one = spi_lp8841_rtc_transfer_one;
+	host->bits_per_word_mask = SPI_BPW_MASK(8);
 #ifdef CONFIG_OF
-	master->dev.of_node = pdev->dev.of_node;
+	host->dev.of_node = pdev->dev.of_node;
 #endif
 
-	data = spi_master_get_devdata(master);
+	data = spi_controller_get_devdata(host);
 
 	data->iomem = devm_platform_ioremap_resource(pdev, 0);
 	ret = PTR_ERR_OR_ZERO(data->iomem);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to get IO address\n");
-		goto err_put_master;
+		goto err_put_host;
 	}
 
 	/* register with the SPI framework */
-	ret = devm_spi_register_master(&pdev->dev, master);
+	ret = devm_spi_register_controller(&pdev->dev, host);
 	if (ret) {
-		dev_err(&pdev->dev, "cannot register spi master\n");
-		goto err_put_master;
+		dev_err(&pdev->dev, "cannot register spi host\n");
+		goto err_put_host;
 	}
 
 	return ret;
 
 
-err_put_master:
-	spi_master_put(master);
+err_put_host:
+	spi_controller_put(host);
 
 	return ret;
 }
@@ -239,6 +239,6 @@ static struct platform_driver spi_lp8841_rtc_driver = {
 };
 module_platform_driver(spi_lp8841_rtc_driver);
 
-MODULE_DESCRIPTION("SPI master driver for ICP DAS LP-8841 RTC");
+MODULE_DESCRIPTION("SPI host driver for ICP DAS LP-8841 RTC");
 MODULE_AUTHOR("Sergei Ianovich");
 MODULE_LICENSE("GPL");
-- 
2.25.1

