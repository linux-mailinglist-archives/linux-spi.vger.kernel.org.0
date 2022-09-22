Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8EF5E5D63
	for <lists+linux-spi@lfdr.de>; Thu, 22 Sep 2022 10:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbiIVIYo (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 22 Sep 2022 04:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiIVIYc (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 22 Sep 2022 04:24:32 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A4F41F9E7
        for <linux-spi@vger.kernel.org>; Thu, 22 Sep 2022 01:24:13 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MY7VT09vLzMpSk;
        Thu, 22 Sep 2022 16:19:29 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 16:24:11 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 22 Sep
 2022 16:24:11 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <yangyingliang@huawei.com>
Subject: [PATCH -next v2 3/6] spi: omap-uwire: Switch to use __devm_spi_alloc_controller()
Date:   Thu, 22 Sep 2022 16:31:00 +0800
Message-ID: <20220922083103.666157-4-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220922083103.666157-1-yangyingliang@huawei.com>
References: <20220922083103.666157-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

With using __devm_spi_alloc_controller(), spi_controller_put() is called in
devres_release_all() whenever the device is unbound, so the spi_master_put()
in error path can be removed. Also replace spi_master_get_devdata() with
spi_controller_get_devdata().

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/spi/spi-omap-uwire.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/spi/spi-omap-uwire.c b/drivers/spi/spi-omap-uwire.c
index 29198e6815b2..9fc8f3342ea4 100644
--- a/drivers/spi/spi-omap-uwire.c
+++ b/drivers/spi/spi-omap-uwire.c
@@ -448,25 +448,23 @@ static void uwire_off(struct uwire_spi *uwire)
 {
 	uwire_write_reg(UWIRE_SR3, 0);
 	clk_disable_unprepare(uwire->ck);
-	spi_master_put(uwire->bitbang.master);
 }
 
 static int uwire_probe(struct platform_device *pdev)
 {
-	struct spi_master	*master;
+	struct spi_controller	*ctlr;
 	struct uwire_spi	*uwire;
 	int			status;
 
-	master = spi_alloc_master(&pdev->dev, sizeof(*uwire));
-	if (!master)
+	ctlr = __devm_spi_alloc_controller(&pdev->dev, sizeof(*uwire), false);
+	if (!ctlr)
 		return -ENODEV;
 
-	uwire = spi_master_get_devdata(master);
+	uwire = spi_controller_get_devdata(ctlr);
 
 	uwire_base = devm_ioremap(&pdev->dev, UWIRE_BASE_PHYS, UWIRE_IO_SIZE);
 	if (!uwire_base) {
 		dev_dbg(&pdev->dev, "can't ioremap UWIRE\n");
-		spi_master_put(master);
 		return -ENOMEM;
 	}
 
@@ -476,7 +474,6 @@ static int uwire_probe(struct platform_device *pdev)
 	if (IS_ERR(uwire->ck)) {
 		status = PTR_ERR(uwire->ck);
 		dev_dbg(&pdev->dev, "no functional clock?\n");
-		spi_master_put(master);
 		return status;
 	}
 	clk_prepare_enable(uwire->ck);
@@ -489,16 +486,16 @@ static int uwire_probe(struct platform_device *pdev)
 	uwire_write_reg(UWIRE_SR3, 1);
 
 	/* the spi->mode bits understood by this driver: */
-	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
-	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(1, 16);
-	master->flags = SPI_MASTER_HALF_DUPLEX;
+	ctlr->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
+	ctlr->bits_per_word_mask = SPI_BPW_RANGE_MASK(1, 16);
+	ctlr->flags = SPI_MASTER_HALF_DUPLEX;
 
-	master->bus_num = 2;	/* "official" */
-	master->num_chipselect = 4;
-	master->setup = uwire_setup;
-	master->cleanup = uwire_cleanup;
+	ctlr->bus_num = 2;	/* "official" */
+	ctlr->num_chipselect = 4;
+	ctlr->setup = uwire_setup;
+	ctlr->cleanup = uwire_cleanup;
 
-	uwire->bitbang.master = master;
+	uwire->bitbang.master = ctlr;
 	uwire->bitbang.chipselect = uwire_chipselect;
 	uwire->bitbang.setup_transfer = uwire_setup_transfer;
 	uwire->bitbang.txrx_bufs = uwire_txrx;
@@ -518,6 +515,7 @@ static int uwire_remove(struct platform_device *pdev)
 
 	spi_bitbang_stop(&uwire->bitbang);
 	uwire_off(uwire);
+	spi_master_put(uwire->bitbang.master);
 	return 0;
 }
 
-- 
2.25.1

