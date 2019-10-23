Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF92BE1AF9
	for <lists+linux-spi@lfdr.de>; Wed, 23 Oct 2019 14:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391429AbfJWMmU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 23 Oct 2019 08:42:20 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:20758 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2389887AbfJWMmU (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 23 Oct 2019 08:42:20 -0400
X-UUID: 35fdebd5099745e5b87bf119d7f48853-20191023
X-UUID: 35fdebd5099745e5b87bf119d7f48853-20191023
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw01.mediatek.com
        (envelope-from <luhua.xu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1724853019; Wed, 23 Oct 2019 20:42:16 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 23 Oct 2019 20:42:11 +0800
Received: from localhost.localdomain (10.15.20.246) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 23 Oct 2019 20:42:11 +0800
From:   Luhua Xu <luhua.xu@mediatek.com>
To:     Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>,
        <luhua.xu@mediatek.com>
Subject: [PATCH 1/1] spi: mediatek: add power control when set_cs
Date:   Wed, 23 Oct 2019 08:38:42 -0400
Message-ID: <1571834322-1121-2-git-send-email-luhua.xu@mediatek.com>
X-Mailer: git-send-email 2.6.4
In-Reply-To: <1571834322-1121-1-git-send-email-luhua.xu@mediatek.com>
References: <1571834322-1121-1-git-send-email-luhua.xu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: "luhua.xu" <luhua.xu@mediatek.com>

Use runtime PM to power spi when set_cs
As set_cs may be called from interrupt context,
set runtime PM IRQ safe for spi.

Signed-off-by: luhua.xu <luhua.xu@mediatek.com>
---
 drivers/spi/spi-mt65xx.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index 6888a4d..039b67d 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -262,8 +262,16 @@ static int mtk_spi_prepare_message(struct spi_master *master,
 static void mtk_spi_set_cs(struct spi_device *spi, bool enable)
 {
 	u32 reg_val;
+	int ret;
 	struct mtk_spi *mdata = spi_master_get_devdata(spi->master);
 
+	ret = pm_runtime_get_sync(spi->master->dev.parent);
+	if (ret < 0) {
+		pm_runtime_put_noidle(spi->master->dev.parent);
+		dev_err(&spi->dev, "failed to power device(%d)\n", ret);
+		return;
+	}
+
 	reg_val = readl(mdata->base + SPI_CMD_REG);
 	if (!enable) {
 		reg_val |= SPI_CMD_PAUSE_EN;
@@ -274,6 +282,9 @@ static void mtk_spi_set_cs(struct spi_device *spi, bool enable)
 		mdata->state = MTK_SPI_IDLE;
 		mtk_spi_reset(mdata);
 	}
+
+	pm_runtime_mark_last_busy(spi->master->dev.parent);
+	pm_runtime_put_autosuspend(spi->master->dev.parent);
 }
 
 static void mtk_spi_prepare_transfer(struct spi_master *master,
@@ -749,6 +760,7 @@ static int mtk_spi_probe(struct platform_device *pdev)
 	clk_disable_unprepare(mdata->spi_clk);
 
 	pm_runtime_enable(&pdev->dev);
+	pm_runtime_irq_safe(&pdev->dev);
 
 	ret = devm_spi_register_master(&pdev->dev, master);
 	if (ret) {
-- 
2.6.4

