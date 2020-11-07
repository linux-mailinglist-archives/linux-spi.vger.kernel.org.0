Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D30902AA381
	for <lists+linux-spi@lfdr.de>; Sat,  7 Nov 2020 09:15:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728091AbgKGIPC (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 7 Nov 2020 03:15:02 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:57208 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728090AbgKGIPB (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 7 Nov 2020 03:15:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604736901; x=1636272901;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jRSYrT/nCX22lvm9yKoOPpqudn5ve7/gRn0IuSGz6SI=;
  b=NcikV2SNwrUYlT7TqG2FFY4WprNZJ5gZTykrEmBCp882gSRDIH75aeBV
   almNFsrpIyWNJdgtgd7nURad1l/5er66DwEz06NCzzJuTUp3mDOl7fmu1
   r09XRVdGG5mRd7BjeCO/Tmy1Seqi2AI6EgGZ+eQTobi8F0L5cz0W5PG83
   E3AVr+jjCCAF5M2NqBD+3xOLoOAqyvFKHP794/iPItdlBezSP2B5iakRN
   9+pYA25klZm4M7mU44jiitx8I9uzRAtB10Fs/dl1IEQWX3i6/b87PaZaZ
   qLIKPVfmCy9Jr2VpAifE8zqs7HCLm+QMajOxp15salwQhdPixkWBtAhAB
   Q==;
IronPort-SDR: wSDsvFCy7sUcgWl2WX+4TWKk4kl+PU6mztTezKtc2gsQ62dV2GZoHPFRzus3nH2CRaxsSeuGCD
 L9grIWk20c3qz33qbm6VLqIlLc2mVJdASW/Ih+43DyscuCCY2uce8i28ki1977je7NMv7XrQ9g
 agW+L/MMv92dmLUpSHQVxzrRA0Ggzd1MqfGlGLQ5onVq3i671Q2lGDxlBHIsNysYJsryC2UwTs
 1Rlevwe+Qfk5LTJzIoJWs2IyhILdV0Y4hRQo5HDEF93/BH4LyOMC7hAgxAhe6LH+8AmT4uNnoJ
 kBg=
X-IronPort-AV: E=Sophos;i="5.77,459,1596470400"; 
   d="scan'208";a="156564390"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Nov 2020 16:15:01 +0800
IronPort-SDR: gr2pWvP+sHb0rlHLAxQ/BqwbF9/TI5akbxBqDmE4+9MFtFIp9QsnhqvkTVOmgbiRgNlXlHd8tZ
 vobzXWe/PSTBBHAeDvlECC+5jzo9bFJiKsbf2+S/bXRN36/SVPH2rla86KVK4fTakUQNT5kN+2
 Ry92zYsfagF0HG5Wt88/9Pj5WRZi0e/xQd8Ngp6zU0Dd1kyFQzNtk+yaUe97GEVCDszXimYoUI
 Lb7BRaOIEwE/VKm9FXqmV0npfXaCpKOWa6rKHZh7XTOPb5E3cBHKIIPPWBECTiOvI/pNzDvsfM
 Ydkv6Smo4IhH8JxgA9x7CWGs
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2020 23:59:52 -0800
IronPort-SDR: J9xCovqu/4T/JaWxZz1AtZJvqQHZI5qpvSqLOujLeGbPzdAeuQZP6yLNgd/KWnxsBqE5HBJdUk
 T9yoxH4vjhUKe+qJ6JA+oduAnkHAcKyCJxRji/atsQXUx5AEcs/IMRduZBCzHq8JeDUrKkEo7o
 3oDZSNdeR86mEFf8ezM/q6Cl04GqBsKwvZh/KZ+s7ayI/b7ind5+X4Bva/1cl9uQJITgTdjjW2
 u0tJiX2KgomnddlAuf3ZSB/4fG9J2C2ArzR88FKk4Xk4B4BwxnCdLVoCwyNdvqJDZpxkKYozUA
 VPg=
WDCIronportException: Internal
Received: from hdrdzf2.ad.shared (HELO twashi.fujisawa.hgst.com) ([10.84.71.85])
  by uls-op-cesaip01.wdc.com with ESMTP; 07 Nov 2020 00:14:59 -0800
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
Subject: [PATCH 14/32] dt-bindings: Define all Kendryte K210 clock IDs
Date:   Sat,  7 Nov 2020 17:14:02 +0900
Message-Id: <20201107081420.60325-15-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201107081420.60325-1-damien.lemoal@wdc.com>
References: <20201107081420.60325-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Define unique arbitrary IDs for all 44 clocks available on the Kendryte
K210 RISC-V SoC in the header file include/dt-bindings/clock/k210-clk.h.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 include/dt-bindings/clock/k210-clk.h | 61 +++++++++++++++++++++++-----
 1 file changed, 50 insertions(+), 11 deletions(-)

diff --git a/include/dt-bindings/clock/k210-clk.h b/include/dt-bindings/clock/k210-clk.h
index 5a2fd64d1a49..8d7ab2f0737c 100644
--- a/include/dt-bindings/clock/k210-clk.h
+++ b/include/dt-bindings/clock/k210-clk.h
@@ -3,18 +3,57 @@
  * Copyright (C) 2019-20 Sean Anderson <seanga2@gmail.com>
  * Copyright (c) 2020 Western Digital Corporation or its affiliates.
  */
-#ifndef K210_CLK_H
-#define K210_CLK_H
+#ifndef CLOCK_K210_CLK_H
+#define CLOCK_K210_CLK_H
 
 /*
- * Arbitrary identifiers for clocks.
- * The structure is: in0 -> pll0 -> aclk -> cpu
- *
- * Since we use the hardware defaults for now, set all these to the same clock.
+ * Kendryte K210 SoC clock identifiers (arbitrary values).
  */
-#define K210_CLK_PLL0   0
-#define K210_CLK_PLL1   0
-#define K210_CLK_ACLK   0
-#define K210_CLK_CPU    0
+#define K210_CLK_IN0	0
+#define K210_CLK_PLL0	1
+#define K210_CLK_PLL1	2
+#define K210_CLK_PLL2	3
+#define K210_CLK_ACLK	4
+#define K210_CLK_CPU	5
+#define K210_CLK_CLINT	6
+#define K210_CLK_DMA	7
+#define K210_CLK_FFT	8
+#define K210_CLK_SRAM0	9
+#define K210_CLK_SRAM1	10
+#define K210_CLK_ROM	11
+#define K210_CLK_DVP	12
+#define K210_CLK_APB0	13
+#define K210_CLK_APB1	14
+#define K210_CLK_APB2	15
+#define K210_CLK_AI	16
+#define K210_CLK_I2S0	17
+#define K210_CLK_I2S1	18
+#define K210_CLK_I2S2	19
+#define K210_CLK_I2S0_M	20
+#define K210_CLK_I2S1_M	21
+#define K210_CLK_I2S2_M	22
+#define K210_CLK_WDT0	23
+#define K210_CLK_WDT1	24
+#define K210_CLK_SPI0	25
+#define K210_CLK_SPI1	26
+#define K210_CLK_SPI2	27
+#define K210_CLK_I2C0	28
+#define K210_CLK_I2C1	29
+#define K210_CLK_I2C2	30
+#define K210_CLK_SPI3	31
+#define K210_CLK_TIMER0	32
+#define K210_CLK_TIMER1	33
+#define K210_CLK_TIMER2	34
+#define K210_CLK_GPIO	35
+#define K210_CLK_UART1	36
+#define K210_CLK_UART2	37
+#define K210_CLK_UART3	38
+#define K210_CLK_FPIOA	39
+#define K210_CLK_SHA	40
+#define K210_CLK_AES	41
+#define K210_CLK_OTP	42
+#define K210_CLK_RTC	43
 
-#endif /* K210_CLK_H */
+#define K210_NUM_CLKS	44
+
+#endif /* CLOCK_K210_CLK_H */
-- 
2.28.0

