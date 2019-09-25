Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18E90BDAAA
	for <lists+linux-spi@lfdr.de>; Wed, 25 Sep 2019 11:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388162AbfIYJMI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 25 Sep 2019 05:12:08 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:47167 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387927AbfIYJMH (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 25 Sep 2019 05:12:07 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 46dXPf4fyyz1rSBb;
        Wed, 25 Sep 2019 11:12:06 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 46dXPf4DQfz1qqkL;
        Wed, 25 Sep 2019 11:12:06 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id FXGkXWStI10e; Wed, 25 Sep 2019 11:12:04 +0200 (CEST)
X-Auth-Info: o4u4qXuuFLlQh1zBWTsqWbrOIzRBQ+Y0XzcSt5tgRFY=
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Wed, 25 Sep 2019 11:12:04 +0200 (CEST)
From:   Lukasz Majewski <lukma@denx.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        krzk@kernel.org, Lukasz Majewski <lukma@denx.de>
Subject: [PATCH v2 2/2] spi: Introduce dspi_slave_abort() function for NXP's dspi SPI driver
Date:   Wed, 25 Sep 2019 11:11:43 +0200
Message-Id: <20190925091143.15468-3-lukma@denx.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190925091143.15468-1-lukma@denx.de>
References: <20190924110547.14770-1-lukma@denx.de>
 <20190925091143.15468-1-lukma@denx.de>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This change provides the dspi_slave_abort() function, which is a callback
for slave_abort() method of SPI controller generic driver.

As in the SPI slave mode the transmission is driven by master, any
distortion may cause the slave to enter undefined internal state.
To avoid this problem the dspi_slave_abort() terminates all pending and
ongoing DMA transactions (with sync) and clears internal FIFOs.

Signed-off-by: Lukasz Majewski <lukma@denx.de>

---
Changes for v2:
- None
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

