Return-Path: <linux-spi+bounces-7738-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDABEA9A745
	for <lists+linux-spi@lfdr.de>; Thu, 24 Apr 2025 11:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38CFF3A716A
	for <lists+linux-spi@lfdr.de>; Thu, 24 Apr 2025 09:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8178121D3EB;
	Thu, 24 Apr 2025 09:00:29 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF13221ADB9;
	Thu, 24 Apr 2025 09:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745485229; cv=none; b=jXKP04Rjz/WwyC2M9uUZ8Fvuq0O37wZ7tPGrJ28UF2H/ozJQ6ZKQhizB5vaNhmrMdbFHtnx/3kVWltCUFX6IxW7rspT3SSgQiy6/1N1NIFxhgRlQbrfPbdWyvWne6We+ktaSwd3WR7oX6bf9yQHZ6MQ4MCse/hPApaYhmpsGqtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745485229; c=relaxed/simple;
	bh=5CH7/tPL2Io8zzwKQ/dSZcjyMjAOYsTEGG4KbV4dW2o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AlU93JhxeeunyE9vZkRWLK5+Gs4o2oXGlhvGk1nw4d6Q5TtlH51s+On9wsfzBxxEGIbVSo6SGCwu+PP4L0PYwFVyTsHYmkzeJ72g6neGGcOhTy1jcxGMFXyYSRSKs9YfDMqeI1bpbbIrPQwrwG+HQ/32Yax5O6ARUuHDAh+2c4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: TPXh0QE0TPWEuJjjgtqO/g==
X-CSE-MsgGUID: i6Hwhv16SRuEODHIjZgcdw==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 24 Apr 2025 18:00:27 +0900
Received: from localhost.localdomain (unknown [10.226.92.69])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id C4CBE4010E39;
	Thu, 24 Apr 2025 18:00:24 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Mark Brown <broonie@kernel.org>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	linux-spi@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH v5 7/7] spi: rpc-if: Add write support for memory-mapped area
Date: Thu, 24 Apr 2025 09:59:55 +0100
Message-ID: <20250424090000.136804-8-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424090000.136804-1-biju.das.jz@bp.renesas.com>
References: <20250424090000.136804-1-biju.das.jz@bp.renesas.com>
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
v4->v5:
 * No change.
 * This patch has build dependency with patch#6.
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


