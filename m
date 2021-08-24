Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26C6C3F58A0
	for <lists+linux-spi@lfdr.de>; Tue, 24 Aug 2021 09:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbhHXHDG (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 24 Aug 2021 03:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231332AbhHXHDG (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 24 Aug 2021 03:03:06 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92EE5C061575;
        Tue, 24 Aug 2021 00:02:22 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id n12so237317plk.10;
        Tue, 24 Aug 2021 00:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0TshSGoZRkdJp806oI7mCmz4O2DIOv+2W+79PoduCNA=;
        b=sXHUhklvqPLVsCc4CKRzsHjdDt76ZShlNR45Krlo3j8cDrU1FQTn0WHmEdyjvRQifh
         fDIPGmxg9UNELHJiuZjMG+2p9Ajq6HJ3ZHYDsPxrnlwn/7FgkU+oU8JSMxzPUtt+YlgJ
         lfJk/845kZ+dW4UXPPcaYN5rLnAJUkQx7AyymGD/mFkq91BsVt/5EjQXjR5W+NQLcNo2
         gdPa0r2ice6CGRdP9IBaUPJfRhcxe1ZmeYk+ynqA3WrgWWRLaDzzlDWTauSN31CcpujV
         9miBpWSe4ECMvRmpBzzyDSuqgWldqej8mWJcu60zPWDfATM23ZCIfzXiHoz+9vOn0n17
         Jmkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0TshSGoZRkdJp806oI7mCmz4O2DIOv+2W+79PoduCNA=;
        b=HmdNwo+aDkTAthvhcv/hUdCjKbRMNdxsjqIsNUIh36dF6MOzoSQHIhBLgnTs2Mi4cS
         iWm2dJsO5a/rCI9NPIBJ0nNhAJZfwvN6jY8txlq34vzdZh4L21qdBQ8t6Y9qZRRQ+U92
         WdN86gBrZbwyysAnv9T+P1DERdGnJM1r5k4hwj2u8n6p1aQBxI3EhvUQ8eeeun5vF6TH
         FI/JUXYmqCv3HjjY9HirnSxJSj5QTZeVkfhjIJL8zYqF1cIh0RzSzUVrpaFAkUy0D9mf
         XgnYUt0mXG9uq0fwZ468vDzEVVPX4LLDNaewC8Tw7dgv2+GPrEmI/7pGrNdgV/m+/LJ9
         rnVw==
X-Gm-Message-State: AOAM5302njZ82VwOuFX0AcRtB4kxs6t5xSiJuvB75jmZgeTXdIG3NvIM
        1rOyZTHJeuk14ipbgxYa6xLGfuc0koM=
X-Google-Smtp-Source: ABdhPJx7qh+mfymAzQBG25lRx9QE5vU6BPHyUUPgWEEM5pL746lJaJh6WH29vwMxgEGrEQbLK0EAQQ==
X-Received: by 2002:a17:90b:f8d:: with SMTP id ft13mr2840811pjb.228.1629788542127;
        Tue, 24 Aug 2021 00:02:22 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id b17sm20365340pgl.61.2021.08.24.00.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 00:02:21 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Luting Guo <luting.guo@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3] spi: sprd: Pass offset instead of physical address to adi_read/_write()
Date:   Tue, 24 Aug 2021 15:02:10 +0800
Message-Id: <20210824070212.2089255-1-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

The register offset would be added a physical address base and then pass to
the function sprd_adt_read()/_write() each time before calling them. So we
can do that within these two functions instead, that would make the code
more clear.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
 drivers/spi/spi-sprd-adi.c | 105 ++++++++++++++++---------------------
 1 file changed, 44 insertions(+), 61 deletions(-)

diff --git a/drivers/spi/spi-sprd-adi.c b/drivers/spi/spi-sprd-adi.c
index ab19068be867..abdad1ea7b38 100644
--- a/drivers/spi/spi-sprd-adi.c
+++ b/drivers/spi/spi-sprd-adi.c
@@ -117,24 +117,18 @@ struct sprd_adi {
 	struct notifier_block	restart_handler;
 };
 
-static int sprd_adi_check_paddr(struct sprd_adi *sadi, u32 paddr)
+static int sprd_adi_check_addr(struct sprd_adi *sadi, u32 reg)
 {
-	if (paddr < sadi->slave_pbase || paddr >
-	    (sadi->slave_pbase + ADI_SLAVE_ADDR_SIZE)) {
+	if (reg > ADI_SLAVE_ADDR_SIZE) {
 		dev_err(sadi->dev,
-			"slave physical address is incorrect, addr = 0x%x\n",
-			paddr);
+			"slave address offset is incorrect, reg = 0x%x\n",
+			reg);
 		return -EINVAL;
 	}
 
 	return 0;
 }
 
-static unsigned long sprd_adi_to_vaddr(struct sprd_adi *sadi, u32 paddr)
-{
-	return (paddr - sadi->slave_pbase + sadi->slave_vbase);
-}
-
 static int sprd_adi_drain_fifo(struct sprd_adi *sadi)
 {
 	u32 timeout = ADI_FIFO_DRAIN_TIMEOUT;
@@ -161,11 +155,11 @@ static int sprd_adi_fifo_is_full(struct sprd_adi *sadi)
 	return readl_relaxed(sadi->base + REG_ADI_ARM_FIFO_STS) & BIT_FIFO_FULL;
 }
 
-static int sprd_adi_read(struct sprd_adi *sadi, u32 reg_paddr, u32 *read_val)
+static int sprd_adi_read(struct sprd_adi *sadi, u32 reg, u32 *read_val)
 {
 	int read_timeout = ADI_READ_TIMEOUT;
 	unsigned long flags;
-	u32 val, rd_addr;
+	u32 val, rd_addr, paddr;
 	int ret = 0;
 
 	if (sadi->hwlock) {
@@ -178,11 +172,16 @@ static int sprd_adi_read(struct sprd_adi *sadi, u32 reg_paddr, u32 *read_val)
 		}
 	}
 
+	ret = sprd_adi_check_addr(sadi, reg);
+	if (ret)
+		goto out;
+
 	/*
 	 * Set the physical register address need to read into RD_CMD register,
 	 * then ADI controller will start to transfer automatically.
 	 */
-	writel_relaxed(reg_paddr, sadi->base + REG_ADI_RD_CMD);
+	paddr = sadi->slave_pbase + reg;
+	writel_relaxed(paddr, sadi->base + REG_ADI_RD_CMD);
 
 	/*
 	 * Wait read operation complete, the BIT_RD_CMD_BUSY will be set
@@ -212,9 +211,9 @@ static int sprd_adi_read(struct sprd_adi *sadi, u32 reg_paddr, u32 *read_val)
 	 */
 	rd_addr = (val & RD_ADDR_MASK) >> RD_ADDR_SHIFT;
 
-	if (rd_addr != (reg_paddr & REG_ADDR_LOW_MASK)) {
+	if (rd_addr != (paddr & REG_ADDR_LOW_MASK)) {
 		dev_err(sadi->dev, "read error, reg addr = 0x%x, val = 0x%x\n",
-			reg_paddr, val);
+			paddr, val);
 		ret = -EIO;
 		goto out;
 	}
@@ -227,9 +226,8 @@ static int sprd_adi_read(struct sprd_adi *sadi, u32 reg_paddr, u32 *read_val)
 	return ret;
 }
 
