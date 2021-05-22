Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63BB938D6BE
	for <lists+linux-spi@lfdr.de>; Sat, 22 May 2021 19:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbhEVSBQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 22 May 2021 14:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbhEVSBQ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 22 May 2021 14:01:16 -0400
X-Greylist: delayed 578 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 22 May 2021 10:59:50 PDT
Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f236:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD629C061574
        for <linux-spi@vger.kernel.org>; Sat, 22 May 2021 10:59:50 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by mailout3.hostsharing.net (Postfix) with ESMTPS id DA804101E6A9A;
        Sat, 22 May 2021 19:50:09 +0200 (CEST)
Received: from localhost (unknown [89.246.108.87])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id 7F623625353E;
        Sat, 22 May 2021 19:50:09 +0200 (CEST)
X-Mailbox-Line: From 75854affc1923309fde05e47494263bde73e5592 Mon Sep 17 00:00:00 2001
Message-Id: <75854affc1923309fde05e47494263bde73e5592.1621703210.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Sat, 22 May 2021 19:49:50 +0200
Subject: [PATCH for-5.13] spi: bcm2835: Fix out-of-bounds access with more than 4
 slaves
To:     Mark Brown <broonie@kernel.org>
Cc:     Joe Burmeister <joe.burmeister@devtank.co.uk>,
        Phil Elwell <phil@raspberrypi.com>,
        "Nicolas Saenz Julienne" <nsaenz@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-spi@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Commit 571e31fa60b3 ("spi: bcm2835: Cache CS register value for
->prepare_message()") limited the number of slaves to 3 at compile-time.
The limitation was necessitated by a statically-sized array prepare_cs[]
in the driver private data which contains a per-slave register value.

The commit sought to enforce the limitation at run-time by setting the
controller's num_chipselect to 3:  Slaves with a higher chipselect are
rejected by spi_add_device().

However the commit neglected that num_chipselect only limits the number
of *native* chipselects.  If GPIO chipselects are specified in the
device tree for more than 3 slaves, num_chipselect is silently raised by
of_spi_get_gpio_numbers() and the result are out-of-bounds accesses to
the statically-sized array prepare_cs[].

As a bandaid fix which is backportable to stable, raise the number of
allowed slaves to 24 (which "ought to be enough for anybody"), enforce
the limitation on slave ->setup and revert num_chipselect to 3 (which is
the number of native chipselects supported by the controller).
An upcoming for-next commit will allow an arbitrary number of slaves.

Fixes: 571e31fa60b3 ("spi: bcm2835: Cache CS register value for ->prepare_message()")
Reported-by: Joe Burmeister <joe.burmeister@devtank.co.uk>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: stable@vger.kernel.org # v5.4+
Cc: Phil Elwell <phil@raspberrypi.com>
---
 drivers/spi/spi-bcm2835.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index 8965fe61c8b4..fe40626e45aa 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -68,7 +68,7 @@
 #define BCM2835_SPI_FIFO_SIZE		64
 #define BCM2835_SPI_FIFO_SIZE_3_4	48
 #define BCM2835_SPI_DMA_MIN_LENGTH	96
-#define BCM2835_SPI_NUM_CS		4   /* raise as necessary */
+#define BCM2835_SPI_NUM_CS		24  /* raise as necessary */
 #define BCM2835_SPI_MODE_BITS	(SPI_CPOL | SPI_CPHA | SPI_CS_HIGH \
 				| SPI_NO_CS | SPI_3WIRE)
 
@@ -1195,6 +1195,12 @@ static int bcm2835_spi_setup(struct spi_device *spi)
 	struct gpio_chip *chip;
 	u32 cs;
 
+	if (spi->chip_select >= BCM2835_SPI_NUM_CS) {
+		dev_err(&spi->dev, "only %d chip-selects supported\n",
+			BCM2835_SPI_NUM_CS - 1);
+		return -EINVAL;
+	}
+
 	/*
 	 * Precalculate SPI slave's CS register value for ->prepare_message():
 	 * The driver always uses software-controlled GPIO chip select, hence
@@ -1288,7 +1294,7 @@ static int bcm2835_spi_probe(struct platform_device *pdev)
 	ctlr->use_gpio_descriptors = true;
 	ctlr->mode_bits = BCM2835_SPI_MODE_BITS;
 	ctlr->bits_per_word_mask = SPI_BPW_MASK(8);
-	ctlr->num_chipselect = BCM2835_SPI_NUM_CS;
+	ctlr->num_chipselect = 3;
 	ctlr->setup = bcm2835_spi_setup;
 	ctlr->transfer_one = bcm2835_spi_transfer_one;
 	ctlr->handle_err = bcm2835_spi_handle_err;
-- 
2.31.1

