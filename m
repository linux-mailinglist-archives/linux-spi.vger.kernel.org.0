Return-Path: <linux-spi+bounces-11691-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E1A2C97AF2
	for <lists+linux-spi@lfdr.de>; Mon, 01 Dec 2025 14:46:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5C4584E23FC
	for <lists+linux-spi@lfdr.de>; Mon,  1 Dec 2025 13:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40DD03161B5;
	Mon,  1 Dec 2025 13:44:26 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C13263164A8;
	Mon,  1 Dec 2025 13:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764596665; cv=none; b=Zu8NkZ7il3H75LMzVvst47LQWkPPaoLDpDQ1lgDXeSuHeGEm36zOIJpsLJBAB+hzJS1j9pr1ZOwieO6zSYLV095KCrcVXFbGvMMuSEG+cPJEJqhLhxdaIRgjMjDakf7uUJEg00DaiJXlPYksyIbZZQ1hU6y1nc6vsUxex8PXO80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764596665; c=relaxed/simple;
	bh=gfZE5pDNxjjD/cfrOYBJmPe45UkIw4FE6AEb2aCh7fM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GAh6i7RVlhVRQtiwUH791vBZxWZ+uaJP0+lqTWsweDA0n8sdVsQKyjdKbp+fU0x8ow4JDgj4fySfU4qebt4V7uGcKoEs2d0GhgnR5zUhD3iIDlhbUV/dZZKzr5+NPL5L30NDuMpXhCj+wCzkP0ddLjJg4vi/SFDal2WJZpRGhMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: aBdb9Ha7ROSDbYGSYFRvtA==
X-CSE-MsgGUID: dX5G5KoqR2mPVxB0Q2aokg==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 01 Dec 2025 22:44:18 +0900
Received: from demon-pc.localdomain (unknown [10.226.93.83])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id E9AA44215A4E;
	Mon,  1 Dec 2025 22:44:13 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-spi@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Subject: [PATCH 11/13] spi: rzv2h-rspi: add support for DMA mode
Date: Mon,  1 Dec 2025 15:42:27 +0200
Message-ID: <20251201134229.600817-12-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251201134229.600817-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20251201134229.600817-1-cosmin-gabriel.tanislav.xa@renesas.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The DMA controller can be used to transfer data to and from the SPI
controller without involving the CPU for each word of a SPI transfer.

Add support for DMA mode.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---
 drivers/spi/spi-rzv2h-rspi.c | 169 ++++++++++++++++++++++++++++++++++-
 1 file changed, 168 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-rzv2h-rspi.c b/drivers/spi/spi-rzv2h-rspi.c
index 9f5bc047b485..aae916882915 100644
--- a/drivers/spi/spi-rzv2h-rspi.c
+++ b/drivers/spi/spi-rzv2h-rspi.c
@@ -9,6 +9,7 @@
 #include <linux/bitops.h>
 #include <linux/bits.h>
 #include <linux/clk.h>
+#include <linux/dmaengine.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/limits.h>
@@ -21,6 +22,8 @@
 #include <linux/spi/spi.h>
 #include <linux/wait.h>
 
+#include "internals.h"
+
 /* Registers */
 #define RSPI_SPDR		0x00
 #define RSPI_SPCR		0x08
