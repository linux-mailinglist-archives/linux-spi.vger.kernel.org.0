Return-Path: <linux-spi+bounces-8690-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8613AAE1C3C
	for <lists+linux-spi@lfdr.de>; Fri, 20 Jun 2025 15:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CA354A37BB
	for <lists+linux-spi@lfdr.de>; Fri, 20 Jun 2025 13:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F90728F501;
	Fri, 20 Jun 2025 13:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="teoIhE3b"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D2F28A71B;
	Fri, 20 Jun 2025 13:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750426197; cv=none; b=ZFU6TAR013sBAIeZwrnXeoqRBMhpXC2fyTJpUd0/qd9VMv84Z05SkdNdSPrYFo9pdsjTcordzQv27N3rZszXzc9p7E5vMMr+MFBf1Ne1miW6oYyKgKwipydgjrR67bPibhZOvacgDtL3IuhtK70/8SkQRDFye9cmIjETtnVP9/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750426197; c=relaxed/simple;
	bh=oWZq8aHxoc/AYd0TeBWtl/V2VXdCuqI5kEwoI43IORQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F3iTfos0D+5Z4oS7/35e8GfxRe+XcKxUqP2JFB0TxSSUx6wE5lzA/ehfc0pZKEa5e0dP32k3cHT/WUex8cOjG3Oy7l1n+xuLDM1JiDGANRVhKkD6HEYjRCAuLbZkSYGXhm9FJpE9wbuv+XjQJbdrMVSUeGKIn+afUZUrcroaX2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=teoIhE3b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA05EC4CEEE;
	Fri, 20 Jun 2025 13:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750426197;
	bh=oWZq8aHxoc/AYd0TeBWtl/V2VXdCuqI5kEwoI43IORQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=teoIhE3b69B20cXfAnxZDTU8IeYgJQqBp5sv3+i3ikg53kah4GZrT7tfidWxFXDMy
	 8xbhaMug9gurh0D2cNPJNQCI/VAh9BvzpRUSU903ZveVUhU6kkBQcNAXPN4VPUca5a
	 AykcwGI6fc0Pprk7MQyvmcnkaHtaTcfz0Hkn5IYonPuZZtzohQdcE+vbsXv0vZQFMu
	 ac/Djz+Zq8IKs2wbpq9x8qEbpZAY8GNpdaNg2KD5pSNSkaB5p7arg5HxcZeDj4fl3g
	 REWv+NoW11Z8TkWGnCstejqZsQiJD/1O3fsfJJa6u/5H59A2jW+SlVPGRgFMWtmlcb
	 aE79GU8NGCtFQ==
From: Conor Dooley <conor@kernel.org>
To: linux-spi@vger.kernel.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Mark Brown <broonie@kernel.org>,
	linux-kernel@vger.kernel.org,
	Cyril Jean <cyril.jean@microchip.com>
Subject: [PATCH v2 3/3] spi: microchip-core-qspi: Add regular transfers
Date: Fri, 20 Jun 2025 14:28:26 +0100
Message-ID: <20250620-splice-shelter-310771564886@spud>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250620-finer-yoyo-0bcae988a299@spud>
References: <20250620-finer-yoyo-0bcae988a299@spud>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9361; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=B/q2ukzJYNYor7gOpnDgWbzzJt0rZvSzVJ1H4vtiFaw=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDBmhiT+aGD79Yf3you3GoyaJoA1PCzbuklkWL3vi/xSby P/yocsbOkpZGMQ4GGTFFFkSb/e1SK3/47LDuectzBxWJpAhDFycAjCRawGMDHNFNedVPbJ7l76u zfPQoa4QCeOZB7U2SjsKvDjDILNFT5zhv3tHhseln8+tfTRSTsw4s0LZasbOScue6C13uqmkHmR vygcA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Cyril Jean <cyril.jean@microchip.com>

The driver for CoreQSPI only supports memory operations at present, so
add support for regular transfers so that the SD card slot and ADC on
the BeagleV Fire can be used.

Signed-off-by: Cyril Jean <cyril.jean@microchip.com>
Co-developed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/spi/spi-microchip-core-qspi.c | 217 +++++++++++++++++++++++---
 1 file changed, 199 insertions(+), 18 deletions(-)

