Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2731D5BE49F
	for <lists+linux-spi@lfdr.de>; Tue, 20 Sep 2022 13:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbiITLjX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 20 Sep 2022 07:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiITLjW (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 20 Sep 2022 07:39:22 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E7FE6D9DE
        for <linux-spi@vger.kernel.org>; Tue, 20 Sep 2022 04:39:21 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MWzym0P97zpSy1;
        Tue, 20 Sep 2022 19:36:32 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 20 Sep 2022 19:39:19 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 20 Sep
 2022 19:39:19 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <michal.simek@xilinx.com>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next] spi: xilinx: Switch to use devm_spi_alloc_master()
Date:   Tue, 20 Sep 2022 19:46:15 +0800
Message-ID: <20220920114615.2681751-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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
 drivers/spi/spi-xilinx.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi-xilinx.c b/drivers/spi/spi-xilinx.c
index 523edfdf5dcd..7377d3b81302 100644
--- a/drivers/spi/spi-xilinx.c
+++ b/drivers/spi/spi-xilinx.c
@@ -421,7 +421,7 @@ static int xilinx_spi_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	master = spi_alloc_master(&pdev->dev, sizeof(struct xilinx_spi));
+	master = devm_spi_alloc_master(&pdev->dev, sizeof(struct xilinx_spi));
 	if (!master)
 		return -ENODEV;
 
@@ -439,10 +439,8 @@ static int xilinx_spi_probe(struct platform_device *pdev)
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	xspi->regs = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(xspi->regs)) {
-		ret = PTR_ERR(xspi->regs);
-		goto put_master;
-	}
+	if (IS_ERR(xspi->regs))
+		return PTR_ERR(xspi->regs);
 
 	master->bus_num = pdev->id;
 	master->num_chipselect = num_cs;
@@ -472,14 +470,13 @@ static int xilinx_spi_probe(struct platform_device *pdev)
 
 	xspi->irq = platform_get_irq(pdev, 0);
 	if (xspi->irq < 0 && xspi->irq != -ENXIO) {
-		ret = xspi->irq;
-		goto put_master;
+		return xspi->irq;
 	} else if (xspi->irq >= 0) {
 		/* Register for SPI Interrupt */
 		ret = devm_request_irq(&pdev->dev, xspi->irq, xilinx_spi_irq, 0,
 				dev_name(&pdev->dev), xspi);
 		if (ret)
-			goto put_master;
+			return ret;
 	}
 
 	/* SPI controller initializations */
@@ -488,7 +485,7 @@ static int xilinx_spi_probe(struct platform_device *pdev)
 	ret = spi_bitbang_start(&xspi->bitbang);
 	if (ret) {
 		dev_err(&pdev->dev, "spi_bitbang_start FAILED\n");
-		goto put_master;
+		return ret;
 	}
 
 	dev_info(&pdev->dev, "at %pR, irq=%d\n", res, xspi->irq);
@@ -500,11 +497,6 @@ static int xilinx_spi_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, master);
 	return 0;
-
-put_master:
-	spi_master_put(master);
-
-	return ret;
 }
 
 static int xilinx_spi_remove(struct platform_device *pdev)
-- 
2.25.1

