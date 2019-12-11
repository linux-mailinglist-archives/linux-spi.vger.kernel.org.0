Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21A8511B942
	for <lists+linux-spi@lfdr.de>; Wed, 11 Dec 2019 17:55:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730510AbfLKQzN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 11 Dec 2019 11:55:13 -0500
Received: from foss.arm.com ([217.140.110.172]:39442 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727118AbfLKQzN (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 11 Dec 2019 11:55:13 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D622D30E;
        Wed, 11 Dec 2019 08:55:12 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 56A4E3F52E;
        Wed, 11 Dec 2019 08:55:12 -0800 (PST)
Date:   Wed, 11 Dec 2019 16:55:10 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     linux-renesas-soc@vger.kernel.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Simon Horman <horms+renesas@verge.net.au>
Subject: Applied "spi: rspi: Remove obsolete platform_device_id entries" to the spi tree
In-Reply-To: <20191211131553.23960-1-geert+renesas@glider.be>
Message-Id: <applied-20191211131553.23960-1-geert+renesas@glider.be>
X-Patchwork-Hint: ignore
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: rspi: Remove obsolete platform_device_id entries

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

From 851c902fd2d09b2ed85181e74b43477b7a3882be Mon Sep 17 00:00:00 2001
From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 11 Dec 2019 14:15:53 +0100
Subject: [PATCH] spi: rspi: Remove obsolete platform_device_id entries

Since commits 05104c266ae9a167 ("ARM: shmobile: r7s72100: genmai: Remove
legacy board file") and a483dcbfa21f919c ("ARM: shmobile: lager: Remove
legacy board support", RZ/A1 and R-Car Gen2 SoCs are only supported in
generic DT-only ARM multi-platform builds.  The driver doesn't need to
match platform devices by name anymore for these platforms, hence remove
the corresponding platform_device_id entries.

The platform_device_id entry for "rspi" is retained, as it is used by
the SH7757 platform, which hasn't been converted to DT yet.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Simon Horman <horms+renesas@verge.net.au>
Link: https://lore.kernel.org/r/20191211131553.23960-1-geert+renesas@glider.be
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-rspi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index 7222c7689c3c..74a12f4dee84 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -1314,8 +1314,6 @@ static int rspi_probe(struct platform_device *pdev)
 
 static const struct platform_device_id spi_driver_ids[] = {
 	{ "rspi",	(kernel_ulong_t)&rspi_ops },
-	{ "rspi-rz",	(kernel_ulong_t)&rspi_rz_ops },
-	{ "qspi",	(kernel_ulong_t)&qspi_ops },
 	{},
 };
 
-- 
2.20.1

