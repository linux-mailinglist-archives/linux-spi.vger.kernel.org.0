Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A20F37668FD
	for <lists+linux-spi@lfdr.de>; Fri, 28 Jul 2023 11:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235524AbjG1JfU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 28 Jul 2023 05:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235496AbjG1JfN (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 28 Jul 2023 05:35:13 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A2910F9
        for <linux-spi@vger.kernel.org>; Fri, 28 Jul 2023 02:35:12 -0700 (PDT)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RC2V91y8YzLnyh;
        Fri, 28 Jul 2023 17:32:33 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500005.china.huawei.com (7.185.36.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 28 Jul 2023 17:35:10 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 28 Jul
 2023 17:35:09 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next 15/21] spi: spi-cavium-thunderx: switch to use modern name
Date:   Fri, 28 Jul 2023 17:32:15 +0800
Message-ID: <20230728093221.3312026-16-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230728093221.3312026-1-yangyingliang@huawei.com>
References: <20230728093221.3312026-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Change legacy name master to modern name host or controller.

No functional changed.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/spi/spi-cavium-thunderx.c | 32 +++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/spi/spi-cavium-thunderx.c b/drivers/spi/spi-cavium-thunderx.c
index 535f7eb9fa69..f7c378a5f1bc 100644
--- a/drivers/spi/spi-cavium-thunderx.c
+++ b/drivers/spi/spi-cavium-thunderx.c
@@ -20,15 +20,15 @@ static int thunderx_spi_probe(struct pci_dev *pdev,
 			      const struct pci_device_id *ent)
 {
 	struct device *dev = &pdev->dev;
-	struct spi_master *master;
+	struct spi_controller *host;
 	struct octeon_spi *p;
 	int ret;
 
-	master = spi_alloc_master(dev, sizeof(struct octeon_spi));
-	if (!master)
+	host = spi_alloc_host(dev, sizeof(struct octeon_spi));
+	if (!host)
 		return -ENOMEM;
 
-	p = spi_master_get_devdata(master);
+	p = spi_controller_get_devdata(host);
 
 	ret = pcim_enable_device(pdev);
 	if (ret)
@@ -64,18 +64,18 @@ static int thunderx_spi_probe(struct pci_dev *pdev,
 		p->sys_freq = SYS_FREQ_DEFAULT;
 	dev_info(dev, "Set system clock to %u\n", p->sys_freq);
 
-	master->flags = SPI_CONTROLLER_HALF_DUPLEX;
-	master->num_chipselect = 4;
-	master->mode_bits = SPI_CPHA | SPI_CPOL | SPI_CS_HIGH |
+	host->flags = SPI_CONTROLLER_HALF_DUPLEX;
+	host->num_chipselect = 4;
+	host->mode_bits = SPI_CPHA | SPI_CPOL | SPI_CS_HIGH |
 			    SPI_LSB_FIRST | SPI_3WIRE;
-	master->transfer_one_message = octeon_spi_transfer_one_message;
-	master->bits_per_word_mask = SPI_BPW_MASK(8);
-	master->max_speed_hz = OCTEON_SPI_MAX_CLOCK_HZ;
-	master->dev.of_node = pdev->dev.of_node;
+	host->transfer_one_message = octeon_spi_transfer_one_message;
+	host->bits_per_word_mask = SPI_BPW_MASK(8);
+	host->max_speed_hz = OCTEON_SPI_MAX_CLOCK_HZ;
+	host->dev.of_node = pdev->dev.of_node;
 
-	pci_set_drvdata(pdev, master);
+	pci_set_drvdata(pdev, host);
 
-	ret = devm_spi_register_master(dev, master);
+	ret = devm_spi_register_controller(dev, host);
 	if (ret)
 		goto error;
 
@@ -84,16 +84,16 @@ static int thunderx_spi_probe(struct pci_dev *pdev,
 error:
 	clk_disable_unprepare(p->clk);
 	pci_release_regions(pdev);
-	spi_master_put(master);
+	spi_controller_put(host);
 	return ret;
 }
 
 static void thunderx_spi_remove(struct pci_dev *pdev)
 {
-	struct spi_master *master = pci_get_drvdata(pdev);
+	struct spi_controller *host = pci_get_drvdata(pdev);
 	struct octeon_spi *p;
 
-	p = spi_master_get_devdata(master);
+	p = spi_controller_get_devdata(host);
 	if (!p)
 		return;
 
-- 
2.25.1