-static int sprd_adi_write(struct sprd_adi *sadi, u32 reg_paddr, u32 val)
+static int sprd_adi_write(struct sprd_adi *sadi, u32 reg, u32 val)
 {
-	unsigned long reg = sprd_adi_to_vaddr(sadi, reg_paddr);
 	u32 timeout = ADI_FIFO_DRAIN_TIMEOUT;
 	unsigned long flags;
 	int ret;
@@ -244,6 +242,10 @@ static int sprd_adi_write(struct sprd_adi *sadi, u32 reg_paddr, u32 val)
 		}
 	}
 
+	ret = sprd_adi_check_addr(sadi, reg);
+	if (ret)
+		goto out;
+
 	ret = sprd_adi_drain_fifo(sadi);
 	if (ret < 0)
 		goto out;
@@ -254,7 +256,8 @@ static int sprd_adi_write(struct sprd_adi *sadi, u32 reg_paddr, u32 val)
 	 */
 	do {
 		if (!sprd_adi_fifo_is_full(sadi)) {
-			writel_relaxed(val, (void __iomem *)reg);
+			/* we need virtual register address to write. */
+			writel_relaxed(val, (void __iomem *)(sadi->slave_vbase + reg));
 			break;
 		}
 
@@ -277,44 +280,24 @@ static int sprd_adi_transfer_one(struct spi_controller *ctlr,
 				 struct spi_transfer *t)
 {
 	struct sprd_adi *sadi = spi_controller_get_devdata(ctlr);
-	u32 phy_reg, val;
+	u32 reg, val;
 	int ret;
 
 	if (t->rx_buf) {
-		phy_reg = *(u32 *)t->rx_buf + sadi->slave_pbase;
-
-		ret = sprd_adi_check_paddr(sadi, phy_reg);
-		if (ret)
-			return ret;
-
-		ret = sprd_adi_read(sadi, phy_reg, &val);
-		if (ret)
-			return ret;
-
+		reg = *(u32 *)t->rx_buf;
+		ret = sprd_adi_read(sadi, reg, &val);
 		*(u32 *)t->rx_buf = val;
 	} else if (t->tx_buf) {
 		u32 *p = (u32 *)t->tx_buf;
-
-		/*
-		 * Get the physical register address need to write and convert
-		 * the physical address to virtual address. Since we need
-		 * virtual register address to write.
-		 */
-		phy_reg = *p++ + sadi->slave_pbase;
-		ret = sprd_adi_check_paddr(sadi, phy_reg);
-		if (ret)
-			return ret;
-
+		reg = *p++;
 		val = *p;
-		ret = sprd_adi_write(sadi, phy_reg, val);
-		if (ret)
-			return ret;
+		ret = sprd_adi_write(sadi, reg, val);
 	} else {
 		dev_err(sadi->dev, "no buffer for transfer\n");
-		return -EINVAL;
+		ret = -EINVAL;
 	}
 
-	return 0;
+	return ret;
 }
 
 static void sprd_adi_set_wdt_rst_mode(struct sprd_adi *sadi)
@@ -323,9 +306,9 @@ static void sprd_adi_set_wdt_rst_mode(struct sprd_adi *sadi)
 	u32 val;
 
 	/* Set default watchdog reboot mode */
-	sprd_adi_read(sadi, sadi->slave_pbase + PMIC_RST_STATUS, &val);
+	sprd_adi_read(sadi, PMIC_RST_STATUS, &val);
 	val |= HWRST_STATUS_WATCHDOG;
-	sprd_adi_write(sadi, sadi->slave_pbase + PMIC_RST_STATUS, val);
+	sprd_adi_write(sadi, PMIC_RST_STATUS, val);
 #endif
 }
 
