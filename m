Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D64D53CD0F7
	for <lists+linux-spi@lfdr.de>; Mon, 19 Jul 2021 11:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236054AbhGSIwu (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 19 Jul 2021 04:52:50 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:51032 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S235963AbhGSIws (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 19 Jul 2021 04:52:48 -0400
X-UUID: 99e2966c8f2a4c629b1003e16592dc69-20210719
X-UUID: 99e2966c8f2a4c629b1003e16592dc69-20210719
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <mason.zhang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1241152251; Mon, 19 Jul 2021 17:33:26 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 19 Jul 2021 17:33:24 +0800
Received: from localhost.localdomain (10.15.20.246) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 19 Jul 2021 17:33:24 +0800
From:   Mason Zhang <mason.zhang@mediatek.com>
To:     Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <leilk.liu@mediatek.com>,
        <wsd_upstream@mediatek.com>, Mason Zhang <Mason.Zhang@mediatek.com>
Subject: [PATCH 3/3] spi: mediatek: modify set_cs_timing callback
Date:   Mon, 19 Jul 2021 17:17:08 +0800
Message-ID: <20210719091707.31664-1-mason.zhang@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Mason Zhang <Mason.Zhang@mediatek.com>

This patch modified set_cs_timing callback:
1. support spi_device set cs_timing in their driver;
2. support set absolute time but no clk count, because;
clk src will change in different platform;
3. call this function in prepare_message but not in other API.

Signed-off-by: Mason Zhang <Mason.Zhang@mediatek.com>
---
 drivers/spi/spi-mt65xx.c | 102 +++++++++++++++++++++------------------
 1 file changed, 56 insertions(+), 46 deletions(-)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index 6f2925118b98..7a34f5b1201d 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -208,6 +208,60 @@ static void mtk_spi_reset(struct mtk_spi *mdata)
 	writel(reg_val, mdata->base + SPI_CMD_REG);
 }
 
+static int mtk_spi_set_hw_cs_timing(struct spi_device *spi)
+{
+	struct mtk_spi *mdata = spi_master_get_devdata(spi->master);
+	struct spi_delay *cs_setup = &spi->cs_setup;
+	struct spi_delay *cs_hold = &spi->cs_hold;
+	struct spi_delay *cs_inactive = &spi->cs_inactive;
+	u16 setup, hold, inactive;
+	u32 reg_val;
+	int delay;
+
+	delay = spi_delay_to_ns(cs_setup, NULL);
+	if (delay < 0)
+		return delay;
+	setup = (delay / 1000) * DIV_ROUND_UP(mdata->spi_clk_hz, 1000000);
+
+	delay = spi_delay_to_ns(cs_hold, NULL);
+	if (delay < 0)
+		return delay;
+	hold = (delay / 1000) * DIV_ROUND_UP(mdata->spi_clk_hz, 1000000);
+
+	delay = spi_delay_to_ns(cs_inactive, NULL);
+	if (delay < 0)
+		return delay;
+	inactive = (delay / 1000) * DIV_ROUND_UP(mdata->spi_clk_hz, 1000000);
+
+	setup    = setup ? setup : 1;
+	hold     = hold ? hold : 1;
+	inactive = inactive ? inactive : 1;
+
+	reg_val = readl(mdata->base + SPI_CFG0_REG);
+	if (mdata->dev_comp->enhance_timing) {
+		reg_val &= ~(0xffff << SPI_ADJUST_CFG0_CS_HOLD_OFFSET);
+		reg_val |= (((hold - 1) & 0xffff)
+			   << SPI_ADJUST_CFG0_CS_HOLD_OFFSET);
+		reg_val &= ~(0xffff << SPI_ADJUST_CFG0_CS_SETUP_OFFSET);
+		reg_val |= (((setup - 1) & 0xffff)
+			   << SPI_ADJUST_CFG0_CS_SETUP_OFFSET);
+	} else {
+		reg_val &= ~(0xff << SPI_CFG0_CS_HOLD_OFFSET);
+		reg_val |= (((hold - 1) & 0xff) << SPI_CFG0_CS_HOLD_OFFSET);
+		reg_val &= ~(0xff << SPI_CFG0_CS_SETUP_OFFSET);
+		reg_val |= (((setup - 1) & 0xff)
+			    << SPI_CFG0_CS_SETUP_OFFSET);
+	}
+	writel(reg_val, mdata->base + SPI_CFG0_REG);
+
+	reg_val = readl(mdata->base + SPI_CFG1_REG);
+	reg_val &= ~SPI_CFG1_CS_IDLE_MASK;
+	reg_val |= (((inactive - 1) & 0xff) << SPI_CFG1_CS_IDLE_OFFSET);
+	writel(reg_val, mdata->base + SPI_CFG1_REG);
+
+	return 0;
+}
+
 static int mtk_spi_prepare_message(struct spi_master *master,
 				   struct spi_message *msg)
 {
@@ -284,6 +338,8 @@ static int mtk_spi_prepare_message(struct spi_master *master,
 		<< SPI_CFG1_GET_TICK_DLY_OFFSET);
 	writel(reg_val, mdata->base + SPI_CFG1_REG);
 
+	/* set hw cs timing */
+	mtk_spi_set_hw_cs_timing(spi);
 	return 0;
 }
 
@@ -528,52 +584,6 @@ static bool mtk_spi_can_dma(struct spi_master *master,
 		(unsigned long)xfer->rx_buf % 4 == 0);
 }
 
