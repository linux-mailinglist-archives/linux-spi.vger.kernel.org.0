Return-Path: <linux-spi+bounces-10450-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1025DBC25DD
	for <lists+linux-spi@lfdr.de>; Tue, 07 Oct 2025 20:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDCFA3B8F4C
	for <lists+linux-spi@lfdr.de>; Tue,  7 Oct 2025 18:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8262DFA2F;
	Tue,  7 Oct 2025 18:20:51 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from srv01.abscue.de (abscue.de [89.58.28.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5C321859A;
	Tue,  7 Oct 2025 18:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.28.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759861251; cv=none; b=jcrqMEBdeFp5Y2zo49JXaOlF+8wam5GXXgBY2NeG5/lwUDmE4LkE9XkkQAu9XREZm6sHFtOmCRcU9iScEz4YYs3iCwF5PxG1UkxC5K94RXGoKxTqkdmKjde9lMb9OaYg+oqyEhlB7uHQ/8YUd/ElDGi34ua8ISucCN6BEV2pUoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759861251; c=relaxed/simple;
	bh=PDVGCyOxhSCPu4V5/+2P720vq13mPR+UE3R0ZxJcAEs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fWqJ4Cw/QkjNq+plsULjH73JWzzEQRB6f9jIakWW/Ypun5+WNkXRiASMiKsSBGtYccOjsYICR080wc3vGYzzDcVKRUpqfXRoB0EFUDRXJKbOFkfSqXV8ccja8Dhgp/fZ1Sd1LikdS16E1rt7fXqJXgFy3d2j3RBf16yBAsyDuDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=abscue.de; spf=pass smtp.mailfrom=abscue.de; arc=none smtp.client-ip=89.58.28.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=abscue.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=abscue.de
Received: from srv01.abscue.de (localhost [127.0.0.1])
	by spamfilter.srv.local (Postfix) with ESMTP id 9963C1C3BB4;
	Tue, 07 Oct 2025 20:15:18 +0200 (CEST)
X-Spam-Level: 
Received: from fluffy-mammal.metal.fwg-cag.de (unknown [IPv6:2001:9e8:cdfe:cd00:889e:d706:979d:b1a])
	by srv01.abscue.de (Postfix) with ESMTPSA id E43691C3B04;
	Tue, 07 Oct 2025 20:15:17 +0200 (CEST)
From: =?utf-8?q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>
Date: Tue, 07 Oct 2025 20:14:19 +0200
Subject: [PATCH 1/3] mfd: sprd-sc27xx: Integrate power off and reboot
 support
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251007-sc27xx-mfd-poweroff-v1-1-89a2f919b731@abscue.de>
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

The SC27xx PMICs allow restarting and powering off the device. Since
this functionality is rather simple and not configurable in any way,
make it part of the main PMIC driver.

Signed-off-by: Otto Pflüger <otto.pflueger@abscue.de>
---
 drivers/mfd/sprd-sc27xx-spi.c | 152 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 152 insertions(+)

diff --git a/drivers/mfd/sprd-sc27xx-spi.c b/drivers/mfd/sprd-sc27xx-spi.c
index d6b4350779e6aecfa19d9fa21b9174447d589e33..28dc82002e3c8eb7748c45f9f1bdadea4feb8206 100644
--- a/drivers/mfd/sprd-sc27xx-spi.c
+++ b/drivers/mfd/sprd-sc27xx-spi.c
@@ -10,6 +10,7 @@
 #include <linux/mfd/sc27xx-pmic.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
+#include <linux/reboot.h>
 #include <linux/regmap.h>
 #include <linux/spi/spi.h>
 #include <uapi/linux/usb/charger.h>
@@ -21,10 +22,48 @@
 #define SPRD_SC2730_IRQ_BASE		0x80
 #define SPRD_SC2730_IRQ_NUMS		10
 #define SPRD_SC2730_CHG_DET		0x1b9c
+
+#define SPRD_SC2730_PWR_PD_HW		0x1820
+#define SPRD_SC2730_SOFT_RST_HW		0x1824
+#define SPRD_SC2730_SLP_CTRL		0x1a48
+#define SPRD_SC2730_RST_STATUS		0x1bac
+#define SPRD_SC2730_SWRST_CTRL0		0x1bf8
+
 #define SPRD_SC2731_IRQ_BASE		0x140
 #define SPRD_SC2731_IRQ_NUMS		16
 #define SPRD_SC2731_CHG_DET		0xedc
 
+#define SPRD_SC2731_PWR_PD_HW		0xc2c
+#define SPRD_SC2731_SLP_CTRL		0xdf0
+#define SPRD_SC2731_RST_STATUS		0xee8
+
+/* PMIC power off and reset definition */
+#define SPRD_SC2730_LDO_XTL_EN		BIT(2)
+#define SPRD_SC2730_SLP_LDO_PD_EN	BIT(0)
+
+#define SPRD_SC2731_LDO_XTL_EN		BIT(3)
+#define SPRD_SC2731_SLP_LDO_PD_EN	BIT(0)
+
+#define SPRD_PMIC_PWR_OFF		BIT(0)
+#define SPRD_PMIC_RESET			BIT(0)
+#define SPRD_PMIC_SOFT_RST_EN		BIT(4)
+
+#define HWRST_STATUS_SECURITY		0x02
+#define HWRST_STATUS_RECOVERY		0x20
+#define HWRST_STATUS_NORMAL		0x40
+#define HWRST_STATUS_ALARM		0x50
+#define HWRST_STATUS_SLEEP		0x60
+#define HWRST_STATUS_FASTBOOT		0x30
+#define HWRST_STATUS_SPECIAL		0x70
+#define HWRST_STATUS_PANIC		0x80
+#define HWRST_STATUS_CFTREBOOT		0x90
+#define HWRST_STATUS_AUTODLOADER	0xa0
+#define HWRST_STATUS_IQMODE		0xb0
+#define HWRST_STATUS_SPRDISK		0xc0
+#define HWRST_STATUS_FACTORYTEST	0xe0
+#define HWRST_STATUS_WATCHDOG		0xf0
+#define HWRST_STATUS_MASK		0xff
+
 /* PMIC charger detection definition */
 #define SPRD_PMIC_CHG_DET_DELAY_US	200000
 #define SPRD_PMIC_CHG_DET_TIMEOUT	2000000
@@ -48,6 +87,14 @@ struct sprd_pmic_data {
 	u32 irq_base;
 	u32 num_irqs;
 	u32 charger_det;
+
+	u32 poweroff_reg;
+	u32 slp_ctrl_reg;
+	u32 slp_ctrl_mask;
+
+	u32 reset_reg;
+	u32 rst_sts_reg;
+	u32 swrst_ctrl_reg;
 };
 
 /*
@@ -59,12 +106,26 @@ static const struct sprd_pmic_data sc2730_data = {
 	.irq_base = SPRD_SC2730_IRQ_BASE,
 	.num_irqs = SPRD_SC2730_IRQ_NUMS,
 	.charger_det = SPRD_SC2730_CHG_DET,
+
+	.poweroff_reg = SPRD_SC2730_PWR_PD_HW,
+	.slp_ctrl_reg = SPRD_SC2730_SLP_CTRL,
+	.slp_ctrl_mask = SPRD_SC2730_LDO_XTL_EN | SPRD_SC2730_SLP_LDO_PD_EN,
+
+	.reset_reg = SPRD_SC2730_SOFT_RST_HW,
+	.rst_sts_reg = SPRD_SC2730_RST_STATUS,
+	.swrst_ctrl_reg = SPRD_SC2730_SWRST_CTRL0,
 };
 
 static const struct sprd_pmic_data sc2731_data = {
 	.irq_base = SPRD_SC2731_IRQ_BASE,
 	.num_irqs = SPRD_SC2731_IRQ_NUMS,
 	.charger_det = SPRD_SC2731_CHG_DET,
+
+	.poweroff_reg = SPRD_SC2731_PWR_PD_HW,
+	.slp_ctrl_reg = SPRD_SC2731_SLP_CTRL,
+	.slp_ctrl_mask = SPRD_SC2731_LDO_XTL_EN | SPRD_SC2731_SLP_LDO_PD_EN,
+
+	.rst_sts_reg = SPRD_SC2731_RST_STATUS,
 };
 
 enum usb_charger_type sprd_pmic_detect_charger_type(struct device *dev)
@@ -149,6 +210,79 @@ static const struct regmap_config sprd_pmic_config = {
 	.max_register = 0xffff,
 };
 
+static int sprd_pmic_poweroff(struct sys_off_data *off_data)
+{
+	struct sprd_pmic *ddata = off_data->cb_data;
+	const struct sprd_pmic_data *pdata = ddata->pdata;
+
+	regmap_clear_bits(ddata->regmap, pdata->slp_ctrl_reg,
+			  pdata->slp_ctrl_mask);
+
+	regmap_write(ddata->regmap, pdata->poweroff_reg, SPRD_PMIC_PWR_OFF);
+
+	mdelay(1000);
+
+	pr_emerg("Unable to poweroff system\n");
+
+	return NOTIFY_DONE;
+}
+
+static int sprd_pmic_restart(struct sys_off_data *off_data)
+{
+	struct sprd_pmic *ddata = off_data->cb_data;
+	const struct sprd_pmic_data *pdata = ddata->pdata;
+	u32 reboot_mode;
+
+	if (!off_data->cmd)
+		reboot_mode = HWRST_STATUS_NORMAL;
+	else if (!strcmp(off_data->cmd, "recovery"))
+		reboot_mode = HWRST_STATUS_RECOVERY;
+	else if (!strcmp(off_data->cmd, "alarm"))
+		reboot_mode = HWRST_STATUS_ALARM;
+	else if (!strcmp(off_data->cmd, "fastsleep"))
+		reboot_mode = HWRST_STATUS_SLEEP;
+	else if (!strcmp(off_data->cmd, "bootloader"))
+		reboot_mode = HWRST_STATUS_FASTBOOT;
+	else if (!strcmp(off_data->cmd, "panic"))
+		reboot_mode = HWRST_STATUS_PANIC;
+	else if (!strcmp(off_data->cmd, "special"))
+		reboot_mode = HWRST_STATUS_SPECIAL;
+	else if (!strcmp(off_data->cmd, "cftreboot"))
+		reboot_mode = HWRST_STATUS_CFTREBOOT;
+	else if (!strcmp(off_data->cmd, "autodloader"))
+		reboot_mode = HWRST_STATUS_AUTODLOADER;
+	else if (!strcmp(off_data->cmd, "iqmode"))
+		reboot_mode = HWRST_STATUS_IQMODE;
+	else if (!strcmp(off_data->cmd, "sprdisk"))
+		reboot_mode = HWRST_STATUS_SPRDISK;
+	else if (!strcmp(off_data->cmd, "tospanic"))
+		reboot_mode = HWRST_STATUS_SECURITY;
+	else if (!strcmp(off_data->cmd, "factorytest"))
+		reboot_mode = HWRST_STATUS_FACTORYTEST;
+	else
+		reboot_mode = HWRST_STATUS_NORMAL;
+
+	regmap_update_bits(ddata->regmap, pdata->rst_sts_reg,
+			   HWRST_STATUS_MASK, reboot_mode);
+
+	/*
+	 * On SC2731, this part is skipped because there is no reset register
+	 * and the restart must be performed using the watchdog.
+	 */
+	if (pdata->reset_reg) {
+		regmap_set_bits(ddata->regmap, pdata->swrst_ctrl_reg,
+				SPRD_PMIC_SOFT_RST_EN);
+
+		regmap_write(ddata->regmap, pdata->reset_reg, SPRD_PMIC_RESET);
+
+		mdelay(1000);
+
+		pr_emerg("Unable to restart system\n");
+	}
+
+	return NOTIFY_DONE;
+}
+
 static int sprd_pmic_probe(struct spi_device *spi)
 {
 	struct sprd_pmic *ddata;
@@ -204,6 +338,24 @@ static int sprd_pmic_probe(struct spi_device *spi)
 		return ret;
 	}
 
+	ret = devm_register_sys_off_handler(&spi->dev, SYS_OFF_MODE_RESTART,
+					    192, sprd_pmic_restart, ddata);
+	if (ret) {
+		dev_err(&spi->dev, "Failed to register restart handler: %d\n",
+			ret);
+		return ret;
+	}
+
+	ret = devm_register_sys_off_handler(&spi->dev,
+					    SYS_OFF_MODE_POWER_OFF,
+					    SYS_OFF_PRIO_DEFAULT,
+					    sprd_pmic_poweroff, ddata);
+	if (ret) {
+		dev_err(&spi->dev, "Failed to register poweroff handler: %d\n",
+			ret);
+		return ret;
+	}
+
 	ret = devm_of_platform_populate(&spi->dev);
 	if (ret) {
 		dev_err(&spi->dev, "Failed to populate sub-devices %d\n", ret);

-- 
2.50.0


