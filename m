Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA71ED32D8
	for <lists+linux-spi@lfdr.de>; Thu, 10 Oct 2019 22:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbfJJUtR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 10 Oct 2019 16:49:17 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:49133 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbfJJUtR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 10 Oct 2019 16:49:17 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MmQUL-1hrtCu1NLt-00iTUZ; Thu, 10 Oct 2019 22:49:09 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>
Cc:     linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linus.walleij@linaro.org,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: [PATCH 25/36] ARM: s3c: spi: avoid hardcoding fiq number in driver
Date:   Thu, 10 Oct 2019 22:30:09 +0200
Message-Id: <20191010203043.1241612-25-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191010203043.1241612-1-arnd@arndb.de>
References: <20191010202802.1132272-1-arnd@arndb.de>
 <20191010203043.1241612-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:s0CwvLUh0Zt1aNpPMIdJtPmyIE+SbFYN5oqxY6XwHzTwnI47DgP
 uoljIHRqhWICxbKhJ3Dy+1+bu0FYJTFGu/+ZCpSR80FWv7/E3LWo79CZLild1X6EkhmA2po
 VHPUq5C+3BzgWtzLxHk1KNXpvPBXxxQSkABs9SWef4/Ls/Dg/a91FmPdRUfuWv8a9TUza+7
 KgM+bsyOeLgUpJTP6GE8A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:4CkTuF8oOdw=:85gFcnpN2VJXr2f5InQsnA
 VNxi7IexHlaXQVNxbACwbr9wFnDR6vQVm3FLC+fZpbvKHddPWYm2A0MZAT5wySowUafjGqErL
 yiFIeJ18+6C1jX17EwyZEtw5rlPx2zCulYdiPdk5s0UB3FDo6X/8CWGKHNVS6jDKyUlJKA4aJ
 GyB5XHhh8sJyCaFqljrEsvf8AMUc2pzjElCVAJJ2wGfTZotQUDxlMRkgCSxX98eIZANU1584E
 aKwfTGZvXJeYIp2ozFvJL72lvXHzY00Ul4MKHhOtYwt8KrK29KH+5Dy0qMp9b5yWABORy7LXW
 cgs0Q9CciwS7bxa5GhfrGgcwU3S1pl8WcbKW0I0fqqAFV4CxEtmdo+JEi2EzIBigVhzCXXWab
 vM8asAqtDMhZqmORz64vPD+KM0hFATjmGNXUyJAI1eTFKT1Hw7ffngX02fJynbAIV+iaPJAwk
 uPRFvSKqblOKGGJ9iA3kal/NiO9euAnsL2eZ/HyW8fmeUYxTxn8jpkLrPz+T85y+vs9J8gY5C
 u5ojweam7qNeSsictVCH2zACJhdUQnBK6fWNhmlFgFrLfP23sw1gW8FLuN7slUmBKSSRWDHDY
 U2EEP0CZPm/uFoKDvOPjrrYNTrkDcKsR4EBBVQsnU9k4Vaz0dIaraWvvmDvY+dg5aMbCd8lhX
 WlcTBOnrKQ23759pdqLM9JV+QSXmJBoO8Tan67RQxsdF92HFR5E+Ku3MRBEOZkH3XkwlJIuaD
 zpHBLMdH9+Hh0Odt+wc1DFCtI4FXeJtAN89h/YNMOwoIvUYWfsKduh8fzVTzg0wjwgMUbjhwp
 z6vRFs5gDeJtNrKFqprqpQE5tPD1IPLe69c81tQu7OWntE78TNoJT4JpPgoz7HuHZYQ0KBKv2
 Af15ynf6YXKickTItCFQ==
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The IRQ_EINT0 constant is a platform detail that is
defined in mach/irqs.h and not visible to drivers once
that header is made private.

Since the same calculation already happens in s3c24xx_set_fiq,
just return the value from there.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
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
index 464146fc8420..58025876a081 100644
--- a/drivers/spi/spi-s3c24xx.c
+++ b/drivers/spi/spi-s3c24xx.c
@@ -229,17 +229,6 @@ struct spi_fiq_code {
 	u8	data[0];
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
2.20.0

