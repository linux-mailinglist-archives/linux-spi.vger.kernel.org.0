Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09E421CB053
	for <lists+linux-spi@lfdr.de>; Fri,  8 May 2020 15:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbgEHNaL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 8 May 2020 09:30:11 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:42708 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbgEHNaK (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 8 May 2020 09:30:10 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 3BFDC80307C7;
        Fri,  8 May 2020 13:30:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id O3E0BWa4NuBz; Fri,  8 May 2020 16:30:06 +0300 (MSK)
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Allison Randal <allison@lohutok.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        <linux-mips@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 02/17] dt-bindings: spi: dw: Add DMA properties bindings
Date:   Fri, 8 May 2020 16:29:27 +0300
Message-ID: <20200508132943.9826-3-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20200508132943.9826-1-Sergey.Semin@baikalelectronics.ru>
References: <20200508132943.9826-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Since DW SPI controller may use DW DMA engine to perform the CPU-less
Tx/Rx SPI transfers and the DW SPI driver now supports it, lets alter
the DW SPI bindings file to accept the Rx and Tx DMA line specifiers.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc: Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>
Cc: Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>
Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Paul Burton <paulburton@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Allison Randal <allison@lohutok.net>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Gareth Williams <gareth.williams.jx@renesas.com>
Cc: linux-mips@vger.kernel.org
---
 .../devicetree/bindings/spi/snps,dw-apb-ssi.yaml       | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
index e2f6d8aa6181..454208842084 100644
--- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
+++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
@@ -73,6 +73,16 @@ properties:
     minimum: 1
     maximum: 4
 
+  dmas:
+    items:
+      - description: TX DMA Channel
+      - description: RX DMA Channel
+
+  dma-names:
+    items:
+      - const: tx
+      - const: rx
+
 patternProperties:
   "^.*@[0-9a-f]+$":
     type: object
-- 
2.25.1

