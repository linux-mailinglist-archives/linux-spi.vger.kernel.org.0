Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99D2C140E27
	for <lists+linux-spi@lfdr.de>; Fri, 17 Jan 2020 16:45:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729368AbgAQPov (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 17 Jan 2020 10:44:51 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:54014 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729219AbgAQPoa (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 17 Jan 2020 10:44:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=bubYcWmZxkJa2g3LCd3hNT3lwv8r6SjJCmZojEtnG3c=; b=V5YjMQHfnfmP
        49ldVECEShgmWIeHNu+ZEfaUf0TNij3yOEwtWN07SOSMlK8lerypiOaPMkl+/CzXDTVJ6/bMVEVIv
        weYofuBZr41MJsclYXvzS/fmkxkIu5XGQoIz77DWVtlD/VMJYywlGLQB9yYTg0XTUpc0kUuIqb7sN
        /6sk8=;
Received: from fw-tnat-cam4.arm.com ([217.140.106.52] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1isTnM-0006uV-8B; Fri, 17 Jan 2020 15:44:24 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id D6370D02A2A; Fri, 17 Jan 2020 15:44:23 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     avifishman70@gmail.com, benjaminfair@google.com,
        broonie@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, mark.rutland@arm.com,
        openbmc@lists.ozlabs.org, robh+dt@kernel.org,
        tali.perry1@gmail.com, venture@google.com, yuenn@google.com
Subject: Applied "spi: npcm-pspi: modify reset support" to the spi tree
In-Reply-To: <20200115162301.235926-5-tmaimon77@gmail.com>
Message-Id: <applied-20200115162301.235926-5-tmaimon77@gmail.com>
X-Patchwork-Hint: ignore
Date:   Fri, 17 Jan 2020 15:44:23 +0000 (GMT)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: npcm-pspi: modify reset support

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.6

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

From b5df0b2ee2ee6b5bdeb55d76c17f695a1aa5388f Mon Sep 17 00:00:00 2001
From: Tomer Maimon <tmaimon77@gmail.com>
Date: Wed, 15 Jan 2020 18:23:01 +0200
Subject: [PATCH] spi: npcm-pspi: modify reset support

Modify NPCM perphiral SPI reset support from
direct register access to reset controller support.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
Link: https://lore.kernel.org/r/20200115162301.235926-5-tmaimon77@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-npcm-pspi.c | 33 +++++++++++----------------------
 1 file changed, 11 insertions(+), 22 deletions(-)

diff --git a/drivers/spi/spi-npcm-pspi.c b/drivers/spi/spi-npcm-pspi.c
index d224aa63dbce..7e9e747b5626 100644
--- a/drivers/spi/spi-npcm-pspi.c
+++ b/drivers/spi/spi-npcm-pspi.c
@@ -12,6 +12,7 @@
 #include <linux/spi/spi.h>
 #include <linux/gpio.h>
 #include <linux/of_gpio.h>
+#include <linux/reset.h>
 
 #include <asm/unaligned.h>
 
@@ -20,7 +21,7 @@
 
 struct npcm_pspi {
 	struct completion xfer_done;
-	struct regmap *rst_regmap;
+	struct reset_control *reset;
 	struct spi_master *master;
 	unsigned int tx_bytes;
 	unsigned int rx_bytes;
@@ -59,12 +60,6 @@ struct npcm_pspi {
 #define NPCM_PSPI_MIN_CLK_DIVIDER	4
 #define NPCM_PSPI_DEFAULT_CLK		25000000
 
-/* reset register */
-#define NPCM7XX_IPSRST2_OFFSET	0x24
-
-#define NPCM7XX_PSPI1_RESET	BIT(22)
-#define NPCM7XX_PSPI2_RESET	BIT(23)
-
 static inline unsigned int bytes_per_word(unsigned int bits)
 {
 	return bits <= 8 ? 1 : 2;
@@ -292,9 +287,9 @@ static int npcm_pspi_unprepare_transfer_hardware(struct spi_master *master)
 
 static void npcm_pspi_reset_hw(struct npcm_pspi *priv)
 {
-	regmap_write(priv->rst_regmap, NPCM7XX_IPSRST2_OFFSET,
-		     NPCM7XX_PSPI1_RESET << priv->id);
-	regmap_write(priv->rst_regmap, NPCM7XX_IPSRST2_OFFSET, 0x0);
+	reset_control_assert(priv->reset);
+	udelay(5);
+	reset_control_deassert(priv->reset);
 }
 
 static irqreturn_t npcm_pspi_handler(int irq, void *dev_id)
@@ -358,10 +353,6 @@ static int npcm_pspi_probe(struct platform_device *pdev)
 	if (num_cs < 0)
 		return num_cs;
 
-	pdev->id = of_alias_get_id(np, "spi");
-	if (pdev->id < 0)
-		pdev->id = 0;
-
 	master = spi_alloc_master(&pdev->dev, sizeof(*priv));
 	if (!master)
 		return -ENOMEM;
@@ -371,7 +362,6 @@ static int npcm_pspi_probe(struct platform_device *pdev)
 	priv = spi_master_get_devdata(master);
 	priv->master = master;
 	priv->is_save_param = false;
-	priv->id = pdev->id;
 
 	priv->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(priv->base)) {
@@ -396,11 +386,10 @@ static int npcm_pspi_probe(struct platform_device *pdev)
 		goto out_disable_clk;
 	}
 
-	priv->rst_regmap =
-		syscon_regmap_lookup_by_compatible("nuvoton,npcm750-rst");
-	if (IS_ERR(priv->rst_regmap)) {
-		dev_err(&pdev->dev, "failed to find nuvoton,npcm750-rst\n");
-		return PTR_ERR(priv->rst_regmap);
+	priv->reset = devm_reset_control_get(&pdev->dev, NULL);
+	if (IS_ERR(priv->reset)) {
+		ret = PTR_ERR(priv->reset);
+		goto out_disable_clk;
 	}
 
 	/* reset SPI-HW block */
@@ -421,7 +410,7 @@ static int npcm_pspi_probe(struct platform_device *pdev)
 	master->min_speed_hz = DIV_ROUND_UP(clk_hz, NPCM_PSPI_MAX_CLK_DIVIDER);
 	master->mode_bits = SPI_CPHA | SPI_CPOL;
 	master->dev.of_node = pdev->dev.of_node;
-	master->bus_num = pdev->id;
+	master->bus_num = -1;
 	master->bits_per_word_mask = SPI_BPW_MASK(8) | SPI_BPW_MASK(16);
 	master->transfer_one = npcm_pspi_transfer_one;
 	master->prepare_transfer_hardware =
@@ -454,7 +443,7 @@ static int npcm_pspi_probe(struct platform_device *pdev)
 	if (ret)
 		goto out_disable_clk;
 
-	pr_info("NPCM Peripheral SPI %d probed\n", pdev->id);
+	pr_info("NPCM Peripheral SPI %d probed\n", master->bus_num);
 
 	return 0;
 
-- 
2.20.1

