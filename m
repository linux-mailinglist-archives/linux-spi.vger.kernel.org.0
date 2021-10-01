Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5017541F11F
	for <lists+linux-spi@lfdr.de>; Fri,  1 Oct 2021 17:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbhJAPXr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 1 Oct 2021 11:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231869AbhJAPXq (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 1 Oct 2021 11:23:46 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8EBDC061775;
        Fri,  1 Oct 2021 08:22:02 -0700 (PDT)
Received: from guri.fritz.box (unknown [IPv6:2a02:810a:880:f54:dd31:3048:d332:54e2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: dafna)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id E35C21F457D1;
        Fri,  1 Oct 2021 16:21:59 +0100 (BST)
From:   Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
To:     broonie@kernel.org
Cc:     Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        kernel@collabora.com, linux-spi@vger.kernel.org,
        enric.balletbo@collabora.com, dafna3@gmail.com,
        Mason Zhang <Mason.Zhang@mediatek.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: [PATCH v2] spi: mediatek: skip delays if they are 0
Date:   Fri,  1 Oct 2021 17:21:53 +0200
Message-Id: <20211001152153.4604-1-dafna.hirschfeld@collabora.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

In the function 'mtk_spi_set_hw_cs_timing'
the 'setup', 'hold' and 'inactive' delays are configured.
In case those values are 0 it causes errors on mt8173:

cros-ec-i2c-tunnel 1100a000.spi:ec@0:i2c-tunnel0:
	Error transferring EC i2c message -71
cros-ec-spi spi0.0: EC failed to respond in time.

This patch fixes that issues by setting only the values
that are not 0.

Fixes: 04e6bb0d6bb1 ("spi: modify set_cs_timing parameter")
Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
---
Changes since v1: v1 was a revert of the commits
04e6bb0d6bb1 ("spi: modify set_cs_timing parameter")
5c842e51ac63 ("spi: mediatek: fix build warnning in set cs timing")

this version fixes the erros instead of reverting

 drivers/spi/spi-mt65xx.c | 64 ++++++++++++++++++++++------------------
 1 file changed, 36 insertions(+), 28 deletions(-)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index 386e8c84be0a..a15de10ee286 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -233,36 +233,44 @@ static int mtk_spi_set_hw_cs_timing(struct spi_device *spi)
 		return delay;
 	inactive = (delay * DIV_ROUND_UP(mdata->spi_clk_hz, 1000000)) / 1000;
 
-	setup    = setup ? setup : 1;
-	hold     = hold ? hold : 1;
-	inactive = inactive ? inactive : 1;
-
-	reg_val = readl(mdata->base + SPI_CFG0_REG);
-	if (mdata->dev_comp->enhance_timing) {
-		hold = min_t(u32, hold, 0x10000);
-		setup = min_t(u32, setup, 0x10000);
-		reg_val &= ~(0xffff << SPI_ADJUST_CFG0_CS_HOLD_OFFSET);
-		reg_val |= (((hold - 1) & 0xffff)
-			   << SPI_ADJUST_CFG0_CS_HOLD_OFFSET);
-		reg_val &= ~(0xffff << SPI_ADJUST_CFG0_CS_SETUP_OFFSET);
-		reg_val |= (((setup - 1) & 0xffff)
-			   << SPI_ADJUST_CFG0_CS_SETUP_OFFSET);
-	} else {
-		hold = min_t(u32, hold, 0x100);
-		setup = min_t(u32, setup, 0x100);
-		reg_val &= ~(0xff << SPI_CFG0_CS_HOLD_OFFSET);
-		reg_val |= (((hold - 1) & 0xff) << SPI_CFG0_CS_HOLD_OFFSET);
-		reg_val &= ~(0xff << SPI_CFG0_CS_SETUP_OFFSET);
-		reg_val |= (((setup - 1) & 0xff)
-			    << SPI_CFG0_CS_SETUP_OFFSET);
+	if (hold || setup) {
+		reg_val = readl(mdata->base + SPI_CFG0_REG);
+		if (mdata->dev_comp->enhance_timing) {
+			if (hold) {
+				hold = min_t(u32, hold, 0x10000);
+				reg_val &= ~(0xffff << SPI_ADJUST_CFG0_CS_HOLD_OFFSET);
+				reg_val |= (((hold - 1) & 0xffff)
+					<< SPI_ADJUST_CFG0_CS_HOLD_OFFSET);
+			}
+			if (setup) {
+				setup = min_t(u32, setup, 0x10000);
+				reg_val &= ~(0xffff << SPI_ADJUST_CFG0_CS_SETUP_OFFSET);
+				reg_val |= (((setup - 1) & 0xffff)
+					<< SPI_ADJUST_CFG0_CS_SETUP_OFFSET);
+			}
+		} else {
+			if (hold) {
+				hold = min_t(u32, hold, 0x100);
+				reg_val &= ~(0xff << SPI_CFG0_CS_HOLD_OFFSET);
+				reg_val |= (((hold - 1) & 0xff) << SPI_CFG0_CS_HOLD_OFFSET);
+			}
+			if (setup) {
+				setup = min_t(u32, setup, 0x100);
+				reg_val &= ~(0xff << SPI_CFG0_CS_SETUP_OFFSET);
+				reg_val |= (((setup - 1) & 0xff)
+					<< SPI_CFG0_CS_SETUP_OFFSET);
+			}
+		}
+		writel(reg_val, mdata->base + SPI_CFG0_REG);
 	}
-	writel(reg_val, mdata->base + SPI_CFG0_REG);
 
-	inactive = min_t(u32, inactive, 0x100);
-	reg_val = readl(mdata->base + SPI_CFG1_REG);
-	reg_val &= ~SPI_CFG1_CS_IDLE_MASK;
-	reg_val |= (((inactive - 1) & 0xff) << SPI_CFG1_CS_IDLE_OFFSET);
-	writel(reg_val, mdata->base + SPI_CFG1_REG);
+	if (inactive) {
+		inactive = min_t(u32, inactive, 0x100);
+		reg_val = readl(mdata->base + SPI_CFG1_REG);
+		reg_val &= ~SPI_CFG1_CS_IDLE_MASK;
+		reg_val |= (((inactive - 1) & 0xff) << SPI_CFG1_CS_IDLE_OFFSET);
+		writel(reg_val, mdata->base + SPI_CFG1_REG);
+	}
 
 	return 0;
 }
-- 
2.17.1

