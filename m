Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABB20AFACD
	for <lists+linux-spi@lfdr.de>; Wed, 11 Sep 2019 12:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbfIKKvV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 11 Sep 2019 06:51:21 -0400
Received: from mailout1.hostsharing.net ([83.223.95.204]:59799 "EHLO
        mailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbfIKKvV (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 11 Sep 2019 06:51:21 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by mailout1.hostsharing.net (Postfix) with ESMTPS id 6E66A101920FB;
        Wed, 11 Sep 2019 12:51:18 +0200 (CEST)
Received: from localhost (p57BD772B.dip0.t-ipconnect.de [87.189.119.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id 319BD613C8EE;
        Wed, 11 Sep 2019 12:51:18 +0200 (CEST)
X-Mailbox-Line: From d17c1d7fcdc97fffa961b8737cfd80eeb14f9416 Mon Sep 17 00:00:00 2001
Message-Id: <d17c1d7fcdc97fffa961b8737cfd80eeb14f9416.1568187525.git.lukas@wunner.de>
In-Reply-To: <cover.1568187525.git.lukas@wunner.de>
References: <cover.1568187525.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Wed, 11 Sep 2019 12:15:30 +0200
Subject: [PATCH v2 06/10] spi: bcm2835: Cache CS register value for
 ->prepare_message()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-rpi-kernel@lists.infradead.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The BCM2835 SPI driver needs to set up the clock polarity in its
->prepare_message() hook before spi_transfer_one_message() asserts chip
select to avoid a gratuitous clock signal edge (cf. commit acace73df2c1
("spi: bcm2835: set up spi-mode before asserting cs-gpio")).

Precalculate the CS register value (which selects the clock polarity)
once in ->setup() and use that cached value in ->prepare_message() and
->transfer_one().  This avoids one MMIO read per message and one per
transfer, yielding a small latency improvement.  Additionally, a
forthcoming commit will use the precalculated value to derive the
register value for clearing the RX FIFO, which will eliminate the need
for an RX dummy buffer when performing TX-only DMA transfers.

Tested-by: Nuno Sá <nuno.sa@analog.com>
Tested-by: Noralf Trønnes <noralf@tronnes.org>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Acked-by: Stefan Wahren <wahrenst@gmx.net>
Acked-by: Martin Sperl <kernel@martin.sperl.org>
---
 drivers/spi/spi-bcm2835.c | 46 ++++++++++++++++++++++-----------------
 1 file changed, 26 insertions(+), 20 deletions(-)

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index 532c58bcfd45..e30e4afcf5f7 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -68,6 +68,7 @@
 #define BCM2835_SPI_FIFO_SIZE		64
 #define BCM2835_SPI_FIFO_SIZE_3_4	48
 #define BCM2835_SPI_DMA_MIN_LENGTH	96
+#define BCM2835_SPI_NUM_CS		3   /* raise as necessary */
 #define BCM2835_SPI_MODE_BITS	(SPI_CPOL | SPI_CPHA | SPI_CS_HIGH \
 				| SPI_NO_CS | SPI_3WIRE)
 
@@ -94,6 +95,8 @@ MODULE_PARM_DESC(polling_limit_us,
  * @rx_prologue: bytes received without DMA if first RX sglist entry's
  *	length is not a multiple of 4 (to overcome hardware limitation)
  * @tx_spillover: whether @tx_prologue spills over to second TX sglist entry
+ * @prepare_cs: precalculated CS register value for ->prepare_message()
+ *	(uses slave-specific clock polarity and phase settings)
  * @debugfs_dir: the debugfs directory - neede to remove debugfs when
  *      unloading the module
  * @count_transfer_polling: count of how often polling mode is used
@@ -116,6 +119,7 @@ struct bcm2835_spi {
 	int tx_prologue;
 	int rx_prologue;
 	unsigned int tx_spillover;
+	u32 prepare_cs[BCM2835_SPI_NUM_CS];
 
 	struct dentry *debugfs_dir;
 	u64 count_transfer_polling;
@@ -818,7 +822,7 @@ static int bcm2835_spi_transfer_one(struct spi_controller *ctlr,
 	struct bcm2835_spi *bs = spi_controller_get_devdata(ctlr);
 	unsigned long spi_hz, clk_hz, cdiv, spi_used_hz;
 	unsigned long hz_per_byte, byte_limit;
-	u32 cs = bcm2835_rd(bs, BCM2835_SPI_CS);
+	u32 cs = bs->prepare_cs[spi->chip_select];
 
 	/* set clock */
 	spi_hz = tfr->speed_hz;
@@ -843,15 +847,6 @@ static int bcm2835_spi_transfer_one(struct spi_controller *ctlr,
 	if (spi->mode & SPI_3WIRE && tfr->rx_buf &&
 	    tfr->rx_buf != ctlr->dummy_rx)
 		cs |= BCM2835_SPI_CS_REN;
-	else
-		cs &= ~BCM2835_SPI_CS_REN;
-
-	/*
-	 * The driver always uses software-controlled GPIO Chip Select.
-	 * Set the hardware-controlled native Chip Select to an invalid
-	 * value to prevent it from interfering.
-	 */
-	cs |= BCM2835_SPI_CS_CS_10 | BCM2835_SPI_CS_CS_01;
 
 	/* set transmit buffers and length */
 	bs->tx_buf = tfr->tx_buf;
@@ -888,7 +883,6 @@ static int bcm2835_spi_prepare_message(struct spi_controller *ctlr,
 {
 	struct spi_device *spi = msg->spi;
 	struct bcm2835_spi *bs = spi_controller_get_devdata(ctlr);
-	u32 cs = bcm2835_rd(bs, BCM2835_SPI_CS);
 	int ret;
 
 	if (ctlr->can_dma) {
@@ -903,14 +897,11 @@ static int bcm2835_spi_prepare_message(struct spi_controller *ctlr,
 			return ret;
 	}
 
-	cs &= ~(BCM2835_SPI_CS_CPOL | BCM2835_SPI_CS_CPHA);
-
-	if (spi->mode & SPI_CPOL)
-		cs |= BCM2835_SPI_CS_CPOL;
-	if (spi->mode & SPI_CPHA)
-		cs |= BCM2835_SPI_CS_CPHA;
-
-	bcm2835_wr(bs, BCM2835_SPI_CS, cs);
+	/*
+	 * Set up clock polarity before spi_transfer_one_message() asserts
+	 * chip select to avoid a gratuitous clock signal edge.
+	 */
+	bcm2835_wr(bs, BCM2835_SPI_CS, bs->prepare_cs[spi->chip_select]);
 
 	return 0;
 }
@@ -936,8 +927,23 @@ static int chip_match_name(struct gpio_chip *chip, void *data)
 
 static int bcm2835_spi_setup(struct spi_device *spi)
 {
+	struct bcm2835_spi *bs = spi_controller_get_devdata(spi->controller);
 	struct gpio_chip *chip;
 	enum gpio_lookup_flags lflags;
+	u32 cs;
+
+	/*
+	 * Precalculate SPI slave's CS register value for ->prepare_message():
+	 * The driver always uses software-controlled GPIO chip select, hence
+	 * set the hardware-controlled native chip select to an invalid value
+	 * to prevent it from interfering.
+	 */
+	cs = BCM2835_SPI_CS_CS_10 | BCM2835_SPI_CS_CS_01;
+	if (spi->mode & SPI_CPOL)
+		cs |= BCM2835_SPI_CS_CPOL;
+	if (spi->mode & SPI_CPHA)
+		cs |= BCM2835_SPI_CS_CPHA;
+	bs->prepare_cs[spi->chip_select] = cs;
 
 	/*
 	 * sanity checking the native-chipselects
@@ -1015,7 +1021,7 @@ static int bcm2835_spi_probe(struct platform_device *pdev)
 	ctlr->use_gpio_descriptors = true;
 	ctlr->mode_bits = BCM2835_SPI_MODE_BITS;
 	ctlr->bits_per_word_mask = SPI_BPW_MASK(8);
-	ctlr->num_chipselect = 3;
+	ctlr->num_chipselect = BCM2835_SPI_NUM_CS;
 	ctlr->setup = bcm2835_spi_setup;
 	ctlr->transfer_one = bcm2835_spi_transfer_one;
 	ctlr->handle_err = bcm2835_spi_handle_err;
-- 
2.23.0

