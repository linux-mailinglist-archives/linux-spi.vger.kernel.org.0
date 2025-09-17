Return-Path: <linux-spi+bounces-10058-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03633B7C43A
	for <lists+linux-spi@lfdr.de>; Wed, 17 Sep 2025 13:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DABDB165F39
	for <lists+linux-spi@lfdr.de>; Wed, 17 Sep 2025 05:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E7526F471;
	Wed, 17 Sep 2025 05:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="KTt3DBv4"
X-Original-To: linux-spi@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8F826A0C6;
	Wed, 17 Sep 2025 05:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758088752; cv=none; b=ChRvuPwxonsQWoEEa/wInvdUNbDjHsgJcI4jIgXEB1yAgWymVS/E9n6YuJrZvHfzy2WhAnl0KeWz8yBMgywj0TmJQJBeFd5UlJkvW1DMZeefIwpzJLxlYbiO+nek13RHxTpcq2osGobZZ49dXk/nmOAfDr9+X9BcfTP9mbWQahk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758088752; c=relaxed/simple;
	bh=N7hSWU4vyXVYq1LgdXSE7TKCjMvfe16Z1XOZz08iKR8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Zbx790Ld1gAlO/PeIEm7TjInlhQ0TVMT9khXdjUM79WN2ybvt9GdAVgZjV2AXVlCGzM5bCuq5xkW2Cq0w0qn9Ox0gKWSiJGjx0zoribdPTB3wsaxcseHDf/jlfcD7UVpWrQOWL5QCah9Za+5Vdr2vprI/dQWLGWvtPy6Yp7oCDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=KTt3DBv4; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 5d27e58e938b11f0b33aeb1e7f16c2b6-20250917
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=9ZJVgwaOEmWuvAFUsMPU8nXNUNjwYPv3DJJE1+Lxz7I=;
	b=KTt3DBv4FvARppbruW1UeGOiaJ8IYvz+FSAnFAsuqOCcM/x+34JbHq40bF8KNPcE2o7+hpdKrFT/bAaY+qwDyz8u9JZ7lkNbZl+I2ix1Pg2NmzRlemAnvNv5RuPttsjI3ZBaHaAEmf4I5OYYMT/rBAaUUa0ooexYZQQu5G3ZHhY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.4,REQID:387a3a3b-1665-41d4-a048-34528a71e302,IP:0,UR
	L:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-25
X-CID-META: VersionHash:1ca6b93,CLOUDID:7152a46c-8443-424b-b119-dc42e68239b0,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|836,TC:-5,Content:0|15|50,EDM:-3
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 5d27e58e938b11f0b33aeb1e7f16c2b6-20250917
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
	(envelope-from <tim.kuo@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 310332080; Wed, 17 Sep 2025 13:58:42 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Wed, 17 Sep 2025 13:58:40 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Wed, 17 Sep 2025 13:58:40 +0800
From: Tim Kuo <Tim.Kuo@mediatek.com>
To: Mark Brown <broonie@kernel.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	Steven Liu <Steven.Liu@mediatek.com>, Sky Huang <Skylake.Huang@mediatek.com>,
	Tim Kuo <Tim.Kuo@mediatek.com>
Subject: [PATCH v2] spi: mt65xx: add dual and quad mode for standard spi device
Date: Wed, 17 Sep 2025 13:58:39 +0800
Message-ID: <20250917055839.500615-1-Tim.Kuo@mediatek.com>
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
v2: remove ret and change to use fallthrough in switch

 drivers/spi/spi-mt65xx.c | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index 8a3c00c3af42..4b40985af1ea 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -563,6 +563,22 @@ static void mtk_spi_setup_packet(struct spi_controller *host)
 	writel(reg_val, mdata->base + SPI_CFG1_REG);
 }
 
+inline u32 mtk_spi_set_nbit(u32 nbit)
+{
+	switch (nbit) {
+	default:
+		pr_warn_once("unknown nbit mode %u. Falling back to single mode\n",
+			     nbit);
+		fallthrough;
+	case SPI_NBITS_SINGLE:
+		return 0x0;
+	case SPI_NBITS_DUAL:
+		return 0x1;
+	case SPI_NBITS_QUAD:
+		return 0x2;
+	}
+}
+
 static void mtk_spi_enable_transfer(struct spi_controller *host)
 {
 	u32 cmd;
@@ -729,10 +745,16 @@ static int mtk_spi_transfer_one(struct spi_controller *host,
 
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


