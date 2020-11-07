Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67F762AA365
	for <lists+linux-spi@lfdr.de>; Sat,  7 Nov 2020 09:14:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbgKGIOq (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 7 Nov 2020 03:14:46 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:57208 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727801AbgKGIOp (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 7 Nov 2020 03:14:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604736885; x=1636272885;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=I9FRj9UJZUXbJ36h9NtK7sWhZkQHQ9GoiFFCz8CrFtg=;
  b=b+uoicjH29u5OVXaeo3l/tlr0xmDcIOWiZCU3aNdSPWCdYzmOmJxzgsK
   w+p9S1012QEhpXnivYO7q7ghPnjPbNDuIbDt+dwgBg536ja5wFH0i4UIP
   CBEjs7cYKO4e/Z5jf8rdofngdmiuLvO/2ZgP846fuy2kRjPanbBB3WUPt
   d56zAZVw/BNhaYJN4mJDYXm7fsNujc94A36D2cVHtbqnpy7QkaJqzGUbE
   W7NzGqvSrQB/REJCwiqAQJoqnHMuAezetFQ1XUHDRGZXnXKqyFdnQtcT3
   U9I2PsZ1pXySPb8k1spTN3pWX9Sus/8YQP1KpZ6Q7Ih1+UyqcDtQlVLsH
   A==;
IronPort-SDR: gd50EAdFdMzA3AZBJvkyIS39FIpmxVYTyBLTTK6GHwvIVnIBIPnq4xMCooUpS2eGWoKICk1Qhg
 yMoUE5d21Ovc0XXqu76EABj/Q+6uvqsNeDPfTaOznusLtmz/kT0v6XgTzVZQ6AE2Igibp6geMG
 pwpN3TbCazuuz87pclQX71PEFcgKyQ41UtzhlSJX8DDoqBWMnobryIr4kuIgcGsib5HTbG73JO
 6dCxHYZiaJudvGWEqcQV97d+o0NCzqDaj57YiRzkScOaPeak2MuUioXnHAcFRLkVZhewwXjSHD
 45U=
X-IronPort-AV: E=Sophos;i="5.77,459,1596470400"; 
   d="scan'208";a="156564374"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Nov 2020 16:14:44 +0800
IronPort-SDR: MCX35SrBKoKEGNTKNmw3PWR7Mi/OMf/CVEw0WqyuKI/L6phDVd5afpgAxkKl0QcSIL2dRSwlX/
 GXGgxgiUWtvRXFszhbRiE0zSoENRjsOw+PVeZ2ONJipPuJnIXvmY+tCuCp18qTLCUQ4/nq+yfi
 gUr/K31QI08cfHWQYdq7uGVtKUpDn66A7k6vxWES8TWehRNsBAjAUz8dsW2x0AkBAYVtOeJ71N
 O1/Yq+SHGUrDa06Ae4QzYKpA1vECHzK86a8iUPIQZ0oMhmmLHytgMOGqGH+8Mwb3+vvWTIaz1A
 NM7UDI6LurVXOWecSoTMDGVN
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2020 23:59:36 -0800
IronPort-SDR: bsAAbPxhXeDIy1nlJsSKE+tRuqxbWo1/7u+arvpKA2lAET/QNMdr3zvocxX2jbfsbYlXs9bvEO
 Fm7DCw0P2OdyDDyO2ze8poOfGV6zbZxsnf4uvzPO/I77VGMirVUC/ruEYCZ21viQipiAvKltd4
 CSNJIPeYmHIXmXrY4IlkHjE2ulrcp5b1uv41XbSr3JQWSRW+Od422ooQBDAE/kIy/Bhs4TWrfo
 xOo9kqfar///MEnTLDERFeB6QRkOV51jFB0kQjo3ADnzaiHY9oD9YsBVThclN7rcXFYmh/0J5J
 MZs=
WDCIronportException: Internal
Received: from hdrdzf2.ad.shared (HELO twashi.fujisawa.hgst.com) ([10.84.71.85])
  by uls-op-cesaip01.wdc.com with ESMTP; 07 Nov 2020 00:14:43 -0800
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
Subject: [PATCH 08/32] riscv: Fix kernel time_init()
Date:   Sat,  7 Nov 2020 17:13:56 +0900
Message-Id: <20201107081420.60325-9-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201107081420.60325-1-damien.lemoal@wdc.com>
References: <20201107081420.60325-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

If of_clk_init() is not called in time_init(), clock providers defined
in the system device tree are not initialized, resulting in failures for
other devices to initialize due to missing clocks.
Similarly to other architectures and to the default kernel time_init()
implementation, call of_clk_init() before executing timer_probe() in
time_init().

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 arch/riscv/kernel/time.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/riscv/kernel/time.c b/arch/riscv/kernel/time.c
index 4d3a1048ad8b..8a5cf99c0776 100644
--- a/arch/riscv/kernel/time.c
+++ b/arch/riscv/kernel/time.c
@@ -4,6 +4,7 @@
  * Copyright (C) 2017 SiFive
  */
 
+#include <linux/of_clk.h>
 #include <linux/clocksource.h>
 #include <linux/delay.h>
 #include <asm/sbi.h>
@@ -24,6 +25,8 @@ void __init time_init(void)
 	riscv_timebase = prop;
 
 	lpj_fine = riscv_timebase / HZ;
+
+	of_clk_init(NULL);
 	timer_probe();
 }
 
-- 
2.28.0

