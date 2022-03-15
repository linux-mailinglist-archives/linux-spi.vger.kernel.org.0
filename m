Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC38B4D92F3
	for <lists+linux-spi@lfdr.de>; Tue, 15 Mar 2022 04:24:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344617AbiCODZm (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 14 Mar 2022 23:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344618AbiCODZk (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 14 Mar 2022 23:25:40 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB6D43587F;
        Mon, 14 Mar 2022 20:24:27 -0700 (PDT)
X-UUID: ccad68b4b2d044b89efa990e6418a922-20220315
X-UUID: ccad68b4b2d044b89efa990e6418a922-20220315
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <leilk.liu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 604504766; Tue, 15 Mar 2022 11:24:18 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 15 Mar 2022 11:24:17 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 15 Mar 2022 11:24:16 +0800
From:   Leilk Liu <leilk.liu@mediatek.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-spi@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        Leilk Liu <leilk.liu@mediatek.com>
Subject: [PATCH V4 4/6] spi: mediatek: add spi memory support for ipm design
Date:   Tue, 15 Mar 2022 11:24:09 +0800
Message-ID: <20220315032411.2826-5-leilk.liu@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220315032411.2826-1-leilk.liu@mediatek.com>
References: <20220315032411.2826-1-leilk.liu@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

this patch add the support of spi-mem for ipm design.

Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
---
 drivers/spi/spi-mt65xx.c | 349 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 348 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index 1a0b3208dfca..8958c3fa4fea 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -17,6 +17,7 @@
 #include <linux/platform_data/spi-mt65xx.h>
 #include <linux/pm_runtime.h>
 #include <linux/spi/spi.h>
+#include <linux/spi/spi-mem.h>
 #include <linux/dma-mapping.h>
 
 #define SPI_CFG0_REG                      0x0000
@@ -78,8 +79,21 @@
 #define SPI_CMD_IPM_GET_TICKDLY_OFFSET    22
 
 #define SPI_CMD_IPM_GET_TICKDLY_MASK	GENMASK(24, 22)
+
+#define PIN_MODE_CFG(x)	((x) / 2)
+
+#define SPI_CFG3_IPM_PIN_MODE_OFFSET		0
 #define SPI_CFG3_IPM_HALF_DUPLEX_DIR		BIT(2)
 #define SPI_CFG3_IPM_HALF_DUPLEX_EN		BIT(3)
+#define SPI_CFG3_IPM_XMODE_EN			BIT(4)
+#define SPI_CFG3_IPM_NODATA_FLAG		BIT(5)
+#define SPI_CFG3_IPM_CMD_BYTELEN_OFFSET		8
+#define SPI_CFG3_IPM_ADDR_BYTELEN_OFFSET	12
+
+#define SPI_CFG3_IPM_CMD_PIN_MODE_MASK		GENMASK(1, 0)
+#define SPI_CFG3_IPM_CMD_BYTELEN_MASK		GENMASK(11, 8)
+#define SPI_CFG3_IPM_ADDR_BYTELEN_MASK		GENMASK(15, 12)
+
 #define MT8173_SPI_MAX_PAD_SEL 3
 
 #define MTK_SPI_PAUSE_INT_STATUS 0x2
@@ -90,6 +104,8 @@
 #define MTK_SPI_MAX_FIFO_SIZE 32U
 #define MTK_SPI_PACKET_SIZE 1024
 #define MTK_SPI_IPM_PACKET_SIZE SZ_64K
+#define MTK_SPI_IPM_PACKET_LOOP SZ_256
+
 #define MTK_SPI_32BITS_MASK  (0xffffffff)
 
 #define DMA_ADDR_EXT_BITS (36)
@@ -107,7 +123,6 @@ struct mtk_spi_compatible {
 	bool no_need_unprepare;
 	/* IPM design adjust and extend register to support more features */
 	bool ipm_design;
-
 };
 
 struct mtk_spi {
@@ -123,6 +138,11 @@ struct mtk_spi {
 	u32 tx_sgl_len, rx_sgl_len;
 	const struct mtk_spi_compatible *dev_comp;
 	u32 spi_clk_hz;
+	struct completion spimem_done;
+	bool use_spimem;
+	struct device *dev;
+	dma_addr_t tx_dma;
+	dma_addr_t rx_dma;
 };
 
 static const struct mtk_spi_compatible mtk_common_compat;
@@ -704,6 +724,12 @@ static irqreturn_t mtk_spi_interrupt(int irq, void *dev_id)
 	else
 		mdata->state = MTK_SPI_IDLE;
 
+	/* SPI-MEM ops */
+	if (mdata->use_spimem) {
+		complete(&mdata->spimem_done);
+		return IRQ_HANDLED;
+	}
+
 	if (!master->can_dma(master, NULL, trans)) {
 		if (trans->rx_buf) {
 			cnt = mdata->xfer_len / 4;
@@ -787,6 +813,320 @@ static irqreturn_t mtk_spi_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static int mtk_spi_mem_adjust_op_size(struct spi_mem *mem,
+				      struct spi_mem_op *op)
+{
+	int opcode_len;
+
+	if (op->data.dir != SPI_MEM_NO_DATA) {
+		opcode_len = 1 + op->addr.nbytes + op->dummy.nbytes;
+		if (opcode_len + op->data.nbytes > MTK_SPI_IPM_PACKET_SIZE) {
+			op->data.nbytes = MTK_SPI_IPM_PACKET_SIZE - opcode_len;
+			/* force data buffer dma-aligned. */
+			op->data.nbytes -= op->data.nbytes % 4;
+		}
+	}
+
+	return 0;
+}
+
+static bool mtk_spi_mem_supports_op(struct spi_mem *mem,
+				    const struct spi_mem_op *op)
+{
+	if (op->data.buswidth > 4 || op->addr.buswidth > 4 ||
+	    op->dummy.buswidth > 4 || op->cmd.buswidth > 4)
+		return false;
+
+	if (op->addr.nbytes && op->dummy.nbytes &&
+	    op->addr.buswidth != op->dummy.buswidth)
+		return false;
+
+	if (op->addr.nbytes + op->dummy.nbytes > 16)
+		return false;
+
+	if (op->data.nbytes > MTK_SPI_IPM_PACKET_SIZE) {
+		if (op->data.nbytes / MTK_SPI_IPM_PACKET_SIZE >
+		    MTK_SPI_IPM_PACKET_LOOP ||
+		    op->data.nbytes % MTK_SPI_IPM_PACKET_SIZE != 0)
+			return false;
+	}
+
+	return true;
+}
+
+static void mtk_spi_mem_setup_dma_xfer(struct spi_master *master,
+				       const struct spi_mem_op *op)
+{
+	struct mtk_spi *mdata = spi_master_get_devdata(master);
+
+	writel((u32)(mdata->tx_dma & MTK_SPI_32BITS_MASK),
+	       mdata->base + SPI_TX_SRC_REG);
+#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
+	if (mdata->dev_comp->dma_ext)
+		writel((u32)(mdata->tx_dma >> 32),
+		       mdata->base + SPI_TX_SRC_REG_64);
+#endif
+
+	if (op->data.dir == SPI_MEM_DATA_IN) {
+		writel((u32)(mdata->rx_dma & MTK_SPI_32BITS_MASK),
+		       mdata->base + SPI_RX_DST_REG);
+#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
+		if (mdata->dev_comp->dma_ext)
+			writel((u32)(mdata->rx_dma >> 32),
+			       mdata->base + SPI_RX_DST_REG_64);
+#endif
+	}
+}
+
+static int mtk_spi_transfer_wait(struct spi_mem *mem,
+				 const struct spi_mem_op *op)
+{
+	struct mtk_spi *mdata = spi_master_get_devdata(mem->spi->master);
+	/*
+	 * For each byte we wait for 8 cycles of the SPI clock.
+	 * Since speed is defined in Hz and we want milliseconds,
+	 * so it should be 8 * 1000.
+	 */
+	u64 ms = 8000LL;
+
+	if (op->data.dir == SPI_MEM_NO_DATA)
+		ms *= 32; /* prevent we may get 0 for short transfers. */
+	else
+		ms *= op->data.nbytes;
+	ms = div_u64(ms, mem->spi->max_speed_hz);
+	ms += ms + 1000; /* 1s tolerance */
+
+	if (ms > UINT_MAX)
+		ms = UINT_MAX;
+
+	if (!wait_for_completion_timeout(&mdata->spimem_done,
+					 msecs_to_jiffies(ms))) {
+		dev_err(mdata->dev, "spi-mem transfer timeout\n");
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
+static int mtk_spi_mem_exec_op(struct spi_mem *mem,
+			       const struct spi_mem_op *op)
+{
+	struct mtk_spi *mdata = spi_master_get_devdata(mem->spi->master);
+	u32 reg_val, nio, tx_size;
+	char *tx_tmp_buf, *rx_tmp_buf;
+	int ret = 0;
+
+	mdata->use_spimem = true;
+	reinit_completion(&mdata->spimem_done);
+
+	mtk_spi_reset(mdata);
+	mtk_spi_hw_init(mem->spi->master, mem->spi);
+	mtk_spi_prepare_transfer(mem->spi->master, mem->spi->max_speed_hz);
+
+	reg_val = readl(mdata->base + SPI_CFG3_IPM_REG);
+	/* opcode byte len */
+	reg_val &= ~SPI_CFG3_IPM_CMD_BYTELEN_MASK;
+	reg_val |= 1 << SPI_CFG3_IPM_CMD_BYTELEN_OFFSET;
+
+	/* addr & dummy byte len */
+	reg_val &= ~SPI_CFG3_IPM_ADDR_BYTELEN_MASK;
+	if (op->addr.nbytes || op->dummy.nbytes)
+		reg_val |= (op->addr.nbytes + op->dummy.nbytes) <<
+			    SPI_CFG3_IPM_ADDR_BYTELEN_OFFSET;
+
+	/* data byte len */
+	if (op->data.dir == SPI_MEM_NO_DATA) {
+		reg_val |= SPI_CFG3_IPM_NODATA_FLAG;
+		writel(0, mdata->base + SPI_CFG1_REG);
+	} else {
+		reg_val &= ~SPI_CFG3_IPM_NODATA_FLAG;
+		mdata->xfer_len = op->data.nbytes;
+		mtk_spi_setup_packet(mem->spi->master);
+	}
+
+	if (op->addr.nbytes || op->dummy.nbytes) {
+		if (op->addr.buswidth == 1 || op->dummy.buswidth == 1)
+			reg_val |= SPI_CFG3_IPM_XMODE_EN;
+		else
+			reg_val &= ~SPI_CFG3_IPM_XMODE_EN;
+	}
+
+	if (op->addr.buswidth == 2 ||
+	    op->dummy.buswidth == 2 ||
+	    op->data.buswidth == 2)
+		nio = 2;
+	else if (op->addr.buswidth == 4 ||
+		 op->dummy.buswidth == 4 ||
+		 op->data.buswidth == 4)
+		nio = 4;
+	else
+		nio = 1;
+
+	reg_val &= ~SPI_CFG3_IPM_CMD_PIN_MODE_MASK;
+	reg_val |= PIN_MODE_CFG(nio) << SPI_CFG3_IPM_PIN_MODE_OFFSET;
+
+	reg_val |= SPI_CFG3_IPM_HALF_DUPLEX_EN;
+	if (op->data.dir == SPI_MEM_DATA_IN)
+		reg_val |= SPI_CFG3_IPM_HALF_DUPLEX_DIR;
+	else
+		reg_val &= ~SPI_CFG3_IPM_HALF_DUPLEX_DIR;
+	writel(reg_val, mdata->base + SPI_CFG3_IPM_REG);
+
+	tx_size = 1 + op->addr.nbytes + op->dummy.nbytes;
+	if (op->data.dir == SPI_MEM_DATA_OUT)
+		tx_size += op->data.nbytes;
+
+	tx_size = max_t(u32, tx_size, 32);
+
+	tx_tmp_buf = kzalloc(tx_size, GFP_KERNEL | GFP_DMA);
+	if (!tx_tmp_buf) {
+		mdata->use_spimem = false;
+		return -ENOMEM;
+	}
+
+	tx_tmp_buf[0] = op->cmd.opcode;
+
+	if (op->addr.nbytes) {
+		int i;
+
+		for (i = 0; i < op->addr.nbytes; i++)
+			tx_tmp_buf[i + 1] = op->addr.val >>
+					(8 * (op->addr.nbytes - i - 1));
+	}
+
+	if (op->dummy.nbytes)
+		memset(tx_tmp_buf + op->addr.nbytes + 1,
+		       0xff,
+		       op->dummy.nbytes);
+
+	if (op->data.nbytes && op->data.dir == SPI_MEM_DATA_OUT)
+		memcpy(tx_tmp_buf + op->dummy.nbytes + op->addr.nbytes + 1,
+		       op->data.buf.out,
+		       op->data.nbytes);
+
+	mdata->tx_dma = dma_map_single(mdata->dev, tx_tmp_buf,
+				       tx_size, DMA_TO_DEVICE);
+	if (dma_mapping_error(mdata->dev, mdata->tx_dma)) {
+		ret = -ENOMEM;
+		goto err_exit;
+	}
+
+	if (op->data.dir == SPI_MEM_DATA_IN) {
+		if (!IS_ALIGNED((size_t)op->data.buf.in, 4)) {
+			rx_tmp_buf = kzalloc(op->data.nbytes,
+					     GFP_KERNEL | GFP_DMA);
+			if (!rx_tmp_buf) {
+				ret = -ENOMEM;
+				goto unmap_tx_dma;
+			}
+		} else {
+			rx_tmp_buf = op->data.buf.in;
+		}
+
+		mdata->rx_dma = dma_map_single(mdata->dev,
+					       rx_tmp_buf,
+					       op->data.nbytes,
+					       DMA_FROM_DEVICE);
+		if (dma_mapping_error(mdata->dev, mdata->rx_dma)) {
+			ret = -ENOMEM;
+			goto kfree_rx_tmp_buf;
+		}
+	}
+
+	reg_val = readl(mdata->base + SPI_CMD_REG);
+	reg_val |= SPI_CMD_TX_DMA;
+	if (op->data.dir == SPI_MEM_DATA_IN)
+		reg_val |= SPI_CMD_RX_DMA;
+	writel(reg_val, mdata->base + SPI_CMD_REG);
+
+	mtk_spi_mem_setup_dma_xfer(mem->spi->master, op);
+
+	mtk_spi_enable_transfer(mem->spi->master);
+
+	/* Wait for the interrupt. */
+	ret = mtk_spi_transfer_wait(mem, op);
+	if (ret)
+		goto unmap_rx_dma;
+
+	/* spi disable dma */
+	reg_val = readl(mdata->base + SPI_CMD_REG);
+	reg_val &= ~SPI_CMD_TX_DMA;
+	if (op->data.dir == SPI_MEM_DATA_IN)
+		reg_val &= ~SPI_CMD_RX_DMA;
+	writel(reg_val, mdata->base + SPI_CMD_REG);
+
+unmap_rx_dma:
+	if (op->data.dir == SPI_MEM_DATA_IN) {
+		dma_unmap_single(mdata->dev, mdata->rx_dma,
+				 op->data.nbytes, DMA_FROM_DEVICE);
+		if (!IS_ALIGNED((size_t)op->data.buf.in, 4))
+			memcpy(op->data.buf.in, rx_tmp_buf, op->data.nbytes);
+	}
+kfree_rx_tmp_buf:
+	if (op->data.dir == SPI_MEM_DATA_IN &&
+	    !IS_ALIGNED((size_t)op->data.buf.in, 4))
+		kfree(rx_tmp_buf);
+unmap_tx_dma:
+	dma_unmap_single(mdata->dev, mdata->tx_dma,
+			 tx_size, DMA_TO_DEVICE);
+err_exit:
+	kfree(tx_tmp_buf);
+	mdata->use_spimem = false;
+
+	return ret;
+}
+
+static const struct spi_controller_mem_ops mtk_spi_mem_ops = {
+	.adjust_op_size = mtk_spi_mem_adjust_op_size,
+	.supports_op = mtk_spi_mem_supports_op,
+	.exec_op = mtk_spi_mem_exec_op,
+};
+
+static void of_mtk_spi_parse_dt(struct spi_master *master, struct device_node *nc)
+{
+	struct mtk_spi *mdata = spi_master_get_devdata(master);
+	u32 value;
+
+	if (!of_property_read_u32(nc, "spi-tx-bus-width", &value)) {
+		switch (value) {
+		case 1:
+			break;
+		case 2:
+			master->mode_bits |= SPI_TX_DUAL;
+			break;
+		case 4:
+			master->mode_bits |= SPI_TX_QUAD;
+			break;
+		default:
+			dev_warn(mdata->dev,
+				 "spi-tx-bus-width %d not supported\n",
+				value);
+			break;
+		}
+	}
+
+	if (!of_property_read_u32(nc, "spi-rx-bus-width", &value)) {
+		switch (value) {
+		case 1:
+			break;
+		case 2:
+			master->mode_bits |= SPI_RX_DUAL;
+			break;
+		case 4:
+			master->mode_bits |= SPI_RX_QUAD;
+			break;
+		case 8:
+			master->mode_bits |= SPI_RX_OCTAL;
+			break;
+		default:
+			dev_warn(mdata->dev,
+				 "spi-rx-bus-width %d not supported\n",
+				value);
+			break;
+		}
+	}
+}
+
 static int mtk_spi_probe(struct platform_device *pdev)
 {
 	struct spi_master *master;
@@ -830,6 +1170,13 @@ static int mtk_spi_probe(struct platform_device *pdev)
 	if (mdata->dev_comp->ipm_design)
 		master->mode_bits |= SPI_LOOP;
 
+	if (mdata->dev_comp->ipm_design) {
+		mdata->dev = &pdev->dev;
+		master->mem_ops = &mtk_spi_mem_ops;
+		of_mtk_spi_parse_dt(master, pdev->dev.of_node);
+		init_completion(&mdata->spimem_done);
+	}
+
 	if (mdata->dev_comp->need_pad_sel) {
 		mdata->pad_num = of_property_count_u32_elems(
 			pdev->dev.of_node,
-- 
2.25.1

