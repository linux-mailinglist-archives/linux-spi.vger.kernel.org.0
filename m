Return-Path: <linux-spi+bounces-4008-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BCD193D288
	for <lists+linux-spi@lfdr.de>; Fri, 26 Jul 2024 13:47:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DDAD1C209FE
	for <lists+linux-spi@lfdr.de>; Fri, 26 Jul 2024 11:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F2E219EA;
	Fri, 26 Jul 2024 11:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="l3stOCYF"
X-Original-To: linux-spi@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7950417A934;
	Fri, 26 Jul 2024 11:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721994449; cv=none; b=S+8eEDpw2/Fq60NA+hYC+rIjl0SnuRu/+nPwjFffujosxsEf0nPyC9lm5EZcGsmc4yDamIlwkz7FODwrMqAIefneFoTOEOsvCPN9h2ItMjJXDzG2iHr7QXAX8vYnEke+9Nw2OM0PR0hgaBEhmxc/fMDqeA23+jvIKYUCGABvoJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721994449; c=relaxed/simple;
	bh=xHeBzfe88Lxqzz7XBGzmzvrhqcFCgBdJRHwCZQajHPg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bIMFXBvi5t7UE9sEF17B21iGLXQJs6PHiEQ/HMYHAg+kyElEd8EnhxB1n158odj1IutC7oE19rto0w18A43aElISrQ9yaUi+A8OPVj3NbOb/AkLQEbe54f0rw9flPRn6B3P3GhvJ001dK6G5OKNtXHTr/y8A3vgGqNlETL/yFB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=l3stOCYF; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1721994445;
	bh=xHeBzfe88Lxqzz7XBGzmzvrhqcFCgBdJRHwCZQajHPg=;
	h=From:To:Cc:Subject:Date:From;
	b=l3stOCYFhwCvRGjQIb69osB2bZL97PdI3TEBBqCbIR1mfhIHcuU/m/ZJ+ueomJlmO
	 /znu1Kks2QmvcekDsPpICDqc0FshAZo4cN2Lw9jh+elRKAksu0+8Lf+/0zdPAKgt9b
	 bZ1Et6skX42DfAc8PQVwczEpcsuHnAvg2XwkqswgXMVnXtS3osQHFNzBU0OOp18C40
	 HHe+HfTIAZwrhLAdN2Ctf5YP0DKvJdFUSEIF7D7PAdo2mWjLPAHd6TlrHsVvQE7yvf
	 7ErnTIcyiHQfg+aLQZ1uK7plo7uHZuBdK2Pbg26xwCDds26yaWGCG6DNB3QuQq0hLL
	 D7WIt6PEJPi1A==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 1C58537804C6;
	Fri, 26 Jul 2024 11:47:25 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: broonie@kernel.org
Cc: matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	kernel@collabora.com
Subject: [PATCH] spi: spi-mt65xx: Use threaded interrupt for non-SPIMEM transfer
Date: Fri, 26 Jul 2024 13:47:21 +0200
Message-ID: <20240726114721.142196-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to avoid blocking for an excessive amount of time, eventually
impacting on system responsiveness, interrupt handlers should finish
executing in as little time as possible.

Use threaded interrupt and move the SPI transfer handling (both
CPU and DMA) for the non-spimem case to an interrupt thread instead.

For SPI-MEM (IPM) controllers, handling is kept in the blocking
interrupt as it simply consists in signalling completion.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/spi/spi-mt65xx.c | 40 +++++++++++++++++++++++++---------------
 1 file changed, 25 insertions(+), 15 deletions(-)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index 36c2f52cd6b8..dfee244fc317 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -743,25 +743,13 @@ static int mtk_spi_setup(struct spi_device *spi)
 	return 0;
 }
 
-static irqreturn_t mtk_spi_interrupt(int irq, void *dev_id)
+static irqreturn_t mtk_spi_interrupt_thread(int irq, void *dev_id)
 {
 	u32 cmd, reg_val, cnt, remainder, len;
 	struct spi_controller *host = dev_id;
 	struct mtk_spi *mdata = spi_controller_get_devdata(host);
 	struct spi_transfer *xfer = mdata->cur_transfer;
 
-	reg_val = readl(mdata->base + SPI_STATUS0_REG);
-	if (reg_val & MTK_SPI_PAUSE_INT_STATUS)
-		mdata->state = MTK_SPI_PAUSED;
-	else
-		mdata->state = MTK_SPI_IDLE;
-
-	/* SPI-MEM ops */
-	if (mdata->use_spimem) {
-		complete(&mdata->spimem_done);
-		return IRQ_HANDLED;
-	}
-
 	if (!host->can_dma(host, NULL, xfer)) {
 		if (xfer->rx_buf) {
 			cnt = mdata->xfer_len / 4;
@@ -845,6 +833,27 @@ static irqreturn_t mtk_spi_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static irqreturn_t mtk_spi_interrupt(int irq, void *dev_id)
+{
+	struct spi_controller *host = dev_id;
+	struct mtk_spi *mdata = spi_controller_get_devdata(host);
+	u32 reg_val;
+
+	reg_val = readl(mdata->base + SPI_STATUS0_REG);
+	if (reg_val & MTK_SPI_PAUSE_INT_STATUS)
+		mdata->state = MTK_SPI_PAUSED;
+	else
+		mdata->state = MTK_SPI_IDLE;
+
+	/* SPI-MEM ops */
+	if (mdata->use_spimem) {
+		complete(&mdata->spimem_done);
+		return IRQ_HANDLED;
+	}
+
+	return IRQ_WAKE_THREAD;
+}
+
 static int mtk_spi_mem_adjust_op_size(struct spi_mem *mem,
 				      struct spi_mem_op *op)
 {
@@ -1255,8 +1264,9 @@ static int mtk_spi_probe(struct platform_device *pdev)
 		dev_notice(dev, "SPI dma_set_mask(%d) failed, ret:%d\n",
 			   addr_bits, ret);
 
-	ret = devm_request_irq(dev, irq, mtk_spi_interrupt,
-			       IRQF_TRIGGER_NONE, dev_name(dev), host);
+	ret = devm_request_threaded_irq(dev, irq, mtk_spi_interrupt,
+					mtk_spi_interrupt_thread,
+					IRQF_TRIGGER_NONE, dev_name(dev), host);
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to register irq\n");
 
-- 
2.45.2


