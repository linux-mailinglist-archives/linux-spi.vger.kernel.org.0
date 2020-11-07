Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A39FE2AA37D
	for <lists+linux-spi@lfdr.de>; Sat,  7 Nov 2020 09:15:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728077AbgKGIO7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 7 Nov 2020 03:14:59 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:57208 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727801AbgKGIO7 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 7 Nov 2020 03:14:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604736898; x=1636272898;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BBotgl9u6Ee4WQKcqLY3PIUza5hjv/SR3kFV9rZnZOg=;
  b=lSpjTg8cVnsrpI/YPV1Ouz6yR83sLcKTHw3Zvi6KIlDcYDR8wnT7La8V
   nleEg5dXoCd/5vDifB3mpJHs+wmlbPral9BxiuCjln9PYFSfrq7Ai1Rqd
   qvlzcIhkM9W42wBd5/VWG847pgaqv320//uPf8Wva2yatVSUcSOUkvuco
   l5Ci7NxAYXRtCV6WdGr3K6mLZTXyA/7eKOqV7Fqrv0sOpgbFVowXg2Ait
   0Ccy4yUqvGwGvAn2vZHUygh6fDC+5zmsDBe5Q1sQfOOdHeHhc1Dge8mjN
   ZmzYHwtnJeahzHrAjqYqdsCVcSYH70CFus5uRp3ZtPh4eT3fv5edV3G4x
   g==;
IronPort-SDR: uvVDnXZ4ej4ygaC6CjrFhVGAP4eBttV0EwmRvUyH7jLlcc4ixdnJgxTluv9k0xQSep3Hzy8rY8
 wjTc82HTHErYRKqrk/k/2CSAuOVRs3Wdf8f6UnOLoOXifNohl6edKvL8gEP0vInWlqFlUEEVfv
 4dqorvkDiSII9rRYWQVksX/BBrMrftPvl3CVCIm3DsT/9gYqRMqu7cezGYu3LpimBlEyvJ1teH
 4+uqNpgnKlgvLFhkcYbaIgL51yfsJ96mPTcCoRSBKZDUA7hMg1iImz9DvXmzl0B62aWf1+yRsx
 bpY=
X-IronPort-AV: E=Sophos;i="5.77,459,1596470400"; 
   d="scan'208";a="156564386"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Nov 2020 16:14:58 +0800
IronPort-SDR: 8+A8jgY2nGCVPPNrYfP97aPluiQti6nNmdcHLc+hObYN6BM4S2MG/7uXwaQGdZo5SQDU0wsB1b
 S6b9PnAuwWSccA7tSPJifZXcqJHOx21cwM3UO0rED9zVjEQwRW14yvjYG7ZBoVPI5QHIkrA7SP
 C3VWZvU+qmytGJFId5aeTnoY+jm0KHF6CBaZxBU/iTEWxGJeAkSxH4Ees8wtbvHDxwcLsIz3UX
 RsARuk4inYmG87klvXx2eb5P6cYlBy61eoWzuIZT4FNJkGVJPDxiAFBamLOMHqtVM5oWPJCL7x
 +gxcJqoMnGZdXDtJ0ES5OZr0
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2020 23:59:49 -0800
IronPort-SDR: BjWEbz725IVXr60UmKHYWFPaQ0JG9Y5DmepU/3LakjotVZSZNa3TsEvhch9efEdMsqQXLDgZZw
 LfNxJVQdDHiaH0A9z6WmLDW2wOu0V4PSeb3HYIxh/gEvDOvx0TVSsQZQ6eWVMqHaa30JTu3ayw
 hyFHPS/W0iAq2huzgNc7jE4htyhf9yT2732ooxixckscNXOIlcfpmqlIvqe+v8xpeCI+VceOcR
 Wu9lxXoRl3aj/2R+5aZwrkA7Uj768KBX2xsfyFmOpdXsrQGVgsr3138v1Vb9SLMoyCe0TqHsEZ
 eiE=
WDCIronportException: Internal
Received: from hdrdzf2.ad.shared (HELO twashi.fujisawa.hgst.com) ([10.84.71.85])
  by uls-op-cesaip01.wdc.com with ESMTP; 07 Nov 2020 00:14:56 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Sean Anderson <seanga2@gmail.com>
