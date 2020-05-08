Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4A991CB049
	for <lists+linux-spi@lfdr.de>; Fri,  8 May 2020 15:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbgEHNaA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 8 May 2020 09:30:00 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:42646 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbgEHN37 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 8 May 2020 09:29:59 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 6F18F80307C1;
        Fri,  8 May 2020 13:29:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Irx0MX0McIdz; Fri,  8 May 2020 16:29:54 +0300 (MSK)
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Mark Brown <broonie@kernel.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Maxim Kaurkin <Maxim.Kaurkin@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Ekaterina Skachko <Ekaterina.Skachko@baikalelectronics.ru>,
        Vadim Vlasov <V.Vlasov@baikalelectronics.ru>,
        Alexey Kolotnikov <Alexey.Kolotnikov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Allison Randal <allison@lohutok.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Rob Herring <robh+dt@kernel.org>, <linux-mips@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 00/17] spi: dw: Add generic DW DMA controller support
Date:   Fri, 8 May 2020 16:29:25 +0300
Message-ID: <20200508132943.9826-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Baikal-T1 SoC provides DW DMA controller to perform low-speed peripherals
Mem-to-Dev and Dev-to-Mem transaction. This is also applicable to the DW
APB SSI devices embedded into the SoC. Currently this type DMA device is
supported by the DW APB SPI driver only as a middle layer code for Intel
MID PCI devices. Seeing the same code can be used for normal platform
DW DMAC device we introduced a set of patches to fix it within this
patchset.

First of all traditionally we replaced the legacy plain text-based dt-binding
file with yaml-based one. Then we unpinned the Intel MID specific code from
the generic DMA one and placed it into the spi-dw-pci.c driver, which was a
better place for it anyway. Then we introduced a set of naming cleanups since
the code was going to be used for generic DW DMAC device and DMAC usage
alterations to handle the controller functionality in a generic way by the
DW APB SSI MMIO driver as well. See the individual patches commit messages
for details.

In addition we fixed a problem in the native chip-select method, which despite
of multiple attempts to be fixed doesn't correctly perceive the SPI_CS_HIGH
flag and the enable-argument.

Finally as a cherry on a cake we replaced the manually written DebugFS
registers read method with a ready-to-use for the same purpose regset32
DebugFS interface usage.

This patchset is rebased and tested on the mainline Linux kernel 5.7-rc4:
0e698dfa2822 ("Linux 5.7-rc4")
tag: v5.7-rc4

Co-developed-by: Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>
Signed-off-by: Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>
Co-developed-by: Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>
Signed-off-by: Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>
Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Cc: Maxim Kaurkin <Maxim.Kaurkin@baikalelectronics.ru>
Cc: Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>
Cc: Ekaterina Skachko <Ekaterina.Skachko@baikalelectronics.ru>
Cc: Vadim Vlasov <V.Vlasov@baikalelectronics.ru>
Cc: Alexey Kolotnikov <Alexey.Kolotnikov@baikalelectronics.ru>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Paul Burton <paulburton@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Allison Randal <allison@lohutok.net>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Gareth Williams <gareth.williams.jx@renesas.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: linux-mips@vger.kernel.org
Cc: linux-spi@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Serge Semin (17):
  dt-bindings: spi: Convert DW SPI binding to DT schema
  dt-bindings: spi: dw: Add DMA properties bindings
  spi: dw: Split up the generic DMA code and Intel MID driver
  spi: dw: Cleanup generic DW DMA code namings
  spi: dw: Discard static DW DMA slave structures
  spi: dw: Add DW SPI DMA/PCI/MMIO dependency on DW SPI core
  spi: dw: Add Tx/Rx finish wait methods to DMA
  spi: dw: Clear DMAC register when done or stopped
  spi: dw: Enable interrupts in accordance with DMA xfer mode
  spi: dw: Parameterize the DMA Rx/Tx burst length
  spi: dw: Fix native CS being unset
  spi: dw: Fix dma_slave_config used partly uninitialized
  spi: dw: Initialize paddr in DW SPI MMIO private data
  spi: dw: Add DMA support to the DW SPI MMIO driver
  spi: dw: Use DMA max burst to set the request thresholds
  spi: dw: Fix Rx-only DMA transfers
  spi: dw: Use regset32 DebugFS method to create a registers file

 .../bindings/spi/snps,dw-apb-ssi.txt          |  41 ---
 .../bindings/spi/snps,dw-apb-ssi.yaml         | 123 +++++++++
 .../devicetree/bindings/spi/spi-dw.txt        |  24 --
 drivers/spi/Kconfig                           |  16 +-
 drivers/spi/Makefile                          |   4 +-
 drivers/spi/{spi-dw-mid.c => spi-dw-dma.c}    | 237 ++++++++++++------
 drivers/spi/spi-dw-mmio.c                     |  15 +-
 drivers/spi/spi-dw-pci.c                      |  38 ++-
 drivers/spi/spi-dw.c                          |  89 +++----
 drivers/spi/spi-dw.h                          |  27 +-
 10 files changed, 402 insertions(+), 212 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
 create mode 100644 Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
 delete mode 100644 Documentation/devicetree/bindings/spi/spi-dw.txt
 rename drivers/spi/{spi-dw-mid.c => spi-dw-dma.c} (53%)

-- 
2.25.1

