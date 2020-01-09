Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A451136294
	for <lists+linux-spi@lfdr.de>; Thu,  9 Jan 2020 22:31:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725791AbgAIVbK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 9 Jan 2020 16:31:10 -0500
Received: from foss.arm.com ([217.140.110.172]:37090 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725763AbgAIVbK (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 9 Jan 2020 16:31:10 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A7C631007;
        Thu,  9 Jan 2020 13:31:09 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2F4273F534;
        Thu,  9 Jan 2020 13:31:09 -0800 (PST)
Date:   Thu, 09 Jan 2020 21:31:07 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     linux-rpi-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: Applied "spi: bcm2835: Raise maximum number of slaves to 4" to the spi tree
In-Reply-To: <01453fd062de2d49bd74a847e13a0781cbf8143d.1578572268.git.lukas@wunner.de>
Message-Id: <applied-01453fd062de2d49bd74a847e13a0781cbf8143d.1578572268.git.lukas@wunner.de>
X-Patchwork-Hint: ignore
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: bcm2835: Raise maximum number of slaves to 4

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

From 603e92ff10a81b965ac41dc9fb3d287408e834fb Mon Sep 17 00:00:00 2001
From: Lukas Wunner <lukas@wunner.de>
Date: Thu, 9 Jan 2020 13:23:41 +0100
Subject: [PATCH] spi: bcm2835: Raise maximum number of slaves to 4

The "RevPi Connect Flat" PLC offered by KUNBUS has 4 slaves attached
to the BCM2835 SPI master.  Raise the maximum number of slaves in the
driver accordingly.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
Reviewed-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Link: https://lore.kernel.org/r/01453fd062de2d49bd74a847e13a0781cbf8143d.1578572268.git.lukas@wunner.de
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-bcm2835.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index b784c9fdf9ec..11c235879bb7 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -68,7 +68,7 @@
 #define BCM2835_SPI_FIFO_SIZE		64
 #define BCM2835_SPI_FIFO_SIZE_3_4	48
 #define BCM2835_SPI_DMA_MIN_LENGTH	96
-#define BCM2835_SPI_NUM_CS		3   /* raise as necessary */
+#define BCM2835_SPI_NUM_CS		4   /* raise as necessary */
 #define BCM2835_SPI_MODE_BITS	(SPI_CPOL | SPI_CPHA | SPI_CS_HIGH \
 				| SPI_NO_CS | SPI_3WIRE)
 
-- 
2.20.1

