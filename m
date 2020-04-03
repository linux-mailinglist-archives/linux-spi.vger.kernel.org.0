Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 868FA19D80D
	for <lists+linux-spi@lfdr.de>; Fri,  3 Apr 2020 15:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728154AbgDCN4G (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 3 Apr 2020 09:56:06 -0400
Received: from foss.arm.com ([217.140.110.172]:53532 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728023AbgDCN4G (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 3 Apr 2020 09:56:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F316031B;
        Fri,  3 Apr 2020 06:56:05 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5908B3F52E;
        Fri,  3 Apr 2020 06:56:05 -0700 (PDT)
Date:   Fri, 03 Apr 2020 14:56:03 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jungseung Lee <js07.lee@samsung.com>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: Applied "spi: spi-ep93xx: fix wrong SPI mode selection" to the spi tree
In-Reply-To:  <20200402121022.9976-1-js07.lee@samsung.com>
Message-Id:  <applied-20200402121022.9976-1-js07.lee@samsung.com>
X-Patchwork-Hint: ignore
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: spi-ep93xx: fix wrong SPI mode selection

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

From 61249ce08ee9d031070281dbf36871f1c794abb8 Mon Sep 17 00:00:00 2001
From: Jungseung Lee <js07.lee@samsung.com>
Date: Thu, 2 Apr 2020 21:10:22 +0900
Subject: [PATCH] spi: spi-ep93xx: fix wrong SPI mode selection

The mode bits on control register 0 are in a different order compared
to the spi mode define values. Thus, in the current code, it fails to
set the correct SPI mode selection. Fix it.

Signed-off-by: Jungseung Lee <js07.lee@samsung.com>
Link: https://lore.kernel.org/r/20200402121022.9976-1-js07.lee@samsung.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-ep93xx.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-ep93xx.c b/drivers/spi/spi-ep93xx.c
index 4e1ccd4e52b6..8c854b187b1d 100644
--- a/drivers/spi/spi-ep93xx.c
+++ b/drivers/spi/spi-ep93xx.c
@@ -31,7 +31,8 @@
 #include <linux/platform_data/spi-ep93xx.h>
 
 #define SSPCR0			0x0000
-#define SSPCR0_MODE_SHIFT	6
+#define SSPCR0_SPO		BIT(6)
+#define SSPCR0_SPH		BIT(7)
 #define SSPCR0_SCR_SHIFT	8
 
 #define SSPCR1			0x0004
@@ -159,7 +160,10 @@ static int ep93xx_spi_chip_setup(struct spi_master *master,
 		return err;
 
 	cr0 = div_scr << SSPCR0_SCR_SHIFT;
-	cr0 |= (spi->mode & (SPI_CPHA | SPI_CPOL)) << SSPCR0_MODE_SHIFT;
+	if (spi->mode & SPI_CPOL)
+		cr0 |= SSPCR0_SPO;
+	if (spi->mode & SPI_CPHA)
+		cr0 |= SSPCR0_SPH;
 	cr0 |= dss;
 
 	dev_dbg(&master->dev, "setup: mode %d, cpsr %d, scr %d, dss %d\n",
-- 
2.20.1

