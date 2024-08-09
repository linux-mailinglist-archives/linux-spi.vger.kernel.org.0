Return-Path: <linux-spi+bounces-4157-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CEAD94D7F4
	for <lists+linux-spi@lfdr.de>; Fri,  9 Aug 2024 22:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEFE31C22149
	for <lists+linux-spi@lfdr.de>; Fri,  9 Aug 2024 20:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEFF92941C;
	Fri,  9 Aug 2024 20:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ndjlo4kD"
X-Original-To: linux-spi@vger.kernel.org
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9316D33D1
	for <linux-spi@vger.kernel.org>; Fri,  9 Aug 2024 20:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723234548; cv=none; b=mcDP15kEx3w9RZRctmquMi7kB9wrxBSnpSEDQsofuHkAbWlgcmph9wnGbggWf+ov76nMe4VIb5CEZuYiMxNTRnkend+NY2SeUXnhZLvR/XJnGd6OQCOzQTFXEPNocokXthHP3Utf1ti93hkVUKukkoZEkRTGuF0ACOlaASqdLX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723234548; c=relaxed/simple;
	bh=Q94hflshZwPlN9gWDzrp3w4LNxNlq8oseCBU0cc0n+Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=N7W+RJGlZ8T5thG/2P8nDtynRIjMnkFLz/pLDiX6w1Qz83j+VtN4Jo81mpCytakSKxcI5Ftb+JP9jXZTRkgwReiMyOqB7SosZKo3x0tUJjQqzaIXQ41cg6C6jxY8/QANQh002qlLPah2qRdaQqtbaT/ujleciyxDUitBV7/AmSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ndjlo4kD; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723234544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fo+3VJ+o4t+MrmdGWaJA4KhyUwcpEZuL9fWevaCmTQE=;
	b=Ndjlo4kDAMLo9FRor5uyBWIAschAWNV+QRH/1UPDBgk9PfybRkZq8p4Thc8mJOpJpDf4CA
	ocQf95+HRRPUrpAykLey7+NGTGAonXJKxFJ2mYCIVd7cwjM1PmAQcnKF3mkFwDGD/i5xBR
	zJlUOlA4BeT75u7Zpd3aexqTpl7j5q8=
From: Sean Anderson <sean.anderson@linux.dev>
To: Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	Michal Simek <michal.simek@amd.com>,
	linux-kernel@vger.kernel.org,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH] spi: zynqmp-gqspi: Scale timeout by data size
Date: Fri,  9 Aug 2024 16:15:39 -0400
Message-Id: <20240809201540.3363243-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Large blocks of data time out when reading because we don't wait long
enough for the transfer to complete. Scale our timeouts based on the
amount of data we are tranferring, with a healthy dose of pessimism.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

 drivers/spi/spi-zynqmp-gqspi.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index 99524a3c9f38..558c466135a5 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -1033,6 +1033,18 @@ static int __maybe_unused zynqmp_runtime_resume(struct device *dev)
 	return 0;
 }
 
+static unsigned long zynqmp_qspi_timeout(struct zynqmp_qspi *xqspi, u8 bits,
+					 unsigned long bytes)
+{
+	unsigned long timeout;
+
+	/* Assume we are at most 2x slower than the nominal bus speed */
+	timeout = mult_frac(bytes, 2 * 8 * MSEC_PER_SEC,
+			    bits * xqspi->speed_hz);
+	/* And add 100 ms for scheduling delays */
+	return msecs_to_jiffies(timeout + 100);
+}
+
 /**
  * zynqmp_qspi_exec_op() - Initiates the QSPI transfer
  * @mem: The SPI memory
@@ -1049,6 +1061,7 @@ static int zynqmp_qspi_exec_op(struct spi_mem *mem,
 {
 	struct zynqmp_qspi *xqspi = spi_controller_get_devdata
 				    (mem->spi->controller);
+	unsigned long timeout;
 	int err = 0, i;
 	u32 genfifoentry = 0;
 	u16 opcode = op->cmd.opcode;
@@ -1077,8 +1090,10 @@ static int zynqmp_qspi_exec_op(struct spi_mem *mem,
 		zynqmp_gqspi_write(xqspi, GQSPI_IER_OFST,
 				   GQSPI_IER_GENFIFOEMPTY_MASK |
 				   GQSPI_IER_TXNOT_FULL_MASK);
-		if (!wait_for_completion_timeout
-		    (&xqspi->data_completion, msecs_to_jiffies(1000))) {
+		timeout = zynqmp_qspi_timeout(xqspi, op->cmd.buswidth,
+					      op->cmd.nbytes);
+		if (!wait_for_completion_timeout(&xqspi->data_completion,
+						 timeout)) {
 			err = -ETIMEDOUT;
 			goto return_err;
 		}
@@ -1104,8 +1119,10 @@ static int zynqmp_qspi_exec_op(struct spi_mem *mem,
 				   GQSPI_IER_TXEMPTY_MASK |
 				   GQSPI_IER_GENFIFOEMPTY_MASK |
 				   GQSPI_IER_TXNOT_FULL_MASK);
-		if (!wait_for_completion_timeout
-		    (&xqspi->data_completion, msecs_to_jiffies(1000))) {
+		timeout = zynqmp_qspi_timeout(xqspi, op->addr.buswidth,
+					      op->addr.nbytes);
+		if (!wait_for_completion_timeout(&xqspi->data_completion,
+						 timeout)) {
 			err = -ETIMEDOUT;
 			goto return_err;
 		}
@@ -1173,8 +1190,9 @@ static int zynqmp_qspi_exec_op(struct spi_mem *mem,
 						   GQSPI_IER_RXEMPTY_MASK);
 			}
 		}
-		if (!wait_for_completion_timeout
-		    (&xqspi->data_completion, msecs_to_jiffies(1000)))
+		timeout = zynqmp_qspi_timeout(xqspi, op->data.buswidth,
+					      op->data.nbytes);
+		if (!wait_for_completion_timeout(&xqspi->data_completion, timeout))
 			err = -ETIMEDOUT;
 	}
 
-- 
2.35.1.1320.gc452695387.dirty


