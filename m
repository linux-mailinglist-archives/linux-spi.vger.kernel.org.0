Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57579FDDA8
	for <lists+linux-spi@lfdr.de>; Fri, 15 Nov 2019 13:26:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727744AbfKOMZV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 15 Nov 2019 07:25:21 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:33208 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727733AbfKOMZU (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 15 Nov 2019 07:25:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=HBh8VwyeABvY6DHkjMBOOalpvrT7tK3xjss5SybD1us=; b=MD9wcjunqubV
        NGi6UMNeQkDXi5d7SiisFCRJukbrBl6/7Pq+XZekBI9jQlyfXeSX8lmdO0lXvJV4C7yQYeoohMQUF
        OxJZ/h8PWuToNvsTrtRk2qG9UVAOeDCVmVWReJ4InbN4wCutx/w6a9w8pzKAD0jR93m347aUq7faG
        5mERY=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iVaf7-0000Mi-TE; Fri, 15 Nov 2019 12:25:17 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 50F6527415A7; Fri, 15 Nov 2019 12:25:17 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Fabio Estevam <festevam@gmail.com>, linux-gpio@vger.kernel.org,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "spi: fsl-cpm: Correct the free:ing" to the spi tree
In-Reply-To: <20191113014442.12100-1-linus.walleij@linaro.org>
X-Patchwork-Hint: ignore
Message-Id: <20191115122517.50F6527415A7@ypsilon.sirena.org.uk>
Date:   Fri, 15 Nov 2019 12:25:17 +0000 (GMT)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: fsl-cpm: Correct the free:ing

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.4

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

From c5923243eb3208ea63b5ed7905610039c4ca5201 Mon Sep 17 00:00:00 2001
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 13 Nov 2019 02:44:42 +0100
Subject: [PATCH] spi: fsl-cpm: Correct the free:ing

The fsl_spi_cpm_free() function does not make the same
checks as the error path in fsl_spi_cpm_init() leading
to crashes on error.

Cc: Fabio Estevam <festevam@gmail.com>
Reported-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Link: https://lore.kernel.org/r/20191113014442.12100-1-linus.walleij@linaro.org
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-fsl-cpm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-cpm.c b/drivers/spi/spi-fsl-cpm.c
index 858f0544289e..54ad0ac121e5 100644
--- a/drivers/spi/spi-fsl-cpm.c
+++ b/drivers/spi/spi-fsl-cpm.c
@@ -392,7 +392,8 @@ void fsl_spi_cpm_free(struct mpc8xxx_spi *mspi)
 	dma_unmap_single(dev, mspi->dma_dummy_rx, SPI_MRBLR, DMA_FROM_DEVICE);
 	dma_unmap_single(dev, mspi->dma_dummy_tx, PAGE_SIZE, DMA_TO_DEVICE);
 	cpm_muram_free(cpm_muram_offset(mspi->tx_bd));
-	cpm_muram_free(cpm_muram_offset(mspi->pram));
+	if (!(mspi->flags & SPI_CPM1))
+		cpm_muram_free(cpm_muram_offset(mspi->pram));
 	fsl_spi_free_dummy_rx();
 }
 EXPORT_SYMBOL_GPL(fsl_spi_cpm_free);
-- 
2.20.1

