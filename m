Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 141D223E0A1
	for <lists+linux-spi@lfdr.de>; Thu,  6 Aug 2020 20:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729434AbgHFSge (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 6 Aug 2020 14:36:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:59082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729328AbgHFSgN (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 6 Aug 2020 14:36:13 -0400
Received: from localhost.localdomain (unknown [194.230.155.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8680A22D74;
        Thu,  6 Aug 2020 18:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596738189;
        bh=3O3liBSyHwDtMPlVC7YZw60Ut1YHcavAkks9soG7J1I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ofZVJEPPrfbV5WFWbrLk1ZSYb2JuhKjThcNSuaWcyMT7nyz4wm9dNg75G6HZrHLAI
         x+EKHl6ZJtPmfxRQ+MBxH/RG+0AB4kLBe91Y8th3E56UZvsDYLD+7vVkLT/TDAJ4/P
         4pOOwo7TLS92qsqFNJkijQfVigbykWD0O+MtInFM=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Mark Brown <broonie@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        Andi Shyti <andi@etezian.org>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH v2 23/41] ARM: s3c24xx: move spi fiq handler into platform
Date:   Thu,  6 Aug 2020 20:20:40 +0200
Message-Id: <20200806182059.2431-23-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200806181932.2253-1-krzk@kernel.org>
References: <20200806181932.2253-1-krzk@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The fiq handler needs access to some register definitions that
should not be used directly by device drivers.

Since this is closely related to the irqchip driver anyway,
move it into the same place.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
[krzk: Add a header guard in include/linux/spi/s3c24xx-fiq.h, fix
      SPDX comment style, update maintainer's entry]
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. Add a header guard in include/linux/spi/s3c24xx-fiq.h,
2. Fix SPDX comment style,
3. Update maintainer's entry.
---
 MAINTAINERS                                            |  1 +
 arch/arm/mach-s3c24xx/Makefile                         |  2 ++
 arch/arm/mach-s3c24xx/irq-s3c24xx-fiq-exports.c        |  9 +++++++++
 .../arm/mach-s3c24xx/irq-s3c24xx-fiq.S                 |  2 +-
 drivers/spi/Makefile                                   |  1 -
 drivers/spi/spi-s3c24xx.c                              |  7 +------
 .../linux/spi/s3c24xx-fiq.h                            | 10 ++++++++++
 7 files changed, 24 insertions(+), 8 deletions(-)
 create mode 100644 arch/arm/mach-s3c24xx/irq-s3c24xx-fiq-exports.c
 rename drivers/spi/spi-s3c24xx-fiq.S => arch/arm/mach-s3c24xx/irq-s3c24xx-fiq.S (98%)
 rename drivers/spi/spi-s3c24xx-fiq.h => include/linux/spi/s3c24xx-fiq.h (66%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 81046738cba9..d9accf3c2582 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15307,6 +15307,7 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/spi/spi-samsung.txt
 F:	drivers/spi/spi-s3c*
 F:	include/linux/platform_data/spi-s3c64xx.h
+F:	include/linux/spi/s3c24xx-fiq.h
 
 SAMSUNG SXGBE DRIVERS
 M:	Byungho An <bh74.an@samsung.com>
diff --git a/arch/arm/mach-s3c24xx/Makefile b/arch/arm/mach-s3c24xx/Makefile
index 8c31f84f8c97..695573df00b1 100644
--- a/arch/arm/mach-s3c24xx/Makefile
+++ b/arch/arm/mach-s3c24xx/Makefile
@@ -9,6 +9,8 @@
 
 obj-y				+= common.o
 obj-y				+= irq-s3c24xx.o
+obj-$(CONFIG_SPI_S3C24XX_FIQ)	+= irq-s3c24xx-fiq.o
+obj-$(CONFIG_SPI_S3C24XX_FIQ)	+= irq-s3c24xx-fiq-exports.o
 
 obj-$(CONFIG_CPU_S3C2410)	+= s3c2410.o
 obj-$(CONFIG_S3C2410_PLL)	+= pll-s3c2410.o
diff --git a/arch/arm/mach-s3c24xx/irq-s3c24xx-fiq-exports.c b/arch/arm/mach-s3c24xx/irq-s3c24xx-fiq-exports.c
new file mode 100644
index 000000000000..84cf86376ded
--- /dev/null
+++ b/arch/arm/mach-s3c24xx/irq-s3c24xx-fiq-exports.c
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/stddef.h>
+#include <linux/export.h>
+#include <linux/spi/s3c24xx-fiq.h>
+
+EXPORT_SYMBOL(s3c24xx_spi_fiq_rx);
+EXPORT_SYMBOL(s3c24xx_spi_fiq_txrx);
+EXPORT_SYMBOL(s3c24xx_spi_fiq_tx);
diff --git a/drivers/spi/spi-s3c24xx-fiq.S b/arch/arm/mach-s3c24xx/irq-s3c24xx-fiq.S
similarity index 98%
rename from drivers/spi/spi-s3c24xx-fiq.S
rename to arch/arm/mach-s3c24xx/irq-s3c24xx-fiq.S
index 9d5f8f1e5e81..2a84535a14fd 100644
--- a/drivers/spi/spi-s3c24xx-fiq.S
+++ b/arch/arm/mach-s3c24xx/irq-s3c24xx-fiq.S
@@ -13,7 +13,7 @@
 #include <mach/map.h>
 #include <mach/regs-irq.h>
 
-#include "spi-s3c24xx-fiq.h"
+#include <linux/spi/s3c24xx-fiq.h>
 
 #define S3C2410_SPTDAT           (0x10)
 #define S3C2410_SPRDAT           (0x14)
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index cf955ea803cd..eba6fb607aa2 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -97,7 +97,6 @@ obj-$(CONFIG_SPI_RPCIF)			+= spi-rpc-if.o
 obj-$(CONFIG_SPI_RSPI)			+= spi-rspi.o
 obj-$(CONFIG_SPI_S3C24XX)		+= spi-s3c24xx-hw.o
 spi-s3c24xx-hw-y			:= spi-s3c24xx.o
-spi-s3c24xx-hw-$(CONFIG_SPI_S3C24XX_FIQ) += spi-s3c24xx-fiq.o
 obj-$(CONFIG_SPI_S3C64XX)		+= spi-s3c64xx.o
 obj-$(CONFIG_SPI_SC18IS602)		+= spi-sc18is602.o
 obj-$(CONFIG_SPI_SH)			+= spi-sh.o
diff --git a/drivers/spi/spi-s3c24xx.c b/drivers/spi/spi-s3c24xx.c
index 92be0c6d798a..e7a4732590db 100644
--- a/drivers/spi/spi-s3c24xx.c
+++ b/drivers/spi/spi-s3c24xx.c
@@ -19,12 +19,12 @@
 #include <linux/spi/spi.h>
 #include <linux/spi/spi_bitbang.h>
 #include <linux/spi/s3c24xx.h>
+#include <linux/spi/s3c24xx-fiq.h>
 #include <linux/module.h>
 
 #include <asm/fiq.h>
 
 #include "spi-s3c24xx-regs.h"
-#include "spi-s3c24xx-fiq.h"
 
 /**
  * struct s3c24xx_spi_devstate - per device data
@@ -229,10 +229,6 @@ struct spi_fiq_code {
 	u8	data[];
 };
 
-extern struct spi_fiq_code s3c24xx_spi_fiq_txrx;
-extern struct spi_fiq_code s3c24xx_spi_fiq_tx;
-extern struct spi_fiq_code s3c24xx_spi_fiq_rx;
-
 /**
  * ack_bit - turn IRQ into IRQ acknowledgement bit
  * @irq: The interrupt number
@@ -282,7 +278,6 @@ static void s3c24xx_spi_tryfiq(struct s3c24xx_spi *hw)
 	regs.uregs[fiq_rrx]  = (long)hw->rx;
 	regs.uregs[fiq_rtx]  = (long)hw->tx + 1;
 	regs.uregs[fiq_rcount] = hw->len - 1;
-	regs.uregs[fiq_rirq] = (long)S3C24XX_VA_IRQ;
 
 	set_fiq_regs(&regs);
 
diff --git a/drivers/spi/spi-s3c24xx-fiq.h b/include/linux/spi/s3c24xx-fiq.h
similarity index 66%
rename from drivers/spi/spi-s3c24xx-fiq.h
rename to include/linux/spi/s3c24xx-fiq.h
index 7786b0ea56ec..d2842ac1de27 100644
--- a/drivers/spi/spi-s3c24xx-fiq.h
+++ b/include/linux/spi/s3c24xx-fiq.h
@@ -7,11 +7,19 @@
  * S3C24XX SPI - FIQ pseudo-DMA transfer support
 */
 
+#ifndef __LINUX_SPI_S3C24XX_FIQ_H
+#define __LINUX_SPI_S3C24XX_FIQ_H __FILE__
+
 /* We have R8 through R13 to play with */
 
 #ifdef __ASSEMBLY__
 #define __REG_NR(x)     r##x
 #else
+
+extern struct spi_fiq_code s3c24xx_spi_fiq_txrx;
+extern struct spi_fiq_code s3c24xx_spi_fiq_tx;
+extern struct spi_fiq_code s3c24xx_spi_fiq_rx;
+
 #define __REG_NR(x)     (x)
 #endif
 
@@ -21,3 +29,5 @@
 #define fiq_rtx		__REG_NR(11)
 #define fiq_rcount	__REG_NR(12)
 #define fiq_rirq	__REG_NR(13)
+
+#endif /* __LINUX_SPI_S3C24XX_FIQ_H */
-- 
2.17.1

