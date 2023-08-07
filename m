Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 116C7772730
	for <lists+linux-spi@lfdr.de>; Mon,  7 Aug 2023 16:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232317AbjHGOK2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 7 Aug 2023 10:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232102AbjHGOKY (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 7 Aug 2023 10:10:24 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E9FEE79
        for <linux-spi@vger.kernel.org>; Mon,  7 Aug 2023 07:10:22 -0700 (PDT)
Received: from dggpemm500008.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RKJ6p1RnCz1Z1Zk;
        Mon,  7 Aug 2023 22:07:30 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500008.china.huawei.com (7.185.36.136) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 7 Aug 2023 22:10:18 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 7 Aug
 2023 22:10:17 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next v2 20/21] spi: hisi-kunpeng: switch to use modern name
Date:   Mon, 7 Aug 2023 22:07:16 +0800
Message-ID: <20230807140717.3484180-21-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230807140717.3484180-1-yangyingliang@huawei.com>
References: <20230807140717.3484180-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Change legacy name master to modern name host.

No functional changed.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/spi/spi-hisi-kunpeng.c | 84 +++++++++++++++++-----------------
 1 file changed, 42 insertions(+), 42 deletions(-)

diff --git a/drivers/spi/spi-hisi-kunpeng.c b/drivers/spi/spi-hisi-kunpeng.c
index 2b4b3d2a22b8..35ef5e8e2ffd 100644
--- a/drivers/spi/spi-hisi-kunpeng.c
+++ b/drivers/spi/spi-hisi-kunpeng.c
@@ -164,10 +164,10 @@ static int hisi_spi_debugfs_init(struct hisi_spi *hs)
 {
 	char name[32];
 
-	struct spi_controller *master;
+	struct spi_controller *host;
 
-	master = container_of(hs->dev, struct spi_controller, dev);
-	snprintf(name, 32, "hisi_spi%d", master->bus_num);
+	host = container_of(hs->dev, struct spi_controller, dev);
+	snprintf(name, 32, "hisi_spi%d", host->bus_num);
 	hs->debugfs = debugfs_create_dir(name, NULL);
 	if (IS_ERR(hs->debugfs))
 		return -ENOMEM;
@@ -291,18 +291,18 @@ static void __hisi_calc_div_reg(struct hisi_chip_data *chip)
 	chip->div_post = (chip->clk_div / chip->div_pre) - 1;
 }
 