diff --git a/drivers/spi/spi-microchip-core-qspi.c b/drivers/spi/spi-microchip-core-qspi.c
index 67ff5f8aa84d0..d13a9b755c7f8 100644
--- a/drivers/spi/spi-microchip-core-qspi.c
+++ b/drivers/spi/spi-microchip-core-qspi.c
@@ -222,6 +222,87 @@ static inline void mchp_coreqspi_write_op(struct mchp_coreqspi *qspi)
 	}
 }
 
+static inline void mchp_coreqspi_write_read_op(struct mchp_coreqspi *qspi)
+{
+	u32 control, data;
+
+	qspi->rx_len = qspi->tx_len;
+
+	control = readl_relaxed(qspi->regs + REG_CONTROL);
+	control |= CONTROL_FLAGSX4;
+	writel_relaxed(control, qspi->regs + REG_CONTROL);
+
+	while (qspi->tx_len >= 4) {
+		while (readl_relaxed(qspi->regs + REG_STATUS) & STATUS_TXFIFOFULL)
+			;
+
+		data = qspi->txbuf ? *((u32 *)qspi->txbuf) : 0xaa;
+		if (qspi->txbuf)
+			qspi->txbuf += 4;
+		qspi->tx_len -= 4;
+		writel_relaxed(data, qspi->regs + REG_X4_TX_DATA);
+
+		/*
+		 * The rx FIFO is twice the size of the tx FIFO, so there is
+		 * no requirement to block transmission if receive data is not
+		 * ready, and it is fine to let the tx FIFO completely fill
+		 * without reading anything from the rx FIFO. Once the tx FIFO
+		 * has been filled and becomes non-full due to a transmission
+		 * occurring there will always be something to receive.
+		 * IOW, this is safe as TX_FIFO_SIZE + 4 < 2 * TX_FIFO_SIZE
+		 */
+		if (qspi->rx_len >= 4) {
+			if (readl_relaxed(qspi->regs + REG_STATUS) & STATUS_RXAVAILABLE) {
+				data = readl_relaxed(qspi->regs + REG_X4_RX_DATA);
+				*(u32 *)qspi->rxbuf = data;
+				qspi->rxbuf += 4;
+				qspi->rx_len -= 4;
+			}
+		}
+	}
+
+	/*
+	 * Since transmission is not being blocked by clearing the rx FIFO,
+	 * loop here until all received data "leaked" by the loop above has
+	 * been dealt with.
+	 */
+	while (qspi->rx_len >= 4) {
+		while (readl_relaxed(qspi->regs + REG_STATUS) & STATUS_RXFIFOEMPTY)
+			;
+		data = readl_relaxed(qspi->regs + REG_X4_RX_DATA);
+		*(u32 *)qspi->rxbuf = data;
+		qspi->rxbuf += 4;
+		qspi->rx_len -= 4;
+	}
+
+	/*
+	 * Since rx_len and tx_len must be < 4 bytes at this point, there's no
+	 * concern about overflowing the rx or tx FIFOs any longer. It's
+	 * therefore safe to loop over the remainder of the transmit data before
+	 * handling the remaining receive data.
+	 */
+	if (!qspi->tx_len)
+		return;
+
+	control &= ~CONTROL_FLAGSX4;
+	writel_relaxed(control, qspi->regs + REG_CONTROL);
+
+	while (qspi->tx_len--) {
+		while (readl_relaxed(qspi->regs + REG_STATUS) & STATUS_TXFIFOFULL)
+			;
+		data = qspi->txbuf ? *qspi->txbuf : 0xaa;
+		qspi->txbuf++;
+		writel_relaxed(data, qspi->regs + REG_TX_DATA);
+	}
+
+	while (qspi->rx_len--) {
+		while (readl_relaxed(qspi->regs + REG_STATUS) & STATUS_RXFIFOEMPTY)
+			;
+		data = readl_relaxed(qspi->regs + REG_RX_DATA);
+		*qspi->rxbuf++ = (data & 0xFF);
+	}
+}
+
 static void mchp_coreqspi_enable_ints(struct mchp_coreqspi *qspi)
 {
 	u32 mask = IEN_TXDONE |
@@ -266,7 +347,7 @@ static irqreturn_t mchp_coreqspi_isr(int irq, void *dev_id)
 }
 
 static int mchp_coreqspi_setup_clock(struct mchp_coreqspi *qspi, struct spi_device *spi,
-				     const struct spi_mem_op *op)
+				     u32 max_freq)
 {
 	unsigned long clk_hz;
 	u32 control, baud_rate_val = 0;
@@ -275,11 +356,11 @@ static int mchp_coreqspi_setup_clock(struct mchp_coreqspi *qspi, struct spi_devi
 	if (!clk_hz)
 		return -EINVAL;
 
-	baud_rate_val = DIV_ROUND_UP(clk_hz, 2 * op->max_freq);
+	baud_rate_val = DIV_ROUND_UP(clk_hz, 2 * max_freq);
 	if (baud_rate_val > MAX_DIVIDER || baud_rate_val < MIN_DIVIDER) {
 		dev_err(&spi->dev,
 			"could not configure the clock for spi clock %d Hz & system clock %ld Hz\n",
-			op->max_freq, clk_hz);
+			max_freq, clk_hz);
 		return -EINVAL;
 	}
 
@@ -367,23 +448,13 @@ static inline void mchp_coreqspi_config_op(struct mchp_coreqspi *qspi, const str
 	writel_relaxed(frames, qspi->regs + REG_FRAMES);
 }
 
-static int mchp_qspi_wait_for_ready(struct spi_mem *mem)
+static int mchp_coreqspi_wait_for_ready(struct mchp_coreqspi *qspi)
 {
-	struct mchp_coreqspi *qspi = spi_controller_get_devdata
-				    (mem->spi->controller);
 	u32 status;
-	int ret;
 
-	ret = readl_poll_timeout(qspi->regs + REG_STATUS, status,
+	return readl_poll_timeout(qspi->regs + REG_STATUS, status,
 				 (status & STATUS_READY), 0,
 				 TIMEOUT_MS);
-	if (ret) {
-		dev_err(&mem->spi->dev,
-			"Timeout waiting on QSPI ready.\n");
-		return -ETIMEDOUT;
-	}
-
-	return ret;
 }
 
 static int mchp_coreqspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
@@ -396,11 +467,13 @@ static int mchp_coreqspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *o
 	int err, i;
 
 	mutex_lock(&qspi->op_lock);
-	err = mchp_qspi_wait_for_ready(mem);
-	if (err)
+	err = mchp_coreqspi_wait_for_ready(qspi);
+	if (err) {
+		dev_err(&mem->spi->dev, "Timeout waiting on QSPI ready.\n");
 		goto error;
+	}
 
-	err = mchp_coreqspi_setup_clock(qspi, mem->spi, op);
+	err = mchp_coreqspi_setup_clock(qspi, mem->spi, op->max_freq);
 	if (err)
 		goto error;
 
@@ -515,6 +588,109 @@ static const struct spi_controller_mem_caps mchp_coreqspi_mem_caps = {
 	.per_op_freq = true,
 };
 
+static int mchp_coreqspi_unprepare_message(struct spi_controller *ctlr, struct spi_message *m)
+{
+	struct mchp_coreqspi *qspi = spi_controller_get_devdata(ctlr);
+
+	/*
+	 * This delay is required for the driver to function correctly,
+	 * but no explanation has been determined for why it is required.
+	 */
+	udelay(750);
+
+	mutex_unlock(&qspi->op_lock);
+
+	return 0;
+}
+
+static int mchp_coreqspi_prepare_message(struct spi_controller *ctlr, struct spi_message *m)
+{
+	struct mchp_coreqspi *qspi = spi_controller_get_devdata(ctlr);
+	struct spi_transfer *t = NULL;
+	u32 control, frames;
+	u32 total_bytes = 0, cmd_bytes = 0, idle_cycles = 0;
+	int ret;
+	bool quad = false, dual = false;
+
+	mutex_lock(&qspi->op_lock);
+	ret = mchp_coreqspi_wait_for_ready(qspi);
+	if (ret) {
+		mutex_unlock(&qspi->op_lock);
+		dev_err(&ctlr->dev, "Timeout waiting on QSPI ready.\n");
+		return ret;
+	}
+
+	ret = mchp_coreqspi_setup_clock(qspi, m->spi, m->spi->max_speed_hz);
+	if (ret) {
+		mutex_unlock(&qspi->op_lock);
+		return ret;
+	}
+
+	control = readl_relaxed(qspi->regs + REG_CONTROL);
+	control &= ~(CONTROL_MODE12_MASK | CONTROL_MODE0);
+	writel_relaxed(control, qspi->regs + REG_CONTROL);
+
+	reinit_completion(&qspi->data_completion);
+
+	list_for_each_entry(t, &m->transfers, transfer_list) {
+		total_bytes += t->len;
+		if (!cmd_bytes && !(t->tx_buf && t->rx_buf))
+			cmd_bytes = t->len;
+		if (!t->rx_buf)
+			cmd_bytes = total_bytes;
+		if (t->tx_nbits == SPI_NBITS_QUAD || t->rx_nbits == SPI_NBITS_QUAD)
+			quad = true;
+		else if (t->tx_nbits == SPI_NBITS_DUAL || t->rx_nbits == SPI_NBITS_DUAL)
+			dual = true;
+	}
+
+	control = readl_relaxed(qspi->regs + REG_CONTROL);
+	if (quad) {
+		control |= (CONTROL_MODE0 | CONTROL_MODE12_EX_RW);
+	} else if (dual) {
+		control &= ~CONTROL_MODE0;
+		control |= CONTROL_MODE12_FULL;
+	} else {
+		control &= ~(CONTROL_MODE12_MASK | CONTROL_MODE0);
+	}
+	writel_relaxed(control, qspi->regs + REG_CONTROL);
+
+	frames = total_bytes & BYTESUPPER_MASK;
+	writel_relaxed(frames, qspi->regs + REG_FRAMESUP);
+	frames = total_bytes & BYTESLOWER_MASK;
+	frames |= cmd_bytes << FRAMES_CMDBYTES_SHIFT;
+	frames |= idle_cycles << FRAMES_IDLE_SHIFT;
+	control = readl_relaxed(qspi->regs + REG_CONTROL);
+	if (control & CONTROL_MODE12_MASK)
+		frames |= (1 << FRAMES_SHIFT);
+
+	frames |= FRAMES_FLAGWORD;
+	writel_relaxed(frames, qspi->regs + REG_FRAMES);
+
+	return 0;
+};
+
+static int mchp_coreqspi_transfer_one(struct spi_controller *ctlr, struct spi_device *spi,
+				      struct spi_transfer *t)
+{
+	struct mchp_coreqspi *qspi = spi_controller_get_devdata(ctlr);
+
+	qspi->tx_len = t->len;
+
+	if (t->tx_buf)
+		qspi->txbuf = (u8 *)t->tx_buf;
+
+	if (!t->rx_buf) {
+		mchp_coreqspi_write_op(qspi);
+	} else {
+		qspi->rxbuf = (u8 *)t->rx_buf;
+		qspi->rx_len = t->len;
+		mchp_coreqspi_write_read_op(qspi);
+	}
+
+	return 0;
+}
+
 static int mchp_coreqspi_probe(struct platform_device *pdev)
 {
 	struct spi_controller *ctlr;
@@ -563,6 +739,11 @@ static int mchp_coreqspi_probe(struct platform_device *pdev)
 			  SPI_TX_DUAL | SPI_TX_QUAD;
 	ctlr->dev.of_node = np;
 	ctlr->min_speed_hz = clk_get_rate(qspi->clk) / 30;
+	ctlr->prepare_message = mchp_coreqspi_prepare_message;
+	ctlr->unprepare_message = mchp_coreqspi_unprepare_message;
+	ctlr->transfer_one = mchp_coreqspi_transfer_one;
+	ctlr->num_chipselect = 2;
+	ctlr->use_gpio_descriptors = true;
 
 	ret = devm_spi_register_controller(&pdev->dev, ctlr);
 	if (ret)
-- 
2.45.2