@@ -96,6 +99,7 @@ struct rzv2h_rspi_info {
 struct rzv2h_rspi_priv {
 	struct spi_controller *controller;
 	const struct rzv2h_rspi_info *info;
+	struct platform_device *pdev;
 	void __iomem *base;
 	struct clk *tclk;
 	struct clk *pclk;
@@ -108,6 +112,7 @@ struct rzv2h_rspi_priv {
 	u8 spr;
 	u8 brdv;
 	bool use_pclk;
+	bool dma_callbacked;
 };
 
 #define RZV2H_RSPI_TX(func, type)					\
@@ -219,6 +224,20 @@ static int rzv2h_rspi_receive(struct rzv2h_rspi_priv *rspi, void *rxbuf,
 	return 0;
 }
 
+static bool rzv2h_rspi_can_dma(struct spi_controller *ctlr, struct spi_device *spi,
+			       struct spi_transfer *xfer)
+{
+	struct rzv2h_rspi_priv *rspi = spi_controller_get_devdata(ctlr);
+
+	if (ctlr->fallback)
+		return false;
+
+	if (!ctlr->dma_tx || !ctlr->dma_rx)
+		return false;
+
+	return xfer->len > rspi->info->fifo_size;
+}
+
 static int rzv2h_rspi_transfer_pio(struct rzv2h_rspi_priv *rspi,
 				   struct spi_device *spi,
 				   struct spi_transfer *transfer,
@@ -240,21 +259,149 @@ static int rzv2h_rspi_transfer_pio(struct rzv2h_rspi_priv *rspi,
 	return ret;
 }
 
+static void rzv2h_rspi_dma_complete(void *arg)
+{
+	struct rzv2h_rspi_priv *rspi = arg;
+
+	rspi->dma_callbacked = 1;
+	wake_up_interruptible(&rspi->wait);
+}
+
+static struct dma_async_tx_descriptor *
+rzv2h_rspi_setup_dma_channel(struct rzv2h_rspi_priv *rspi,
+			     struct dma_chan *chan, struct sg_table *sg,
+			     enum dma_slave_buswidth width,
+			     enum dma_transfer_direction direction)
+{
+	struct dma_slave_config config = {
+		.dst_addr = rspi->pdev->resource->start + RSPI_SPDR,
+		.src_addr = rspi->pdev->resource->start + RSPI_SPDR,
+		.dst_addr_width = width,
+		.src_addr_width = width,
+		.direction = direction,
+	};
+	struct dma_async_tx_descriptor *desc;
+	int ret;
+
+	ret = dmaengine_slave_config(chan, &config);
+	if (ret)
+		return ERR_PTR(ret);
+
+	desc = dmaengine_prep_slave_sg(chan, sg->sgl, sg->nents, direction,
+				       DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+	if (!desc)
+		return ERR_PTR(-EAGAIN);
+
+	if (direction == DMA_DEV_TO_MEM) {
+		desc->callback = rzv2h_rspi_dma_complete;
+		desc->callback_param = rspi;
+	}
+
+	return desc;
+}
+
+static enum dma_slave_buswidth
+rzv2h_rspi_dma_width(struct rzv2h_rspi_priv *rspi)
+{
+	switch (rspi->bytes_per_word) {
+	case 4:
+		return DMA_SLAVE_BUSWIDTH_4_BYTES;
+	case 2:
+		return DMA_SLAVE_BUSWIDTH_2_BYTES;
+	case 1:
+		return DMA_SLAVE_BUSWIDTH_1_BYTE;
+	default:
+		return DMA_SLAVE_BUSWIDTH_UNDEFINED;
+	}
+}
+
+static int rzv2h_rspi_transfer_dma(struct rzv2h_rspi_priv *rspi,
+				   struct spi_device *spi,
+				   struct spi_transfer *transfer,
+				   unsigned int words_to_transfer)
+{
+	struct dma_async_tx_descriptor *tx_desc = NULL, *rx_desc = NULL;
+	enum dma_slave_buswidth width;
+	dma_cookie_t cookie;
+	int ret;
+
+	width = rzv2h_rspi_dma_width(rspi);
+	if (width == DMA_SLAVE_BUSWIDTH_UNDEFINED)
+		return -EINVAL;
+
+	rx_desc = rzv2h_rspi_setup_dma_channel(rspi, rspi->controller->dma_rx,
+					       &transfer->rx_sg, width,
+					       DMA_DEV_TO_MEM);
+	if (IS_ERR(rx_desc))
+		return PTR_ERR(rx_desc);
+
+	tx_desc = rzv2h_rspi_setup_dma_channel(rspi, rspi->controller->dma_tx,
+					       &transfer->tx_sg, width,
+					       DMA_MEM_TO_DEV);
+	if (IS_ERR(tx_desc))
+		return PTR_ERR(tx_desc);
+
+	cookie = dmaengine_submit(rx_desc);
+	if (dma_submit_error(cookie))
+		return cookie;
+
+	cookie = dmaengine_submit(tx_desc);
+	if (dma_submit_error(cookie)) {
+		dmaengine_terminate_sync(rspi->controller->dma_rx);
+		return cookie;
+	}
+
+	/*
+	 * DMA transfer does not need IRQs to be enabled.
+	 * For PIO, we only use RX IRQ, so disable that.
+	 */
+	disable_irq(rspi->irq_rx);
+
+	rspi->dma_callbacked = 0;
+
+	dma_async_issue_pending(rspi->controller->dma_rx);
+	dma_async_issue_pending(rspi->controller->dma_tx);
+	rzv2h_rspi_clear_all_irqs(rspi);
+
+	ret = wait_event_interruptible_timeout(rspi->wait, rspi->dma_callbacked, HZ);
+	if (ret) {
+		dmaengine_synchronize(rspi->controller->dma_tx);
+		dmaengine_synchronize(rspi->controller->dma_rx);
+		ret = 0;
+	} else {
+		dmaengine_terminate_sync(rspi->controller->dma_tx);
+		dmaengine_terminate_sync(rspi->controller->dma_rx);
+		ret = -ETIMEDOUT;
+	}
+
+	enable_irq(rspi->irq_rx);
+
+	return ret;
+}
+
 static int rzv2h_rspi_transfer_one(struct spi_controller *controller,
 				   struct spi_device *spi,
 				   struct spi_transfer *transfer)
 {
 	struct rzv2h_rspi_priv *rspi = spi_controller_get_devdata(controller);
+	bool is_dma = spi_xfer_is_dma_mapped(controller, spi, transfer);
 	unsigned int words_to_transfer;
 	int ret;
 
 	transfer->effective_speed_hz = rspi->freq;
 	words_to_transfer = transfer->len / rspi->bytes_per_word;
 
-	ret = rzv2h_rspi_transfer_pio(rspi, spi, transfer, words_to_transfer);
+	if (is_dma)
+		ret = rzv2h_rspi_transfer_dma(rspi, spi, transfer, words_to_transfer);
+	else
+		ret = rzv2h_rspi_transfer_pio(rspi, spi, transfer, words_to_transfer);
 
 	rzv2h_rspi_clear_all_irqs(rspi);
 
+	if (is_dma && ret == -EAGAIN)
+		/* Retry with PIO */
+		transfer->error = SPI_TRANS_FAIL_NO_START;
+
 	return ret;
 }
 
@@ -557,6 +704,7 @@ static int rzv2h_rspi_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, rspi);
 
 	rspi->controller = controller;
+	rspi->pdev = pdev;
 
 	rspi->info = device_get_match_data(dev);
 
@@ -613,6 +761,7 @@ static int rzv2h_rspi_probe(struct platform_device *pdev)
 	controller->unprepare_message = rzv2h_rspi_unprepare_message;
 	controller->num_chipselect = 4;
 	controller->transfer_one = rzv2h_rspi_transfer_one;
+	controller->can_dma = rzv2h_rspi_can_dma;
 
 	tclk_rate = clk_round_rate(rspi->tclk, 0);
 	if (tclk_rate < 0)
@@ -630,6 +779,24 @@ static int rzv2h_rspi_probe(struct platform_device *pdev)
 							   RSPI_SPBR_SPR_MIN,
 							   RSPI_SPCMD_BRDV_MIN);
 
+	controller->dma_tx = devm_dma_request_chan(dev, "tx");
+	if (IS_ERR(controller->dma_tx)) {
+		ret = dev_warn_probe(dev, PTR_ERR(controller->dma_tx),
+				     "failed to request TX DMA channel\n");
+		if (ret == -EPROBE_DEFER)
+			return ret;
+		controller->dma_tx = NULL;
+	}
+
+	controller->dma_rx = devm_dma_request_chan(dev, "rx");
+	if (IS_ERR(controller->dma_rx)) {
+		ret = dev_warn_probe(dev, PTR_ERR(controller->dma_rx),
+				     "failed to request RX DMA channel\n");
+		if (ret == -EPROBE_DEFER)
+			return ret;
+		controller->dma_rx = NULL;
+	}
+
 	device_set_node(&controller->dev, dev_fwnode(dev));
 
 	ret = devm_spi_register_controller(dev, controller);
-- 
2.52.0


