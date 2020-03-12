Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8D51837C6
	for <lists+linux-spi@lfdr.de>; Thu, 12 Mar 2020 18:39:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbgCLRjH (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 12 Mar 2020 13:39:07 -0400
Received: from foss.arm.com ([217.140.110.172]:38876 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726127AbgCLRjH (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 12 Mar 2020 13:39:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8FC8A30E;
        Thu, 12 Mar 2020 10:39:06 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1184B3F6CF;
        Thu, 12 Mar 2020 10:39:05 -0700 (PDT)
Date:   Thu, 12 Mar 2020 17:39:04 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     broonie@kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "spi: meson-spicc: adapt burst handling for G12A support" to the spi tree
In-Reply-To:  <20200312133131.26430-8-narmstrong@baylibre.com>
Message-Id:  <applied-20200312133131.26430-8-narmstrong@baylibre.com>
X-Patchwork-Hint: ignore
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: meson-spicc: adapt burst handling for G12A support

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

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

From 0eb707ac7dd7a4329d93d47feada6c9bb5ea8ee9 Mon Sep 17 00:00:00 2001
From: Neil Armstrong <narmstrong@baylibre.com>
Date: Thu, 12 Mar 2020 14:31:29 +0100
Subject: [PATCH] spi: meson-spicc: adapt burst handling for G12A support

The G12A SPICC controller variant has a different FIFO size and doesn't
handle the RX Half interrupt the same way as GXL & AXG variants.

Thus simplify the burst management and take in account a variable FIFO
size.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Link: https://lore.kernel.org/r/20200312133131.26430-8-narmstrong@baylibre.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-meson-spicc.c | 129 +++++++++++++---------------------
 1 file changed, 50 insertions(+), 79 deletions(-)

diff --git a/drivers/spi/spi-meson-spicc.c b/drivers/spi/spi-meson-spicc.c
index 4494a791f4a7..351ccd8dd2c2 100644
--- a/drivers/spi/spi-meson-spicc.c
+++ b/drivers/spi/spi-meson-spicc.c
@@ -141,12 +141,10 @@
 #define writel_bits_relaxed(mask, val, addr) \
 	writel_relaxed((readl_relaxed(addr) & ~(mask)) | (val), addr)
 
-#define SPICC_BURST_MAX	16
-#define SPICC_FIFO_HALF 10
-
 struct meson_spicc_data {
 	unsigned int			max_speed_hz;
 	unsigned int			min_speed_hz;
+	unsigned int			fifo_size;
 	bool				has_oen;
 	bool				has_enhance_clk_div;
 };
@@ -166,8 +164,6 @@ struct meson_spicc_device {
 	unsigned long			tx_remain;
 	unsigned long			rx_remain;
 	unsigned long			xfer_remain;
-	bool				is_burst_end;
-	bool				is_last_burst;
 };
 
 static void meson_spicc_oen_enable(struct meson_spicc_device *spicc)
@@ -191,7 +187,7 @@ static inline bool meson_spicc_txfull(struct meson_spicc_device *spicc)
 
 static inline bool meson_spicc_rxready(struct meson_spicc_device *spicc)
 {
-	return FIELD_GET(SPICC_RH | SPICC_RR | SPICC_RF_EN,
+	return FIELD_GET(SPICC_RH | SPICC_RR | SPICC_RF,
 			 readl_relaxed(spicc->base + SPICC_STATREG));
 }
 
@@ -246,34 +242,22 @@ static inline void meson_spicc_tx(struct meson_spicc_device *spicc)
 			       spicc->base + SPICC_TXDATA);
 }
 
-static inline u32 meson_spicc_setup_rx_irq(struct meson_spicc_device *spicc,
-					   u32 irq_ctrl)
+static inline void meson_spicc_setup_burst(struct meson_spicc_device *spicc)
 {
-	if (spicc->rx_remain > SPICC_FIFO_HALF)
-		irq_ctrl |= SPICC_RH_EN;
-	else
-		irq_ctrl |= SPICC_RR_EN;
-
-	return irq_ctrl;
-}
 
-static inline void meson_spicc_setup_burst(struct meson_spicc_device *spicc,
-					   unsigned int burst_len)
-{
+	unsigned int burst_len = min_t(unsigned int,
+				       spicc->xfer_remain /
+				       spicc->bytes_per_word,
+				       spicc->data->fifo_size);
 	/* Setup Xfer variables */
 	spicc->tx_remain = burst_len;
 	spicc->rx_remain = burst_len;
 	spicc->xfer_remain -= burst_len * spicc->bytes_per_word;
-	spicc->is_burst_end = false;
-	if (burst_len < SPICC_BURST_MAX || !spicc->xfer_remain)
-		spicc->is_last_burst = true;
-	else
-		spicc->is_last_burst = false;
 
 	/* Setup burst length */
 	writel_bits_relaxed(SPICC_BURSTLENGTH_MASK,
 			FIELD_PREP(SPICC_BURSTLENGTH_MASK,
-				burst_len),
+				burst_len - 1),
 			spicc->base + SPICC_CONREG);
 
 	/* Fill TX FIFO */
@@ -283,61 +267,26 @@ static inline void meson_spicc_setup_burst(struct meson_spicc_device *spicc,
 static irqreturn_t meson_spicc_irq(int irq, void *data)
 {
 	struct meson_spicc_device *spicc = (void *) data;
-	u32 ctrl = readl_relaxed(spicc->base + SPICC_INTREG);
-	u32 stat = readl_relaxed(spicc->base + SPICC_STATREG) & ctrl;
 
-	ctrl &= ~(SPICC_RH_EN | SPICC_RR_EN);
+	writel_bits_relaxed(SPICC_TC, SPICC_TC, spicc->base + SPICC_STATREG);
 
 	/* Empty RX FIFO */
 	meson_spicc_rx(spicc);
 
-	/* Enable TC interrupt since we transferred everything */
-	if (!spicc->tx_remain && !spicc->rx_remain) {
-		spicc->is_burst_end = true;
-
-		/* Enable TC interrupt */
-		ctrl |= SPICC_TC_EN;
-
-		/* Reload IRQ status */
-		stat = readl_relaxed(spicc->base + SPICC_STATREG) & ctrl;
-	}
-
-	/* Check transfer complete */
-	if ((stat & SPICC_TC) && spicc->is_burst_end) {
-		unsigned int burst_len;
-
-		/* Clear TC bit */
-		writel_relaxed(SPICC_TC, spicc->base + SPICC_STATREG);
-
-		/* Disable TC interrupt */
-		ctrl &= ~SPICC_TC_EN;
-
-		if (spicc->is_last_burst) {
-			/* Disable all IRQs */
-			writel(0, spicc->base + SPICC_INTREG);
-
-			spi_finalize_current_transfer(spicc->master);
+	if (!spicc->xfer_remain) {
+		/* Disable all IRQs */
+		writel(0, spicc->base + SPICC_INTREG);
 
-			return IRQ_HANDLED;
-		}
+		spi_finalize_current_transfer(spicc->master);
 
-		burst_len = min_t(unsigned int,
-				  spicc->xfer_remain / spicc->bytes_per_word,
-				  SPICC_BURST_MAX);
-
-		/* Setup burst */
-		meson_spicc_setup_burst(spicc, burst_len);
-
-		/* Restart burst */
-		writel_bits_relaxed(SPICC_XCH, SPICC_XCH,
-				    spicc->base + SPICC_CONREG);
+		return IRQ_HANDLED;
 	}
 
-	/* Setup RX interrupt trigger */
-	ctrl = meson_spicc_setup_rx_irq(spicc, ctrl);
+	/* Setup burst */
+	meson_spicc_setup_burst(spicc);
 
-	/* Reconfigure interrupts */
-	writel(ctrl, spicc->base + SPICC_INTREG);
+	/* Start burst */
+	writel_bits_relaxed(SPICC_XCH, SPICC_XCH, spicc->base + SPICC_CONREG);
 
 	return IRQ_HANDLED;
 }
@@ -405,6 +354,28 @@ static void meson_spicc_setup_xfer(struct meson_spicc_device *spicc,
 	clk_set_rate(spicc->clk, xfer->speed_hz);
 
 	meson_spicc_auto_io_delay(spicc);
+
+	writel_relaxed(0, spicc->base + SPICC_DMAREG);
+}
+
+static void meson_spicc_reset_fifo(struct meson_spicc_device *spicc)
+{
+	u32 data;
+
+	if (spicc->data->has_oen)
+		writel_bits_relaxed(SPICC_ENH_MAIN_CLK_AO,
+				    SPICC_ENH_MAIN_CLK_AO,
+				    spicc->base + SPICC_ENH_CTL0);
+
+	writel_bits_relaxed(SPICC_FIFORST_W1_MASK, SPICC_FIFORST_W1_MASK,
+			    spicc->base + SPICC_TESTREG);
+
+	while (meson_spicc_rxready(spicc))
+		data = readl_relaxed(spicc->base + SPICC_RXDATA);
+
+	if (spicc->data->has_oen)
+		writel_bits_relaxed(SPICC_ENH_MAIN_CLK_AO, 0,
+				    spicc->base + SPICC_ENH_CTL0);
 }
 
 static int meson_spicc_transfer_one(struct spi_master *master,
@@ -412,8 +383,6 @@ static int meson_spicc_transfer_one(struct spi_master *master,
 				    struct spi_transfer *xfer)
 {
 	struct meson_spicc_device *spicc = spi_master_get_devdata(master);
-	unsigned int burst_len;
-	u32 irq = 0;
 
 	/* Store current transfer */
 	spicc->xfer = xfer;
@@ -427,22 +396,22 @@ static int meson_spicc_transfer_one(struct spi_master *master,
 	spicc->bytes_per_word =
 	   DIV_ROUND_UP(spicc->xfer->bits_per_word, 8);
 
+	if (xfer->len % spicc->bytes_per_word)
+		return -EINVAL;
+
 	/* Setup transfer parameters */
 	meson_spicc_setup_xfer(spicc, xfer);
 
-	burst_len = min_t(unsigned int,
-			  spicc->xfer_remain / spicc->bytes_per_word,
-			  SPICC_BURST_MAX);
-
-	meson_spicc_setup_burst(spicc, burst_len);
+	meson_spicc_reset_fifo(spicc);
 
-	irq = meson_spicc_setup_rx_irq(spicc, irq);
+	/* Setup burst */
+	meson_spicc_setup_burst(spicc);
 
 	/* Start burst */
 	writel_bits_relaxed(SPICC_XCH, SPICC_XCH, spicc->base + SPICC_CONREG);
 
 	/* Enable interrupts */
-	writel_relaxed(irq, spicc->base + SPICC_INTREG);
+	writel_relaxed(SPICC_TC_EN, spicc->base + SPICC_INTREG);
 
 	return 1;
 }
@@ -499,7 +468,7 @@ static int meson_spicc_prepare_message(struct spi_master *master,
 	/* Setup no wait cycles by default */
 	writel_relaxed(0, spicc->base + SPICC_PERIODREG);
 
-	writel_bits_relaxed(BIT(24), BIT(24), spicc->base + SPICC_TESTREG);
+	writel_bits_relaxed(SPICC_LBC_W1, 0, spicc->base + SPICC_TESTREG);
 
 	return 0;
 }
@@ -797,11 +766,13 @@ static int meson_spicc_remove(struct platform_device *pdev)
 static const struct meson_spicc_data meson_spicc_gx_data = {
 	.max_speed_hz		= 30000000,
 	.min_speed_hz		= 325000,
+	.fifo_size		= 16,
 };
 
 static const struct meson_spicc_data meson_spicc_axg_data = {
 	.max_speed_hz		= 80000000,
 	.min_speed_hz		= 325000,
+	.fifo_size		= 16,
 	.has_oen		= true,
 	.has_enhance_clk_div	= true,
 };
-- 
2.20.1

