Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00A17777300
	for <lists+linux-spi@lfdr.de>; Thu, 10 Aug 2023 10:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234218AbjHJIdQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 10 Aug 2023 04:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234222AbjHJIdP (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 10 Aug 2023 04:33:15 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E629E40
        for <linux-spi@vger.kernel.org>; Thu, 10 Aug 2023 01:33:14 -0700 (PDT)
Received: from dggpemm500018.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RM0Tg4JM9zJsgT;
        Thu, 10 Aug 2023 16:29:43 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500018.china.huawei.com (7.185.36.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 10 Aug 2023 16:33:12 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 10 Aug
 2023 16:33:12 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next 20/21] spi: omap-uwire: switch to use modern name
Date:   Thu, 10 Aug 2023 16:30:03 +0800
Message-ID: <20230810083004.3988597-21-yangyingliang@huawei.com>
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
 drivers/spi/spi-omap-uwire.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/spi/spi-omap-uwire.c b/drivers/spi/spi-omap-uwire.c
index f89aa9e52c23..2dd1c1bcf4bf 100644
--- a/drivers/spi/spi-omap-uwire.c
+++ b/drivers/spi/spi-omap-uwire.c
@@ -315,7 +315,7 @@ static int uwire_setup_transfer(struct spi_device *spi, struct spi_transfer *t)
 	int			div2;
 	int			status;
 
-	uwire = spi_master_get_devdata(spi->master);
+	uwire = spi_controller_get_devdata(spi->controller);
 
 	/* mode 0..3, clock inverted separately;
 	 * standard nCS signaling;
@@ -448,25 +448,25 @@ static void uwire_off(struct uwire_spi *uwire)
 {
 	uwire_write_reg(UWIRE_SR3, 0);
 	clk_disable_unprepare(uwire->ck);
-	spi_master_put(uwire->bitbang.master);
+	spi_controller_put(uwire->bitbang.master);
 }
 
 static int uwire_probe(struct platform_device *pdev)
 {
-	struct spi_master	*master;
+	struct spi_controller	*host;
 	struct uwire_spi	*uwire;
 	int			status;
 
-	master = spi_alloc_master(&pdev->dev, sizeof(*uwire));
-	if (!master)
+	host = spi_alloc_host(&pdev->dev, sizeof(*uwire));
+	if (!host)
 		return -ENODEV;
 
-	uwire = spi_master_get_devdata(master);
+	uwire = spi_controller_get_devdata(host);
 
 	uwire_base = devm_ioremap(&pdev->dev, UWIRE_BASE_PHYS, UWIRE_IO_SIZE);
 	if (!uwire_base) {
 		dev_dbg(&pdev->dev, "can't ioremap UWIRE\n");
-		spi_master_put(master);
+		spi_controller_put(host);
 		return -ENOMEM;
 	}
 
@@ -476,7 +476,7 @@ static int uwire_probe(struct platform_device *pdev)
 	if (IS_ERR(uwire->ck)) {
 		status = PTR_ERR(uwire->ck);
 		dev_dbg(&pdev->dev, "no functional clock?\n");
-		spi_master_put(master);
+		spi_controller_put(host);
 		return status;
 	}
 	clk_prepare_enable(uwire->ck);
@@ -484,16 +484,16 @@ static int uwire_probe(struct platform_device *pdev)
 	uwire_write_reg(UWIRE_SR3, 1);
 
 	/* the spi->mode bits understood by this driver: */
-	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
-	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(1, 16);
-	master->flags = SPI_CONTROLLER_HALF_DUPLEX;
+	host->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
+	host->bits_per_word_mask = SPI_BPW_RANGE_MASK(1, 16);
+	host->flags = SPI_CONTROLLER_HALF_DUPLEX;
 
-	master->bus_num = 2;	/* "official" */
-	master->num_chipselect = 4;
-	master->setup = uwire_setup;
-	master->cleanup = uwire_cleanup;
+	host->bus_num = 2;	/* "official" */
+	host->num_chipselect = 4;
+	host->setup = uwire_setup;
+	host->cleanup = uwire_cleanup;
 
-	uwire->bitbang.master = master;
+	uwire->bitbang.master = host;
 	uwire->bitbang.chipselect = uwire_chipselect;
 	uwire->bitbang.setup_transfer = uwire_setup_transfer;
 	uwire->bitbang.txrx_bufs = uwire_txrx;
-- 
2.25.1

