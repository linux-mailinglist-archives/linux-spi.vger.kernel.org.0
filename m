Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D276F1346F7
	for <lists+linux-spi@lfdr.de>; Wed,  8 Jan 2020 17:00:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbgAHP7o (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 8 Jan 2020 10:59:44 -0500
Received: from foss.arm.com ([217.140.110.172]:46758 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729287AbgAHP7W (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 8 Jan 2020 10:59:22 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DD31B31B;
        Wed,  8 Jan 2020 07:59:21 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6683F3F534;
        Wed,  8 Jan 2020 07:59:21 -0800 (PST)
Date:   Wed, 08 Jan 2020 15:59:20 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Chris Brandt <chris.brandt@renesas.com>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        =?UTF-8?q?Jan=20Kundr=C3=A1t?= <jan.kundrat@cesnet.cz>
Subject: Applied "spi: Add generic support for unused native cs with cs-gpios" to the spi tree
In-Reply-To: <20200102133822.29346-2-geert+renesas@glider.be>
Message-Id: <applied-20200102133822.29346-2-geert+renesas@glider.be>
X-Patchwork-Hint: ignore
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: Add generic support for unused native cs with cs-gpios

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.6

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

From 7d93aecdb58d47e8ed90b4a44c0fc9ffb8de941c Mon Sep 17 00:00:00 2001
From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 2 Jan 2020 14:38:17 +0100
Subject: [PATCH] spi: Add generic support for unused native cs with cs-gpios

Some SPI master controllers always drive a native chip select when
performing a transfer.  Hence when using both native and GPIO chip
selects, at least one native chip select must be left unused, to be
driven when performing transfers with slave devices using GPIO chip
selects.

Currently, to find an unused native chip select, SPI controller drivers
need to parse and process cs-gpios theirselves.  This is not only
duplicated in each driver that needs it, but also duplicates part of the
work done later at SPI controller registration time.  Note that this
cannot be done after spi_register_controller() returns, as at that time,
slave devices may have been probed already.

Hence add generic support to the SPI subsystem for finding an unused
native chip select.  Optionally, this unused native chip select, and all
other in-use native chip selects, can be validated against the maximum
number of native chip selects available on the controller hardware.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20200102133822.29346-2-geert+renesas@glider.be
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi.c       | 17 +++++++++++++++++
 include/linux/spi/spi.h |  8 ++++++++
 2 files changed, 25 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 5485ef89197c..197c9e0ac2a6 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2464,6 +2464,8 @@ static int spi_get_gpio_descs(struct spi_controller *ctlr)
 	int nb, i;
 	struct gpio_desc **cs;
 	struct device *dev = &ctlr->dev;
+	unsigned long native_cs_mask = 0;
+	unsigned int num_cs_gpios = 0;
 
 	nb = gpiod_count(dev, "cs");
 	ctlr->num_chipselect = max_t(int, nb, ctlr->num_chipselect);
@@ -2505,7 +2507,22 @@ static int spi_get_gpio_descs(struct spi_controller *ctlr)
 			if (!gpioname)
 				return -ENOMEM;
 			gpiod_set_consumer_name(cs[i], gpioname);
+			num_cs_gpios++;
+			continue;
+		}
+
+		if (ctlr->max_native_cs && i >= ctlr->max_native_cs) {
+			dev_err(dev, "Invalid native chip select %d\n", i);
+			return -EINVAL;
 		}
+		native_cs_mask |= BIT(i);
+	}
+
+	ctlr->unused_native_cs = ffz(native_cs_mask);
+	if (num_cs_gpios && ctlr->max_native_cs &&
+	    ctlr->unused_native_cs >= ctlr->max_native_cs) {
+		dev_err(dev, "No unused native chip select available\n");
+		return -EINVAL;
 	}
 
 	return 0;
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 98fe8663033a..e4011b852fc3 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -423,6 +423,12 @@ static inline void spi_unregister_driver(struct spi_driver *sdrv)
  *	GPIO descriptors rather than using global GPIO numbers grabbed by the
  *	driver. This will fill in @cs_gpiods and @cs_gpios should not be used,
  *	and SPI devices will have the cs_gpiod assigned rather than cs_gpio.
+ * @unused_native_cs: When cs_gpiods is used, spi_register_controller() will
+ *	fill in this field with the first unused native CS, to be used by SPI
+ *	controller drivers that need to drive a native CS when using GPIO CS.
+ * @max_native_cs: When cs_gpiods is used, and this field is filled in,
+ *	spi_register_controller() will validate all native CS (including the
+ *	unused native CS) against this value.
  * @statistics: statistics for the spi_controller
  * @dma_tx: DMA transmit channel
  * @dma_rx: DMA receive channel
@@ -624,6 +630,8 @@ struct spi_controller {
 	int			*cs_gpios;
 	struct gpio_desc	**cs_gpiods;
 	bool			use_gpio_descriptors;
+	u8			unused_native_cs;
+	u8			max_native_cs;
 
 	/* statistics */
 	struct spi_statistics	statistics;
-- 
2.20.1

