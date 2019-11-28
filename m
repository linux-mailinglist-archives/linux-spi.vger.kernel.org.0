Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DABE10C954
	for <lists+linux-spi@lfdr.de>; Thu, 28 Nov 2019 14:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbfK1NTD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 28 Nov 2019 08:19:03 -0500
Received: from foss.arm.com ([217.140.110.172]:35306 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726227AbfK1NTD (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 28 Nov 2019 08:19:03 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 81B4130E;
        Thu, 28 Nov 2019 05:19:02 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0234A3F52E;
        Thu, 28 Nov 2019 05:19:01 -0800 (PST)
Date:   Thu, 28 Nov 2019 13:19:00 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Christophe Leroy <christophe.leroy@c-s.fr>,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "spi: fsl: Fix GPIO descriptor support" to the spi tree
In-Reply-To: <20191128083718.39177-1-linus.walleij@linaro.org>
Message-Id: <applied-20191128083718.39177-1-linus.walleij@linaro.org>
X-Patchwork-Hint: ignore
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: fsl: Fix GPIO descriptor support

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

From f106904968e2a075e64653b9b79dda9f0f070ab5 Mon Sep 17 00:00:00 2001
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 28 Nov 2019 09:37:16 +0100
Subject: [PATCH] spi: fsl: Fix GPIO descriptor support

This makes the driver actually support looking up GPIO
descriptor. A coding mistake in the initial descriptor
support patch was that it was failing to turn on the very
feature it was implementing. Mea culpa.

Cc: Christophe Leroy <christophe.leroy@c-s.fr>
Reported-by: Christophe Leroy <christophe.leroy@c-s.fr>
Fixes: 0f0581b24bd0 ("spi: fsl: Convert to use CS GPIO descriptors")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Tested-by: Christophe Leroy <christophe.leroy@c-s.fr>
Link: https://lore.kernel.org/r/20191128083718.39177-1-linus.walleij@linaro.org
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-fsl-spi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-fsl-spi.c b/drivers/spi/spi-fsl-spi.c
index 114801a32371..c87e9c4506c2 100644
--- a/drivers/spi/spi-fsl-spi.c
+++ b/drivers/spi/spi-fsl-spi.c
@@ -611,6 +611,7 @@ static struct spi_master * fsl_spi_probe(struct device *dev,
 	master->setup = fsl_spi_setup;
 	master->cleanup = fsl_spi_cleanup;
 	master->transfer_one_message = fsl_spi_do_one_msg;
+	master->use_gpio_descriptors = true;
 
 	mpc8xxx_spi = spi_master_get_devdata(master);
 	mpc8xxx_spi->max_bits_per_word = 32;
-- 
2.20.1