-static u32 hisi_calc_effective_speed(struct spi_controller *master,
+static u32 hisi_calc_effective_speed(struct spi_controller *host,
 			struct hisi_chip_data *chip, u32 speed_hz)
 {
 	u32 effective_speed;
 
 	/* Note clock divider doesn't support odd numbers */
-	chip->clk_div = DIV_ROUND_UP(master->max_speed_hz, speed_hz) + 1;
+	chip->clk_div = DIV_ROUND_UP(host->max_speed_hz, speed_hz) + 1;
 	chip->clk_div &= 0xfffe;
 	if (chip->clk_div > CLK_DIV_MAX)
 		chip->clk_div = CLK_DIV_MAX;
 
-	effective_speed = master->max_speed_hz / chip->clk_div;
+	effective_speed = host->max_speed_hz / chip->clk_div;
 	if (chip->speed_hz != effective_speed) {
 		__hisi_calc_div_reg(chip);
 		chip->speed_hz = effective_speed;
@@ -336,20 +336,20 @@ static void hisi_spi_hw_init(struct hisi_spi *hs)
 
 static irqreturn_t hisi_spi_irq(int irq, void *dev_id)
 {
-	struct spi_controller *master = dev_id;
-	struct hisi_spi *hs = spi_controller_get_devdata(master);
+	struct spi_controller *host = dev_id;
+	struct hisi_spi *hs = spi_controller_get_devdata(host);
 	u32 irq_status = readl(hs->regs + HISI_SPI_ISR) & ISR_MASK;
 
 	if (!irq_status)
 		return IRQ_NONE;
 
-	if (!master->cur_msg)
+	if (!host->cur_msg)
 		return IRQ_HANDLED;
 
 	/* Error handling */
 	if (irq_status & ISR_RXOF) {
 		dev_err(hs->dev, "interrupt_transfer: fifo overflow\n");
-		master->cur_msg->status = -EIO;
+		host->cur_msg->status = -EIO;
 		goto finalize_transfer;
 	}
 
@@ -369,20 +369,20 @@ static irqreturn_t hisi_spi_irq(int irq, void *dev_id)
 
 finalize_transfer:
 	hisi_spi_disable(hs);
-	spi_finalize_current_transfer(master);
+	spi_finalize_current_transfer(host);
 	return IRQ_HANDLED;
 }
 
-static int hisi_spi_transfer_one(struct spi_controller *master,
+static int hisi_spi_transfer_one(struct spi_controller *host,
 		struct spi_device *spi, struct spi_transfer *transfer)
 {
-	struct hisi_spi *hs = spi_controller_get_devdata(master);
+	struct hisi_spi *hs = spi_controller_get_devdata(host);
 	struct hisi_chip_data *chip = spi_get_ctldata(spi);
 	u32 cr = chip->cr;
 
 	/* Update per transfer options for speed and bpw */
 	transfer->effective_speed_hz =
-		hisi_calc_effective_speed(master, chip, transfer->speed_hz);
+		hisi_calc_effective_speed(host, chip, transfer->speed_hz);
 	cr |= FIELD_PREP(CR_DIV_PRE_MASK, chip->div_pre);
 	cr |= FIELD_PREP(CR_DIV_POST_MASK, chip->div_post);
 	cr |= FIELD_PREP(CR_BPW_MASK, transfer->bits_per_word - 1);
@@ -409,10 +409,10 @@ static int hisi_spi_transfer_one(struct spi_controller *master,
 	return 1;
 }
 
-static void hisi_spi_handle_err(struct spi_controller *master,
+static void hisi_spi_handle_err(struct spi_controller *host,
 		struct spi_message *msg)
 {
-	struct hisi_spi *hs = spi_controller_get_devdata(master);
+	struct hisi_spi *hs = spi_controller_get_devdata(host);
 
 	hisi_spi_disable(hs);
 
@@ -452,7 +452,7 @@ static void hisi_spi_cleanup(struct spi_device *spi)
 static int hisi_spi_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct spi_controller *master;
+	struct spi_controller *host;
 	struct hisi_spi *hs;
 	int ret, irq;
 
@@ -460,13 +460,13 @@ static int hisi_spi_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return irq;
 
-	master = devm_spi_alloc_master(dev, sizeof(*hs));
-	if (!master)
+	host = devm_spi_alloc_host(dev, sizeof(*hs));
+	if (!host)
 		return -ENOMEM;
 
-	platform_set_drvdata(pdev, master);
+	platform_set_drvdata(pdev, host);
 
-	hs = spi_controller_get_devdata(master);
+	hs = spi_controller_get_devdata(host);
 	hs->dev = dev;
 	hs->irq = irq;
 
@@ -474,9 +474,9 @@ static int hisi_spi_probe(struct platform_device *pdev)
 	if (IS_ERR(hs->regs))
 		return PTR_ERR(hs->regs);
 
-	/* Specify maximum SPI clocking speed (master only) by firmware */
+	/* Specify maximum SPI clocking speed (host only) by firmware */
 	ret = device_property_read_u32(dev, "spi-max-frequency",
-					&master->max_speed_hz);
+					&host->max_speed_hz);
 	if (ret) {
 		dev_err(dev, "failed to get max SPI clocking speed, ret=%d\n",
 			ret);
@@ -484,32 +484,32 @@ static int hisi_spi_probe(struct platform_device *pdev)
 	}
 
 	ret = device_property_read_u16(dev, "num-cs",
-					&master->num_chipselect);
+					&host->num_chipselect);
 	if (ret)
-		master->num_chipselect = DEFAULT_NUM_CS;
-
-	master->use_gpio_descriptors = true;
-	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LOOP;
-	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 32);
-	master->bus_num = pdev->id;
-	master->setup = hisi_spi_setup;
-	master->cleanup = hisi_spi_cleanup;
-	master->transfer_one = hisi_spi_transfer_one;
-	master->handle_err = hisi_spi_handle_err;
-	master->dev.fwnode = dev->fwnode;
+		host->num_chipselect = DEFAULT_NUM_CS;
+
+	host->use_gpio_descriptors = true;
+	host->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LOOP;
+	host->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 32);
+	host->bus_num = pdev->id;
+	host->setup = hisi_spi_setup;
+	host->cleanup = hisi_spi_cleanup;
+	host->transfer_one = hisi_spi_transfer_one;
+	host->handle_err = hisi_spi_handle_err;
+	host->dev.fwnode = dev->fwnode;
 
 	hisi_spi_hw_init(hs);
 
 	ret = devm_request_irq(dev, hs->irq, hisi_spi_irq, 0, dev_name(dev),
-			master);
+			       host);
 	if (ret < 0) {
 		dev_err(dev, "failed to get IRQ=%d, ret=%d\n", hs->irq, ret);
 		return ret;
 	}
 
-	ret = spi_register_controller(master);
+	ret = spi_register_controller(host);
 	if (ret) {
-		dev_err(dev, "failed to register spi master, ret=%d\n", ret);
+		dev_err(dev, "failed to register spi host, ret=%d\n", ret);
 		return ret;
 	}
 
@@ -518,18 +518,18 @@ static int hisi_spi_probe(struct platform_device *pdev)
 
 	dev_info(dev, "hw version:0x%x max-freq:%u kHz\n",
 		readl(hs->regs + HISI_SPI_VERSION),
-		master->max_speed_hz / 1000);
+		host->max_speed_hz / 1000);
 
 	return 0;
 }
 
 static void hisi_spi_remove(struct platform_device *pdev)
 {
-	struct spi_controller *master = platform_get_drvdata(pdev);
-	struct hisi_spi *hs = spi_controller_get_devdata(master);
+	struct spi_controller *host = platform_get_drvdata(pdev);
+	struct hisi_spi *hs = spi_controller_get_devdata(host);
 
 	debugfs_remove_recursive(hs->debugfs);
-	spi_unregister_controller(master);
+	spi_unregister_controller(host);
 }
 
 static const struct acpi_device_id hisi_spi_acpi_match[] = {
-- 
2.25.1