-static int mtk_spi_set_hw_cs_timing(struct spi_device *spi,
-				    struct spi_delay *setup,
-				    struct spi_delay *hold,
-				    struct spi_delay *inactive)
-{
-	struct mtk_spi *mdata = spi_master_get_devdata(spi->master);
-	u16 setup_dly, hold_dly, inactive_dly;
-	u32 reg_val;
-
-	if ((setup && setup->unit != SPI_DELAY_UNIT_SCK) ||
-	    (hold && hold->unit != SPI_DELAY_UNIT_SCK) ||
-	    (inactive && inactive->unit != SPI_DELAY_UNIT_SCK)) {
-		dev_err(&spi->dev,
-			"Invalid delay unit, should be SPI_DELAY_UNIT_SCK\n");
-		return -EINVAL;
-	}
-
-	setup_dly = setup ? setup->value : 1;
-	hold_dly = hold ? hold->value : 1;
-	inactive_dly = inactive ? inactive->value : 1;
-
-	reg_val = readl(mdata->base + SPI_CFG0_REG);
-	if (mdata->dev_comp->enhance_timing) {
-		reg_val &= ~(0xffff << SPI_ADJUST_CFG0_CS_HOLD_OFFSET);
-		reg_val |= (((hold_dly - 1) & 0xffff)
-			   << SPI_ADJUST_CFG0_CS_HOLD_OFFSET);
-		reg_val &= ~(0xffff << SPI_ADJUST_CFG0_CS_SETUP_OFFSET);
-		reg_val |= (((setup_dly - 1) & 0xffff)
-			   << SPI_ADJUST_CFG0_CS_SETUP_OFFSET);
-	} else {
-		reg_val &= ~(0xff << SPI_CFG0_CS_HOLD_OFFSET);
-		reg_val |= (((hold_dly - 1) & 0xff) << SPI_CFG0_CS_HOLD_OFFSET);
-		reg_val &= ~(0xff << SPI_CFG0_CS_SETUP_OFFSET);
-		reg_val |= (((setup_dly - 1) & 0xff)
-			    << SPI_CFG0_CS_SETUP_OFFSET);
-	}
-	writel(reg_val, mdata->base + SPI_CFG0_REG);
-
-	reg_val = readl(mdata->base + SPI_CFG1_REG);
-	reg_val &= ~SPI_CFG1_CS_IDLE_MASK;
-	reg_val |= (((inactive_dly - 1) & 0xff) << SPI_CFG1_CS_IDLE_OFFSET);
-	writel(reg_val, mdata->base + SPI_CFG1_REG);
-
-	return 0;
-}
-
 static int mtk_spi_setup(struct spi_device *spi)
 {
 	struct mtk_spi *mdata = spi_master_get_devdata(spi->master);
-- 
2.18.0

