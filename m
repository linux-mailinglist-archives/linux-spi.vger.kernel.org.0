Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EACF715939B
	for <lists+linux-spi@lfdr.de>; Tue, 11 Feb 2020 16:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730259AbgBKPtZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 11 Feb 2020 10:49:25 -0500
Received: from foss.arm.com ([217.140.110.172]:48492 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730377AbgBKPtZ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 11 Feb 2020 10:49:25 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AD3F531B;
        Tue, 11 Feb 2020 07:49:24 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 329183F68E;
        Tue, 11 Feb 2020 07:49:24 -0800 (PST)
Date:   Tue, 11 Feb 2020 15:49:22 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     alsa-devel@alsa-project.org,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Jie Yang <yang.jie@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Takashi Iwai <tiwai@suse.com>
Subject: Applied "spi: pxa2xx: Enable support for compile-testing" to the asoc tree
In-Reply-To: <20200210093027.6672-1-geert@linux-m68k.org>
Message-Id: <applied-20200210093027.6672-1-geert@linux-m68k.org>
X-Patchwork-Hint: ignore
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: pxa2xx: Enable support for compile-testing

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.7

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

From 0d4416446897a91bb19ba837b97b607caea59a8f Mon Sep 17 00:00:00 2001
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 10 Feb 2020 10:30:27 +0100
Subject: [PATCH] spi: pxa2xx: Enable support for compile-testing

m68k/allmodconfig:

    WARNING: unmet direct dependencies detected for SPI_PXA2XX
      Depends on [n]: SPI [=y] && SPI_MASTER [=y] && (ARCH_PXA || ARCH_MMP || PCI [=n] || ACPI)
      Selected by [m]:
      - SND_SOC_INTEL_BDW_RT5677_MACH [=m] && SOUND [=m] && !UML && SND [=m] && SND_SOC [=m] && SND_SOC_INTEL_MACH [=y] && (SND_SOC_INTEL_HASWELL [=n] || SND_SOC_SOF_BROADWELL [=m]) && I2C [=m] && (I2C_DESIGNWARE_PLATFORM [=m] || COMPILE_TEST [=y]) && (GPIOLIB [=y] || COMPILE_TEST [=y]) && (X86_INTEL_LPSS || COMPILE_TEST [=y]) && SPI_MASTER [=y]

This happens because SND_SOC_INTEL_BDW_RT5677_MACH selects SPI_PXA2XX,
and the former depends on COMPILE_TEST, while the latter does not.

Fix this by enabling compile-testing for SPI_PXA2XX.

Fixes: 630db1549356f644 ("ASoC: Intel: bdw-rt5677: fix Kconfig dependencies")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20200210093027.6672-1-geert@linux-m68k.org
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index d6ed0c355954..912cd6e35726 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -551,7 +551,7 @@ config SPI_PPC4xx
 
 config SPI_PXA2XX
 	tristate "PXA2xx SSP SPI master"
-	depends on (ARCH_PXA || ARCH_MMP || PCI || ACPI)
+	depends on ARCH_PXA || ARCH_MMP || PCI || ACPI || COMPILE_TEST
 	select PXA_SSP if ARCH_PXA || ARCH_MMP
 	help
 	  This enables using a PXA2xx or Sodaville SSP port as a SPI master
-- 
2.20.1

