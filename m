Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8D67772F3
	for <lists+linux-spi@lfdr.de>; Thu, 10 Aug 2023 10:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233216AbjHJIdL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 10 Aug 2023 04:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234202AbjHJIdK (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 10 Aug 2023 04:33:10 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD501E40
        for <linux-spi@vger.kernel.org>; Thu, 10 Aug 2023 01:33:08 -0700 (PDT)
Received: from dggpemm100004.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RM0TW6c7VztSFH;
        Thu, 10 Aug 2023 16:29:35 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm100004.china.huawei.com (7.185.36.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 10 Aug 2023 16:33:06 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 10 Aug
 2023 16:33:05 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next 03/21] spi: meson-spicc: switch to use modern name
Date:   Thu, 10 Aug 2023 16:29:46 +0800
Message-ID: <20230810083004.3988597-4-yangyingliang@huawei.com>
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
 drivers/spi/spi-meson-spicc.c | 106 +++++++++++++++++-----------------
 1 file changed, 53 insertions(+), 53 deletions(-)

diff --git a/drivers/spi/spi-meson-spicc.c b/drivers/spi/spi-meson-spicc.c
index 43d134f4b42b..d0790d2ef1b5 100644
--- a/drivers/spi/spi-meson-spicc.c
+++ b/drivers/spi/spi-meson-spicc.c
@@ -44,7 +44,7 @@
 
 #define SPICC_CONREG	0x08
 #define SPICC_ENABLE		BIT(0)
-#define SPICC_MODE_MASTER	BIT(1)
+#define SPICC_MODE_HOST		BIT(1)
 #define SPICC_XCH		BIT(2)
 #define SPICC_SMC		BIT(3)
 #define SPICC_POL		BIT(4)
@@ -106,17 +106,17 @@
 #define SPICC_SWAP_RO		BIT(14) /* RX FIFO Data Swap Read-Only */
 #define SPICC_SWAP_W1		BIT(15) /* RX FIFO Data Swap Write-Only */
 #define SPICC_DLYCTL_RO_MASK	GENMASK(20, 15) /* Delay Control Read-Only */
-#define SPICC_MO_DELAY_MASK	GENMASK(17, 16) /* Master Output Delay */
+#define SPICC_MO_DELAY_MASK	GENMASK(17, 16) /* Host Output Delay */
 #define SPICC_MO_NO_DELAY	0
 #define SPICC_MO_DELAY_1_CYCLE	1
 #define SPICC_MO_DELAY_2_CYCLE	2
 #define SPICC_MO_DELAY_3_CYCLE	3
-#define SPICC_MI_DELAY_MASK	GENMASK(19, 18) /* Master Input Delay */
+#define SPICC_MI_DELAY_MASK	GENMASK(19, 18) /* Host Input Delay */
 #define SPICC_MI_NO_DELAY	0
 #define SPICC_MI_DELAY_1_CYCLE	1
 #define SPICC_MI_DELAY_2_CYCLE	2
 #define SPICC_MI_DELAY_3_CYCLE	3
-#define SPICC_MI_CAP_DELAY_MASK	GENMASK(21, 20) /* Master Capture Delay */
+#define SPICC_MI_CAP_DELAY_MASK	GENMASK(21, 20) /* Host Capture Delay */
 #define SPICC_CAP_AHEAD_2_CYCLE	0
 #define SPICC_CAP_AHEAD_1_CYCLE	1
 #define SPICC_CAP_NO_DELAY	2
@@ -151,7 +151,7 @@ struct meson_spicc_data {
 };
 
 struct meson_spicc_device {
-	struct spi_master		*master;
+	struct spi_controller		*host;
 	struct platform_device		*pdev;
 	void __iomem			*base;
 	struct clk			*core;
@@ -399,11 +399,11 @@ static void meson_spicc_reset_fifo(struct meson_spicc_device *spicc)
 				    spicc->base + SPICC_ENH_CTL0);
 }
 
