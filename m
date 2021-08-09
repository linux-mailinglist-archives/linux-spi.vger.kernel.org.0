Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7CCD3E3F7C
	for <lists+linux-spi@lfdr.de>; Mon,  9 Aug 2021 08:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231801AbhHIGB6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Aug 2021 02:01:58 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:51390 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229483AbhHIGB6 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 9 Aug 2021 02:01:58 -0400
X-UUID: 9113354633154d349f0240378f5a3eba-20210809
X-UUID: 9113354633154d349f0240378f5a3eba-20210809
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <mason.zhang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 625483577; Mon, 09 Aug 2021 14:01:32 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 9 Aug 2021 14:01:32 +0800
Received: from localhost.localdomain (10.15.20.246) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 9 Aug 2021 14:01:31 +0800
From:   Mason Zhang <Mason.Zhang@mediatek.com>
To:     Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        Mason Zhang <Mason.Zhang@mediatek.com>
Subject: [PATCH 1/1] spi: mediatek: fix build warnning in set cs timing
Date:   Mon, 9 Aug 2021 13:59:12 +0800
Message-ID: <20210809055911.17538-1-Mason.Zhang@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

this patch fixed the build warnning in set cs timing.

Signed-off-by: Mason Zhang <Mason.Zhang@mediatek.com>
---
 drivers/spi/spi-mt65xx.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index bb09592bc009..2f83599642fd 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -214,7 +214,7 @@ static int mtk_spi_set_hw_cs_timing(struct spi_device *spi)
 	struct spi_delay *cs_setup = &spi->cs_setup;
 	struct spi_delay *cs_hold = &spi->cs_hold;
 	struct spi_delay *cs_inactive = &spi->cs_inactive;
-	u16 setup, hold, inactive;
+	u32 setup, hold, inactive;
 	u32 reg_val;
 	int delay;
 
@@ -239,8 +239,8 @@ static int mtk_spi_set_hw_cs_timing(struct spi_device *spi)
 
 	reg_val = readl(mdata->base + SPI_CFG0_REG);
 	if (mdata->dev_comp->enhance_timing) {
-		hold = min(hold, 0xffff);
-		setup = min(setup, 0xffff);
+		hold = min_t(u32, hold, 0x10000);
+		setup = min_t(u32, setup, 0x10000);
 		reg_val &= ~(0xffff << SPI_ADJUST_CFG0_CS_HOLD_OFFSET);
 		reg_val |= (((hold - 1) & 0xffff)
 			   << SPI_ADJUST_CFG0_CS_HOLD_OFFSET);
@@ -248,8 +248,8 @@ static int mtk_spi_set_hw_cs_timing(struct spi_device *spi)
 		reg_val |= (((setup - 1) & 0xffff)
 			   << SPI_ADJUST_CFG0_CS_SETUP_OFFSET);
 	} else {
-		hold = min(hold, 0xff);
-		setup = min(setup, 0xff);
+		hold = min_t(u32, hold, 0x100);
+		setup = min_t(u32, setup, 0x100);
 		reg_val &= ~(0xff << SPI_CFG0_CS_HOLD_OFFSET);
 		reg_val |= (((hold - 1) & 0xff) << SPI_CFG0_CS_HOLD_OFFSET);
 		reg_val &= ~(0xff << SPI_CFG0_CS_SETUP_OFFSET);
@@ -258,7 +258,7 @@ static int mtk_spi_set_hw_cs_timing(struct spi_device *spi)
 	}
 	writel(reg_val, mdata->base + SPI_CFG0_REG);
 
-	inactive = min(inactive, 0xff);
+	inactive = min_t(u32, inactive, 0x100);
 	reg_val = readl(mdata->base + SPI_CFG1_REG);
 	reg_val &= ~SPI_CFG1_CS_IDLE_MASK;
 	reg_val |= (((inactive - 1) & 0xff) << SPI_CFG1_CS_IDLE_OFFSET);
-- 
2.18.0

