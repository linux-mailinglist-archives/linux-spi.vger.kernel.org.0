Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27EED183183
	for <lists+linux-spi@lfdr.de>; Thu, 12 Mar 2020 14:32:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727456AbgCLNcI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 12 Mar 2020 09:32:08 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38650 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727437AbgCLNbn (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 12 Mar 2020 09:31:43 -0400
Received: by mail-wm1-f67.google.com with SMTP id h83so2773835wmf.3
        for <linux-spi@vger.kernel.org>; Thu, 12 Mar 2020 06:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tdUB5s+Mgt8nPOXH1fk62M6gPs/HBhr92WS0vOvoB1Y=;
        b=fDpw7L+gW+Pj56qUlrLoOupqymKfPWSYbHcqXeYo8PK0Q12Q7VmFHJkS7UauyOeKGd
         nT5vfpMk5dlesnPeCwZSkDZ9H/ORR7AToqivIwtAXa+KdpSfH2HiXzS36+47BPVCMF58
         +fFY5aMsmeyRMTHN++OW+He5L+/UYDfEbIR4FG8nGT+uWQ0uV9y6/aJyF1hO46rnxqqK
         31oeFdQ8Of844HYuiIuGda7zr5DjjRn/YdKcn8Fyx4hBnixE+3Uzsw9U1R6u3fxyygsY
         wMEA3qkA78Z3IRRWfY42RYTiQys+fiScAXWCK0vVjlkcXua3i3rtj78hKw9FZtq3dGfZ
         L7eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tdUB5s+Mgt8nPOXH1fk62M6gPs/HBhr92WS0vOvoB1Y=;
        b=YfHPbg1Yx5ZRGInRrEMQnzu7FFpJOz/R7qCakfzAvTB/ofjkquklqb8dHdoWsONS+F
         Iqbwx3EfzTwirUNXn1OJGLFpoKe2Rh665aYxqzTCcMldQVMizCzT7SZv6u/umlA137wa
         GacsASJ7N8x+iU/wzsNcy6BE6+AsNU1YV9ugmPppeonBgb0amPoIZmu7rR/0EQEtq9BQ
         KBzFKvP+PEUVcp6vnUmOqH7ZKQGn1QjvoDA7aMcLKl1e99gxfcfh71ErOZXNHbpqiyPh
         XlIdd2Bn/ScyaX1TildaKIBu+a1VihK7OPMUPo0HIGiT9EUImWWwKVwkIeV/oLXyTghD
         CJGw==
X-Gm-Message-State: ANhLgQ3Z0nzPK0N0i6x13ZOZiuLu+ls5/CbV5/ZJRqOalX0rWg6l2lrT
        DWb84BT3neMKn3X/wvg3VsBrcw==
X-Google-Smtp-Source: ADFU+vv/ptKYufG50eCMBenezZRiuwhxHUdOT4gS3Eid//FvxWcjmAm/EFdpPj9NJL4rydwgYyOYQg==
X-Received: by 2002:a1c:e257:: with SMTP id z84mr5153684wmg.91.1584019901376;
        Thu, 12 Mar 2020 06:31:41 -0700 (PDT)
Received: from bender.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id m21sm12242885wmi.27.2020.03.12.06.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 06:31:40 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     broonie@kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-spi@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 7/9] spi: meson-spicc: adapt burst handling for G12A support
Date:   Thu, 12 Mar 2020 14:31:29 +0100
Message-Id: <20200312133131.26430-8-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200312133131.26430-1-narmstrong@baylibre.com>
References: <20200312133131.26430-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The G12A SPICC controller variant has a different FIFO size and doesn't
handle the RX Half interrupt the same way as GXL & AXG variants.

Thus simplify the burst management and take in account a variable FIFO
size.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
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
2.22.0

