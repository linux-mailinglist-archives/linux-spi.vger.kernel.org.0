Return-Path: <linux-spi+bounces-8605-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7A7ADBC8E
	for <lists+linux-spi@lfdr.de>; Tue, 17 Jun 2025 00:02:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7502172A95
	for <lists+linux-spi@lfdr.de>; Mon, 16 Jun 2025 22:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B21237180;
	Mon, 16 Jun 2025 22:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="udplqrxW"
X-Original-To: linux-spi@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36AD523505E
	for <linux-spi@vger.kernel.org>; Mon, 16 Jun 2025 22:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750111284; cv=none; b=I+EYNJqlmMe22TBj+fICHdjJ3fLPeusATTwp+ABD22+mzgPXMDoTmLq30/sPRhlpBph1pGBp117CbluFuerkLQqJE1BcBb1zbIpYkZPhd+lWuxbKdCITH1M8rCnyaW26eNKFVjqG1+ESEXn8YSkMfi3etbHmBYidEuzqhBxIUJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750111284; c=relaxed/simple;
	bh=NcmTj5O4UnDJpKrXg8mlqcQXqW5kLOfOgZhvciV6zUo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PEd3BzsfhP5JKtVjJTsBo8s+2mN7OdZlCUgB9D88284lDeeGTJeBn7ivzOmoQYW3jR8TpAii5yLO0hZoA5Vj/wy5jeP+fqgaed4j1OkzObIkdg/+K05wPOtym/z3xbSa41sYMWQJkLqPyNGo6z0jmG8B1qYmu0jwLR8m/Jd2XCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=udplqrxW; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750111281;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UpXv1zP1pu51TTfErAKypkJY3vjgrcKFdh3KjXTzhFA=;
	b=udplqrxWmGeRFbpu6YjHOGUPktFGJtRBM5UfUSsLYVTGVZ2Yt7dK+XIYp7GzFbUKRk447d
	nJ8irijhPldc1awyPuB+LHl3oEr9g9aOSJn+LM0DavL274LLBCCTUpZfacG1+O0+A3TrFl
	NjLIvzJbMesvV/uqBA2M7Ka98jjmCHQ=
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
Subject: [PATCH v2 6/9] spi: zynqmp-gqspi: Pass speed directly to config_op
Date: Mon, 16 Jun 2025 18:00:51 -0400
Message-Id: <20250616220054.3968946-7-sean.anderson@linux.dev>
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

In preparation for supporting transfer_one, which supplies the speed
from the spi_transfer instead of the spi_device, convert config_op to
take the speed directly.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

(no changes since v1)

 drivers/spi/spi-zynqmp-gqspi.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index add5eea12153..a17e77dc4e27 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -533,8 +533,8 @@ static inline u32 zynqmp_qspi_selectspimode(struct zynqmp_qspi *xqspi,
 /**
  * zynqmp_qspi_config_op - Configure QSPI controller for specified
  *				transfer
- * @xqspi:	Pointer to the zynqmp_qspi structure
- * @op:		The memory operation to execute
+ * @xqspi: Pointer to the zynqmp_qspi structure
+ * @req_speed_hz: Requested frequency
  *
  * Sets the operational mode of QSPI controller for the next QSPI transfer and
  * sets the requested clock frequency.
@@ -551,13 +551,10 @@ static inline u32 zynqmp_qspi_selectspimode(struct zynqmp_qspi *xqspi,
  *	by the QSPI controller the driver will set the highest or lowest
  *	frequency supported by controller.
  */
-static int zynqmp_qspi_config_op(struct zynqmp_qspi *xqspi,
-				 const struct spi_mem_op *op)
+static int zynqmp_qspi_config_op(struct zynqmp_qspi *xqspi, u32 req_speed_hz)
 {
 	ulong clk_rate;
-	u32 config_reg, req_speed_hz, baud_rate_val = 0;
-
-	req_speed_hz = op->max_freq;
+	u32 config_reg, baud_rate_val = 0;
 
 	if (xqspi->speed_hz != req_speed_hz) {
 		xqspi->speed_hz = req_speed_hz;
@@ -1053,7 +1050,7 @@ static int zynqmp_qspi_exec_op(struct spi_mem *mem,
 	u64 opaddr;
 
 	mutex_lock(&xqspi->op_lock);
-	zynqmp_qspi_config_op(xqspi, op);
+	zynqmp_qspi_config_op(xqspi, op->max_freq);
 	zynqmp_qspi_chipselect(mem->spi, false);
 	genfifoentry |= xqspi->genfifocs;
 	genfifoentry |= xqspi->genfifobus;
-- 
2.35.1.1320.gc452695387.dirty


