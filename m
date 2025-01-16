Return-Path: <linux-spi+bounces-6386-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E03A14577
	for <lists+linux-spi@lfdr.de>; Fri, 17 Jan 2025 00:22:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B1E01631E2
	for <lists+linux-spi@lfdr.de>; Thu, 16 Jan 2025 23:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95BF232438;
	Thu, 16 Jan 2025 23:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FC8PcUCx"
X-Original-To: linux-spi@vger.kernel.org
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB2E241A0B
	for <linux-spi@vger.kernel.org>; Thu, 16 Jan 2025 23:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737069703; cv=none; b=HlMRRZ+Y93S5xtocQf5h39Z570+2FjtnOBG12CTYsTS8/U5ZmeDgqwzHLqUOwfGi0v6gUD94yugVHRUPs3MeFv9S7eIxOeC1SISrvTciUVZceRfI/U5h3yHwQsswgYWNl2Sf/9EE9FLj1p3p+PKvz8nwk/At9I4O9rdTFtHwQko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737069703; c=relaxed/simple;
	bh=t+jiC9zkX1Xh/vs8ZAOS/bTNB7s03aofjGiFfqcq76Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S+DKfBkUyR6EAxGgw24cU2pUgqreVr+uBq1FjY/Bf/Kf2OKdTygie35pe+I4lVWQherQTHvp+TUIlKOlamhEE57W/c+fABhpywLVIdXh5PrFv5qdkqUrzDgAMDsbkIAHTd9gP/POFlVa18d5+VNWD12otN+8VuttqQ6gqVoP6Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FC8PcUCx; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737069700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iHGW05zMsRoR73u/6yei3oxj4qrZbmDsPW4oXB+eZkU=;
	b=FC8PcUCx4FLk+kJ5dUK5PmZ4kNCi7FHBtSOZdcTd1NI9Cv+mzt3FYqh/GEDIQAJplr2LTH
	+CB0MonTZo3qbrYkTjhmYQ+MJi4fEyQvvGxfpkgZDbrZGPv7+x6WldnxUDrN/3AQR2rY+B
	g9rKRJZXgpZvbq+Te/7nPRvzt3Y89cM=
From: Sean Anderson <sean.anderson@linux.dev>
To: Mark Brown <broonie@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	linux-spi@vger.kernel.org
Cc: Jinjie Ruan <ruanjinjie@huawei.com>,
	linux-arm-kernel@lists.infradead.org,
	Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
	linux-kernel@vger.kernel.org,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH 6/7] spi: zynqmp-gqspi: Support GPIO chip selects
Date: Thu, 16 Jan 2025 18:21:16 -0500
Message-Id: <20250116232118.2694169-7-sean.anderson@linux.dev>
In-Reply-To: <20250116232118.2694169-1-sean.anderson@linux.dev>
References: <20250116232118.2694169-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

GPIO chipselects use the traditional SPU API instead of the SPIMEM API.
Implement it with transfer_one and set_cs (for non-GPIO chipselects). At
the moment we only support half-duplex transfers, which is good enough
to access SPI flashes.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

 drivers/spi/spi-zynqmp-gqspi.c | 83 ++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index 9823d710c4d6..efd01e06b77a 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -528,6 +528,15 @@ static void zynqmp_qspi_chipselect(struct spi_device *qspi, bool is_high)
 		dev_err(xqspi->dev, "Chip select timed out\n");
 }
 
