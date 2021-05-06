Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7782A374DC5
	for <lists+linux-spi@lfdr.de>; Thu,  6 May 2021 05:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231842AbhEFDBZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 5 May 2021 23:01:25 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:17469 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231745AbhEFDBY (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 5 May 2021 23:01:24 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FbJCy2qdWzkWqK;
        Thu,  6 May 2021 10:57:50 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.498.0; Thu, 6 May 2021 11:00:16 +0800
From:   Jay Fang <f.fangjian@huawei.com>
To:     <broonie@kernel.org>, <linus.walleij@linaro.org>
CC:     <linux-spi@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linuxarm@huawei.com>, <huangdaode@huawei.com>,
        <tangzihao1@hisilicon.com>
Subject: [PATCH 1/2] spi: Correct CS GPIOs polarity when using GPIO descriptors
Date:   Thu, 6 May 2021 11:00:16 +0800
Message-ID: <1620270017-52643-2-git-send-email-f.fangjian@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1620270017-52643-1-git-send-email-f.fangjian@huawei.com>
References: <1620270017-52643-1-git-send-email-f.fangjian@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

When using GPIO descriptors for CS GPIOs we need to inspect the child node
to determine if the 'cs-gpios' active flags should have inverted semantics.

Previously, commit 6953c57ab172 ("gpio: of: Handle SPI chipselect legacy
bindings") introduced a special quirk to solve the conflict between the
'cs-gpios' flags and the optional SPI slaves flags. The principle is that
the SPI slave flag will take precedence when we get a conflict. For more
details, see Documentation/devicetree/bindings/spi/spi-controller.yaml.

If following the previous commit, we need to add a new quirk to deal with
this in ACPI. Instead, this patch introduces a generic implementation to
solve this conflict by SPI core.

The 'cs-gpios' active rules are as follows:

1) DT (SPI device have active low chip selects by default):

    device node     | cs-gpio       | CS pin state active
    ================+===============+=====================
    spi-cs-high     | -             | H
    -               | -             | L
    spi-cs-high     | ACTIVE_HIGH   | H
    -               | ACTIVE_HIGH   | L
    spi-cs-high     | ACTIVE_LOW    | H
    -               | ACTIVE_LOW    | L

2) ACPI:

    device node     | cs-gpio       | CS pin state active
    ================+===============+=====================
    PolarityLow     | ACTIVE_LOW    | L
    PolarityLow     | ACTIVE_HIGH   | L
    PolarityHigh    | ACTIVE_LOW    | H
    PolarityHigh    | ACTIVE_HIGH   | H

Signed-off-by: Jay Fang <f.fangjian@huawei.com>
Signed-off-by: Zihao Tang <tangzihao1@hisilicon.com>
---
 drivers/spi/spi.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index b08efe8..2c0324d 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -33,6 +33,7 @@
 #include <linux/highmem.h>
 #include <linux/idr.h>
 #include <linux/platform_data/x86/apple.h>
+#include <../gpio/gpiolib.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/spi.h>
@@ -604,9 +605,26 @@ int spi_add_device(struct spi_device *spi)
 	}
 
 	/* Descriptors take precedence */
-	if (ctlr->cs_gpiods)
+	if (ctlr->cs_gpiods) {
 		spi->cs_gpiod = ctlr->cs_gpiods[spi->chip_select];
-	else if (ctlr->cs_gpios)
+
+		/* We need to handle the active flag conflict between
+		 * the cs-gpio and the SPI slave. The SPI slave active
+		 * flag will determine the active state of cs-gpio.
+		 */
+		if (spi->mode & SPI_CS_HIGH) {
+			if (test_bit(FLAG_ACTIVE_LOW, &spi->cs_gpiod->flags)) {
+				dev_warn(&spi->dev, "GPIO handle specifies "
+					"active low - ignored\n");
+				clear_bit(FLAG_ACTIVE_LOW, &spi->cs_gpiod->flags);
+			}
+		} else {
+			if (!test_bit(FLAG_ACTIVE_LOW, &spi->cs_gpiod->flags))
+				dev_warn(&spi->dev, "enforce active low on "
+					"chipselect handle\n");
+			set_bit(FLAG_ACTIVE_LOW, &spi->cs_gpiod->flags);
+		}
+	} else if (ctlr->cs_gpios)
 		spi->cs_gpio = ctlr->cs_gpios[spi->chip_select];
 
 	/* Drivers may modify this initial i/o setup, but will
-- 
2.7.4

