Return-Path: <linux-spi+bounces-11645-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 16563C911B6
	for <lists+linux-spi@lfdr.de>; Fri, 28 Nov 2025 09:11:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9EC6F4E862F
	for <lists+linux-spi@lfdr.de>; Fri, 28 Nov 2025 08:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812742DF710;
	Fri, 28 Nov 2025 08:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="p+6a6G2M"
X-Original-To: linux-spi@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCFC2F691F
	for <linux-spi@vger.kernel.org>; Fri, 28 Nov 2025 08:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764317218; cv=none; b=BfL4OGMe/yvk36XWVVrhotRJZ1B3rpsQ5sw4i3ExOucZnjMl9NYMi5o53UCZNfLP1iqt6VtSajW6YFB/b00dKVJVUVIAJoROOfIR5GO1wDbm49UsR/p3Tcxc3d6KRWTn3FjbYzLmG5FJSIc/+V9W64Q1SrRJIFOPVwOBJlD8fc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764317218; c=relaxed/simple;
	bh=PaRuPo/8d18hXOSOrZZmdayCy4RSaURgt88N6VVQF5k=;
	h=Date:From:To:Cc:Subject:Message-Id:Mime-Version:Content-Type; b=ZkvRDAAmyJwVPrFJAE6JiqK6PERTz6CXAgfJnIIuJs9D4HF1OQ55d+ZEX6/Ax+Hj7VjEUlUntIKgcbz/K1dd5pQatJ3wBSen1s0x29LQjZD5ro4UynO3L0j+rLB4/dNACMx1xPWzPhUiJDT1HEEoRUuGh+uNALGoFr/KmaGY960=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=p+6a6G2M; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 28 Nov 2025 16:06:30 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764317204;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xyLFdyMwZ35EJDPF/oEQsYS5adqqktBJr+Gd6bwHb1s=;
	b=p+6a6G2MkCuAkyVcpkoCUGlMHQvfw7oFTHgM6kKGth5gHzu2BDjbMOSdcKoYNhmVDiEd7g
	QKotHrcaGmyiGLiG4shNZ2XfKoSuB6KQgwCICyoA78UEpVMnRIVDqyDAvmeHcDCqVYlw7U
	NDF+aEYGhSdDubKw7lRlZL59LFT/COc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tianchu Chen <tianchu.chen@linux.dev>
To: broonie@kernel.org
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
 gregkh@linuxfoundation.org
Subject: [PATCH] spi: ch341: fix out-of-bounds memory access in
 ch341_transfer_one
Message-Id: <20251128160630.0f922c45ec6084a46fb57099@linux.dev>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

From: Tianchu Chen <flynnnchen@tencent.com>

Discovered by Atuin - Automated Vulnerability Discovery Engine.

The 'len' variable is calculated as 'min(32, trans->len + 1)',
which includes the 1-byte command header.

When copying data from 'trans->tx_buf' to 'ch341->tx_buf + 1', using 'len'
as the length is incorrect because:

1. It causes an out-of-bounds read from 'trans->tx_buf' (which has size
   'trans->len', i.e., 'len - 1' in this context).
2. It can cause an out-of-bounds write to 'ch341->tx_buf' if 'len' is
   CH341_PACKET_LENGTH (32). Writing 32 bytes to ch341->tx_buf + 1
   overflows the buffer.

Fix this by copying 'len - 1' bytes.

Fixes: 8846739f52af ("spi: add ch341a usb2spi driver")
Signed-off-by: Tianchu Chen <flynnnchen@tencent.com>
---
 drivers/spi/spi-ch341.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-ch341.c b/drivers/spi/spi-ch341.c
index 46bc208f2..79d2f9ab4 100644
--- a/drivers/spi/spi-ch341.c
+++ b/drivers/spi/spi-ch341.c
@@ -78,7 +78,7 @@ static int ch341_transfer_one(struct spi_controller *host,
 
 	ch341->tx_buf[0] = CH341A_CMD_SPI_STREAM;
 
-	memcpy(ch341->tx_buf + 1, trans->tx_buf, len);
+	memcpy(ch341->tx_buf + 1, trans->tx_buf, len - 1);
 
 	ret = usb_bulk_msg(ch341->udev, ch341->write_pipe, ch341->tx_buf, len,
 			   NULL, CH341_DEFAULT_TIMEOUT);
-- 
2.39.5


