Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7261FA4E5
	for <lists+linux-spi@lfdr.de>; Tue, 16 Jun 2020 02:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbgFPAJp (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 15 Jun 2020 20:09:45 -0400
Received: from foss.arm.com ([217.140.110.172]:56986 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726486AbgFPAJm (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 15 Jun 2020 20:09:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0D9A91042;
        Mon, 15 Jun 2020 17:09:42 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 794253F73C;
        Mon, 15 Jun 2020 17:09:40 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     broonie@kernel.org, nsaenzjulienne@suse.de, f.fainelli@gmail.com,
        rjui@broadcom.com, sbranden@broadcom.com
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-spi@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, kernel@martin.sperl.org,
        lukas@wunner.de, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] spi: bcm2835: Micro-optimise IRQ handler
Date:   Tue, 16 Jun 2020 01:09:28 +0100
Message-Id: <6b401cb521539caffab21f05b4c8cba6c9d27c6e.1592261248.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.23.0.dirty
In-Reply-To: <cover.1592261248.git.robin.murphy@arm.com>
References: <cover.1592261248.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The IRQ handler only needs the struct spi_controller for the sake of
the completion at the end of a transfer. Passing the struct bcm2835_spi
directly as the IRQ data allows that level of indirection to be pushed
into the completion path for the reverse lookup, and avoided entirely
in all other cases.

This saves one explicit load in the critical path, plus (for a GCC 8.3
build) two registers worth of stack frame overhead.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/spi/spi-bcm2835.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index 524a91e52111..aec70ac8911e 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -86,6 +86,7 @@ MODULE_PARM_DESC(polling_limit_us,
  * @clk: core clock, divided to calculate serial clock
  * @irq: interrupt, signals TX FIFO empty or RX FIFO ¾ full
  * @tfr: SPI transfer currently processed
+ * @ctlr: SPI controller reverse lookup
  * @tx_buf: pointer whence next transmitted byte is read
  * @rx_buf: pointer where next received byte is written
  * @tx_len: remaining bytes to transmit
@@ -125,6 +126,7 @@ struct bcm2835_spi {
 	struct clk *clk;
 	int irq;
 	struct spi_transfer *tfr;
+	struct spi_controller *ctlr;
 	const u8 *tx_buf;
 	u8 *rx_buf;
 	int tx_len;
@@ -362,8 +364,7 @@ static void bcm2835_spi_reset_hw(struct bcm2835_spi *bs)
 
 static irqreturn_t bcm2835_spi_interrupt(int irq, void *dev_id)
 {
-	struct spi_controller *ctlr = dev_id;
-	struct bcm2835_spi *bs = spi_controller_get_devdata(ctlr);
+	struct bcm2835_spi *bs = dev_id;
 	u32 cs = bcm2835_rd(bs, BCM2835_SPI_CS);
 
 	/*
@@ -387,7 +388,7 @@ static irqreturn_t bcm2835_spi_interrupt(int irq, void *dev_id)
 		/* Transfer complete - reset SPI HW */
 		bcm2835_spi_reset_hw(bs);
 		/* wake up the framework */
-		complete(&ctlr->xfer_completion);
+		complete(&bs->ctlr->xfer_completion);
 	}
 
 	return IRQ_HANDLED;
@@ -1310,6 +1311,7 @@ static int bcm2835_spi_probe(struct platform_device *pdev)
 	ctlr->dev.of_node = pdev->dev.of_node;
 
 	bs = spi_controller_get_devdata(ctlr);
+	bs->ctlr = ctlr;
 
 	bs->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(bs->regs)) {
@@ -1344,7 +1346,7 @@ static int bcm2835_spi_probe(struct platform_device *pdev)
 		   BCM2835_SPI_CS_CLEAR_RX | BCM2835_SPI_CS_CLEAR_TX);
 
 	err = devm_request_irq(&pdev->dev, bs->irq, bcm2835_spi_interrupt, 0,
-			       dev_name(&pdev->dev), ctlr);
+			       dev_name(&pdev->dev), bs);
 	if (err) {
 		dev_err(&pdev->dev, "could not request IRQ: %d\n", err);
 		goto out_dma_release;
-- 
2.23.0.dirty

