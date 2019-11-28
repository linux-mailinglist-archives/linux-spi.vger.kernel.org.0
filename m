Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 409E710C958
	for <lists+linux-spi@lfdr.de>; Thu, 28 Nov 2019 14:19:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbfK1NTF (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 28 Nov 2019 08:19:05 -0500
Received: from foss.arm.com ([217.140.110.172]:35314 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726734AbfK1NTF (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 28 Nov 2019 08:19:05 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F122A30E;
        Thu, 28 Nov 2019 05:19:04 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 701773F52E;
        Thu, 28 Nov 2019 05:19:04 -0800 (PST)
Date:   Thu, 28 Nov 2019 13:19:02 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     broonie@kernel.org, gregory.clement@bootlin.com,
        linus.walleij@linaro.org, Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: Applied "spi: dw: Correct handling of native chipselect" to the spi tree
In-Reply-To: <20191127153936.29719-1-ckeepax@opensource.cirrus.com>
Message-Id: <applied-20191127153936.29719-1-ckeepax@opensource.cirrus.com>
X-Patchwork-Hint: ignore
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: dw: Correct handling of native chipselect

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

From ada9e3fcc175db4538f5b5e05abf5dedf626e550 Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.cirrus.com>
Date: Wed, 27 Nov 2019 15:39:36 +0000
Subject: [PATCH] spi: dw: Correct handling of native chipselect

This patch reverts commit 6e0a32d6f376 ("spi: dw: Fix default polarity
of native chipselect").

The SPI framework always called the set_cs callback with the logic
level it desired on the chip select line, which is what the drivers
original handling supported. commit f3186dd87669 ("spi: Optionally
use GPIO descriptors for CS GPIOs") changed these symantics, but only
in the case of drivers that also support GPIO chip selects, to true
meaning apply slave select rather than logic high. This left things in
an odd state where a driver that only supports hardware chip selects,
the core would handle polarity but if the driver supported GPIOs as
well the driver should handle polarity.  At this point the reverted
change was applied to change the logic in the driver to match new
system.

This was then broken by commit 3e5ec1db8bfe ("spi: Fix SPI_CS_HIGH
setting when using native and GPIO CS") which reverted the core back
to consistently calling set_cs with a logic level.

This fix reverts the driver code back to its original state to match
the current core code. This is probably a better fix as a) the set_cs
callback is always called with consistent symantics and b) the
inversion for SPI_CS_HIGH can be handled in the core and doesn't need
to be coded in each driver supporting it.

Fixes: 3e5ec1db8bfe ("spi: Fix SPI_CS_HIGH setting when using native and GPIO CS")
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Link: https://lore.kernel.org/r/20191127153936.29719-1-ckeepax@opensource.cirrus.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-dw.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index 466f5c67843b..9387f60eb496 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -129,10 +129,11 @@ void dw_spi_set_cs(struct spi_device *spi, bool enable)
 	struct dw_spi *dws = spi_controller_get_devdata(spi->controller);
 	struct chip_data *chip = spi_get_ctldata(spi);
 
+	/* Chip select logic is inverted from spi_set_cs() */
 	if (chip && chip->cs_control)
-		chip->cs_control(enable);
+		chip->cs_control(!enable);
 
-	if (enable)
+	if (!enable)
 		dw_writel(dws, DW_SPI_SER, BIT(spi->chip_select));
 	else if (dws->cs_override)
 		dw_writel(dws, DW_SPI_SER, 0);
-- 
2.20.1

