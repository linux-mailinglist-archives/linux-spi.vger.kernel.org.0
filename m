Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2F1C32F0
	for <lists+linux-spi@lfdr.de>; Tue,  1 Oct 2019 13:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387594AbfJALlK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 1 Oct 2019 07:41:10 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:41030 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387600AbfJALlK (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 1 Oct 2019 07:41:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=frM2JsTVe3jb5WiWwu7ktf9Jc8bbbMxoSVuWP1vincI=; b=KFeL27be0KdS
        RdCLZ7pZZHlD4j+kYZwXdDBRtEaVRKWnZbnuZ82Q4ZfMEluAu6Mt/GKBf9M7mEk8H3/brDw6SUxco
        frHPTwS03rVTQAMbkdlXfgSgW3iKOzkmu05xx66EjRJ49Nt/pMr2Cm0jjJjqIM3YzOfaHzdawridi
        A9qBI=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iFGWf-0004YV-V3; Tue, 01 Oct 2019 11:41:06 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 7830D2742A10; Tue,  1 Oct 2019 12:41:05 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Lukasz Majewski <lukma@denx.de>
Cc:     krzk@kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "spi: Introduce dspi_slave_abort() function for NXP's dspi SPI driver" to the spi tree
In-Reply-To: <20190924110547.14770-3-lukma@denx.de>
X-Patchwork-Hint: ignore
Message-Id: <20191001114105.7830D2742A10@ypsilon.sirena.org.uk>
Date:   Tue,  1 Oct 2019 12:41:05 +0100 (BST)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: Introduce dspi_slave_abort() function for NXP's dspi SPI driver

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

From f4b323905d8b3e28b2a9cef9325dbec1b0f7f064 Mon Sep 17 00:00:00 2001
From: Lukasz Majewski <lukma@denx.de>
Date: Tue, 24 Sep 2019 13:05:47 +0200
Subject: [PATCH] spi: Introduce dspi_slave_abort() function for NXP's dspi SPI
 driver

This change provides the dspi_slave_abort() function, which is a callback
for slave_abort() method of SPI controller generic driver.

As in the SPI slave mode the transmission is driven by master, any
distortion may cause the slave to enter undefined internal state.
To avoid this problem the dspi_slave_abort() terminates all pending and
ongoing DMA transactions (with sync) and clears internal FIFOs.

Signed-off-by: Lukasz Majewski <lukma@denx.de>
Link: https://lore.kernel.org/r/20190924110547.14770-3-lukma@denx.de
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-fsl-dspi.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index bec758e978fb..2c0f211eed87 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -1006,6 +1006,25 @@ static void dspi_init(struct fsl_dspi *dspi)
 			     SPI_CTARE_FMSZE(0) | SPI_CTARE_DTCP(1));
 }
 
+static int dspi_slave_abort(struct spi_master *master)
+{
+	struct fsl_dspi *dspi = spi_master_get_devdata(master);
+
+	/*
+	 * Terminate all pending DMA transactions for the SPI working
+	 * in SLAVE mode.
+	 */
+	dmaengine_terminate_sync(dspi->dma->chan_rx);
+	dmaengine_terminate_sync(dspi->dma->chan_tx);
+
+	/* Clear the internal DSPI RX and TX FIFO buffers */
+	regmap_update_bits(dspi->regmap, SPI_MCR,
+			   SPI_MCR_CLR_TXF | SPI_MCR_CLR_RXF,
+			   SPI_MCR_CLR_TXF | SPI_MCR_CLR_RXF);
+
+	return 0;
+}
+
 static int dspi_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
@@ -1030,6 +1049,7 @@ static int dspi_probe(struct platform_device *pdev)
 	ctlr->dev.of_node = pdev->dev.of_node;
 
 	ctlr->cleanup = dspi_cleanup;
+	ctlr->slave_abort = dspi_slave_abort;
 	ctlr->mode_bits = SPI_CPOL | SPI_CPHA | SPI_LSB_FIRST;
 
 	pdata = dev_get_platdata(&pdev->dev);
-- 
2.20.1

