Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67B902AA378
	for <lists+linux-spi@lfdr.de>; Sat,  7 Nov 2020 09:14:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728064AbgKGIO4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 7 Nov 2020 03:14:56 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:57208 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727801AbgKGIO4 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 7 Nov 2020 03:14:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604736896; x=1636272896;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=j1x1G3XInZVmPKyvKou7aPWZB2ab3LHivJbgfaIIf1E=;
  b=O5gdys3VmVXQfy8KWcOoihCBf7O04HtITKZefJ6GZXIGFpxMYb4o6fRI
   DvrfU/yAz7aJrEktewHAnykLB4sFf6KbAcgT7L+/OpLxr8iE0xSsQYYHB
   g0z7klEA9oYocDgkdHMAwIaKTaQNGdXr3BVCqEOH3ew+BJ/0F6dNW+yIa
   zBmfzDRrSevj6AUCu+I8IhsCREISglG7ZO0R2YSwnXjMyBsFTo/xaRHK1
   5KlGV/nbogH3aaGiQm++/M6g5heEDuEZwOuaWOonrciwyVxjDMqOgLFdg
   5qzTLTft3Or0AOhXCffWnLWVhuP20zrFRI8DuXB+FT+1FrbhR0mWF+JdZ
   A==;
IronPort-SDR: EW3aluuLk7Z4tRekYUtGy5j4m3CcMVXQaVfunWN69fXn1YJhlbzgKM7hGDcH4/vHAJ1Dmz1OIq
 ojRgFRg477zUX0QMn1AOTII/pH0D0V/h91HEBSAyLYJBkuQPO44hBykoeni2U7VcpNdyLxm2Xy
 hW+2XGU82HpnvHeavIWkWLRmKrjETJVUN1jaM5hhMxIybZcThUwHHcfDx24Bq3XRtLQmehq0BS
 NEhv7x5H9Mf/tD7yAuKROeKfFHbaS2Mx9o6m/UM6G42oW4GvJJjDpoXdlCyACdDgKg6m5yl/Rb
 fSI=
X-IronPort-AV: E=Sophos;i="5.77,459,1596470400"; 
   d="scan'208";a="156564383"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Nov 2020 16:14:55 +0800
IronPort-SDR: eHB44qJE5SSb0XdQ3hx6AYXToNqzcYHyj2dsRy1RT3q2tmfVAq+EBJPn5dNP6yIjDYRrrPAr3l
 TwcWBGD7GYrgpMQafipgAuaWFn42LqQwQz/qH9fCzPxIlPj85hIU/MhnedHs8fI1Sn/9xzEdsn
 7j1xdY9XMIcMjC9yr5EUtP9p4J32KuRp26SVr6sQhNsdH8if7df+apL4ZuKXi+Yv9dLzvTOyOQ
 NVjw1fhhIVvpS6HnJ7ToKJfvA4Xm+8g3zFV+kuvaKaY0hETQzJ0lG1DZ/a5KfeaUtZJmdQgU4j
 ZqYeNPs4laTlSyaqCxEZ2vTk
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2020 23:59:46 -0800
IronPort-SDR: cDAYLC/Y3uvh8Vg5Uw/U3omgYHlJ5tgAt5xkJ+ZX3vNx/zsmJdc7c8iZKsQEVC56BhIw0O2+mu
 CUe1wghA6cqE9JUn7x46JYF4ba2yB4PZTwKhnvYYeyQ6FsYtzu4HM7uY+6w/gVTyHCZVEj+Vtz
 rJl2S0ANRS5XszYtSghrto0CMCO3RnmSogqkj8XGq6wSLeIfsfQXLhfHCR8MFhp8n+i8akiwtp
 GFd+3ctJ2PwrEMeMCpTKE3Ov1EoV0oF4ssbXK5nOmLxCGs5RscS1lhj+8aEp1DYia90vdaLsDS
 g4k=
