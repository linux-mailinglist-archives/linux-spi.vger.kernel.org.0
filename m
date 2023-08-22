Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25DDF783783
	for <lists+linux-spi@lfdr.de>; Tue, 22 Aug 2023 03:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232083AbjHVBjA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 21 Aug 2023 21:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232082AbjHVBiu (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 21 Aug 2023 21:38:50 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 363C6187
        for <linux-spi@vger.kernel.org>; Mon, 21 Aug 2023 18:38:47 -0700 (PDT)
Received: from dggpemm100003.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RVBmG1LGgz1L9bq;
        Tue, 22 Aug 2023 09:37:18 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm100003.china.huawei.com (7.185.36.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 22 Aug 2023 09:38:45 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 22 Aug
 2023 09:38:45 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next 22/24] spi: xtensa-xtfpga: switch to use modern name
Date:   Tue, 22 Aug 2023 09:35:09 +0800
Message-ID: <20230822013511.4161475-23-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230822013511.4161475-1-yangyingliang@huawei.com>
References: <20230822013511.4161475-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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
 drivers/spi/spi-xtensa-xtfpga.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/spi/spi-xtensa-xtfpga.c b/drivers/spi/spi-xtensa-xtfpga.c
index dbd85d7a1526..3c7721894376 100644
--- a/drivers/spi/spi-xtensa-xtfpga.c
+++ b/drivers/spi/spi-xtensa-xtfpga.c
@@ -53,7 +53,7 @@ static inline void xtfpga_spi_wait_busy(struct xtfpga_spi *xspi)
 static u32 xtfpga_spi_txrx_word(struct spi_device *spi, unsigned nsecs,
 				u32 v, u8 bits, unsigned flags)
 {
-	struct xtfpga_spi *xspi = spi_master_get_devdata(spi->master);
+	struct xtfpga_spi *xspi = spi_controller_get_devdata(spi->controller);
 
 	xspi->data = (xspi->data << bits) | (v & GENMASK(bits - 1, 0));
 	xspi->data_sz += bits;
@@ -71,7 +71,7 @@ static u32 xtfpga_spi_txrx_word(struct spi_device *spi, unsigned nsecs,
 
 static void xtfpga_spi_chipselect(struct spi_device *spi, int is_on)
 {
-	struct xtfpga_spi *xspi = spi_master_get_devdata(spi->master);
+	struct xtfpga_spi *xspi = spi_controller_get_devdata(spi->controller);
 
 	WARN_ON(xspi->data_sz != 0);
 	xspi->data_sz = 0;
@@ -81,19 +81,19 @@ static int xtfpga_spi_probe(struct platform_device *pdev)
 {
 	struct xtfpga_spi *xspi;
 	int ret;
-	struct spi_master *master;
+	struct spi_controller *host;
 
-	master = devm_spi_alloc_master(&pdev->dev, sizeof(struct xtfpga_spi));
-	if (!master)
+	host = devm_spi_alloc_host(&pdev->dev, sizeof(struct xtfpga_spi));
+	if (!host)
 		return -ENOMEM;
 
-	master->flags = SPI_CONTROLLER_NO_RX;
-	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(1, 16);
-	master->bus_num = pdev->dev.id;
-	master->dev.of_node = pdev->dev.of_node;
+	host->flags = SPI_CONTROLLER_NO_RX;
+	host->bits_per_word_mask = SPI_BPW_RANGE_MASK(1, 16);
+	host->bus_num = pdev->dev.id;
+	host->dev.of_node = pdev->dev.of_node;
 
-	xspi = spi_master_get_devdata(master);
-	xspi->bitbang.master = master;
+	xspi = spi_controller_get_devdata(host);
+	xspi->bitbang.master = host;
 	xspi->bitbang.chipselect = xtfpga_spi_chipselect;
 	xspi->bitbang.txrx_word[SPI_MODE_0] = xtfpga_spi_txrx_word;
 	xspi->regs = devm_platform_ioremap_resource(pdev, 0);
@@ -113,17 +113,17 @@ static int xtfpga_spi_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	platform_set_drvdata(pdev, master);
+	platform_set_drvdata(pdev, host);
 	return 0;
 }
 
 static void xtfpga_spi_remove(struct platform_device *pdev)
 {
-	struct spi_master *master = platform_get_drvdata(pdev);
-	struct xtfpga_spi *xspi = spi_master_get_devdata(master);
+	struct spi_controller *host = platform_get_drvdata(pdev);
+	struct xtfpga_spi *xspi = spi_controller_get_devdata(host);
 
 	spi_bitbang_stop(&xspi->bitbang);
-	spi_master_put(master);
+	spi_controller_put(host);
 }
 
 MODULE_ALIAS("platform:" XTFPGA_SPI_NAME);
-- 
2.25.1

