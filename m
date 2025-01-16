Return-Path: <linux-spi+bounces-6371-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D87A144A6
	for <lists+linux-spi@lfdr.de>; Thu, 16 Jan 2025 23:42:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A92D166091
	for <lists+linux-spi@lfdr.de>; Thu, 16 Jan 2025 22:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE4D236ED1;
	Thu, 16 Jan 2025 22:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="w5EAQ6xc"
X-Original-To: linux-spi@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE931DCB24
	for <linux-spi@vger.kernel.org>; Thu, 16 Jan 2025 22:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737067323; cv=none; b=BFh52FrWc9SWy03WlWF4OsIIpRPPme+xMVgZhxn2bP7AjJCtXvTaXw5MjZDKQbFJjFqCUcrQAT6sQyphKTmZmWxsuIa75UkcpYHCV50ZcLkzjVeTenYCu6OmA+IDZJztmsqoudjcR/q8O7hR25M9dBe/ofnTN7KfWMw4+GxKgBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737067323; c=relaxed/simple;
	bh=vcRnzWCFnr3yaH8vfY7Kc3VYluA5JqXoH35+D2BiDfI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TeRlpF4hRvUyhCyuoQ/ifA0ARkMa84vSM5TEKQwO5YKooeEXmTb2i7s5KWPCXBMGF3cZ6DF96C7T6KhJVwMqIg9ofrEO/wuKgjEWi9gfLmDWYDexHBKl1uir7dkv4uYFkHl+va1o97MeGB9zzDcv7swkQvvPpwvMF6LbkXJlKiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=w5EAQ6xc; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737067319;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZKn1FYerABDRxU2IGNUMyctJwGzKXnWiMDFTa4RkomA=;
	b=w5EAQ6xc30i08qaqnUgk6SKSMzDHukNhmSqW4ueaba1oyf+9CXNVSUBkFZaArvIsgP824C
	NOelbDcTtpRLXDag+l6swHrdu7Oj6ZWgp+JwJ65Ny64/j/Tro+JcM6QCcrlN9CK2JzN5Ot
	xRBfgpoDTueXskQ5BPHNtjtmWUxfKgA=
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
Subject: [PATCH 2/5] spi: zynqmp-gqspi: Add some more debug prints
Date: Thu, 16 Jan 2025 17:41:27 -0500
Message-Id: <20250116224130.2684544-3-sean.anderson@linux.dev>
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

Add a few more debug prints to make it easier to determine how the
device is programmed.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

 drivers/spi/spi-zynqmp-gqspi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index 0c3b3a16bb36..79dd1d56d05c 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -580,6 +580,8 @@ static int zynqmp_qspi_config_op(struct zynqmp_qspi *xqspi,
 		zynqmp_gqspi_write(xqspi, GQSPI_CONFIG_OFST, config_reg);
 		zynqmp_qspi_set_tapdelay(xqspi, baud_rate_val);
 	}
+
+	dev_dbg(xqspi->dev, "config speed %u\n", req_speed_hz);
 	return 0;
 }
 
@@ -693,6 +695,8 @@ static void zynqmp_qspi_fillgenfifo(struct zynqmp_qspi *xqspi, u8 nbits,
 	}
 	genfifoentry |= zynqmp_qspi_selectspimode(xqspi, nbits);
 	xqspi->genfifoentry = genfifoentry;
+	dev_dbg(xqspi->dev, "genfifo %05x transfer_len %u\n",
+		genfifoentry, transfer_len);
 
 	if ((transfer_len) < GQSPI_GENFIFO_IMM_DATA_MASK) {
 		genfifoentry &= ~GQSPI_GENFIFO_IMM_DATA_MASK;
-- 
2.35.1.1320.gc452695387.dirty


