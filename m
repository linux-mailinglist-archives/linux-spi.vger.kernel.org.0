Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E782177CD3
	for <lists+linux-spi@lfdr.de>; Tue,  3 Mar 2020 18:09:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729570AbgCCRIW (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 3 Mar 2020 12:08:22 -0500
Received: from foss.arm.com ([217.140.110.172]:49994 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729041AbgCCRIW (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 3 Mar 2020 12:08:22 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 646CC2F;
        Tue,  3 Mar 2020 09:08:22 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DC64F3F534;
        Tue,  3 Mar 2020 09:08:21 -0800 (PST)
Date:   Tue, 03 Mar 2020 17:08:20 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Cc:     Igor Opanyuk <igor.opanyuk@toradex.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-spi@vger.kernel.org,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Mark Brown <broonie@kernel.org>,
        Oleksandr Suvorov <cryosay@gmail.com>,
        Philippe Schenker <philippe.schenker@toradex.com>
Subject: Applied "spi: fsl-lpspi: remove unneeded array" to the spi tree
In-Reply-To:  <20200220141143.3902922-2-oleksandr.suvorov@toradex.com>
Message-Id:  <applied-20200220141143.3902922-2-oleksandr.suvorov@toradex.com>
X-Patchwork-Hint: ignore
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: fsl-lpspi: remove unneeded array

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

From 2fa98705a9289c758b6154a22174aa8d4041a285 Mon Sep 17 00:00:00 2001
From: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Date: Thu, 20 Feb 2020 14:11:48 +0000
Subject: [PATCH] spi: fsl-lpspi: remove unneeded array

- replace the array with the shift operation
- remove the extra comparing operation.

Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Link: https://lore.kernel.org/r/20200220141143.3902922-2-oleksandr.suvorov@toradex.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-fsl-lpspi.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index d0b8cc741a24..298329b781d2 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -86,8 +86,6 @@
 #define TCR_RXMSK	BIT(19)
 #define TCR_TXMSK	BIT(18)
 
-static int clkdivs[] = {1, 2, 4, 8, 16, 32, 64, 128};
-
 struct lpspi_config {
 	u8 bpw;
 	u8 chip_select;
@@ -331,15 +329,14 @@ static int fsl_lpspi_set_bitrate(struct fsl_lpspi_data *fsl_lpspi)
 	}
 
 	for (prescale = 0; prescale < 8; prescale++) {
-		scldiv = perclk_rate /
-			 (clkdivs[prescale] * config.speed_hz) - 2;
+		scldiv = perclk_rate / config.speed_hz / (1 << prescale) - 2;
 		if (scldiv < 256) {
 			fsl_lpspi->config.prescale = prescale;
 			break;
 		}
 	}
 
-	if (prescale == 8 && scldiv >= 256)
+	if (scldiv >= 256)
 		return -EINVAL;
 
 	writel(scldiv | (scldiv << 8) | ((scldiv >> 1) << 16),
-- 
2.20.1

