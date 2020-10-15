Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEB3728F61A
	for <lists+linux-spi@lfdr.de>; Thu, 15 Oct 2020 17:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389793AbgJOPrs (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 15 Oct 2020 11:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389730AbgJOPrs (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 15 Oct 2020 11:47:48 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F77C061755;
        Thu, 15 Oct 2020 08:47:48 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id c21so3605093ljn.13;
        Thu, 15 Oct 2020 08:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=LuKF0N1JWbU39+L/415wOhZopR6HqG/zcA49QCFaGoU=;
        b=q/JCsOkiRkSfwE9CeyPER2pmdNqet2sgfhpNu+Z7z/nRBVQAWH/YLTWyvHx2Mu1rww
         gg7MHdSynSX/mLZbYpyQn26huirzbqm2mfnWTRBqMjhSFDN2SHHl6qlIunVIak779d+I
         IrC9mKusAF2Eown+rQINqzXMFvcLkvNjm3u8qj0Pk3Bgwd/9SYvJe0Ohd0BseUwk6NGw
         fnnbhkfXppli8NjVXnXFXjsq+FkZLxknhM+jBZ6GGXqvCUvyfigotiu1qNXL2MRA7npo
         Mxh4N8Hfmr560DHjys1ZA8jnLWEAux+VT4DL+PP23gEMDUMh11jpHS/+eGvvYVdOXlEr
         tEXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LuKF0N1JWbU39+L/415wOhZopR6HqG/zcA49QCFaGoU=;
        b=rVrXbgURzk7d8hCn0zdzfxJ6tUKVufqoQCQ6aRygeKUJAyGJwgsFyC0FZ/O8Vbw7yD
         rOSBCAiQLHNkxwB99Q/Xqp1lsSWnPddBqES56rrTgVsjL8vqwS91y0p5nAyU6dj/6v2N
         B/KZFvyZqJkW0V+IT+1UXBhHQt4e97c+ckUMMNPmlMui1VH+3Qv5nW+wHWOS/JdIWQ/W
         o+6O0EaeUsnkLcgCPEj46OmFCA1WX7QCKc85EYD1bOuKKiigaQl0HA6pKJXA7KmeBz+U
         ig+obEGTjqA5T/M4Rzq0kt5wYgfY5WtL/oDzxbJPCrisx8KfUALvpuoxL8s0BQnm9QDO
         qrAA==
X-Gm-Message-State: AOAM531N6Q0SzR3yGZEDJAUEev+QZHs4gE89jggKOaFvSgI4nxzJ2+bk
        rgoFhMUw8GPLJitnc/+u/hM=
X-Google-Smtp-Source: ABdhPJxYlqpNs9ZSfaxC2+6cCXCeZdTV39Ou1WQlV24xesWTKcO0afuTLZOpQMy5wb3uAjgVc9qIlQ==
X-Received: by 2002:a2e:9f4d:: with SMTP id v13mr1625625ljk.379.1602776866730;
        Thu, 15 Oct 2020 08:47:46 -0700 (PDT)
Received: from ubuntu-18.lintech.local ([80.87.144.137])
        by smtp.gmail.com with ESMTPSA id i13sm161294lfe.16.2020.10.15.08.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 08:47:46 -0700 (PDT)
From:   Alexander Kochetkov <al.kochet@gmail.com>
To:     Mark Brown <broonie@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Alexander Kochetkov <al.kochet@gmail.com>
Subject: [PATCH] spi: spi-sun6i: implement DMA-based transfer mode
Date:   Thu, 15 Oct 2020 18:47:40 +0300
Message-Id: <20201015154740.20825-1-al.kochet@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

DMA-based transfer will be enabled if data length is larger than FIFO size
(64 bytes for A64). This greatly reduce number of interrupts for
transferring data.

For smaller data size PIO mode will be used. In PIO mode whole buffer will
be loaded into FIFO.

If driver failed to request DMA channels then it fallback for PIO mode.

Tested on SOPINE (https://www.pine64.org/sopine/)

Signed-off-by: Alexander Kochetkov <al.kochet@gmail.com>
---
 drivers/spi/spi-sun6i.c | 171 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 159 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
index 19238e1b76b4..38e5b8af7da6 100644
--- a/drivers/spi/spi-sun6i.c
+++ b/drivers/spi/spi-sun6i.c
@@ -18,6 +18,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/reset.h>
+#include <linux/dmaengine.h>
 
 #include <linux/spi/spi.h>
 
@@ -52,10 +53,12 @@
 
 #define SUN6I_FIFO_CTL_REG		0x18
 #define SUN6I_FIFO_CTL_RF_RDY_TRIG_LEVEL_MASK	0xff
+#define SUN6I_FIFO_CTL_RF_DRQ_EN		BIT(8)
 #define SUN6I_FIFO_CTL_RF_RDY_TRIG_LEVEL_BITS	0
 #define SUN6I_FIFO_CTL_RF_RST			BIT(15)
 #define SUN6I_FIFO_CTL_TF_ERQ_TRIG_LEVEL_MASK	0xff
 #define SUN6I_FIFO_CTL_TF_ERQ_TRIG_LEVEL_BITS	16
+#define SUN6I_FIFO_CTL_TF_DRQ_EN		BIT(24)
 #define SUN6I_FIFO_CTL_TF_RST			BIT(31)
 
 #define SUN6I_FIFO_STA_REG		0x1c
@@ -83,6 +86,8 @@
 struct sun6i_spi {
 	struct spi_master	*master;
 	void __iomem		*base_addr;
+	dma_addr_t		dma_addr_rx;
+	dma_addr_t		dma_addr_tx;
 	struct clk		*hclk;
 	struct clk		*mclk;
 	struct reset_control	*rstc;
@@ -92,6 +97,7 @@ struct sun6i_spi {
 	const u8		*tx_buf;
 	u8			*rx_buf;
 	int			len;
+	bool			use_dma;
 	unsigned long		fifo_depth;
 };
 
@@ -182,6 +188,66 @@ static size_t sun6i_spi_max_transfer_size(struct spi_device *spi)
 	return SUN6I_MAX_XFER_SIZE - 1;
 }
 
+static int sun6i_spi_prepare_dma(struct sun6i_spi *sspi,
+				 struct spi_transfer *tfr)
+{
+	struct dma_async_tx_descriptor *rxdesc, *txdesc;
+	struct spi_master *master = sspi->master;
+
+	rxdesc = NULL;
+	if (tfr->rx_buf) {
+		struct dma_slave_config rxconf = {
+			.direction = DMA_DEV_TO_MEM,
+			.src_addr = sspi->dma_addr_rx,
+			.src_addr_width = 1,
+			.src_maxburst = 1,
+		};
+
+		dmaengine_slave_config(master->dma_rx, &rxconf);
+
+		rxdesc = dmaengine_prep_slave_sg(
+				master->dma_rx,
+				tfr->rx_sg.sgl, tfr->rx_sg.nents,
+				DMA_DEV_TO_MEM, DMA_PREP_INTERRUPT);
+		if (!rxdesc)
+			return -EINVAL;
+	}
+
+	txdesc = NULL;
+	if (tfr->tx_buf) {
+		struct dma_slave_config txconf = {
+			.direction = DMA_MEM_TO_DEV,
+			.dst_addr = sspi->dma_addr_tx,
+			.dst_addr_width = 1,
+			.dst_maxburst = 1,
+		};
+
+		dmaengine_slave_config(master->dma_tx, &txconf);
+
+		txdesc = dmaengine_prep_slave_sg(
+				master->dma_tx,
+				tfr->tx_sg.sgl, tfr->tx_sg.nents,
+				DMA_MEM_TO_DEV, DMA_PREP_INTERRUPT);
+		if (!txdesc) {
+			if (rxdesc)
+				dmaengine_terminate_sync(master->dma_rx);
+			return -EINVAL;
+		}
+	}
+
+	if (tfr->rx_buf) {
+		dmaengine_submit(rxdesc);
+		dma_async_issue_pending(master->dma_rx);
+	}
+
+	if (tfr->tx_buf) {
+		dmaengine_submit(txdesc);
+		dma_async_issue_pending(master->dma_tx);
+	}
+
+	return 0;
+}
+
 static int sun6i_spi_transfer_one(struct spi_master *master,
 				  struct spi_device *spi,
 				  struct spi_transfer *tfr)
@@ -201,6 +267,8 @@ static int sun6i_spi_transfer_one(struct spi_master *master,
 	sspi->tx_buf = tfr->tx_buf;
 	sspi->rx_buf = tfr->rx_buf;
 	sspi->len = tfr->len;
+	sspi->use_dma = master->can_dma ?
+			master->can_dma(master, spi, tfr) : false;
 
 	/* Clear pending interrupts */
 	sun6i_spi_write(sspi, SUN6I_INT_STA_REG, ~0);
@@ -216,9 +284,17 @@ static int sun6i_spi_transfer_one(struct spi_master *master,
 	 * (See spi-sun4i.c)
 	 */
 	trig_level = sspi->fifo_depth / 4 * 3;
-	sun6i_spi_write(sspi, SUN6I_FIFO_CTL_REG,
-			(trig_level << SUN6I_FIFO_CTL_RF_RDY_TRIG_LEVEL_BITS) |
-			(trig_level << SUN6I_FIFO_CTL_TF_ERQ_TRIG_LEVEL_BITS));
+	reg = (trig_level << SUN6I_FIFO_CTL_RF_RDY_TRIG_LEVEL_BITS) |
+	      (trig_level << SUN6I_FIFO_CTL_TF_ERQ_TRIG_LEVEL_BITS);
+
+	if (sspi->use_dma) {
+		if (tfr->tx_buf)
+			reg |= SUN6I_FIFO_CTL_TF_DRQ_EN;
+		if (tfr->rx_buf)
+			reg |= SUN6I_FIFO_CTL_RF_DRQ_EN;
+	}
+
+	sun6i_spi_write(sspi, SUN6I_FIFO_CTL_REG, reg);
 
 	/*
 	 * Setup the transfer control register: Chip Select,
@@ -300,16 +376,28 @@ static int sun6i_spi_transfer_one(struct spi_master *master,
 	sun6i_spi_write(sspi, SUN6I_XMIT_CNT_REG, tx_len);
 	sun6i_spi_write(sspi, SUN6I_BURST_CTL_CNT_REG, tx_len);
 
-	/* Fill the TX FIFO */
-	sun6i_spi_fill_fifo(sspi);
+	if (!sspi->use_dma) {
+		/* Fill the TX FIFO */
+		sun6i_spi_fill_fifo(sspi);
+	} else {
+		ret = sun6i_spi_prepare_dma(sspi, tfr);
+		if (ret) {
+			dev_warn(&master->dev,
+				 "%s: prepare DMA failed, ret=%d",
+				 dev_name(&spi->dev), ret);
+			return ret;
+		}
+	}
 
 	/* Enable the interrupts */
 	reg = SUN6I_INT_CTL_TC;
 
-	if (rx_len > sspi->fifo_depth)
-		reg |= SUN6I_INT_CTL_RF_RDY;
-	if (tx_len > sspi->fifo_depth)
-		reg |= SUN6I_INT_CTL_TF_ERQ;
+	if (!sspi->use_dma) {
+		if (rx_len > sspi->fifo_depth)
+			reg |= SUN6I_INT_CTL_RF_RDY;
+		if (tx_len > sspi->fifo_depth)
+			reg |= SUN6I_INT_CTL_TF_ERQ;
+	}
 
 	sun6i_spi_write(sspi, SUN6I_INT_CTL_REG, reg);
 
@@ -332,6 +420,11 @@ static int sun6i_spi_transfer_one(struct spi_master *master,
 
 	sun6i_spi_write(sspi, SUN6I_INT_CTL_REG, 0);
 
+	if (ret && sspi->use_dma) {
+		dmaengine_terminate_sync(master->dma_rx);
+		dmaengine_terminate_sync(master->dma_tx);
+	}
+
 	return ret;
 }
 
@@ -343,7 +436,8 @@ static irqreturn_t sun6i_spi_handler(int irq, void *dev_id)
 	/* Transfer complete */
 	if (status & SUN6I_INT_CTL_TC) {
 		sun6i_spi_write(sspi, SUN6I_INT_STA_REG, SUN6I_INT_CTL_TC);
-		sun6i_spi_drain_fifo(sspi);
+		if (!sspi->use_dma)
+			sun6i_spi_drain_fifo(sspi);
 		complete(&sspi->done);
 		return IRQ_HANDLED;
 	}
@@ -422,10 +516,24 @@ static int sun6i_spi_runtime_suspend(struct device *dev)
 	return 0;
 }
 
+static bool sun6i_spi_can_dma(struct spi_master *master,
+				 struct spi_device *spi,
+				 struct spi_transfer *xfer)
+{
+	struct sun6i_spi *sspi = spi_master_get_devdata(master);
+
+	/* if the number of spi words to transfer is less or equal than
+	 * the fifo length we can just fill the fifo and wait for a single
+	 * irq, so don't bother setting up dma
+	 */
+	return xfer->len > sspi->fifo_depth;
+}
+
 static int sun6i_spi_probe(struct platform_device *pdev)
 {
 	struct spi_master *master;
 	struct sun6i_spi *sspi;
+	struct resource *mem;
 	int ret = 0, irq;
 
 	master = spi_alloc_master(&pdev->dev, sizeof(struct sun6i_spi));
@@ -437,7 +545,7 @@ static int sun6i_spi_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, master);
 	sspi = spi_master_get_devdata(master);
 
-	sspi->base_addr = devm_platform_ioremap_resource(pdev, 0);
+	sspi->base_addr = devm_platform_get_and_ioremap_resource(pdev, 0, &mem);
 	if (IS_ERR(sspi->base_addr)) {
 		ret = PTR_ERR(sspi->base_addr);
 		goto err_free_master;
@@ -494,6 +602,33 @@ static int sun6i_spi_probe(struct platform_device *pdev)
 		goto err_free_master;
 	}
 
+	master->dma_tx = dma_request_chan(&pdev->dev, "tx");
+	if (IS_ERR(master->dma_tx)) {
+		/* Check tx to see if we need defer probing driver */
+		if (PTR_ERR(master->dma_tx) == -EPROBE_DEFER) {
+			ret = -EPROBE_DEFER;
+			goto err_free_master;
+		}
+		dev_warn(&pdev->dev, "Failed to request TX DMA channel\n");
+		master->dma_tx = NULL;
+	}
+
+	master->dma_rx = dma_request_chan(&pdev->dev, "rx");
+	if (IS_ERR(master->dma_rx)) {
+		if (PTR_ERR(master->dma_rx) == -EPROBE_DEFER) {
+			ret = -EPROBE_DEFER;
+			goto err_free_dma_tx;
+		}
+		dev_warn(&pdev->dev, "Failed to request RX DMA channel\n");
+		master->dma_rx = NULL;
+	}
+
+	if (master->dma_tx && master->dma_rx) {
+		sspi->dma_addr_tx = mem->start + SUN6I_TXDATA_REG;
+		sspi->dma_addr_rx = mem->start + SUN6I_RXDATA_REG;
+		master->can_dma = sun6i_spi_can_dma;
+	}
+
 	/*
 	 * This wake-up/shutdown pattern is to be able to have the
 	 * device woken up, even if runtime_pm is disabled
@@ -501,7 +636,7 @@ static int sun6i_spi_probe(struct platform_device *pdev)
 	ret = sun6i_spi_runtime_resume(&pdev->dev);
 	if (ret) {
 		dev_err(&pdev->dev, "Couldn't resume the device\n");
-		goto err_free_master;
+		goto err_free_dma_rx;
 	}
 
 	pm_runtime_set_active(&pdev->dev);
@@ -519,6 +654,12 @@ static int sun6i_spi_probe(struct platform_device *pdev)
 err_pm_disable:
 	pm_runtime_disable(&pdev->dev);
 	sun6i_spi_runtime_suspend(&pdev->dev);
+err_free_dma_rx:
+	if (master->dma_rx)
+		dma_release_channel(master->dma_rx);
+err_free_dma_tx:
+	if (master->dma_tx)
+		dma_release_channel(master->dma_tx);
 err_free_master:
 	spi_master_put(master);
 	return ret;
@@ -526,8 +667,14 @@ static int sun6i_spi_probe(struct platform_device *pdev)
 
 static int sun6i_spi_remove(struct platform_device *pdev)
 {
+	struct spi_master *master = platform_get_drvdata(pdev);
+
 	pm_runtime_force_suspend(&pdev->dev);
 
+	if (master->dma_tx)
+		dma_release_channel(master->dma_tx);
+	if (master->dma_rx)
+		dma_release_channel(master->dma_rx);
 	return 0;
 }
 
-- 
2.17.1

