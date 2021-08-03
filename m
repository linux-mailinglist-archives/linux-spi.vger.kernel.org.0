Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1DD83DEB20
	for <lists+linux-spi@lfdr.de>; Tue,  3 Aug 2021 12:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235341AbhHCKln (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 3 Aug 2021 06:41:43 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:47752 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S235398AbhHCKlm (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 3 Aug 2021 06:41:42 -0400
X-UUID: 2a88cbcd37d6414291ecc8a074b8d9d1-20210803
X-UUID: 2a88cbcd37d6414291ecc8a074b8d9d1-20210803
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <mason.zhang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1291082287; Tue, 03 Aug 2021 18:41:29 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 3 Aug 2021 18:41:28 +0800
Received: from localhost.localdomain (10.15.20.246) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 3 Aug 2021 18:41:27 +0800
From:   Mason Zhang <Mason.Zhang@mediatek.com>
To:     Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Laxman Dewangan <ldewangan@nvidia.com>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        Mason Zhang <Mason.Zhang@mediatek.com>
Subject: [PATCH v2 3/4] spi: mediatek: modify set_cs_timing callback
Date:   Tue, 3 Aug 2021 18:24:29 +0800
Message-ID: <20210803102428.6476-1-Mason.Zhang@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This patch modified set_cs_timing callback:
  1 support spi_device set cs_timing in their driver;
  2 support set absolute time but no clk count, because;
    clk src will change in different platform;
  3 call this function in prepare_message but not in other API.

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

