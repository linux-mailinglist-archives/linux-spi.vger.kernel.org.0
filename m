Return-Path: <linux-spi+bounces-6370-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A389A144A4
	for <lists+linux-spi@lfdr.de>; Thu, 16 Jan 2025 23:42:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E59323A9BBC
	for <lists+linux-spi@lfdr.de>; Thu, 16 Jan 2025 22:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141A81DDC33;
	Thu, 16 Jan 2025 22:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XUK0fntH"
X-Original-To: linux-spi@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E514D1DC98C
	for <linux-spi@vger.kernel.org>; Thu, 16 Jan 2025 22:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737067322; cv=none; b=Qht2kYTQhP5ND6Dfi5lGyjKMPaiEztUQTkQoz1WoGL9igThYu8yJaeS5QcyX0gyJ6FZM2vCT6dY21I67FQXetLmBYR7Ci5NiX3L/nBZ5ZLA8/7mIac8EPcAXahQ1k/bYoMk9jB0LKdBCNxN8ZoOcTqrbx1VW9rQ43682bAR8gnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737067322; c=relaxed/simple;
	bh=kLtzHBmY20oZ9e25EhhGHKYRiSBuCy6uzCL0tLByKgs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QISBdgdxac6Si6DJJN9EyYDujwuJ9wIyc/3aZVe0Hg1wRwLP2vyWbubb5NsjuWcfQ1JFHtXbjAgCkrl1WkjjjgZF+J9MMr7RdVRkvZKh/nw1fEEAPXHLjYhDBEQ4ufUJ7Wn1XjXD8v4X7JQ/rZERAY7Z3V1llQ6IR3UAqOpnLBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XUK0fntH; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737067317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iU2N2JXGLPWImpT+BmMIzsUXEUu7RmoA8czJtXTqRmE=;
	b=XUK0fntHOipj9+BpcG1fwV18cGCbY7Crzq4SjXFl+VL/vNt/6v9xOrQFQ4vqEWaDiKEFZL
	ZdCwkDmHlrerjMhsM3FEKXCOaB6ck6VvA044bK8Dc4Bp6hSWAI0+t9GUg0JAhYR274eLsM
	it6dWctQOKECQtlfBKBKIwe4gRlBLQ8=
From: Sean Anderson <sean.anderson@linux.dev>
To: Mark Brown <broonie@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	linux-spi@vger.kernel.org
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH 1/5] spi: zynqmp-gqspi: Reformat long line
Date: Thu, 16 Jan 2025 17:41:26 -0500
Message-Id: <20250116224130.2684544-2-sean.anderson@linux.dev>
In-Reply-To: <20250116224130.2684544-1-sean.anderson@linux.dev>
References: <20250116224130.2684544-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This long line is broken in an unusual place. Reformat it to better
match the kernel style.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

 drivers/spi/spi-zynqmp-gqspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index 549a6e0c9654..0c3b3a16bb36 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -1059,8 +1059,8 @@ static unsigned long zynqmp_qspi_timeout(struct zynqmp_qspi *xqspi, u8 bits,
 static int zynqmp_qspi_exec_op(struct spi_mem *mem,
 			       const struct spi_mem_op *op)
 {
-	struct zynqmp_qspi *xqspi = spi_controller_get_devdata
-				    (mem->spi->controller);
+	struct zynqmp_qspi *xqspi =
+		spi_controller_get_devdata(mem->spi->controller);
 	unsigned long timeout;
 	int err = 0, i;
 	u32 genfifoentry = 0;
-- 
2.35.1.1320.gc452695387.dirty


