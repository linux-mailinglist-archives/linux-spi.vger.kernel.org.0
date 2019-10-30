Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23A72E9749
	for <lists+linux-spi@lfdr.de>; Wed, 30 Oct 2019 08:40:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726027AbfJ3Hko (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 30 Oct 2019 03:40:44 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37196 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbfJ3Hko (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 30 Oct 2019 03:40:44 -0400
Received: by mail-lf1-f66.google.com with SMTP id b20so763160lfp.4
        for <linux-spi@vger.kernel.org>; Wed, 30 Oct 2019 00:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RREdTBdq7HQxZnKMjBIZAoepDvAAe7/WrZQPOuJU5ZI=;
        b=yKZ2RbyeuXR2DXOrzXqGKHXrYiL3TZnVwUZe/bx/QlF3PbLQOfXLxO97jgmCPoYZ5l
         RY181akcqESLFjLjmd95ZV9GKEdgSv9Zbf5rpaq5xMSkoMWY/nw0RmDxi7DIDwn7DOlr
         Em2qRzoWbHsiRlt3kwo7DgBtDBJu9xfF5OHSxgASQ4NnnAM405BCjzfhgsaCq7iEkNxu
         OhDQnHVjj5dJkr5rx1YUPo9E8bo1dxQ0DeR38kfPvNDG20jtAQnZocurFecrWF3uSPwR
         o60vGheKRDRadrSUTSITPXaNodnzgBJbmb+Y6R1DaWRnDyhAF4mxbMxtOz4SZUBGt1j8
         CI2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RREdTBdq7HQxZnKMjBIZAoepDvAAe7/WrZQPOuJU5ZI=;
        b=PZ9ur0pRHktq/cPbKQHPevjk8NiIs8Q6ojBJb2+4WNcZKwP/VN71X9i+1tQQ1uLt0X
         GqPtTzd8heGArwzDoY3r7vvF3+oLFX0MQ8WQjQ/C44WzQ5XX0gV1QnGY0pbFqlMbQGu8
         UNEJzgTpo8bUxbPzqaE94Md4BepSgQevf+optLAoQPTv40A9P3xc2NgQRknFtMlF5q1i
         QtXpBI4ol+2YB1LyJ/7kigjIzhQMCEk442QgBNw9eBV2lwstxlG8lmasusTAkkMUBilg
         Ty+jhIO8Dcj7NtEvj9y20+oYYhaKOa8VIqvtJJavYkUtplvVsnzLrZycyNbFfWgqJiLP
         FhFg==
X-Gm-Message-State: APjAAAWROIjYBL8YKX79yf+YhkdFBCac/mUIPLRrOu0Jzb0JvAvo90Lr
        GtAhMYX8i3Zsvthjd2mFRViuHQ==
X-Google-Smtp-Source: APXvYqzYDZ6/7TMXCNkggaYm51jvNCYLywF92PYsegMY3jFW2JDiqLIxj2eBs+byngl5pyawMVkdJw==
X-Received: by 2002:a19:654d:: with SMTP id c13mr5062916lfj.30.1572421241748;
        Wed, 30 Oct 2019 00:40:41 -0700 (PDT)
Received: from localhost.localdomain (c-79c8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.200.121])
        by smtp.gmail.com with ESMTPSA id e2sm217541ljp.48.2019.10.30.00.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 00:40:40 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc:     linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Atsushi Nemoto <atsushi.nemoto@sord.co.jp>
Subject: [PATCH] spi: txx9: Convert to use GPIO descriptors
Date:   Wed, 30 Oct 2019 08:38:32 +0100
Message-Id: <20191030073832.24038-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

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
---
 drivers/spi/spi-txx9.c | 75 ++++++++++++++++++++++++++++++++----------
 1 file changed, 58 insertions(+), 17 deletions(-)

diff --git a/drivers/spi/spi-txx9.c b/drivers/spi/spi-txx9.c
index 51759d3fd45f..22b19d960d3b 100644
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
@@ -320,6 +317,47 @@ static int txx9spi_transfer(struct spi_device *spi, struct spi_message *m)
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
@@ -373,12 +411,14 @@ static int txx9spi_probe(struct platform_device *dev)
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
 
@@ -387,6 +427,7 @@ static int txx9spi_probe(struct platform_device *dev)
 	master->transfer = txx9spi_transfer;
 	master->num_chipselect = (u16)UINT_MAX; /* any GPIO numbers */
 	master->bits_per_word_mask = SPI_BPW_MASK(8) | SPI_BPW_MASK(16);
+	master->use_gpio_descriptors = true;
 
 	ret = devm_spi_register_master(&dev->dev, master);
 	if (ret)
-- 
2.21.0