Subject: [PATCH 13/32] riscv: Fix builtin DTB handling
Date:   Sat,  7 Nov 2020 17:14:01 +0900
Message-Id: <20201107081420.60325-14-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201107081420.60325-1-damien.lemoal@wdc.com>
References: <20201107081420.60325-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

All SiPeed K210 boards have the exact same vendor, arch and
implementation IDs, preventing differentiation of the device tree to use
through the SOC_BUILTIN_DTB_DECLARE() macro. This result in this macro,
used only for Kendryte, to be useless and to prevent changing the
builtin device tree without also changing the code of the sysctl soc
driver.

Fix this problem by removing the SOC_BUILTIN_DTB_DECLARE() macro and
associated code, falling back to a simpler, and more traditional
handling of builtin DTB similar to other architectures.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 arch/riscv/Kconfig.socs               | 22 ++++++++++++----
 arch/riscv/boot/dts/kendryte/Makefile |  5 ++--
 arch/riscv/include/asm/soc.h          | 38 ---------------------------
 arch/riscv/kernel/soc.c               | 27 -------------------
 arch/riscv/mm/init.c                  |  6 +----
 drivers/soc/kendryte/k210-sysctl.c    | 12 ---------
 6 files changed, 21 insertions(+), 89 deletions(-)

diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
index e724fddc44ba..97ef393d0ed0 100644
--- a/arch/riscv/Kconfig.socs
+++ b/arch/riscv/Kconfig.socs
@@ -33,9 +33,10 @@ config SOC_KENDRYTE
 	help
 	  This enables support for Kendryte K210 SoC platform hardware.
 
-config SOC_KENDRYTE_K210_DTB
-	def_bool y
-	depends on SOC_KENDRYTE_K210_DTB_BUILTIN
+config BUILTIN_DTB
+	def_bool n
+
+if SOC_KENDRYTE
 
 config SOC_KENDRYTE_K210_DTB_BUILTIN
 	bool "Builtin device tree for the Kendryte K210"
@@ -43,10 +44,21 @@ config SOC_KENDRYTE_K210_DTB_BUILTIN
 	default y
 	select OF
 	select BUILTIN_DTB
-	select SOC_KENDRYTE_K210_DTB
 	help
-	  Builds a device tree for the Kendryte K210 into the Linux image.
+	  Build a device tree for the Kendryte K210 into the Linux image.
 	  This option should be selected if no bootloader is being used.
 	  If unsure, say Y.
 
+config SOC_KENDRYTE_K210_DTB_SOURCE
+	string "Source file for the Kendryte K210 builtin DTB"
+	depends on SOC_KENDRYTE
+	depends on SOC_KENDRYTE_K210_DTB_BUILTIN
+	default "k210"
+	help
+	  Base name (without suffix, relative to arch/riscv/boot/dts/kendryte)
+	  for the DTS file that will be used to produce the DTB linked into the
+	  kernel.
+
+endif
+
 endmenu
diff --git a/arch/riscv/boot/dts/kendryte/Makefile b/arch/riscv/boot/dts/kendryte/Makefile
index 1a88e616f18e..83636693166d 100644
--- a/arch/riscv/boot/dts/kendryte/Makefile
+++ b/arch/riscv/boot/dts/kendryte/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-dtb-$(CONFIG_SOC_KENDRYTE_K210_DTB) += k210.dtb
-
+ifneq ($(CONFIG_SOC_KENDRYTE_K210_DTB_SOURCE),"")
+dtb-y += $(strip $(shell echo $(CONFIG_SOC_KENDRYTE_K210_DTB_SOURCE))).dtb
 obj-$(CONFIG_SOC_KENDRYTE_K210_DTB_BUILTIN) += $(addsuffix .o, $(dtb-y))
+endif
diff --git a/arch/riscv/include/asm/soc.h b/arch/riscv/include/asm/soc.h
index 6c8363b1f327..f494066051a2 100644
--- a/arch/riscv/include/asm/soc.h
+++ b/arch/riscv/include/asm/soc.h
@@ -21,42 +21,4 @@ void soc_early_init(void);
 extern unsigned long __soc_early_init_table_start;
 extern unsigned long __soc_early_init_table_end;
 
