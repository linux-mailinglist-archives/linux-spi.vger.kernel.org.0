Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55AC6144330
	for <lists+linux-spi@lfdr.de>; Tue, 21 Jan 2020 18:29:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729108AbgAUR3R (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 21 Jan 2020 12:29:17 -0500
Received: from foss.arm.com ([217.140.110.172]:46556 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728186AbgAUR3R (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 21 Jan 2020 12:29:17 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A3A17328;
        Tue, 21 Jan 2020 09:29:16 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 20E3B3F6C4;
        Tue, 21 Jan 2020 09:29:15 -0800 (PST)
Date:   Tue, 21 Jan 2020 17:29:14 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Applied "spi: pxa2xx: Avoid touching SSCR0_SSE on MMP2" to the spi tree
In-Reply-To: <20200118094031.327373-1-lkundrak@v3.sk>
Message-Id: <applied-20200118094031.327373-1-lkundrak@v3.sk>
X-Patchwork-Hint: ignore
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: pxa2xx: Avoid touching SSCR0_SSE on MMP2

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

From 29d7e05c5f75fc2ebf3608743b6809aa0ff56800 Mon Sep 17 00:00:00 2001
From: Lubomir Rintel <lkundrak@v3.sk>
Date: Sat, 18 Jan 2020 10:40:31 +0100
Subject: [PATCH] spi: pxa2xx: Avoid touching SSCR0_SSE on MMP2

A read from a Winbond W25Q32FV SPI NOR memory chip on my MMP2 returns
wrong data.

It seems like SSE doesn't do the right thing on MMP2 at all. After
enabling the SPI port back again, the FIFO reads return garbage. Things
can be brought back to order by telling the PMU to reset the block.

Here's a good transaction with said chip:

  # busybox devmem 0xd4035000 32 0x00001987 # SSCR0
  # echo 0 >/sys/class/gpio/gpio46/value    # (assert CS)
  # busybox devmem 0xd4035010 32 0x0000009f # SSDR (read ID command)
  # busybox devmem 0xd4035010 32 0x00000000 # SSDR
  # busybox devmem 0xd4035010 32 0x00000000 # SSDR
  # busybox devmem 0xd4035010 32 0x00000000 # SSDR
  # busybox devmem 0xd4035010 32 0x00000000 # SSDR
  # busybox devmem 0xd4035010 32 0x00000000 # SSDR
  # busybox devmem 0xd4035010 32 0x00000000 # SSDR
  # busybox devmem 0xd4035010               # SSDR
  0x000000ff
  # busybox devmem 0xd4035010               # SSDR
  0x000000ef                                # Correct response
  # busybox devmem 0xd4035010               # SSDR
  0x00000040
  # busybox devmem 0xd4035010               # SSDR
  0x00000016
  # busybox devmem 0xd4035010               # SSDR
  0x00000000
  # busybox devmem 0xd4035010               # SSDR
  0x00000000
  # busybox devmem 0xd4035010               # SSDR
  0x00000000
  # echo 1 >/sys/class/gpio/gpio46/value # (deassert CS)
  #

Flipping off an on SSE, then running another transaction:

  # busybox devmem 0xd4035000 32 0x00001907 # SSCR0, SSE off
  # busybox devmem 0xd4035000 32 0x00001987 # SSCR0, SSE on
  # echo 0 >/sys/class/gpio/gpio46/value    # (assert CS)
  # busybox devmem 0xd4035010 32 0x0000009f # SSDR (read ID command)
  # busybox devmem 0xd4035010 32 0x00000000 # SSDR
  # busybox devmem 0xd4035010 32 0x00000000 # SSDR
  # busybox devmem 0xd4035010 32 0x00000000 # SSDR
  # busybox devmem 0xd4035010 32 0x00000000 # SSDR
  # busybox devmem 0xd4035010 32 0x00000000 # SSDR
  # busybox devmem 0xd4035010 32 0x00000000 # SSDR
  # busybox devmem 0xd4035010               # SSDR
  0x000000ff
  # busybox devmem 0xd4035010               # SSDR
  0x000000ff                                # Garbage!
  # busybox devmem 0xd4035010               # SSDR
  0x000000ff                                # Oh no
  # busybox devmem 0xd4035010               # SSDR
  0x000000ff
  # busybox devmem 0xd4035010               # SSDR
  0x000000ff
  # busybox devmem 0xd4035010               # SSDR
  0x000000ff
  # busybox devmem 0xd4035010               # SSDR
  0x000000ff
  # echo 1 >/sys/class/gpio/gpio46/value # (deassert CS)
  #

Sometimes the response is not just ones, but something that looks like
bits of a response from a previous transaction.

I can't see a fix other than not touching the SSE altogether after the
device is first brought up.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Link: https://lore.kernel.org/r/20200118094031.327373-1-lkundrak@v3.sk
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-pxa2xx.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 8114d3289fdc..0408782c7ed0 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -461,6 +461,16 @@ int pxa2xx_spi_flush(struct driver_data *drv_data)
 	return limit;
 }
 
+static void pxa2xx_spi_off(struct driver_data *drv_data)
+{
+	/* On MMP, disabling SSE seems to corrupt the rx fifo */
+	if (drv_data->ssp_type == MMP2_SSP)
+		return;
+
+	pxa2xx_spi_write(drv_data, SSCR0,
+			 pxa2xx_spi_read(drv_data, SSCR0) & ~SSCR0_SSE);
+}
+
 static int null_writer(struct driver_data *drv_data)
 {
 	u8 n_bytes = drv_data->n_bytes;
@@ -587,8 +597,7 @@ static void int_error_stop(struct driver_data *drv_data, const char* msg)
 	if (!pxa25x_ssp_comp(drv_data))
 		pxa2xx_spi_write(drv_data, SSTO, 0);
 	pxa2xx_spi_flush(drv_data);
-	pxa2xx_spi_write(drv_data, SSCR0,
-			 pxa2xx_spi_read(drv_data, SSCR0) & ~SSCR0_SSE);
+	pxa2xx_spi_off(drv_data);
 
 	dev_err(&drv_data->pdev->dev, "%s\n", msg);
 
@@ -686,8 +695,7 @@ static irqreturn_t interrupt_transfer(struct driver_data *drv_data)
 
 static void handle_bad_msg(struct driver_data *drv_data)
 {
-	pxa2xx_spi_write(drv_data, SSCR0,
-			 pxa2xx_spi_read(drv_data, SSCR0) & ~SSCR0_SSE);
+	pxa2xx_spi_off(drv_data);
 	pxa2xx_spi_write(drv_data, SSCR1,
 			 pxa2xx_spi_read(drv_data, SSCR1) & ~drv_data->int_cr1);
 	if (!pxa25x_ssp_comp(drv_data))
@@ -1062,7 +1070,8 @@ static int pxa2xx_spi_transfer_one(struct spi_controller *controller,
 	    || (pxa2xx_spi_read(drv_data, SSCR1) & change_mask)
 	    != (cr1 & change_mask)) {
 		/* stop the SSP, and update the other bits */
-		pxa2xx_spi_write(drv_data, SSCR0, cr0 & ~SSCR0_SSE);
+		if (drv_data->ssp_type != MMP2_SSP)
+			pxa2xx_spi_write(drv_data, SSCR0, cr0 & ~SSCR0_SSE);
 		if (!pxa25x_ssp_comp(drv_data))
 			pxa2xx_spi_write(drv_data, SSTO, chip->timeout);
 		/* first set CR1 without interrupt and service enables */
@@ -1118,8 +1127,7 @@ static int pxa2xx_spi_slave_abort(struct spi_controller *controller)
 	if (!pxa25x_ssp_comp(drv_data))
 		pxa2xx_spi_write(drv_data, SSTO, 0);
 	pxa2xx_spi_flush(drv_data);
-	pxa2xx_spi_write(drv_data, SSCR0,
-			 pxa2xx_spi_read(drv_data, SSCR0) & ~SSCR0_SSE);
+	pxa2xx_spi_off(drv_data);
 
 	dev_dbg(&drv_data->pdev->dev, "transfer aborted\n");
 
@@ -1135,8 +1143,7 @@ static void pxa2xx_spi_handle_err(struct spi_controller *controller,
 	struct driver_data *drv_data = spi_controller_get_devdata(controller);
 
 	/* Disable the SSP */
-	pxa2xx_spi_write(drv_data, SSCR0,
-			 pxa2xx_spi_read(drv_data, SSCR0) & ~SSCR0_SSE);
+	pxa2xx_spi_off(drv_data);
 	/* Clear and disable interrupts and service requests */
 	write_SSSR_CS(drv_data, drv_data->clear_sr);
 	pxa2xx_spi_write(drv_data, SSCR1,
@@ -1161,8 +1168,7 @@ static int pxa2xx_spi_unprepare_transfer(struct spi_controller *controller)
 	struct driver_data *drv_data = spi_controller_get_devdata(controller);
 
 	/* Disable the SSP now */
-	pxa2xx_spi_write(drv_data, SSCR0,
-			 pxa2xx_spi_read(drv_data, SSCR0) & ~SSCR0_SSE);
+	pxa2xx_spi_off(drv_data);
 
 	return 0;
 }
-- 
2.20.1

