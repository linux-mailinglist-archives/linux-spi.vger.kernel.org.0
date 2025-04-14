Return-Path: <linux-spi+bounces-7565-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C3269A877E1
	for <lists+linux-spi@lfdr.de>; Mon, 14 Apr 2025 08:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F6817A7733
	for <lists+linux-spi@lfdr.de>; Mon, 14 Apr 2025 06:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7BD319D8B2;
	Mon, 14 Apr 2025 06:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eosYtut7"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2791624D2;
	Mon, 14 Apr 2025 06:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744612219; cv=none; b=VBxiR4YUN6RmTjTIJIS0yc9b2s6qdUr4/KdS+jEE061yqCQJ44EOd54O2yIiuROBMCVyHhvGfpJqrBlZxJsaT7EWlH9gYiJMZCMLtzi8T26dcPc2lb0wlyaRGPFMAv5kb/VY6plXe3SPk+QVvzG/olGqXq4gikg0v6GvMgQQqTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744612219; c=relaxed/simple;
	bh=CK7oamQ/u7YicjK4ooDvIecsdbM7b6TnJ4HdPk294E0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=pup8Rhpi+NIGg+JhwsyO+1izVp0zVOv015o4nvSUGZ01OrmkCHbDtfvsPYLjM1GHevpLDH55IZM7RfKU3VR0syzq9jzKgkopzWbZo8wqHQDB2PPUBe9R8URayDZHe2oTjQyYZDIj20vKXR5ZNddjPGbyH+UMOEq2JiYcW40RLpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eosYtut7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 167CCC4CEE2;
	Mon, 14 Apr 2025 06:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744612219;
	bh=CK7oamQ/u7YicjK4ooDvIecsdbM7b6TnJ4HdPk294E0=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=eosYtut7kZvnX9UEia962gbtjSvlvfbfQYXF3ApBpo2dvL0VE4ae7KvFlP0pXu7BH
	 zA8MrzvDIEteRb5ZMBoy19mUwMCsMbUmOEcKTJOEp7xR8qC0pLlWto9+fLXb4SM2bn
	 /EeyjgMqUK4nMNy4orI1Vq0qjMLXaf5pcHdfhaurJORUGkTauXAZs18EOv+OmuXrYx
	 z5p91eFemAyjH0lOMIMOTpIQTvyKahd9mE9BkQFNTorkKrtODeGxlI8vhsGSzvKSOP
	 GweVZfipcKSHRflXl4NKtfh/vLUpJZMkjci6WN8Zmu/x5wawsepmZNFahsauISr6dr
	 EKaBbrsu940KQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA04C3601E;
	Mon, 14 Apr 2025 06:30:18 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Mon, 14 Apr 2025 14:30:16 +0800
Subject: [PATCH v2] spi: meson-spicc: add DMA support
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250414-spi-dma-v2-1-84bbd92fa469@amlogic.com>
X-B4-Tracking: v=1; b=H4sIAHer/GcC/2XMQQ6DIBCF4auYWZcGUIx05T0aF3RAnaSIgYa0M
 dy91G2X/8vLd0BykVyCW3NAdJkSha2GvDSAq9kWx8jWBsml4h0fWNqJWW8YdlrPqudWagX1vUc
 30/uU7lPtldIrxM8JZ/Fb/40smGAttsPD9RK5xtH4Z1gIrxg8TKWULy0/7OKgAAAA
To: Mark Brown <broonie@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Sunny Luo <sunny.luo@amlogic.com>, Xianwei Zhao <xianwei.zhao@amlogic.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744612216; l=11623;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=K38dd2ROpHs/4tx+cPKZN+kqAxqsqkokJqx1gtC9UE4=;
 b=yjkWJQQx46rMxvB39CFR/EFq0onm4aWZfuR124a+5MYQMTj+Lep/QfaMIHEtj3RADwnBN9Z5v
 UVmjvqMRqSmCXqrVtI+2r9iZoPxGXMG5kDgAd9mHmOW6O2bb6JO1wWT
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=o4fDH8ZXL6xQg5h17eNzRljf6pwZHWWjqcOSsj3dW24=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20231208 with
 auth_id=107
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

