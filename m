Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C04F1175F27
	for <lists+linux-spi@lfdr.de>; Mon,  2 Mar 2020 17:05:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbgCBQF0 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 2 Mar 2020 11:05:26 -0500
Received: from foss.arm.com ([217.140.110.172]:34698 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727154AbgCBQF0 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 2 Mar 2020 11:05:26 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DE0782F;
        Mon,  2 Mar 2020 08:05:25 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5CCD53F534;
        Mon,  2 Mar 2020 08:05:25 -0800 (PST)
Date:   Mon, 02 Mar 2020 16:05:23 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     bcm-kernel-feedback-list@broadcom.com, broonie@kernel.org,
        f.fainelli@gmail.com, jonas.gorski@gmail.com,
        Jonas Gorski <jonas.gorski@gmail.com>,
        kernel-janitors@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "spi: bcm63xx-hsspi: Really keep pll clk enabled" to the spi tree
In-Reply-To:  <20200228213838.7124-1-christophe.jaillet@wanadoo.fr>
Message-Id:  <applied-20200228213838.7124-1-christophe.jaillet@wanadoo.fr>
X-Patchwork-Hint: ignore
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: bcm63xx-hsspi: Really keep pll clk enabled

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

From 51bddd4501bc414b8b1e8f4d096b4a5304068169 Mon Sep 17 00:00:00 2001
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Date: Fri, 28 Feb 2020 22:38:38 +0100
Subject: [PATCH] spi: bcm63xx-hsspi: Really keep pll clk enabled

The purpose of commit 0fd85869c2a9 ("spi/bcm63xx-hsspi: keep pll clk enabled")
was to keep the pll clk enabled through the lifetime of the device.

In order to do that, some 'clk_prepare_enable()'/'clk_disable_unprepare()'
calls have been added in the error handling path of the probe function, in
the remove function and in the suspend and resume functions.

However, a 'clk_disable_unprepare()' call has been unfortunately left in
the probe function. So the commit seems to be more or less a no-op.

Axe it now, so that the pll clk is left enabled through the lifetime of
the device, as described in the commit.

Fixes: 0fd85869c2a9 ("spi/bcm63xx-hsspi: keep pll clk enabled")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Acked-by: Jonas Gorski <jonas.gorski@gmail.com>
Link: https://lore.kernel.org/r/20200228213838.7124-1-christophe.jaillet@wanadoo.fr
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-bcm63xx-hsspi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-bcm63xx-hsspi.c b/drivers/spi/spi-bcm63xx-hsspi.c
index 7327309ea3d5..6c235306c0e4 100644
--- a/drivers/spi/spi-bcm63xx-hsspi.c
+++ b/drivers/spi/spi-bcm63xx-hsspi.c
@@ -366,7 +366,6 @@ static int bcm63xx_hsspi_probe(struct platform_device *pdev)
 			goto out_disable_clk;
 
 		rate = clk_get_rate(pll_clk);
-		clk_disable_unprepare(pll_clk);
 		if (!rate) {
 			ret = -EINVAL;
 			goto out_disable_pll_clk;
-- 
2.20.1

