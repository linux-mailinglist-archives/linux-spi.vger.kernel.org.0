Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3107F374DC4
	for <lists+linux-spi@lfdr.de>; Thu,  6 May 2021 05:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbhEFDBY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 5 May 2021 23:01:24 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:17468 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231758AbhEFDBY (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 5 May 2021 23:01:24 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FbJCy2bXCzkWqJ;
        Thu,  6 May 2021 10:57:50 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.498.0; Thu, 6 May 2021 11:00:17 +0800
From:   Jay Fang <f.fangjian@huawei.com>
To:     <broonie@kernel.org>, <linus.walleij@linaro.org>
CC:     <linux-spi@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linuxarm@huawei.com>, <huangdaode@huawei.com>,
        <tangzihao1@hisilicon.com>
Subject: [PATCH 2/2] Revert "gpio: of: Handle SPI chipselect legacy bindings"
Date:   Thu, 6 May 2021 11:00:17 +0800
Message-ID: <1620270017-52643-3-git-send-email-f.fangjian@huawei.com>
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

This reverts commit 6953c57ab1721ce57914fc5741d0ce0568756bb0.

The latter introduced a generic implementation to resolve it by SPI core
and is not needed anymore after the previous commit.

Signed-off-by: Jay Fang <f.fangjian@huawei.com>
---
 drivers/gpio/gpiolib-of.c | 51 ++---------------------------------------------
 1 file changed, 2 insertions(+), 49 deletions(-)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index baf0153..b8337f8b 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -132,8 +132,7 @@ bool of_gpio_need_valid_mask(const struct gpio_chip *gc)
 
 static void of_gpio_flags_quirks(struct device_node *np,
 				 const char *propname,
-				 enum of_gpio_flags *flags,
-				 int index)
+				 enum of_gpio_flags *flags)
 {
 	/*
 	 * Some GPIO fixed regulator quirks.
@@ -172,52 +171,6 @@ static void of_gpio_flags_quirks(struct device_node *np,
 			of_node_full_name(np));
 	}
 
-	/*
-	 * Legacy handling of SPI active high chip select. If we have a
-	 * property named "cs-gpios" we need to inspect the child node
-	 * to determine if the flags should have inverted semantics.
-	 */
-	if (IS_ENABLED(CONFIG_SPI_MASTER) && !strcmp(propname, "cs-gpios") &&
-	    of_property_read_bool(np, "cs-gpios")) {
-		struct device_node *child;
-		u32 cs;
-		int ret;
-
-		for_each_child_of_node(np, child) {
-			ret = of_property_read_u32(child, "reg", &cs);
-			if (ret)
-				continue;
-			if (cs == index) {
-				/*
-				 * SPI children have active low chip selects
-				 * by default. This can be specified negatively
-				 * by just omitting "spi-cs-high" in the
-				 * device node, or actively by tagging on
-				 * GPIO_ACTIVE_LOW as flag in the device
-				 * tree. If the line is simultaneously
-				 * tagged as active low in the device tree
-				 * and has the "spi-cs-high" set, we get a
-				 * conflict and the "spi-cs-high" flag will
-				 * take precedence.
-				 */
-				if (of_property_read_bool(child, "spi-cs-high")) {
-					if (*flags & OF_GPIO_ACTIVE_LOW) {
-						pr_warn("%s GPIO handle specifies active low - ignored\n",
-							of_node_full_name(child));
-						*flags &= ~OF_GPIO_ACTIVE_LOW;
-					}
-				} else {
-					if (!(*flags & OF_GPIO_ACTIVE_LOW))
-						pr_info("%s enforce active low on chipselect handle\n",
-							of_node_full_name(child));
-					*flags |= OF_GPIO_ACTIVE_LOW;
-				}
-				of_node_put(child);
-				break;
-			}
-		}
-	}
-
 	/* Legacy handling of stmmac's active-low PHY reset line */
 	if (IS_ENABLED(CONFIG_STMMAC_ETH) &&
 	    !strcmp(propname, "snps,reset-gpio") &&
@@ -263,7 +216,7 @@ static struct gpio_desc *of_get_named_gpiod_flags(struct device_node *np,
 		goto out;
 
 	if (flags)
-		of_gpio_flags_quirks(np, propname, flags, index);
+		of_gpio_flags_quirks(np, propname, flags);
 
 	pr_debug("%s: parsed '%s' property of node '%pOF[%d]' - status (%d)\n",
 		 __func__, propname, np, index,
-- 
2.7.4