From: Xianwei Zhao <xianwei.zhao@amlogic.com>

Add DMA support for spicc driver.

DMA works if the transfer meets the following conditions:
1. 64 bits per word;
2. The transfer length must be multiples of the dma_burst_len,
   and the dma_burst_len should be one of 8,7...2,
   otherwise, it will be split into several SPI bursts.

Signed-off-by: Sunny Luo <sunny.luo@amlogic.com>
Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
Changes in v2:
- Make formatting adjustments and code optimizations according to Neil's suggestions.
- Remove two special DMA trigger modes that are not fully implemented.
- Link to v1: https://lore.kernel.org/r/20250408-spi-dma-v1-1-3c38be62c09c@amlogic.com
---
 drivers/spi/spi-meson-spicc.c | 241 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 220 insertions(+), 21 deletions(-)

diff --git a/drivers/spi/spi-meson-spicc.c b/drivers/spi/spi-meson-spicc.c
index df74ad5060f8..6b9137307533 100644
--- a/drivers/spi/spi-meson-spicc.c
+++ b/drivers/spi/spi-meson-spicc.c
@@ -21,18 +21,26 @@
 #include <linux/interrupt.h>
 #include <linux/reset.h>
 #include <linux/pinctrl/consumer.h>
+#include <linux/dma-mapping.h>
 
 /*
- * The Meson SPICC controller could support DMA based transfers, but is not
- * implemented by the vendor code, and while having the registers documentation
- * it has never worked on the GXL Hardware.
- * The PIO mode is the only mode implemented, and due to badly designed HW :
- * - all transfers are cutted in 16 words burst because the FIFO hangs on
- *   TX underflow, and there is no TX "Half-Empty" interrupt, so we go by
- *   FIFO max size chunk only
- * - CS management is dumb, and goes UP between every burst, so is really a
- *   "Data Valid" signal than a Chip Select, GPIO link should be used instead
- *   to have a CS go down over the full transfer
+ * There are two modes for data transmission: PIO and DMA.
+ * When bits_per_word is 8, 16, 24, or 32, data is transferred using PIO mode.
+ * When bits_per_word is 64, DMA mode is used by default.
+ *
+ * DMA achieves a transfer with one or more SPI bursts, each SPI burst is made
+ * up of one or more DMA bursts. The DMA burst implementation mechanism is,
+ * For TX, when the number of words in TXFIFO is less than the preset
+ * reading threshold, SPICC starts a reading DMA burst, which reads the preset
+ * number of words from TX buffer, then writes them into TXFIFO.
+ * For RX, when the number of words in RXFIFO is greater than the preset
+ * writing threshold, SPICC starts a writing request burst, which reads the
+ * preset number of words from RXFIFO, then write them into RX buffer.
+ * DMA works if the transfer meets the following conditions,
+ * - 64 bits per word
+ * - The transfer length in word must be multiples of the dma_burst_len, and
+ *   the dma_burst_len should be one of 8,7...2, otherwise, it will be split
+ *   into several SPI bursts by this driver
  */
 
 #define SPICC_MAX_BURST	128
@@ -128,6 +136,23 @@
 
 #define SPICC_DWADDR	0x24	/* Write Address of DMA */
 
