Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E777D27139C
	for <lists+linux-spi@lfdr.de>; Sun, 20 Sep 2020 13:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbgITL32 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 20 Sep 2020 07:29:28 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:53570 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbgITL30 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 20 Sep 2020 07:29:26 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id A8AFA803017F;
        Sun, 20 Sep 2020 11:29:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Wnmc5wMGlxvH; Sun, 20 Sep 2020 14:29:22 +0300 (MSK)
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Mark Brown <broonie@kernel.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        "wuxu . wu" <wuxu.wu@huawei.com>, Feng Tang <feng.tang@intel.com>,
        Rob Herring <robh+dt@kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 00/30] spi: dw: Add full Baikal-T1 SPI Controllers support
Date:   Sun, 20 Sep 2020 14:28:44 +0300
Message-ID: <20200920112914.26501-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Originally I intended to merge a dedicated Baikal-T1 System Boot SPI
Controller driver into the kernel and leave the DW APB SSI driver
untouched. But after a long discussion (see the link at the bottom of the
letter) Mark and Andy persuaded me to integrate what we developed there
into the DW APB SSI core driver to be useful for another controllers,
which may have got the same peculiarities/problems as ours:
- No IRQ.
- No DMA.
- No GPIO CS, so a native CS is utilized.
- small Tx/Rx FIFO depth.
- Automatic CS assertion/de-assertion.
- Slow system bus.
All of them have been fixed in the framework of this patchset in some
extent at least for the SPI memory operations. As I expected it wasn't
that easy and the integration took that many patches as you can see from
the subject. Though some of them are mere cleanups or weakly related with
the subject fixes, but we just couldn't leave the code as is at some
places since we were working with the DW APB SSI driver anyway. Here is
what we did to fix the original DW APB SSI driver, to make it less messy.

First two patches are just cleanups to simplify the DW APB SSI device
initialization a bit. We suggest to discard the IRQ threshold macro as
unused and use a ternary operator to initialize the set_cs callback
instead of assigning-and-updating it.

Then we've discovered that the n_bytes field of the driver private data is
used by the DW APB SSI IRQ handler, which requires it to be initialized
before the SMP memory barrier and to be visible from another CPUs. Speaking
about the SMP memory barrier. Having one right after the shared resources
initialization is enough and there is no point in using the spin-lock to
protect the Tx/Rx buffer pointers. The protection functionality is
redundant there by the driver design. (Though I have a doubt whether the
SMP memory barrier is also required there because the normal IO-methods
like readl/writel implies a full memory barrier. So any memory operations
performed before them are supposed to be seen by devices and another CPUs.
See the patch log for details of my concern.)

Thirdly we've found out that there is some confusion in the IRQs
masking/unmasking/clearing in the SPI-transfer procedure. Multiple interrupts
are unmasked on the SPI-transfer initialization, but just TXEI is only
masked back on completion. Similarly IRQ status isn't cleared on the
controller reset, which actually makes the reset being not full and errors
prone in the controller probe procedure.

Another very important optimization is using the IO-relaxed accessors in
the dw_read_io_reg()/dw_write_io_reg() methods. Since the Tx/Rx FIFO data
registers are the most frequently accessible controller resource, using
relaxed accessors there will significantly improve the data read/write
performance. At least on Baikal-T1 SoC such modification opens up a way to
have the DW APB SSI controller working with higher SPI bus speeds, than
without it.

Fifthly we've made an effort to cleanup the code using the SPI-device
private data - chip_data. We suggest to remove the chip type from there
since it isn't used and isn't implemented right anyway. Then instead of
having a bus speed, clock divider, transfer mode preserved there, and
recalculating the CR0 fields of the SPI-device-specific phase, polarity
and frame format each time the SPI transfer is requested, we can save it
in the chip_data instance. By doing so we'll make that structure finally
used as it was supposed to by design (see the spi-fsl-dspi.c, spi-pl022.c,
spi-pxa2xx.c drivers for examples).

Sixthly instead of having the SPI-transfer specific CR0-update callback,
we suggest to implement the DW APB SSI controller capabilities approach.
By doing so we can now inject the vendor-specific peculiarities in
different parts of the DW APB SSI core driver (which is required to
implement both SPI-transfers and the SPI memory operations). This will
also make the code less confusing like defining a callback in the core
driver, setting it up in the glue layer, then calling it from the core
driver again. Seeing the small capabilities implementation embedded
in-situ is more readable than tracking the callbacks assignments. This
will concern the CS-override, Keembay master setup, DW SSI-specific CR0
registers layout capabilities.

Seventhly since there are going to be two types of the transfers
implemented in the DW APB SSI core driver, we need a common method to set
the controller configuration like, Tx/Rx-mode, bus speed, data frame size
and number of data frames to read in case of the memory operations. So we
just detached the corresponding code from the SPI-transfer-one method and
made it to be a part of the new dw_spi_update_config() function, which is
former update_cr0(). Note that the new method will be also useful for the
glue drivers, which due to the hardware design need to create their own
memory operations (for instance, for the dirmap-operations provided in the
Baikal-T System Boot SPI controller driver).

Eighthly it is the data IO procedure and IRQ-based SPI-transfer
implementation refactoring. The former one will look much simpler if the
buffers initial pointers and the buffers length data utilized instead of
the Tx/Rx buffers start and end pointers. The later one currently lacks of
valid execution at the final stage of the SPI-transfer. So if there is no
data left to send, but there is still data which needs to be received, the
Tx FIFO Empty IRQ will constantly happen until all of the requested
inbound data is received. So we suggest to fix that by taking the Rx FIFO
Empty IRQ into account.

