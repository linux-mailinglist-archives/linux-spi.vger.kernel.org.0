Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EEA15BE49D
	for <lists+linux-spi@lfdr.de>; Tue, 20 Sep 2022 13:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbiITLhx (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 20 Sep 2022 07:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbiITLhw (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 20 Sep 2022 07:37:52 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03EC66F252
        for <linux-spi@vger.kernel.org>; Tue, 20 Sep 2022 04:37:49 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MWzx0128YzpT6v;
        Tue, 20 Sep 2022 19:35:00 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 20 Sep 2022 19:37:47 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 20 Sep
 2022 19:37:47 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-xtensa@linux-xtensa.org>, <linux-spi@vger.kernel.org>
CC:     <jcmvbkbc@gmail.com>, <broonie@kernel.org>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next] spi: xtensa-xtfpga: Switch to use devm_spi_alloc_master()
Date:   Tue, 20 Sep 2022 19:44:48 +0800
Message-ID: <20220920114448.2681053-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
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

Switch to use devm_spi_alloc_master() to simpify error path.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/spi/spi-xtensa-xtfpga.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-xtensa-xtfpga.c b/drivers/spi/spi-xtensa-xtfpga.c
index fc2b5eb7d614..2fa7608f94cd 100644
--- a/drivers/spi/spi-xtensa-xtfpga.c
+++ b/drivers/spi/spi-xtensa-xtfpga.c
@@ -83,7 +83,7 @@ static int xtfpga_spi_probe(struct platform_device *pdev)
 	int ret;
 	struct spi_master *master;
 
-	master = spi_alloc_master(&pdev->dev, sizeof(struct xtfpga_spi));
+	master = devm_spi_alloc_master(&pdev->dev, sizeof(struct xtfpga_spi));
 	if (!master)
 		return -ENOMEM;
 
@@ -97,30 +97,24 @@ static int xtfpga_spi_probe(struct platform_device *pdev)
 	xspi->bitbang.chipselect = xtfpga_spi_chipselect;
 	xspi->bitbang.txrx_word[SPI_MODE_0] = xtfpga_spi_txrx_word;
 	xspi->regs = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(xspi->regs)) {
-		ret = PTR_ERR(xspi->regs);
-		goto err;
-	}
+	if (IS_ERR(xspi->regs))
+		return PTR_ERR(xspi->regs);
 
 	xtfpga_spi_write32(xspi, XTFPGA_SPI_START, 0);
 	usleep_range(1000, 2000);
 	if (xtfpga_spi_read32(xspi, XTFPGA_SPI_BUSY)) {
 		dev_err(&pdev->dev, "Device stuck in busy state\n");
-		ret = -EBUSY;
-		goto err;
+		return -EBUSY;
 	}
 
 	ret = spi_bitbang_start(&xspi->bitbang);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "spi_bitbang_start failed\n");
-		goto err;
+		return ret;
 	}
 
 	platform_set_drvdata(pdev, master);
 	return 0;
-err:
-	spi_master_put(master);
-	return ret;
 }
 
 static int xtfpga_spi_remove(struct platform_device *pdev)
-- 
2.25.1

