Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B0721820E6
	for <lists+linux-spi@lfdr.de>; Wed, 11 Mar 2020 19:35:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730781AbgCKSfe (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 11 Mar 2020 14:35:34 -0400
Received: from foss.arm.com ([217.140.110.172]:53466 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730641AbgCKSfe (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 11 Mar 2020 14:35:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3869D1FB;
        Wed, 11 Mar 2020 11:35:33 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B02773F6CF;
        Wed, 11 Mar 2020 11:35:32 -0700 (PDT)
Date:   Wed, 11 Mar 2020 18:35:31 +0000
From:   Mark Brown <broonie@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     broonie@kernel.org, chenxiang66@hisilicon.com, joe@perches.com,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-next@vger.kernel.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, rdunlap@infradead.org,
        sfr@canb.auug.org.au, Tudor.Ambarus@microchip.com
Subject: Applied "spi: Stop selecting MTD_SPI_NOR for SPI_HISI_SFC_V3XX" to the spi tree
In-Reply-To:  <1583948115-239907-1-git-send-email-john.garry@huawei.com>
Message-Id:  <applied-1583948115-239907-1-git-send-email-john.garry@huawei.com>
X-Patchwork-Hint: ignore
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: Stop selecting MTD_SPI_NOR for SPI_HISI_SFC_V3XX

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

From caef2df1137adcea48b0902f310f4639b846e3a1 Mon Sep 17 00:00:00 2001
From: John Garry <john.garry@huawei.com>
Date: Thu, 12 Mar 2020 01:35:15 +0800
Subject: [PATCH] spi: Stop selecting MTD_SPI_NOR for SPI_HISI_SFC_V3XX

By selecting MTD_SPI_NOR for SPI_HISI_SFC_V3XX, we may introduce unmet
dependencies:

WARNING: unmet direct dependencies detected for MTD_SPI_NOR
  Depends on [m]: MTD [=m] && SPI_MASTER [=y]
  Selected by [y]:
  - SPI_HISI_SFC_V3XX [=y] && SPI [=y] && SPI_MASTER [=y] && (ARM64 && ACPI [=y] || COMPILE_TEST [=y]) && HAS_IOMEM [=y]

Since MTD_SPI_NOR is only selected by SPI_HISI_SFC_V3XX for practical
reasons - slave devices use the spi-nor driver, enabled by MTD_SPI_NOR -
just drop it.

Signed-off-by: John Garry <john.garry@huawei.com>

Link: https://lore.kernel.org/r/1583948115-239907-1-git-send-email-john.garry@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 8ad267cb15cd..ad79454d8584 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -299,7 +299,6 @@ config SPI_HISI_SFC_V3XX
 	tristate "HiSilicon SPI-NOR Flash Controller for Hi16XX chipsets"
 	depends on (ARM64 && ACPI) || COMPILE_TEST
 	depends on HAS_IOMEM
-	select MTD_SPI_NOR
 	help
 	  This enables support for HiSilicon v3xx SPI-NOR flash controller
 	  found in hi16xx chipsets.
-- 
2.20.1

