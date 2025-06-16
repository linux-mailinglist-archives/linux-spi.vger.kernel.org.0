Return-Path: <linux-spi+bounces-8607-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A34BADBC91
	for <lists+linux-spi@lfdr.de>; Tue, 17 Jun 2025 00:02:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C08AD1892F7A
	for <lists+linux-spi@lfdr.de>; Mon, 16 Jun 2025 22:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CDBE225388;
	Mon, 16 Jun 2025 22:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fRpI7zM8"
X-Original-To: linux-spi@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8285A23313E
	for <linux-spi@vger.kernel.org>; Mon, 16 Jun 2025 22:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750111288; cv=none; b=TEBAAuo6p6THiAHx6BiWnUmSP1cxcnVbXeE4Woj8+xJ9JScFilDHOuf4eVm9mrluQedwFt7urid0Qwk8EWLMM8KQ8aSMAVuldA8p24bBbPyezh7DFrGGZdXheaoSauvSYkAtL1xvJrw+Tapc0W2xJ1co03rwYyOyr3Z3hPg5jn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750111288; c=relaxed/simple;
	bh=GDARaksPLKEKseFYGSFlXG8ZZvfvQwPmIQyC3rwaexU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eJW+0AET//8whJl49vy3eebz5sWFfK3PZCWNlsn3rjMy6tQ55PZh5XoIgXzN90aa3X/N9sEOi3NELY1movMh9v5ip0c8dnouo0x+JPvqJkpNMYbRqBw02j+vzLsoxqeoHSSOvHcGyrwBWnwpkW+15np3WmgmhdJ/RvQ8Fs2BSy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fRpI7zM8; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750111284;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U8s2DHgn3w9rCn5wed99fTlnLPjizNqzhROnC2hjDTA=;
	b=fRpI7zM8EJ3lvBmGn2ZK6cQPnRoS5fEUqpX4uEe/Q79CiQkoJ8ri/t072mO5lxXCYc/qbc
	3KTVhRUQHgYXwCYzio47tXfi1X9NhHR5sreoEhqfjwuviauAq0QTq/k8y7nquFpMCUJpxW
	RNJwGK6tuqfrBzMKUy133m4n6EGrudc=
From: Sean Anderson <sean.anderson@linux.dev>
To: Mark Brown <broonie@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	linux-spi@vger.kernel.org
Cc: Jinjie Ruan <ruanjinjie@huawei.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH v2 8/9] spi: zynqmp-gqspi: Support GPIO chip selects
Date: Mon, 16 Jun 2025 18:00:53 -0400
Message-Id: <20250616220054.3968946-9-sean.anderson@linux.dev>
In-Reply-To: <20250616220054.3968946-1-sean.anderson@linux.dev>
References: <20250616220054.3968946-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

GPIO chipselects use the traditional SPI API instead of the SPIMEM API.
Implement it with transfer_one and set_cs (for non-GPIO chipselects). At
the moment we only support half-duplex transfers, which is good enough
to access SPI flashes.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

Changes in v2:
- Use ->buses instead of an upper/lower split

 drivers/spi/spi-zynqmp-gqspi.c | 93 ++++++++++++++++++++++++++++++----
 1 file changed, 84 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index b36159dbaff0..87d375fae653 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -499,6 +499,15 @@ static void zynqmp_qspi_chipselect(struct spi_device *qspi, bool is_high)
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
@@ -1197,6 +1206,73 @@ static int zynqmp_qspi_exec_op(struct spi_mem *mem,
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
+		xqspi->genfifobus =
+			FIELD_PREP(GQSPI_GENFIFO_BUS_MASK, spi->buses);
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
+	if (!wait_for_completion_timeout(&xqspi->data_completion, timeout))
+		return -ETIMEDOUT;
+	return 0;
+}
+
 static const struct dev_pm_ops zynqmp_qspi_dev_pm_ops = {
 	SET_RUNTIME_PM_OPS(zynqmp_runtime_suspend,
 			   zynqmp_runtime_resume, NULL)
@@ -1316,27 +1392,26 @@ static int zynqmp_qspi_probe(struct platform_device *pdev)
 	if (ret)
 		goto clk_dis_all;
 
+	ctlr->max_native_cs = 2;
 	ret = of_property_read_u32(np, "num-cs", &num_cs);
-	if (ret < 0) {
+	if (ret < 0)
 		ctlr->num_chipselect = GQSPI_DEFAULT_NUM_CS;
-	} else if (num_cs > GQSPI_MAX_NUM_CS) {
-		ret = -EINVAL;
-		dev_err(&pdev->dev, "only %d chip selects are available\n",
-			GQSPI_MAX_NUM_CS);
-		goto clk_dis_all;
-	} else {
+	else
 		ctlr->num_chipselect = num_cs;
-	}
 
 	ctlr->num_buses = 2;
-	ctlr->flags = SPI_CONTROLLER_DEFAULT_BUS_IS_CS;
+	ctlr->flags = SPI_CONTROLLER_DEFAULT_BUS_IS_CS |
+		      SPI_CONTROLLER_HALF_DUPLEX;
 	ctlr->bits_per_word_mask = SPI_BPW_MASK(8);
 	ctlr->mem_ops = &zynqmp_qspi_mem_ops;
 	ctlr->mem_caps = &zynqmp_qspi_mem_caps;
 	ctlr->setup = zynqmp_qspi_setup_op;
+	ctlr->set_cs = zynqmp_qspi_set_cs;
+	ctlr->transfer_one = zynqmp_qspi_transfer_one;
 	ctlr->bits_per_word_mask = SPI_BPW_MASK(8);
 	ctlr->dev.of_node = np;
 	ctlr->auto_runtime_pm = true;
+	ctlr->use_gpio_descriptors = true;
 
 	ret = devm_spi_register_controller(&pdev->dev, ctlr);
 	if (ret) {
-- 
2.35.1.1320.gc452695387.dirty


