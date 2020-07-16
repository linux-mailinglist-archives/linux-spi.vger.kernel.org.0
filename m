Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34446221BCD
	for <lists+linux-spi@lfdr.de>; Thu, 16 Jul 2020 07:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725270AbgGPFLt (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 16 Jul 2020 01:11:49 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:45897 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbgGPFLt (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 16 Jul 2020 01:11:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1594876308; x=1626412308;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=f+rPT+jNEXdJoFoZf0UEA0FTUOzDbR/rIkJL2ofKWF0=;
  b=oQ4/q7HaCGy+dAbHIEAhHtg/6P5OU4eJvhQTMG1G7RmNQk7GjNnjKXKs
   b1ISXe6/ELBD2eW7ppQzbCgLM2wqqbExX94duAtdalGeQeTd2h7atkpSC
   HXun1P07Vzm6iQPpxHraycA29zqeGR0tXk5iO8EYRGAR1mSyF9+GLPvYW
   tEB7CZWWFZCYjsVPt8OUctYaQUmK1rswHklOeZcFZ0khbMhaEhKRdTgP6
   CVLsM423YcUallmsz0qJFg3OJZUSOQ4PWkTFfAHr0MICqq424LIVXby8q
   EufhbtJWoqWXUakr1WpTuiQ6PijbFBp/iiaCfmw7l2axYpZc1N5DzoT3J
   Q==;
IronPort-SDR: wQwQRKuCAYZPa4M66Lv+/DTAIg8SUlTR2tOOyI8CyphClmYcWz5VxQKli4nA5Q2CcH3oWfGiym
 ychYzYEoeftLGroJPtzwW6oqXZSYbkWtBCQVWFmDXKb6RQm7DW+MsGHAQ8iq8iI+GMcTQMDFhG
 Z2h//MYmbTst6ZAC4nGHgKSKS+V3Tr7m0IcxnqIEIg+JBAo9+flw2QT1vtkAQcQaT1tEUJCJ5M
 Cny35fvz+mQeYQORKopnKFgQ9JhQC3ZlyJP6CP8o6sxgyjcWweu5fl0+FcHVXHPQ52djQQufgl
 prU=
X-IronPort-AV: E=Sophos;i="5.75,358,1589266800"; 
   d="scan'208";a="84097825"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Jul 2020 22:11:48 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 15 Jul 2020 22:11:47 -0700
Received: from atudor-ThinkPad-T470p.amer.actel.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Wed, 15 Jul 2020 22:11:46 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <broonie@kernel.org>
CC:     <han.xu@nxp.com>, <trivial@kernel.org>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH trivial] spi: Fix SPI NOR and SPI NAND acronyms
Date:   Thu, 16 Jul 2020 08:11:44 +0300
Message-ID: <20200716051144.568606-1-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The industry refers to these flash types as "SPI NOR" and
"SPI NAND". Be consistent and use the same acronyms.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/spi/Kconfig        | 10 +++++-----
 drivers/spi/spi-fsl-qspi.c |  2 +-
 drivers/spi/spi-orion.c    |  2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index b89d03a36cbd..c11c6c5cb442 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -169,7 +169,7 @@ config SPI_BCM_QSPI
 	help
 	  Enables support for the Broadcom SPI flash and MSPI controller.
 	  Select this option for any one of BRCMSTB, iProc NSP and NS2 SoCs
-	  based platforms. This driver works for both SPI master for spi-nor
+	  based platforms. This driver works for both SPI master for SPI NOR
 	  flash device as well as MSPI device.
 
 config SPI_BITBANG
@@ -311,11 +311,11 @@ config SPI_FSL_QUADSPI
 	  supports the high-level SPI memory interface.
 
 config SPI_HISI_SFC_V3XX
-	tristate "HiSilicon SPI-NOR Flash Controller for Hi16XX chipsets"
+	tristate "HiSilicon SPI NOR Flash Controller for Hi16XX chipsets"
 	depends on (ARM64 && ACPI) || COMPILE_TEST
 	depends on HAS_IOMEM
 	help
-	  This enables support for HiSilicon v3xx SPI-NOR flash controller
+	  This enables support for HiSilicon v3xx SPI NOR flash controller
 	  found in hi16xx chipsets.
 
 config SPI_NXP_FLEXSPI
@@ -477,9 +477,9 @@ config SPI_MTK_NOR
 	depends on ARCH_MEDIATEK || COMPILE_TEST
 	help
 	  This enables support for SPI NOR controller found on MediaTek
-	  ARM SoCs. This is a controller specifically for SPI-NOR flash.
+	  ARM SoCs. This is a controller specifically for SPI NOR flash.
 	  It can perform generic SPI transfers up to 6 bytes via generic
-	  SPI interface as well as several SPI-NOR specific instructions
+	  SPI interface as well as several SPI NOR specific instructions
 	  via SPI MEM interface.
 
 config SPI_NPCM_FIU
diff --git a/drivers/spi/spi-fsl-qspi.c b/drivers/spi/spi-fsl-qspi.c
index 6766262d7e75..9851551ebbe0 100644
--- a/drivers/spi/spi-fsl-qspi.c
+++ b/drivers/spi/spi-fsl-qspi.c
@@ -15,7 +15,7 @@
  *     Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
  *     Suresh Gupta <suresh.gupta@nxp.com>
  *
- * Based on the original fsl-quadspi.c spi-nor driver:
+ * Based on the original fsl-quadspi.c SPI NOR driver:
  * Author: Freescale Semiconductor, Inc.
  *
  */
diff --git a/drivers/spi/spi-orion.c b/drivers/spi/spi-orion.c
index 43f73db22f21..b57b8b3cc26e 100644
--- a/drivers/spi/spi-orion.c
+++ b/drivers/spi/spi-orion.c
@@ -708,7 +708,7 @@ static int orion_spi_probe(struct platform_device *pdev)
 		/*
 		 * Only map one page for direct access. This is enough for the
 		 * simple TX transfer which only writes to the first word.
-		 * This needs to get extended for the direct SPI-NOR / SPI-NAND
+		 * This needs to get extended for the direct SPI NOR / SPI NAND
 		 * support, once this gets implemented.
 		 */
 		dir_acc = &spi->child[cs].direct_access;
-- 
2.25.1

