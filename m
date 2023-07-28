Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 426BB7668FB
	for <lists+linux-spi@lfdr.de>; Fri, 28 Jul 2023 11:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235519AbjG1JfT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 28 Jul 2023 05:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235338AbjG1JfN (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 28 Jul 2023 05:35:13 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D84A1E4F
        for <linux-spi@vger.kernel.org>; Fri, 28 Jul 2023 02:35:11 -0700 (PDT)
Received: from dggpemm500013.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RC2TP51wvztRRn;
        Fri, 28 Jul 2023 17:31:53 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500013.china.huawei.com (7.185.36.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 28 Jul 2023 17:35:09 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 28 Jul
 2023 17:35:09 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next 14/21] spi: octeon: switch to use modern name
Date:   Fri, 28 Jul 2023 17:32:14 +0800
Message-ID: <20230728093221.3312026-15-yangyingliang@huawei.com>
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
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Change legacy name master to modern name host or controller.

No functional changed.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/spi/spi-cavium-octeon.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/spi/spi-cavium-octeon.c b/drivers/spi/spi-cavium-octeon.c
index 58060be33106..4511c3b31223 100644
--- a/drivers/spi/spi-cavium-octeon.c
+++ b/drivers/spi/spi-cavium-octeon.c
@@ -19,15 +19,15 @@
 static int octeon_spi_probe(struct platform_device *pdev)
 {
 	void __iomem *reg_base;
-	struct spi_master *master;
+	struct spi_controller *host;
 	struct octeon_spi *p;
 	int err = -ENOENT;
 
-	master = spi_alloc_master(&pdev->dev, sizeof(struct octeon_spi));
-	if (!master)
+	host = spi_alloc_host(&pdev->dev, sizeof(struct octeon_spi));
+	if (!host)
 		return -ENOMEM;
-	p = spi_master_get_devdata(master);
-	platform_set_drvdata(pdev, master);
+	p = spi_controller_get_devdata(host);
+	platform_set_drvdata(pdev, host);
 
 	reg_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(reg_base)) {
@@ -43,21 +43,21 @@ static int octeon_spi_probe(struct platform_device *pdev)
 	p->regs.tx = 0x10;
 	p->regs.data = 0x80;
 
-	master->num_chipselect = 4;
-	master->mode_bits = SPI_CPHA |
+	host->num_chipselect = 4;
+	host->mode_bits = SPI_CPHA |
 			    SPI_CPOL |
 			    SPI_CS_HIGH |
 			    SPI_LSB_FIRST |
 			    SPI_3WIRE;
 
-	master->transfer_one_message = octeon_spi_transfer_one_message;
-	master->bits_per_word_mask = SPI_BPW_MASK(8);
-	master->max_speed_hz = OCTEON_SPI_MAX_CLOCK_HZ;
+	host->transfer_one_message = octeon_spi_transfer_one_message;
+	host->bits_per_word_mask = SPI_BPW_MASK(8);
+	host->max_speed_hz = OCTEON_SPI_MAX_CLOCK_HZ;
 
-	master->dev.of_node = pdev->dev.of_node;
-	err = devm_spi_register_master(&pdev->dev, master);
+	host->dev.of_node = pdev->dev.of_node;
+	err = devm_spi_register_controller(&pdev->dev, host);
 	if (err) {
-		dev_err(&pdev->dev, "register master failed: %d\n", err);
+		dev_err(&pdev->dev, "register host failed: %d\n", err);
 		goto fail;
 	}
 
@@ -65,14 +65,14 @@ static int octeon_spi_probe(struct platform_device *pdev)
 
 	return 0;
 fail:
-	spi_master_put(master);
+	spi_controller_put(host);
 	return err;
 }
 
 static void octeon_spi_remove(struct platform_device *pdev)
 {
-	struct spi_master *master = platform_get_drvdata(pdev);
-	struct octeon_spi *p = spi_master_get_devdata(master);
+	struct spi_controller *host = platform_get_drvdata(pdev);
+	struct octeon_spi *p = spi_controller_get_devdata(host);
 
 	/* Clear the CSENA* and put everything in a known state. */
 	writeq(0, p->register_base + OCTEON_SPI_CFG(p));
-- 
2.25.1

