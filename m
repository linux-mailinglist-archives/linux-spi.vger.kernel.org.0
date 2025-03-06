Return-Path: <linux-spi+bounces-7066-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 23FA4A55281
	for <lists+linux-spi@lfdr.de>; Thu,  6 Mar 2025 18:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7C867A184E
	for <lists+linux-spi@lfdr.de>; Thu,  6 Mar 2025 17:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5020B25D202;
	Thu,  6 Mar 2025 17:09:56 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D10EF25A633;
	Thu,  6 Mar 2025 17:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741280996; cv=none; b=ZoHyoIKmUllSLJFr8oDirzfmWXumSsHi+qdp18sybSwre+nFny2lr7l5D5njDzLRoV8ZwjjICuFuwpDffzL5Pn+dGDpO8wXc6GFgGAHjus+lZPXEQVhTqLtiNydsROQpqQkeyoYa+GFAvXhV2OviL14J/A73lI4hsv2MNHM/04w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741280996; c=relaxed/simple;
	bh=D+X8tP2LDC9YiDuBE6bTFGT91uMG7BqoCbRc19P6eZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fhYFA0NTreSTsAwaB2s/ez6HF7qU+mdvTorRoSvvU8KQv3odMSktpkDAK5zpl8UOy5Qq20yBjaULheBSfFy4fuidVK93/UqTPCjhmlcNIh9UajaLSkjE/7KhqBWqib66i/xAcvX41Z0tyujIUytniRHYojGwo+jQjlFLCgdRWWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: WmvQ8V4GRDKbEdpwj7OAug==
X-CSE-MsgGUID: vLkCBgNoSSOY9sGSl/XN1Q==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 07 Mar 2025 02:09:53 +0900
Received: from localhost.localdomain (unknown [10.226.92.10])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 4B0AF400857C;
	Fri,  7 Mar 2025 02:09:51 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Mark Brown <broonie@kernel.org>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	linux-spi@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH v2 8/8] spi: rpc-if: Add write support for memory-mapped area
Date: Thu,  6 Mar 2025 17:09:18 +0000
Message-ID: <20250306170924.241257-9-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250306170924.241257-1-biju.das.jz@bp.renesas.com>
References: <20250306170924.241257-1-biju.das.jz@bp.renesas.com>
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


