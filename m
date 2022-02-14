Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6718D4B4492
	for <lists+linux-spi@lfdr.de>; Mon, 14 Feb 2022 09:44:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242251AbiBNIoN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 14 Feb 2022 03:44:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242224AbiBNIoL (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 14 Feb 2022 03:44:11 -0500
Received: from mail-m17664.qiye.163.com (mail-m17664.qiye.163.com [59.111.176.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 620CB50457;
        Mon, 14 Feb 2022 00:44:02 -0800 (PST)
Received: from localhost.localdomain (unknown [58.22.7.114])
        by mail-m17664.qiye.163.com (Hmail) with ESMTPA id 70BF014031D;
        Mon, 14 Feb 2022 16:44:00 +0800 (CST)
From:   Jon Lin <jon.lin@rock-chips.com>
To:     broonie@kernel.org
Cc:     heiko@sntech.de, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jon Lin <jon.lin@rock-chips.com>
Subject: [PATCH v2 3/6] spi: rockchip: Stop spi slave dma receiver when cs inactive
Date:   Mon, 14 Feb 2022 16:43:36 +0800
Message-Id: <20220214084339.18996-4-jon.lin@rock-chips.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220214084339.18996-1-jon.lin@rock-chips.com>
References: <20220214084339.18996-1-jon.lin@rock-chips.com>
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
        kWDxoPAgseWUFZKDYvK1lXWShZQUhPN1dZLVlBSVdZDwkaFQgSH1lBWUJLSx9WGUlMShpLTUJKHx
        gaVRMBExYaEhckFA4PWVdZFhoPEhUdFFlBWVVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6ODY6DCo6Mz4MQxE9CT0vGSo*
        K1EaC0xVSlVKTU9PQ0lDSU9LQktDVTMWGhIXVREUFVUXEhU7CRQYEFYYExILCFUYFBZFWVdZEgtZ
        QVlOQ1VJSVVMVUpKT1lXWQgBWUFMTElPNwY+
X-HM-Tid: 0a7ef7672aefda2fkuws70bf014031d
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The spi which's version is higher than ver 2 will automatically
enable this feature.

If the length of master transmission is uncertain, the RK spi slave
is better to automatically stop after cs inactive instead of waiting
for xfer_completion forever.

Signed-off-by: Jon Lin <jon.lin@rock-chips.com>
---

Changes in v2: None
Changes in v1: None

 drivers/spi/spi-rockchip.c | 81 ++++++++++++++++++++++++++++++++++----
 1 file changed, 73 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index c6a1bb09be05..5ecd0692cca1 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -133,7 +133,8 @@
 #define INT_TF_OVERFLOW				(1 << 1)
 #define INT_RF_UNDERFLOW			(1 << 2)
 #define INT_RF_OVERFLOW				(1 << 3)
-#define INT_RF_FULL					(1 << 4)
+#define INT_RF_FULL				(1 << 4)
+#define INT_CS_INACTIVE				(1 << 6)
 
 /* Bit fields in ICR, 4bit */
 #define ICR_MASK					0x0f
@@ -194,6 +195,8 @@ struct rockchip_spi {
 	bool cs_asserted[ROCKCHIP_SPI_MAX_CS_NUM];
 
 	bool slave_abort;
+	bool cs_inactive; /* spi slave tansmition stop when cs inactive */
+	struct spi_transfer *xfer; /* Store xfer temporarily */
 };
 
 static inline void spi_enable_chip(struct rockchip_spi *rs, bool enable)
@@ -343,6 +346,15 @@ static irqreturn_t rockchip_spi_isr(int irq, void *dev_id)
 	struct spi_controller *ctlr = dev_id;
 	struct rockchip_spi *rs = spi_controller_get_devdata(ctlr);
 
+	/* When int_cs_inactive comes, spi slave abort */
+	if (rs->cs_inactive && readl_relaxed(rs->regs + ROCKCHIP_SPI_IMR) & INT_CS_INACTIVE) {
+		ctlr->slave_abort(ctlr);
+		writel_relaxed(0, rs->regs + ROCKCHIP_SPI_IMR);
+		writel_relaxed(0xffffffff, rs->regs + ROCKCHIP_SPI_ICR);
+
+		return IRQ_HANDLED;
+	}
+
 	if (rs->tx_left)
 		rockchip_spi_pio_writer(rs);
 
@@ -350,6 +362,7 @@ static irqreturn_t rockchip_spi_isr(int irq, void *dev_id)
 	if (!rs->rx_left) {
 		spi_enable_chip(rs, false);
 		writel_relaxed(0, rs->regs + ROCKCHIP_SPI_IMR);
+		writel_relaxed(0xffffffff, rs->regs + ROCKCHIP_SPI_ICR);
 		spi_finalize_current_transfer(ctlr);
 	}
 
@@ -357,14 +370,18 @@ static irqreturn_t rockchip_spi_isr(int irq, void *dev_id)
 }
 
 static int rockchip_spi_prepare_irq(struct rockchip_spi *rs,
-		struct spi_transfer *xfer)
+				    struct spi_controller *ctlr,
+				    struct spi_transfer *xfer)
 {
 	rs->tx = xfer->tx_buf;
 	rs->rx = xfer->rx_buf;
 	rs->tx_left = rs->tx ? xfer->len / rs->n_bytes : 0;
 	rs->rx_left = xfer->len / rs->n_bytes;
 
-	writel_relaxed(INT_RF_FULL, rs->regs + ROCKCHIP_SPI_IMR);
+	if (rs->cs_inactive)
+		writel_relaxed(INT_RF_FULL | INT_CS_INACTIVE, rs->regs + ROCKCHIP_SPI_IMR);
+	else
+		writel_relaxed(INT_RF_FULL, rs->regs + ROCKCHIP_SPI_IMR);
 	spi_enable_chip(rs, true);
 
 	if (rs->tx_left)
@@ -383,6 +400,9 @@ static void rockchip_spi_dma_rxcb(void *data)
 	if (state & TXDMA && !rs->slave_abort)
 		return;
 
+	if (rs->cs_inactive)
+		writel_relaxed(0, rs->regs + ROCKCHIP_SPI_IMR);
+
 	spi_enable_chip(rs, false);
 	spi_finalize_current_transfer(ctlr);
 }
@@ -423,14 +443,16 @@ static int rockchip_spi_prepare_dma(struct rockchip_spi *rs,
 
 	atomic_set(&rs->state, 0);
 
+	rs->tx = xfer->tx_buf;
+	rs->rx = xfer->rx_buf;
+
 	rxdesc = NULL;
 	if (xfer->rx_buf) {
 		struct dma_slave_config rxconf = {
 			.direction = DMA_DEV_TO_MEM,
 			.src_addr = rs->dma_addr_rx,
 			.src_addr_width = rs->n_bytes,
-			.src_maxburst = rockchip_spi_calc_burst_size(xfer->len /
-								     rs->n_bytes),
+			.src_maxburst = rockchip_spi_calc_burst_size(xfer->len / rs->n_bytes),
 		};
 
 		dmaengine_slave_config(ctlr->dma_rx, &rxconf);
@@ -474,10 +496,13 @@ static int rockchip_spi_prepare_dma(struct rockchip_spi *rs,
 	/* rx must be started before tx due to spi instinct */
 	if (rxdesc) {
 		atomic_or(RXDMA, &rs->state);
-		dmaengine_submit(rxdesc);
+		ctlr->dma_rx->cookie = dmaengine_submit(rxdesc);
 		dma_async_issue_pending(ctlr->dma_rx);
 	}
 
+	if (rs->cs_inactive)
+		writel_relaxed(INT_CS_INACTIVE, rs->regs + ROCKCHIP_SPI_IMR);
+
 	spi_enable_chip(rs, true);
 
 	if (txdesc) {
@@ -584,7 +609,42 @@ static size_t rockchip_spi_max_transfer_size(struct spi_device *spi)
 static int rockchip_spi_slave_abort(struct spi_controller *ctlr)
 {
 	struct rockchip_spi *rs = spi_controller_get_devdata(ctlr);
+	u32 rx_fifo_left;
+	struct dma_tx_state state;
+	enum dma_status status;
+
+	/* Get current dma rx point */
+	if (atomic_read(&rs->state) & RXDMA) {
+		dmaengine_pause(ctlr->dma_rx);
+		status = dmaengine_tx_status(ctlr->dma_rx, ctlr->dma_rx->cookie, &state);
+		if (status == DMA_ERROR) {
+			rs->rx = rs->xfer->rx_buf;
+			rs->xfer->len = 0;
+			rx_fifo_left = readl_relaxed(rs->regs + ROCKCHIP_SPI_RXFLR);
+			for (; rx_fifo_left; rx_fifo_left--)
+				readl_relaxed(rs->regs + ROCKCHIP_SPI_RXDR);
+			goto out;
+		} else {
+			rs->rx += rs->xfer->len - rs->n_bytes * state.residue;
+		}
+	}
 
+	/* Get the valid data left in rx fifo and set rs->xfer->len real rx size */
+	if (rs->rx) {
+		rx_fifo_left = readl_relaxed(rs->regs + ROCKCHIP_SPI_RXFLR);
+		for (; rx_fifo_left; rx_fifo_left--) {
+			u32 rxw = readl_relaxed(rs->regs + ROCKCHIP_SPI_RXDR);
+
+			if (rs->n_bytes == 1)
+				*(u8 *)rs->rx = (u8)rxw;
+			else
+				*(u16 *)rs->rx = (u16)rxw;
+			rs->rx += rs->n_bytes;
+		}
+		rs->xfer->len = (unsigned int)(rs->rx - rs->xfer->rx_buf);
+	}
+
+out:
 	if (atomic_read(&rs->state) & RXDMA)
 		dmaengine_terminate_sync(ctlr->dma_rx);
 	if (atomic_read(&rs->state) & TXDMA)
@@ -626,7 +686,7 @@ static int rockchip_spi_transfer_one(
 	}
 
 	rs->n_bytes = xfer->bits_per_word <= 8 ? 1 : 2;
-
+	rs->xfer = xfer;
 	use_dma = ctlr->can_dma ? ctlr->can_dma(ctlr, spi, xfer) : false;
 
 	ret = rockchip_spi_config(rs, spi, xfer, use_dma, ctlr->slave);
@@ -636,7 +696,7 @@ static int rockchip_spi_transfer_one(
 	if (use_dma)
 		return rockchip_spi_prepare_dma(rs, ctlr, xfer);
 
-	return rockchip_spi_prepare_irq(rs, xfer);
+	return rockchip_spi_prepare_irq(rs, ctlr, xfer);
 }
 
 static bool rockchip_spi_can_dma(struct spi_controller *ctlr,
@@ -815,8 +875,13 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 	switch (readl_relaxed(rs->regs + ROCKCHIP_SPI_VERSION)) {
 	case ROCKCHIP_SPI_VER2_TYPE2:
 		ctlr->mode_bits |= SPI_CS_HIGH;
+		if (ctlr->can_dma && slave_mode)
+			rs->cs_inactive = true;
+		else
+			rs->cs_inactive = false;
 		break;
 	default:
+		rs->cs_inactive = false;
 		break;
 	}
 
-- 
2.17.1