+static void zynqmp_qspi_set_cs(struct spi_device *qspi, bool is_high)
+{
+	struct zynqmp_qspi *xqspi = spi_controller_get_devdata(qspi->controller);
+
+	mutex_lock(&xqspi->op_lock);
+	zynqmp_qspi_chipselect(qspi, is_high);
+	mutex_unlock(&xqspi->op_lock);
+}
+
 /**
  * zynqmp_qspi_selectspimode - Selects SPI mode - x1 or x2 or x4.
  * @xqspi:	xqspi is a pointer to the GQSPI instance
@@ -1271,6 +1280,75 @@ static int zynqmp_qspi_exec_op(struct spi_mem *mem,
 	return err;
 }
 
+static int zynqmp_qspi_transfer_one(struct spi_controller *ctlr,
+				    struct spi_device *spi,
+				    struct spi_transfer *transfer)
+{
+	struct zynqmp_qspi *xqspi = spi_controller_get_devdata(ctlr);
+	unsigned long timeout;
+	u32 genfifoentry;
+	u32 mask = 0;
+	int ret;
+
+	dev_dbg(xqspi->dev, "xfer %u/%u %u\n", transfer->tx_nbits,
+		transfer->rx_nbits, transfer->len);
+
+	if (transfer->tx_nbits && transfer->rx_nbits)
+		return -EOPNOTSUPP;
+
+	guard(mutex)(&xqspi->op_lock);
+	zynqmp_qspi_config_op(xqspi, transfer->speed_hz, spi->mode);
+	if (spi_get_csgpiod(spi, 0)) {
+		if (ctlr == xqspi->lower) {
+			xqspi->genfifobus = GQSPI_GENFIFO_BUS_LOWER;
+		} else {
+			WARN_ON_ONCE(ctlr != xqspi->upper);
+			xqspi->genfifobus = GQSPI_GENFIFO_BUS_UPPER;
+		}
+		xqspi->genfifocs = 0;
+	}
+	genfifoentry = xqspi->genfifocs | xqspi->genfifobus;
+
+	reinit_completion(&xqspi->data_completion);
+	if (transfer->tx_nbits) {
+		xqspi->txbuf = transfer->tx_buf;
+		xqspi->rxbuf = NULL;
+		xqspi->bytes_to_transfer = transfer->len;
+		xqspi->bytes_to_receive = 0;
+		zynqmp_qspi_write_op(xqspi, transfer->tx_nbits, genfifoentry);
+		mask = GQSPI_IER_TXEMPTY_MASK | GQSPI_IER_GENFIFOEMPTY_MASK |
+		       GQSPI_IER_TXNOT_FULL_MASK;
+		timeout = zynqmp_qspi_timeout(xqspi, transfer->tx_nbits,
+					      transfer->len);
+	} else {
+		xqspi->txbuf = NULL;
+		xqspi->rxbuf = transfer->rx_buf;
+		xqspi->bytes_to_transfer = 0;
+		xqspi->bytes_to_receive = transfer->len;
+		ret = zynqmp_qspi_read_op(xqspi, transfer->rx_nbits,
+					  genfifoentry);
+		if (ret)
+			return ret;
+
+		if (xqspi->mode != GQSPI_MODE_DMA)
+			mask = GQSPI_IER_GENFIFOEMPTY_MASK |
+			       GQSPI_IER_RXNEMPTY_MASK | GQSPI_IER_RXEMPTY_MASK;
+		timeout = zynqmp_qspi_timeout(xqspi, transfer->rx_nbits,
+					      transfer->len);
+	}
+
+	zynqmp_gqspi_write(xqspi, GQSPI_CONFIG_OFST,
+			   zynqmp_gqspi_read(xqspi, GQSPI_CONFIG_OFST) |
+			   GQSPI_CFG_START_GEN_FIFO_MASK);
+	if (mask)
+		zynqmp_gqspi_write(xqspi, GQSPI_IER_OFST, mask);
+	else
+		zynqmp_gqspi_write(xqspi, GQSPI_QSPIDMA_DST_I_EN_OFST,
+				   GQSPI_QSPIDMA_DST_I_EN_DONE_MASK);
+
+	return zynqmp_qspi_wait(xqspi, timeout);
+}
+
 static const struct dev_pm_ops zynqmp_qspi_dev_pm_ops = {
 	SET_RUNTIME_PM_OPS(zynqmp_runtime_suspend,
 			   zynqmp_runtime_resume, NULL)
@@ -1318,6 +1396,7 @@ zynqmp_qspi_alloc_split(struct zynqmp_qspi *xqspi, const char *name)
 		return ERR_PTR(-ENOMEM);
 
 	ctlr->dev.of_node = np;
+	ctlr->max_native_cs = 1;
 	if (of_property_read_u32(np, "num-cs", &num_cs))
 		ctlr->num_chipselect = GQSPI_DEFAULT_NUM_CS;
 	else
@@ -1337,11 +1416,15 @@ static int zynqmp_qspi_register_ctlr(struct zynqmp_qspi *xqspi,
 	spi_controller_set_devdata(ctlr, xqspi);
 	ctlr->mode_bits = SPI_CPOL | SPI_CPHA | SPI_RX_DUAL | SPI_RX_QUAD |
 		SPI_TX_DUAL | SPI_TX_QUAD;
+	ctlr->flags = SPI_CONTROLLER_HALF_DUPLEX;
 	ctlr->max_speed_hz = xqspi->speed_hz;
 	ctlr->bits_per_word_mask = SPI_BPW_MASK(8);
 	ctlr->mem_ops = &zynqmp_qspi_mem_ops;
 	ctlr->setup = zynqmp_qspi_setup_op;
+	ctlr->set_cs = zynqmp_qspi_set_cs;
+	ctlr->transfer_one = zynqmp_qspi_transfer_one;
 	ctlr->auto_runtime_pm = true;
+	ctlr->use_gpio_descriptors = true;
 
 	ret = devm_spi_register_controller(xqspi->dev, ctlr);
 	if (ret)
-- 
2.35.1.1320.gc452695387.dirty


