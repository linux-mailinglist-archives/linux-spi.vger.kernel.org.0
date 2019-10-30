Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4C4E9D47
	for <lists+linux-spi@lfdr.de>; Wed, 30 Oct 2019 15:16:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbfJ3OQm (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 30 Oct 2019 10:16:42 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:40800 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbfJ3OQm (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 30 Oct 2019 10:16:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=heA0qH4A3CJhukQ4aM3sFmsJPa3nS4YlchNqlSQ664E=; b=UhdcZ6V/giMa
        d8C9nGEadlTzI+GYecA53opw1rSh5hI5KWh2joudWvjwSPSa0pMm+7kejLvPIrsZRr7/VzBals7yU
        DDaDihtPWj8kk3NTw64nRtTQha3+Rp4/00Khj/u6fhKR7vibFhJryHcUzdUGwN7ekpXU6/z32KF6S
        ThITY=;
Received: from [195.11.164.221] (helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1iPom4-0005D0-Km; Wed, 30 Oct 2019 14:16:36 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 48056D020AA; Wed, 30 Oct 2019 14:16:36 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Atsushi Nemoto <atsushi.nemoto@sord.co.jp>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: Applied "spi: txx9: Convert to use GPIO descriptors" to the spi tree
In-Reply-To: <20191030073832.24038-1-linus.walleij@linaro.org>
X-Patchwork-Hint: ignore
Message-Id: <20191030141636.48056D020AA@fitzroy.sirena.org.uk>
Date:   Wed, 30 Oct 2019 14:16:36 +0000 (GMT)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: txx9: Convert to use GPIO descriptors

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

From c8b348dd86091daa3496a6dc8c0777b78c9683a6 Mon Sep 17 00:00:00 2001
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 30 Oct 2019 08:38:32 +0100
Subject: [PATCH] spi: txx9: Convert to use GPIO descriptors

This converts the TXX9 SPI driver to use GPIO descriptors
to control the GPIO chip selects.

As the driver was clearly (ab)using the device tree "reg"
property to offset into the global GPIO chip we have to
add a hack to counter the hack: add a 1-to-1 chip select
to GPIO offset mapping for all 16 lines on the TXX9 GPIO
chip. The details are described in a largeish comment
in the patch.

We do not need to set up the GPIO as output any more since
the core will take care of this, as well as it will handle
the polarity inversion semantics.

Cc: Atsushi Nemoto <atsushi.nemoto@sord.co.jp>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Link: https://lore.kernel.org/r/20191030073832.24038-1-linus.walleij@linaro.org
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-txx9.c | 75 ++++++++++++++++++++++++++++++++----------
 1 file changed, 58 insertions(+), 17 deletions(-)

diff --git a/drivers/spi/spi-txx9.c b/drivers/spi/spi-txx9.c
index 83daaa597acc..3606232f190f 100644
--- a/drivers/spi/spi-txx9.c
+++ b/drivers/spi/spi-txx9.c
@@ -26,7 +26,8 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/module.h>
-#include <linux/gpio.h>
+#include <linux/gpio/machine.h>
+#include <linux/gpio/consumer.h>
 
 
 #define SPI_FIFO_SIZE 4
@@ -79,7 +80,7 @@ struct txx9spi {
 	void __iomem *membase;
 	int baseclk;
 	struct clk *clk;
-	int last_chipselect;
+	struct gpio_desc *last_chipselect;
 	int last_chipselect_val;
 };
 
@@ -95,20 +96,22 @@ static void txx9spi_wr(struct txx9spi *c, u32 val, int reg)
 static void txx9spi_cs_func(struct spi_device *spi, struct txx9spi *c,
 		int on, unsigned int cs_delay)
 {
-	int val = (spi->mode & SPI_CS_HIGH) ? on : !on;
-
+	/*
+	 * The GPIO descriptor will track polarity inversion inside
+	 * gpiolib.
+	 */
 	if (on) {
 		/* deselect the chip with cs_change hint in last transfer */
-		if (c->last_chipselect >= 0)
-			gpio_set_value(c->last_chipselect,
+		if (c->last_chipselect)
+			gpiod_set_value(c->last_chipselect,
 					!c->last_chipselect_val);
-		c->last_chipselect = spi->chip_select;
-		c->last_chipselect_val = val;
+		c->last_chipselect = spi->cs_gpiod;
+		c->last_chipselect_val = on;
 	} else {
-		c->last_chipselect = -1;
+		c->last_chipselect = NULL;
 		ndelay(cs_delay);	/* CS Hold Time */
 	}
-	gpio_set_value(spi->chip_select, val);
+	gpiod_set_value(spi->cs_gpiod, on);
 	ndelay(cs_delay);	/* CS Setup Time / CS Recovery Time */
 }
 
@@ -119,12 +122,6 @@ static int txx9spi_setup(struct spi_device *spi)
 	if (!spi->max_speed_hz)
 		return -EINVAL;
 
-	if (gpio_direction_output(spi->chip_select,
-			!(spi->mode & SPI_CS_HIGH))) {
-		dev_err(&spi->dev, "Cannot setup GPIO for chipselect.\n");
-		return -EINVAL;
-	}
-
 	/* deselect chip */
 	spin_lock(&c->lock);
 	txx9spi_cs_func(spi, c, 0, (NSEC_PER_SEC / 2) / spi->max_speed_hz);
@@ -319,6 +316,47 @@ static int txx9spi_transfer(struct spi_device *spi, struct spi_message *m)
 	return 0;
 }
 
+/*
+ * Chip select uses GPIO only, further the driver is using the chip select
+ * numer (from the device tree "reg" property, and this can only come from
+ * device tree since this i MIPS and there is no way to pass platform data) as
+ * the GPIO number. As the platform has only one GPIO controller (the txx9 GPIO
+ * chip) it is thus using the chip select number as an offset into that chip.
+ * This chip has a maximum of 16 GPIOs 0..15 and this is what all platforms
+ * register.
+ *
+ * We modernized this behaviour by explicitly converting that offset to an
+ * offset on the GPIO chip using a GPIO descriptor machine table of the same
+ * size as the txx9 GPIO chip with a 1-to-1 mapping of chip select to GPIO
+ * offset.
+ *
+ * This is admittedly a hack, but it is countering the hack of using "reg" to
+ * contain a GPIO offset when it should be using "cs-gpios" as the SPI bindings
+ * state.
+ */
+static struct gpiod_lookup_table txx9spi_cs_gpio_table = {
+	.dev_id = "spi0",
+	.table = {
+		GPIO_LOOKUP_IDX("TXx9", 0, "cs", 0, GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP_IDX("TXx9", 1, "cs", 1, GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP_IDX("TXx9", 2, "cs", 2, GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP_IDX("TXx9", 3, "cs", 3, GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP_IDX("TXx9", 4, "cs", 4, GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP_IDX("TXx9", 5, "cs", 5, GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP_IDX("TXx9", 6, "cs", 6, GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP_IDX("TXx9", 7, "cs", 7, GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP_IDX("TXx9", 8, "cs", 8, GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP_IDX("TXx9", 9, "cs", 9, GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP_IDX("TXx9", 10, "cs", 10, GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP_IDX("TXx9", 11, "cs", 11, GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP_IDX("TXx9", 12, "cs", 12, GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP_IDX("TXx9", 13, "cs", 13, GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP_IDX("TXx9", 14, "cs", 14, GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP_IDX("TXx9", 15, "cs", 15, GPIO_ACTIVE_LOW),
+		{ },
+	},
+};
+
 static int txx9spi_probe(struct platform_device *dev)
 {
 	struct spi_master *master;
@@ -372,12 +410,14 @@ static int txx9spi_probe(struct platform_device *dev)
 	if (ret)
 		goto exit;
 
-	c->last_chipselect = -1;
+	c->last_chipselect = NULL;
 
 	dev_info(&dev->dev, "at %#llx, irq %d, %dMHz\n",
 		 (unsigned long long)res->start, irq,
 		 (c->baseclk + 500000) / 1000000);
 
+	gpiod_add_lookup_table(&txx9spi_cs_gpio_table);
+
 	/* the spi->mode bits understood by this driver: */
 	master->mode_bits = SPI_CS_HIGH | SPI_CPOL | SPI_CPHA;
 
@@ -386,6 +426,7 @@ static int txx9spi_probe(struct platform_device *dev)
 	master->transfer = txx9spi_transfer;
 	master->num_chipselect = (u16)UINT_MAX; /* any GPIO numbers */
 	master->bits_per_word_mask = SPI_BPW_MASK(8) | SPI_BPW_MASK(16);
+	master->use_gpio_descriptors = true;
 
 	ret = devm_spi_register_master(&dev->dev, master);
 	if (ret)
-- 
2.20.1

