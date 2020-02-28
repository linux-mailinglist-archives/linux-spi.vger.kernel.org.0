Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6F4D173B41
	for <lists+linux-spi@lfdr.de>; Fri, 28 Feb 2020 16:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbgB1PXG (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 28 Feb 2020 10:23:06 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:40904 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726796AbgB1PXF (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 28 Feb 2020 10:23:05 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id E33A56AC8E6748186BEC;
        Fri, 28 Feb 2020 23:22:53 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.439.0; Fri, 28 Feb 2020 23:22:44 +0800
From:   John Garry <john.garry@huawei.com>
To:     <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>,
        <andriy.shevchenko@linux.intel.com>, <linuxarm@huawei.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH RFC 3/3] spi: HiSilicon v3xx: Use DMI quirk to set controller buswidth override bits
Date:   Fri, 28 Feb 2020 23:18:51 +0800
Message-ID: <1582903131-160033-4-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1582903131-160033-1-git-send-email-john.garry@huawei.com>
References: <1582903131-160033-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The Huawei D06 board (and variants) can support Quad mode of operation.

Since we have no current method in ACPI SPI bus device resource description
to describe this information, use DMI to detect the board, and set the
controller buswidth override bits.

Signed-off-by: John Garry <john.garry@huawei.com>
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
2.17.1