@@ -366,40 +349,40 @@ static int sprd_adi_restart_handler(struct notifier_block *this,
 		reboot_mode = HWRST_STATUS_NORMAL;
 
 	/* Record the reboot mode */
-	sprd_adi_read(sadi, sadi->slave_pbase + PMIC_RST_STATUS, &val);
+	sprd_adi_read(sadi, PMIC_RST_STATUS, &val);
 	val &= ~HWRST_STATUS_WATCHDOG;
 	val |= reboot_mode;
-	sprd_adi_write(sadi, sadi->slave_pbase + PMIC_RST_STATUS, val);
+	sprd_adi_write(sadi, PMIC_RST_STATUS, val);
 
 	/* Enable the interface clock of the watchdog */
-	sprd_adi_read(sadi, sadi->slave_pbase + PMIC_MODULE_EN, &val);
+	sprd_adi_read(sadi, PMIC_MODULE_EN, &val);
 	val |= BIT_WDG_EN;
-	sprd_adi_write(sadi, sadi->slave_pbase + PMIC_MODULE_EN, val);
+	sprd_adi_write(sadi, PMIC_MODULE_EN, val);
 
 	/* Enable the work clock of the watchdog */
-	sprd_adi_read(sadi, sadi->slave_pbase + PMIC_CLK_EN, &val);
+	sprd_adi_read(sadi, PMIC_CLK_EN, &val);
 	val |= BIT_WDG_EN;
-	sprd_adi_write(sadi, sadi->slave_pbase + PMIC_CLK_EN, val);
+	sprd_adi_write(sadi, PMIC_CLK_EN, val);
 
 	/* Unlock the watchdog */
-	sprd_adi_write(sadi, sadi->slave_pbase + REG_WDG_LOCK, WDG_UNLOCK_KEY);
+	sprd_adi_write(sadi, REG_WDG_LOCK, WDG_UNLOCK_KEY);
 
-	sprd_adi_read(sadi, sadi->slave_pbase + REG_WDG_CTRL, &val);
+	sprd_adi_read(sadi, REG_WDG_CTRL, &val);
 	val |= BIT_WDG_NEW;
-	sprd_adi_write(sadi, sadi->slave_pbase + REG_WDG_CTRL, val);
+	sprd_adi_write(sadi, REG_WDG_CTRL, val);
 
 	/* Load the watchdog timeout value, 50ms is always enough. */
-	sprd_adi_write(sadi, sadi->slave_pbase + REG_WDG_LOAD_HIGH, 0);
-	sprd_adi_write(sadi, sadi->slave_pbase + REG_WDG_LOAD_LOW,
+	sprd_adi_write(sadi, REG_WDG_LOAD_HIGH, 0);
+	sprd_adi_write(sadi, REG_WDG_LOAD_LOW,
 		       WDG_LOAD_VAL & WDG_LOAD_MASK);
 
 	/* Start the watchdog to reset system */
-	sprd_adi_read(sadi, sadi->slave_pbase + REG_WDG_CTRL, &val);
+	sprd_adi_read(sadi, REG_WDG_CTRL, &val);
 	val |= BIT_WDG_RUN | BIT_WDG_RST;
-	sprd_adi_write(sadi, sadi->slave_pbase + REG_WDG_CTRL, val);
+	sprd_adi_write(sadi, REG_WDG_CTRL, val);
 
 	/* Lock the watchdog */
-	sprd_adi_write(sadi, sadi->slave_pbase + REG_WDG_LOCK, ~WDG_UNLOCK_KEY);
+	sprd_adi_write(sadi, REG_WDG_LOCK, ~WDG_UNLOCK_KEY);
 
 	mdelay(1000);
 
-- 
2.25.1

