Return-Path: <linux-spi+bounces-6982-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1973A4BF27
	for <lists+linux-spi@lfdr.de>; Mon,  3 Mar 2025 12:45:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 250721657E4
	for <lists+linux-spi@lfdr.de>; Mon,  3 Mar 2025 11:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 079A12066F3;
	Mon,  3 Mar 2025 11:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="JjNJeRbk"
X-Original-To: linux-spi@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBEC2063FB;
	Mon,  3 Mar 2025 11:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741002350; cv=none; b=Hu6hI0ScmEUgxlGmhrXll396+WVb5JVBDmxxSCGWAu+PpVjGUtuu9ItDvF7ob5C3A1Lwx7l8BZxAQFUOMiwYL6cM9975hi2gJ3/VknDXlEHrZTgj91cnXoOX0T6QnsHvA1kp8aQ95kVhhcmH3ToExdrKOxL2HtXgmMR7IsilQco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741002350; c=relaxed/simple;
	bh=yfh60pxplQouyVIZ0XXgVKzLPvOXQPcH/ahecH04GmY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Hc8RXXZ0quVnssTRshxQMWSzZcXqhjJ72rDBlXnLQLIRpS3f/yl9olFL0dVFo9KRGDSSrgKKbzSiCl1K0WK4r1nvgXFCq+/Zr4D6EmypMSRd5pi2NAWbFxSyCqYC4YMP3WSk4c9wtm3fCPwr4JMlwxNYDI1DQic8961pkoH5nVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=JjNJeRbk; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 0a212abef82511efaae1fd9735fae912-20250303
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=LwCVeFpA/Piyu+6TIfX5BmaS9Ohc00hSvCtLpd0ifXo=;
	b=JjNJeRbkEoeHHvxxflOd+eHgf9j8pfqdyqCSnh92L1ZF3nNgYuQ2/Hl8d7D5LIXib86UuZpFMcyz1FjyHf6HsyLWldKVvxInxZj2QVEmkZtabpMi01JFtSEkAjUOS/vZ2QgmEriRsuqUYGuPmygmIaQoJOIc19GtM5K6CexvZe8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:d879ec84-6e90-422a-8214-892794b3f111,IP:0,UR
	L:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-25
