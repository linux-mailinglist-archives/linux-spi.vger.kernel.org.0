Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90B961837CD
	for <lists+linux-spi@lfdr.de>; Thu, 12 Mar 2020 18:39:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbgCLRjU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 12 Mar 2020 13:39:20 -0400
Received: from foss.arm.com ([217.140.110.172]:38918 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726127AbgCLRjU (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 12 Mar 2020 13:39:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DDB8430E;
        Thu, 12 Mar 2020 10:39:19 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 633BB3F6CF;
        Thu, 12 Mar 2020 10:39:19 -0700 (PDT)
Date:   Thu, 12 Mar 2020 17:39:17 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     broonie@kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Sunny Luo <sunny.luo@amlogic.com>,
        Yixun Lan <yixun.lan@amlogic.com>
Subject: Applied "spi: meson-spicc: support max 80MHz clock" to the spi tree
In-Reply-To:  <20200312133131.26430-5-narmstrong@baylibre.com>
Message-Id:  <applied-20200312133131.26430-5-narmstrong@baylibre.com>
X-Patchwork-Hint: ignore
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: meson-spicc: support max 80MHz clock

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

From 3196816ff64bb3a21fbda89e7355b6b87c3f50a0 Mon Sep 17 00:00:00 2001
From: Neil Armstrong <narmstrong@baylibre.com>
Date: Thu, 12 Mar 2020 14:31:26 +0100
Subject: [PATCH] spi: meson-spicc: support max 80MHz clock

The SPICC controller in Meson-AXG is capable of running at 80M clock.
The ASIC IP is improved and the clock is actually running higher than
previous old SoCs.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
Signed-off-by: Sunny Luo <sunny.luo@amlogic.com>
Link: https://lore.kernel.org/r/20200312133131.26430-5-narmstrong@baylibre.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-meson-spicc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-meson-spicc.c b/drivers/spi/spi-meson-spicc.c
index bd434d9055d9..710b4e780daa 100644
--- a/drivers/spi/spi-meson-spicc.c
+++ b/drivers/spi/spi-meson-spicc.c
@@ -35,7 +35,6 @@
  *   to have a CS go down over the full transfer
  */
 
-#define SPICC_MAX_FREQ	30000000
 #define SPICC_MAX_BURST	128
 
 /* Register Map */
@@ -132,6 +131,7 @@
 #define SPICC_FIFO_HALF 10
 
 struct meson_spicc_data {
+	unsigned int			max_speed_hz;
 	bool				has_oen;
 	bool				has_enhance_clk_div;
 };
@@ -693,11 +693,9 @@ static int meson_spicc_probe(struct platform_device *pdev)
 	master->transfer_one = meson_spicc_transfer_one;
 	master->use_gpio_descriptors = true;
 
-	/* Setup max rate according to the Meson GX datasheet */
-	if ((rate >> 2) > SPICC_MAX_FREQ)
-		master->max_speed_hz = SPICC_MAX_FREQ;
-	else
-		master->max_speed_hz = rate >> 2;
+	/* Setup max rate according to the Meson datasheet */
+	master->max_speed_hz = min_t(unsigned int, rate >> 1,
+				     spicc->data->max_speed_hz);
 
 	meson_spicc_oen_enable(spicc);
 
@@ -737,9 +735,11 @@ static int meson_spicc_remove(struct platform_device *pdev)
 }
 
 static const struct meson_spicc_data meson_spicc_gx_data = {
+	.max_speed_hz		= 30000000,
 };
 
 static const struct meson_spicc_data meson_spicc_axg_data = {
+	.max_speed_hz		= 80000000,
 	.has_oen		= true,
 	.has_enhance_clk_div	= true,
 };
-- 
2.20.1

