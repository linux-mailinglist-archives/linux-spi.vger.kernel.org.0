Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E518F43F66
	for <lists+linux-spi@lfdr.de>; Thu, 13 Jun 2019 17:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731519AbfFMP46 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 13 Jun 2019 11:56:58 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:58320 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731602AbfFMP44 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 13 Jun 2019 11:56:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=rdQRuigh4pPeCL+DVbRSo6mhbiJGsrIQYlQjApHWDv0=; b=oQqdv9lbFaap
        lqFl0w8uGa3mtUNuoyJ3dzjNNPSg2zlLw9FZv2WJqiSQQCSXU260B+0O8NCq136s/Fkv+HMl6+M6x
        eNCrhjKTPfhFzTFar4/Q6xf5qoL5vo7cllUKDv18o27TQ+EanPRjjjRtvRnnYklr+8JDBo7gaXhGe
        nTicM=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hbS5t-0005HU-Rk; Thu, 13 Jun 2019 15:56:53 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 66A20440046; Thu, 13 Jun 2019 16:56:53 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, broonie@kernel.org,
        david.brown@linaro.org, jorge.ramirez-ortiz@linaro.org,
        khasim.mohammed@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: Applied "spi: qup: fix PIO/DMA transfers." to the spi tree
In-Reply-To: <20190610072243.19710-1-jorge.ramirez-ortiz@linaro.org>
X-Patchwork-Hint: ignore
Message-Id: <20190613155653.66A20440046@finisterre.sirena.org.uk>
Date:   Thu, 13 Jun 2019 16:56:53 +0100 (BST)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: qup: fix PIO/DMA transfers.

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.2

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

From a75e91bad717fea43358e7f743de5f93c4e5978f Mon Sep 17 00:00:00 2001
From: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Date: Mon, 10 Jun 2019 09:22:43 +0200
Subject: [PATCH] spi: qup: fix PIO/DMA transfers.

- DMA/PIO:
  If an error IRQ occurred during PIO or DMA mode make sure to log it so
on completion the transfer can be marked as an error.

- PIO:
  Do not complete a transaction until all data has been transferred or
an error IRQ was flagged.

1) If there was no error IRQ, ignore the done flag IRQ
(QUP_OP_MAX_INPUT_DONE_FLAG) until all data for the transfer has been
processed: not doing so risks completing the transfer returning
uninitialized data in the buffers.

2) Under stress testing we have identified the need to
protect read/write operations against spurious IN/OUT service events.

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-qup.c | 51 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 45 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
index 974a8ce58b68..0a2ffd2f968a 100644
--- a/drivers/spi/spi-qup.c
+++ b/drivers/spi/spi-qup.c
@@ -281,6 +281,9 @@ static void spi_qup_read(struct spi_qup *controller, u32 *opflags)
 		writel_relaxed(QUP_OP_IN_SERVICE_FLAG,
 			       controller->base + QUP_OPERATIONAL);
 
+		if (!remainder)
+			goto exit;
+
 		if (is_block_mode) {
 			num_words = (remainder > words_per_block) ?
 					words_per_block : remainder;
@@ -310,11 +313,13 @@ static void spi_qup_read(struct spi_qup *controller, u32 *opflags)
 	 * to refresh opflags value because MAX_INPUT_DONE_FLAG may now be
 	 * present and this is used to determine if transaction is complete
 	 */
-	*opflags = readl_relaxed(controller->base + QUP_OPERATIONAL);
-	if (is_block_mode && *opflags & QUP_OP_MAX_INPUT_DONE_FLAG)
-		writel_relaxed(QUP_OP_IN_SERVICE_FLAG,
-			       controller->base + QUP_OPERATIONAL);
-
+exit:
+	if (!remainder) {
+		*opflags = readl_relaxed(controller->base + QUP_OPERATIONAL);
+		if (is_block_mode && *opflags & QUP_OP_MAX_INPUT_DONE_FLAG)
+			writel_relaxed(QUP_OP_IN_SERVICE_FLAG,
+				       controller->base + QUP_OPERATIONAL);
+	}
 }
 
 static void spi_qup_write_to_fifo(struct spi_qup *controller, u32 num_words)
@@ -362,6 +367,10 @@ static void spi_qup_write(struct spi_qup *controller)
 		writel_relaxed(QUP_OP_OUT_SERVICE_FLAG,
 			       controller->base + QUP_OPERATIONAL);
 
+		/* make sure the interrupt is valid */
+		if (!remainder)
+			return;
+
 		if (is_block_mode) {
 			num_words = (remainder > words_per_block) ?
 				words_per_block : remainder;
@@ -575,10 +584,24 @@ static int spi_qup_do_pio(struct spi_device *spi, struct spi_transfer *xfer,
 	return 0;
 }
 
+static bool spi_qup_data_pending(struct spi_qup *controller)
+{
+	unsigned int remainder_tx, remainder_rx;
+
+	remainder_tx = DIV_ROUND_UP(spi_qup_len(controller) -
+				    controller->tx_bytes, controller->w_size);
+
+	remainder_rx = DIV_ROUND_UP(spi_qup_len(controller) -
+				    controller->rx_bytes, controller->w_size);
+
+	return remainder_tx || remainder_rx;
+}
+
 static irqreturn_t spi_qup_qup_irq(int irq, void *dev_id)
 {
 	struct spi_qup *controller = dev_id;
 	u32 opflags, qup_err, spi_err;
+	unsigned long flags;
 	int error = 0;
 
 	qup_err = readl_relaxed(controller->base + QUP_ERROR_FLAGS);
@@ -610,6 +633,11 @@ static irqreturn_t spi_qup_qup_irq(int irq, void *dev_id)
 		error = -EIO;
 	}
 
+	spin_lock_irqsave(&controller->lock, flags);
+	if (!controller->error)
+		controller->error = error;
+	spin_unlock_irqrestore(&controller->lock, flags);
+
 	if (spi_qup_is_dma_xfer(controller->mode)) {
 		writel_relaxed(opflags, controller->base + QUP_OPERATIONAL);
 	} else {
@@ -618,11 +646,22 @@ static irqreturn_t spi_qup_qup_irq(int irq, void *dev_id)
 
 		if (opflags & QUP_OP_OUT_SERVICE_FLAG)
 			spi_qup_write(controller);
+
+		if (!spi_qup_data_pending(controller))
+			complete(&controller->done);
 	}
 
-	if ((opflags & QUP_OP_MAX_INPUT_DONE_FLAG) || error)
+	if (error)
 		complete(&controller->done);
 
+	if (opflags & QUP_OP_MAX_INPUT_DONE_FLAG) {
+		if (!spi_qup_is_dma_xfer(controller->mode)) {
+			if (spi_qup_data_pending(controller))
+				return IRQ_HANDLED;
+		}
+		complete(&controller->done);
+	}
+
 	return IRQ_HANDLED;
 }
 
-- 
2.20.1