+#define SPICC_LD_CNTL0	0x28
+#define VSYNC_IRQ_SRC_SELECT		BIT(0)
+#define DMA_EN_SET_BY_VSYNC		BIT(2)
+#define XCH_EN_SET_BY_VSYNC		BIT(3)
+#define DMA_READ_COUNTER_EN		BIT(4)
+#define DMA_WRITE_COUNTER_EN		BIT(5)
+#define DMA_RADDR_LOAD_BY_VSYNC		BIT(6)
+#define DMA_WADDR_LOAD_BY_VSYNC		BIT(7)
+#define DMA_ADDR_LOAD_FROM_LD_ADDR	BIT(8)
+
+#define SPICC_LD_CNTL1	0x2c
+#define DMA_READ_COUNTER		GENMASK(15, 0)
+#define DMA_WRITE_COUNTER		GENMASK(31, 16)
+#define DMA_BURST_LEN_DEFAULT		8
+#define DMA_BURST_COUNT_MAX		0xffff
+#define SPI_BURST_LEN_MAX	(DMA_BURST_LEN_DEFAULT * DMA_BURST_COUNT_MAX)
+
 #define SPICC_ENH_CTL0	0x38	/* Enhanced Feature */
 #define SPICC_ENH_CLK_CS_DELAY_MASK	GENMASK(15, 0)
 #define SPICC_ENH_DATARATE_MASK		GENMASK(23, 16)
@@ -171,6 +196,9 @@ struct meson_spicc_device {
 	struct pinctrl			*pinctrl;
 	struct pinctrl_state		*pins_idle_high;
 	struct pinctrl_state		*pins_idle_low;
+	dma_addr_t			tx_dma;
+	dma_addr_t			rx_dma;
+	bool				using_dma;
 };
 
 #define pow2_clk_to_spicc(_div) container_of(_div, struct meson_spicc_device, pow2_div)
@@ -202,6 +230,148 @@ static void meson_spicc_oen_enable(struct meson_spicc_device *spicc)
 	writel_relaxed(conf, spicc->base + SPICC_ENH_CTL0);
 }
 
