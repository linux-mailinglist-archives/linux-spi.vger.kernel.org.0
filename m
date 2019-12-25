Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 086B112A8D3
	for <lists+linux-spi@lfdr.de>; Wed, 25 Dec 2019 19:22:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbfLYSWP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 25 Dec 2019 13:22:15 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:34892 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726893AbfLYSWO (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 25 Dec 2019 13:22:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=oFZfdu3FayRWkFOptQ3TVsdzB2BuspkdPu1Jk5+RMDg=; b=Aq34xpKGL2a/
        Dyhx0ABuiNq5yDFUPUhx/qHvI28DeJQ4oIbwsXP3MVs8cG8BpPkEyuHL0Z3p8BE6Piv31GxOm67gi
        YcjUpSL8oen21WfcVTQ5DLfskURatqEsWfynQu1m2D252+oIyvkf1GnqVaPsZkOlkbHY+QQLXHxKv
        i21gM=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ikBIN-0001ow-1r; Wed, 25 Dec 2019 18:22:07 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 8F905D01A24; Wed, 25 Dec 2019 18:22:06 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Jassi Brar <jaswinder.singh@linaro.org>,
        Keiji Hayashibara <hayashibara.keiji@socionext.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>
Subject: Applied "spi: uniphier: Add DMA transfer mode support" to the spi tree
In-Reply-To: <1577149107-30670-6-git-send-email-hayashi.kunihiko@socionext.com>
Message-Id: <applied-1577149107-30670-6-git-send-email-hayashi.kunihiko@socionext.com>
X-Patchwork-Hint: ignore
Date:   Wed, 25 Dec 2019 18:22:06 +0000 (GMT)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: uniphier: Add DMA transfer mode support

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.6

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From 28d1dddc59f6b7fc085093e7c1e978b33f0caf4c Mon Sep 17 00:00:00 2001
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Date: Tue, 24 Dec 2019 09:58:27 +0900
Subject: [PATCH] spi: uniphier: Add DMA transfer mode support

This adds DMA transfer mode support for UniPhier SPI controller.

Since this controller requires simulteaneous transmission and reception,
this indicates SPI_CONTROLLER_MUST_RX and SPI_CONTROLLER_MUST_TX.

Because the supported dma controller has alignment restiction,
there is also a restriction that 'maxburst' parameters in dma_slave_config
corresponds to one word width.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Link: https://lore.kernel.org/r/1577149107-30670-6-git-send-email-hayashi.kunihiko@socionext.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-uniphier.c | 200 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 198 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-uniphier.c b/drivers/spi/spi-uniphier.c
index c4e3b96b1038..0fa50979644d 100644
--- a/drivers/spi/spi-uniphier.c
+++ b/drivers/spi/spi-uniphier.c
@@ -8,6 +8,7 @@
 #include <linux/bitops.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
+#include <linux/dmaengine.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/module.h>
@@ -23,6 +24,7 @@
 
 struct uniphier_spi_priv {
 	void __iomem *base;
+	dma_addr_t base_dma_addr;
 	struct clk *clk;
 	struct spi_master *master;
 	struct completion xfer_done;
@@ -32,6 +34,7 @@ struct uniphier_spi_priv {
 	unsigned int rx_bytes;
 	const u8 *tx_buf;
 	u8 *rx_buf;
+	atomic_t dma_busy;
 
 	bool is_save_param;
 	u8 bits_per_word;
@@ -61,11 +64,16 @@ struct uniphier_spi_priv {
 #define   SSI_FPS_FSTRT		BIT(14)
 
 #define SSI_SR			0x14
+#define   SSI_SR_BUSY		BIT(7)
 #define   SSI_SR_RNE		BIT(0)
 
 #define SSI_IE			0x18
+#define   SSI_IE_TCIE		BIT(4)
 #define   SSI_IE_RCIE		BIT(3)
+#define   SSI_IE_TXRE		BIT(2)
+#define   SSI_IE_RXRE		BIT(1)
 #define   SSI_IE_RORIE		BIT(0)
+#define   SSI_IE_ALL_MASK	GENMASK(4, 0)
 
 #define SSI_IS			0x1c
 #define   SSI_IS_RXRS		BIT(9)
@@ -87,6 +95,10 @@ struct uniphier_spi_priv {
 #define SSI_RXDR		0x24
 
 #define SSI_FIFO_DEPTH		8U
+#define SSI_FIFO_BURST_NUM	1
+
+#define SSI_DMA_RX_BUSY		BIT(1)
+#define SSI_DMA_TX_BUSY		BIT(0)
 
 static inline unsigned int bytes_per_word(unsigned int bits)
 {
@@ -334,6 +346,128 @@ static void uniphier_spi_set_cs(struct spi_device *spi, bool enable)
 	writel(val, priv->base + SSI_FPS);
 }
 
+static bool uniphier_spi_can_dma(struct spi_master *master,
+				 struct spi_device *spi,
+				 struct spi_transfer *t)
+{
+	struct uniphier_spi_priv *priv = spi_master_get_devdata(master);
+	unsigned int bpw = bytes_per_word(priv->bits_per_word);
+
+	if ((!master->dma_tx && !master->dma_rx)
+	    || (!master->dma_tx && t->tx_buf)
+	    || (!master->dma_rx && t->rx_buf))
+		return false;
+
+	return DIV_ROUND_UP(t->len, bpw) > SSI_FIFO_DEPTH;
+}
+
+static void uniphier_spi_dma_rxcb(void *data)
+{
+	struct spi_master *master = data;
+	struct uniphier_spi_priv *priv = spi_master_get_devdata(master);
+	int state = atomic_fetch_andnot(SSI_DMA_RX_BUSY, &priv->dma_busy);
+
+	uniphier_spi_irq_disable(priv, SSI_IE_RXRE);
+
+	if (!(state & SSI_DMA_TX_BUSY))
+		spi_finalize_current_transfer(master);
+}
+
+static void uniphier_spi_dma_txcb(void *data)
+{
+	struct spi_master *master = data;
+	struct uniphier_spi_priv *priv = spi_master_get_devdata(master);
+	int state = atomic_fetch_andnot(SSI_DMA_TX_BUSY, &priv->dma_busy);
+
+	uniphier_spi_irq_disable(priv, SSI_IE_TXRE);
+
+	if (!(state & SSI_DMA_RX_BUSY))
+		spi_finalize_current_transfer(master);
+}
+
+static int uniphier_spi_transfer_one_dma(struct spi_master *master,
+					 struct spi_device *spi,
+					 struct spi_transfer *t)
+{
+	struct uniphier_spi_priv *priv = spi_master_get_devdata(master);
+	struct dma_async_tx_descriptor *rxdesc = NULL, *txdesc = NULL;
+	int buswidth;
+
+	atomic_set(&priv->dma_busy, 0);
+
+	uniphier_spi_set_fifo_threshold(priv, SSI_FIFO_BURST_NUM);
+
+	if (priv->bits_per_word <= 8)
+		buswidth = DMA_SLAVE_BUSWIDTH_1_BYTE;
+	else if (priv->bits_per_word <= 16)
+		buswidth = DMA_SLAVE_BUSWIDTH_2_BYTES;
+	else
+		buswidth = DMA_SLAVE_BUSWIDTH_4_BYTES;
+
+	if (priv->rx_buf) {
+		struct dma_slave_config rxconf = {
+			.direction = DMA_DEV_TO_MEM,
+			.src_addr = priv->base_dma_addr + SSI_RXDR,
+			.src_addr_width = buswidth,
+			.src_maxburst = SSI_FIFO_BURST_NUM,
+		};
+
+		dmaengine_slave_config(master->dma_rx, &rxconf);
+
+		rxdesc = dmaengine_prep_slave_sg(
+			master->dma_rx,
+			t->rx_sg.sgl, t->rx_sg.nents,
+			DMA_DEV_TO_MEM, DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+		if (!rxdesc)
+			goto out_err_prep;
+
+		rxdesc->callback = uniphier_spi_dma_rxcb;
+		rxdesc->callback_param = master;
+
+		uniphier_spi_irq_enable(priv, SSI_IE_RXRE);
+		atomic_or(SSI_DMA_RX_BUSY, &priv->dma_busy);
+
+		dmaengine_submit(rxdesc);
+		dma_async_issue_pending(master->dma_rx);
+	}
+
+	if (priv->tx_buf) {
+		struct dma_slave_config txconf = {
+			.direction = DMA_MEM_TO_DEV,
+			.dst_addr = priv->base_dma_addr + SSI_TXDR,
+			.dst_addr_width = buswidth,
+			.dst_maxburst = SSI_FIFO_BURST_NUM,
+		};
+
+		dmaengine_slave_config(master->dma_tx, &txconf);
+
+		txdesc = dmaengine_prep_slave_sg(
+			master->dma_tx,
+			t->tx_sg.sgl, t->tx_sg.nents,
+			DMA_MEM_TO_DEV, DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+		if (!txdesc)
+			goto out_err_prep;
+
+		txdesc->callback = uniphier_spi_dma_txcb;
+		txdesc->callback_param = master;
+
+		uniphier_spi_irq_enable(priv, SSI_IE_TXRE);
+		atomic_or(SSI_DMA_TX_BUSY, &priv->dma_busy);
+
+		dmaengine_submit(txdesc);
+		dma_async_issue_pending(master->dma_tx);
+	}
+
+	/* signal that we need to wait for completion */
+	return (priv->tx_buf || priv->rx_buf);
+
+out_err_prep:
+	if (rxdesc)
+		dmaengine_terminate_sync(master->dma_rx);
+
+	return -EINVAL;
+}
+
 static int uniphier_spi_transfer_one_irq(struct spi_master *master,
 					 struct spi_device *spi,
 					 struct spi_transfer *t)
@@ -395,6 +529,7 @@ static int uniphier_spi_transfer_one(struct spi_master *master,
 {
 	struct uniphier_spi_priv *priv = spi_master_get_devdata(master);
 	unsigned long threshold;
+	bool use_dma;
 
 	/* Terminate and return success for 0 byte length transfer */
 	if (!t->len)
@@ -402,6 +537,10 @@ static int uniphier_spi_transfer_one(struct spi_master *master,
 
 	uniphier_spi_setup_transfer(spi, t);
 
+	use_dma = master->can_dma ? master->can_dma(master, spi, t) : false;
+	if (use_dma)
+		return uniphier_spi_transfer_one_dma(master, spi, t);
+
 	/*
 	 * If the transfer operation will take longer than
 	 * SSI_POLL_TIMEOUT_US, it should use irq.
@@ -445,7 +584,17 @@ static void uniphier_spi_handle_err(struct spi_master *master,
 	val = SSI_FC_TXFFL | SSI_FC_RXFFL;
 	writel(val, priv->base + SSI_FC);
 
-	uniphier_spi_irq_disable(priv, SSI_IE_RCIE | SSI_IE_RORIE);
+	uniphier_spi_irq_disable(priv, SSI_IE_ALL_MASK);
+
+	if (atomic_read(&priv->dma_busy) & SSI_DMA_TX_BUSY) {
+		dmaengine_terminate_async(master->dma_tx);
+		atomic_andnot(SSI_DMA_TX_BUSY, &priv->dma_busy);
+	}
+
+	if (atomic_read(&priv->dma_busy) & SSI_DMA_RX_BUSY) {
+		dmaengine_terminate_async(master->dma_rx);
+		atomic_andnot(SSI_DMA_RX_BUSY, &priv->dma_busy);
+	}
 }
 
 static irqreturn_t uniphier_spi_handler(int irq, void *dev_id)
@@ -493,6 +642,9 @@ static int uniphier_spi_probe(struct platform_device *pdev)
 {
 	struct uniphier_spi_priv *priv;
 	struct spi_master *master;
+	struct resource *res;
+	struct dma_slave_caps caps;
+	u32 dma_tx_burst = 0, dma_rx_burst = 0;
 	unsigned long clk_rate;
 	int irq;
 	int ret;
@@ -507,11 +659,13 @@ static int uniphier_spi_probe(struct platform_device *pdev)
 	priv->master = master;
 	priv->is_save_param = false;
 
-	priv->base = devm_platform_ioremap_resource(pdev, 0);
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	priv->base = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(priv->base)) {
 		ret = PTR_ERR(priv->base);
 		goto out_master_put;
 	}
+	priv->base_dma_addr = res->start;
 
 	priv->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(priv->clk)) {
@@ -555,7 +709,44 @@ static int uniphier_spi_probe(struct platform_device *pdev)
 	master->unprepare_transfer_hardware
 				= uniphier_spi_unprepare_transfer_hardware;
 	master->handle_err = uniphier_spi_handle_err;
+	master->can_dma = uniphier_spi_can_dma;
+
 	master->num_chipselect = 1;
+	master->flags = SPI_CONTROLLER_MUST_RX | SPI_CONTROLLER_MUST_TX;
+
+	master->dma_tx = dma_request_chan(&pdev->dev, "tx");
+	if (IS_ERR_OR_NULL(master->dma_tx)) {
+		if (PTR_ERR(master->dma_tx) == -EPROBE_DEFER)
+			goto out_disable_clk;
+		master->dma_tx = NULL;
+		dma_tx_burst = INT_MAX;
+	} else {
+		ret = dma_get_slave_caps(master->dma_tx, &caps);
+		if (ret) {
+			dev_err(&pdev->dev, "failed to get TX DMA capacities: %d\n",
+				ret);
+			goto out_disable_clk;
+		}
+		dma_tx_burst = caps.max_burst;
+	}
+
+	master->dma_rx = dma_request_chan(&pdev->dev, "rx");
+	if (IS_ERR_OR_NULL(master->dma_rx)) {
+		if (PTR_ERR(master->dma_rx) == -EPROBE_DEFER)
+			goto out_disable_clk;
+		master->dma_rx = NULL;
+		dma_rx_burst = INT_MAX;
+	} else {
+		ret = dma_get_slave_caps(master->dma_rx, &caps);
+		if (ret) {
+			dev_err(&pdev->dev, "failed to get RX DMA capacities: %d\n",
+				ret);
+			goto out_disable_clk;
+		}
+		dma_rx_burst = caps.max_burst;
+	}
+
+	master->max_dma_len = min(dma_tx_burst, dma_rx_burst);
 
 	ret = devm_spi_register_master(&pdev->dev, master);
 	if (ret)
@@ -575,6 +766,11 @@ static int uniphier_spi_remove(struct platform_device *pdev)
 {
 	struct uniphier_spi_priv *priv = platform_get_drvdata(pdev);
 
+	if (priv->master->dma_tx)
+		dma_release_channel(priv->master->dma_tx);
+	if (priv->master->dma_rx)
+		dma_release_channel(priv->master->dma_rx);
+
 	clk_disable_unprepare(priv->clk);
 
 	return 0;
-- 
2.20.1

