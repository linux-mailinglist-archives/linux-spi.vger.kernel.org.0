Return-Path: <linux-spi+bounces-8606-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49047ADBC94
	for <lists+linux-spi@lfdr.de>; Tue, 17 Jun 2025 00:03:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B8E13A8E74
	for <lists+linux-spi@lfdr.de>; Mon, 16 Jun 2025 22:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6803238C36;
	Mon, 16 Jun 2025 22:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vpEA3/2l"
X-Original-To: linux-spi@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3848237176
	for <linux-spi@vger.kernel.org>; Mon, 16 Jun 2025 22:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750111286; cv=none; b=AefxRzppCuIXnoqUyKjvhIh2NQdlYri/6JcQh8jpQSX5zLazgh1z/h2PXOJYDRhKJ8khMG0ZFl2rUtBpxV5j2bpbIjrGcGjBF/zdaStlfttD13MjEss6esUgl3ReH3Fca8tXZ0sfD8EC+Ref/UpFvr/S46sYEhNpnkVHfzkOJGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750111286; c=relaxed/simple;
	bh=Wraj1hZ3EBxKe2cyb3q1iqv3qisL2xc0bmwF6cli6Hk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KFGya1Y7Xer1etG+XrDe4kfTn7NeOKjJRSfT0Yf2zwEB5gIxz+SFutsbilqn/aVFtmlbz1LQXKxJcd/Xrbu9+qXcdqfaG7ur6yCHYCXzvvao+Hwiuc3B+D4fPpeCLBOvlSSg9gixo45WAI5o8xgWPCCcV2xLeGw5T5P/NUXeuvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vpEA3/2l; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750111283;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NGOH8Yvcz0WgyTH+Nb2rF8MG3xwZ18CiFbl2INC4Pwc=;
	b=vpEA3/2lKQLW1KlQy0fAkRGHmm41rLVtpUYTk/FtQEClVaZDGiw59+7LhF+lpXDM4UzepZ
	fb4cLEp2SSBV37UlS50QI9aUP5JoKCOYg8XHGzaXk3p8SXV1m7VcZ9qcay0zX7+/bT9NfA
	vwKxcXFL30SFCIuAsagUKLA+gFHt3mw=
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
Subject: [PATCH v2 7/9] spi: zynqmp-gqspi: Configure SPI mode dynamically
Date: Mon, 16 Jun 2025 18:00:52 -0400
Message-Id: <20250616220054.3968946-8-sean.anderson@linux.dev>
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

The SPI mode (phase/polarity) can change between spi_transfers. In
preparation for transfer_one support, program the SPI mode on every
operation instead of once during init.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

(no changes since v1)

 drivers/spi/spi-zynqmp-gqspi.c | 43 +++++++++++++++++++++++-----------
 1 file changed, 29 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index a17e77dc4e27..b36159dbaff0 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -184,7 +184,8 @@ struct qspi_platform_data {
  * @mode:		Defines the mode in which QSPI is operating
  * @data_completion:	completion structure
  * @op_lock:		Operational lock
- * @speed_hz:          Current SPI bus clock speed in hz
+ * @speed_hz:		Current SPI bus clock speed in hz
+ * @spi_mode:		Current SPI bus mode
  * @has_tapdelay:	Used for tapdelay register available in qspi
  */
 struct zynqmp_qspi {
@@ -207,6 +208,7 @@ struct zynqmp_qspi {
 	struct completion data_completion;
 	struct mutex op_lock;
 	u32 speed_hz;
+	u32 spi_mode;
 	bool has_tapdelay;
 };
 
@@ -387,16 +389,11 @@ static void zynqmp_qspi_init_hw(struct zynqmp_qspi *xqspi)
 	config_reg |= GQSPI_CFG_WP_HOLD_MASK;
 	/* Clear pre-scalar by default */
 	config_reg &= ~GQSPI_CFG_BAUD_RATE_DIV_MASK;
-	/* Set CPHA */
-	if (xqspi->ctlr->mode_bits & SPI_CPHA)
-		config_reg |= GQSPI_CFG_CLK_PHA_MASK;
-	else
-		config_reg &= ~GQSPI_CFG_CLK_PHA_MASK;
-	/* Set CPOL */
-	if (xqspi->ctlr->mode_bits & SPI_CPOL)
-		config_reg |= GQSPI_CFG_CLK_POL_MASK;
-	else
-		config_reg &= ~GQSPI_CFG_CLK_POL_MASK;
+
+	/* Set default mode */
+	xqspi->spi_mode = SPI_MODE_3;
+	config_reg |= GQSPI_CFG_CLK_PHA_MASK;
+	config_reg |= GQSPI_CFG_CLK_POL_MASK;
 
 	/* Set the clock frequency */
 	clk_rate = clk_get_rate(xqspi->refclk);
@@ -535,6 +532,7 @@ static inline u32 zynqmp_qspi_selectspimode(struct zynqmp_qspi *xqspi,
  *				transfer
  * @xqspi: Pointer to the zynqmp_qspi structure
  * @req_speed_hz: Requested frequency
+ * @mode: Requested SPI mode
  *
  * Sets the operational mode of QSPI controller for the next QSPI transfer and
  * sets the requested clock frequency.
@@ -551,7 +549,8 @@ static inline u32 zynqmp_qspi_selectspimode(struct zynqmp_qspi *xqspi,
  *	by the QSPI controller the driver will set the highest or lowest
  *	frequency supported by controller.
  */
-static int zynqmp_qspi_config_op(struct zynqmp_qspi *xqspi, u32 req_speed_hz)
+static int zynqmp_qspi_config_op(struct zynqmp_qspi *xqspi, u32 req_speed_hz,
+				 u32 mode)
 {
 	ulong clk_rate;
 	u32 config_reg, baud_rate_val = 0;
@@ -577,7 +576,23 @@ static int zynqmp_qspi_config_op(struct zynqmp_qspi *xqspi, u32 req_speed_hz)
 		zynqmp_qspi_set_tapdelay(xqspi, baud_rate_val);
 	}
 
-	dev_dbg(xqspi->dev, "config speed %u\n", req_speed_hz);
+	mode &= SPI_MODE_X_MASK;
+	if (xqspi->spi_mode != mode) {
+		xqspi->spi_mode = mode;
+
+		config_reg = zynqmp_gqspi_read(xqspi, GQSPI_CONFIG_OFST);
+		if (mode & SPI_CPHA)
+			config_reg |= GQSPI_CFG_CLK_PHA_MASK;
+		else
+			config_reg &= ~GQSPI_CFG_CLK_PHA_MASK;
+		if (mode & SPI_CPOL)
+			config_reg |= GQSPI_CFG_CLK_POL_MASK;
+		else
+			config_reg &= ~GQSPI_CFG_CLK_POL_MASK;
+		zynqmp_gqspi_write(xqspi, GQSPI_CONFIG_OFST, config_reg);
+	}
+
+	dev_dbg(xqspi->dev, "config speed %u mode %x\n", req_speed_hz, mode);
 	return 0;
 }
 
@@ -1050,7 +1065,7 @@ static int zynqmp_qspi_exec_op(struct spi_mem *mem,
 	u64 opaddr;
 
 	mutex_lock(&xqspi->op_lock);
-	zynqmp_qspi_config_op(xqspi, op->max_freq);
+	zynqmp_qspi_config_op(xqspi, op->max_freq, mem->spi->mode);
 	zynqmp_qspi_chipselect(mem->spi, false);
 	genfifoentry |= xqspi->genfifocs;
 	genfifoentry |= xqspi->genfifobus;
-- 
2.35.1.1320.gc452695387.dirty


