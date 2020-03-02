Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2036175F1E
	for <lists+linux-spi@lfdr.de>; Mon,  2 Mar 2020 17:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727299AbgCBQFR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 2 Mar 2020 11:05:17 -0500
Received: from foss.arm.com ([217.140.110.172]:34652 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727170AbgCBQFR (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 2 Mar 2020 11:05:17 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AC58B2F;
        Mon,  2 Mar 2020 08:05:16 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2EE2A3F7D8;
        Mon,  2 Mar 2020 08:05:16 -0800 (PST)
Date:   Mon, 02 Mar 2020 16:05:14 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Cc:     Igor Opaniuk <igor.opaniuk@toradex.com>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Mark Brown <broonie@kernel.org>,
        Oleksandr Suvorov <cryosay@gmail.com>,
        Philippe Schenker <philippe.schenker@toradex.com>
Subject: Applied "spi: spidev: fix speed setting message" to the spi tree
In-Reply-To:  <20200229161841.89144-3-oleksandr.suvorov@toradex.com>
Message-Id:  <applied-20200229161841.89144-3-oleksandr.suvorov@toradex.com>
X-Patchwork-Hint: ignore
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: spidev: fix speed setting message

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

From 4276fc82fc5d1aa24c6ad1a16fbaccf11fa61e02 Mon Sep 17 00:00:00 2001
From: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Date: Sat, 29 Feb 2020 18:18:41 +0200
Subject: [PATCH] spi: spidev: fix speed setting message

The message of max device speed setting is shown when
an error in spi_setup() occurs.
Instead, it should be shown when the setup call succeeds.

Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Link: https://lore.kernel.org/r/20200229161841.89144-3-oleksandr.suvorov@toradex.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spidev.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index c97e853dbf5c..80dd1025b953 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -454,10 +454,11 @@ spidev_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 
 			spi->max_speed_hz = tmp;
 			retval = spi_setup(spi);
-			if (retval >= 0)
+			if (retval == 0) {
 				spidev->speed_hz = tmp;
-			else
-				dev_dbg(&spi->dev, "%d Hz (max)\n", tmp);
+				dev_dbg(&spi->dev, "%d Hz (max)\n",
+					spidev->speed_hz);
+			}
 			spi->max_speed_hz = save;
 		}
 		break;
-- 
2.20.1

