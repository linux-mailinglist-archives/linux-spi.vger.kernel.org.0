Return-Path: <linux-spi+bounces-7383-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D1BA77DEC
	for <lists+linux-spi@lfdr.de>; Tue,  1 Apr 2025 16:36:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 777473ACE72
	for <lists+linux-spi@lfdr.de>; Tue,  1 Apr 2025 14:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 843C7204F6A;
	Tue,  1 Apr 2025 14:36:13 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD798204C29;
	Tue,  1 Apr 2025 14:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743518173; cv=none; b=i9pA9JjIJ4NwkFp8UmgFmoEztH8xUlm6rhaIGbY+Uk8ek5/9s1l4YyDKYe30bx9p9dkYp7sM+0qbRCsJ4pUSDcU51vH376aVYMkswC1QnQpwWvTbnrb9mRElDecNydkHoNs1L/DPCIhtoff1rWEsFb980UvxCvNL2lMwFrzsXgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743518173; c=relaxed/simple;
	bh=tqL5C/yTwccB8HKPyGNWZ9I0xAWuqGTiU+CmPQKYadY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WzRo1q/hjnc96Kid1JwpQRmLS90Kmp/1cAWW9C2GKz18NyZC/5F7L6+L4Uls3v5YssXagtUQVlymUd3uJA6wRjOdIqBBiFbFp2S8qwUQkKnah1M8Q6PkgYdqxFx9q7crGeThHQ83cmKLk+4LewtDp67xd4rdl86+8pz07W4lryY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: e1PPH+c3QY22Rm6ztah3GQ==
X-CSE-MsgGUID: GFimqYCFShu1AyeUZVISpw==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 01 Apr 2025 23:36:10 +0900
Received: from localhost.localdomain (unknown [10.226.92.156])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id BF5DF43319E2;
	Tue,  1 Apr 2025 23:36:07 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Mark Brown <broonie@kernel.org>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	linux-spi@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH v4 9/9] spi: rpc-if: Add write support for memory-mapped area
Date: Tue,  1 Apr 2025 15:35:27 +0100
Message-ID: <20250401143537.224047-10-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250401143537.224047-1-biju.das.jz@bp.renesas.com>
References: <20250401143537.224047-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add write support for memory-mapped area as xSPI interface require
it.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v3->v4:
 * No change.
v2->v3:
 * No change.
v1->v2:
 * No change.
---
 drivers/spi/spi-rpc-if.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-rpc-if.c b/drivers/spi/spi-rpc-if.c
index e0c66a24a3cb..627cffea5d5c 100644
--- a/drivers/spi/spi-rpc-if.c
+++ b/drivers/spi/spi-rpc-if.c
@@ -75,6 +75,19 @@ static bool rpcif_spi_mem_supports_op(struct spi_mem *mem,
 	return true;
 }
 
+static ssize_t xspi_spi_mem_dirmap_write(struct spi_mem_dirmap_desc *desc,
+					 u64 offs, size_t len, const void *buf)
+{
+	struct rpcif *rpc = spi_controller_get_devdata(desc->mem->spi->controller);
+
+	if (offs + desc->info.offset + len > U32_MAX)
+		return -EINVAL;
+
+	rpcif_spi_mem_prepare(desc->mem->spi, &desc->info.op_tmpl, &offs, &len);
+
+	return xspi_dirmap_write(rpc->dev, offs, len, buf);
+}
+
 static ssize_t rpcif_spi_mem_dirmap_read(struct spi_mem_dirmap_desc *desc,
 					 u64 offs, size_t len, void *buf)
 {
@@ -103,7 +116,7 @@ static int rpcif_spi_mem_dirmap_create(struct spi_mem_dirmap_desc *desc)
 	if (!rpc->dirmap)
 		return -EOPNOTSUPP;
 
-	if (desc->info.op_tmpl.data.dir != SPI_MEM_DATA_IN)
+	if (!rpc->xspi && desc->info.op_tmpl.data.dir != SPI_MEM_DATA_IN)
 		return -EOPNOTSUPP;
 
 	return 0;
@@ -125,6 +138,7 @@ static const struct spi_controller_mem_ops rpcif_spi_mem_ops = {
 	.exec_op	= rpcif_spi_mem_exec_op,
 	.dirmap_create	= rpcif_spi_mem_dirmap_create,
 	.dirmap_read	= rpcif_spi_mem_dirmap_read,
+	.dirmap_write	= xspi_spi_mem_dirmap_write,
 };
 
 static int rpcif_spi_probe(struct platform_device *pdev)
-- 
2.43.0


