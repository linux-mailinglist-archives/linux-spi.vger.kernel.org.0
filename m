Return-Path: <linux-spi+bounces-6382-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63962A1456D
	for <lists+linux-spi@lfdr.de>; Fri, 17 Jan 2025 00:21:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CC7C163738
	for <lists+linux-spi@lfdr.de>; Thu, 16 Jan 2025 23:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4989242275;
	Thu, 16 Jan 2025 23:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OZHlBT2E"
X-Original-To: linux-spi@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCFB241A05
	for <linux-spi@vger.kernel.org>; Thu, 16 Jan 2025 23:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737069696; cv=none; b=In3Psaf+2+5B1UphTpfvkbDCxpFdnUyc2If7XkgQ5Zm1+Am79okoEYPSisOFQG2TGZUriMCjKkjCvR97pxOfYqbsNMfM9fT9za1BYmsdbT0Yd4+VP9NkG+dKqas8kxKxlgY/kRt0UMAF+2Qnv3TjqkzEPHTXr/aiv9HEJHFaKrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737069696; c=relaxed/simple;
	bh=cGARqq8IjWrrcZ6KdmSNFZSMwkTjtVepKJsEOxCEYMc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VquQ0W+9dUiwM1kfMY/gSi3k62w5uGicrv8VN3QXh+7+SF1vkYjsjpa+OAGClG62yGX0xXVdlchm25Z0qLStDxu5dcF78yY+Q+4FkdsbvzeovLDYRAbWmSPEZzlDI2VVb3CdZnmFQHvMeveGpizCh/MEApR1Wqwy20j3RAlGZ0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OZHlBT2E; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737069692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f3kAvIiPvuDbscly1USvzOsklcOMjk05ZoOBm2Yut2w=;
	b=OZHlBT2EInsgKHaSkHw4Zp/mu/U8KYfBsgR4roeno+oDlFuiQYLIY+Noe2l/rde4Wuidmb
	bL9U8Dq/8IkbRrP3mXDLK1JcJyKPvpqyhSkeg0dUGrVOwPBgNw7k8EJp91Q6LVN+uVG91h
	of0+hZ4S9RHUXh/QZ+BL20EnQoVPhQ4=
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
Subject: [PATCH 2/7] spi: zynqmp-gqspi: Pass speed/mode directly to config_op
Date: Thu, 16 Jan 2025 18:21:12 -0500
Message-Id: <20250116232118.2694169-3-sean.anderson@linux.dev>
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

In preparation for supporting transfer_one, which supplies the speed
from the spi_transfer instead of the spi_device, convert config_op to
take the speed and mode directly.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

 drivers/spi/spi-zynqmp-gqspi.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index 95eea7d75f71..ba12adec8632 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -545,8 +545,8 @@ static inline u32 zynqmp_qspi_selectspimode(struct zynqmp_qspi *xqspi,
 /**
  * zynqmp_qspi_config_op - Configure QSPI controller for specified
  *				transfer
- * @xqspi:	Pointer to the zynqmp_qspi structure
- * @qspi:	Pointer to the spi_device structure
+ * @xqspi: Pointer to the zynqmp_qspi structure
+ * @req_speed_hz: Requested frequency
  *
  * Sets the operational mode of QSPI controller for the next QSPI transfer and
  * sets the requested clock frequency.
@@ -563,13 +563,10 @@ static inline u32 zynqmp_qspi_selectspimode(struct zynqmp_qspi *xqspi,
  *	by the QSPI controller the driver will set the highest or lowest
  *	frequency supported by controller.
  */
-static int zynqmp_qspi_config_op(struct zynqmp_qspi *xqspi,
-				 struct spi_device *qspi)
+static int zynqmp_qspi_config_op(struct zynqmp_qspi *xqspi, u32 req_speed_hz)
 {
 	ulong clk_rate;
-	u32 config_reg, req_speed_hz, baud_rate_val = 0;
-
-	req_speed_hz = qspi->max_speed_hz;
+	u32 config_reg, baud_rate_val = 0;
 
 	if (xqspi->speed_hz != req_speed_hz) {
 		xqspi->speed_hz = req_speed_hz;
@@ -1094,7 +1091,7 @@ static int zynqmp_qspi_exec_op(struct spi_mem *mem,
 		op->dummy.buswidth, op->data.buswidth);
 
 	mutex_lock(&xqspi->op_lock);
-	zynqmp_qspi_config_op(xqspi, mem->spi);
+	zynqmp_qspi_config_op(xqspi, mem->spi->max_speed_hz);
 	zynqmp_qspi_chipselect(mem->spi, false);
 	genfifoentry |= xqspi->genfifocs;
 	genfifoentry |= xqspi->genfifobus;
-- 
2.35.1.1320.gc452695387.dirty


