Return-Path: <linux-spi+bounces-6384-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0FC0A14572
	for <lists+linux-spi@lfdr.de>; Fri, 17 Jan 2025 00:22:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60BE23AAACF
	for <lists+linux-spi@lfdr.de>; Thu, 16 Jan 2025 23:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C019C24387D;
	Thu, 16 Jan 2025 23:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Thjwuswf"
X-Original-To: linux-spi@vger.kernel.org
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAA0236EAE
	for <linux-spi@vger.kernel.org>; Thu, 16 Jan 2025 23:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737069699; cv=none; b=fV8760g9w0ePks8n3gmaGPMreZd4bb3i0gs5qOEHdiewWVXJuqzSocVGw5Oqp7q4HhesxX2Q3QTXBi9GCpXTXKRYijoO0GceVu/4vR8eH48kx0YD5o/BwKraaZxmvHXYtEt1pT2Mtc93SnLwXbcBCbEHOge/k6lhAN5rjNSdW5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737069699; c=relaxed/simple;
	bh=cmpt93uTXNc+OJZHAOkMie/0u7D5Kgb/EnQQoR11n7Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=toLtOKHT45POZJXZBh2BSkUZs22MtJyVRBdjYK2g6UCy/HjksW49hjkpkd9BiSknQYQekKHgulssnMSPRA6SXzz/Kih7T7nY9zbQSkQ1xFIx4x8XtUrksaSKSqqLOmONPBpyCWSz/6I7bhQR7JgwSL4QqFBCtWvOQr+pmiWqwQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Thjwuswf; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737069696;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fStIbrCOb/5ColUxilUsQxP712qLdfKYYHDEiYij27w=;
	b=ThjwuswfDNPcj2UE4dP0vdjjWbWAYcdXs2jMVU1jT+42ZK8CguBj+r51yWDkZtt6SNPocY
	uq6JTjleQaOmNDEM6GilRXNXu+lpqzziHkkZ0CRwOPmgLqGihk+FvJxlzmrBqqURYVM9n5
	9TXbQ2KWJ39SCpmjBnJ0f7UclKrYQso=
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
Subject: [PATCH 4/7] spi: zynqmp-gqspi: Refactor out controller initialization
Date: Thu, 16 Jan 2025 18:21:14 -0500
Message-Id: <20250116232118.2694169-5-sean.anderson@linux.dev>
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

In preparation for having multiple SPI busses, refactor out the
controller initialization into a separate function. No functional change
intended.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

 drivers/spi/spi-zynqmp-gqspi.c | 42 +++++++++++++++++++++-------------
 1 file changed, 26 insertions(+), 16 deletions(-)

diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index a1233897dc88..d78e114e17e0 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -1253,6 +1253,29 @@ static const struct spi_controller_mem_ops zynqmp_qspi_mem_ops = {
 	.exec_op = zynqmp_qspi_exec_op,
 };
 
+static int zynqmp_qspi_register_ctlr(struct zynqmp_qspi *xqspi,
+				     struct spi_controller *ctlr)
+{
+	int ret;
+
+	if (!ctlr)
+		return 0;
+
+	ctlr->mode_bits = SPI_CPOL | SPI_CPHA | SPI_RX_DUAL | SPI_RX_QUAD |
+		SPI_TX_DUAL | SPI_TX_QUAD;
+	ctlr->max_speed_hz = xqspi->speed_hz;
+	ctlr->bits_per_word_mask = SPI_BPW_MASK(8);
+	ctlr->mem_ops = &zynqmp_qspi_mem_ops;
+	ctlr->setup = zynqmp_qspi_setup_op;
+	ctlr->auto_runtime_pm = true;
+
+	ret = devm_spi_register_controller(xqspi->dev, ctlr);
+	if (ret)
+		dev_err_probe(xqspi->dev, ret, "could not register %pOF\n",
+			      ctlr->dev.of_node);
+	return ret;
+}
+
 /**
  * zynqmp_qspi_probe - Probe method for the QSPI driver
  * @pdev:	Pointer to the platform_device structure
@@ -1329,12 +1352,8 @@ static int zynqmp_qspi_probe(struct platform_device *pdev)
 		goto clk_dis_all;
 	}
 
-	ctlr->mode_bits = SPI_CPOL | SPI_CPHA | SPI_RX_DUAL | SPI_RX_QUAD |
-		SPI_TX_DUAL | SPI_TX_QUAD;
-	ctlr->max_speed_hz = clk_get_rate(xqspi->refclk) / 2;
-	xqspi->speed_hz = ctlr->max_speed_hz;
-
 	/* QSPI controller initializations */
+	xqspi->speed_hz = clk_get_rate(xqspi->refclk) / 2;
 	ret = zynqmp_qspi_init_hw(xqspi);
 	if (ret)
 		goto clk_dis_all;
@@ -1368,18 +1387,9 @@ static int zynqmp_qspi_probe(struct platform_device *pdev)
 		ctlr->num_chipselect = num_cs;
 	}
 
-	ctlr->bits_per_word_mask = SPI_BPW_MASK(8);
-	ctlr->mem_ops = &zynqmp_qspi_mem_ops;
-	ctlr->setup = zynqmp_qspi_setup_op;
-	ctlr->bits_per_word_mask = SPI_BPW_MASK(8);
-	ctlr->dev.of_node = np;
-	ctlr->auto_runtime_pm = true;
-
-	ret = devm_spi_register_controller(&pdev->dev, ctlr);
-	if (ret) {
-		dev_err(&pdev->dev, "spi_register_controller failed\n");
+	ret = zynqmp_qspi_register_ctlr(xqspi, ctlr);
+	if (ret)
 		goto clk_dis_all;
-	}
 
 	pm_runtime_mark_last_busy(&pdev->dev);
 	pm_runtime_put_autosuspend(&pdev->dev);
-- 
2.35.1.1320.gc452695387.dirty


