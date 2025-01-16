Return-Path: <linux-spi+bounces-6377-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6B8A144DD
	for <lists+linux-spi@lfdr.de>; Thu, 16 Jan 2025 23:55:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96AB37A10D0
	for <lists+linux-spi@lfdr.de>; Thu, 16 Jan 2025 22:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E707236EA5;
	Thu, 16 Jan 2025 22:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HqSjS39s"
X-Original-To: linux-spi@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BEC31DDC3A
	for <linux-spi@vger.kernel.org>; Thu, 16 Jan 2025 22:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737068142; cv=none; b=iQQ0/SvdaZFdag04yUdDyqgGK0Zxl+nR409H84/ZE+5ZP0soMcF4sx5/LY/Y13ygJtgydFAXKjareKlhRNEREudAT0gr1l43Hwp1V5UCyLyI944uUDCJxYHP5RLFuVKWlnpEhi5sM8/bs+ovxz43wly7jVxWxyTh9L6cnIAvxus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737068142; c=relaxed/simple;
	bh=eY/eaELoWrsvth7t7ZoGKiHeId+2n5EaWWrJKJ1e0gg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y8Mpfw2wCLvUOk/En1LMLETJQ57bkXpaZCv37UUHvu3OdseU9O0kvgmrfoUUsEE5VCAwtY7PpK17S8aqbyn1ZOU3wRRQ8RXgNK5QI5II4NIpNzdn1V16tRJ1S+dzekpkK5OWB+Gzbx99tllEIV4znnAzztSLBhcvBYWjhNd4HD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HqSjS39s; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737068138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vgnMG6pJBvdU2HUT93EP8LTpJb1730xDsO9aVBeLZE0=;
	b=HqSjS39sCx1/8b+P1gWd98wQX8dz5L7tEUVtHzPgZxCKdACiIywurRdbHDCUANiI67fMHq
	NWZXZI6UwmOW0/sByqg57FkK4umUM06xUhjCUna30sdmiXct32oAvCftbYnl8Xy0uygIru
	6IYiVj282sCb7U25m/QVyM+zRL9kzAY=
From: Sean Anderson <sean.anderson@linux.dev>
To: Mark Brown <broonie@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	linux-spi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	linux-arm-kernel@lists.infradead.org,
	Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH 2/5] spi: zynqmp-gqspi: Reset device in probe
Date: Thu, 16 Jan 2025 17:55:18 -0500
Message-Id: <20250116225521.2688224-3-sean.anderson@linux.dev>
In-Reply-To: <20250116225521.2688224-1-sean.anderson@linux.dev>
References: <20250116225521.2688224-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Ensure we get a clean slate (without any bootloader settings) by
resetting the device before we initialize it.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

 drivers/spi/spi-zynqmp-gqspi.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index 549a6e0c9654..7d138f45b692 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -17,6 +17,7 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/reset.h>
 #include <linux/spi/spi.h>
 #include <linux/spinlock.h>
 #include <linux/workqueue.h>
@@ -171,6 +172,7 @@ struct qspi_platform_data {
  * @regs:		Virtual address of the QSPI controller registers
  * @refclk:		Pointer to the peripheral clock
  * @pclk:		Pointer to the APB clock
+ * @reset:		Pointer to reset controller
  * @irq:		IRQ number
  * @dev:		Pointer to struct device
  * @txbuf:		Pointer to the TX buffer
@@ -193,6 +195,7 @@ struct zynqmp_qspi {
 	void __iomem *regs;
 	struct clk *refclk;
 	struct clk *pclk;
+	struct reset_control *reset;
 	int irq;
 	struct device *dev;
 	const void *txbuf;
@@ -351,10 +354,17 @@ static void zynqmp_qspi_set_tapdelay(struct zynqmp_qspi *xqspi, u32 baudrateval)
  *	- Set clock polarity and
  *	- Enable the QSPI controller
  */
-static void zynqmp_qspi_init_hw(struct zynqmp_qspi *xqspi)
+static int zynqmp_qspi_init_hw(struct zynqmp_qspi *xqspi)
 {
 	u32 config_reg, baud_rate_val = 0;
 	ulong clk_rate;
+	int ret;
+
+	ret = reset_control_reset(xqspi->reset);
+	if (ret) {
+		dev_err(xqspi->dev, "Unable to reset: %pe\n", &ret);
+		return ret;
+	}
 
 	/* Select the GQSPI mode */
 	zynqmp_gqspi_write(xqspi, GQSPI_SEL_OFST, GQSPI_SEL_MASK);
@@ -436,6 +446,8 @@ static void zynqmp_qspi_init_hw(struct zynqmp_qspi *xqspi)
 
 	/* Enable the GQSPI */
 	zynqmp_gqspi_write(xqspi, GQSPI_EN_OFST, GQSPI_EN_MASK);
+
+	return 0;
 }
 
 /**
@@ -1259,6 +1271,12 @@ static int zynqmp_qspi_probe(struct platform_device *pdev)
 	if (IS_ERR(xqspi->regs))
 		return PTR_ERR(xqspi->regs);
 
+	xqspi->reset =
+		devm_reset_control_get_optional_exclusive(&pdev->dev, NULL);
+	if (IS_ERR(xqspi->reset))
+		return dev_err_probe(dev, PTR_ERR(xqspi->reset),
+				     "could not get reset\n");
+
 	xqspi->pclk = devm_clk_get(&pdev->dev, "pclk");
 	if (IS_ERR(xqspi->pclk))
 		return dev_err_probe(dev, PTR_ERR(xqspi->pclk),
@@ -1300,7 +1318,9 @@ static int zynqmp_qspi_probe(struct platform_device *pdev)
 	xqspi->speed_hz = ctlr->max_speed_hz;
 
 	/* QSPI controller initializations */
-	zynqmp_qspi_init_hw(xqspi);
+	ret = zynqmp_qspi_init_hw(xqspi);
+	if (ret)
+		goto clk_dis_all;
 
 	xqspi->irq = platform_get_irq(pdev, 0);
 	if (xqspi->irq < 0) {
-- 
2.35.1.1320.gc452695387.dirty


