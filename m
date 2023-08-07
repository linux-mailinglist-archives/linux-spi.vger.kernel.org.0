Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2460677248B
	for <lists+linux-spi@lfdr.de>; Mon,  7 Aug 2023 14:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233705AbjHGMod (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 7 Aug 2023 08:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233694AbjHGMo0 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 7 Aug 2023 08:44:26 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC643173E
        for <linux-spi@vger.kernel.org>; Mon,  7 Aug 2023 05:44:16 -0700 (PDT)
Received: from dggpemm100002.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RKGFP5PlSz1KCHh;
        Mon,  7 Aug 2023 20:43:05 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm100002.china.huawei.com (7.185.36.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 7 Aug 2023 20:44:14 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 7 Aug
 2023 20:44:13 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next 19/20] spi: jcore: switch to use modern name
Date:   Mon, 7 Aug 2023 20:41:04 +0800
Message-ID: <20230807124105.3429709-20-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230807124105.3429709-1-yangyingliang@huawei.com>
References: <20230807124105.3429709-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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
 drivers/spi/spi-jcore.c | 44 ++++++++++++++++++++---------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/spi/spi-jcore.c b/drivers/spi/spi-jcore.c
index c42a3358e8c9..e37ca22e04ba 100644
--- a/drivers/spi/spi-jcore.c
+++ b/drivers/spi/spi-jcore.c
@@ -33,7 +33,7 @@
 #define JCORE_SPI_WAIT_RDY_MAX_LOOP	2000000
 
 struct jcore_spi {
-	struct spi_master *master;
+	struct spi_controller *host;
 	void __iomem *base;
 	unsigned int cs_reg;
 	unsigned int speed_reg;
@@ -59,7 +59,7 @@ static void jcore_spi_program(struct jcore_spi *hw)
 	void __iomem *ctrl_reg = hw->base + CTRL_REG;
 
 	if (jcore_spi_wait(ctrl_reg))
-		dev_err(hw->master->dev.parent,
+		dev_err(hw->host->dev.parent,
 			"timeout waiting to program ctrl reg.\n");
 
 	writel(hw->cs_reg | hw->speed_reg, ctrl_reg);
@@ -67,10 +67,10 @@ static void jcore_spi_program(struct jcore_spi *hw)
 
 static void jcore_spi_chipsel(struct spi_device *spi, bool value)
 {
-	struct jcore_spi *hw = spi_master_get_devdata(spi->master);
+	struct jcore_spi *hw = spi_controller_get_devdata(spi->controller);
 	u32 csbit = 1U << (2 * spi_get_chipselect(spi, 0));
 
-	dev_dbg(hw->master->dev.parent, "chipselect %d\n", spi_get_chipselect(spi, 0));
+	dev_dbg(hw->host->dev.parent, "chipselect %d\n", spi_get_chipselect(spi, 0));
 
 	if (value)
 		hw->cs_reg |= csbit;
@@ -90,14 +90,14 @@ static void jcore_spi_baudrate(struct jcore_spi *hw, int speed)
 	else
 		hw->speed_reg = ((hw->clock_freq / 2 / speed) - 1) << 27;
 	jcore_spi_program(hw);
-	dev_dbg(hw->master->dev.parent, "speed=%d reg=0x%x\n",
+	dev_dbg(hw->host->dev.parent, "speed=%d reg=0x%x\n",
 		speed, hw->speed_reg);
 }
 
-static int jcore_spi_txrx(struct spi_master *master, struct spi_device *spi,
+static int jcore_spi_txrx(struct spi_controller *host, struct spi_device *spi,
 			  struct spi_transfer *t)
 {
-	struct jcore_spi *hw = spi_master_get_devdata(master);
+	struct jcore_spi *hw = spi_controller_get_devdata(host);
 
 	void __iomem *ctrl_reg = hw->base + CTRL_REG;
 	void __iomem *data_reg = hw->base + DATA_REG;
@@ -130,7 +130,7 @@ static int jcore_spi_txrx(struct spi_master *master, struct spi_device *spi,
 			*rx++ = readl(data_reg);
 	}
 
-	spi_finalize_current_transfer(master);
+	spi_finalize_current_transfer(host);
 
 	if (count < len)
 		return -EREMOTEIO;
@@ -142,26 +142,26 @@ static int jcore_spi_probe(struct platform_device *pdev)
 {
 	struct device_node *node = pdev->dev.of_node;
 	struct jcore_spi *hw;
-	struct spi_master *master;
+	struct spi_controller *host;
 	struct resource *res;
 	u32 clock_freq;
 	struct clk *clk;
 	int err = -ENODEV;
 
-	master = spi_alloc_master(&pdev->dev, sizeof(struct jcore_spi));
-	if (!master)
+	host = spi_alloc_host(&pdev->dev, sizeof(struct jcore_spi));
+	if (!host)
 		return err;
 
-	/* Setup the master state. */
-	master->num_chipselect = 3;
-	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
-	master->transfer_one = jcore_spi_txrx;
-	master->set_cs = jcore_spi_chipsel;
-	master->dev.of_node = node;
-	master->bus_num = pdev->id;
+	/* Setup the host state. */
+	host->num_chipselect = 3;
+	host->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
+	host->transfer_one = jcore_spi_txrx;
+	host->set_cs = jcore_spi_chipsel;
+	host->dev.of_node = node;
+	host->bus_num = pdev->id;
 
-	hw = spi_master_get_devdata(master);
-	hw->master = master;
+	hw = spi_controller_get_devdata(host);
+	hw->host = host;
 	platform_set_drvdata(pdev, hw);
 
 	/* Find and map our resources */
@@ -200,7 +200,7 @@ static int jcore_spi_probe(struct platform_device *pdev)
 	jcore_spi_baudrate(hw, 400000);
 
 	/* Register our spi controller */
-	err = devm_spi_register_master(&pdev->dev, master);
+	err = devm_spi_register_controller(&pdev->dev, host);
 	if (err)
 		goto exit;
 
@@ -209,7 +209,7 @@ static int jcore_spi_probe(struct platform_device *pdev)
 exit_busy:
 	err = -EBUSY;
 exit:
-	spi_master_put(master);
+	spi_controller_put(host);
 	return err;
 }
 
-- 
2.25.1

