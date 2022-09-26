Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FACC5EAB3C
	for <lists+linux-spi@lfdr.de>; Mon, 26 Sep 2022 17:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236716AbiIZPhz (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 26 Sep 2022 11:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236720AbiIZPfx (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 26 Sep 2022 11:35:53 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC46E270A
        for <linux-spi@vger.kernel.org>; Mon, 26 Sep 2022 07:23:14 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MblHd4VY1zWgvn;
        Mon, 26 Sep 2022 22:19:09 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 26 Sep 2022 22:23:12 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 26 Sep
 2022 22:23:12 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <lukas@wunner.de>, <yangyingliang@huawei.com>
Subject: [PATCH -next 2/2] spi: xilinx: switch to use spi_controller_*() functions
Date:   Mon, 26 Sep 2022 22:29:33 +0800
Message-ID: <20220926142933.2299460-2-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220926142933.2299460-1-yangyingliang@huawei.com>
References: <20220926142933.2299460-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Switch to use devm_spi_alloc_controller(), spi_controller_get_devdata() and
spi_controller_put(), it's no functional changed.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/spi/spi-xilinx.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/spi/spi-xilinx.c b/drivers/spi/spi-xilinx.c
index 7377d3b81302..307872d7b5a5 100644
--- a/drivers/spi/spi-xilinx.c
+++ b/drivers/spi/spi-xilinx.c
@@ -185,7 +185,7 @@ static void xspi_init_hw(struct xilinx_spi *xspi)
 
 static void xilinx_spi_chipselect(struct spi_device *spi, int is_on)
 {
-	struct xilinx_spi *xspi = spi_master_get_devdata(spi->master);
+	struct xilinx_spi *xspi = spi_controller_get_devdata(spi->controller);
 	u16 cr;
 	u32 cs;
 
@@ -225,7 +225,7 @@ static void xilinx_spi_chipselect(struct spi_device *spi, int is_on)
 static int xilinx_spi_setup_transfer(struct spi_device *spi,
 		struct spi_transfer *t)
 {
-	struct xilinx_spi *xspi = spi_master_get_devdata(spi->master);
+	struct xilinx_spi *xspi = spi_controller_get_devdata(spi->controller);
 
 	if (spi->mode & SPI_CS_HIGH)
 		xspi->cs_inactive &= ~BIT(spi->chip_select);
@@ -237,7 +237,7 @@ static int xilinx_spi_setup_transfer(struct spi_device *spi,
 
 static int xilinx_spi_txrx_bufs(struct spi_device *spi, struct spi_transfer *t)
 {
-	struct xilinx_spi *xspi = spi_master_get_devdata(spi->master);
+	struct xilinx_spi *xspi = spi_controller_get_devdata(spi->controller);
 	int remaining_words;	/* the number of words left to transfer */
 	bool use_irq = false;
 	u16 cr = 0;
@@ -392,7 +392,7 @@ static int xilinx_spi_probe(struct platform_device *pdev)
 	struct xspi_platform_data *pdata;
 	struct resource *res;
 	int ret, num_cs = 0, bits_per_word;
-	struct spi_master *master;
+	struct spi_controller *ctlr;
 	u32 tmp;
 	u8 i;
 
@@ -421,17 +421,17 @@ static int xilinx_spi_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	master = devm_spi_alloc_master(&pdev->dev, sizeof(struct xilinx_spi));
-	if (!master)
+	ctlr = devm_spi_alloc_controller(&pdev->dev, sizeof(struct xilinx_spi));
+	if (!ctlr)
 		return -ENODEV;
 
 	/* the spi->mode bits understood by this driver: */
-	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_LSB_FIRST | SPI_LOOP |
-			    SPI_CS_HIGH;
+	ctlr->mode_bits = SPI_CPOL | SPI_CPHA | SPI_LSB_FIRST | SPI_LOOP |
+			  SPI_CS_HIGH;
 
-	xspi = spi_master_get_devdata(master);
+	xspi = spi_controller_get_devdata(ctlr);
 	xspi->cs_inactive = 0xffffffff;
-	xspi->bitbang.master = master;
+	xspi->bitbang.master = ctlr;
 	xspi->bitbang.chipselect = xilinx_spi_chipselect;
 	xspi->bitbang.setup_transfer = xilinx_spi_setup_transfer;
 	xspi->bitbang.txrx_bufs = xilinx_spi_txrx_bufs;
@@ -442,9 +442,9 @@ static int xilinx_spi_probe(struct platform_device *pdev)
 	if (IS_ERR(xspi->regs))
 		return PTR_ERR(xspi->regs);
 
-	master->bus_num = pdev->id;
-	master->num_chipselect = num_cs;
-	master->dev.of_node = pdev->dev.of_node;
+	ctlr->bus_num = pdev->id;
+	ctlr->num_chipselect = num_cs;
+	ctlr->dev.of_node = pdev->dev.of_node;
 
 	/*
 	 * Detect endianess on the IP via loop bit in CR. Detection
@@ -464,7 +464,7 @@ static int xilinx_spi_probe(struct platform_device *pdev)
 		xspi->write_fn = xspi_write32_be;
 	}
 
-	master->bits_per_word_mask = SPI_BPW_MASK(bits_per_word);
+	ctlr->bits_per_word_mask = SPI_BPW_MASK(bits_per_word);
 	xspi->bytes_per_word = bits_per_word / 8;
 	xspi->buffer_size = xilinx_spi_find_buffer_size(xspi);
 
@@ -492,17 +492,17 @@ static int xilinx_spi_probe(struct platform_device *pdev)
 
 	if (pdata) {
 		for (i = 0; i < pdata->num_devices; i++)
-			spi_new_device(master, pdata->devices + i);
+			spi_new_device(ctlr, pdata->devices + i);
 	}
 
-	platform_set_drvdata(pdev, master);
+	platform_set_drvdata(pdev, ctlr);
 	return 0;
 }
 
 static int xilinx_spi_remove(struct platform_device *pdev)
 {
-	struct spi_master *master = platform_get_drvdata(pdev);
-	struct xilinx_spi *xspi = spi_master_get_devdata(master);
+	struct spi_controller *ctlr = platform_get_drvdata(pdev);
+	struct xilinx_spi *xspi = spi_controller_get_devdata(ctlr);
 	void __iomem *regs_base = xspi->regs;
 
 	spi_bitbang_stop(&xspi->bitbang);
@@ -512,7 +512,7 @@ static int xilinx_spi_remove(struct platform_device *pdev)
 	/* Disable the global IPIF interrupt */
 	xspi->write_fn(0, regs_base + XIPIF_V123B_DGIER_OFFSET);
 
-	spi_master_put(xspi->bitbang.master);
+	spi_controller_put(xspi->bitbang.master);
 
 	return 0;
 }
-- 
2.25.1

