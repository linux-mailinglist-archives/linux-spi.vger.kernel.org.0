Return-Path: <linux-spi+bounces-6379-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF87A144E1
	for <lists+linux-spi@lfdr.de>; Thu, 16 Jan 2025 23:56:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64EAB167F86
	for <lists+linux-spi@lfdr.de>; Thu, 16 Jan 2025 22:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45B5242252;
	Thu, 16 Jan 2025 22:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kDWFGToA"
X-Original-To: linux-spi@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF481DDC1D
	for <linux-spi@vger.kernel.org>; Thu, 16 Jan 2025 22:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737068145; cv=none; b=Z5+Ra6xW8f3TKdrR6j3r+GXeHZwQ2uS24jdW80/XgEzX2v2RcJfVNOfSadxw6esG1381i+BEL3gT1+c++UxEwg7fYmmSP+Jy6L4RE4A21OJriH3uAUQHM75z7584wHZ4Eg6MCyKsamJQiidKRoj8mqHgm95y81iHgie7ny+LGO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737068145; c=relaxed/simple;
	bh=ba8hLmCk3005C8TXKZHQSGE03vULFLV7U6Bv6zHV6h0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GpWeSoAvDDlOL46SaaFkB+GZT21pFv+OLFEnD0kTEC7Sv/AeXWVNCTp7zaraoCW9+ppNfxF26OQnkRNNTllaMN/nDC3I1A9Wi5n0KPUXbgf465omvhp8JzVl4ahkERAIrMque4HG4TsViLq8f6wqz3ReXNqyJRLKSktb6P8ZXW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kDWFGToA; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737068141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=myOtv1Ti+fSD/oUnnjMPiLo6ViBfIn8lXDe7UnZSh0A=;
	b=kDWFGToAYreA642mEaPCSTgL8yMCyoWf1ryblhiDYjNDN/jNrkOpR6vFAqcmahj41e3+FG
	n8//t5wXav35O4QoYpGTvE2t9oCA5AxyrNKwEjmv7w4zr0IKjo+0ySN+W9wvQdok+vZWbg
	iWJ/p18qs+HmYN0fkO6qSNwMDnuvFF8=
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
Subject: [PATCH 4/5] spi: zynqmp-gqspi: Allow interrupting operations
Date: Thu, 16 Jan 2025 17:55:20 -0500
Message-Id: <20250116225521.2688224-5-sean.anderson@linux.dev>
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

Some operations (such as reading several megabytes of data from a flash)
can take several seconds or more. Users may want to cancel such
operations. Allow them to do so now that we have a way to recover.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

 drivers/spi/spi-zynqmp-gqspi.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index cf47466ec982..fa4bff73324e 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -1062,14 +1062,24 @@ static int zynqmp_qspi_wait(struct zynqmp_qspi *xqspi, unsigned long timeout)
 {
 	int ret;
 
-	ret = wait_for_completion_timeout(&xqspi->data_completion, timeout);
-	if (ret)
+	/* Only allow interrupting if we can reset the device */
+	if (xqspi->reset)
+		ret = wait_for_completion_interruptible_timeout(&xqspi->data_completion,
+								timeout);
+	else
+		ret = wait_for_completion_timeout(&xqspi->data_completion,
+						  timeout);
+	if (ret > 0)
 		return 0;
-	dev_err(xqspi->dev, "Operation timed out\n");
+
+	if (!ret) {
+		dev_err(xqspi->dev, "Operation timed out\n");
+		ret = -ETIMEDOUT;
+	}
 
 	/* Attempt to recover as best we can */
 	zynqmp_qspi_init_hw(xqspi);
-	return -ETIMEDOUT;
+	return ret;
 }
 
 /**
-- 
2.35.1.1320.gc452695387.dirty