-static int meson_spicc_transfer_one(struct spi_master *master,
+static int meson_spicc_transfer_one(struct spi_controller *host,
 				    struct spi_device *spi,
 				    struct spi_transfer *xfer)
 {
-	struct meson_spicc_device *spicc = spi_master_get_devdata(master);
+	struct meson_spicc_device *spicc = spi_controller_get_devdata(host);
 	uint64_t timeout;
 
 	/* Store current transfer */
@@ -454,19 +454,19 @@ static int meson_spicc_transfer_one(struct spi_master *master,
 	return 0;
 }
 
-static int meson_spicc_prepare_message(struct spi_master *master,
+static int meson_spicc_prepare_message(struct spi_controller *host,
 				       struct spi_message *message)
 {
-	struct meson_spicc_device *spicc = spi_master_get_devdata(master);
+	struct meson_spicc_device *spicc = spi_controller_get_devdata(host);
 	struct spi_device *spi = message->spi;
 	u32 conf = readl_relaxed(spicc->base + SPICC_CONREG) & SPICC_DATARATE_MASK;
 
 	/* Store current message */
 	spicc->message = message;
 
-	/* Enable Master */
+	/* Enable Host */
 	conf |= SPICC_ENABLE;
-	conf |= SPICC_MODE_MASTER;
+	conf |= SPICC_MODE_HOST;
 
 	/* SMC = 0 */
 
@@ -519,9 +519,9 @@ static int meson_spicc_prepare_message(struct spi_master *master,
 	return 0;
 }
 
-static int meson_spicc_unprepare_transfer(struct spi_master *master)
+static int meson_spicc_unprepare_transfer(struct spi_controller *host)
 {
-	struct meson_spicc_device *spicc = spi_master_get_devdata(master);
+	struct meson_spicc_device *spicc = spi_controller_get_devdata(host);
 	u32 conf = readl_relaxed(spicc->base + SPICC_CONREG) & SPICC_DATARATE_MASK;
 
 	/* Disable all IRQs */
@@ -541,7 +541,7 @@ static int meson_spicc_unprepare_transfer(struct spi_master *master)
 static int meson_spicc_setup(struct spi_device *spi)
 {
 	if (!spi->controller_state)
-		spi->controller_state = spi_master_get_devdata(spi->master);
+		spi->controller_state = spi_controller_get_devdata(spi->controller);
 
 	return 0;
 }
@@ -585,7 +585,7 @@ static unsigned long meson_spicc_pow2_recalc_rate(struct clk_hw *hw,
 	struct clk_divider *divider = to_clk_divider(hw);
 	struct meson_spicc_device *spicc = pow2_clk_to_spicc(divider);
 
-	if (!spicc->master->cur_msg)
+	if (!spicc->host->cur_msg)
 		return 0;
 
 	return clk_divider_ops.recalc_rate(hw, parent_rate);
@@ -597,7 +597,7 @@ static int meson_spicc_pow2_determine_rate(struct clk_hw *hw,
 	struct clk_divider *divider = to_clk_divider(hw);
 	struct meson_spicc_device *spicc = pow2_clk_to_spicc(divider);
 
-	if (!spicc->master->cur_msg)
+	if (!spicc->host->cur_msg)
 		return -EINVAL;
 
 	return clk_divider_ops.determine_rate(hw, req);
@@ -609,7 +609,7 @@ static int meson_spicc_pow2_set_rate(struct clk_hw *hw, unsigned long rate,
 	struct clk_divider *divider = to_clk_divider(hw);
 	struct meson_spicc_device *spicc = pow2_clk_to_spicc(divider);
 
-	if (!spicc->master->cur_msg)
+	if (!spicc->host->cur_msg)
 		return -EINVAL;
 
 	return clk_divider_ops.set_rate(hw, rate, parent_rate);
@@ -769,23 +769,23 @@ static int meson_spicc_enh_clk_init(struct meson_spicc_device *spicc)
 
 static int meson_spicc_probe(struct platform_device *pdev)
 {
-	struct spi_master *master;
+	struct spi_controller *host;
 	struct meson_spicc_device *spicc;
 	int ret, irq;
 
-	master = spi_alloc_master(&pdev->dev, sizeof(*spicc));
-	if (!master) {
-		dev_err(&pdev->dev, "master allocation failed\n");
+	host = spi_alloc_host(&pdev->dev, sizeof(*spicc));
+	if (!host) {
+		dev_err(&pdev->dev, "host allocation failed\n");
 		return -ENOMEM;
 	}
-	spicc = spi_master_get_devdata(master);
-	spicc->master = master;
+	spicc = spi_controller_get_devdata(host);
+	spicc->host = host;
 
 	spicc->data = of_device_get_match_data(&pdev->dev);
 	if (!spicc->data) {
 		dev_err(&pdev->dev, "failed to get match data\n");
 		ret = -EINVAL;
-		goto out_master;
+		goto out_host;
 	}
 
 	spicc->pdev = pdev;
@@ -797,11 +797,11 @@ static int meson_spicc_probe(struct platform_device *pdev)
 	if (IS_ERR(spicc->base)) {
 		dev_err(&pdev->dev, "io resource mapping failed\n");
 		ret = PTR_ERR(spicc->base);
-		goto out_master;
+		goto out_host;
 	}
 
-	/* Set master mode and enable controller */
-	writel_relaxed(SPICC_ENABLE | SPICC_MODE_MASTER,
+	/* Set host mode and enable controller */
+	writel_relaxed(SPICC_ENABLE | SPICC_MODE_HOST,
 		       spicc->base + SPICC_CONREG);
 
 	/* Disable all IRQs */
@@ -810,21 +810,21 @@ static int meson_spicc_probe(struct platform_device *pdev)
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
 		ret = irq;
-		goto out_master;
+		goto out_host;
 	}
 
 	ret = devm_request_irq(&pdev->dev, irq, meson_spicc_irq,
 			       0, NULL, spicc);
 	if (ret) {
 		dev_err(&pdev->dev, "irq request failed\n");
-		goto out_master;
+		goto out_host;
 	}
 
 	spicc->core = devm_clk_get(&pdev->dev, "core");
 	if (IS_ERR(spicc->core)) {
 		dev_err(&pdev->dev, "core clock request failed\n");
 		ret = PTR_ERR(spicc->core);
-		goto out_master;
+		goto out_host;
 	}
 
 	if (spicc->data->has_pclk) {
@@ -832,14 +832,14 @@ static int meson_spicc_probe(struct platform_device *pdev)
 		if (IS_ERR(spicc->pclk)) {
 			dev_err(&pdev->dev, "pclk clock request failed\n");
 			ret = PTR_ERR(spicc->pclk);
-			goto out_master;
+			goto out_host;
 		}
 	}
 
 	ret = clk_prepare_enable(spicc->core);
 	if (ret) {
 		dev_err(&pdev->dev, "core clock enable failed\n");
-		goto out_master;
+		goto out_host;
 	}
 
 	ret = clk_prepare_enable(spicc->pclk);
@@ -856,22 +856,22 @@ static int meson_spicc_probe(struct platform_device *pdev)
 
 	device_reset_optional(&pdev->dev);
 
-	master->num_chipselect = 4;
-	master->dev.of_node = pdev->dev.of_node;
-	master->mode_bits = SPI_CPHA | SPI_CPOL | SPI_CS_HIGH;
-	master->bits_per_word_mask = SPI_BPW_MASK(32) |
-				     SPI_BPW_MASK(24) |
-				     SPI_BPW_MASK(16) |
-				     SPI_BPW_MASK(8);
-	master->flags = (SPI_CONTROLLER_MUST_RX | SPI_CONTROLLER_MUST_TX);
-	master->min_speed_hz = spicc->data->min_speed_hz;
-	master->max_speed_hz = spicc->data->max_speed_hz;
-	master->setup = meson_spicc_setup;
-	master->cleanup = meson_spicc_cleanup;
-	master->prepare_message = meson_spicc_prepare_message;
-	master->unprepare_transfer_hardware = meson_spicc_unprepare_transfer;
-	master->transfer_one = meson_spicc_transfer_one;
-	master->use_gpio_descriptors = true;
+	host->num_chipselect = 4;
+	host->dev.of_node = pdev->dev.of_node;
+	host->mode_bits = SPI_CPHA | SPI_CPOL | SPI_CS_HIGH;
+	host->bits_per_word_mask = SPI_BPW_MASK(32) |
+				   SPI_BPW_MASK(24) |
+				   SPI_BPW_MASK(16) |
+				   SPI_BPW_MASK(8);
+	host->flags = (SPI_CONTROLLER_MUST_RX | SPI_CONTROLLER_MUST_TX);
+	host->min_speed_hz = spicc->data->min_speed_hz;
+	host->max_speed_hz = spicc->data->max_speed_hz;
+	host->setup = meson_spicc_setup;
+	host->cleanup = meson_spicc_cleanup;
+	host->prepare_message = meson_spicc_prepare_message;
+	host->unprepare_transfer_hardware = meson_spicc_unprepare_transfer;
+	host->transfer_one = meson_spicc_transfer_one;
+	host->use_gpio_descriptors = true;
 
 	meson_spicc_oen_enable(spicc);
 
@@ -889,9 +889,9 @@ static int meson_spicc_probe(struct platform_device *pdev)
 		}
 	}
 
-	ret = devm_spi_register_master(&pdev->dev, master);
+	ret = devm_spi_register_controller(&pdev->dev, host);
 	if (ret) {
-		dev_err(&pdev->dev, "spi master registration failed\n");
+		dev_err(&pdev->dev, "spi host registration failed\n");
 		goto out_clk;
 	}
 
@@ -903,8 +903,8 @@ static int meson_spicc_probe(struct platform_device *pdev)
 out_core_clk:
 	clk_disable_unprepare(spicc->core);
 
-out_master:
-	spi_master_put(master);
+out_host:
+	spi_controller_put(host);
 
 	return ret;
 }
@@ -919,7 +919,7 @@ static void meson_spicc_remove(struct platform_device *pdev)
 	clk_disable_unprepare(spicc->core);
 	clk_disable_unprepare(spicc->pclk);
 
-	spi_master_put(spicc->master);
+	spi_controller_put(spicc->host);
 }
 
 static const struct meson_spicc_data meson_spicc_gx_data = {
-- 
2.25.1

