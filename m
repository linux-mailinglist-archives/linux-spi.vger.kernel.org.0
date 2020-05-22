Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19F7F1DDBA3
	for <lists+linux-spi@lfdr.de>; Fri, 22 May 2020 02:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730224AbgEVAI0 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 21 May 2020 20:08:26 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:41122 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729771AbgEVAIZ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 21 May 2020 20:08:25 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 124508030776;
        Fri, 22 May 2020 00:08:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id FhwTsYRa_w4h; Fri, 22 May 2020 03:08:17 +0300 (MSK)
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
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>, <linux-mips@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 00/16] spi: dw: Add generic DW DMA controller support
Date:   Fri, 22 May 2020 03:07:49 +0300
Message-ID: <20200522000806.7381-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Baikal-T1 SoC provides a DW DMA controller to perform low-speed peripherals
Mem-to-Dev and Dev-to-Mem transaction. This is also applicable to the DW
APB SSI devices embedded into the SoC. Currently the DMA-based transfers
are supported by the DW APB SPI driver only as a middle layer code for
Intel MID/Elkhart PCI devices. Seeing the same code can be used for normal
platform DMAC device we introduced a set of patches to fix it within this
series.

First of all we need to add the Tx and Rx DMA channels support into the DW
APB SSI binding. Then there are several fixes and cleanups provided as a
initial preparation for the Generic DMA support integration: add Tx/Rx
finish wait methods, clear DMAC register when done or stopped, Fix native
CS being unset, enable interrupts in accordance with DMA xfer mode,
discard static DW DMA slave structures, discard unused void priv pointer
and dma_width member of the dw_spi structure, provide the DMA Tx/Rx burst
length parametrisation and make sure it's optionally set in accordance
with the DMA max-burst capability.

In order to have the DW APB SSI MMIO driver working with DMA we need to
initialize the paddr field with the physical base address of the DW APB SSI
registers space. Then we unpin the Intel MID specific code from the
generic DMA one and placed it into the spi-dw-pci.c driver, which is a
better place for it anyway. After that the naming cleanups are performed
since the code is going to be used for a generic DMAC device. Finally the
Generic DMA initialization can be added to the generic version of the
DW APB SSI IP.

Last but not least we traditionally convert the legacy plain text-based
dt-binding file with yaml-based one and as a cherry on a cake replace
the manually written DebugFS registers read method with a ready-to-use
for the same purpose regset32 DebugFS interface usage.

This patchset is rebased and tested on the spi/for-next (5.7-rc5):
base-commit: fe9fce6b2cf3 ("Merge remote-tracking branch 'spi/for-5.8' into spi-next")

Link: https://lore.kernel.org/linux-spi/20200508132943.9826-1-Sergey.Semin@baikalelectronics.ru/
Changelog v2:
- Rebase on top of the spi repository for-next branch.
- Move bindings conversion patch to the tail of the series.
- Move fixes to the head of the series.
- Apply as many changes as possible to be applied the Generic DMA
  functionality support is added and the spi-dw-mid is moved to the
  spi-dw-dma driver.
- Discard patch "spi: dw: Fix dma_slave_config used partly uninitialized"
  since the problem has already been fixed.
- Add new patch "spi: dw: Discard unused void priv pointer".
- Add new patch "spi: dw: Discard dma_width member of the dw_spi structure".
  n_bytes member of the DW SPI data can be used instead.
- Build the DMA functionality into the DW APB SSI core if required instead
  of creating a separate kernel module.
- Use conditional statement instead of the ternary operator in the ref
  clock getter.

Link: https://lore.kernel.org/linux-spi/20200515104758.6934-1-Sergey.Semin@baikalelectronics.ru/
Changelog v3:
- Use spi_delay_exec() method to wait for the DMA operation completion.
- Explicitly initialize the dw_dma_slave members on stack.
- Discard the dws->fifo_len utilization in the Tx FIFO DMA threshold
  setting from the patch where we just add the default burst length
  constants.
- Use min() method to calculate the optimal burst values.
- Add new patch which moves the spi-dw.c source file to spi-dw-core.c in
  order to preserve the DW APB SSI core driver name.
- Add commas in the debugfs_reg32 structure initializer and after the last
  entry of the dw_spi_dbgfs_regs array.

Link: https://lore.kernel.org/linux-spi/20200521012206.14472-1-Sergey.Semin@baikalelectronics.ru
Changelog v4:
- Get back ndelay() method to wait for an SPI transfer completion.
  spi_delay_exec() isn't suitable for the atomic context.

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
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: linux-mips@vger.kernel.org
Cc: linux-spi@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Serge Semin (16):
  spi: dw: Add Tx/Rx finish wait methods to the MID DMA
  spi: dw: Enable interrupts in accordance with DMA xfer mode
  spi: dw: Discard static DW DMA slave structures
  spi: dw: Discard unused void priv pointer
  spi: dw: Discard dma_width member of the dw_spi structure
  spi: dw: Parameterize the DMA Rx/Tx burst length
  spi: dw: Use DMA max burst to set the request thresholds
  spi: dw: Fix Rx-only DMA transfers
  spi: dw: Add core suffix to the DW APB SSI core source file
  spi: dw: Move Non-DMA code to the DW PCIe-SPI driver
  spi: dw: Remove DW DMA code dependency from DW_DMAC_PCI
  spi: dw: Add DW SPI DMA/PCI/MMIO dependency on the DW SPI core
  spi: dw: Cleanup generic DW DMA code namings
  spi: dw: Add DMA support to the DW SPI MMIO driver
  spi: dw: Use regset32 DebugFS method to create regdump file
  dt-bindings: spi: Convert DW SPI binding to DT schema

 .../bindings/spi/snps,dw-apb-ssi.txt          |  44 ---
 .../bindings/spi/snps,dw-apb-ssi.yaml         | 127 +++++++++
 .../devicetree/bindings/spi/spi-dw.txt        |  24 --
 drivers/spi/Kconfig                           |  15 +-
 drivers/spi/Makefile                          |   5 +-
 drivers/spi/{spi-dw.c => spi-dw-core.c}       |  88 ++----
 drivers/spi/{spi-dw-mid.c => spi-dw-dma.c}    | 261 ++++++++++--------
 drivers/spi/spi-dw-mmio.c                     |   4 +
 drivers/spi/spi-dw-pci.c                      |  50 +++-
 drivers/spi/spi-dw.h                          |  33 ++-
 10 files changed, 392 insertions(+), 259 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
 create mode 100644 Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
 delete mode 100644 Documentation/devicetree/bindings/spi/spi-dw.txt
 rename drivers/spi/{spi-dw.c => spi-dw-core.c} (82%)
 rename drivers/spi/{spi-dw-mid.c => spi-dw-dma.c} (55%)

-- 
2.25.1

