Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49C633438DA
	for <lists+linux-spi@lfdr.de>; Mon, 22 Mar 2021 06:54:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbhCVFxv (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 22 Mar 2021 01:53:51 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:26641 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229547AbhCVFxV (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 22 Mar 2021 01:53:21 -0400
X-UUID: 3f6ea8acbda04d57876ad6d2f7ca6cba-20210322
X-UUID: 3f6ea8acbda04d57876ad6d2f7ca6cba-20210322
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <leilk.liu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1882996186; Mon, 22 Mar 2021 13:53:12 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 22 Mar 2021 13:53:08 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 22 Mar 2021 13:53:07 +0800
From:   Leilk Liu <leilk.liu@mediatek.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-spi@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <fparent@baylibre.com>, Leilk Liu <leilk.liu@mediatek.com>
Subject: [PATCH 4/4] spi: mediatek: add mt8195 spi slave support
Date:   Mon, 22 Mar 2021 13:52:44 +0800
Message-ID: <20210322055244.30179-5-leilk.liu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210322055244.30179-1-leilk.liu@mediatek.com>
References: <20210322055244.30179-1-leilk.liu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 3597F3A5F9E48644A278F10701EA652FB15E6B1057F2215D5892DC25101ABE122000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

this patch adds mt8195 spi slave compatible support.

Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
---
 drivers/spi/spi-slave-mt27xx.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/spi/spi-slave-mt27xx.c b/drivers/spi/spi-slave-mt27xx.c
index 7e6fadc88cef..f199a6c4738a 100644
--- a/drivers/spi/spi-slave-mt27xx.c
+++ b/drivers/spi/spi-slave-mt27xx.c
@@ -77,12 +77,20 @@ struct mtk_spi_compatible {
 	const u32 max_fifo_size;
 	bool must_rx;
 };
+
 static const struct mtk_spi_compatible mt2712_compat = {
 	.max_fifo_size = 512,
 };
+static const struct mtk_spi_compatible mt8195_compat = {
+	.max_fifo_size = 128,
+	.must_rx = true,
+};
+
 static const struct of_device_id mtk_spi_slave_of_match[] = {
 	{ .compatible = "mediatek,mt2712-spi-slave",
 	  .data = (void *)&mt2712_compat,},
+	{ .compatible = "mediatek,mt8195-spi-slave",
+	  .data = (void *)&mt8195_compat,},
 	{}
 };
 MODULE_DEVICE_TABLE(of, mtk_spi_slave_of_match);
-- 
2.18.0

