Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2287223E12E
	for <lists+linux-spi@lfdr.de>; Thu,  6 Aug 2020 20:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729545AbgHFSli (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 6 Aug 2020 14:41:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:54062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728326AbgHFS3u (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 6 Aug 2020 14:29:50 -0400
Received: from localhost.localdomain (unknown [194.230.155.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3DB5D22E01;
        Thu,  6 Aug 2020 18:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596738239;
        bh=0MX3E7Ne/rPTcgcCD1XqjJDdOiBT4MRY8ces7kKdkI0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fpd7yEIes202ZGrwsi7XioG0nprsSaGhvANyXicNmF1IjIGUhWmE9/7lvAIMALBiK
         UzCilFjlVt/VkB23Su1aGrP5eF+NC20P24Jgxn8ZBHgS+WWTblxxxZzbJVt0dH1P3e
         DdO2vM6jvaB47RBJfmB1NZYiu8fsK4bL7CWPXc3A=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Kukjin Kim <kgene@kernel.org>, Andi Shyti <andi@etezian.org>,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH v2 31/41] ARM: s3c24xx: spi: avoid hardcoding fiq number in driver
Date:   Thu,  6 Aug 2020 20:20:48 +0200
Message-Id: <20200806182059.2431-31-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200806181932.2253-1-krzk@kernel.org>
References: <20200806181932.2253-1-krzk@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The IRQ_EINT0 constant is a platform detail that is
defined in mach/irqs.h and not visible to drivers once
that header is made private.

Since the same calculation already happens in s3c24xx_set_fiq,
just return the value from there.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/mach-s3c24xx/irq-s3c24xx.c | 12 +++++++++---
 drivers/spi/spi-s3c24xx.c           | 18 ++----------------
 include/linux/spi/s3c24xx.h         |  2 +-
 3 files changed, 12 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/irq-s3c24xx.c b/arch/arm/mach-s3c24xx/irq-s3c24xx.c
index b0e879ee14c1..3965347cacf0 100644
--- a/arch/arm/mach-s3c24xx/irq-s3c24xx.c
+++ b/arch/arm/mach-s3c24xx/irq-s3c24xx.c
@@ -376,14 +376,17 @@ asmlinkage void __exception_irq_entry s3c24xx_handle_irq(struct pt_regs *regs)
 /**
  * s3c24xx_set_fiq - set the FIQ routing
  * @irq: IRQ number to route to FIQ on processor.
+ * @ack_ptr: pointer to a location for storing the bit mask
  * @on: Whether to route @irq to the FIQ, or to remove the FIQ routing.
  *
  * Change the state of the IRQ to FIQ routing depending on @irq and @on. If
  * @on is true, the @irq is checked to see if it can be routed and the
  * interrupt controller updated to route the IRQ. If @on is false, the FIQ
  * routing is cleared, regardless of which @irq is specified.
+ *
+ * returns the mask value for the register.
  */
-int s3c24xx_set_fiq(unsigned int irq, bool on)
+int s3c24xx_set_fiq(unsigned int irq, u32 *ack_ptr, bool on)
 {
 	u32 intmod;
 	unsigned offs;
@@ -391,15 +394,18 @@ int s3c24xx_set_fiq(unsigned int irq, bool on)
 	if (on) {
 		offs = irq - FIQ_START;
 		if (offs > 31)
-			return -EINVAL;
+			return 0;
 
 		intmod = 1 << offs;
 	} else {
 		intmod = 0;
 	}
 
+	if (ack_ptr)
+		*ack_ptr = intmod;
 	writel_relaxed(intmod, S3C2410_INTMOD);
-	return 0;
+
+	return intmod;
 }
 
 EXPORT_SYMBOL_GPL(s3c24xx_set_fiq);
diff --git a/drivers/spi/spi-s3c24xx.c b/drivers/spi/spi-s3c24xx.c
index e7a4732590db..d6f51695ca5b 100644
--- a/drivers/spi/spi-s3c24xx.c
+++ b/drivers/spi/spi-s3c24xx.c
@@ -229,17 +229,6 @@ struct spi_fiq_code {
 	u8	data[];
 };
 
-/**
- * ack_bit - turn IRQ into IRQ acknowledgement bit
- * @irq: The interrupt number
- *
- * Returns the bit to write to the interrupt acknowledge register.
- */
-static inline u32 ack_bit(unsigned int irq)
-{
-	return 1 << (irq - IRQ_EINT0);
-}
-
 /**
  * s3c24xx_spi_tryfiq - attempt to claim and setup FIQ for transfer
  * @hw: The hardware state.
@@ -256,6 +245,7 @@ static void s3c24xx_spi_tryfiq(struct s3c24xx_spi *hw)
 	struct pt_regs regs;
 	enum spi_fiq_mode mode;
 	struct spi_fiq_code *code;
+	u32 *ack_ptr = NULL;
 	int ret;
 
 	if (!hw->fiq_claimed) {
@@ -282,8 +272,6 @@ static void s3c24xx_spi_tryfiq(struct s3c24xx_spi *hw)
 	set_fiq_regs(&regs);
 
 	if (hw->fiq_mode != mode) {
-		u32 *ack_ptr;
-
 		hw->fiq_mode = mode;
 
 		switch (mode) {
@@ -303,12 +291,10 @@ static void s3c24xx_spi_tryfiq(struct s3c24xx_spi *hw)
 		BUG_ON(!code);
 
 		ack_ptr = (u32 *)&code->data[code->ack_offset];
-		*ack_ptr = ack_bit(hw->irq);
-
 		set_fiq_handler(&code->data, code->length);
 	}
 
-	s3c24xx_set_fiq(hw->irq, true);
+	s3c24xx_set_fiq(hw->irq, ack_ptr, true);
 
 	hw->fiq_mode = mode;
 	hw->fiq_inuse = 1;
diff --git a/include/linux/spi/s3c24xx.h b/include/linux/spi/s3c24xx.h
index c91d10b82f08..440a71593162 100644
--- a/include/linux/spi/s3c24xx.h
+++ b/include/linux/spi/s3c24xx.h
@@ -20,6 +20,6 @@ struct s3c2410_spi_info {
 	void (*set_cs)(struct s3c2410_spi_info *spi, int cs, int pol);
 };
 
-extern int s3c24xx_set_fiq(unsigned int irq, bool on);
+extern int s3c24xx_set_fiq(unsigned int irq, u32 *ack_ptr, bool on);
 
 #endif /* __LINUX_SPI_S3C24XX_H */
-- 
2.17.1

