Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4988917C192
	for <lists+linux-spi@lfdr.de>; Fri,  6 Mar 2020 16:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725922AbgCFPT1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 6 Mar 2020 10:19:27 -0500
Received: from foss.arm.com ([217.140.110.172]:35354 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725873AbgCFPT0 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 6 Mar 2020 10:19:26 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DC64E30E;
        Fri,  6 Mar 2020 07:19:25 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5F7A23F237;
        Fri,  6 Mar 2020 07:19:25 -0800 (PST)
Date:   Fri, 06 Mar 2020 15:19:23 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Joe Perches <joe@perches.com>
Cc:     John Garry <john.garry@huawei.com>,
        linux-spi <linux-spi@vger.kernel.org>, linux-spi@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Applied "spi: Remove CONFIG_ prefix from Kconfig select" to the spi tree
In-Reply-To:  <f8ac6b32a29b9a05b58a7e58ffe8b780642abbf1.camel@perches.com>
Message-Id:  <applied-f8ac6b32a29b9a05b58a7e58ffe8b780642abbf1.camel@perches.com>
X-Patchwork-Hint: ignore
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: Remove CONFIG_ prefix from Kconfig select

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

From e14572c52546c16e159c4c1814984843a119e823 Mon Sep 17 00:00:00 2001
From: Joe Perches <joe@perches.com>
Date: Thu, 5 Mar 2020 07:15:53 -0800
Subject: [PATCH] spi: Remove CONFIG_ prefix from Kconfig select

commit a2ca53b52e00 ("spi: Add HiSilicon v3xx SPI NOR flash
controller driver") likely inadvertently used a select statement
with a CONFIG_ prefix, remove the prefix.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Joe Perches <joe@perches.com>
Acked-by: John Garry <john.garry@huawei.com>
Link: https://lore.kernel.org/r/f8ac6b32a29b9a05b58a7e58ffe8b780642abbf1.camel@perches.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 887fefe87fd5..9c5dadb238dc 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -292,7 +292,7 @@ config SPI_HISI_SFC_V3XX
 	tristate "HiSilicon SPI-NOR Flash Controller for Hi16XX chipsets"
 	depends on (ARM64 && ACPI) || COMPILE_TEST
 	depends on HAS_IOMEM
-	select CONFIG_MTD_SPI_NOR
+	select MTD_SPI_NOR
 	help
 	  This enables support for HiSilicon v3xx SPI-NOR flash controller
 	  found in hi16xx chipsets.
-- 
2.20.1

