Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03113658BDD
	for <lists+linux-spi@lfdr.de>; Thu, 29 Dec 2022 11:42:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233049AbiL2Kmb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 29 Dec 2022 05:42:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233118AbiL2KmO (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 29 Dec 2022 05:42:14 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81FE9B87A
        for <linux-spi@vger.kernel.org>; Thu, 29 Dec 2022 02:42:12 -0800 (PST)
Received: from dggpemm500007.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NjQ0N4w88z16Ltp;
        Thu, 29 Dec 2022 18:40:52 +0800 (CST)
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 29 Dec
 2022 18:41:40 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next 3/3] spi: spi-altera-platform: switch to use modern name
Date:   Thu, 29 Dec 2022 18:38:37 +0800
Message-ID: <20221229103837.4192759-4-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221229103837.4192759-1-yangyingliang@huawei.com>
References: <20221229103837.4192759-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
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
 drivers/spi/spi-altera-platform.c | 36 +++++++++++++++----------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/spi/spi-altera-platform.c b/drivers/spi/spi-altera-platform.c
index cde12c4b9cbc..72e7a0f21793 100644
--- a/drivers/spi/spi-altera-platform.c
+++ b/drivers/spi/spi-altera-platform.c
@@ -39,16 +39,16 @@ static int altera_spi_probe(struct platform_device *pdev)
 	struct altera_spi_platform_data *pdata = dev_get_platdata(&pdev->dev);
 	enum altera_spi_type type = ALTERA_SPI_TYPE_UNKNOWN;
 	struct altera_spi *hw;
-	struct spi_master *master;
+	struct spi_controller *host;
 	int err = -ENODEV;
 	u16 i;
 
-	master = spi_alloc_master(&pdev->dev, sizeof(struct altera_spi));
-	if (!master)
+	host = spi_alloc_host(&pdev->dev, sizeof(struct altera_spi));
+	if (!host)
 		return err;
 
-	/* setup the master state. */
-	master->bus_num = -1;
+	/* setup the host state. */
+	host->bus_num = -1;
 
 	if (pdata) {
 		if (pdata->num_chipselect > ALTERA_SPI_MAX_CS) {
@@ -59,18 +59,18 @@ static int altera_spi_probe(struct platform_device *pdev)
 			goto exit;
 		}
 
-		master->num_chipselect = pdata->num_chipselect;
-		master->mode_bits = pdata->mode_bits;
-		master->bits_per_word_mask = pdata->bits_per_word_mask;
+		host->num_chipselect = pdata->num_chipselect;
+		host->mode_bits = pdata->mode_bits;
+		host->bits_per_word_mask = pdata->bits_per_word_mask;
 	} else {
-		master->num_chipselect = 16;
-		master->mode_bits = SPI_CS_HIGH;
-		master->bits_per_word_mask = SPI_BPW_RANGE_MASK(1, 16);
+		host->num_chipselect = 16;
+		host->mode_bits = SPI_CS_HIGH;
+		host->bits_per_word_mask = SPI_BPW_RANGE_MASK(1, 16);
 	}
 
-	master->dev.of_node = pdev->dev.of_node;
+	host->dev.of_node = pdev->dev.of_node;
 
-	hw = spi_master_get_devdata(master);
+	hw = spi_controller_get_devdata(host);
 	hw->dev = &pdev->dev;
 
 	if (platid)
@@ -107,24 +107,24 @@ static int altera_spi_probe(struct platform_device *pdev)
 		}
 	}
 
-	altera_spi_init_host(master);
+	altera_spi_init_host(host);
 
 	/* irq is optional */
 	hw->irq = platform_get_irq(pdev, 0);
 	if (hw->irq >= 0) {
 		err = devm_request_irq(&pdev->dev, hw->irq, altera_spi_irq, 0,
-				       pdev->name, master);
+				       pdev->name, host);
 		if (err)
 			goto exit;
 	}
 
-	err = devm_spi_register_master(&pdev->dev, master);
+	err = devm_spi_register_controller(&pdev->dev, host);
 	if (err)
 		goto exit;
 
 	if (pdata) {
 		for (i = 0; i < pdata->num_devices; i++) {
-			if (!spi_new_device(master, pdata->devices + i))
+			if (!spi_new_device(host, pdata->devices + i))
 				dev_warn(&pdev->dev,
 					 "unable to create SPI device: %s\n",
 					 pdata->devices[i].modalias);
@@ -135,7 +135,7 @@ static int altera_spi_probe(struct platform_device *pdev)
 
 	return 0;
 exit:
-	spi_master_put(master);
+	spi_controller_put(host);
 	return err;
 }
 
-- 
2.25.1

