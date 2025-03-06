Return-Path: <linux-spi+bounces-7064-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F3B8A5524A
	for <lists+linux-spi@lfdr.de>; Thu,  6 Mar 2025 18:06:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 183AC164D29
	for <lists+linux-spi@lfdr.de>; Thu,  6 Mar 2025 17:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3C925A325;
	Thu,  6 Mar 2025 17:05:41 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E76E25D52B;
	Thu,  6 Mar 2025 17:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741280741; cv=none; b=f9NduTY4UEtJGMtbAa9h8wsNdat267ELy6iNL7K7RiFdGSFgE/y06Exap2/jbPTarO7KTTlhom27uljrrGkSMqMkd4l5CbgG/wc6b7iAeNkZXsnh63UTID/vtOG8aAKZo9/Qm9beT1ZXjGui+1CyQ83UvGibfHBWDr/o+UqAoXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741280741; c=relaxed/simple;
	bh=D+X8tP2LDC9YiDuBE6bTFGT91uMG7BqoCbRc19P6eZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L4+WUsmQ3ac2ZN5fciIo709JNZESvEejn7mw1duYKx+VDD6vHpcpCydUC+jqI8rWgXSpvMsr1hkn8+AKWY6S7UA44ZWsSlaT+VxcwyENTFq80MJSzWMgRX+8Og8gfnJ9RAiXjxkFosk0zZbHt3mT+Y4cXPQP/u/Dzim9LyhFydY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: TVnyD1s0Si6ifkq3CV1yTQ==
X-CSE-MsgGUID: RLiQLCHISRWGyBqugA7Deg==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 07 Mar 2025 02:05:39 +0900
Received: from localhost.localdomain (unknown [10.226.92.10])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 00B9E4016D60;
	Fri,  7 Mar 2025 02:05:36 +0900 (JST)
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
Date: Thu,  6 Mar 2025 17:05:06 +0000
Message-ID: <20250306170512.241128-9-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250306170512.241128-1-biju.das.jz@bp.renesas.com>
References: <20250306170512.241128-1-biju.das.jz@bp.renesas.com>
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


