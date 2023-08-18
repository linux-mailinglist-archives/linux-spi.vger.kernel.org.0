Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2B2C780895
	for <lists+linux-spi@lfdr.de>; Fri, 18 Aug 2023 11:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351080AbjHRJfx (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 18 Aug 2023 05:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359240AbjHRJfW (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 18 Aug 2023 05:35:22 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EDBC3A89
        for <linux-spi@vger.kernel.org>; Fri, 18 Aug 2023 02:35:19 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RRxX25glpz1GFB0;
        Fri, 18 Aug 2023 17:33:54 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 18 Aug 2023 17:35:17 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Fri, 18 Aug
 2023 17:35:17 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next v3 02/23] spi: mchp-pci1xxxx: switch to use modern name
Date:   Fri, 18 Aug 2023 17:31:33 +0800
Message-ID: <20230818093154.1183529-3-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230818093154.1183529-1-yangyingliang@huawei.com>
References: <20230818093154.1183529-1-yangyingliang@huawei.com>
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
 drivers/spi/spi-pci1xxxx.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-pci1xxxx.c b/drivers/spi/spi-pci1xxxx.c
index d23c42839da1..3638e974f5d4 100644
--- a/drivers/spi/spi-pci1xxxx.c
+++ b/drivers/spi/spi-pci1xxxx.c
@@ -65,7 +65,7 @@ struct pci1xxxx_spi_internal {
 	bool spi_xfer_in_progress;
 	int irq;
 	struct completion spi_xfer_done;
-	struct spi_master *spi_host;
+	struct spi_controller *spi_host;
 	struct pci1xxxx_spi *parent;
 	struct {
 		unsigned int dev_sel : 3;
@@ -250,7 +250,7 @@ static int pci1xxxx_spi_probe(struct pci_dev *pdev, const struct pci_device_id *
 	struct pci1xxxx_spi_internal *spi_sub_ptr;
 	struct device *dev = &pdev->dev;
 	struct pci1xxxx_spi *spi_bus;
-	struct spi_master *spi_host;
+	struct spi_controller *spi_host;
 	u32 regval;
 	int ret;
 
@@ -276,7 +276,7 @@ static int pci1xxxx_spi_probe(struct pci_dev *pdev, const struct pci_device_id *
 						      sizeof(struct pci1xxxx_spi_internal),
 						      GFP_KERNEL);
 		spi_sub_ptr = spi_bus->spi_int[iter];
-		spi_sub_ptr->spi_host = devm_spi_alloc_master(dev, sizeof(struct spi_master));
+		spi_sub_ptr->spi_host = devm_spi_alloc_host(dev, sizeof(struct spi_controller));
 		if (!spi_sub_ptr->spi_host)
 			return -ENOMEM;
 
@@ -366,8 +366,8 @@ static int pci1xxxx_spi_probe(struct pci_dev *pdev, const struct pci_device_id *
 		spi_host->max_speed_hz = PCI1XXXX_SPI_MAX_CLOCK_HZ;
 		spi_host->min_speed_hz = PCI1XXXX_SPI_MIN_CLOCK_HZ;
 		spi_host->flags = SPI_CONTROLLER_MUST_TX;
-		spi_master_set_devdata(spi_host, spi_sub_ptr);
-		ret = devm_spi_register_master(dev, spi_host);
+		spi_controller_set_devdata(spi_host, spi_sub_ptr);
+		ret = devm_spi_register_controller(dev, spi_host);
 		if (ret)
 			goto error;
 	}
@@ -415,7 +415,7 @@ static int pci1xxxx_spi_resume(struct device *dev)
 
 	for (iter = 0; iter < spi_ptr->total_hw_instances; iter++) {
 		spi_sub_ptr = spi_ptr->spi_int[iter];
-		spi_master_resume(spi_sub_ptr->spi_host);
+		spi_controller_resume(spi_sub_ptr->spi_host);
 		writel(regval, spi_ptr->reg_base +
 		       SPI_MST_EVENT_MASK_REG_OFFSET(iter));
 
@@ -441,7 +441,7 @@ static int pci1xxxx_spi_suspend(struct device *dev)
 
 		/* Store existing config before suspend */
 		store_restore_config(spi_ptr, spi_sub_ptr, iter, 1);
-		spi_master_suspend(spi_sub_ptr->spi_host);
+		spi_controller_suspend(spi_sub_ptr->spi_host);
 		writel(reg1, spi_ptr->reg_base +
 		       SPI_MST_EVENT_MASK_REG_OFFSET(iter));
 	}
-- 
2.25.1

