Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6950A174B0
	for <lists+linux-spi@lfdr.de>; Wed,  8 May 2019 11:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbfEHJJp (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 8 May 2019 05:09:45 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:58436 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbfEHJJp (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 8 May 2019 05:09:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=d5tlZR4YPrfOV1eJw5fAEi0JNHKIwg4JXLInXGrtSQY=; b=JYWjRhMTnybW
        UvPtCE0jBpP4wGAsRCAXF+MYiZDq/Tqi03TUaCGLsgS3jf1w7IT+MQC8ISeEyLHPNWwgpOV3a6PIT
        +FDx/7i8xCI0T2yJPrlBnCiFfH46xWRP7QaObSBmuEmUiZOclC2z3GjDj9f3XJakNMBDiEeybzsNL
        r3Jms=;
Received: from [61.199.190.11] (helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hOIZe-0007gT-14; Wed, 08 May 2019 09:09:17 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 1B5D444003B; Wed,  8 May 2019 10:08:57 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Radu Pirea <radu_nicolae.pirea@upb.ro>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        devicetree@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Richard Genoud <richard.genoud@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Applied "spi: at91-usart: add DMA support" to the spi tree
In-Reply-To: <20190505180646.1442-3-radu_nicolae.pirea@upb.ro>
X-Patchwork-Hint: ignore
Message-Id: <20190508090857.1B5D444003B@finisterre.sirena.org.uk>
Date:   Wed,  8 May 2019 10:08:57 +0100 (BST)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: at91-usart: add DMA support

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.3

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

From c3fdefc2d79e38d20e955d2d3ad48261d99c2936 Mon Sep 17 00:00:00 2001
From: Radu Pirea <radu_nicolae.pirea@upb.ro>
Date: Sun, 5 May 2019 21:06:46 +0300
Subject: [PATCH] spi: at91-usart: add DMA support

This patch adds support for DMA. Transfers are done with dma only if
they are longer than 16 bytes in order to achieve a better performance.
DMA setup introduces a little overhead and for transfers shorter than 16
bytes there is no performance improvement.

Signed-off-by: Radu Pirea <radu_nicolae.pirea@upb.ro>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-at91-usart.c | 221 ++++++++++++++++++++++++++++++++++-
 1 file changed, 219 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-at91-usart.c b/drivers/spi/spi-at91-usart.c
index f763e14bdf12..a40bb2ef89dc 100644
--- a/drivers/spi/spi-at91-usart.c
+++ b/drivers/spi/spi-at91-usart.c
@@ -8,9 +8,12 @@
 
 #include <linux/clk.h>
 #include <linux/delay.h>
+#include <linux/dmaengine.h>
+#include <linux/dma-direction.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/of_platform.h>
 #include <linux/of_gpio.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
@@ -59,6 +62,8 @@
 
 #define US_INIT \
 	(US_MR_SPI_MASTER | US_MR_CHRL | US_MR_CLKO | US_MR_WRDBT)
+#define US_DMA_MIN_BYTES       16
+#define US_DMA_TIMEOUT         (msecs_to_jiffies(1000))
 
 /* Register access macros */
 #define at91_usart_spi_readl(port, reg) \
@@ -72,14 +77,19 @@
 	writeb_relaxed((value), (port)->regs + US_##reg)
 
 struct at91_usart_spi {
+	struct platform_device  *mpdev;
 	struct spi_transfer	*current_transfer;
 	void __iomem		*regs;
 	struct device		*dev;
 	struct clk		*clk;
 
+	struct completion	xfer_completion;
+
 	/*used in interrupt to protect data reading*/
 	spinlock_t		lock;
 
+	phys_addr_t		phybase;
+
 	int			irq;
 	unsigned int		current_tx_remaining_bytes;
 	unsigned int		current_rx_remaining_bytes;
@@ -88,8 +98,182 @@ struct at91_usart_spi {
 	u32			status;
 
 	bool			xfer_failed;
+	bool			use_dma;
 };
 
+static void dma_callback(void *data)
+{
+	struct spi_controller   *ctlr = data;
+	struct at91_usart_spi   *aus = spi_master_get_devdata(ctlr);
+
+	at91_usart_spi_writel(aus, IER, US_IR_RXRDY);
+	aus->current_rx_remaining_bytes = 0;
+	complete(&aus->xfer_completion);
+}
+
+static bool at91_usart_spi_can_dma(struct spi_controller *ctrl,
+				   struct spi_device *spi,
+				   struct spi_transfer *xfer)
+{
+	struct at91_usart_spi *aus = spi_master_get_devdata(ctrl);
+
+	return aus->use_dma && xfer->len >= US_DMA_MIN_BYTES;
+}
+
+static int at91_usart_spi_configure_dma(struct spi_controller *ctlr,
+					struct at91_usart_spi *aus)
+{
+	struct dma_slave_config slave_config;
+	struct device *dev = &aus->mpdev->dev;
+	phys_addr_t phybase = aus->phybase;
+	dma_cap_mask_t mask;
+	int err = 0;
+
+	dma_cap_zero(mask);
+	dma_cap_set(DMA_SLAVE, mask);
+
+	ctlr->dma_tx = dma_request_slave_channel_reason(dev, "tx");
+	if (IS_ERR_OR_NULL(ctlr->dma_tx)) {
+		if (IS_ERR(ctlr->dma_tx)) {
+			err = PTR_ERR(ctlr->dma_tx);
+			goto at91_usart_spi_error_clear;
+		}
+
+		dev_dbg(dev,
+			"DMA TX channel not available, SPI unable to use DMA\n");
+		err = -EBUSY;
+		goto at91_usart_spi_error_clear;
+	}
+
+	ctlr->dma_rx = dma_request_slave_channel_reason(dev, "rx");
+	if (IS_ERR_OR_NULL(ctlr->dma_rx)) {
+		if (IS_ERR(ctlr->dma_rx)) {
+			err = PTR_ERR(ctlr->dma_rx);
+			goto at91_usart_spi_error;
+		}
+
+		dev_dbg(dev,
+			"DMA RX channel not available, SPI unable to use DMA\n");
+		err = -EBUSY;
+		goto at91_usart_spi_error;
+	}
+
+	slave_config.dst_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
+	slave_config.src_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
+	slave_config.dst_addr = (dma_addr_t)phybase + US_THR;
+	slave_config.src_addr = (dma_addr_t)phybase + US_RHR;
+	slave_config.src_maxburst = 1;
+	slave_config.dst_maxburst = 1;
+	slave_config.device_fc = false;
+
+	slave_config.direction = DMA_DEV_TO_MEM;
+	if (dmaengine_slave_config(ctlr->dma_rx, &slave_config)) {
+		dev_err(&ctlr->dev,
+			"failed to configure rx dma channel\n");
+		err = -EINVAL;
+		goto at91_usart_spi_error;
+	}
+
+	slave_config.direction = DMA_MEM_TO_DEV;
+	if (dmaengine_slave_config(ctlr->dma_tx, &slave_config)) {
+		dev_err(&ctlr->dev,
+			"failed to configure tx dma channel\n");
+		err = -EINVAL;
+		goto at91_usart_spi_error;
+	}
+
+	aus->use_dma = true;
+	return 0;
+
+at91_usart_spi_error:
+	if (!IS_ERR_OR_NULL(ctlr->dma_tx))
+		dma_release_channel(ctlr->dma_tx);
+	if (!IS_ERR_OR_NULL(ctlr->dma_rx))
+		dma_release_channel(ctlr->dma_rx);
+	ctlr->dma_tx = NULL;
+	ctlr->dma_rx = NULL;
+
+at91_usart_spi_error_clear:
+	return err;
+}
+
+static void at91_usart_spi_release_dma(struct spi_controller *ctlr)
+{
+	if (ctlr->dma_rx)
+		dma_release_channel(ctlr->dma_rx);
+	if (ctlr->dma_tx)
+		dma_release_channel(ctlr->dma_tx);
+}
+
+static void at91_usart_spi_stop_dma(struct spi_controller *ctlr)
+{
+	if (ctlr->dma_rx)
+		dmaengine_terminate_all(ctlr->dma_rx);
+	if (ctlr->dma_tx)
+		dmaengine_terminate_all(ctlr->dma_tx);
+}
+
+static int at91_usart_spi_dma_transfer(struct spi_controller *ctlr,
+				       struct spi_transfer *xfer)
+{
+	struct at91_usart_spi *aus = spi_master_get_devdata(ctlr);
+	struct dma_chan	 *rxchan = ctlr->dma_rx;
+	struct dma_chan *txchan = ctlr->dma_tx;
+	struct dma_async_tx_descriptor *rxdesc;
+	struct dma_async_tx_descriptor *txdesc;
+	dma_cookie_t cookie;
+
+	/* Disable RX interrupt */
+	at91_usart_spi_writel(aus, IDR, US_IR_RXRDY);
+
+	rxdesc = dmaengine_prep_slave_sg(rxchan,
+					 xfer->rx_sg.sgl,
+					 xfer->rx_sg.nents,
+					 DMA_DEV_TO_MEM,
+					 DMA_PREP_INTERRUPT |
+					 DMA_CTRL_ACK);
+	if (!rxdesc)
+		goto at91_usart_spi_err_dma;
+
+	txdesc = dmaengine_prep_slave_sg(txchan,
+					 xfer->tx_sg.sgl,
+					 xfer->tx_sg.nents,
+					 DMA_MEM_TO_DEV,
+					 DMA_PREP_INTERRUPT |
+					 DMA_CTRL_ACK);
+	if (!txdesc)
+		goto at91_usart_spi_err_dma;
+
+	rxdesc->callback = dma_callback;
+	rxdesc->callback_param = ctlr;
+
+	cookie = rxdesc->tx_submit(rxdesc);
+	if (dma_submit_error(cookie))
+		goto at91_usart_spi_err_dma;
+
+	cookie = txdesc->tx_submit(txdesc);
+	if (dma_submit_error(cookie))
+		goto at91_usart_spi_err_dma;
+
+	rxchan->device->device_issue_pending(rxchan);
+	txchan->device->device_issue_pending(txchan);
+
+	return 0;
+
+at91_usart_spi_err_dma:
+	/* Enable RX interrupt if something fails and fallback to PIO */
+	at91_usart_spi_writel(aus, IER, US_IR_RXRDY);
+	at91_usart_spi_stop_dma(ctlr);
+
+	return -ENOMEM;
+}
+
+static unsigned long at91_usart_spi_dma_timeout(struct at91_usart_spi *aus)
+{
+	return wait_for_completion_timeout(&aus->xfer_completion,
+					   US_DMA_TIMEOUT);
+}
+
 static inline u32 at91_usart_spi_tx_ready(struct at91_usart_spi *aus)
 {
 	return aus->status & US_IR_TXRDY;
@@ -216,6 +400,8 @@ static int at91_usart_spi_transfer_one(struct spi_controller *ctlr,
 				       struct spi_transfer *xfer)
 {
 	struct at91_usart_spi *aus = spi_master_get_devdata(ctlr);
+	unsigned long dma_timeout = 0;
+	int ret = 0;
 
 	at91_usart_spi_set_xfer_speed(aus, xfer);
 	aus->xfer_failed = false;
@@ -225,8 +411,25 @@ static int at91_usart_spi_transfer_one(struct spi_controller *ctlr,
 
 	while ((aus->current_tx_remaining_bytes ||
 		aus->current_rx_remaining_bytes) && !aus->xfer_failed) {
-		at91_usart_spi_read_status(aus);
-		at91_usart_spi_tx(aus);
+		reinit_completion(&aus->xfer_completion);
+		if (at91_usart_spi_can_dma(ctlr, spi, xfer) &&
+		    !ret) {
+			ret = at91_usart_spi_dma_transfer(ctlr, xfer);
+			if (ret)
+				continue;
+
+			dma_timeout = at91_usart_spi_dma_timeout(aus);
+
+			if (WARN_ON(dma_timeout == 0)) {
+				dev_err(&spi->dev, "DMA transfer timeout\n");
+				return -EIO;
+			}
+			aus->current_tx_remaining_bytes = 0;
+		} else {
+			at91_usart_spi_read_status(aus);
+			at91_usart_spi_tx(aus);
+		}
+
 		cpu_relax();
 	}
 
@@ -345,6 +548,7 @@ static int at91_usart_spi_probe(struct platform_device *pdev)
 	controller->transfer_one = at91_usart_spi_transfer_one;
 	controller->prepare_message = at91_usart_spi_prepare_message;
 	controller->unprepare_message = at91_usart_spi_unprepare_message;
+	controller->can_dma = at91_usart_spi_can_dma;
 	controller->cleanup = at91_usart_spi_cleanup;
 	controller->max_speed_hz = DIV_ROUND_UP(clk_get_rate(clk),
 						US_MIN_CLK_DIV);
@@ -376,7 +580,17 @@ static int at91_usart_spi_probe(struct platform_device *pdev)
 	aus->spi_clk = clk_get_rate(clk);
 	at91_usart_spi_init(aus);
 
+	aus->phybase = regs->start;
+
+	aus->mpdev = to_platform_device(pdev->dev.parent);
+
+	ret = at91_usart_spi_configure_dma(controller, aus);
+	if (ret)
+		goto at91_usart_fail_dma;
+
 	spin_lock_init(&aus->lock);
+	init_completion(&aus->xfer_completion);
+
 	ret = devm_spi_register_master(&pdev->dev, controller);
 	if (ret)
 		goto at91_usart_fail_register_master;
@@ -389,6 +603,8 @@ static int at91_usart_spi_probe(struct platform_device *pdev)
 	return 0;
 
 at91_usart_fail_register_master:
+	at91_usart_spi_release_dma(controller);
+at91_usart_fail_dma:
 	clk_disable_unprepare(clk);
 at91_usart_spi_probe_fail:
 	spi_master_put(controller);
@@ -453,6 +669,7 @@ static int at91_usart_spi_remove(struct platform_device *pdev)
 	struct spi_controller *ctlr = platform_get_drvdata(pdev);
 	struct at91_usart_spi *aus = spi_master_get_devdata(ctlr);
 
+	at91_usart_spi_release_dma(ctlr);
 	clk_disable_unprepare(aus->clk);
 
 	return 0;
-- 
2.20.1

