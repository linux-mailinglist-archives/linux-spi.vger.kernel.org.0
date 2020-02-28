Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09221173F83
	for <lists+linux-spi@lfdr.de>; Fri, 28 Feb 2020 19:25:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbgB1SZk (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 28 Feb 2020 13:25:40 -0500
Received: from foss.arm.com ([217.140.110.172]:42650 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbgB1SZk (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 28 Feb 2020 13:25:40 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C3A4B31B;
        Fri, 28 Feb 2020 10:25:39 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 47EE23F7B4;
        Fri, 28 Feb 2020 10:25:39 -0800 (PST)
Date:   Fri, 28 Feb 2020 18:25:37 +0000
From:   Mark Brown <broonie@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     andriy.shevchenko@linux.intel.com, broonie@kernel.org,
        linuxarm@huawei.com, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: Applied "spi: Allow SPI controller override device buswidth" to the spi tree
In-Reply-To:  <1582903131-160033-2-git-send-email-john.garry@huawei.com>
Message-Id:  <applied-1582903131-160033-2-git-send-email-john.garry@huawei.com>
X-Patchwork-Hint: ignore
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: Allow SPI controller override device buswidth

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

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

From ea23578611dce2eeaf31dcfe12cd7130cf3d1411 Mon Sep 17 00:00:00 2001
From: John Garry <john.garry@huawei.com>
Date: Fri, 28 Feb 2020 23:18:49 +0800
Subject: [PATCH] spi: Allow SPI controller override device buswidth

Currently ACPI firmware description for a SPI device does not have any
method to describe the data buswidth on the board.

So even through the controller and device may support higher modes than
standard SPI, it cannot be assumed that the board does - as such, that
device is limited to standard SPI in such a circumstance.

As a workaround, allow the controller driver supply buswidth override bits,
which are used inform the core code that the controller driver knows the
buswidth supported on that board for that device.

A host controller driver might know this info from DMI tables, for example.

Signed-off-by: John Garry <john.garry@huawei.com>
Link: https://lore.kernel.org/r/1582903131-160033-2-git-send-email-john.garry@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi.c       | 4 +++-
 include/linux/spi/spi.h | 3 +++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 38b4c78df506..292f26807b41 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -510,6 +510,7 @@ struct spi_device *spi_alloc_device(struct spi_controller *ctlr)
 	spi->dev.bus = &spi_bus_type;
 	spi->dev.release = spidev_release;
 	spi->cs_gpio = -ENOENT;
+	spi->mode = ctlr->buswidth_override_bits;
 
 	spin_lock_init(&spi->statistics.lock);
 
@@ -2181,9 +2182,10 @@ static acpi_status acpi_register_spi_device(struct spi_controller *ctlr,
 		return AE_NO_MEMORY;
 	}
 
+
 	ACPI_COMPANION_SET(&spi->dev, adev);
 	spi->max_speed_hz	= lookup.max_speed_hz;
-	spi->mode		= lookup.mode;
+	spi->mode		|= lookup.mode;
 	spi->irq		= lookup.irq;
 	spi->bits_per_word	= lookup.bits_per_word;
 	spi->chip_select	= lookup.chip_select;
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 6d16ba01ff5a..600e3793303e 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -481,6 +481,9 @@ struct spi_controller {
 	/* spi_device.mode flags understood by this controller driver */
 	u32			mode_bits;
 
+	/* spi_device.mode flags override flags for this controller */
+	u32			buswidth_override_bits;
+
 	/* bitmask of supported bits_per_word for transfers */
 	u32			bits_per_word_mask;
 #define SPI_BPW_MASK(bits) BIT((bits) - 1)
-- 
2.20.1

