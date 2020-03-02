Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CDA8175F24
	for <lists+linux-spi@lfdr.de>; Mon,  2 Mar 2020 17:05:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbgCBQFW (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 2 Mar 2020 11:05:22 -0500
Received: from foss.arm.com ([217.140.110.172]:34684 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727170AbgCBQFV (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 2 Mar 2020 11:05:21 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 65F9D1045;
        Mon,  2 Mar 2020 08:05:21 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DCD533F534;
        Mon,  2 Mar 2020 08:05:20 -0800 (PST)
Date:   Mon, 02 Mar 2020 16:05:19 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Cc:     Igor Opaniuk <igor.opaniuk@toradex.com>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Mark Brown <broonie@kernel.org>,
        Oleksandr Suvorov <cryosay@gmail.com>,
        Philippe Schenker <philippe.schenker@toradex.com>
Subject: Applied "spi: spidev: fix a debug message value" to the spi tree
In-Reply-To:  <20200229161841.89144-2-oleksandr.suvorov@toradex.com>
Message-Id:  <applied-20200229161841.89144-2-oleksandr.suvorov@toradex.com>
X-Patchwork-Hint: ignore
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: spidev: fix a debug message value

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

From ea70fb5b3e8b795730ab5716592bb573648434bb Mon Sep 17 00:00:00 2001
From: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Date: Sat, 29 Feb 2020 18:18:40 +0200
Subject: [PATCH] spi: spidev: fix a debug message value

The debug message in spidev_message() can show wrong xfer speed.
It happens if the initial (came from DT) and set with ioctl call spidev
speeds are different (spidev->speed_hz != spi->max_speed_hz) and one
sends a message with ioctl call and the field of speed is uninitialized
(u_tmp->speed_hz == 0).

In this case the kernel shows the spi->max_speed_hz value instead of
correct spidev->speed_hz.
...
set the max speed with an ioctl call:
[ 1227.702714] spidev spi0.0: setup mode 0, 32 bits/w, 20000000 Hz max --> 0
(real speed sets to 20000000Hz)
send a message with an ioctl call:
[ 1227.731801] spidev spi0.0:   xfer len 4096 tx 32bits 0 usec 10000000Hz
(debug message shows 10000000Hz that is the original max speed of this
spidev came from DT)
...

Fix the data source for the debug message.

Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Link: https://lore.kernel.org/r/20200229161841.89144-2-oleksandr.suvorov@toradex.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spidev.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 2ab6e782f14c..c97e853dbf5c 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -275,14 +275,14 @@ static int spidev_message(struct spidev_data *spidev,
 #ifdef VERBOSE
 		dev_dbg(&spidev->spi->dev,
 			"  xfer len %u %s%s%s%dbits %u usec %u usec %uHz\n",
-			u_tmp->len,
-			u_tmp->rx_buf ? "rx " : "",
-			u_tmp->tx_buf ? "tx " : "",
-			u_tmp->cs_change ? "cs " : "",
-			u_tmp->bits_per_word ? : spidev->spi->bits_per_word,
-			u_tmp->delay_usecs,
-			u_tmp->word_delay_usecs,
-			u_tmp->speed_hz ? : spidev->spi->max_speed_hz);
+			k_tmp->len,
+			k_tmp->rx_buf ? "rx " : "",
+			k_tmp->tx_buf ? "tx " : "",
+			k_tmp->cs_change ? "cs " : "",
+			k_tmp->bits_per_word ? : spidev->spi->bits_per_word,
+			k_tmp->delay.value,
+			k_tmp->word_delay.value,
+			k_tmp->speed_hz ? : spidev->spi->max_speed_hz);
 #endif
 		spi_message_add_tail(k_tmp, &msg);
 	}
-- 
2.20.1

