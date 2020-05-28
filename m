Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27CC51E69DD
	for <lists+linux-spi@lfdr.de>; Thu, 28 May 2020 20:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406064AbgE1S6T (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 28 May 2020 14:58:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:60352 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406065AbgE1S6S (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 28 May 2020 14:58:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 3F458AB5C;
        Thu, 28 May 2020 18:58:16 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Mark Brown <broonie@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Martin Sperl <kernel@martin.sperl.org>, linux-spi@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] spi: bcm2835: Enable shared interrupt support
Date:   Thu, 28 May 2020 20:58:04 +0200
Message-Id: <20200528185805.28991-1-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Martin Sperl <kernel@martin.sperl.org>

bcm2711, Rasberry Pi 4's SoC, shares one interrupt for multiple
instances of the bcm2835 SPI controller. So this enables shared
interrupt support for them.

The early bail out in the interrupt routine avoids messing with buffers
of transfers being done by other means. Otherwise, the driver can handle
receiving interrupts asserted by other controllers during an IRQ based
transfer.

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 drivers/spi/spi-bcm2835.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index 11c235879bb7..ca1085c812f2 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -379,6 +379,10 @@ static irqreturn_t bcm2835_spi_interrupt(int irq, void *dev_id)
 	if (bs->tx_len && cs & BCM2835_SPI_CS_DONE)
 		bcm2835_wr_fifo_blind(bs, BCM2835_SPI_FIFO_SIZE);
 
+	/* check if we got interrupt enabled */
+	if (!(bcm2835_rd(bs, BCM2835_SPI_CS) & BCM2835_SPI_CS_INTR))
+		return IRQ_NONE;
+
 	/* Read as many bytes as possible from FIFO */
 	bcm2835_rd_fifo(bs);
 	/* Write as many bytes as possible to FIFO */
@@ -1340,8 +1344,8 @@ static int bcm2835_spi_probe(struct platform_device *pdev)
 	bcm2835_wr(bs, BCM2835_SPI_CS,
 		   BCM2835_SPI_CS_CLEAR_RX | BCM2835_SPI_CS_CLEAR_TX);
 
-	err = devm_request_irq(&pdev->dev, bs->irq, bcm2835_spi_interrupt, 0,
-			       dev_name(&pdev->dev), ctlr);
+	err = devm_request_irq(&pdev->dev, bs->irq, bcm2835_spi_interrupt,
+			       IRQF_SHARED, dev_name(&pdev->dev), ctlr);
 	if (err) {
 		dev_err(&pdev->dev, "could not request IRQ: %d\n", err);
 		goto out_dma_release;
-- 
2.26.2

