Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8472677F025
	for <lists+linux-spi@lfdr.de>; Thu, 17 Aug 2023 07:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348077AbjHQFH5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 17 Aug 2023 01:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348075AbjHQFHe (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 17 Aug 2023 01:07:34 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE61826AB
        for <linux-spi@vger.kernel.org>; Wed, 16 Aug 2023 22:07:32 -0700 (PDT)
Received: from dggpemm100010.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RRCch24GPzVk7q;
        Thu, 17 Aug 2023 13:05:24 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm100010.china.huawei.com (7.185.36.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 17 Aug 2023 13:07:30 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Thu, 17 Aug
 2023 13:07:30 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next v2 10/23] spi: rb4xx: switch to use modern name
Date:   Thu, 17 Aug 2023 13:03:19 +0800
Message-ID: <20230817050332.1274751-11-yangyingliang@huawei.com>
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
 drivers/spi/spi-rb4xx.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/spi/spi-rb4xx.c b/drivers/spi/spi-rb4xx.c
index c817889a7797..225f75550780 100644
--- a/drivers/spi/spi-rb4xx.c
+++ b/drivers/spi/spi-rb4xx.c
@@ -80,7 +80,7 @@ static void do_spi_byte_two(struct rb4xx_spi *rbspi, u32 spi_ioc, u8 byte)
 
 static void rb4xx_set_cs(struct spi_device *spi, bool enable)
 {
-	struct rb4xx_spi *rbspi = spi_master_get_devdata(spi->master);
+	struct rb4xx_spi *rbspi = spi_controller_get_devdata(spi->controller);
 
 	/*
 	 * Setting CS is done along with bitbanging the actual values,
@@ -92,10 +92,10 @@ static void rb4xx_set_cs(struct spi_device *spi, bool enable)
 			    AR71XX_SPI_IOC_CS0 | AR71XX_SPI_IOC_CS1);
 }
 
-static int rb4xx_transfer_one(struct spi_master *master,
+static int rb4xx_transfer_one(struct spi_controller *host,
 			      struct spi_device *spi, struct spi_transfer *t)
 {
-	struct rb4xx_spi *rbspi = spi_master_get_devdata(master);
+	struct rb4xx_spi *rbspi = spi_controller_get_devdata(host);
 	int i;
 	u32 spi_ioc;
 	u8 *rx_buf;
@@ -126,14 +126,14 @@ static int rb4xx_transfer_one(struct spi_master *master,
 			continue;
 		rx_buf[i] = rb4xx_read(rbspi, AR71XX_SPI_REG_RDS);
 	}
-	spi_finalize_current_transfer(master);
+	spi_finalize_current_transfer(host);
 
 	return 0;
 }
 
 static int rb4xx_spi_probe(struct platform_device *pdev)
 {
-	struct spi_master *master;
+	struct spi_controller *host;
 	struct clk *ahb_clk;
 	struct rb4xx_spi *rbspi;
 	int err;
@@ -143,31 +143,31 @@ static int rb4xx_spi_probe(struct platform_device *pdev)
 	if (IS_ERR(spi_base))
 		return PTR_ERR(spi_base);
 
-	master = devm_spi_alloc_master(&pdev->dev, sizeof(*rbspi));
-	if (!master)
+	host = devm_spi_alloc_host(&pdev->dev, sizeof(*rbspi));
+	if (!host)
 		return -ENOMEM;
 
 	ahb_clk = devm_clk_get(&pdev->dev, "ahb");
 	if (IS_ERR(ahb_clk))
 		return PTR_ERR(ahb_clk);
 
-	master->dev.of_node = pdev->dev.of_node;
-	master->bus_num = 0;
-	master->num_chipselect = 3;
-	master->mode_bits = SPI_TX_DUAL;
-	master->bits_per_word_mask = SPI_BPW_MASK(8);
-	master->flags = SPI_CONTROLLER_MUST_TX;
-	master->transfer_one = rb4xx_transfer_one;
-	master->set_cs = rb4xx_set_cs;
+	host->dev.of_node = pdev->dev.of_node;
+	host->bus_num = 0;
+	host->num_chipselect = 3;
+	host->mode_bits = SPI_TX_DUAL;
+	host->bits_per_word_mask = SPI_BPW_MASK(8);
+	host->flags = SPI_CONTROLLER_MUST_TX;
+	host->transfer_one = rb4xx_transfer_one;
+	host->set_cs = rb4xx_set_cs;
 
-	rbspi = spi_master_get_devdata(master);
+	rbspi = spi_controller_get_devdata(host);
 	rbspi->base = spi_base;
 	rbspi->clk = ahb_clk;
 	platform_set_drvdata(pdev, rbspi);
 
-	err = devm_spi_register_master(&pdev->dev, master);
+	err = devm_spi_register_controller(&pdev->dev, host);
 	if (err) {
-		dev_err(&pdev->dev, "failed to register SPI master\n");
+		dev_err(&pdev->dev, "failed to register SPI host\n");
 		return err;
 	}
 
-- 
2.25.1

