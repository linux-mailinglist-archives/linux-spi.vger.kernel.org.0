Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC96784F4F
	for <lists+linux-spi@lfdr.de>; Wed, 23 Aug 2023 05:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232427AbjHWDdo (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 22 Aug 2023 23:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232410AbjHWDdl (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 22 Aug 2023 23:33:41 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C56AE4D
        for <linux-spi@vger.kernel.org>; Tue, 22 Aug 2023 20:33:38 -0700 (PDT)
Received: from dggpemm500003.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RVsGH4G7dz1L9Tn;
        Wed, 23 Aug 2023 11:32:07 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500003.china.huawei.com (7.185.36.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 23 Aug 2023 11:33:36 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 23 Aug
 2023 11:33:36 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next v2 10/21] spi: mt65xx: switch to use modern name
Date:   Wed, 23 Aug 2023 11:29:52 +0800
Message-ID: <20230823033003.3407403-11-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230823033003.3407403-1-yangyingliang@huawei.com>
References: <20230823033003.3407403-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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
 drivers/spi/spi-mt65xx.c | 190 +++++++++++++++++++--------------------
 1 file changed, 95 insertions(+), 95 deletions(-)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index 0757985947dd..8d5d170d49cc 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -135,7 +135,7 @@ struct mtk_spi_compatible {
  * @pad_num:		Number of pad_sel entries
  * @pad_sel:		Groups of pins to select
  * @parent_clk:		Parent of sel_clk
- * @sel_clk:		SPI master mux clock
+ * @sel_clk:		SPI host mux clock
  * @spi_clk:		Peripheral clock
  * @spi_hclk:		AHB bus clock
  * @cur_transfer:	Currently processed SPI transfer
@@ -282,7 +282,7 @@ static void mtk_spi_reset(struct mtk_spi *mdata)
 
 static int mtk_spi_set_hw_cs_timing(struct spi_device *spi)
 {
-	struct mtk_spi *mdata = spi_master_get_devdata(spi->master);
+	struct mtk_spi *mdata = spi_controller_get_devdata(spi->controller);
 	struct spi_delay *cs_setup = &spi->cs_setup;
 	struct spi_delay *cs_hold = &spi->cs_hold;
 	struct spi_delay *cs_inactive = &spi->cs_inactive;
@@ -347,13 +347,13 @@ static int mtk_spi_set_hw_cs_timing(struct spi_device *spi)
 	return 0;
 }
 
-static int mtk_spi_hw_init(struct spi_master *master,
+static int mtk_spi_hw_init(struct spi_controller *host,
 			   struct spi_device *spi)
 {
 	u16 cpha, cpol;
 	u32 reg_val;
 	struct mtk_chip_config *chip_config = spi->controller_data;
-	struct mtk_spi *mdata = spi_master_get_devdata(master);
+	struct mtk_spi *mdata = spi_controller_get_devdata(host);
 
 	cpha = spi->mode & SPI_CPHA ? 1 : 0;
 	cpol = spi->mode & SPI_CPOL ? 1 : 0;
@@ -452,16 +452,16 @@ static int mtk_spi_hw_init(struct spi_master *master,
 	return 0;
 }
 
-static int mtk_spi_prepare_message(struct spi_master *master,
+static int mtk_spi_prepare_message(struct spi_controller *host,
 				   struct spi_message *msg)
 {
-	return mtk_spi_hw_init(master, msg->spi);
+	return mtk_spi_hw_init(host, msg->spi);
 }
 
 static void mtk_spi_set_cs(struct spi_device *spi, bool enable)
 {
 	u32 reg_val;
-	struct mtk_spi *mdata = spi_master_get_devdata(spi->master);
+	struct mtk_spi *mdata = spi_controller_get_devdata(spi->controller);
 
 	if (spi->mode & SPI_CS_HIGH)
 		enable = !enable;
@@ -478,11 +478,11 @@ static void mtk_spi_set_cs(struct spi_device *spi, bool enable)
 	}
 }
 
-static void mtk_spi_prepare_transfer(struct spi_master *master,
+static void mtk_spi_prepare_transfer(struct spi_controller *host,
 				     u32 speed_hz)
 {
 	u32 div, sck_time, reg_val;
-	struct mtk_spi *mdata = spi_master_get_devdata(master);
+	struct mtk_spi *mdata = spi_controller_get_devdata(host);
 
 	if (speed_hz < mdata->spi_clk_hz / 2)
 		div = DIV_ROUND_UP(mdata->spi_clk_hz, speed_hz);
@@ -511,10 +511,10 @@ static void mtk_spi_prepare_transfer(struct spi_master *master,
 	}
 }
 
-static void mtk_spi_setup_packet(struct spi_master *master)
+static void mtk_spi_setup_packet(struct spi_controller *host)
 {
 	u32 packet_size, packet_loop, reg_val;
-	struct mtk_spi *mdata = spi_master_get_devdata(master);
+	struct mtk_spi *mdata = spi_controller_get_devdata(host);
 
 	if (mdata->dev_comp->ipm_design)
 		packet_size = min_t(u32,
@@ -538,10 +538,10 @@ static void mtk_spi_setup_packet(struct spi_master *master)
 	writel(reg_val, mdata->base + SPI_CFG1_REG);
 }
 
-static void mtk_spi_enable_transfer(struct spi_master *master)
+static void mtk_spi_enable_transfer(struct spi_controller *host)
 {
 	u32 cmd;
-	struct mtk_spi *mdata = spi_master_get_devdata(master);
+	struct mtk_spi *mdata = spi_controller_get_devdata(host);
 
 	cmd = readl(mdata->base + SPI_CMD_REG);
 	if (mdata->state == MTK_SPI_IDLE)
@@ -566,10 +566,10 @@ static int mtk_spi_get_mult_delta(struct mtk_spi *mdata, u32 xfer_len)
 	return mult_delta;
 }
 
-static void mtk_spi_update_mdata_len(struct spi_master *master)
+static void mtk_spi_update_mdata_len(struct spi_controller *host)
 {
 	int mult_delta;
-	struct mtk_spi *mdata = spi_master_get_devdata(master);
+	struct mtk_spi *mdata = spi_controller_get_devdata(host);
 
 	if (mdata->tx_sgl_len && mdata->rx_sgl_len) {
 		if (mdata->tx_sgl_len > mdata->rx_sgl_len) {
@@ -594,10 +594,10 @@ static void mtk_spi_update_mdata_len(struct spi_master *master)
 	}
 }
 
-static void mtk_spi_setup_dma_addr(struct spi_master *master,
+static void mtk_spi_setup_dma_addr(struct spi_controller *host,
 				   struct spi_transfer *xfer)
 {
-	struct mtk_spi *mdata = spi_master_get_devdata(master);
+	struct mtk_spi *mdata = spi_controller_get_devdata(host);
 
 	if (mdata->tx_sgl) {
 		writel((u32)(xfer->tx_dma & MTK_SPI_32BITS_MASK),
@@ -620,19 +620,19 @@ static void mtk_spi_setup_dma_addr(struct spi_master *master,
 	}
 }
 
-static int mtk_spi_fifo_transfer(struct spi_master *master,
+static int mtk_spi_fifo_transfer(struct spi_controller *host,
 				 struct spi_device *spi,
 				 struct spi_transfer *xfer)
 {
 	int cnt, remainder;
 	u32 reg_val;
-	struct mtk_spi *mdata = spi_master_get_devdata(master);
+	struct mtk_spi *mdata = spi_controller_get_devdata(host);
 
 	mdata->cur_transfer = xfer;
 	mdata->xfer_len = min(MTK_SPI_MAX_FIFO_SIZE, xfer->len);
 	mdata->num_xfered = 0;
-	mtk_spi_prepare_transfer(master, xfer->speed_hz);
-	mtk_spi_setup_packet(master);
+	mtk_spi_prepare_transfer(host, xfer->speed_hz);
+	mtk_spi_setup_packet(host);
 
 	if (xfer->tx_buf) {
 		cnt = xfer->len / 4;
@@ -645,17 +645,17 @@ static int mtk_spi_fifo_transfer(struct spi_master *master,
 		}
 	}
 
-	mtk_spi_enable_transfer(master);
+	mtk_spi_enable_transfer(host);
 
 	return 1;
 }
 
-static int mtk_spi_dma_transfer(struct spi_master *master,
+static int mtk_spi_dma_transfer(struct spi_controller *host,
 				struct spi_device *spi,
 				struct spi_transfer *xfer)
 {
 	int cmd;
-	struct mtk_spi *mdata = spi_master_get_devdata(master);
+	struct mtk_spi *mdata = spi_controller_get_devdata(host);
 
 	mdata->tx_sgl = NULL;
 	mdata->rx_sgl = NULL;
@@ -664,7 +664,7 @@ static int mtk_spi_dma_transfer(struct spi_master *master,
 	mdata->cur_transfer = xfer;
 	mdata->num_xfered = 0;
 
-	mtk_spi_prepare_transfer(master, xfer->speed_hz);
+	mtk_spi_prepare_transfer(host, xfer->speed_hz);
 
 	cmd = readl(mdata->base + SPI_CMD_REG);
 	if (xfer->tx_buf)
@@ -687,19 +687,19 @@ static int mtk_spi_dma_transfer(struct spi_master *master,
 		mdata->rx_sgl_len = sg_dma_len(mdata->rx_sgl);
 	}
 
-	mtk_spi_update_mdata_len(master);
-	mtk_spi_setup_packet(master);
-	mtk_spi_setup_dma_addr(master, xfer);
-	mtk_spi_enable_transfer(master);
+	mtk_spi_update_mdata_len(host);
+	mtk_spi_setup_packet(host);
+	mtk_spi_setup_dma_addr(host, xfer);
+	mtk_spi_enable_transfer(host);
 
 	return 1;
 }
 
-static int mtk_spi_transfer_one(struct spi_master *master,
+static int mtk_spi_transfer_one(struct spi_controller *host,
 				struct spi_device *spi,
 				struct spi_transfer *xfer)
 {
-	struct mtk_spi *mdata = spi_master_get_devdata(spi->master);
+	struct mtk_spi *mdata = spi_controller_get_devdata(spi->controller);
 	u32 reg_val = 0;
 
 	/* prepare xfer direction and duplex mode */
@@ -712,13 +712,13 @@ static int mtk_spi_transfer_one(struct spi_master *master,
 		writel(reg_val, mdata->base + SPI_CFG3_IPM_REG);
 	}
 
-	if (master->can_dma(master, spi, xfer))
-		return mtk_spi_dma_transfer(master, spi, xfer);
+	if (host->can_dma(host, spi, xfer))
+		return mtk_spi_dma_transfer(host, spi, xfer);
 	else
-		return mtk_spi_fifo_transfer(master, spi, xfer);
+		return mtk_spi_fifo_transfer(host, spi, xfer);
 }
 
-static bool mtk_spi_can_dma(struct spi_master *master,
+static bool mtk_spi_can_dma(struct spi_controller *host,
 			    struct spi_device *spi,
 			    struct spi_transfer *xfer)
 {
@@ -730,7 +730,7 @@ static bool mtk_spi_can_dma(struct spi_master *master,
 
 static int mtk_spi_setup(struct spi_device *spi)
 {
-	struct mtk_spi *mdata = spi_master_get_devdata(spi->master);
+	struct mtk_spi *mdata = spi_controller_get_devdata(spi->controller);
 
 	if (!spi->controller_data)
 		spi->controller_data = (void *)&mtk_default_chip_info;
@@ -745,8 +745,8 @@ static int mtk_spi_setup(struct spi_device *spi)
 static irqreturn_t mtk_spi_interrupt(int irq, void *dev_id)
 {
 	u32 cmd, reg_val, cnt, remainder, len;
-	struct spi_master *master = dev_id;
-	struct mtk_spi *mdata = spi_master_get_devdata(master);
+	struct spi_controller *host = dev_id;
+	struct mtk_spi *mdata = spi_controller_get_devdata(host);
 	struct spi_transfer *trans = mdata->cur_transfer;
 
 	reg_val = readl(mdata->base + SPI_STATUS0_REG);
@@ -761,7 +761,7 @@ static irqreturn_t mtk_spi_interrupt(int irq, void *dev_id)
 		return IRQ_HANDLED;
 	}
 
-	if (!master->can_dma(master, NULL, trans)) {
+	if (!host->can_dma(host, NULL, trans)) {
 		if (trans->rx_buf) {
 			cnt = mdata->xfer_len / 4;
 			ioread32_rep(mdata->base + SPI_RX_DATA_REG,
@@ -779,13 +779,13 @@ static irqreturn_t mtk_spi_interrupt(int irq, void *dev_id)
 
 		mdata->num_xfered += mdata->xfer_len;
 		if (mdata->num_xfered == trans->len) {
-			spi_finalize_current_transfer(master);
+			spi_finalize_current_transfer(host);
 			return IRQ_HANDLED;
 		}
 
 		len = trans->len - mdata->num_xfered;
 		mdata->xfer_len = min(MTK_SPI_MAX_FIFO_SIZE, len);
-		mtk_spi_setup_packet(master);
+		mtk_spi_setup_packet(host);
 
 		cnt = mdata->xfer_len / 4;
 		iowrite32_rep(mdata->base + SPI_TX_DATA_REG,
@@ -800,7 +800,7 @@ static irqreturn_t mtk_spi_interrupt(int irq, void *dev_id)
 			writel(reg_val, mdata->base + SPI_TX_DATA_REG);
 		}
 
-		mtk_spi_enable_transfer(master);
+		mtk_spi_enable_transfer(host);
 
 		return IRQ_HANDLED;
 	}
@@ -832,14 +832,14 @@ static irqreturn_t mtk_spi_interrupt(int irq, void *dev_id)
 		cmd &= ~SPI_CMD_RX_DMA;
 		writel(cmd, mdata->base + SPI_CMD_REG);
 
-		spi_finalize_current_transfer(master);
+		spi_finalize_current_transfer(host);
 		return IRQ_HANDLED;
 	}
 
-	mtk_spi_update_mdata_len(master);
-	mtk_spi_setup_packet(master);
-	mtk_spi_setup_dma_addr(master, trans);
-	mtk_spi_enable_transfer(master);
+	mtk_spi_update_mdata_len(host);
+	mtk_spi_setup_packet(host);
+	mtk_spi_setup_dma_addr(host, trans);
+	mtk_spi_enable_transfer(host);
 
 	return IRQ_HANDLED;
 }
@@ -884,10 +884,10 @@ static bool mtk_spi_mem_supports_op(struct spi_mem *mem,
 	return true;
 }
 
-static void mtk_spi_mem_setup_dma_xfer(struct spi_master *master,
+static void mtk_spi_mem_setup_dma_xfer(struct spi_controller *host,
 				       const struct spi_mem_op *op)
 {
-	struct mtk_spi *mdata = spi_master_get_devdata(master);
+	struct mtk_spi *mdata = spi_controller_get_devdata(host);
 
 	writel((u32)(mdata->tx_dma & MTK_SPI_32BITS_MASK),
 	       mdata->base + SPI_TX_SRC_REG);
@@ -911,7 +911,7 @@ static void mtk_spi_mem_setup_dma_xfer(struct spi_master *master,
 static int mtk_spi_transfer_wait(struct spi_mem *mem,
 				 const struct spi_mem_op *op)
 {
-	struct mtk_spi *mdata = spi_master_get_devdata(mem->spi->master);
+	struct mtk_spi *mdata = spi_controller_get_devdata(mem->spi->controller);
 	/*
 	 * For each byte we wait for 8 cycles of the SPI clock.
 	 * Since speed is defined in Hz and we want milliseconds,
@@ -941,7 +941,7 @@ static int mtk_spi_transfer_wait(struct spi_mem *mem,
 static int mtk_spi_mem_exec_op(struct spi_mem *mem,
 			       const struct spi_mem_op *op)
 {
-	struct mtk_spi *mdata = spi_master_get_devdata(mem->spi->master);
+	struct mtk_spi *mdata = spi_controller_get_devdata(mem->spi->controller);
 	u32 reg_val, nio, tx_size;
 	char *tx_tmp_buf, *rx_tmp_buf;
 	int ret = 0;
@@ -950,8 +950,8 @@ static int mtk_spi_mem_exec_op(struct spi_mem *mem,
 	reinit_completion(&mdata->spimem_done);
 
 	mtk_spi_reset(mdata);
-	mtk_spi_hw_init(mem->spi->master, mem->spi);
-	mtk_spi_prepare_transfer(mem->spi->master, mem->spi->max_speed_hz);
+	mtk_spi_hw_init(mem->spi->controller, mem->spi);
+	mtk_spi_prepare_transfer(mem->spi->controller, mem->spi->max_speed_hz);
 
 	reg_val = readl(mdata->base + SPI_CFG3_IPM_REG);
 	/* opcode byte len */
@@ -971,7 +971,7 @@ static int mtk_spi_mem_exec_op(struct spi_mem *mem,
 	} else {
 		reg_val &= ~SPI_CFG3_IPM_NODATA_FLAG;
 		mdata->xfer_len = op->data.nbytes;
-		mtk_spi_setup_packet(mem->spi->master);
+		mtk_spi_setup_packet(mem->spi->controller);
 	}
 
 	if (op->addr.nbytes || op->dummy.nbytes) {
@@ -1069,9 +1069,9 @@ static int mtk_spi_mem_exec_op(struct spi_mem *mem,
 		reg_val |= SPI_CMD_RX_DMA;
 	writel(reg_val, mdata->base + SPI_CMD_REG);
 
-	mtk_spi_mem_setup_dma_xfer(mem->spi->master, op);
+	mtk_spi_mem_setup_dma_xfer(mem->spi->controller, op);
 
-	mtk_spi_enable_transfer(mem->spi->master);
+	mtk_spi_enable_transfer(mem->spi->controller);
 
 	/* Wait for the interrupt. */
 	ret = mtk_spi_transfer_wait(mem, op);
@@ -1115,41 +1115,41 @@ static const struct spi_controller_mem_ops mtk_spi_mem_ops = {
 static int mtk_spi_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct spi_master *master;
+	struct spi_controller *host;
 	struct mtk_spi *mdata;
 	int i, irq, ret, addr_bits;
 
-	master = devm_spi_alloc_master(dev, sizeof(*mdata));
-	if (!master)
-		return dev_err_probe(dev, -ENOMEM, "failed to alloc spi master\n");
+	host = devm_spi_alloc_host(dev, sizeof(*mdata));
+	if (!host)
+		return dev_err_probe(dev, -ENOMEM, "failed to alloc spi host\n");
 
-	master->auto_runtime_pm = true;
-	master->dev.of_node = dev->of_node;
-	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_LSB_FIRST;
+	host->auto_runtime_pm = true;
+	host->dev.of_node = dev->of_node;
+	host->mode_bits = SPI_CPOL | SPI_CPHA | SPI_LSB_FIRST;
 
-	master->set_cs = mtk_spi_set_cs;
-	master->prepare_message = mtk_spi_prepare_message;
-	master->transfer_one = mtk_spi_transfer_one;
-	master->can_dma = mtk_spi_can_dma;
-	master->setup = mtk_spi_setup;
-	master->set_cs_timing = mtk_spi_set_hw_cs_timing;
-	master->use_gpio_descriptors = true;
+	host->set_cs = mtk_spi_set_cs;
+	host->prepare_message = mtk_spi_prepare_message;
+	host->transfer_one = mtk_spi_transfer_one;
+	host->can_dma = mtk_spi_can_dma;
+	host->setup = mtk_spi_setup;
+	host->set_cs_timing = mtk_spi_set_hw_cs_timing;
+	host->use_gpio_descriptors = true;
 
-	mdata = spi_master_get_devdata(master);
+	mdata = spi_controller_get_devdata(host);
 	mdata->dev_comp = device_get_match_data(dev);
 
 	if (mdata->dev_comp->enhance_timing)
-		master->mode_bits |= SPI_CS_HIGH;
+		host->mode_bits |= SPI_CS_HIGH;
 
 	if (mdata->dev_comp->must_tx)
-		master->flags = SPI_CONTROLLER_MUST_TX;
+		host->flags = SPI_CONTROLLER_MUST_TX;
 	if (mdata->dev_comp->ipm_design)
-		master->mode_bits |= SPI_LOOP | SPI_RX_DUAL | SPI_TX_DUAL |
-				     SPI_RX_QUAD | SPI_TX_QUAD;
+		host->mode_bits |= SPI_LOOP | SPI_RX_DUAL | SPI_TX_DUAL |
+				   SPI_RX_QUAD | SPI_TX_QUAD;
 
 	if (mdata->dev_comp->ipm_design) {
 		mdata->dev = dev;
-		master->mem_ops = &mtk_spi_mem_ops;
+		host->mem_ops = &mtk_spi_mem_ops;
 		init_completion(&mdata->spimem_done);
 	}
 
@@ -1176,7 +1176,7 @@ static int mtk_spi_probe(struct platform_device *pdev)
 		}
 	}
 
-	platform_set_drvdata(pdev, master);
+	platform_set_drvdata(pdev, host);
 	mdata->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(mdata->base))
 		return PTR_ERR(mdata->base);
@@ -1235,12 +1235,12 @@ static int mtk_spi_probe(struct platform_device *pdev)
 	}
 
 	if (mdata->dev_comp->need_pad_sel) {
-		if (mdata->pad_num != master->num_chipselect)
+		if (mdata->pad_num != host->num_chipselect)
 			return dev_err_probe(dev, -EINVAL,
 				"pad_num does not match num_chipselect(%d != %d)\n",
-				mdata->pad_num, master->num_chipselect);
+				mdata->pad_num, host->num_chipselect);
 
-		if (!master->cs_gpiods && master->num_chipselect > 1)
+		if (!host->cs_gpiods && host->num_chipselect > 1)
 			return dev_err_probe(dev, -EINVAL,
 				"cs_gpios not specified and num_chipselect > 1\n");
 	}
@@ -1255,16 +1255,16 @@ static int mtk_spi_probe(struct platform_device *pdev)
 			   addr_bits, ret);
 
 	ret = devm_request_irq(dev, irq, mtk_spi_interrupt,
-			       IRQF_TRIGGER_NONE, dev_name(dev), master);
+			       IRQF_TRIGGER_NONE, dev_name(dev), host);
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to register irq\n");
 
 	pm_runtime_enable(dev);
 
-	ret = devm_spi_register_master(dev, master);
+	ret = devm_spi_register_controller(dev, host);
 	if (ret) {
 		pm_runtime_disable(dev);
-		return dev_err_probe(dev, ret, "failed to register master\n");
+		return dev_err_probe(dev, ret, "failed to register host\n");
 	}
 
 	return 0;
@@ -1272,8 +1272,8 @@ static int mtk_spi_probe(struct platform_device *pdev)
 
 static void mtk_spi_remove(struct platform_device *pdev)
 {
-	struct spi_master *master = platform_get_drvdata(pdev);
-	struct mtk_spi *mdata = spi_master_get_devdata(master);
+	struct spi_controller *host = platform_get_drvdata(pdev);
+	struct mtk_spi *mdata = spi_controller_get_devdata(host);
 	int ret;
 
 	if (mdata->use_spimem && !completion_done(&mdata->spimem_done))
@@ -1304,10 +1304,10 @@ static void mtk_spi_remove(struct platform_device *pdev)
 static int mtk_spi_suspend(struct device *dev)
 {
 	int ret;
-	struct spi_master *master = dev_get_drvdata(dev);
-	struct mtk_spi *mdata = spi_master_get_devdata(master);
+	struct spi_controller *host = dev_get_drvdata(dev);
+	struct mtk_spi *mdata = spi_controller_get_devdata(host);
 
-	ret = spi_master_suspend(master);
+	ret = spi_controller_suspend(host);
 	if (ret)
 		return ret;
 
@@ -1322,8 +1322,8 @@ static int mtk_spi_suspend(struct device *dev)
 static int mtk_spi_resume(struct device *dev)
 {
 	int ret;
-	struct spi_master *master = dev_get_drvdata(dev);
-	struct mtk_spi *mdata = spi_master_get_devdata(master);
+	struct spi_controller *host = dev_get_drvdata(dev);
+	struct mtk_spi *mdata = spi_controller_get_devdata(host);
 
 	if (!pm_runtime_suspended(dev)) {
 		ret = clk_prepare_enable(mdata->spi_clk);
@@ -1340,7 +1340,7 @@ static int mtk_spi_resume(struct device *dev)
 		}
 	}
 
-	ret = spi_master_resume(master);
+	ret = spi_controller_resume(host);
 	if (ret < 0) {
 		clk_disable_unprepare(mdata->spi_clk);
 		clk_disable_unprepare(mdata->spi_hclk);
@@ -1353,8 +1353,8 @@ static int mtk_spi_resume(struct device *dev)
 #ifdef CONFIG_PM
 static int mtk_spi_runtime_suspend(struct device *dev)
 {
-	struct spi_master *master = dev_get_drvdata(dev);
-	struct mtk_spi *mdata = spi_master_get_devdata(master);
+	struct spi_controller *host = dev_get_drvdata(dev);
+	struct mtk_spi *mdata = spi_controller_get_devdata(host);
 
 	if (mdata->dev_comp->no_need_unprepare) {
 		clk_disable(mdata->spi_clk);
@@ -1369,8 +1369,8 @@ static int mtk_spi_runtime_suspend(struct device *dev)
 
 static int mtk_spi_runtime_resume(struct device *dev)
 {
-	struct spi_master *master = dev_get_drvdata(dev);
-	struct mtk_spi *mdata = spi_master_get_devdata(master);
+	struct spi_controller *host = dev_get_drvdata(dev);
+	struct mtk_spi *mdata = spi_controller_get_devdata(host);
 	int ret;
 
 	if (mdata->dev_comp->no_need_unprepare) {
-- 
2.25.1

