Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6C2A3C700D
	for <lists+linux-spi@lfdr.de>; Tue, 13 Jul 2021 13:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235983AbhGMMAr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 13 Jul 2021 08:00:47 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:38742 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S235797AbhGMMAr (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 13 Jul 2021 08:00:47 -0400
X-UUID: 902a55c266aa41bd95fdcbfd5356fe29-20210713
X-UUID: 902a55c266aa41bd95fdcbfd5356fe29-20210713
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <mason.zhang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1492047116; Tue, 13 Jul 2021 19:57:54 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 13 Jul 2021 19:57:52 +0800
Received: from localhost.localdomain (10.15.20.246) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 13 Jul 2021 19:57:52 +0800
From:   Mason Zhang <mason.zhang@mediatek.com>
To:     Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <leilk.liu@mediatek.com>,
        <wsd_upstream@mediatek.com>, Mason Zhang <Mason.Zhang@mediatek.com>
Subject: [PATCH 1/2] spi: mediatek: add tick_delay support
Date:   Tue, 13 Jul 2021 19:40:49 +0800
Message-ID: <20210713114048.29509-1-mason.zhang@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Mason Zhang <Mason.Zhang@mediatek.com>

This patch support tick_delay setting, some users need use
high-speed spi speed, which can use tick_delay to tuning spi clk timing.

Signed-off-by: Mason Zhang <Mason.Zhang@mediatek.com>
---
 drivers/spi/spi-mt65xx.c                 | 11 ++++++++++-
 include/linux/platform_data/spi-mt65xx.h |  1 +
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index 097625d7915e..b34fbc913fd6 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -42,8 +42,9 @@
 #define SPI_CFG1_CS_IDLE_OFFSET           0
 #define SPI_CFG1_PACKET_LOOP_OFFSET       8
 #define SPI_CFG1_PACKET_LENGTH_OFFSET     16
-#define SPI_CFG1_GET_TICK_DLY_OFFSET      30
+#define SPI_CFG1_GET_TICK_DLY_OFFSET      29
 
+#define SPI_CFG1_GET_TICK_DLY_MASK        0xe0000000
 #define SPI_CFG1_CS_IDLE_MASK             0xff
 #define SPI_CFG1_PACKET_LOOP_MASK         0xff00
 #define SPI_CFG1_PACKET_LENGTH_MASK       0x3ff0000
@@ -152,6 +153,7 @@ static const struct mtk_spi_compatible mt6893_compat = {
  */
 static const struct mtk_chip_config mtk_default_chip_info = {
 	.sample_sel = 0,
+	.tick_delay = 0,
 };
 
 static const struct of_device_id mtk_spi_of_match[] = {
@@ -275,6 +277,13 @@ static int mtk_spi_prepare_message(struct spi_master *master,
 		writel(mdata->pad_sel[spi->chip_select],
 		       mdata->base + SPI_PAD_SEL_REG);
 
+	/* tick delay */
+	reg_val = readl(mdata->base + SPI_CFG1_REG);
+	reg_val &= ~SPI_CFG1_GET_TICK_DLY_MASK;
+	reg_val |= ((chip_config->tick_delay & 0x7)
+		<< SPI_CFG1_GET_TICK_DLY_OFFSET);
+	writel(reg_val, mdata->base + SPI_CFG1_REG);
+
 	return 0;
 }
 
diff --git a/include/linux/platform_data/spi-mt65xx.h b/include/linux/platform_data/spi-mt65xx.h
index 65fd5ffd257c..f0db674f07b8 100644
--- a/include/linux/platform_data/spi-mt65xx.h
+++ b/include/linux/platform_data/spi-mt65xx.h
@@ -12,5 +12,6 @@
 /* Board specific platform_data */
 struct mtk_chip_config {
 	u32 sample_sel;
+	u32 tick_delay;
 };
 #endif
-- 
2.18.0

