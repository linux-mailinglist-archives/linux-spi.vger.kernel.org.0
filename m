Return-Path: <linux-spi+bounces-10042-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C96FB5902B
	for <lists+linux-spi@lfdr.de>; Tue, 16 Sep 2025 10:16:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF1AC1B23B65
	for <lists+linux-spi@lfdr.de>; Tue, 16 Sep 2025 08:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17EDF27FB2F;
	Tue, 16 Sep 2025 08:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="JvebwpEc"
X-Original-To: linux-spi@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2597723E229;
	Tue, 16 Sep 2025 08:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758010566; cv=none; b=pDu8jkroLNjWv9JbFBuBtmi8DwDZx7zqD778yRV/szazPkWnCxlSPw0ZCAgP4HCKnJJJXdJA9srO2fKI3uy22B9jMURuHvCnnwWfUiU9TVbFnzL3D/kfm8ctk/40viF5ErQK/mXaKJwbQzwKaYq8xnZYmHXF+RelGszU5MzZCws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758010566; c=relaxed/simple;
	bh=Q/+oIBGch8qZShTfC7m3G/faLlMwyE1AHNhUGc+5LCk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nPFldt8jbj3LraY3mAlepqLY7/DtsRliz4rHEx2Joeny5xBu67V71vHcbzc4O22LPGRzur8UqsUyJLCCwXZW1/lXx6VwLgZR3s93BBatLOUXIjw6UxvhkmH4gmJO84Ig48bwNZSEC4iPVVA3tY/fv8tG9iTPEzbj6A2Edau877E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=JvebwpEc; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 600abe5492d511f0bd5779446731db89-20250916
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=vKGd3v+/MNTZFBly663z0CRc24GoxcHKINEmL/tLaUE=;
	b=JvebwpEc9DQL1i5ZpV+gvhvFltmlSGOqe2iA0co1i35kJb7GgUT2nvDUZg6e9L/KVztFTviAt8L/ySeg20w6Rk/nYy3OkROwzOTqsHIoKt1DZJ45CvrX//8z9oumtIWIrtvx3xxORYGJKkaJe8f5myK001cFG8TdiM4GqLz4jTU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.4,REQID:3e1d9aaa-8765-4b9f-b6f9-179efad1c66d,IP:0,UR
	L:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-25
X-CID-META: VersionHash:1ca6b93,CLOUDID:aff4d684-5317-4626-9d82-238d715c253f,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:-5,Content:0|15|50,EDM:-3,IP:
	nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,L
	ES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 600abe5492d511f0bd5779446731db89-20250916
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
	(envelope-from <tim.kuo@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 265731134; Tue, 16 Sep 2025 16:15:58 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Tue, 16 Sep 2025 16:15:56 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Tue, 16 Sep 2025 16:15:56 +0800
From: Tim Kuo <Tim.Kuo@mediatek.com>
To: Mark Brown <broonie@kernel.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	Steven Liu <Steven.Liu@mediatek.com>, Sky Huang <Skylake.Huang@mediatek.com>,
	Tim Kuo <Tim.Kuo@mediatek.com>
Subject: [PATCH] spi: mt65xx: add dual and quad mode for standard spi device
Date: Tue, 16 Sep 2025 16:15:15 +0800
Message-ID: <20250916081515.324130-1-Tim.Kuo@mediatek.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

From: "Tim Kuo" <Tim.Kuo@mediatek.com>

Mediatek SPI hardware natively supports dual and quad modes, and these
modes are already enabled for SPI flash devices under spi-mem framework
in MTK SPI controller spi-mt65xx. However, other SPI devices, such as
touch panels, are limited to single mode because spi-mt65xx lacks SPI
mode argument parsing from SPI framework for these SPI devices outside
spi-mem framework.

This patch adds dual and quad mode support for these SPI devices by
introducing a new API, mtk_spi_set_nbits, for SPI mode argument parsing.

Signed-off-by: Tim Kuo <Tim.Kuo@mediatek.com>
---
 drivers/spi/spi-mt65xx.c | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index 8a3c00c3af42..591740805740 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -563,6 +563,27 @@ static void mtk_spi_setup_packet(struct spi_controller *host)
 	writel(reg_val, mdata->base + SPI_CFG1_REG);
 }
 
+inline u32 mtk_spi_set_nbit(u32 nbit)
+{
+	u32 ret = 0;
+
+	switch (nbit) {
+	case SPI_NBITS_SINGLE:
+		ret = 0x0;
+		break;
+	case SPI_NBITS_DUAL:
+		ret = 0x1;
+		break;
+	case SPI_NBITS_QUAD:
+		ret = 0x2;
+		break;
+	default:
+		pr_info("unknown spi nbit mode, use single mode!");
+		break;
+	}
+	return ret;
+}
+
 static void mtk_spi_enable_transfer(struct spi_controller *host)
 {
 	u32 cmd;
@@ -729,10 +750,16 @@ static int mtk_spi_transfer_one(struct spi_controller *host,
 
 	/* prepare xfer direction and duplex mode */
 	if (mdata->dev_comp->ipm_design) {
-		if (!xfer->tx_buf || !xfer->rx_buf) {
+		if (xfer->tx_buf && xfer->rx_buf) {
+			reg_val &= ~SPI_CFG3_IPM_HALF_DUPLEX_EN;
+		} else if (xfer->tx_buf) {
+			reg_val |= SPI_CFG3_IPM_HALF_DUPLEX_EN;
+			reg_val &= ~SPI_CFG3_IPM_HALF_DUPLEX_DIR;
+			reg_val |= mtk_spi_set_nbit(xfer->tx_nbits);
+		} else {
 			reg_val |= SPI_CFG3_IPM_HALF_DUPLEX_EN;
-			if (xfer->rx_buf)
-				reg_val |= SPI_CFG3_IPM_HALF_DUPLEX_DIR;
+			reg_val |= SPI_CFG3_IPM_HALF_DUPLEX_DIR;
+			reg_val |= mtk_spi_set_nbit(xfer->rx_nbits);
 		}
 		writel(reg_val, mdata->base + SPI_CFG3_IPM_REG);
 	}
-- 
2.45.2


