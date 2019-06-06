Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A048337F89
	for <lists+linux-spi@lfdr.de>; Thu,  6 Jun 2019 23:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728454AbfFFV1p (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 6 Jun 2019 17:27:45 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:59372 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728452AbfFFV1p (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 6 Jun 2019 17:27:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=iTBpUenYt5TRt0pKN2VQcUXbaHgvcGjOjaOWkyUYusc=; b=ACrAPspd8ob8
        SUn7J5Coyi9qIqntZ2TxVhuJuOW+cVduSwxFu5B4nnyVH+i5icsnWRzNIf0EzuFRJ2jE4tyCR9K/8
        XNEFRjkGsHsC/m1yvZpwkAF9+MQOP7Emw/e8XNVKjzeG2M0B94l2/wTWk28iCbL+VzCd7gM3h6RGQ
        Mubas=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hYzv3-0007Wf-RB; Thu, 06 Jun 2019 21:27:33 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 5E2FE440046; Thu,  6 Jun 2019 22:27:33 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Leilk Liu <leilk.liu@mediatek.com>
Cc:     devicetree@vger.kernel.org, fparent@baylibre.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: Applied "spi: mediatek: add SPI_LSB_FIRST support" to the spi tree
In-Reply-To: <1559704024-5369-1-git-send-email-leilk.liu@mediatek.com>
X-Patchwork-Hint: ignore
Message-Id: <20190606212733.5E2FE440046@finisterre.sirena.org.uk>
Date:   Thu,  6 Jun 2019 22:27:33 +0100 (BST)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: mediatek: add SPI_LSB_FIRST support

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.3

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

From 3e582c6e911ffe6c90b9f90324bdf85fc728d0c3 Mon Sep 17 00:00:00 2001
From: Leilk Liu <leilk.liu@mediatek.com>
Date: Wed, 5 Jun 2019 11:07:04 +0800
Subject: [PATCH] spi: mediatek: add SPI_LSB_FIRST support

this patch add SPI_LSB_FIRST feature support.

Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-mt65xx.c                 | 15 ++++++---------
 include/linux/platform_data/spi-mt65xx.h |  2 --
 2 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index 0cce6f0ba824..7f4dc1844789 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -131,8 +131,6 @@ static const struct mtk_spi_compatible mt8183_compat = {
  * supplies it.
  */
 static const struct mtk_chip_config mtk_default_chip_info = {
-	.rx_mlsb = 1,
-	.tx_mlsb = 1,
 	.cs_pol = 0,
 	.sample_sel = 0,
 };
@@ -203,14 +201,13 @@ static int mtk_spi_prepare_message(struct spi_master *master,
 		reg_val &= ~SPI_CMD_CPOL;
 
 	/* set the mlsbx and mlsbtx */
-	if (chip_config->tx_mlsb)
-		reg_val |= SPI_CMD_TXMSBF;
-	else
+	if (spi->mode & SPI_LSB_FIRST) {
 		reg_val &= ~SPI_CMD_TXMSBF;
-	if (chip_config->rx_mlsb)
-		reg_val |= SPI_CMD_RXMSBF;
-	else
 		reg_val &= ~SPI_CMD_RXMSBF;
+	} else {
+		reg_val |= SPI_CMD_TXMSBF;
+		reg_val |= SPI_CMD_RXMSBF;
+	}
 
 	/* set the tx/rx endian */
 #ifdef __LITTLE_ENDIAN
@@ -607,7 +604,7 @@ static int mtk_spi_probe(struct platform_device *pdev)
 
 	master->auto_runtime_pm = true;
 	master->dev.of_node = pdev->dev.of_node;
-	master->mode_bits = SPI_CPOL | SPI_CPHA;
+	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_LSB_FIRST;
 
 	master->set_cs = mtk_spi_set_cs;
 	master->prepare_message = mtk_spi_prepare_message;
diff --git a/include/linux/platform_data/spi-mt65xx.h b/include/linux/platform_data/spi-mt65xx.h
index ba4e4bb70262..8d5df58a13ef 100644
--- a/include/linux/platform_data/spi-mt65xx.h
+++ b/include/linux/platform_data/spi-mt65xx.h
@@ -14,8 +14,6 @@
 
 /* Board specific platform_data */
 struct mtk_chip_config {
-	u32 tx_mlsb;
-	u32 rx_mlsb;
 	u32 cs_pol;
 	u32 sample_sel;
 };
-- 
2.20.1

