Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0C2C122BE4
	for <lists+linux-spi@lfdr.de>; Tue, 17 Dec 2019 13:39:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbfLQMjl (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 17 Dec 2019 07:39:41 -0500
Received: from foss.arm.com ([217.140.110.172]:35688 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728051AbfLQMji (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 17 Dec 2019 07:39:38 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0941E328;
        Tue, 17 Dec 2019 04:39:38 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7CE8C3F718;
        Tue, 17 Dec 2019 04:39:37 -0800 (PST)
Date:   Tue, 17 Dec 2019 12:39:35 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jean Pihet <jean.pihet@newoldbits.com>
Cc:     Arnout Vandecappelle <arnout.vandecappelle@essensium.com>,
        Conrad Ratschan <conrad.ratschan@rockwellcollins.com>,
        linux-omap@vger.kernel.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Ryan Barnett <ryan.barnett@rockwellcollins.com>,
        Tony Lindgren <tony@atomide.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Applied "spi: spi-ti-qspi: Remove unused macro for fclk frequency" to the spi tree
In-Reply-To: <20191211193954.747745-2-jean.pihet@newoldbits.com>
Message-Id: <applied-20191211193954.747745-2-jean.pihet@newoldbits.com>
X-Patchwork-Hint: ignore
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: spi-ti-qspi: Remove unused macro for fclk frequency

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

From c1795f7cee026b066485de794cff4e5bb9475a98 Mon Sep 17 00:00:00 2001
From: Jean Pihet <jean.pihet@newoldbits.com>
Date: Wed, 11 Dec 2019 20:39:52 +0100
Subject: [PATCH] spi: spi-ti-qspi: Remove unused macro for fclk frequency

The fclk and its rate are retrieved from DT.

Signed-off-by: Jean Pihet <jean.pihet@newoldbits.com>
Cc: Ryan Barnett <ryan.barnett@rockwellcollins.com>
Cc: Conrad Ratschan <conrad.ratschan@rockwellcollins.com>
Cc: Arnout Vandecappelle <arnout.vandecappelle@essensium.com>
Link: https://lore.kernel.org/r/20191211193954.747745-2-jean.pihet@newoldbits.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-ti-qspi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index 3cb65371ae3b..a18835128ad0 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -79,8 +79,6 @@ struct ti_qspi {
 
 #define QSPI_COMPLETION_TIMEOUT		msecs_to_jiffies(2000)
 
-#define QSPI_FCLK			192000000
-
 /* Clock Control */
 #define QSPI_CLK_EN			(1 << 31)
 #define QSPI_CLK_DIV_MAX		0xffff
-- 
2.20.1

