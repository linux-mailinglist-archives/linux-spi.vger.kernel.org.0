Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 317981A87A0
	for <lists+linux-spi@lfdr.de>; Tue, 14 Apr 2020 19:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407726AbgDNRg5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 14 Apr 2020 13:36:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:46336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407723AbgDNRgz (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 14 Apr 2020 13:36:55 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1641206B6;
        Tue, 14 Apr 2020 17:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586885815;
        bh=0gtq+ysQmCLWHecrd2BE7Xmt3ByEXc71uIUmS3qrl9w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=h7MMRrlqtIVJmWwe4nHvW1VvyBvwklSgcrzCPsZ28/feSr8QFgoGf7q25QOYYD5Ls
         YXYmziMKU//dHLyQud5jwiyaI0ntYLBgCqkXZgorEHdmo1diAx+owJ15tgmCHlU9Su
         8CgNmpo9+sV030B6a91UuRArMH57gbdQXPU9q05E=
Date:   Tue, 14 Apr 2020 18:36:52 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Baolin Wang <baolin.wang7@gmail.com>
Cc:     baolin.wang7@gmail.com, broonie@kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, orsonzhai@gmail.com,
        zhang.lyra@gmail.com
Subject: Applied "spi: sprd: adi: Use IS_ENABLED() to validate configs" to the spi tree
In-Reply-To:  <e38807eadd5550add8eb90dd3f8fbe2cfc39cc13.1586759322.git.baolin.wang7@gmail.com>
Message-Id:  <applied-e38807eadd5550add8eb90dd3f8fbe2cfc39cc13.1586759322.git.baolin.wang7@gmail.com>
X-Patchwork-Hint: ignore
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: sprd: adi: Use IS_ENABLED() to validate configs

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

From bb4bf8d2f4e0fdf64e43bb3a3186e04891b8a8e1 Mon Sep 17 00:00:00 2001
From: Baolin Wang <baolin.wang7@gmail.com>
Date: Mon, 13 Apr 2020 14:30:25 +0800
Subject: [PATCH] spi: sprd: adi: Use IS_ENABLED() to validate configs

If the Spreadtrum wachdog is loaded as a module, we still need set default
watchdog reboot mode in case the rebooting is caused by watchdog. But now
we can not set the watchdog reboot mode by using '#ifdef' to validate
the watchdog configuration, thus we can change to use IS_ENABLED() to
fix this issue.

Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
Link: https://lore.kernel.org/r/e38807eadd5550add8eb90dd3f8fbe2cfc39cc13.1586759322.git.baolin.wang7@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-sprd-adi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-sprd-adi.c b/drivers/spi/spi-sprd-adi.c
index 87dadb6b8ebf..88e6543648cb 100644
--- a/drivers/spi/spi-sprd-adi.c
+++ b/drivers/spi/spi-sprd-adi.c
@@ -319,7 +319,7 @@ static int sprd_adi_transfer_one(struct spi_controller *ctlr,
 
 static void sprd_adi_set_wdt_rst_mode(struct sprd_adi *sadi)
 {
-#ifdef CONFIG_SPRD_WATCHDOG
+#if IS_ENABLED(CONFIG_SPRD_WATCHDOG)
 	u32 val;
 
 	/* Set default watchdog reboot mode */
-- 
2.20.1

