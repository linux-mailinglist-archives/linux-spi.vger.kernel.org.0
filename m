Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 119573B7086
	for <lists+linux-spi@lfdr.de>; Tue, 29 Jun 2021 12:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232804AbhF2K0y (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 29 Jun 2021 06:26:54 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:60413 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232692AbhF2K0y (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 29 Jun 2021 06:26:54 -0400
X-UUID: 1a86f1fa32a54a9d8a2b7c36e418078d-20210629
X-UUID: 1a86f1fa32a54a9d8a2b7c36e418078d-20210629
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <mason.zhang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 568761973; Tue, 29 Jun 2021 18:24:23 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 29 Jun 2021 18:24:21 +0800
Received: from localhost.localdomain (10.15.20.246) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 29 Jun 2021 18:24:20 +0800
From:   Mason Zhang <mason.zhang@mediatek.com>
To:     Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <leilk.liu@mediatek.com>,
        <wsd_upstream@mediatek.com>, Mason Zhang <Mason.Zhang@mediatek.com>
Subject: [PATCH 1/2] spi: mediatek: add no_need_unprepare support
Date:   Tue, 29 Jun 2021 18:08:15 +0800
Message-ID: <20210629100814.21402-1-mason.zhang@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Mason Zhang <Mason.Zhang@mediatek.com>

This patch add no_need_unprepare support for spi, if spi src clk is
MAIN PLL, it can keep the clk_prepare and will not cause low power
issue. So we no need do clk_prepare/clk_unprepare in runtime pm,
and it will get better performance, because clk_prepare has called
mutex lock.
In the same way,
clk_get_rate also has called mutex lock, so we moved it to spi_probe.

Signed-off-by: Mason Zhang <Mason.Zhang@mediatek.com>
---
 drivers/spi/spi-mt65xx.c | 41 +++++++++++++++++++++++++++++++++-------
 1 file changed, 34 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index 976f73b9e299..097625d7915e 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -90,6 +90,8 @@ struct mtk_spi_compatible {
 	bool enhance_timing;
 	/* some IC support DMA addr extension */
 	bool dma_ext;
+	/* some IC no need unprepare SPI clk */
+	bool no_need_unprepare;
 };
 
 struct mtk_spi {
@@ -104,6 +106,7 @@ struct mtk_spi {
 	struct scatterlist *tx_sgl, *rx_sgl;
 	u32 tx_sgl_len, rx_sgl_len;
 	const struct mtk_spi_compatible *dev_comp;
+	u32 spi_clk_hz;
 };
 
 static const struct mtk_spi_compatible mtk_common_compat;
@@ -135,6 +138,14 @@ static const struct mtk_spi_compatible mt8183_compat = {
 	.enhance_timing = true,
 };
 
+static const struct mtk_spi_compatible mt6893_compat = {
+	.need_pad_sel = true,
+	.must_tx = true,
+	.enhance_timing = true,
+	.dma_ext = true,
+	.no_need_unprepare = true,
+};
+
 /*
  * A piece of default chip info unless the platform
  * supplies it.
@@ -174,6 +185,9 @@ static const struct of_device_id mtk_spi_of_match[] = {
 	{ .compatible = "mediatek,mt8192-spi",
 		.data = (void *)&mt6765_compat,
 	},
+	{ .compatible = "mediatek,mt6893-spi",
+		.data = (void *)&mt6893_compat,
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(of, mtk_spi_of_match);
@@ -287,12 +301,11 @@ static void mtk_spi_set_cs(struct spi_device *spi, bool enable)
 static void mtk_spi_prepare_transfer(struct spi_master *master,
 				     struct spi_transfer *xfer)
 {
-	u32 spi_clk_hz, div, sck_time, reg_val;
+	u32 div, sck_time, reg_val;
 	struct mtk_spi *mdata = spi_master_get_devdata(master);
 
-	spi_clk_hz = clk_get_rate(mdata->spi_clk);
-	if (xfer->speed_hz < spi_clk_hz / 2)
-		div = DIV_ROUND_UP(spi_clk_hz, xfer->speed_hz);
+	if (xfer->speed_hz < mdata->spi_clk_hz / 2)
+		div = DIV_ROUND_UP(mdata->spi_clk_hz, xfer->speed_hz);
 	else
 		div = 1;
 
@@ -789,7 +802,12 @@ static int mtk_spi_probe(struct platform_device *pdev)
 		goto err_put_master;
 	}
 
-	clk_disable_unprepare(mdata->spi_clk);
+	mdata->spi_clk_hz = clk_get_rate(mdata->spi_clk);
+
+	if (mdata->dev_comp->no_need_unprepare)
+		clk_disable(mdata->spi_clk);
+	else
+		clk_disable_unprepare(mdata->spi_clk);
 
 	pm_runtime_enable(&pdev->dev);
 
@@ -857,6 +875,9 @@ static int mtk_spi_remove(struct platform_device *pdev)
 
 	mtk_spi_reset(mdata);
 
+	if (mdata->dev_comp->no_need_unprepare)
+		clk_unprepare(mdata->spi_clk);
+
 	return 0;
 }
 
@@ -905,7 +926,10 @@ static int mtk_spi_runtime_suspend(struct device *dev)
 	struct spi_master *master = dev_get_drvdata(dev);
 	struct mtk_spi *mdata = spi_master_get_devdata(master);
 
-	clk_disable_unprepare(mdata->spi_clk);
+	if (mdata->dev_comp->no_need_unprepare)
+		clk_disable(mdata->spi_clk);
+	else
+		clk_disable_unprepare(mdata->spi_clk);
 
 	return 0;
 }
@@ -916,7 +940,10 @@ static int mtk_spi_runtime_resume(struct device *dev)
 	struct mtk_spi *mdata = spi_master_get_devdata(master);
 	int ret;
 
-	ret = clk_prepare_enable(mdata->spi_clk);
+	if (mdata->dev_comp->no_need_unprepare)
+		ret = clk_enable(mdata->spi_clk);
+	else
+		ret = clk_prepare_enable(mdata->spi_clk);
 	if (ret < 0) {
 		dev_err(dev, "failed to enable spi_clk (%d)\n", ret);
 		return ret;
-- 
2.18.0