X-CID-META: VersionHash:0ef645f,CLOUDID:206b7629-e0f8-414e-b8c3-b75c08217be8,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 0a212abef82511efaae1fd9735fae912-20250303
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
	(envelope-from <cloud.zhang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1350380792; Mon, 03 Mar 2025 19:45:43 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 3 Mar 2025 19:45:42 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Mon, 3 Mar 2025 19:45:42 +0800
From: mtk22730 <Cloud.Zhang@mediatek.com>
To: Mark Brown <broonie@kernel.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, mtk22730
	<Cloud.Zhang@mediatek.com>, Cloud Zhang <cloud.zhang@mediatek.com>
Subject: [v2] spi: spi-mtk-nor: Modify the clock architecture of nor controller
Date: Mon, 3 Mar 2025 19:45:07 +0800
Message-ID: <20250303114540.1617-1-Cloud.Zhang@mediatek.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The clocks used by different platforms are not same. So it is
necessary to modify the clock architecture to be adaptable to more
platforms.

Signed-off-by: Cloud Zhang <cloud.zhang@mediatek.com>
---
Changes in v2:
  -Use clk_bulk_xxx related functions to enable/disable clocks.

Changes in v1:
  -Add new function mtk_nor_parse_clk() to parse nor clock parameters.
---
---
 drivers/spi/spi-mtk-nor.c | 103 ++++++++++++++++++++------------------
 1 file changed, 54 insertions(+), 49 deletions(-)

diff --git a/drivers/spi/spi-mtk-nor.c b/drivers/spi/spi-mtk-nor.c
index 85ab5ce96c4d..4863b9cb2706 100644
--- a/drivers/spi/spi-mtk-nor.c
+++ b/drivers/spi/spi-mtk-nor.c
@@ -99,6 +99,8 @@
 
 #define CLK_TO_US(sp, clkcnt)		DIV_ROUND_UP(clkcnt, sp->spi_freq / 1000000)
 
+#define MAX_CLOCK_CNT		6
+
 struct mtk_nor_caps {
 	u8 dma_bits;
 
@@ -116,10 +118,8 @@ struct mtk_nor {
 	void __iomem *base;
 	u8 *buffer;
 	dma_addr_t buffer_dma;
-	struct clk *spi_clk;
-	struct clk *ctlr_clk;
-	struct clk *axi_clk;
-	struct clk *axi_s_clk;
+	struct clk_bulk_data clocks[MAX_CLOCK_CNT];
+	int clock_cnt;
 	unsigned int spi_freq;
 	bool wbuf_en;
 	bool has_irq;
@@ -703,44 +703,68 @@ static int mtk_nor_transfer_one_message(struct spi_controller *host,
 
 static void mtk_nor_disable_clk(struct mtk_nor *sp)
 {
-	clk_disable_unprepare(sp->spi_clk);
-	clk_disable_unprepare(sp->ctlr_clk);
-	clk_disable_unprepare(sp->axi_clk);
-	clk_disable_unprepare(sp->axi_s_clk);
+	clk_bulk_disable_unprepare(sp->clock_cnt, sp->clocks);
 }
 
 static int mtk_nor_enable_clk(struct mtk_nor *sp)
 {
 	int ret;
+	int i;
 
-	ret = clk_prepare_enable(sp->spi_clk);
-	if (ret)
-		return ret;
-
-	ret = clk_prepare_enable(sp->ctlr_clk);
+	ret = clk_bulk_prepare_enable(sp->clock_cnt, sp->clocks);
 	if (ret) {
-		clk_disable_unprepare(sp->spi_clk);
+		dev_err(sp->dev, "enable clk failed\n");
 		return ret;
 	}
 
-	ret = clk_prepare_enable(sp->axi_clk);
-	if (ret) {
-		clk_disable_unprepare(sp->spi_clk);
-		clk_disable_unprepare(sp->ctlr_clk);
-		return ret;
-	}
+	for (i = 0; i < sp->clock_cnt; i++) {
+		if (IS_ERR(sp->clocks[i].clk)) {
+			dev_err(sp->dev, "get %s fail\n", sp->clocks[i].id);
+			return PTR_ERR(sp->clocks[i].clk);
+		}
 
-	ret = clk_prepare_enable(sp->axi_s_clk);
-	if (ret) {
-		clk_disable_unprepare(sp->spi_clk);
-		clk_disable_unprepare(sp->ctlr_clk);
-		clk_disable_unprepare(sp->axi_clk);
-		return ret;
+		if (!strcmp(sp->clocks[i].id, "spi"))
+			sp->spi_freq = clk_get_rate(sp->clocks[i].clk);
 	}
 
 	return 0;
 }
 
+static int mtk_nor_parse_clk(struct device *dev, struct mtk_nor *sp)
+{
+	struct device_node *np = dev->of_node;
+	int ret;
+	const char *name;
+	int cnt, i;
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
+	}
+
+	sp->clock_cnt = cnt;
+	for (i = 0; i < cnt; i++) {
+		ret = of_property_read_string_index(np, "clock-names", i, &name);
+		if (ret) {
+			dev_err(dev, "failed to get clock string\n");
+			return ret;
+		}
+
+		sp->clocks[i].id = name;
+	}
+
+	ret = devm_clk_bulk_get(dev, sp->clock_cnt, sp->clocks);
+
+out:
+	return ret;
+}
+
 static void mtk_nor_init(struct mtk_nor *sp)
 {
 	writel(0, sp->base + MTK_NOR_REG_IRQ_EN);
@@ -813,29 +837,12 @@ static int mtk_nor_probe(struct platform_device *pdev)
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
@@ -868,10 +875,6 @@ static int mtk_nor_probe(struct platform_device *pdev)
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
@@ -885,11 +888,13 @@ static int mtk_nor_probe(struct platform_device *pdev)
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


