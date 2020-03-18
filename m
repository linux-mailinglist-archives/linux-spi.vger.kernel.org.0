Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 933E718A2E8
	for <lists+linux-spi@lfdr.de>; Wed, 18 Mar 2020 20:08:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbgCRTIJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 18 Mar 2020 15:08:09 -0400
Received: from foss.arm.com ([217.140.110.172]:53584 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726506AbgCRTIJ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 18 Mar 2020 15:08:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C1DD41FB;
        Wed, 18 Mar 2020 12:08:08 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 340BE3F67D;
        Wed, 18 Mar 2020 12:08:08 -0700 (PDT)
Date:   Wed, 18 Mar 2020 19:08:06 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Fabio Estevam <fabio.estevam@nxp.com>, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: Applied "spi: mxs: Drop GPIO includes" to the spi tree
In-Reply-To: <20200317092457.264055-1-linus.walleij@linaro.org>
Message-Id: <applied-20200317092457.264055-1-linus.walleij@linaro.org>
X-Patchwork-Hint: ignore
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: mxs: Drop GPIO includes

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.7

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

From 85dadb718cc23492ef6edbc9af6c765a0c0aca66 Mon Sep 17 00:00:00 2001
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 17 Mar 2020 10:24:57 +0100
Subject: [PATCH] spi: mxs: Drop GPIO includes

This driver is not using any symbols from the GPIO .h files
so drop them.

It was however implicitly using <linux/pinctrl/consumer.h>
so include that instead.

Cc: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Link: https://lore.kernel.org/r/20200317092457.264055-1-linus.walleij@linaro.org
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-mxs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/spi/spi-mxs.c b/drivers/spi/spi-mxs.c
index dce85ee07cd0..918918a9e049 100644
--- a/drivers/spi/spi-mxs.c
+++ b/drivers/spi/spi-mxs.c
@@ -22,7 +22,6 @@
 #include <linux/ioport.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
-#include <linux/of_gpio.h>
 #include <linux/platform_device.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
@@ -32,7 +31,7 @@
 #include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/completion.h>
-#include <linux/gpio.h>
+#include <linux/pinctrl/consumer.h>
 #include <linux/regulator/consumer.h>
 #include <linux/pm_runtime.h>
 #include <linux/module.h>
-- 
2.20.1

