Return-Path: <linux-spi+bounces-3386-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5908990575D
	for <lists+linux-spi@lfdr.de>; Wed, 12 Jun 2024 17:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEBAD28A164
	for <lists+linux-spi@lfdr.de>; Wed, 12 Jun 2024 15:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E307B181320;
	Wed, 12 Jun 2024 15:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q4LeZg6Z"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE8B18131B;
	Wed, 12 Jun 2024 15:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718207337; cv=none; b=UphI5VWIQE/L5F/rcxuGYQZsOwR6XAONUzbmfqgXPkN6vJ2db69j4UMtwnoiS8grB3vVh8/cZZijY+NSO8HmpoV6InJBacc10ASZk9m1J33QfevRpSkNtXMbnHYhsdHqFpu552TwRUxQ4i41momTT/J3JYU1mqW/6E0pWwz8cbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718207337; c=relaxed/simple;
	bh=Q80LEcSfWLwrGQtxBO719jXJBFBRKXkIm/AvzbhGOt4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OyccBOCFwJ9be/PLl4NvrJhXfMRMpYR7ZwGhbPWsFUXRcz+364qb7Y4dPLv69LBcfVR5FxT0Wh0xFNW2RGQ+Ib5stTrNuFCqfhmL8dcKQxQMonk85jv2FNS1EehKxipG7aMlpl90vyVWsjZCQn2XgIKxdnlJJb7G2WsyltF1SJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q4LeZg6Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64BC6C116B1;
	Wed, 12 Jun 2024 15:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718207337;
	bh=Q80LEcSfWLwrGQtxBO719jXJBFBRKXkIm/AvzbhGOt4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q4LeZg6ZmpiDECtGr1npo3EJ+dB9xzOEoODDtCwMNjkwRHgnNKJ9dW1Zq8cV2R2yB
	 ZHOexrEkJ9NTn37oh6yuvbPoAsUchxEDVLcvRIqkxR9TgjZj6Twty3W4K7yl3SZGbY
	 3EsZGEGxYhw4D/891sogIQ//LftabpA3PpL89wi0NyCBQWRvB2OE8llEFxCgvDXL9P
	 S8av/vlaJo5lnBGWYF+v+DwyaLW196usIsp4lU6iUHYSqCSVCHpxACuKnSJ3hmbA/C
	 k/VhFW6jmcpB+nq5N1N1DBojnS71/JGcsGIy+ocmPwCvqZOpKo1Dy7TuYImrLU3oxK
	 7IqxuNrAm7PyA==
From: Conor Dooley <conor@kernel.org>
To: linux-mmc@vger.kernel.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	cyril.jean@microchip.com,
	Mark Brown <broonie@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-spi@vger.kernel.org
Subject: [RFC v1 2/3] spi: microchip-core-qspi: Add regular transfers
Date: Wed, 12 Jun 2024 16:48:32 +0100
Message-ID: <20240612-uphold-dinner-a47b4c44be18@spud>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240612-brigade-shell-1f626e7e592f@spud>
References: <20240612-brigade-shell-1f626e7e592f@spud>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8823; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=uI9WGvVZLyn7qdrTfj6zoMBWM0en+Fn3mbBJbuvgJdI=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDGmZh329aqKFtOr3zPFcd03R+MeXtvUMzO1yyU9eaYouW OHIx2zSUcrCIMbBICumyJJ4u69Fav0flx3OPW9h5rAygQxh4OIUgImofmf4w7tuWuKHDeU1M5Sz tyv+vPU09swr+8By+45rWcLzfuyuKGH4XzrHrtKSI6pL76zc4xxjzqD/CUXb7rx9aLCdQajyf/k JNgA=
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
 drivers/spi/spi-microchip-core-qspi.c | 223 +++++++++++++++++++++++++-
 1 file changed, 221 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-microchip-core-qspi.c b/drivers/spi/spi-microchip-core-qspi.c