WDCIronportException: Internal
Received: from hdrdzf2.ad.shared (HELO twashi.fujisawa.hgst.com) ([10.84.71.85])
  by uls-op-cesaip01.wdc.com with ESMTP; 07 Nov 2020 00:14:54 -0800
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
Subject: [PATCH 12/32] riscv: Automatically select sysctl config options
Date:   Sat,  7 Nov 2020 17:14:00 +0900
Message-Id: <20201107081420.60325-13-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201107081420.60325-1-damien.lemoal@wdc.com>
References: <20201107081420.60325-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

With the device tree update for the Kendryte K210 SoC, most peripherals
are now defined under one of 3 advanced power buses (apb0, apb1 and
apb2) compatible with the simple-pm-bus driver. The sysctl SoC device
is defined as a syscon/simple-mfd device. Enable the configuration
options PM, SIMPLE_PM_BUS, SYSCON and MFD_SYSCON to enable drivers for
these device tree nodes.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 arch/riscv/Kconfig.socs       |  1 +
 drivers/soc/Kconfig           |  2 +-
 drivers/soc/kendryte/Kconfig  | 19 +++++++------------
 drivers/soc/kendryte/Makefile |  2 +-
 4 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
index 8a55f6156661..e724fddc44ba 100644
--- a/arch/riscv/Kconfig.socs
+++ b/arch/riscv/Kconfig.socs
@@ -29,6 +29,7 @@ config SOC_KENDRYTE
 	select SERIAL_SIFIVE if TTY
 	select SERIAL_SIFIVE_CONSOLE if TTY
 	select SIFIVE_PLIC
+	select SOC_K210
 	help
 	  This enables support for Kendryte K210 SoC platform hardware.
 
diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
index 425ab6f7e375..f511cad87a0e 100644
--- a/drivers/soc/Kconfig
+++ b/drivers/soc/Kconfig
@@ -9,6 +9,7 @@ source "drivers/soc/bcm/Kconfig"
 source "drivers/soc/fsl/Kconfig"
 source "drivers/soc/imx/Kconfig"
 source "drivers/soc/ixp4xx/Kconfig"
+source "drivers/soc/kendryte/Kconfig"
 source "drivers/soc/mediatek/Kconfig"
 source "drivers/soc/qcom/Kconfig"
 source "drivers/soc/renesas/Kconfig"
@@ -22,6 +23,5 @@ source "drivers/soc/ux500/Kconfig"
 source "drivers/soc/versatile/Kconfig"
 source "drivers/soc/xilinx/Kconfig"
 source "drivers/soc/zte/Kconfig"
-source "drivers/soc/kendryte/Kconfig"
 
 endmenu
diff --git a/drivers/soc/kendryte/Kconfig b/drivers/soc/kendryte/Kconfig
index 49785b1b0217..11579139ede6 100644
--- a/drivers/soc/kendryte/Kconfig
+++ b/drivers/soc/kendryte/Kconfig
@@ -1,14 +1,9 @@
 # SPDX-License-Identifier: GPL-2.0
 
-if SOC_KENDRYTE
-
-config K210_SYSCTL
-	bool "Kendryte K210 system controller"
-	default y
-	depends on RISCV
-	help
-	  Enables controlling the K210 various clocks and to enable
-	  general purpose use of the extra 2MB of SRAM normally
-	  reserved for the AI engine.
-
-endif
+config SOC_K210
+	bool "Kendryte K210 SoC drivers"
+	depends on RISCV && SOC_KENDRYTE && OF
+        select PM
+        select SIMPLE_PM_BUS
+        select SYSCON
+        select MFD_SYSCON
diff --git a/drivers/soc/kendryte/Makefile b/drivers/soc/kendryte/Makefile
index 002d9ce95c0d..e67425707484 100644
--- a/drivers/soc/kendryte/Makefile
+++ b/drivers/soc/kendryte/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 
-obj-$(CONFIG_K210_SYSCTL)	+= k210-sysctl.o
+obj-$(CONFIG_SOC_K210)	+= k210-sysctl.o
-- 
2.28.0