Ninthly it's potentially errors prone to enable the DW APB SSI interrupts
before enabling the chip. It specifically concerns a case if for some
reason the DW APB SSI IRQs handler is executed before the controller is
enabled. That will cause a part of the outbound data loss. So we suggest
to reverse the order.

Tenthly in order to be able to pre-initialize the Tx FIFO with data and
only the start the SPI memory operations we need to have any CS
de-activated. We'll fulfil that requirement by explicitly clearing the CS
on the SPI transfer completion and at the explicit controller reset.

Then seeing all the currently available and potentially being created
types of the SPI transfers need to perform the DW APB SSI controller
status register check and the errors handler procedure, we've created a
common method for all of them.

Eleventhly if before we've mostly had a series of fixups, cleanups and
refactorings, here we've finally come to the new functionality
implementation. It concerns the poll-based transfer (as Baikal-T1 System
Boot SPI controller lacks a dedicated IRQ lane connected) and the SPI
memory operations implementation. If the former feature is pretty much
straightforward (see the patch log for details), the later one is a bit
tricky. It's based on the EEPROM-read (write-then-read) and the Tx-only
modes of the DW APB SSI controller, which as performing the automatic data
read and write let's us to implement the faster IO procedure than using
the Tx-Rx-mode-based approach. Having the memory-operations implemented
that way is the best thing we can currently do to provide the errors-less
SPI transfers to SPI devices with native CS attached.

Note the approach utilized here to develop the SPI memory operations can
be also used to create the "automatic CS toggle problem"-free(ish) SPI
transfers (combine SPI-message transfers into two buffers, disable
interrupts, push-pull the combined data). But we don't provide a solution
in the framework of this patchset. It is a matter of a dedicated one,
which we currently don't intend to spend our time on.

Finally at the closure of the this patchset you'll find patches, which
provide the Baikal-T1-specific DW APB SSI controllers support. The SoC has
got three SPI controllers. Two of them are pretty much normal DW APB SSI
interfaces: with IRQ, DMA, FIFOs of 64 words depth, 4x CSs. But the third
one as being a part of the Baikal-T1 System Boot Controller has got a very
limited resources: no IRQ, no DMA, only a single native chip-select and
Tx/Rx FIFOs with just 8 words depth available. In order to provide a
transparent initial boot code execution the System Boot SPI Controller is
also utilized by an vendor-specific IP-block, which exposes an SPI flash
memory direct mapping interface. Please see the corresponding patch for
details.

Link: https://lore.kernel.org/linux-spi/20200508093621.31619-1-Sergey.Semin@baikalelectronics.ru/

[1] "LINUX KERNEL MEMORY BARRIERS", Documentation/memory-barriers.txt,
    Section "KERNEL I/O BARRIER EFFECTS"

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Cc: Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>
Cc: Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Lars Povlsen <lars.povlsen@microchip.com>
Cc: wuxu.wu <wuxu.wu@huawei.com>
Cc: Feng Tang <feng.tang@intel.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: linux-spi@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Serge Semin (30):
  spi: dw: Discard IRQ threshold macro
  spi: dw: Use ternary op to init set_cs callback
  spi: dw: Initialize n_bytes before the memory barrier
  Revert: spi: spi-dw: Add lock protect dw_spi rx/tx to prevent
    concurrent calls
  spi: dw: Clear IRQ status on DW SPI controller reset
  spi: dw: Disable all IRQs when controller is unused
  spi: dw: Use relaxed IO-methods to access FIFOs
  spi: dw: Discard DW SSI chip type storages
  spi: dw: Convert CS-override to DW SPI capabilities
  spi: dw: Add KeemBay Master capability
  spi: dw: Add DWC SSI capability
  spi: dw: Detach SPI device specific CR0 config method
  spi: dw: Update SPI bus speed in a config function
  spi: dw: Simplify the SPI bus speed config procedure
  spi: dw: Update Rx sample delay in the config function
  spi: dw: Add DW SPI controller config structure
  spi: dw: Refactor data IO procedure
  spi: dw: Refactor IRQ-based SPI transfer procedure
  spi: dw: Perform IRQ setup in a dedicated function
  spi: dw: Unmask IRQs after enabling the chip
  spi: dw: Discard chip enabling on DMA setup error
  spi: dw: De-assert chip-select on reset
  spi: dw: Explicitly de-assert CS on SPI transfer completion
  spi: dw: Move num-of retries parameter to the header file
  spi: dw: Add generic DW SSI status-check method
  spi: dw: Add memory operations support
  spi: dw: Introduce max mem-ops SPI bus frequency setting
  spi: dw: Add poll-based SPI transfers support
  dt-bindings: spi: dw: Add Baikal-T1 SPI Controllers
  spi: dw: Add Baikal-T1 SPI Controller glue driver

 .../bindings/spi/snps,dw-apb-ssi.yaml         |  33 +-
 drivers/spi/Kconfig                           |  29 +
 drivers/spi/Makefile                          |   1 +
 drivers/spi/spi-dw-bt1.c                      | 339 +++++++++
 drivers/spi/spi-dw-core.c                     | 642 ++++++++++++++----
 drivers/spi/spi-dw-dma.c                      |  16 +-
 drivers/spi/spi-dw-mmio.c                     |  36 +-
 drivers/spi/spi-dw.h                          |  85 ++-
 8 files changed, 960 insertions(+), 221 deletions(-)
 create mode 100644 drivers/spi/spi-dw-bt1.c

-- 
2.27.0

