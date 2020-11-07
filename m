Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6550E2AA384
	for <lists+linux-spi@lfdr.de>; Sat,  7 Nov 2020 09:15:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728099AbgKGIPF (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 7 Nov 2020 03:15:05 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:57208 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727989AbgKGIPF (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 7 Nov 2020 03:15:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604736904; x=1636272904;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OwEcAaLGKLikEV3IIKilCFTJ3PqrOw5/ZYDF2ZHGjzw=;
  b=AbphSkPw9aK9Mg28zlPcfgh1sqA43m7F4yPLqd/nRt2F1xCVTj2BLugq
   cuoTd65bLtSF3eyDm4E65s13bmlg884kh8598pHuFvFqzicubuLcGFLuS
   sFbQldRHKj6qUD8T3Od2g2OY0SA3wm8g4FxG+W43COJFI1pDCOQZYSTYK
   RtQuFAA4yD9Wi6stxKQLyf1PpmLJM3YystImmFe71DUKeucZp6cZHSkY1
   hd0NfIpzjPfZvtoA+1zM5oK/aUwrAurFhEgBqEuL+zet+yLibEuTdC/IV
   ziqrxETrTJppuRaxohpOJqh7wk1IZeTzJg/hOJ1qstCOL5/t62i+hd7gP
   A==;
IronPort-SDR: YiI4xf/iOl0OwFvRlXm4J5U+urLwgHhzwtG1XV+n6dvw8MnkzZmzVJxnDBhPuLRXVAXaqXgxfZ
 An4asaQ19XvLa8AwWiwSw6Ww/hGxfwxKRf6wYKOycD8TUj3bP5PY60mz9XoWC/iHIEz0kH7eG7
 Lq7laChix6YpS0c4yDMFEjmc+t1nhlwyYQ8DYKdybdXdSffil8uMfBP1EOSzG6Wk2OkE51kvdg
 jyBVS+Ml/S6ZNgRMNajrhypwmLgZK4c4184ZkJ4a4CIoBkRchkLju2amu0tqwdw186yHOXOFWm
 FKM=
X-IronPort-AV: E=Sophos;i="5.77,459,1596470400"; 
   d="scan'208";a="156564392"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Nov 2020 16:15:03 +0800
IronPort-SDR: taG2sS+61Tfoy1/9YQZ8YdW2Q8g/1PpSM7cqVhzq6hH1/Owv1AaX5onQ1uyecI5GiLfO6OGd5R
 QvMSoV0rWxvEEzvwwleCpiE8IgtaXKmgkSEBzK9RvrEdFSfeNEiD8AvNh/z/udsejhsgQSysim
 Bv5RxCfPfhnEVwqzDIBjtF+Ktk+Kr/tq/wfmZRN8lebUisWXtXwJO6KNFOrD1A7Ag8EwAl4Hjr
 dZftZvsmD++0aD3It9s5Wco89SV/cFxaHYrPY1dZqvWnZE3GifitCdXcH1lQADOws88Bs/0LVw
 XF1YTt0qRqJ8JOoGBqLN287+
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2020 23:59:54 -0800
IronPort-SDR: dNzPwHeL0Y0HsdiO5RbgCWw5NbkvUs09f6HACXWVf3uJo62lGJ18zW3AULbXxjvfEzay/Fqiwj
 Ti4+Ok/5odPXKfyMVNpuPjkqrE0h6iYvNW/XFzgzAudOb9azkDYhuoVU3gNaBud4vKouOyh8Ao
 DrOaW4Ehk2wpJWepXLnw/skilL/a32bxsfTF7tGMtyNhq8nCh3Qzod393PXKbPzMdCRs0lBJgv
 W2WN0Mnas1krFdeveG2FIWFXpUGtHlF+BOmSXXiadqXLPo9q7LUQyxDO+5rdR2G7O8VmOwiavJ
 lQ0=
WDCIronportException: Internal
Received: from hdrdzf2.ad.shared (HELO twashi.fujisawa.hgst.com) ([10.84.71.85])
  by uls-op-cesaip01.wdc.com with ESMTP; 07 Nov 2020 00:15:02 -0800
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
Subject: [PATCH 15/32] dt-bindings: Define Kendryte K210 sysctl registers
Date:   Sat,  7 Nov 2020 17:14:03 +0900
Message-Id: <20201107081420.60325-16-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201107081420.60325-1-damien.lemoal@wdc.com>
References: <20201107081420.60325-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Introduce the dt-bindings file include/dt-bindings/mfd/k210_sysctl.h to
define the offset of all registers of the K210 system controller.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 include/dt-bindings/mfd/k210-sysctl.h | 41 +++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 include/dt-bindings/mfd/k210-sysctl.h

diff --git a/include/dt-bindings/mfd/k210-sysctl.h b/include/dt-bindings/mfd/k210-sysctl.h
new file mode 100644
index 000000000000..5cc386d3c9ca
--- /dev/null
+++ b/include/dt-bindings/mfd/k210-sysctl.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2020 Sean Anderson <seanga2@gmail.com>
+ * Copyright (c) 2020 Western Digital Corporation or its affiliates.
+ */
+#ifndef MFD_K210_SYSCTL_H
+#define MFD_K210_SYSCTL_H
+
+/*
+ * Kendryte K210 SoC system controller registers offsets.
+ * Taken from Kendryte SDK (kendryte-standalone-sdk).
+ */
+#define K210_SYSCTL_GIT_ID	0x00 /* Git short commit id */
+#define K210_SYSCTL_UART_BAUD	0x04 /* Default UARTHS baud rate */
+#define K210_SYSCTL_PLL0	0x08 /* PLL0 controller */
+#define K210_SYSCTL_PLL1	0x0C /* PLL1 controller */
+#define K210_SYSCTL_PLL2	0x10 /* PLL2 controller */
+#define K210_SYSCTL_PLL_LOCK	0x18 /* PLL lock tester */
+#define K210_SYSCTL_ROM_ERROR	0x1C /* AXI ROM detector */
+#define K210_SYSCTL_SEL0	0x20 /* Clock select controller 0 */
+#define K210_SYSCTL_SEL1	0x24 /* Clock select controller 1 */
+#define K210_SYSCTL_EN_CENT	0x28 /* Central clock enable */
+#define K210_SYSCTL_EN_PERI	0x2C /* Peripheral clock enable */
+#define K210_SYSCTL_SOFT_RESET	0x30 /* Soft reset ctrl */
+#define K210_SYSCTL_PERI_RESET	0x34 /* Peripheral reset controller */
+#define K210_SYSCTL_THR0	0x38 /* Clock threshold controller 0 */
+#define K210_SYSCTL_THR1	0x3C /* Clock threshold controller 1 */
+#define K210_SYSCTL_THR2	0x40 /* Clock threshold controller 2 */
+#define K210_SYSCTL_THR3	0x44 /* Clock threshold controller 3 */
+#define K210_SYSCTL_THR4	0x48 /* Clock threshold controller 4 */
+#define K210_SYSCTL_THR5	0x4C /* Clock threshold controller 5 */
+#define K210_SYSCTL_THR6	0x50 /* Clock threshold controller 6 */
+#define K210_SYSCTL_MISC	0x54 /* Miscellaneous controller */
+#define K210_SYSCTL_PERI	0x58 /* Peripheral controller */
+#define K210_SYSCTL_SPI_SLEEP	0x5C /* SPI sleep controller */
+#define K210_SYSCTL_RESET_STAT	0x60 /* Reset source status */
+#define K210_SYSCTL_DMA_SEL0	0x64 /* DMA handshake selector 0 */
+#define K210_SYSCTL_DMA_SEL1	0x68 /* DMA handshake selector 1 */
+#define K210_SYSCTL_POWER_SEL	0x6C /* IO Power Mode Select controller */
+
+#endif /* MFD_K210_SYSCTL_H */
-- 
2.28.0

