Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 433472AA38B
	for <lists+linux-spi@lfdr.de>; Sat,  7 Nov 2020 09:15:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbgKGIPK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 7 Nov 2020 03:15:10 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:57208 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727860AbgKGIPK (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 7 Nov 2020 03:15:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604736909; x=1636272909;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=i3cWoJkR7yUZQNOde09o7Nwh6wMCqp2Qd3Q1TOs0x7M=;
  b=Nk9na0o/VIwbQ7dtDUh/XNdYPogWEBZt1AHAMfnpi8q1J2NpvmV9mtDZ
   s64mkDxxRfoA1RFd7NmGP4X1I0jSLd4CDhvEYusd488BBLey7i3oN5POb
   F37V3z5Mzxv/L+8Xgmvsxei4hRAYVCu/yBTugVP/tMmzK7fj88pbDpY82
   DtNvFbJDYxP/nLL0uHBKP3KNv4WCswmccy4c0KLp+qHKIAaCJ2B9jCV83
   e4qJr03gzaeMJc+cV80YZY2cU8eOCS8xF8eC/NNoW6oLyZIn+5gYRrwbm
   DS9BM1zqkaJlB4IXLLoTxlQRiLdprOMP4qcnJAyb8pAE7T/yStk3cO8RP
   g==;
IronPort-SDR: ALkElSPBg2N34XY4foVIuu6KyaY57HfPSMgPA+WCRURxyUiQJQWrbelhXXY/YWU+Pd1Wha1KH2
 EeWZgHfQNxM0zqjnTluISggKUWcoMkSY8A3B7l3rxsJKhMPBHX3T53VCx2mccJN9//dJ6jQsf0
 Hz+JyyKU/vduyjEpImr8PMoag8ohyprNKSxBm5F+wp1wTbEebzlLnFS1l7hQxvs5Y/ZgdOTjcl
 ng2GDwGNn5CNdyEfSwoxvKD/MrGzxeVapDW6xdraan3O0IMBvRzo6DSry6xRb/JUXnS6nVvYBP
 MrQ=
X-IronPort-AV: E=Sophos;i="5.77,459,1596470400"; 
   d="scan'208";a="156564397"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Nov 2020 16:15:08 +0800
IronPort-SDR: FH39SVUv08nLOxG1dKsM1eZwvx+s7dUed2GaNI+j3z+CrkbP+umQKleuOipfyeAnV+L6BrfkEU
 e6ZlVhamcu6sGe2f+3ww2ltMgR1FaoD0PR08dAEJuNoN5U71j/stxB6SPo8wjtQgYAri25d/zb
 IwiCvpGGwZoNtfXk6VSXMCJUr2PesQcOW7298QRWWvb4uShZFjS/hjmlLcoi84Nvq0SMJGsnxb
 zqzHsZ8GWit5y/+XP4jOYIZC7jg5PnQGtBmdRep79HuXoaLFIBVuXK21Z7vnNoaWU1Tfkz3j2z
 aeYGU8wA73xsnA12/noA5V3E
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2020 00:00:00 -0800
IronPort-SDR: y1qTH6RGguGSyluxLK/fBd4YoKIYIBAHDBFAdJDQnfLjUxogD/HMVQV51PGP4PWDtiHU7L5lXh
 Ks0iRlB+NUDic6UsOlYiPQeN7Sa7eXGftVRNUnS53IRichEDB5BqeldCwo72sfTn2QQDblZvWX
 RisdudAF1jcncJw0uUSGiwjWt+bVWimOOgsvFBdNd4+YimsR0TBA//fGYaan2doQ2vHP1rTsfh
 oQrdxVYyDy+UDB00awl1jR/S0/pdo6CeH33MIgTe/wg/bW5ZNjUhktJ78wfuahcIGR5Ym1N2ub
 JZA=
WDCIronportException: Internal
Received: from hdrdzf2.ad.shared (HELO twashi.fujisawa.hgst.com) ([10.84.71.85])
  by uls-op-cesaip01.wdc.com with ESMTP; 07 Nov 2020 00:15:07 -0800
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
Subject: [PATCH 17/32] dt-bindings: Define Kendryte K210 reset signals
Date:   Sat,  7 Nov 2020 17:14:05 +0900
Message-Id: <20201107081420.60325-18-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201107081420.60325-1-damien.lemoal@wdc.com>
References: <20201107081420.60325-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Introduce the dt-bindings file include/dt-bindings/reset/k210_sysctl.h
to define IDs for all 30 reset signals available on the Kendryte K210
RISC-V SoC.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 include/dt-bindings/reset/k210-rst.h | 42 ++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 include/dt-bindings/reset/k210-rst.h

diff --git a/include/dt-bindings/reset/k210-rst.h b/include/dt-bindings/reset/k210-rst.h
new file mode 100644
index 000000000000..883c1aed50e8
--- /dev/null
+++ b/include/dt-bindings/reset/k210-rst.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2019 Sean Anderson <seanga2@gmail.com>
+ * Copyright (c) 2020 Western Digital Corporation or its affiliates.
+ */
+#ifndef RESET_K210_SYSCTL_H
+#define RESET_K210_SYSCTL_H
+
+/*
+ * Kendryte K210 SoC system controller K210_SYSCTL_SOFT_RESET register bits.
+ * Taken from Kendryte SDK (kendryte-standalone-sdk).
+ */
+#define K210_RST_ROM	0
+#define K210_RST_DMA	1
+#define K210_RST_AI	2
+#define K210_RST_DVP	3
+#define K210_RST_FFT	4
+#define K210_RST_GPIO	5
+#define K210_RST_SPI0	6
+#define K210_RST_SPI1	7
+#define K210_RST_SPI2	8
+#define K210_RST_SPI3	9
+#define K210_RST_I2S0	10
+#define K210_RST_I2S1	11
+#define K210_RST_I2S2	12
+#define K210_RST_I2C0	13
+#define K210_RST_I2C1	14
+#define K210_RST_I2C2	15
+#define K210_RST_UART1	16
+#define K210_RST_UART2	17
+#define K210_RST_UART3	18
+#define K210_RST_AES	19
+#define K210_RST_FPIOA	20
+#define K210_RST_TIMER0	21
+#define K210_RST_TIMER1	22
+#define K210_RST_TIMER2	23
+#define K210_RST_WDT0	24
+#define K210_RST_WDT1	25
+#define K210_RST_SHA	26
+#define K210_RST_RTC	29
+
+#endif /* RESET_K210_SYSCTL_H */
-- 
2.28.0

