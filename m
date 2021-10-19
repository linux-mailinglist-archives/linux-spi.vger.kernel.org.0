Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 883F3432D9C
	for <lists+linux-spi@lfdr.de>; Tue, 19 Oct 2021 08:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbhJSGED (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 19 Oct 2021 02:04:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:44860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229527AbhJSGED (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 19 Oct 2021 02:04:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 48810611EF;
        Tue, 19 Oct 2021 06:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634623310;
        bh=0F9kleSFJ9nK+wVZLn1cdTaZ5EXA2k0thI1ZxzugtYY=;
        h=From:To:Cc:Subject:Date:From;
        b=m/1KWH1NUiTS0VSgO21HAtsHk6Xnr6Yaect56xxiD0o6slx2mzSwjrOkhJnFS3S3l
         BCEq9YxEEU7PGMHkuSB7//Vw/JY8eAl4qWoKA+0hQVK+WLxEcdLDI2hlMf/dbwpb36
         HIj2lfYFBtJTByKBAjNQJnh+p/TF0xpf6/gbAqBWXbULbHJWstW7HnkjCSzoUt46yC
         XIjd4W/WAJryPKN4KGk+O1bR5a7xjoBhdFMEGahOkaCGtoVFDrZuk3aBl2rFQLY977
         DkZmSJeVq4CHFO+/bQAW842F8sedpwWzXSngi8nJQG94s6/AVehiqpFOJ+HmkWFK7U
         iUfQqkyc3ZckQ==
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4] spi: spi-geni-qcom: Add support for GPI dma
Date:   Tue, 19 Oct 2021 11:31:35 +0530
Message-Id: <20211019060135.1482666-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

We can use GPI DMA for devices where it is enabled by firmware. Add
support for this mode

Signed-off-by: Vinod Koul <vkoul@kernel.org>
-
Changes since v3:
 - Drop merged spi core, geni patches
 - Remove global structs and use local variables instead
 - modularize code more as suggested by Doug
 - fix kbuild bot warning

 drivers/i2c/busses/i2c-qcom-geni.c | 275 +++++++++++++++++++++++++++--
 1 file changed, 264 insertions(+), 11 deletions(-)

--
 drivers/spi/spi-geni-qcom.c | 254 +++++++++++++++++++++++++++++++++---
 1 file changed, 239 insertions(+), 15 deletions(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index 2f51421e2a71..bdeb732dda5c 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -2,6 +2,9 @@
 // Copyright (c) 2017-2018, The Linux foundation. All rights reserved.
 
 #include <linux/clk.h>
+#include <linux/dmaengine.h>
+#include <linux/dma-mapping.h>
+#include <linux/dma/qcom-gpi-dma.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/log2.h>
@@ -63,6 +66,15 @@
 #define TIMESTAMP_AFTER		BIT(3)
 #define POST_CMD_DELAY		BIT(4)
 
+#define GSI_LOOPBACK_EN		BIT(0)
+#define GSI_CS_TOGGLE		BIT(3)
+#define GSI_CPHA		BIT(4)
+#define GSI_CPOL		BIT(5)
+
+#define MAX_TX_SG		3
+#define NUM_SPI_XFER		8
+#define SPI_XFER_TIMEOUT_MS	250
+
 struct spi_geni_master {
 	struct geni_se se;
 	struct device *dev;
@@ -84,6 +96,9 @@ struct spi_geni_master {
 	int irq;
 	bool cs_flag;
 	bool abort_failed;
+	struct dma_chan *tx;
+	struct dma_chan *rx;
+	int cur_xfer_mode;
 };
 
 static int get_spi_clk_cfg(unsigned int speed_hz,
@@ -330,34 +345,197 @@ static int setup_fifo_params(struct spi_device *spi_slv,
 	return geni_spi_set_clock_and_bw(mas, spi_slv->max_speed_hz);
 }
 
+static void
+spi_gsi_callback_result(void *cb, const struct dmaengine_result *result)
+{
+	struct spi_master *spi = cb;
+
+	if (result->result != DMA_TRANS_NOERROR) {
+		dev_err(&spi->dev, "DMA txn failed: %d\n", result->result);
+		return;
+	}
+
+	if (!result->residue) {
+		dev_dbg(&spi->dev, "DMA txn completed\n");
+		spi_finalize_current_transfer(spi);
+	} else {
+		dev_err(&spi->dev, "DMA xfer has pending: %d\n", result->residue);
+	}
+}
+
+static int setup_gsi_xfer(struct spi_transfer *xfer, struct spi_geni_master *mas,
+			  struct spi_device *spi_slv, struct spi_master *spi)
+{
+	unsigned long flags = DMA_PREP_INTERRUPT | DMA_CTRL_ACK;
+	struct dma_slave_config config = {};
+	struct gpi_spi_config peripheral = {};
+	struct dma_async_tx_descriptor *tx_desc, *rx_desc;
+	int ret;
+
+	config.peripheral_config = &peripheral;
+	config.peripheral_size = sizeof(peripheral);
+	peripheral.set_config = true;
+
+	if (xfer->bits_per_word != mas->cur_bits_per_word ||
+	    xfer->speed_hz != mas->cur_speed_hz) {
+		mas->cur_bits_per_word = xfer->bits_per_word;
+		mas->cur_speed_hz = xfer->speed_hz;
+	}
+
+	if (xfer->tx_buf && xfer->rx_buf) {
+		peripheral.cmd = SPI_DUPLEX;
+	} else if (xfer->tx_buf) {
+		peripheral.cmd = SPI_TX;
+		peripheral.rx_len = 0;
+	} else if (xfer->rx_buf) {
+		peripheral.cmd = SPI_RX;
+		if (!(mas->cur_bits_per_word % MIN_WORD_LEN)) {
+			peripheral.rx_len = ((xfer->len << 3) / mas->cur_bits_per_word);
+		} else {
+			int bytes_per_word = (mas->cur_bits_per_word / BITS_PER_BYTE) + 1;
+
+			peripheral.rx_len = (xfer->len / bytes_per_word);
+		}
+	}
+
+	peripheral.loopback_en = spi_slv->mode && SPI_LOOP;
+	peripheral.clock_pol_high = spi_slv->mode && SPI_CPOL;
+	peripheral.data_pol_high = spi_slv->mode && SPI_CPHA;
+	peripheral.cs = spi_slv->chip_select;
+	peripheral.pack_en = true;
+	peripheral.word_len = xfer->bits_per_word - MIN_WORD_LEN;
+
+	ret = get_spi_clk_cfg(mas->cur_speed_hz, mas,
+			      &peripheral.clk_src, &peripheral.clk_div);
+	if (ret) {
+		dev_err(mas->dev, "Err in get_spi_clk_cfg() :%d\n", ret);
+		return ret;
+	}
+
+	if (!xfer->cs_change) {
+		if (!list_is_last(&xfer->transfer_list, &spi->cur_msg->transfers))
+			peripheral.fragmentation = FRAGMENTATION;
+	}
+
+	if (peripheral.cmd & SPI_RX) {
+		dmaengine_slave_config(mas->rx, &config);
+		rx_desc = dmaengine_prep_slave_sg(mas->rx, xfer->rx_sg.sgl, xfer->rx_sg.nents,
+						  DMA_DEV_TO_MEM, flags);
+		if (!rx_desc) {
+			dev_err(mas->dev, "Err setting up rx desc\n");
+			return -EIO;
+		}
+	}
+
+	/*
+	 * Prepare the TX always, even for RX or tx_buf being null, we would
+	 * need TX to be prepared per GSI spec
+	 */
+	dmaengine_slave_config(mas->tx, &config);
+	tx_desc = dmaengine_prep_slave_sg(mas->tx, xfer->tx_sg.sgl, xfer->tx_sg.nents,
+					  DMA_MEM_TO_DEV, flags);
+	if (!tx_desc) {
+		dev_err(mas->dev, "Err setting up tx desc\n");
+		return -EIO;
+	}
+
+	tx_desc->callback_result = spi_gsi_callback_result;
+	tx_desc->callback_param = spi;
+
+	if (peripheral.cmd & SPI_RX)
+		dmaengine_submit(rx_desc);
+	dmaengine_submit(tx_desc);
+
+	if (peripheral.cmd & SPI_RX)
+		dma_async_issue_pending(mas->rx);
+
+	dma_async_issue_pending(mas->tx);
+	return 1;
+}
+
+static bool geni_can_dma(struct spi_controller *ctlr,
+			 struct spi_device *slv, struct spi_transfer *xfer)
+{
+	struct spi_geni_master *mas = spi_master_get_devdata(slv->master);
+
+	/* check if dma is supported */
+	return mas->cur_xfer_mode != GENI_SE_FIFO;
+}
+
 static int spi_geni_prepare_message(struct spi_master *spi,
 					struct spi_message *spi_msg)
 {
-	int ret;
 	struct spi_geni_master *mas = spi_master_get_devdata(spi);
+	int ret;
 
-	if (spi_geni_is_abort_still_pending(mas))
-		return -EBUSY;
+	switch (mas->cur_xfer_mode) {
+	case GENI_SE_FIFO:
+		if (spi_geni_is_abort_still_pending(mas))
+			return -EBUSY;
+		ret = setup_fifo_params(spi_msg->spi, spi);
+		if (ret)
+			dev_err(mas->dev, "Couldn't select mode %d\n", ret);
+		return ret;
 
-	ret = setup_fifo_params(spi_msg->spi, spi);
-	if (ret)
-		dev_err(mas->dev, "Couldn't select mode %d\n", ret);
+	case GENI_GPI_DMA:
+		/* nothing to do for GPI DMA */
+		return 0;
+	}
+
+	dev_err(mas->dev, "Mode not supported %d", mas->cur_xfer_mode);
+	return -EINVAL;
+}
+
+static int spi_geni_grab_gpi_chan(struct spi_geni_master *mas)
+{
+	int ret;
+
+	mas->tx = dma_request_chan(mas->dev, "tx");
+	ret = dev_err_probe(mas->dev, IS_ERR(mas->tx), "Failed to get tx DMA ch\n");
+	if (ret < 0)
+		goto err_tx;
+
+	mas->rx = dma_request_chan(mas->dev, "rx");
+	ret = dev_err_probe(mas->dev, IS_ERR(mas->rx), "Failed to get rx DMA ch\n");
+	if (ret < 0)
+		goto err_rx;
+
+	return 0;
+
+err_rx:
+	dma_release_channel(mas->tx);
+	mas->tx = NULL;
+err_tx:
+	mas->rx = NULL;
 	return ret;
 }
 
+static void spi_geni_release_dma_chan(struct spi_geni_master *mas)
+{
+	if (mas->rx) {
+		dma_release_channel(mas->rx);
+		mas->rx = NULL;
+	}
+
+	if (mas->tx) {
+		dma_release_channel(mas->tx);
+		mas->tx = NULL;
+	}
+}
+
 static int spi_geni_init(struct spi_geni_master *mas)
 {
 	struct geni_se *se = &mas->se;
 	unsigned int proto, major, minor, ver;
-	u32 spi_tx_cfg;
+	u32 spi_tx_cfg, fifo_disable;
+	int ret = -ENXIO;
 
 	pm_runtime_get_sync(mas->dev);
 
 	proto = geni_se_read_proto(se);
 	if (proto != GENI_SE_SPI) {
 		dev_err(mas->dev, "Invalid proto %d\n", proto);
-		pm_runtime_put(mas->dev);
-		return -ENXIO;
+		goto out_pm;
 	}
 	mas->tx_fifo_depth = geni_se_get_tx_fifo_depth(se);
 
@@ -380,15 +558,38 @@ static int spi_geni_init(struct spi_geni_master *mas)
 	else
 		mas->oversampling = 1;
 
-	geni_se_select_mode(se, GENI_SE_FIFO);
+	fifo_disable = readl(se->base + GENI_IF_DISABLE_RO) & FIFO_IF_DISABLE;
+	switch (fifo_disable) {
+	case 1:
+		ret = spi_geni_grab_gpi_chan(mas);
+		if (!ret) { /* success case */
+			mas->cur_xfer_mode = GENI_GPI_DMA;
+			geni_se_select_mode(se, GENI_GPI_DMA);
+			dev_dbg(mas->dev, "Using GPI DMA mode for SPI\n");
+			break;
+		}
+		/*
+		 * in case of failure to get dma channel, we can still do the
+		 * FIFO mode, so fallthrough
+		 */
+		dev_warn(mas->dev, "FIFO mode disabled, but couldn't get DMA, fall back to FIFO mode\n");
+		fallthrough;
+
+	case 0:
+		mas->cur_xfer_mode = GENI_SE_FIFO;
+		geni_se_select_mode(se, GENI_SE_FIFO);
+		ret = 0;
+		break;
+	}
 
 	/* We always control CS manually */
 	spi_tx_cfg = readl(se->base + SE_SPI_TRANS_CFG);
 	spi_tx_cfg &= ~CS_TOGGLE;
 	writel(spi_tx_cfg, se->base + SE_SPI_TRANS_CFG);
 
+out_pm:
 	pm_runtime_put(mas->dev);
-	return 0;
+	return ret;
 }
 
 static unsigned int geni_byte_per_fifo_word(struct spi_geni_master *mas)
@@ -569,8 +770,11 @@ static int spi_geni_transfer_one(struct spi_master *spi,
 	if (!xfer->len)
 		return 0;
 
-	setup_fifo_xfer(xfer, mas, slv->mode, spi);
-	return 1;
+	if (mas->cur_xfer_mode == GENI_SE_FIFO) {
+		setup_fifo_xfer(xfer, mas, slv->mode, spi);
+		return 1;
+	}
+	return setup_gsi_xfer(xfer, mas, slv, spi);
 }
 
 static irqreturn_t geni_spi_isr(int irq, void *data)
@@ -665,6 +869,13 @@ static int spi_geni_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return irq;
 
+	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
+	if (ret) {
+		ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
+		if (ret)
+			return dev_err_probe(dev, ret, "could not set DMA mask\n");
+	}
+
 	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base))
 		return PTR_ERR(base);
@@ -704,9 +915,10 @@ static int spi_geni_probe(struct platform_device *pdev)
 	spi->max_speed_hz = 50000000;
 	spi->prepare_message = spi_geni_prepare_message;
 	spi->transfer_one = spi_geni_transfer_one;
+	spi->can_dma = geni_can_dma;
+	spi->dma_map_dev = dev->parent;
 	spi->auto_runtime_pm = true;
 	spi->handle_err = handle_fifo_timeout;
-	spi->set_cs = spi_geni_set_cs;
 	spi->use_gpio_descriptors = true;
 
 	init_completion(&mas->cs_done);
@@ -732,9 +944,17 @@ static int spi_geni_probe(struct platform_device *pdev)
 	if (ret)
 		goto spi_geni_probe_runtime_disable;
 
+	/*
+	 * check the mode supported and set_cs for fifo mode only
+	 * for dma (gsi) mode, the gsi will set cs based on params passed in
+	 * TRE
+	 */
+	if (mas->cur_xfer_mode == GENI_SE_FIFO)
+		spi->set_cs = spi_geni_set_cs;
+
 	ret = request_irq(mas->irq, geni_spi_isr, 0, dev_name(dev), spi);
 	if (ret)
-		goto spi_geni_probe_runtime_disable;
+		goto spi_geni_release_dma;
 
 	ret = spi_register_master(spi);
 	if (ret)
@@ -743,6 +963,8 @@ static int spi_geni_probe(struct platform_device *pdev)
 	return 0;
 spi_geni_probe_free_irq:
 	free_irq(mas->irq, spi);
+spi_geni_release_dma:
+	spi_geni_release_dma_chan(mas);
 spi_geni_probe_runtime_disable:
 	pm_runtime_disable(dev);
 	return ret;
@@ -756,6 +978,8 @@ static int spi_geni_remove(struct platform_device *pdev)
 	/* Unregister _before_ disabling pm_runtime() so we stop transfers */
 	spi_unregister_master(spi);
 
+	spi_geni_release_dma_chan(mas);
+
 	free_irq(mas->irq, spi);
 	pm_runtime_disable(&pdev->dev);
 	return 0;
-- 
2.31.1

