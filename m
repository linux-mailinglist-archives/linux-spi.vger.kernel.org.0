Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 441501837D4
	for <lists+linux-spi@lfdr.de>; Thu, 12 Mar 2020 18:39:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbgCLRje (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 12 Mar 2020 13:39:34 -0400
Received: from foss.arm.com ([217.140.110.172]:38960 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726127AbgCLRjd (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 12 Mar 2020 13:39:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 298F530E;
        Thu, 12 Mar 2020 10:39:33 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A35763F6CF;
        Thu, 12 Mar 2020 10:39:32 -0700 (PDT)
Date:   Thu, 12 Mar 2020 17:39:31 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     broonie@kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "spi: meson-spicc: remove unused variables" to the spi tree
In-Reply-To:  <20200312133131.26430-2-narmstrong@baylibre.com>
Message-Id:  <applied-20200312133131.26430-2-narmstrong@baylibre.com>
X-Patchwork-Hint: ignore
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: meson-spicc: remove unused variables

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

From b9dfb20eed5c7dab37d6267a985dbe16df9e4293 Mon Sep 17 00:00:00 2001
From: Neil Armstrong <narmstrong@baylibre.com>
Date: Thu, 12 Mar 2020 14:31:23 +0100
Subject: [PATCH] spi: meson-spicc: remove unused variables

Remove unused variables from spicc data struct.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Link: https://lore.kernel.org/r/20200312133131.26430-2-narmstrong@baylibre.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-meson-spicc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/spi/spi-meson-spicc.c b/drivers/spi/spi-meson-spicc.c
index 7f5680fe2568..8425e5ae1273 100644
--- a/drivers/spi/spi-meson-spicc.c
+++ b/drivers/spi/spi-meson-spicc.c
@@ -130,9 +130,7 @@ struct meson_spicc_device {
 	u8				*rx_buf;
 	unsigned int			bytes_per_word;
 	unsigned long			tx_remain;
-	unsigned long			txb_remain;
 	unsigned long			rx_remain;
-	unsigned long			rxb_remain;
 	unsigned long			xfer_remain;
 	bool				is_burst_end;
 	bool				is_last_burst;
-- 
2.20.1

