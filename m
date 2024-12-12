Return-Path: <linux-spi+bounces-6041-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE4679EE2CC
	for <lists+linux-spi@lfdr.de>; Thu, 12 Dec 2024 10:24:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90E31161A32
	for <lists+linux-spi@lfdr.de>; Thu, 12 Dec 2024 09:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 772AA210198;
	Thu, 12 Dec 2024 09:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="WS62WFVr"
X-Original-To: linux-spi@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7684220E337;
	Thu, 12 Dec 2024 09:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733995341; cv=none; b=cphLg4gxX3B/i6icY8eNy0KpENjMQ/cJt2j5JJ08dB1dNuFdrM8MHF8pFcHt2wxkAx7yasUOd5YnBrLqMOJRhgGWBUsqxlaI6c/8tp59XZj3ltTDFDDwAVq28lQrOAvIO96GEqLwjBb9HqKjuMy9eSSfxZ0KiC3kzwxRYhtvLCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733995341; c=relaxed/simple;
	bh=1I5xkOfcK/G28pEQISMHkgkC3GLNjLYii3hf5M0pLxE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GhByJfP5wBuBcbzlWckDGFxaWb7Bp4En9jlx+xnWZPCa2JaEJsIc03fBoJy2j80bBwgvLeTV7RBinUzSPkaJ0ZKPUT4g4iwWP0bjKgytuAdapyum3JupUcp6WG0blCKJ3sIPEEYmcB7vecYhrEwG5IWurQZ6+bHZQ/9H5Ragm18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=WS62WFVr; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 920f2606b86a11ef99858b75a2457dd9-20241212
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=tGykcbTcw3d7ewUJ0l3TKsRLZtS5QyewppIPS1U+Om8=;
	b=WS62WFVrp77EVvB9ufbchuuPGjh9c0yK9g/gdlkj4Gw0C+fQGU3j/tyc1naF8M1ttcZXqcrJHaN9b4vs4PaMOaVvHK+pEiTdqj6cm6hxYGnnBwyy9u9Z5SkdnUUN9j6DakGJCrSY0qSLx83OtALvAErWaXY+BNGYEr6CFOp6W6w=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:28d77f41-f6a6-41f5-ba80-15e537227a74,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:6493067,CLOUDID:9a796828-d2eb-4de2-b5c9-495d1bc17256,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 920f2606b86a11ef99858b75a2457dd9-20241212
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
	(envelope-from <cloud.zhang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 981262921; Thu, 12 Dec 2024 17:22:12 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 12 Dec 2024 17:22:09 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 12 Dec 2024 17:22:08 +0800
From: mtk22730 <Cloud.Zhang@mediatek.com>
To: Mark Brown <broonie@kernel.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, Cloud Zhang
	<cloud.zhang@mediatek.com>
Subject: [PATCH] [v1] spi: spi-mtk-nor: Modify the clock architecture of nor controller
Date: Thu, 12 Dec 2024 17:20:12 +0800
Message-ID: <20241212092206.14071-1-Cloud.Zhang@mediatek.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10-2.015300-8.000000
X-TMASE-MatchedRID: PZMqI2AhqDQdWKRD1iYss+EbUg4xvs+wCt59Uh3p/NUKogmGusPLb8UR
	fpp2J0YycRMU/6zQP6hcWPWm98SUsWdvGUEuKvScnIGynr5ObIaKbuU19+RNrmq//5Ao1w8uVon
	uiLTPfifG3TRnfVX2PIAy6p60ZV62SwOSQ/fMiOrdB/CxWTRRu4PtEWvP7F7FglK3TQvBrzHUdN
	vHZnc+lOkykW6dVMoLp7xo3bUdR0zawYtKJNIJl4y1Ms3iZ9oVEBHFAzc5ZQlDW0Cl2o4sC7Y3k
	0MIk05nhJVRlkc0uv5GBXoeyrLHXVBo425nomviD2TeXwRpghw5Asr9kfiuVp6oP1a0mRIj
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10-2.015300-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	9A918C98F4CB6051F0074717FB9392B18B5A07F715E3C802758DA1FA72F647DF2000:8

From: Cloud Zhang <cloud.zhang@mediatek.com>

The clock used by different platforms is not same. So it is
necessary to modify the clock architecture to be adaptable to more
platforms.

Signed-off-by: Cloud Zhang <cloud.zhang@mediatek.com>
---
 drivers/spi/spi-mtk-nor.c | 118 ++++++++++++++++++++++----------------
 1 file changed, 68 insertions(+), 50 deletions(-)

diff --git a/drivers/spi/spi-mtk-nor.c b/drivers/spi/spi-mtk-nor.c
index 85ab5ce96c4d..d466a8d3f062 100644
--- a/drivers/spi/spi-mtk-nor.c
+++ b/drivers/spi/spi-mtk-nor.c
@@ -99,6 +99,8 @@
 
 #define CLK_TO_US(sp, clkcnt)		DIV_ROUND_UP(clkcnt, sp->spi_freq / 1000000)
 
+#define MAX_CLOCK_CNT		6
+
 struct mtk_nor_caps {
 	u8 dma_bits;
 
@@ -110,16 +112,19 @@ struct mtk_nor_caps {
 	u8 extra_dummy_bit;
 };
 
+struct clk_info {
+	struct clk *clki;
+	const char *name;
+};
+
 struct mtk_nor {
 	struct spi_controller *ctlr;
 	struct device *dev;
 	void __iomem *base;
 	u8 *buffer;
 	dma_addr_t buffer_dma;
-	struct clk *spi_clk;
-	struct clk *ctlr_clk;
-	struct clk *axi_clk;
-	struct clk *axi_s_clk;
+	struct clk_info clocks[MAX_CLOCK_CNT];
+	u8 clock_cnt;
 	unsigned int spi_freq;
 	bool wbuf_en;
 	bool has_irq;
@@ -703,42 +708,74 @@ static int mtk_nor_transfer_one_message(struct spi_controller *host,
 
 static void mtk_nor_disable_clk(struct mtk_nor *sp)
 {
-	clk_disable_unprepare(sp->spi_clk);
-	clk_disable_unprepare(sp->ctlr_clk);
-	clk_disable_unprepare(sp->axi_clk);
-	clk_disable_unprepare(sp->axi_s_clk);
+	u8 i;
+
+	for (i = 0; i < sp->clock_cnt; i++)
+		clk_disable_unprepare(sp->clocks[i].clki);
 }
 
 static int mtk_nor_enable_clk(struct mtk_nor *sp)
 {
 	int ret;
+	u8 i, j;
 
-	ret = clk_prepare_enable(sp->spi_clk);
-	if (ret)
-		return ret;
+	for (i = 0; i < sp->clock_cnt; i++) {
+		ret = clk_prepare_enable(sp->clocks[i].clki);
+		if (ret) {
+			for (j = 0; j < i; j++)
+				clk_disable_unprepare(sp->clocks[j].clki);
 
-	ret = clk_prepare_enable(sp->ctlr_clk);
-	if (ret) {
-		clk_disable_unprepare(sp->spi_clk);
-		return ret;
+			return ret;
+		}
+
+		if (strcmp(sp->clocks[i].name, "spi"))
+			sp->spi_freq = clk_get_rate(sp->clocks[i].clki);
 	}
 
-	ret = clk_prepare_enable(sp->axi_clk);
-	if (ret) {
-		clk_disable_unprepare(sp->spi_clk);
-		clk_disable_unprepare(sp->ctlr_clk);
-		return ret;
+	return 0;
+}
+
+static int mtk_nor_parse_clk(struct device *dev, struct mtk_nor *sp)
+{
+	struct device_node *np = dev->of_node;
+	int ret;
+	const char *name;
+	u8 cnt, i;
+
+	cnt = of_property_count_strings(np, "clock-names");
+	if (!cnt || (cnt == -EINVAL)) {
+		dev_err(dev, "Unable to find clocks\n");
+		ret = -EINVAL;
+		goto out;
+	} else if (cnt < 0) {
+		dev_err(dev, "Count clock strings failed, err %d\n", cnt);
+		ret = cnt;
+		goto out;
+	} else if (cnt > MAX_CLOCK_CNT) {
+		ret = -EINVAL;
+		goto out;
 	}
 
-	ret = clk_prepare_enable(sp->axi_s_clk);
-	if (ret) {
-		clk_disable_unprepare(sp->spi_clk);
-		clk_disable_unprepare(sp->ctlr_clk);
-		clk_disable_unprepare(sp->axi_clk);
-		return ret;
+	sp->clock_cnt = cnt;
+
+	for (i = 0; i < cnt; i++) {
+		ret = of_property_read_string_index(np, "clock-names", i,
+				       &name);
+		if (ret) {
+			dev_err(dev, "failed to get clock string\n");
+			return ret;
+		}
+
+		sp->clocks[i].name = name;
+		sp->clocks[i].clki = devm_clk_get(dev, sp->clocks[i].name);
+		if (IS_ERR(sp->clocks[i].clki)) {
+			dev_err(dev, "get clock %s fail\n", sp->clocks[i].name);
+			return PTR_ERR(sp->clocks[i].clki);
+		}
 	}
 
-	return 0;
+out:
+	return ret;
 }
 
 static void mtk_nor_init(struct mtk_nor *sp)
@@ -813,29 +850,12 @@ static int mtk_nor_probe(struct platform_device *pdev)
 	struct mtk_nor *sp;
 	struct mtk_nor_caps *caps;
 	void __iomem *base;
-	struct clk *spi_clk, *ctlr_clk, *axi_clk, *axi_s_clk;
 	int ret, irq;
 
 	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
-	spi_clk = devm_clk_get(&pdev->dev, "spi");
-	if (IS_ERR(spi_clk))
-		return PTR_ERR(spi_clk);
-
-	ctlr_clk = devm_clk_get(&pdev->dev, "sf");
-	if (IS_ERR(ctlr_clk))
-		return PTR_ERR(ctlr_clk);
-
-	axi_clk = devm_clk_get_optional(&pdev->dev, "axi");
-	if (IS_ERR(axi_clk))
-		return PTR_ERR(axi_clk);
-
-	axi_s_clk = devm_clk_get_optional(&pdev->dev, "axi_s");
-	if (IS_ERR(axi_s_clk))
-		return PTR_ERR(axi_s_clk);
-
 	caps = (struct mtk_nor_caps *)of_device_get_match_data(&pdev->dev);
 
 	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(caps->dma_bits));
@@ -868,10 +888,6 @@ static int mtk_nor_probe(struct platform_device *pdev)
 	sp->wbuf_en = false;
 	sp->ctlr = ctlr;
 	sp->dev = &pdev->dev;
-	sp->spi_clk = spi_clk;
-	sp->ctlr_clk = ctlr_clk;
-	sp->axi_clk = axi_clk;
-	sp->axi_s_clk = axi_s_clk;
 	sp->caps = caps;
 	sp->high_dma = caps->dma_bits > 32;
 	sp->buffer = dmam_alloc_coherent(&pdev->dev,
@@ -885,11 +901,13 @@ static int mtk_nor_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
-	ret = mtk_nor_enable_clk(sp);
+	ret = mtk_nor_parse_clk(sp->dev, sp);
 	if (ret < 0)
 		return ret;
 
-	sp->spi_freq = clk_get_rate(sp->spi_clk);
+	ret = mtk_nor_enable_clk(sp);
+	if (ret < 0)
+		return ret;
 
 	mtk_nor_init(sp);
 
-- 
2.46.0


