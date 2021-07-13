Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74D413C700F
	for <lists+linux-spi@lfdr.de>; Tue, 13 Jul 2021 13:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235919AbhGMMC2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 13 Jul 2021 08:02:28 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:41054 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S235797AbhGMMC2 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 13 Jul 2021 08:02:28 -0400
X-UUID: bc9aa24003bc4abbbcb5e7b476c21f65-20210713
X-UUID: bc9aa24003bc4abbbcb5e7b476c21f65-20210713
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <mason.zhang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 748022706; Tue, 13 Jul 2021 19:59:34 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 13 Jul 2021 19:59:22 +0800
Received: from localhost.localdomain (10.15.20.246) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 13 Jul 2021 19:59:21 +0800
From:   Mason Zhang <mason.zhang@mediatek.com>
To:     Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <leilk.liu@mediatek.com>,
        <wsd_upstream@mediatek.com>, Mason Zhang <Mason.Zhang@mediatek.com>
Subject: [PATCH 2/2] spi: mediatek: move devm_spi_register_master position
Date:   Tue, 13 Jul 2021 19:42:48 +0800
Message-ID: <20210713114247.1536-1-mason.zhang@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Mason Zhang <Mason.Zhang@mediatek.com>

This patch move devm_spi_register_master to the end of mtk_spi_probe.
If slaves call spi_sync in there probe function, master should have probe done.

Signed-off-by: Mason Zhang <Mason.Zhang@mediatek.com>
---
 drivers/spi/spi-mt65xx.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index b34fbc913fd6..6f2925118b98 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -820,12 +820,6 @@ static int mtk_spi_probe(struct platform_device *pdev)
 
 	pm_runtime_enable(&pdev->dev);
 
-	ret = devm_spi_register_master(&pdev->dev, master);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to register master (%d)\n", ret);
-		goto err_disable_runtime_pm;
-	}
-
 	if (mdata->dev_comp->need_pad_sel) {
 		if (mdata->pad_num != master->num_chipselect) {
 			dev_err(&pdev->dev,
@@ -865,6 +859,12 @@ static int mtk_spi_probe(struct platform_device *pdev)
 		dev_notice(&pdev->dev, "SPI dma_set_mask(%d) failed, ret:%d\n",
 			   addr_bits, ret);
 
+	ret = devm_spi_register_master(&pdev->dev, master);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to register master (%d)\n", ret);
+		goto err_disable_runtime_pm;
+	}
+
 	return 0;
 
 err_disable_runtime_pm:
-- 
2.18.0

