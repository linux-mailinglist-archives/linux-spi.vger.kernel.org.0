Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19F5B86C60
	for <lists+linux-spi@lfdr.de>; Thu,  8 Aug 2019 23:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403940AbfHHV3O (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 8 Aug 2019 17:29:14 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:51859 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404251AbfHHV3O (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 8 Aug 2019 17:29:14 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1Mxpqo-1iF0VT3dks-00zD7L; Thu, 08 Aug 2019 23:28:57 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Tony Lindgren <tony@atomide.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: [PATCH 07/22] ARM: omap1: move perseus spi pinconf to board file
Date:   Thu,  8 Aug 2019 23:22:16 +0200
Message-Id: <20190808212234.2213262-8-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190808212234.2213262-1-arnd@arndb.de>
References: <20190808212234.2213262-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:OUywYjmUvR4CggfZfvVTBOs6Wqw61X7ANdp+0I65+P8MCPSSa41
 5GvGcAmYjU2DGOzqYVYCAn/KSoqrC1TXd4CnESq/PgpAi3GqLbpTe3IptCS8caaxMlQ7MWB
 qspivVS8oe8TFvFiGP+yhn+TNtbQ31DZqvBQMB8LsgaAzHiS6rwCdV2Wa5fHzpxxGDK29H2
 oVjrpRiT3l+OAdxjzkEqg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:HTgsHXt4VYg=:wv/3Tz08gC4O1xmYtn1lnv
 0DQVchC6pJEpqwK+9CzLoTkrnBsAxE7wZ+elRXgafIIObsfCNN/YIgTQ1GdzAShuaQlhVUAiI
 x2put5/QNp+CQKco+ufIo3WHRGRBqey6WIpXX3I0vYqr5zrSFImTvDEr26dWXewa8Mge4eIl9
 1zandRW0JCIG0L7TtDX6UFCokfvoWtQFPzY3zsIR/U9cFbYboSkaJl1xb6m8LmTMz1Fy+r3Xo
 3IxwAXhdJ539LXs1RLtojMfFqgTVwmfhY2aiC4Mu1N4VhBJRVMUU39ySLQZi7LVc/eOT7qiOt
 mbUIg0pOs3W84yVSI/V/2eEOCoxIhMCWtiQ8UYSmcrk3HumNFJCiB0TJn2lnbrIByn4XAm24E
 WznZoc38kwirw1rzqsFaDVwfSRvHkB5IOK392edCP0d7AgSYWCrBKpTvLVWew9EfVojJI/WHc
 2mVDRcJiU4P/xzA3rN8j7ED727y6zXc0KrWLV+OLt27wntOZxNuwOIjm9oDiicsH1bvFm7OUC
 SNkSxxwqlJeNQXllVKUrLsRfTT5UGPZIqVy5go2ubH3J6RHBC1w0pP+0w5WqBW8Cm89usEALa
 iKtMuH4jjEzc/yH9jf4lu9GQ05158U+qlSFKhqq27BtihJNJhdr4cG8OTguF49oF/z3GoUZbz
 0zk3AiGWMmw/7SdHAJ8JjCbDR6tL1hq0xnwyrGxON2pNn9j7RW51LxD6sg3MZJxWqMNYZ+1WU
 sY7/qqbeEDI/viciS0gwy5RjMHG7ffieopLw0A==
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The driver has always had a FIXME about this, and it seems
like this trivial code move avoids a mach header inclusion,
so just do it.

With that out of the way, and the header file inclusions
changed to global files, the driver can also be compile-tested
on other platforms.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-omap1/board-perseus2.c |  6 ++++++
 drivers/spi/Kconfig                  |  2 +-
 drivers/spi/spi-omap-uwire.c         | 15 +++------------
 3 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-omap1/board-perseus2.c b/arch/arm/mach-omap1/board-perseus2.c
index 1aeeb7337d29..da0155107d85 100644
--- a/arch/arm/mach-omap1/board-perseus2.c
+++ b/arch/arm/mach-omap1/board-perseus2.c
@@ -289,6 +289,12 @@ static void __init omap_perseus2_init(void)
 	omap_cfg_reg(F4_7XX_KBC3);
 	omap_cfg_reg(E3_7XX_KBC4);
 
+	if (IS_ENABLED(CONFIG_SPI_OMAP_UWIRE)) {
+		/* configure pins: MPU_UW_nSCS1, MPU_UW_SDO, MPU_UW_SCLK */
+		int val = omap_readl(OMAP7XX_IO_CONF_9) & ~0x00EEE000;
+		omap_writel(val | 0x00AAA000, OMAP7XX_IO_CONF_9);
+	}
+
 	platform_add_devices(devices, ARRAY_SIZE(devices));
 
 	omap_serial_init();
diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 949b18ed9d6b..4e67c155229e 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -464,7 +464,7 @@ config SPI_OCTEON
 
 config SPI_OMAP_UWIRE
 	tristate "OMAP1 MicroWire"
-	depends on ARCH_OMAP1
+	depends on ARCH_OMAP1 || (ARM && COMPILE_TEST)
 	select SPI_BITBANG
 	help
 	  This hooks up to the MicroWire controller on OMAP1 chips.
diff --git a/drivers/spi/spi-omap-uwire.c b/drivers/spi/spi-omap-uwire.c
index ce8dbdbce312..278d42a2ec49 100644
--- a/drivers/spi/spi-omap-uwire.c
+++ b/drivers/spi/spi-omap-uwire.c
@@ -44,13 +44,10 @@
 #include <linux/module.h>
 #include <linux/io.h>
 
-#include <mach/hardware.h>
 #include <asm/mach-types.h>
-
-#include <mach/mux.h>
-
-#include <mach/omap7xx.h>	/* OMAP7XX_IO_CONF registers */
-
+#include <linux/soc/ti/omap1-io.h>
+#include <linux/soc/ti/omap1-soc.h>
+#include <linux/soc/ti/omap1-mux.h>
 
 /* FIXME address is now a platform device resource,
  * and irqs should show there too...
@@ -541,12 +538,6 @@ static int __init omap_uwire_init(void)
 		omap_cfg_reg(N14_1610_UWIRE_CS0);
 		omap_cfg_reg(N15_1610_UWIRE_CS1);
 	}
-	if (machine_is_omap_perseus2()) {
-		/* configure pins: MPU_UW_nSCS1, MPU_UW_SDO, MPU_UW_SCLK */
-		int val = omap_readl(OMAP7XX_IO_CONF_9) & ~0x00EEE000;
-		omap_writel(val | 0x00AAA000, OMAP7XX_IO_CONF_9);
-	}
-
 	return platform_driver_register(&uwire_driver);
 }
 
-- 
2.20.0

