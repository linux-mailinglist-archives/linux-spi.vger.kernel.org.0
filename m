Return-Path: <linux-spi+bounces-6383-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2763A1456E
	for <lists+linux-spi@lfdr.de>; Fri, 17 Jan 2025 00:21:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A1C6188BB9E
	for <lists+linux-spi@lfdr.de>; Thu, 16 Jan 2025 23:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D8C224334A;
	Thu, 16 Jan 2025 23:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Jh8CpEMO"
X-Original-To: linux-spi@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA8F1DDC02
	for <linux-spi@vger.kernel.org>; Thu, 16 Jan 2025 23:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737069698; cv=none; b=CXfJywDncuk4bQWSmycH9YoHsDl6YhSb0t9lh2uOqXK6s5DiaBVq59DXm9B3zQrRHBKsapPgr5MFmT6iKTKiht5XBh9xuL+0JHjC32Wf1FyEAnhOUSHnJB1dzOLNLLw8ygguWDnxkouwDlo4s2RHAOJi35QuZuNZeO/l6tB1F3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737069698; c=relaxed/simple;
	bh=OOK781rmzkzLoj6MaztFylLTWOfajTWMn0Kdy0HlWJY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ChQYYsDC6HGpFP9pkQrk2GvWgdgbV+YyqM+K4iGrt3t41/9N0630wwoAlF5VZDUc29nfRQ01HAAaz9yYRGnURIfrA6BKHukR5yUefz61YbJV2m8+rp8HxGCOBn+4qD0uI6MGS8eQyasMW4uWoJEIxnqBiCkfHayFNiVJeSbiM68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Jh8CpEMO; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737069694;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tR7y50rU9pbEgmCCWcpvtHmGNRcuzBMssivVLFdASTM=;
	b=Jh8CpEMOdwgu6Pnxq6Tet2VsuOjmAyePO/p+VNLWKjABgzvL3GoB5J3dnw7d+pGa15dY7k
	S5bmlvFxriK1IFnsBAEETSMU66FWKCV5JGzYlVxaZm6Wm0r/gAyWaPfX387I8VOl3zrlj3
	v0NQ8XVoezZsntJrgtUCD6hgn6XMByw=
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
Subject: [PATCH 3/7] spi: zynqmp-gqspi: Configure SPI mode dynamically
Date: Thu, 16 Jan 2025 18:21:13 -0500
Message-Id: <20250116232118.2694169-4-sean.anderson@linux.dev>
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

The SPI mode (phase /polarity) can change between spi_transfers.  In
preparation for transfer_one support, program the SPI mode on every
operation instead of once during init.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

 drivers/spi/spi-zynqmp-gqspi.c | 43 +++++++++++++++++++++++-----------
 1 file changed, 29 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index ba12adec8632..a1233897dc88 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -186,7 +186,8 @@ struct qspi_platform_data {
  * @mode:		Defines the mode in which QSPI is operating
  * @data_completion:	completion structure
  * @op_lock:		Operational lock
- * @speed_hz:          Current SPI bus clock speed in hz
+ * @speed_hz:		Current SPI bus clock speed in hz
+ * @spi_mode:		Current SPI bus mode
  * @has_tapdelay:	Used for tapdelay register available in qspi
  */
 struct zynqmp_qspi {
@@ -210,6 +211,7 @@ struct zynqmp_qspi {
 	struct completion data_completion;
 	struct mutex op_lock;
 	u32 speed_hz;
+	u32 spi_mode;
 	bool has_tapdelay;
 };
 
@@ -397,16 +399,11 @@ static int zynqmp_qspi_init_hw(struct zynqmp_qspi *xqspi)
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
@@ -547,6 +544,7 @@ static inline u32 zynqmp_qspi_selectspimode(struct zynqmp_qspi *xqspi,
  *				transfer
  * @xqspi: Pointer to the zynqmp_qspi structure
  * @req_speed_hz: Requested frequency
+ * @mode: Requested SPI mode
  *
  * Sets the operational mode of QSPI controller for the next QSPI transfer and
  * sets the requested clock frequency.
@@ -563,7 +561,8 @@ static inline u32 zynqmp_qspi_selectspimode(struct zynqmp_qspi *xqspi,
  *	by the QSPI controller the driver will set the highest or lowest
  *	frequency supported by controller.
  */
-static int zynqmp_qspi_config_op(struct zynqmp_qspi *xqspi, u32 req_speed_hz)
+static int zynqmp_qspi_config_op(struct zynqmp_qspi *xqspi, u32 req_speed_hz,
+				 u32 mode)
 {
 	ulong clk_rate;
 	u32 config_reg, baud_rate_val = 0;
@@ -589,7 +588,23 @@ static int zynqmp_qspi_config_op(struct zynqmp_qspi *xqspi, u32 req_speed_hz)
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
 
@@ -1091,7 +1106,7 @@ static int zynqmp_qspi_exec_op(struct spi_mem *mem,
 		op->dummy.buswidth, op->data.buswidth);
 
 	mutex_lock(&xqspi->op_lock);
-	zynqmp_qspi_config_op(xqspi, mem->spi->max_speed_hz);
+	zynqmp_qspi_config_op(xqspi, mem->spi->max_speed_hz, mem->spi->mode);
 	zynqmp_qspi_chipselect(mem->spi, false);
 	genfifoentry |= xqspi->genfifocs;
 	genfifoentry |= xqspi->genfifobus;
-- 
2.35.1.1320.gc452695387.dirty


