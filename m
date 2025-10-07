Return-Path: <linux-spi+bounces-10452-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 579F0BC25F5
	for <lists+linux-spi@lfdr.de>; Tue, 07 Oct 2025 20:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BD0414F7453
	for <lists+linux-spi@lfdr.de>; Tue,  7 Oct 2025 18:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B80B221F12;
	Tue,  7 Oct 2025 18:20:56 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from srv01.abscue.de (abscue.de [89.58.28.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E63321D3E8;
	Tue,  7 Oct 2025 18:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.28.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759861256; cv=none; b=GdYXipFesO5Wupd8mBmZQ6UgllIx/qYnnREvE6Z1/Dxem3wbusKElL5wpZ8OkAZTVG4Lt2SaFfJXB7m+pZE5s2Mmg77youxT6OsKdQ9k32WnDinayx1mIlgmG0WsrA1RkTC/FAJFtt1PV/Db/BX50eENrJxlbOjkv8/NFZ3paiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759861256; c=relaxed/simple;
	bh=ncPpQZbFWw8NMSWBPoo/kgtWe5usLDXcsXQuGtximK4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bpil9E2wOYpUvGrlyNVG/b+WdMFmJ3CtkkF2WKDJQiTc9+7nSZ4QfDDyuLECFNLLJjdPTDQ+Pb2j7VgzT2XHuvWTzQMVd33UeOieJJqKxutz0fo7TSSCZ7tJFnBW2vqHT3EzahCaVvY+LNUS2/ajDnBCBlmMsq2/O2NbzRWNWu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=abscue.de; spf=pass smtp.mailfrom=abscue.de; arc=none smtp.client-ip=89.58.28.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=abscue.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=abscue.de
Received: from srv01.abscue.de (localhost [127.0.0.1])
	by spamfilter.srv.local (Postfix) with ESMTP id 02DAB1C40CA;
	Tue, 07 Oct 2025 20:15:18 +0200 (CEST)
X-Spam-Level: 
Received: from fluffy-mammal.metal.fwg-cag.de (unknown [IPv6:2001:9e8:cdfe:cd00:889e:d706:979d:b1a])
	by srv01.abscue.de (Postfix) with ESMTPSA id 5DF991C3B06;
	Tue, 07 Oct 2025 20:15:18 +0200 (CEST)
From: =?utf-8?q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>
Date: Tue, 07 Oct 2025 20:14:20 +0200
Subject: [PATCH 2/3] spi: sprd-adi: Remove code for storing the reboot mode
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251007-sc27xx-mfd-poweroff-v1-2-89a2f919b731@abscue.de>
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

This functionality is now provided by the PMIC driver. Ideally, the
entire reboot code should be removed since it does not belong in the bus
driver, but it is kept for now since there is no driver for the PMIC
watchdog on SC2731 yet.

Signed-off-by: Otto Pflüger <otto.pflueger@abscue.de>
---
 drivers/spi/spi-sprd-adi.c | 73 +---------------------------------------------
 1 file changed, 1 insertion(+), 72 deletions(-)

diff --git a/drivers/spi/spi-sprd-adi.c b/drivers/spi/spi-sprd-adi.c
index 262c11d977ea350c3b8a861064d9f109cc57a45e..47e6fbbf9991dbe77ad22e03c9709e6ee3a1b01e 100644
--- a/drivers/spi/spi-sprd-adi.c
+++ b/drivers/spi/spi-sprd-adi.c
@@ -101,27 +101,10 @@
 #define BIT_WDG_EN			BIT(2)
 
 /* Registers definitions for PMIC */
-#define PMIC_RST_STATUS			0xee8
 #define PMIC_MODULE_EN			0xc08
 #define PMIC_CLK_EN			0xc18
 #define PMIC_WDG_BASE			0x80
 
-/* Definition of PMIC reset status register */
-#define HWRST_STATUS_SECURITY		0x02
-#define HWRST_STATUS_RECOVERY		0x20
-#define HWRST_STATUS_NORMAL		0x40
-#define HWRST_STATUS_ALARM		0x50
-#define HWRST_STATUS_SLEEP		0x60
-#define HWRST_STATUS_FASTBOOT		0x30
-#define HWRST_STATUS_SPECIAL		0x70
-#define HWRST_STATUS_PANIC		0x80
-#define HWRST_STATUS_CFTREBOOT		0x90
-#define HWRST_STATUS_AUTODLOADER	0xa0
-#define HWRST_STATUS_IQMODE		0xb0
-#define HWRST_STATUS_SPRDISK		0xc0
-#define HWRST_STATUS_FACTORYTEST	0xe0
-#define HWRST_STATUS_WATCHDOG		0xf0
-
 /* Use default timeout 50 ms that converts to watchdog values */
 #define WDG_LOAD_VAL			((50 * 32768) / 1000)
 #define WDG_LOAD_MASK			GENMASK(15, 0)
@@ -139,7 +122,6 @@ struct sprd_adi_data {
 	u32 slave_addr_size;
 	int (*read_check)(u32 val, u32 reg);
 	int (*restart)(struct sys_off_data *data);
-	void (*wdg_rst)(void *p);
 };
 
 struct sprd_adi {
@@ -355,58 +337,10 @@ static int sprd_adi_transfer_one(struct spi_controller *ctlr,
 	return ret;
 }
 
-static void sprd_adi_set_wdt_rst_mode(void *p)
-{
-#if IS_ENABLED(CONFIG_SPRD_WATCHDOG)
-	u32 val;
-	struct sprd_adi *sadi = (struct sprd_adi *)p;
-
-	/* Init watchdog reset mode */
-	sprd_adi_read(sadi, PMIC_RST_STATUS, &val);
-	val |= HWRST_STATUS_WATCHDOG;
-	sprd_adi_write(sadi, PMIC_RST_STATUS, val);
-#endif
-}
-
 static int sprd_adi_restart(struct sprd_adi *sadi, unsigned long mode,
 			    const char *cmd, struct sprd_adi_wdg *wdg)
 {
-	u32 val, reboot_mode = 0;
-
-	if (!cmd)
-		reboot_mode = HWRST_STATUS_NORMAL;
-	else if (!strncmp(cmd, "recovery", 8))
-		reboot_mode = HWRST_STATUS_RECOVERY;
-	else if (!strncmp(cmd, "alarm", 5))
-		reboot_mode = HWRST_STATUS_ALARM;
-	else if (!strncmp(cmd, "fastsleep", 9))
-		reboot_mode = HWRST_STATUS_SLEEP;
-	else if (!strncmp(cmd, "bootloader", 10))
-		reboot_mode = HWRST_STATUS_FASTBOOT;
-	else if (!strncmp(cmd, "panic", 5))
-		reboot_mode = HWRST_STATUS_PANIC;
-	else if (!strncmp(cmd, "special", 7))
-		reboot_mode = HWRST_STATUS_SPECIAL;
-	else if (!strncmp(cmd, "cftreboot", 9))
-		reboot_mode = HWRST_STATUS_CFTREBOOT;
-	else if (!strncmp(cmd, "autodloader", 11))
-		reboot_mode = HWRST_STATUS_AUTODLOADER;
-	else if (!strncmp(cmd, "iqmode", 6))
-		reboot_mode = HWRST_STATUS_IQMODE;
-	else if (!strncmp(cmd, "sprdisk", 7))
-		reboot_mode = HWRST_STATUS_SPRDISK;
-	else if (!strncmp(cmd, "tospanic", 8))
-		reboot_mode = HWRST_STATUS_SECURITY;
-	else if (!strncmp(cmd, "factorytest", 11))
-		reboot_mode = HWRST_STATUS_FACTORYTEST;
-	else
-		reboot_mode = HWRST_STATUS_NORMAL;
-
-	/* Record the reboot mode */
-	sprd_adi_read(sadi, wdg->rst_sts, &val);
-	val &= ~HWRST_STATUS_WATCHDOG;
-	val |= reboot_mode;
-	sprd_adi_write(sadi, wdg->rst_sts, val);
+	u32 val;
 
 	/* Enable the interface clock of the watchdog */
 	sprd_adi_read(sadi, wdg->wdg_en, &val);
@@ -448,7 +382,6 @@ static int sprd_adi_restart_sc9860(struct sys_off_data *data)
 {
 	struct sprd_adi_wdg wdg = {
 		.base = PMIC_WDG_BASE,
-		.rst_sts = PMIC_RST_STATUS,
 		.wdg_en = PMIC_MODULE_EN,
 		.wdg_clk = PMIC_CLK_EN,
 	};
@@ -568,9 +501,6 @@ static int sprd_adi_probe(struct platform_device *pdev)
 
 	sprd_adi_hw_init(sadi);
 
-	if (sadi->data->wdg_rst)
-		sadi->data->wdg_rst(sadi);
-
 	ctlr->dev.of_node = pdev->dev.of_node;
 	ctlr->bus_num = pdev->id;
 	ctlr->num_chipselect = num_chipselect;
@@ -606,7 +536,6 @@ static struct sprd_adi_data sc9860_data = {
 	.slave_addr_size = ADI_10BIT_SLAVE_ADDR_SIZE,
 	.read_check = sprd_adi_read_check_r2,
 	.restart = sprd_adi_restart_sc9860,
-	.wdg_rst = sprd_adi_set_wdt_rst_mode,
 };
 
 static struct sprd_adi_data sc9863_data = {

-- 
2.50.0