+static int meson_spicc_dma_map(struct meson_spicc_device *spicc,
+			       struct spi_transfer *t)
+{
+	struct device *dev = spicc->host->dev.parent;
+
+	if (!(t->tx_buf && t->rx_buf))
+		return -EINVAL;
+
+	t->tx_dma = dma_map_single(dev, (void *)t->tx_buf, t->len, DMA_TO_DEVICE);
+	if (dma_mapping_error(dev, t->tx_dma))
+		return -ENOMEM;
+
+	t->rx_dma = dma_map_single(dev, t->rx_buf, t->len, DMA_FROM_DEVICE);
+	if (dma_mapping_error(dev, t->rx_dma))
+		return -ENOMEM;
+
+	spicc->tx_dma = t->tx_dma;
+	spicc->rx_dma = t->rx_dma;
+
+	return 0;
+}
+
+static void meson_spicc_dma_unmap(struct meson_spicc_device *spicc,
+				  struct spi_transfer *t)
+{
+	struct device *dev = spicc->host->dev.parent;
+
+	if (t->tx_dma)
+		dma_unmap_single(dev, t->tx_dma, t->len, DMA_TO_DEVICE);
+	if (t->rx_dma)
+		dma_unmap_single(dev, t->rx_dma, t->len, DMA_FROM_DEVICE);
+}
+
+/*
+ * According to the remain words length, calculate a suitable spi burst length
+ * and a dma burst length for current spi burst
+ */
+static u32 meson_spicc_calc_dma_len(struct meson_spicc_device *spicc,
+				    u32 len, u32 *dma_burst_len)
+{
+	u32 i;
+
+	if (len <= spicc->data->fifo_size) {
+		*dma_burst_len = len;
+		return len;
+	}
+
+	*dma_burst_len = DMA_BURST_LEN_DEFAULT;
+
+	if (len == (SPI_BURST_LEN_MAX + 1))
+		return SPI_BURST_LEN_MAX - DMA_BURST_LEN_DEFAULT;
+
+	if (len >= SPI_BURST_LEN_MAX)
+		return SPI_BURST_LEN_MAX;
+
+	for (i = DMA_BURST_LEN_DEFAULT; i > 1; i--)
+		if ((len % i) == 0) {
+			*dma_burst_len = i;
+			return len;
+		}
+
+	i = len % DMA_BURST_LEN_DEFAULT;
+	len -= i;
+
+	if (i == 1)
+		len -= DMA_BURST_LEN_DEFAULT;
+
+	return len;
+}
+
+static void meson_spicc_setup_dma(struct meson_spicc_device *spicc)
+{
+	unsigned int len;
+	unsigned int dma_burst_len, dma_burst_count;
+	unsigned int count_en = 0;
+	unsigned int txfifo_thres = 0;
+	unsigned int read_req = 0;
+	unsigned int rxfifo_thres = 31;
+	unsigned int write_req = 0;
+	unsigned int ld_ctr1 = 0;
+
+	writel_relaxed(spicc->tx_dma, spicc->base + SPICC_DRADDR);
+	writel_relaxed(spicc->rx_dma, spicc->base + SPICC_DWADDR);
+
+	/* Set the max burst length to support a transmission with length of
+	 * no more than 1024 bytes(128 words), which must use the CS management
+	 * because of some strict timing requirements
+	 */
+	writel_bits_relaxed(SPICC_BURSTLENGTH_MASK, SPICC_BURSTLENGTH_MASK,
+			    spicc->base + SPICC_CONREG);
+
+	len = meson_spicc_calc_dma_len(spicc, spicc->xfer_remain,
+				       &dma_burst_len);
+	spicc->xfer_remain -= len;
+	dma_burst_count = DIV_ROUND_UP(len, dma_burst_len);
+	dma_burst_len--;
+
+	if (spicc->tx_dma) {
+		spicc->tx_dma += len;
+		count_en |= DMA_READ_COUNTER_EN;
+		txfifo_thres = spicc->data->fifo_size - dma_burst_len;
+		read_req = dma_burst_len;
+		ld_ctr1 |= FIELD_PREP(DMA_READ_COUNTER, dma_burst_count);
+	}
+
+	if (spicc->rx_dma) {
+		spicc->rx_dma += len;
+		count_en |= DMA_WRITE_COUNTER_EN;
+		rxfifo_thres = dma_burst_len;
+		write_req = dma_burst_len;
+		ld_ctr1 |= FIELD_PREP(DMA_WRITE_COUNTER, dma_burst_count);
+	}
+
+	writel_relaxed(count_en, spicc->base + SPICC_LD_CNTL0);
+	writel_relaxed(ld_ctr1, spicc->base + SPICC_LD_CNTL1);
+	writel_relaxed(SPICC_DMA_ENABLE
+		    | SPICC_DMA_URGENT
+		    | FIELD_PREP(SPICC_TXFIFO_THRESHOLD_MASK, txfifo_thres)
+		    | FIELD_PREP(SPICC_READ_BURST_MASK, read_req)
+		    | FIELD_PREP(SPICC_RXFIFO_THRESHOLD_MASK, rxfifo_thres)
+		    | FIELD_PREP(SPICC_WRITE_BURST_MASK, write_req),
+		    spicc->base + SPICC_DMAREG);
+}
+
+static irqreturn_t meson_spicc_dma_irq(struct meson_spicc_device *spicc)
+{
+	if (readl_relaxed(spicc->base + SPICC_DMAREG) & SPICC_DMA_ENABLE)
+		return IRQ_HANDLED;
+
+	if (spicc->xfer_remain) {
+		meson_spicc_setup_dma(spicc);
+	} else {
+		writel_bits_relaxed(SPICC_SMC, 0, spicc->base + SPICC_CONREG);
+		writel_relaxed(0, spicc->base + SPICC_INTREG);
+		writel_relaxed(0, spicc->base + SPICC_DMAREG);
+		meson_spicc_dma_unmap(spicc, spicc->xfer);
+		complete(&spicc->done);
+	}
+
+	return IRQ_HANDLED;
+}
+
 static inline bool meson_spicc_txfull(struct meson_spicc_device *spicc)
 {
 	return !!FIELD_GET(SPICC_TF,
@@ -293,6 +463,9 @@ static irqreturn_t meson_spicc_irq(int irq, void *data)
 
 	writel_bits_relaxed(SPICC_TC, SPICC_TC, spicc->base + SPICC_STATREG);
 
+	if (spicc->using_dma)
+		return meson_spicc_dma_irq(spicc);
+
 	/* Empty RX FIFO */
 	meson_spicc_rx(spicc);
 
@@ -426,9 +599,6 @@ static int meson_spicc_transfer_one(struct spi_controller *host,
 
 	meson_spicc_reset_fifo(spicc);
 
-	/* Setup burst */
-	meson_spicc_setup_burst(spicc);
-
 	/* Setup wait for completion */
 	reinit_completion(&spicc->done);
 
@@ -442,11 +612,36 @@ static int meson_spicc_transfer_one(struct spi_controller *host,
 	/* Increase it twice and add 200 ms tolerance */
 	timeout += timeout + 200;
 
-	/* Start burst */
-	writel_bits_relaxed(SPICC_XCH, SPICC_XCH, spicc->base + SPICC_CONREG);
+	if (xfer->bits_per_word == 64) {
+		int ret;
+
+		/* dma_burst_len 1 can't trigger a dma burst */
+		if (xfer->len < 16)
+			return -EINVAL;
+
+		ret = meson_spicc_dma_map(spicc, xfer);
+		if (ret) {
+			meson_spicc_dma_unmap(spicc, xfer);
+			dev_err(host->dev.parent, "dma map failed\n");
+			return ret;
+		}
+
+		spicc->using_dma = true;
+		spicc->xfer_remain = DIV_ROUND_UP(xfer->len, spicc->bytes_per_word);
+		meson_spicc_setup_dma(spicc);
+		writel_relaxed(SPICC_TE_EN, spicc->base + SPICC_INTREG);
+		writel_bits_relaxed(SPICC_SMC, SPICC_SMC, spicc->base + SPICC_CONREG);
+	} else {
+		spicc->using_dma = false;
+		/* Setup burst */
+		meson_spicc_setup_burst(spicc);
 
-	/* Enable interrupts */
-	writel_relaxed(SPICC_TC_EN, spicc->base + SPICC_INTREG);
+		/* Start burst */
+		writel_bits_relaxed(SPICC_XCH, SPICC_XCH, spicc->base + SPICC_CONREG);
+
+		/* Enable interrupts */
+		writel_relaxed(SPICC_TC_EN, spicc->base + SPICC_INTREG);
+	}
 
 	if (!wait_for_completion_timeout(&spicc->done, msecs_to_jiffies(timeout)))
 		return -ETIMEDOUT;
@@ -545,6 +740,14 @@ static int meson_spicc_setup(struct spi_device *spi)
 	if (!spi->controller_state)
 		spi->controller_state = spi_controller_get_devdata(spi->controller);
 
+	/* DMA works at 64 bits, the rest works on PIO */
+	if (spi->bits_per_word != 8 &&
+	    spi->bits_per_word != 16 &&
+	    spi->bits_per_word != 24 &&
+	    spi->bits_per_word != 32 &&
+	    spi->bits_per_word != 64)
+		return -EINVAL;
+
 	return 0;
 }
 
@@ -853,10 +1056,6 @@ static int meson_spicc_probe(struct platform_device *pdev)
 	host->num_chipselect = 4;
 	host->dev.of_node = pdev->dev.of_node;
 	host->mode_bits = SPI_CPHA | SPI_CPOL | SPI_CS_HIGH | SPI_LOOP;
-	host->bits_per_word_mask = SPI_BPW_MASK(32) |
-				   SPI_BPW_MASK(24) |
-				   SPI_BPW_MASK(16) |
-				   SPI_BPW_MASK(8);
 	host->flags = (SPI_CONTROLLER_MUST_RX | SPI_CONTROLLER_MUST_TX);
 	host->min_speed_hz = spicc->data->min_speed_hz;
 	host->max_speed_hz = spicc->data->max_speed_hz;

---
base-commit: 49807ed87851916ef655f72e9562f96355183090
change-id: 20250408-spi-dma-c499f560d295

Best regards,
-- 
Xianwei Zhao <xianwei.zhao@amlogic.com>



