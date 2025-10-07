Return-Path: <linux-spi+bounces-10451-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DFE1BC25E0
	for <lists+linux-spi@lfdr.de>; Tue, 07 Oct 2025 20:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 00FBB4EB879
	for <lists+linux-spi@lfdr.de>; Tue,  7 Oct 2025 18:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 032812E8E09;
	Tue,  7 Oct 2025 18:20:52 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from srv01.abscue.de (abscue.de [89.58.28.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6912206A7;
	Tue,  7 Oct 2025 18:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.28.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759861251; cv=none; b=CC2bYpPMvE94vPg4zOycJolqnBm0eQsiuwXDXkpj8lwPryWvrroHAqSkLiqRM9qh2loeweWG2TsnzYEbcYROwA5ZbwD0VharXrWOh5LiQBwT1haY1b6uewts3si51GHyX27FZvhUgyz6zKDZut7NovP2abSsEViK8BqZysspL5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759861251; c=relaxed/simple;
	bh=8/b7jwWBDbOGO7fjgsRdi05ElyTw54npNSsGTIgmHMk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FVuJc+RUDCZMDVImeF8T9t59EcJ8Li9DwIQJ9D5GL0kcFNj57UG4MQAZoAlbQ5GVEk7Y6IadAx50NIKrL4GR0rOzgDb6WTioyp4QeCEe62IXqO3qkl+RF0raxguYkVnoYj95ftoUunbXTFyhpG1wIoS9R4qKThlrJhXSq2bI4pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=abscue.de; spf=pass smtp.mailfrom=abscue.de; arc=none smtp.client-ip=89.58.28.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=abscue.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=abscue.de
Received: from srv01.abscue.de (localhost [127.0.0.1])
	by spamfilter.srv.local (Postfix) with ESMTP id DE8A01C3AC5;
	Tue, 07 Oct 2025 20:15:21 +0200 (CEST)
X-Spam-Level: 
Received: from fluffy-mammal.metal.fwg-cag.de (unknown [IPv6:2001:9e8:cdfe:cd00:889e:d706:979d:b1a])
	by srv01.abscue.de (Postfix) with ESMTPSA id CA4E61C40C9;
	Tue, 07 Oct 2025 20:15:18 +0200 (CEST)
From: =?utf-8?q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>
Date: Tue, 07 Oct 2025 20:14:21 +0200
Subject: [PATCH 3/3] power: reset: sc27xx: Drop unused driver
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251007-sc27xx-mfd-poweroff-v1-3-89a2f919b731@abscue.de>
References: <20251007-sc27xx-mfd-poweroff-v1-0-89a2f919b731@abscue.de>
In-Reply-To: <20251007-sc27xx-mfd-poweroff-v1-0-89a2f919b731@abscue.de>
To: Lee Jones <lee@kernel.org>, Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>
Cc: Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-spi@vger.kernel.org, linux-pm@vger.kernel.org, 
 =?utf-8?q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>
X-Mailer: b4 0.14.2

This driver was never actually probed because it was missing an OF match
table and was not integrated into the MFD driver. Remove it now that the
power off functionality is handled directly in the MFD driver.

Signed-off-by: Otto Pflüger <otto.pflueger@abscue.de>
---
 drivers/power/reset/Kconfig           |  9 ----
 drivers/power/reset/Makefile          |  1 -
 drivers/power/reset/sc27xx-poweroff.c | 79 -----------------------------------
 3 files changed, 89 deletions(-)

diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index 8248895ca90389c1db33c7b09e5f5925a9034cee..c4a28f6f04f6be13d20ce2b08427fd1679b1df5a 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -320,15 +320,6 @@ config SYSCON_REBOOT_MODE
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
index 51da87e05ce76bc608d961485063555c3ba5d96c..cabaa0de2de68794bea5f9523855bb9ef0083ef0 100644
--- a/drivers/power/reset/Makefile
+++ b/drivers/power/reset/Makefile
@@ -37,6 +37,5 @@ obj-$(CONFIG_POWER_RESET_SYSCON_POWEROFF) += syscon-poweroff.o
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


