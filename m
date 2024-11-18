Return-Path: <linux-spi+bounces-5727-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A643B9D1707
	for <lists+linux-spi@lfdr.de>; Mon, 18 Nov 2024 18:22:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBF32B25EBB
	for <lists+linux-spi@lfdr.de>; Mon, 18 Nov 2024 17:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E8FF1A01B3;
	Mon, 18 Nov 2024 17:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="fhKzbRWa"
X-Original-To: linux-spi@vger.kernel.org
Received: from ec2-44-216-146-137.compute-1.amazonaws.com (ec2-44-216-146-137.compute-1.amazonaws.com [44.216.146.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80C7198E99;
	Mon, 18 Nov 2024 17:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.216.146.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731950362; cv=none; b=unGSDdlr7dbZfLGznmnEfT4KWUpFS/ASBcqIi8LZckSnXSFSFeUuofm9Y3p95lh4fcc0hF2uiTegPtJ/erkD9o0AnVbn5FEBvR9rz+L8QXtUeIEUrZudUOscs9gir+ZZdL84ov6TxR773t0pYAymn9nZ906VnihZ8BBaJPASBK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731950362; c=relaxed/simple;
	bh=bS0rX26lWdgUGaXcPq2jIpYHj6Dic8ngDtC3mIhebAc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aalY99PXnB5eUXq4jLlXH5MbDM+0DFq4bEQrR9ElgWNaZJDYPuQXg5qmiBx76qJhGgiU7nzzaxSagFHxGqfoRr0EsWVj4qZe8YAcK7W2JZHmtgxCXUHi4R9PoARoHein/wzB2odPU0knK5oHMrGaedpWjnhoVyh/6Aunp5TNN8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=fhKzbRWa; arc=none smtp.client-ip=44.216.146.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from rockchip.. (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 317a7f35;
	Mon, 18 Nov 2024 22:56:48 +0800 (GMT+08:00)
From: Jon Lin <jon.lin@rock-chips.com>
To: broonie@kernel.org
Cc: linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	heiko@sntech.de,
	jon.lin@rock-chips.com,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org
Subject: [PATCH] spi: rockchip-sfc: Embedded DMA only support 4B aligned address
Date: Mon, 18 Nov 2024 22:56:46 +0800
Message-Id: <20241118145646.2609039-1-jon.lin@rock-chips.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQhoaTFZCT01PTh4ZSEpOSk5WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a933fc6ba8d09d9kunm317a7f35
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6P006SBw*SzIhQ1ELSzkPMyov
	GBgwCkxVSlVKTEhKQk9KQ0tCTU1PVTMWGhIXVREUFVUXEhU7CRQYEFYYExILCFUYFBZFWVdZEgtZ
	QVlOQ1VJSVVMVUpKT1lXWQgBWUFDQ083Bg++
DKIM-Signature:a=rsa-sha256;
	b=fhKzbRWaLMBVXGi5F1pcCy/LUI0n+JSbCyVA5a8UCaMGcee5HZb4Zw3KEK74/cUF6oOxDzAJB/Mo6VzGT9cTygrEXl87Deas3Xwkx9wSNw/7e1NFRQ/Xtnf5UsA+posFPdKhOsGodusVnV5SmP5C8KpDEs1ICFKYMi+tNV6vXCQ=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=orMLRxEgPaCVt+DUcYSRwYW0pCq8JjJqS0YZ0bC7OiQ=;
	h=date:mime-version:subject:message-id:from;

Controller limitations.

Signed-off-by: Jon Lin <jon.lin@rock-chips.com>
---

 drivers/spi/spi-rockchip-sfc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-rockchip-sfc.c b/drivers/spi/spi-rockchip-sfc.c
index 316e3db88492..69d0f2175568 100644
--- a/drivers/spi/spi-rockchip-sfc.c
+++ b/drivers/spi/spi-rockchip-sfc.c
@@ -503,7 +503,7 @@ static int rockchip_sfc_exec_mem_op(struct spi_mem *mem, const struct spi_mem_op
 	rockchip_sfc_adjust_op_work((struct spi_mem_op *)op);
 	rockchip_sfc_xfer_setup(sfc, mem, op, len);
 	if (len) {
-		if (likely(sfc->use_dma) && len >= SFC_DMA_TRANS_THRETHOLD) {
+		if (likely(sfc->use_dma) && len >= SFC_DMA_TRANS_THRETHOLD && !(len & 0x3)) {
 			init_completion(&sfc->cp);
 			rockchip_sfc_irq_unmask(sfc, SFC_IMR_DMA);
 			ret = rockchip_sfc_xfer_data_dma(sfc, op, len);
-- 
2.34.1


