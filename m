Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 673553F6FEB
	for <lists+linux-spi@lfdr.de>; Wed, 25 Aug 2021 09:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239063AbhHYHAn (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 25 Aug 2021 03:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238620AbhHYHAb (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 25 Aug 2021 03:00:31 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC0BC0613D9;
        Tue, 24 Aug 2021 23:59:46 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id g184so3636999pgc.6;
        Tue, 24 Aug 2021 23:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t+1/92GDKpJBD6nqCDRc028YnKjOTeYzjVSOJICxTvg=;
        b=GpIHjuh1QeiD2TLRypEYsu19pabJL5ZmwD14wWQUJay9e47K7FfIP/jFh9qpljXV55
         qD+6ZVcdwCaNqLZ+Tm9PPuFsFbZPWA92d7u+9gkz2A31dinUAYRrgA5sB/dHZNthx0HG
         se3xwxxEdWeU59ra/lxyv7aCdsZ1VFhnmiSUIQ935/20DLWea8OjZrcJcivxQxvlRwhv
         at7fM4NQ3bXqfJuIjghexR2hqu7sAY4H+2W/WLkzcDpeeItjg9bMLEKOT2s99h+Hf4In
         UNBKklzfdbETnsqn3q/iKyFxNQ3G+tMlx0VZyMj5j5Qv+Vza+ZpbZTJymD2kAa56LuhM
         5DJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t+1/92GDKpJBD6nqCDRc028YnKjOTeYzjVSOJICxTvg=;
        b=CzMjLWdxyeTQTOGn6N9xAQkw5RlTpTOrr1rEt/ngNAT9I+65E6qXJL5x8um7LRLzDA
         HlyLxInOaKZEaGSYF1JOKC6V3YyambvAlK0XMY/58c64GQTec7iujLSftq3sCMFu3vE/
         cqlPf3VlwEhPrP9Vlhtgimo9q2WT2XMp+bXMuUCXKP2IAdlfWBqVMt50lSpUb7bgNI4t
         0Ote3mh8RXOrCq0p4w541zQNeJM+i1hv/DMN1I9TovRT5IndMVwXi/P0KT/megKIXeJo
         yvlXyimV6f70bqth5E9HLa+j5KoO6//YU69+gPUfFAV3B4Zd5LRrZbRq98LdVHKrGJuR
         MEXA==
X-Gm-Message-State: AOAM531Tz6F3TPvf/VCxhV+63orTyaxN2v/wvTrPZCRlW1v1hPhZTbX6
        CYPBOdeBI4IY3P9xyl7xhLI=
X-Google-Smtp-Source: ABdhPJz0AkCDAxUq+6UZ5sYKvW+v+l1/7ZmxI4D7MLLZrYE7ugUS7fRx7n7JOKAVhfEYMZH4/YXh5g==
X-Received: by 2002:a63:e00b:: with SMTP id e11mr41109951pgh.190.1629874785949;
        Tue, 24 Aug 2021 23:59:45 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id q102sm4443109pjq.54.2021.08.24.23.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 23:59:45 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Luting Guo <luting.guo@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH V2 1/3] spi: sprd: Add ADI r3 support
Date:   Wed, 25 Aug 2021 14:59:29 +0800
Message-Id: <20210825065931.2111159-2-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210825065931.2111159-1-zhang.lyra@gmail.com>
References: <20210825065931.2111159-1-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

ADI r3p0 is used on SC9863 and UMS512 SoCs.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
 drivers/spi/spi-sprd-adi.c | 218 ++++++++++++++++++++++++++++---------
 1 file changed, 167 insertions(+), 51 deletions(-)

diff --git a/drivers/spi/spi-sprd-adi.c b/drivers/spi/spi-sprd-adi.c
index 07f11b17bf20..5ec1845d8e5b 100644
--- a/drivers/spi/spi-sprd-adi.c
+++ b/drivers/spi/spi-sprd-adi.c
@@ -52,10 +52,20 @@
 
 /*
  * ADI slave devices include RTC, ADC, regulator, charger, thermal and so on.
- * The slave devices address offset is always 0x8000 and size is 4K.
+ * ADI supports 12/14bit address for r2p0, and additional 17bit for r3p0 or
+ * later versions. Since bit[1:0] are zero, so the spec describe them as
+ * 10/12/15bit address mode.
+ * The 10bit mode supports sigle slave, 12/15bit mode supports 3 slave, the
+ * high two bits is slave_id.
+ * The slave devices address offset is 0x8000 for 10/12bit address mode,
+ * and 0x20000 for 15bit mode.
  */
-#define ADI_SLAVE_ADDR_SIZE		SZ_4K
-#define ADI_SLAVE_OFFSET		0x8000
+#define ADI_10BIT_SLAVE_ADDR_SIZE	SZ_4K
+#define ADI_10BIT_SLAVE_OFFSET		0x8000
+#define ADI_12BIT_SLAVE_ADDR_SIZE	SZ_16K
+#define ADI_12BIT_SLAVE_OFFSET		0x8000
+#define ADI_15BIT_SLAVE_ADDR_SIZE	SZ_128K
+#define ADI_15BIT_SLAVE_OFFSET		0x20000
 
 /* Timeout (ms) for the trylock of hardware spinlocks */
 #define ADI_HWSPINLOCK_TIMEOUT		5000
@@ -67,24 +77,35 @@
 
 #define ADI_FIFO_DRAIN_TIMEOUT		1000
 #define ADI_READ_TIMEOUT		2000
-#define REG_ADDR_LOW_MASK		GENMASK(11, 0)
+
+/*
+ * Read back address from REG_ADI_RD_DATA bit[30:16] which maps to:
+ * REG_ADI_RD_CMD bit[14:0] for r2p0
+ * REG_ADI_RD_CMD bit[16:2] for r3p0
+ */
+#define RDBACK_ADDR_MASK_R2		GENMASK(14, 0)
+#define RDBACK_ADDR_MASK_R3		GENMASK(16, 2)
+#define RDBACK_ADDR_SHIFT_R3		2
 
 /* Registers definitions for PMIC watchdog controller */
-#define REG_WDG_LOAD_LOW		0x80
-#define REG_WDG_LOAD_HIGH		0x84
-#define REG_WDG_CTRL			0x88
-#define REG_WDG_LOCK			0xa0
+#define REG_WDG_LOAD_LOW		0x0
+#define REG_WDG_LOAD_HIGH		0x4
+#define REG_WDG_CTRL			0x8
+#define REG_WDG_LOCK			0x20
 
 /* Bits definitions for register REG_WDG_CTRL */
 #define BIT_WDG_RUN			BIT(1)
 #define BIT_WDG_NEW			BIT(2)
 #define BIT_WDG_RST			BIT(3)
 
+/* Bits definitions for register REG_MODULE_EN */
+#define BIT_WDG_EN			BIT(2)
+
 /* Registers definitions for PMIC */
 #define PMIC_RST_STATUS			0xee8
 #define PMIC_MODULE_EN			0xc08
 #define PMIC_CLK_EN			0xc18
-#define BIT_WDG_EN			BIT(2)
+#define PMIC_WDG_BASE			0x80
 
 /* Definition of PMIC reset status register */
 #define HWRST_STATUS_SECURITY		0x02
@@ -103,10 +124,26 @@
 #define HWRST_STATUS_WATCHDOG		0xf0
 
 /* Use default timeout 50 ms that converts to watchdog values */
-#define WDG_LOAD_VAL			((50 * 1000) / 32768)
+#define WDG_LOAD_VAL			((50 * 32768) / 1000)
 #define WDG_LOAD_MASK			GENMASK(15, 0)
 #define WDG_UNLOCK_KEY			0xe551
 
+struct sprd_adi_wdg {
+	u32 base;
+	u32 rst_sts;
+	u32 wdg_en;
+	u32 wdg_clk;
+};
+
+struct sprd_adi_data {
+	u32 slave_offset;
+	u32 slave_addr_size;
+	int (*read_check)(u32 val, u32 reg);
+	int (*restart)(struct notifier_block *this,
+		       unsigned long mode, void *cmd);
+	void (*wdg_rst)(void *p);
+};
+
 struct sprd_adi {
 	struct spi_controller	*ctlr;
 	struct device		*dev;
@@ -115,11 +152,12 @@ struct sprd_adi {
 	unsigned long		slave_vbase;
 	unsigned long		slave_pbase;
 	struct notifier_block	restart_handler;
+	const struct sprd_adi_data *data;
 };
 
 static int sprd_adi_check_addr(struct sprd_adi *sadi, u32 reg)
 {
-	if (reg >= ADI_SLAVE_ADDR_SIZE) {
+	if (reg >= sadi->data->slave_addr_size) {
 		dev_err(sadi->dev,
 			"slave address offset is incorrect, reg = 0x%x\n",
 			reg);
@@ -155,11 +193,35 @@ static int sprd_adi_fifo_is_full(struct sprd_adi *sadi)
 	return readl_relaxed(sadi->base + REG_ADI_ARM_FIFO_STS) & BIT_FIFO_FULL;
 }
 
+static int sprd_adi_read_check(u32 val, u32 addr)
+{
+	u32 rd_addr;
+
+	rd_addr = (val & RD_ADDR_MASK) >> RD_ADDR_SHIFT;
+
+	if (rd_addr != addr) {
+		pr_err("ADI read error, addr = 0x%x, val = 0x%x\n", addr, val);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int sprd_adi_read_check_r2(u32 val, u32 reg)
+{
+	return sprd_adi_read_check(val, reg & RDBACK_ADDR_MASK_R2);
+}
+
+static int sprd_adi_read_check_r3(u32 val, u32 reg)
+{
+	return sprd_adi_read_check(val, (reg & RDBACK_ADDR_MASK_R3) >> RDBACK_ADDR_SHIFT_R3);
+}
+
 static int sprd_adi_read(struct sprd_adi *sadi, u32 reg, u32 *read_val)
 {
 	int read_timeout = ADI_READ_TIMEOUT;
 	unsigned long flags;
-	u32 val, rd_addr;
+	u32 val;
 	int ret = 0;
 
 	if (sadi->hwlock) {
@@ -203,18 +265,15 @@ static int sprd_adi_read(struct sprd_adi *sadi, u32 reg, u32 *read_val)
 	}
 
 	/*
-	 * The return value includes data and read register address, from bit 0
-	 * to bit 15 are data, and from bit 16 to bit 30 are read register
-	 * address. Then we can check the returned register address to validate
-	 * data.
+	 * The return value before adi r5p0 includes data and read register
+	 * address, from bit 0to bit 15 are data, and from bit 16 to bit 30
+	 * are read register address. Then we can check the returned register
+	 * address to validate data.
 	 */
-	rd_addr = (val & RD_ADDR_MASK) >> RD_ADDR_SHIFT;
-
-	if (rd_addr != (reg & REG_ADDR_LOW_MASK)) {
-		dev_err(sadi->dev, "read error, reg addr = 0x%x, val = 0x%x\n",
-			reg, val);
-		ret = -EIO;
-		goto out;
+	if (sadi->data->read_check) {
+		ret = sadi->data->read_check(val, reg);
+		if (ret < 0)
+			goto out;
 	}
 
 	*read_val = val & RD_VALUE_MASK;
@@ -299,20 +358,22 @@ static int sprd_adi_transfer_one(struct spi_controller *ctlr,
 	return ret;
 }
 
-static void sprd_adi_set_wdt_rst_mode(struct sprd_adi *sadi)
+static void sprd_adi_set_wdt_rst_mode(void *p)
 {
 #if IS_ENABLED(CONFIG_SPRD_WATCHDOG)
 	u32 val;
+	struct sprd_adi *sadi = (struct sprd_adi *)p;
 
-	/* Set default watchdog reboot mode */
+
+	/* Init watchdog reset mode */
 	sprd_adi_read(sadi, PMIC_RST_STATUS, &val);
 	val |= HWRST_STATUS_WATCHDOG;
 	sprd_adi_write(sadi, PMIC_RST_STATUS, val);
 #endif
 }
 
-static int sprd_adi_restart_handler(struct notifier_block *this,
-				    unsigned long mode, void *cmd)
+static int sprd_adi_restart(struct notifier_block *this, unsigned long mode,
+				  void *cmd, struct sprd_adi_wdg *wdg)
 {
 	struct sprd_adi *sadi = container_of(this, struct sprd_adi,
 					     restart_handler);
@@ -348,40 +409,40 @@ static int sprd_adi_restart_handler(struct notifier_block *this,
 		reboot_mode = HWRST_STATUS_NORMAL;
 
 	/* Record the reboot mode */
-	sprd_adi_read(sadi, PMIC_RST_STATUS, &val);
+	sprd_adi_read(sadi, wdg->rst_sts, &val);
 	val &= ~HWRST_STATUS_WATCHDOG;
 	val |= reboot_mode;
-	sprd_adi_write(sadi, PMIC_RST_STATUS, val);
+	sprd_adi_write(sadi, wdg->rst_sts, val);
 
 	/* Enable the interface clock of the watchdog */
-	sprd_adi_read(sadi, PMIC_MODULE_EN, &val);
+	sprd_adi_read(sadi, wdg->wdg_en, &val);
 	val |= BIT_WDG_EN;
-	sprd_adi_write(sadi, PMIC_MODULE_EN, val);
+	sprd_adi_write(sadi, wdg->wdg_en, val);
 
 	/* Enable the work clock of the watchdog */
-	sprd_adi_read(sadi, PMIC_CLK_EN, &val);
+	sprd_adi_read(sadi, wdg->wdg_clk, &val);
 	val |= BIT_WDG_EN;
-	sprd_adi_write(sadi, PMIC_CLK_EN, val);
+	sprd_adi_write(sadi, wdg->wdg_clk, val);
 
 	/* Unlock the watchdog */
-	sprd_adi_write(sadi, REG_WDG_LOCK, WDG_UNLOCK_KEY);
+	sprd_adi_write(sadi, wdg->base + REG_WDG_LOCK, WDG_UNLOCK_KEY);
 
-	sprd_adi_read(sadi, REG_WDG_CTRL, &val);
+	sprd_adi_read(sadi, wdg->base + REG_WDG_CTRL, &val);
 	val |= BIT_WDG_NEW;
-	sprd_adi_write(sadi, REG_WDG_CTRL, val);
+	sprd_adi_write(sadi, wdg->base + REG_WDG_CTRL, val);
 
 	/* Load the watchdog timeout value, 50ms is always enough. */
-	sprd_adi_write(sadi, REG_WDG_LOAD_HIGH, 0);
-	sprd_adi_write(sadi, REG_WDG_LOAD_LOW,
+	sprd_adi_write(sadi, wdg->base + REG_WDG_LOAD_HIGH, 0);
+	sprd_adi_write(sadi, wdg->base + REG_WDG_LOAD_LOW,
 		       WDG_LOAD_VAL & WDG_LOAD_MASK);
 
 	/* Start the watchdog to reset system */
-	sprd_adi_read(sadi, REG_WDG_CTRL, &val);
+	sprd_adi_read(sadi, wdg->base + REG_WDG_CTRL, &val);
 	val |= BIT_WDG_RUN | BIT_WDG_RST;
-	sprd_adi_write(sadi, REG_WDG_CTRL, val);
+	sprd_adi_write(sadi, wdg->base + REG_WDG_CTRL, val);
 
 	/* Lock the watchdog */
-	sprd_adi_write(sadi, REG_WDG_LOCK, ~WDG_UNLOCK_KEY);
+	sprd_adi_write(sadi, wdg->base + REG_WDG_LOCK, ~WDG_UNLOCK_KEY);
 
 	mdelay(1000);
 
@@ -389,6 +450,19 @@ static int sprd_adi_restart_handler(struct notifier_block *this,
 	return NOTIFY_DONE;
 }
 
+static int sprd_adi_restart_sc9860(struct notifier_block *this,
+					   unsigned long mode, void *cmd)
+{
+	struct sprd_adi_wdg wdg = {
+		.base = PMIC_WDG_BASE,
+		.rst_sts = PMIC_RST_STATUS,
+		.wdg_en = PMIC_MODULE_EN,
+		.wdg_clk = PMIC_CLK_EN,
+	};
+
+	return sprd_adi_restart(this, mode, cmd, &wdg);
+}
+
 static void sprd_adi_hw_init(struct sprd_adi *sadi)
 {
 	struct device_node *np = sadi->dev->of_node;
@@ -440,10 +514,11 @@ static void sprd_adi_hw_init(struct sprd_adi *sadi)
 static int sprd_adi_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
+	const struct sprd_adi_data *data;
 	struct spi_controller *ctlr;
 	struct sprd_adi *sadi;
 	struct resource *res;
-	u32 num_chipselect;
+	u16 num_chipselect;
 	int ret;
 
 	if (!np) {
@@ -451,6 +526,12 @@ static int sprd_adi_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
+	data = of_device_get_match_data(&pdev->dev);
+	if (!data) {
+		dev_err(&pdev->dev, "no matching driver data found\n");
+		return -EINVAL;
+	}
+
 	pdev->id = of_alias_get_id(np, "spi");
 	num_chipselect = of_get_child_count(np);
 
@@ -468,10 +549,12 @@ static int sprd_adi_probe(struct platform_device *pdev)
 		goto put_ctlr;
 	}
 
-	sadi->slave_vbase = (unsigned long)sadi->base + ADI_SLAVE_OFFSET;
-	sadi->slave_pbase = res->start + ADI_SLAVE_OFFSET;
+	sadi->slave_vbase = (unsigned long)sadi->base +
+			    data->slave_offset;
+	sadi->slave_pbase = res->start + data->slave_offset;
 	sadi->ctlr = ctlr;
 	sadi->dev = &pdev->dev;
+	sadi->data = data;
 	ret = of_hwspin_lock_get_id(np, 0);
 	if (ret > 0 || (IS_ENABLED(CONFIG_HWSPINLOCK) && ret == 0)) {
 		sadi->hwlock =
@@ -492,7 +575,9 @@ static int sprd_adi_probe(struct platform_device *pdev)
 	}
 
 	sprd_adi_hw_init(sadi);
-	sprd_adi_set_wdt_rst_mode(sadi);
+
+	if (sadi->data->wdg_rst)
+		sadi->data->wdg_rst(sadi);
 
 	ctlr->dev.of_node = pdev->dev.of_node;
 	ctlr->bus_num = pdev->id;
@@ -507,12 +592,14 @@ static int sprd_adi_probe(struct platform_device *pdev)
 		goto put_ctlr;
 	}
 
-	sadi->restart_handler.notifier_call = sprd_adi_restart_handler;
-	sadi->restart_handler.priority = 128;
-	ret = register_restart_handler(&sadi->restart_handler);
-	if (ret) {
-		dev_err(&pdev->dev, "can not register restart handler\n");
-		goto put_ctlr;
+	if (sadi->data->restart) {
+		sadi->restart_handler.notifier_call = sadi->data->restart;
+		sadi->restart_handler.priority = 128;
+		ret = register_restart_handler(&sadi->restart_handler);
+		if (ret) {
+			dev_err(&pdev->dev, "can not register restart handler\n");
+			goto put_ctlr;
+		}
 	}
 
 	return 0;
@@ -531,9 +618,38 @@ static int sprd_adi_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static struct sprd_adi_data sc9860_data = {
+	.slave_offset = ADI_10BIT_SLAVE_OFFSET,
+	.slave_addr_size = ADI_10BIT_SLAVE_ADDR_SIZE,
+	.read_check = sprd_adi_read_check_r2,
+	.restart = sprd_adi_restart_sc9860,
+	.wdg_rst = sprd_adi_set_wdt_rst_mode,
+};
+
+static struct sprd_adi_data sc9863_data = {
+	.slave_offset = ADI_12BIT_SLAVE_OFFSET,
+	.slave_addr_size = ADI_12BIT_SLAVE_ADDR_SIZE,
+	.read_check = sprd_adi_read_check_r3,
+};
+
+static struct sprd_adi_data ums512_data = {
+	.slave_offset = ADI_15BIT_SLAVE_OFFSET,
+	.slave_addr_size = ADI_15BIT_SLAVE_ADDR_SIZE,
+	.read_check = sprd_adi_read_check_r3,
+};
+
 static const struct of_device_id sprd_adi_of_match[] = {
 	{
 		.compatible = "sprd,sc9860-adi",
+		.data = &sc9860_data,
+	},
+	{
+		.compatible = "sprd,sc9863-adi",
+		.data = &sc9863_data,
+	},
+	{
+		.compatible = "sprd,ums512-adi",
+		.data = &ums512_data,
 	},
 	{ },
 };
-- 
2.25.1

