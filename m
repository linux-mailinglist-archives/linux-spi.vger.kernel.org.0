Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 767F6173F7E
	for <lists+linux-spi@lfdr.de>; Fri, 28 Feb 2020 19:25:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgB1SZb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 28 Feb 2020 13:25:31 -0500
Received: from foss.arm.com ([217.140.110.172]:42624 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726740AbgB1SZb (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 28 Feb 2020 13:25:31 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C84E7FEC;
        Fri, 28 Feb 2020 10:25:30 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4B3703F7B4;
        Fri, 28 Feb 2020 10:25:30 -0800 (PST)
Date:   Fri, 28 Feb 2020 18:25:28 +0000
From:   Mark Brown <broonie@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     andriy.shevchenko@linux.intel.com, broonie@kernel.org,
        linuxarm@huawei.com, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: Applied "spi: HiSilicon v3xx: Use DMI quirk to set controller buswidth override bits" to the spi tree
In-Reply-To:  <1582903131-160033-4-git-send-email-john.garry@huawei.com>
Message-Id:  <applied-1582903131-160033-4-git-send-email-john.garry@huawei.com>
X-Patchwork-Hint: ignore
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: HiSilicon v3xx: Use DMI quirk to set controller buswidth override bits

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

From 34e608b023e96f51b31274435b49c8ae61e2389f Mon Sep 17 00:00:00 2001
From: John Garry <john.garry@huawei.com>
Date: Fri, 28 Feb 2020 23:18:51 +0800
Subject: [PATCH] spi: HiSilicon v3xx: Use DMI quirk to set controller buswidth
 override bits

The Huawei D06 board (and variants) can support Quad mode of operation.

Since we have no current method in ACPI SPI bus device resource description
to describe this information, use DMI to detect the board, and set the
controller buswidth override bits.

Signed-off-by: John Garry <john.garry@huawei.com>
Link: https://lore.kernel.org/r/1582903131-160033-4-git-send-email-john.garry@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-hisi-sfc-v3xx.c | 56 ++++++++++++++++++++++++++++++++-
 1 file changed, 55 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-hisi-sfc-v3xx.c b/drivers/spi/spi-hisi-sfc-v3xx.c
index 45d906110ed1..e3b57252d075 100644
--- a/drivers/spi/spi-hisi-sfc-v3xx.c
+++ b/drivers/spi/spi-hisi-sfc-v3xx.c
@@ -7,6 +7,7 @@
 
 #include <linux/acpi.h>
 #include <linux/bitops.h>
+#include <linux/dmi.h>
 #include <linux/iopoll.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
@@ -250,6 +251,44 @@ static const struct spi_controller_mem_ops hisi_sfc_v3xx_mem_ops = {
 	.exec_op = hisi_sfc_v3xx_exec_op,
 };
 
+static int hisi_sfc_v3xx_buswidth_override_bits;
+
+/*
+ * ACPI FW does not allow us to currently set the device buswidth, so quirk it
+ * depending on the board.
+ */
+static int __init hisi_sfc_v3xx_dmi_quirk(const struct dmi_system_id *d)
+{
+	hisi_sfc_v3xx_buswidth_override_bits = SPI_RX_QUAD | SPI_TX_QUAD;
+
+	return 0;
+}
+
+static const struct dmi_system_id hisi_sfc_v3xx_dmi_quirk_table[]  = {
+	{
+	.callback = hisi_sfc_v3xx_dmi_quirk,
+	.matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "Huawei"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "D06"),
+	},
+	},
+	{
+	.callback = hisi_sfc_v3xx_dmi_quirk,
+	.matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "Huawei"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "TaiShan 2280 V2"),
+	},
+	},
+	{
+	.callback = hisi_sfc_v3xx_dmi_quirk,
+	.matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "Huawei"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "TaiShan 200 (Model 2280)"),
+	},
+	},
+	{}
+};
+
 static int hisi_sfc_v3xx_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -265,6 +304,8 @@ static int hisi_sfc_v3xx_probe(struct platform_device *pdev)
 	ctlr->mode_bits = SPI_RX_DUAL | SPI_RX_QUAD |
 			  SPI_TX_DUAL | SPI_TX_QUAD;
 
+	ctlr->buswidth_override_bits = hisi_sfc_v3xx_buswidth_override_bits;
+
 	host = spi_controller_get_devdata(ctlr);
 	host->dev = dev;
 
@@ -320,7 +361,20 @@ static struct platform_driver hisi_sfc_v3xx_spi_driver = {
 	.probe	= hisi_sfc_v3xx_probe,
 };
 
-module_platform_driver(hisi_sfc_v3xx_spi_driver);
+static int __init hisi_sfc_v3xx_spi_init(void)
+{
+	dmi_check_system(hisi_sfc_v3xx_dmi_quirk_table);
+
+	return platform_driver_register(&hisi_sfc_v3xx_spi_driver);
+}
+
+static void __exit hisi_sfc_v3xx_spi_exit(void)
+{
+	platform_driver_unregister(&hisi_sfc_v3xx_spi_driver);
+}
+
+module_init(hisi_sfc_v3xx_spi_init);
+module_exit(hisi_sfc_v3xx_spi_exit);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("John Garry <john.garry@huawei.com>");
-- 
2.20.1