-/*
- * Allows Linux to provide a device tree, which is necessary for SOCs that
- * don't provide a useful one on their own.
- */
-struct soc_builtin_dtb {
-	unsigned long vendor_id;
-	unsigned long arch_id;
-	unsigned long imp_id;
-	void *(*dtb_func)(void);
-};
-
-/*
- * The argument name must specify a valid DTS file name without the dts
- * extension.
- */
-#define SOC_BUILTIN_DTB_DECLARE(name, vendor, arch, impl)		\
-	extern void *__dtb_##name##_begin;				\
-									\
-	static __init __used						\
-	void *__soc_builtin_dtb_f__##name(void)				\
-	{								\
-		return (void *)&__dtb_##name##_begin;			\
-	}								\
-									\
-	static const struct soc_builtin_dtb __soc_builtin_dtb__##name	\
-		__used __section("__soc_builtin_dtb_table") =		\
-	{								\
-		.vendor_id = vendor,					\
-		.arch_id   = arch,					\
-		.imp_id    = impl,					\
-		.dtb_func  = __soc_builtin_dtb_f__##name,		\
-	}
-
-extern unsigned long __soc_builtin_dtb_table_start;
-extern unsigned long __soc_builtin_dtb_table_end;
-
-void *soc_lookup_builtin_dtb(void);
-
 #endif
diff --git a/arch/riscv/kernel/soc.c b/arch/riscv/kernel/soc.c
index c7b0a73e382e..a0516172a33c 100644
--- a/arch/riscv/kernel/soc.c
+++ b/arch/riscv/kernel/soc.c
@@ -26,30 +26,3 @@ void __init soc_early_init(void)
 		}
 	}
 }
-
-static bool soc_builtin_dtb_match(unsigned long vendor_id,
-				unsigned long arch_id, unsigned long imp_id,
-				const struct soc_builtin_dtb *entry)
-{
-	return entry->vendor_id == vendor_id &&
-	       entry->arch_id == arch_id &&
-	       entry->imp_id == imp_id;
-}
-
-void * __init soc_lookup_builtin_dtb(void)
-{
-	unsigned long vendor_id, arch_id, imp_id;
-	const struct soc_builtin_dtb *s;
-
-	__asm__ ("csrr %0, mvendorid" : "=r"(vendor_id));
-	__asm__ ("csrr %0, marchid" : "=r"(arch_id));
-	__asm__ ("csrr %0, mimpid" : "=r"(imp_id));
-
-	for (s = (void *)&__soc_builtin_dtb_table_start;
-	     (void *)s < (void *)&__soc_builtin_dtb_table_end; s++) {
-		if (soc_builtin_dtb_match(vendor_id, arch_id, imp_id, s))
-			return s->dtb_func();
-	}
-
-	return NULL;
-}
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index ea933b789a88..d9c8d8819ed8 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -591,11 +591,7 @@ static void __init setup_vm_final(void)
 asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 {
 #ifdef CONFIG_BUILTIN_DTB
-	dtb_early_va = soc_lookup_builtin_dtb();
-	if (!dtb_early_va) {
-		/* Fallback to first available DTS */
-		dtb_early_va = (void *) __dtb_start;
-	}
+	dtb_early_va = (void *) __dtb_start;
 #else
 	dtb_early_va = (void *)dtb_pa;
 #endif
diff --git a/drivers/soc/kendryte/k210-sysctl.c b/drivers/soc/kendryte/k210-sysctl.c
index 707019223dd8..4608fbca20e1 100644
--- a/drivers/soc/kendryte/k210-sysctl.c
+++ b/drivers/soc/kendryte/k210-sysctl.c
@@ -246,15 +246,3 @@ static void __init k210_soc_early_init(const void *fdt)
 	iounmap(regs);
 }
 SOC_EARLY_INIT_DECLARE(generic_k210, "kendryte,k210", k210_soc_early_init);
-
-#ifdef CONFIG_SOC_KENDRYTE_K210_DTB_BUILTIN
-/*
- * Generic entry for the default k210.dtb embedded DTB for boards with:
- *   - Vendor ID: 0x4B5
- *   - Arch ID: 0xE59889E6A5A04149 (= "Canaan AI" in UTF-8 encoded Chinese)
- *   - Impl ID:	0x4D41495832303030 (= "MAIX2000")
- * These values are reported by the SiPEED MAXDUINO, SiPEED MAIX GO and
- * SiPEED Dan dock boards.
- */
-SOC_BUILTIN_DTB_DECLARE(k210, 0x4B5, 0xE59889E6A5A04149, 0x4D41495832303030);
-#endif
-- 
2.28.0

