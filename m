Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA80777302
	for <lists+linux-spi@lfdr.de>; Thu, 10 Aug 2023 10:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234215AbjHJIdQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 10 Aug 2023 04:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234229AbjHJIdP (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 10 Aug 2023 04:33:15 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B7710CF
        for <linux-spi@vger.kernel.org>; Thu, 10 Aug 2023 01:33:13 -0700 (PDT)
Received: from dggpemm500014.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RM0XJ05Syz1L9k9;
        Thu, 10 Aug 2023 16:32:00 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500014.china.huawei.com (7.185.36.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 10 Aug 2023 16:33:12 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 10 Aug
 2023 16:33:11 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next 19/21] spi: oc-tiny: switch to use modern name
Date:   Thu, 10 Aug 2023 16:30:02 +0800
Message-ID: <20230810083004.3988597-20-yangyingliang@huawei.com>
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
 drivers/spi/spi-oc-tiny.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/spi/spi-oc-tiny.c b/drivers/spi/spi-oc-tiny.c
index 3af499838e84..cf7c111088a6 100644
--- a/drivers/spi/spi-oc-tiny.c
+++ b/drivers/spi/spi-oc-tiny.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * OpenCores tiny SPI master driver
+ * OpenCores tiny SPI host driver
  *
  * https://opencores.org/project,tiny_spi
  *
@@ -53,7 +53,7 @@ struct tiny_spi {
 
 static inline struct tiny_spi *tiny_spi_to_hw(struct spi_device *sdev)
 {
-	return spi_master_get_devdata(sdev->master);
+	return spi_controller_get_devdata(sdev->controller);
 }
 
 static unsigned int tiny_spi_baud(struct spi_device *spi, unsigned int hz)
@@ -212,24 +212,24 @@ static int tiny_spi_probe(struct platform_device *pdev)
 {
 	struct tiny_spi_platform_data *platp = dev_get_platdata(&pdev->dev);
 	struct tiny_spi *hw;
-	struct spi_master *master;
+	struct spi_controller *host;
 	int err = -ENODEV;
 
-	master = spi_alloc_master(&pdev->dev, sizeof(struct tiny_spi));
-	if (!master)
+	host = spi_alloc_host(&pdev->dev, sizeof(struct tiny_spi));
+	if (!host)
 		return err;
 
-	/* setup the master state. */
-	master->bus_num = pdev->id;
-	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
-	master->setup = tiny_spi_setup;
-	master->use_gpio_descriptors = true;
+	/* setup the host state. */
+	host->bus_num = pdev->id;
+	host->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
+	host->setup = tiny_spi_setup;
+	host->use_gpio_descriptors = true;
 
-	hw = spi_master_get_devdata(master);
+	hw = spi_controller_get_devdata(host);
 	platform_set_drvdata(pdev, hw);
 
 	/* setup the state for the bitbang driver */
-	hw->bitbang.master = master;
+	hw->bitbang.master = host;
 	hw->bitbang.setup_transfer = tiny_spi_setup_transfer;
 	hw->bitbang.txrx_bufs = tiny_spi_txrx_bufs;
 
@@ -267,17 +267,17 @@ static int tiny_spi_probe(struct platform_device *pdev)
 	return 0;
 
 exit:
-	spi_master_put(master);
+	spi_controller_put(host);
 	return err;
 }
 
 static void tiny_spi_remove(struct platform_device *pdev)
 {
 	struct tiny_spi *hw = platform_get_drvdata(pdev);
-	struct spi_master *master = hw->bitbang.master;
+	struct spi_controller *host = hw->bitbang.master;
 
 	spi_bitbang_stop(&hw->bitbang);
-	spi_master_put(master);
+	spi_controller_put(host);
 }
 
 #ifdef CONFIG_OF
-- 
2.25.1