index 09f16471c537..1b23a38c155c 100644
--- a/drivers/spi/spi-microchip-core-qspi.c
+++ b/drivers/spi/spi-microchip-core-qspi.c
@@ -222,6 +222,86 @@ static inline void mchp_coreqspi_write_op(struct mchp_coreqspi *qspi, bool word)
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
+		data = *(u32 *)qspi->txbuf;
+		qspi->txbuf += 4;
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
+		data = *qspi->txbuf++;
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
+
 static void mchp_coreqspi_enable_ints(struct mchp_coreqspi *qspi)
 {
 	u32 mask = IEN_TXDONE |
@@ -366,7 +446,7 @@ static inline void mchp_coreqspi_config_op(struct mchp_coreqspi *qspi, const str
 	writel_relaxed(frames, qspi->regs + REG_FRAMES);
 }
 
-static int mchp_qspi_wait_for_ready(struct spi_mem *mem)
+static int mchp_coreqspi_wait_for_ready(struct spi_mem *mem)
 {
 	struct mchp_coreqspi *qspi = spi_controller_get_devdata
 				    (mem->spi->controller);
@@ -395,7 +475,7 @@ static int mchp_coreqspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *o
 	int err, i;
 
 	mutex_lock(&qspi->op_lock);
-	err = mchp_qspi_wait_for_ready(mem);
+	err = mchp_coreqspi_wait_for_ready(mem);
 	if (err)
 		goto error;
 
@@ -498,6 +578,142 @@ static const struct spi_controller_mem_ops mchp_coreqspi_mem_ops = {
 	.exec_op = mchp_coreqspi_exec_op,
 };
 
+
+static void mchp_coreqspi_activate_cs(struct spi_device *spi)
+{
+	if (spi_get_csgpiod(spi, 0))
+		gpiod_set_value(spi_get_csgpiod(spi, 0), 1);
+}
+
+static void mchp_coreqspi_deactivate_cs(struct spi_device *spi)
+{
+	if (spi_get_csgpiod(spi, 0))
+		gpiod_set_value(spi_get_csgpiod(spi, 0), 0);
+}
+
+static int mchp_coreqspi_transfer_one_message(struct spi_controller *ctlr,
+					struct spi_message *m)
+{
+	struct mchp_coreqspi *qspi = spi_controller_get_devdata(ctlr);
+	struct spi_transfer *t = NULL;
+	u32 control, frames, status;
+	u32 total_bytes = 0, cmd_bytes = 0, idle_cycles = 0;
+	int ret;
+	bool quad = false, dual = false;
+	bool cs_change = true;
+
+	mutex_lock(&qspi->op_lock);
+	ret = readl_poll_timeout(qspi->regs + REG_STATUS, status,
+				 (status & STATUS_READY), 0,
+				 TIMEOUT_MS);
+	if (ret) {
+		mutex_unlock(&qspi->op_lock);
+		dev_err(&ctlr->dev,
+			"Timeout waiting on QSPI ready.\n");
+		return -ETIMEDOUT;
+	}
+
+	ret = mchp_coreqspi_setup_clock(qspi, m->spi);
+	if (ret)
+		goto error;
+
+	control = readl_relaxed(qspi->regs + REG_CONTROL);
+	control &= ~(CONTROL_MODE12_MASK | CONTROL_MODE0);
+	writel_relaxed(control, qspi->regs + REG_CONTROL);
+
+	reinit_completion(&qspi->data_completion);
+
+	/* Check the total bytes and command bytes */
+	list_for_each_entry(t, &m->transfers, transfer_list) {
+		total_bytes += t->len;
+		if ((!cmd_bytes) && !(t->tx_buf && t->rx_buf))
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
+
+	writel_relaxed(control, qspi->regs + REG_CONTROL);
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
+	//TODO: questionable robustness if both cs_change and cs_off toggle
+	list_for_each_entry(t, &m->transfers, transfer_list) {
+		//cs_change being set means we need to re-enable
+		if (cs_change && !t->cs_off)
+			mchp_coreqspi_activate_cs(m->spi);
+		else if (cs_change) //cs_off set but we changed it after last xfer so it may be on
+			mchp_coreqspi_deactivate_cs(m->spi);
+
+		if ((t->tx_buf) && (t->rx_buf)){
+			qspi->txbuf = (u8 *)t->tx_buf;
+			qspi->rxbuf = (u8 *)t->rx_buf;
+			qspi->tx_len = t->len;
+			mchp_coreqspi_write_read_op(qspi);
+		} else if (t->tx_buf) {
+			qspi->txbuf = (u8 *)t->tx_buf;
+			qspi->tx_len = t->len;
+			mchp_coreqspi_write_op(qspi, true);
+		} else {
+			qspi->rxbuf = (u8 *)t->rx_buf;
+			qspi->rx_len = t->len;
+			mchp_coreqspi_read_op(qspi);
+		}
+
+		spi_transfer_delay_exec(t);
+
+		cs_change = t->cs_change;
+		if (cs_change) {
+			if (list_is_last(&t->transfer_list, &m->transfers)) {
+				break; //special meaning, see below
+			}
+
+			// cs_change is set, so disable between xfers
+			if (!t->cs_off)
+				mchp_coreqspi_deactivate_cs(m->spi);
+			else
+				mchp_coreqspi_activate_cs(m->spi);
+
+			spi_transfer_cs_change_delay_exec(m, t);
+		}
+	}
+
+	udelay(750);
+
+	m->actual_length = total_bytes;
+
+error:
+	if (ret != 0 || !cs_change) //special case of cs_change for last xfer, set means dont touch line state
+		mchp_coreqspi_deactivate_cs(m->spi);
+
+	m->status = ret;
+	spi_finalize_current_message(ctlr);
+	mutex_unlock(&qspi->op_lock);
+	return ret;
+}
+
 static int mchp_coreqspi_probe(struct platform_device *pdev)
 {
 	struct spi_controller *ctlr;
@@ -544,6 +760,9 @@ static int mchp_coreqspi_probe(struct platform_device *pdev)
 	ctlr->mode_bits = SPI_CPOL | SPI_CPHA | SPI_RX_DUAL | SPI_RX_QUAD |
 			  SPI_TX_DUAL | SPI_TX_QUAD;
 	ctlr->dev.of_node = np;
+	ctlr->transfer_one_message = mchp_coreqspi_transfer_one_message;
+	ctlr->num_chipselect = 2;
+	ctlr->use_gpio_descriptors = true;
 
 	ret = devm_spi_register_controller(&pdev->dev, ctlr);
 	if (ret)
-- 
2.43.0


