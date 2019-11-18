Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF7A8100AC7
	for <lists+linux-spi@lfdr.de>; Mon, 18 Nov 2019 18:49:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbfKRRtE (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 18 Nov 2019 12:49:04 -0500
Received: from foss.arm.com ([217.140.110.172]:37906 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726314AbfKRRtD (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 18 Nov 2019 12:49:03 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0EE9EDA7;
        Mon, 18 Nov 2019 09:49:03 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 72FE23F703;
        Mon, 18 Nov 2019 09:49:02 -0800 (PST)
Date:   Mon, 18 Nov 2019 17:49:00 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Luhua Xu <luhua.xu@mediatek.com>
Cc:     Allison Randal <allison@lohutok.net>,
        Enrico Weigelt <info@metux.net>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Leilk Liu <leilk.liu@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Applied "spi: mediatek: add SPI_CS_HIGH support" to the spi tree
In-Reply-To: <1574053037-26721-2-git-send-email-luhua.xu@mediatek.com>
Message-Id: <applied-1574053037-26721-2-git-send-email-luhua.xu@mediatek.com>
X-Patchwork-Hint: ignore
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: mediatek: add SPI_CS_HIGH support

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.5

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From ae7c2d342a10dbef1e054482f46498b6282a1df0 Mon Sep 17 00:00:00 2001
From: Luhua Xu <luhua.xu@mediatek.com>
Date: Mon, 18 Nov 2019 12:57:16 +0800
Subject: [PATCH] spi: mediatek: add SPI_CS_HIGH support

Change to use SPI_CS_HIGH to support spi CS polarity setting
for chips support enhance_timing.

Signed-off-by: Luhua Xu <luhua.xu@mediatek.com>
Link: https://lore.kernel.org/r/1574053037-26721-2-git-send-email-luhua.xu@mediatek.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-mt65xx.c                 | 12 ++++++++++--
 include/linux/platform_data/spi-mt65xx.h |  1 -
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index 25fe149a8d9a..6783e12c40c2 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -139,7 +139,6 @@ static const struct mtk_spi_compatible mt8183_compat = {
  * supplies it.
  */
 static const struct mtk_chip_config mtk_default_chip_info = {
-	.cs_pol = 0,
 	.sample_sel = 0,
 };
 
@@ -230,10 +229,12 @@ static int mtk_spi_prepare_message(struct spi_master *master,
 #endif
 
 	if (mdata->dev_comp->enhance_timing) {
-		if (chip_config->cs_pol)
+		/* set CS polarity */
+		if (spi->mode & SPI_CS_HIGH)
 			reg_val |= SPI_CMD_CS_POL;
 		else
 			reg_val &= ~SPI_CMD_CS_POL;
+
 		if (chip_config->sample_sel)
 			reg_val |= SPI_CMD_SAMPLE_SEL;
 		else
@@ -264,6 +265,9 @@ static void mtk_spi_set_cs(struct spi_device *spi, bool enable)
 	u32 reg_val;
 	struct mtk_spi *mdata = spi_master_get_devdata(spi->master);
 
+	if (spi->mode & SPI_CS_HIGH)
+		enable = !enable;
+
 	reg_val = readl(mdata->base + SPI_CMD_REG);
 	if (!enable) {
 		reg_val |= SPI_CMD_PAUSE_EN;
@@ -646,6 +650,10 @@ static int mtk_spi_probe(struct platform_device *pdev)
 
 	mdata = spi_master_get_devdata(master);
 	mdata->dev_comp = of_id->data;
+
+	if (mdata->dev_comp->enhance_timing)
+		master->mode_bits |= SPI_CS_HIGH;
+
 	if (mdata->dev_comp->must_tx)
 		master->flags = SPI_MASTER_MUST_TX;
 
diff --git a/include/linux/platform_data/spi-mt65xx.h b/include/linux/platform_data/spi-mt65xx.h
index f0e6d6483e62..65fd5ffd257c 100644
--- a/include/linux/platform_data/spi-mt65xx.h
+++ b/include/linux/platform_data/spi-mt65xx.h
@@ -11,7 +11,6 @@
 
 /* Board specific platform_data */
 struct mtk_chip_config {
-	u32 cs_pol;
 	u32 sample_sel;
 };
 #endif
-- 
2.20.1

