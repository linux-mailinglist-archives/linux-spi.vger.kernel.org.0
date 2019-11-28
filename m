Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CFFC10C95B
	for <lists+linux-spi@lfdr.de>; Thu, 28 Nov 2019 14:19:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbfK1NTI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 28 Nov 2019 08:19:08 -0500
Received: from foss.arm.com ([217.140.110.172]:35324 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726726AbfK1NTH (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 28 Nov 2019 08:19:07 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6D51F30E;
        Thu, 28 Nov 2019 05:19:07 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E07063F52E;
        Thu, 28 Nov 2019 05:19:06 -0800 (PST)
Date:   Thu, 28 Nov 2019 13:19:05 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     broonie@kernel.org, gregory.clement@bootlin.com,
        linus.walleij@linaro.org, Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: Applied "spi: cadence: Correct handling of native chipselect" to the spi tree
In-Reply-To: <20191126164140.6240-1-ckeepax@opensource.cirrus.com>
Message-Id: <applied-20191126164140.6240-1-ckeepax@opensource.cirrus.com>
X-Patchwork-Hint: ignore
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: cadence: Correct handling of native chipselect

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

From 61acd19f9c56fa0809285346bd0bd4a926ab0da0 Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.cirrus.com>
Date: Tue, 26 Nov 2019 16:41:40 +0000
Subject: [PATCH] spi: cadence: Correct handling of native chipselect

To fix a regression on the Cadence SPI driver, this patch reverts
commit 6046f5407ff0 ("spi: cadence: Fix default polarity of native
chipselect").

This patch was not the correct fix for the issue. The SPI framework
calls the set_cs line with the logic level it desires on the chip select
line, as such the old is_high handling was correct. However, this was
broken by the fact that before commit 3e5ec1db8bfe ("spi: Fix SPI_CS_HIGH
setting when using native and GPIO CS") all controllers that offered
the use of a GPIO chip select had SPI_CS_HIGH applied, even for hardware
chip selects. This caused the value passed into the driver to be inverted.
Which unfortunately makes it look like a logical enable the chip select
value.

Since the core was corrected to not unconditionally apply SPI_CS_HIGH,
the Cadence driver, whilst using the hardware chip select, will deselect
the chip select every time we attempt to communicate with the device,
which results in failed communications.

Fixes: 3e5ec1db8bfe ("spi: Fix SPI_CS_HIGH setting when using native and GPIO CS")
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Link: https://lore.kernel.org/r/20191126164140.6240-1-ckeepax@opensource.cirrus.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-cadence.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-cadence.c b/drivers/spi/spi-cadence.c
index c36587b42e95..82a0ee09cbe1 100644
--- a/drivers/spi/spi-cadence.c
+++ b/drivers/spi/spi-cadence.c
@@ -168,16 +168,16 @@ static void cdns_spi_init_hw(struct cdns_spi *xspi)
 /**
  * cdns_spi_chipselect - Select or deselect the chip select line
  * @spi:	Pointer to the spi_device structure
- * @enable:	Select (1) or deselect (0) the chip select line
+ * @is_high:	Select(0) or deselect (1) the chip select line
  */
-static void cdns_spi_chipselect(struct spi_device *spi, bool enable)
+static void cdns_spi_chipselect(struct spi_device *spi, bool is_high)
 {
 	struct cdns_spi *xspi = spi_master_get_devdata(spi->master);
 	u32 ctrl_reg;
 
 	ctrl_reg = cdns_spi_read(xspi, CDNS_SPI_CR);
 
-	if (!enable) {
+	if (is_high) {
 		/* Deselect the slave */
 		ctrl_reg |= CDNS_SPI_CR_SSCTRL;
 	} else {
-- 
2.20.1

