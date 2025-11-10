Return-Path: <linux-spi+bounces-11146-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F57AC48FA2
	for <lists+linux-spi@lfdr.de>; Mon, 10 Nov 2025 20:22:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F9B73AC31A
	for <lists+linux-spi@lfdr.de>; Mon, 10 Nov 2025 19:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2668332BF32;
	Mon, 10 Nov 2025 19:15:52 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from srv01.abscue.de (abscue.de [89.58.28.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535F0136351;
	Mon, 10 Nov 2025 19:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.28.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762802152; cv=none; b=bI8S34pHhZ7PMf+NNwauMafmS5+lAqfE/YmHS3uvUh6F6zboBVyzWd0LVy9HB1e5JAr3cQNW0pS8jiCPecL7CAJgwgVlpF8unbTELWo5t7Aus6g/BKJ9oPjllxhqHjeuFv6AuBUivRtSv7vjBocsROchbAKjcUgl7r6QszMvCJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762802152; c=relaxed/simple;
	bh=id2JJee4nGZVhNPaZX1f6WOSr0vjJcvlPgl2F1hrb+E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Pd6t0VP4DWp3EMAPLUKWN8WzNHW5uLYyCCC1PbeTrzKUYZaxjGJ4PV+s7HSo+6JridygNTgyNf18qPYCErx6OBaFnW76MSA/DJ8NqVdzYlzWrh4zLBj+tHduYRIeroB2ZIRDIzFMxtH1J2XpO9pN7wgN0tg4LiT67k2XCI/ABNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=abscue.de; spf=pass smtp.mailfrom=abscue.de; arc=none smtp.client-ip=89.58.28.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=abscue.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=abscue.de
Received: from srv01.abscue.de (localhost [127.0.0.1])
	by spamfilter.srv.local (Postfix) with ESMTP id 887CB1C0036;
	Mon, 10 Nov 2025 20:10:33 +0100 (CET)
X-Spam-Level: 
Received: from fluffy-mammal.metal.fwg-cag.de (unknown [IPv6:2001:9e8:cdd8:ff00:36bc:9812:27d4:17cf])
	by srv01.abscue.de (Postfix) with ESMTPSA id 3A6AC1C0241;
	Mon, 10 Nov 2025 20:10:30 +0100 (CET)
From: =?utf-8?q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>
Date: Mon, 10 Nov 2025 20:09:00 +0100
Subject: [PATCH v2 3/3] power: reset: sc27xx: Drop unused driver
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251110-sc27xx-mfd-poweroff-v2-3-fd5842e732fe@abscue.de>
References: <20251110-sc27xx-mfd-poweroff-v2-0-fd5842e732fe@abscue.de>
In-Reply-To: <20251110-sc27xx-mfd-poweroff-v2-0-fd5842e732fe@abscue.de>
To: Lee Jones <lee@kernel.org>, Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>
Cc: Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-spi@vger.kernel.org, linux-pm@vger.kernel.org, 
 =?utf-8?q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.14.2

This driver was never actually probed because it was missing an OF match
table and was not integrated into the MFD driver. Remove it now that the
power off functionality is handled directly in the MFD driver.

Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Otto Pflüger <otto.pflueger@abscue.de>
---
 drivers/power/reset/Kconfig           |  9 ----
 drivers/power/reset/Makefile          |  1 -
 drivers/power/reset/sc27xx-poweroff.c | 79 -----------------------------------
 3 files changed, 89 deletions(-)

diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index f6c1bcbb57deff3568d6b1b326454add3b3bbf06..007e2cd53bbfba8dddcd1a71118ddaf5ec47c0ff 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -329,15 +329,6 @@ config SYSCON_REBOOT_MODE
 	  register, then the bootloader can read it to take different
 	  action according to the mode.
 
-config POWER_RESET_SC27XX
-	tristate "Spreadtrum SC27xx PMIC power-off driver"
-	depends on MFD_SC27XX_PMIC || COMPILE_TEST
-	help
-	  This driver supports powering off a system through
-	  Spreadtrum SC27xx series PMICs. The SC27xx series
-	  PMICs includes the SC2720, SC2721, SC2723, SC2730
-	  and SC2731 chips.
-
 config NVMEM_REBOOT_MODE
 	tristate "Generic NVMEM reboot mode driver"
 	depends on OF
diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
index 0e4ae6f6b5c55729cf60846d47e6fe0fec24f3cc..14876511c675bd52a99a10890cd685a254f0e030 100644
--- a/drivers/power/reset/Makefile
+++ b/drivers/power/reset/Makefile
@@ -38,6 +38,5 @@ obj-$(CONFIG_POWER_RESET_SYSCON_POWEROFF) += syscon-poweroff.o
 obj-$(CONFIG_POWER_RESET_RMOBILE) += rmobile-reset.o
 obj-$(CONFIG_REBOOT_MODE) += reboot-mode.o
 obj-$(CONFIG_SYSCON_REBOOT_MODE) += syscon-reboot-mode.o
-obj-$(CONFIG_POWER_RESET_SC27XX) += sc27xx-poweroff.o
 obj-$(CONFIG_NVMEM_REBOOT_MODE) += nvmem-reboot-mode.o
 obj-$(CONFIG_POWER_MLXBF) += pwr-mlxbf.o
diff --git a/drivers/power/reset/sc27xx-poweroff.c b/drivers/power/reset/sc27xx-poweroff.c
deleted file mode 100644
index 90287c31992c4889f9241e82a21a1949ecca7702..0000000000000000000000000000000000000000
--- a/drivers/power/reset/sc27xx-poweroff.c
+++ /dev/null
@@ -1,79 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (C) 2018 Spreadtrum Communications Inc.
- * Copyright (C) 2018 Linaro Ltd.
- */
-
-#include <linux/cpu.h>
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/platform_device.h>
-#include <linux/pm.h>
-#include <linux/regmap.h>
-#include <linux/syscore_ops.h>
-
-#define SC27XX_PWR_PD_HW	0xc2c
-#define SC27XX_PWR_OFF_EN	BIT(0)
-#define SC27XX_SLP_CTRL		0xdf0
-#define SC27XX_LDO_XTL_EN	BIT(3)
-
-static struct regmap *regmap;
-
-/*
- * On Spreadtrum platform, we need power off system through external SC27xx
- * series PMICs, and it is one similar SPI bus mapped by regmap to access PMIC,
- * which is not fast io access.
- *
- * So before stopping other cores, we need release other cores' resource by
- * taking cpus down to avoid racing regmap or spi mutex lock when poweroff
- * system through PMIC.
- */
-static void sc27xx_poweroff_shutdown(void)
-{
-#ifdef CONFIG_HOTPLUG_CPU
-	int cpu;
-
-	for_each_online_cpu(cpu) {
-		if (cpu != smp_processor_id())
-			remove_cpu(cpu);
-	}
-#endif
-}
-
-static struct syscore_ops poweroff_syscore_ops = {
-	.shutdown = sc27xx_poweroff_shutdown,
-};
-
-static void sc27xx_poweroff_do_poweroff(void)
-{
-	/* Disable the external subsys connection's power firstly */
-	regmap_write(regmap, SC27XX_SLP_CTRL, SC27XX_LDO_XTL_EN);
-
-	regmap_write(regmap, SC27XX_PWR_PD_HW, SC27XX_PWR_OFF_EN);
-}
-
-static int sc27xx_poweroff_probe(struct platform_device *pdev)
-{
-	if (regmap)
-		return -EINVAL;
-
-	regmap = dev_get_regmap(pdev->dev.parent, NULL);
-	if (!regmap)
-		return -ENODEV;
-
-	pm_power_off = sc27xx_poweroff_do_poweroff;
-	register_syscore_ops(&poweroff_syscore_ops);
-	return 0;
-}
-
-static struct platform_driver sc27xx_poweroff_driver = {
-	.probe = sc27xx_poweroff_probe,
-	.driver = {
-		.name = "sc27xx-poweroff",
-	},
-};
-module_platform_driver(sc27xx_poweroff_driver);
-
-MODULE_DESCRIPTION("Power off driver for SC27XX PMIC Device");
-MODULE_AUTHOR("Baolin Wang <baolin.wang@unisoc.com>");
-MODULE_LICENSE("GPL v2");

-- 
2.50.0


