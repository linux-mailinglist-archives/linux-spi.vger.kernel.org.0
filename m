Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 462EF1E7EA6
	for <lists+linux-spi@lfdr.de>; Fri, 29 May 2020 15:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbgE2N2Z (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 29 May 2020 09:28:25 -0400
Received: from mga14.intel.com ([192.55.52.115]:29787 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726549AbgE2N2Z (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 29 May 2020 09:28:25 -0400
IronPort-SDR: QFMzlWVV9gu/4KcBOVGh5v2I8G3iz3I5b2Ro3agD9k+/4lK4ea/sG1lzePDL49quwk37Zi8wAc
 z7+OUg8x8ccg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2020 06:27:53 -0700
IronPort-SDR: cA+BucQzZeLIfs/tSI/C39At1sHwgt9TW3geV63sMlmZpjHfaHWUg93O3YYiBL044lyiMcdscd
 lT9KxA1ArQ4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,448,1583222400"; 
   d="scan'208";a="443389518"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga005.jf.intel.com with ESMTP; 29 May 2020 06:27:49 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jef39-009ce1-V3; Fri, 29 May 2020 16:27:51 +0300
Date:   Fri, 29 May 2020 16:27:51 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Mark Brown <broonie@kernel.org>,
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
        Arnd Bergmann <arnd@arndb.de>, Feng Tang <feng.tang@intel.com>,
        Rob Herring <robh+dt@kernel.org>, linux-mips@vger.kernel.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 00/16] spi: dw: Add generic DW DMA controller support
Message-ID: <20200529132751.GR1634618@smile.fi.intel.com>
References: <20200529131205.31838-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200529131205.31838-1-Sergey.Semin@baikalelectronics.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, May 29, 2020 at 04:11:49PM +0300, Serge Semin wrote:
> Baikal-T1 SoC provides a DW DMA controller to perform low-speed peripherals
> Mem-to-Dev and Dev-to-Mem transaction. This is also applicable to the DW
> APB SSI devices embedded into the SoC. Currently the DMA-based transfers
> are supported by the DW APB SPI driver only as a middle layer code for
> Intel MID/Elkhart PCI devices. Seeing the same code can be used for normal
> platform DMAC device we introduced a set of patches to fix it within this
> series.
> 
> First of all we need to add the Tx and Rx DMA channels support into the DW
> APB SSI binding. Then there are several fixes and cleanups provided as a
> initial preparation for the Generic DMA support integration: add Tx/Rx
> finish wait methods, clear DMAC register when done or stopped, Fix native
> CS being unset, enable interrupts in accordance with DMA xfer mode,
> discard static DW DMA slave structures, discard unused void priv pointer
> and dma_width member of the dw_spi structure, provide the DMA Tx/Rx burst
> length parametrisation and make sure it's optionally set in accordance
> with the DMA max-burst capability.
> 
> In order to have the DW APB SSI MMIO driver working with DMA we need to
> initialize the paddr field with the physical base address of the DW APB SSI
> registers space. Then we unpin the Intel MID specific code from the
> generic DMA one and placed it into the spi-dw-pci.c driver, which is a
> better place for it anyway. After that the naming cleanups are performed
> since the code is going to be used for a generic DMAC device. Finally the
> Generic DMA initialization can be added to the generic version of the
> DW APB SSI IP.
> 
> Last but not least we traditionally convert the legacy plain text-based
> dt-binding file with yaml-based one and as a cherry on a cake replace
> the manually written DebugFS registers read method with a ready-to-use
> for the same purpose regset32 DebugFS interface usage.
> 
> This patchset is rebased and tested on the spi/for-next (5.7-rc5):
> base-commit: fe9fce6b2cf3 ("Merge remote-tracking branch 'spi/for-5.8' into spi-next")

Mark, I leave few first patches for you to decide if it's right thing to do.
So, if you are okay, I'm not against them, thanks!

> Link: https://lore.kernel.org/linux-spi/20200508132943.9826-1-Sergey.Semin@baikalelectronics.ru/
> Changelog v2:
> - Rebase on top of the spi repository for-next branch.
> - Move bindings conversion patch to the tail of the series.
> - Move fixes to the head of the series.
> - Apply as many changes as possible to be applied the Generic DMA
>   functionality support is added and the spi-dw-mid is moved to the
>   spi-dw-dma driver.
> - Discard patch "spi: dw: Fix dma_slave_config used partly uninitialized"
>   since the problem has already been fixed.
> - Add new patch "spi: dw: Discard unused void priv pointer".
> - Add new patch "spi: dw: Discard dma_width member of the dw_spi structure".
>   n_bytes member of the DW SPI data can be used instead.
> - Build the DMA functionality into the DW APB SSI core if required instead
>   of creating a separate kernel module.
> - Use conditional statement instead of the ternary operator in the ref
>   clock getter.
> 
> Link: https://lore.kernel.org/linux-spi/20200515104758.6934-1-Sergey.Semin@baikalelectronics.ru/
> Changelog v3:
> - Use spi_delay_exec() method to wait for the DMA operation completion.
> - Explicitly initialize the dw_dma_slave members on stack.
> - Discard the dws->fifo_len utilization in the Tx FIFO DMA threshold
>   setting from the patch where we just add the default burst length
>   constants.
> - Use min() method to calculate the optimal burst values.
> - Add new patch which moves the spi-dw.c source file to spi-dw-core.c in
>   order to preserve the DW APB SSI core driver name.
> - Add commas in the debugfs_reg32 structure initializer and after the last
>   entry of the dw_spi_dbgfs_regs array.
> 
> Link: https://lore.kernel.org/linux-spi/20200521012206.14472-1-Sergey.Semin@baikalelectronics.ru
> Changelog v4:
> - Get back ndelay() method to wait for an SPI transfer completion.
>   spi_delay_exec() isn't suitable for the atomic context.
> 
> Link: https://lore.kernel.org/linux-spi/20200522000806.7381-1-Sergey.Semin@baikalelectronics.ru
> Changelog v5:
> - Refactor the Tx/Rx DMA-based SPI transfers wait methods.
> - Add a new patch "spi: dw: Set xfer effective_speed_hz".
> - Add a new patch "spi: dw: Return any value retrieved from the
>   dma_transfer callback" as a preparation patch before implementing
>   the local DMA, Tx SPI and Rx SPI transfers wait methods.
> - Add a new patch "spi: dw: Locally wait for the DMA transactions
>   completion", which provides a local DMA transaction complete
>   method
> - Create a dedicated patch which adds the Rx-done wait method:
>   "spi: dw: Add SPI Rx-done wait method to DMA-based transfer".
> - Add more detailed description of the problems the Tx/Rx-wait
>   methods-related patches fix.
> - Wait for the SPI Tx and Rx transfers being finished in the
>   mid_spi_dma_transfer() method executed in the task context.
> - Use spi_delay_exec() to wait for the SPI Tx/Rx completion, since now
>   the driver calls the wait methods in the kernel thread context.
> - Use SPI_DELAY_UNIT_SCK spi_delay unit for Tx-wait delay, since SPI
>   xfer's are now have the effective_speed_hz initialized.
> - Rx-wait for a delay correlated with the APB/SSI synchronous clock
>   rate instead of using the SPI bus clock rate.
> 
> Link: https://lore.kernel.org/linux-spi/20200529035915.20790-1-Sergey.Semin@baikalelectronics.ru
> Changelog v6:
> - Provide a more detailed description of the patch:
>   2901db35bea1 ("spi: dw: Locally wait for the DMA transfers completion")
> - Calculate the Rx delay with better accuracy by moving 4-multiplication
>   to the head of the formulae:
>   ns = 4U * NSEC_PER_SEC / dws->max_freq * nents.
> 
> Co-developed-by: Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>
> Signed-off-by: Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>
> Co-developed-by: Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>
> Signed-off-by: Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> Cc: Maxim Kaurkin <Maxim.Kaurkin@baikalelectronics.ru>
> Cc: Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>
> Cc: Ekaterina Skachko <Ekaterina.Skachko@baikalelectronics.ru>
> Cc: Vadim Vlasov <V.Vlasov@baikalelectronics.ru>
> Cc: Alexey Kolotnikov <Alexey.Kolotnikov@baikalelectronics.ru>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Feng Tang <feng.tang@intel.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: linux-mips@vger.kernel.org
> Cc: linux-spi@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> 
> Serge Semin (16):
>   spi: dw: Set xfer effective_speed_hz
>   spi: dw: Return any value retrieved from the dma_transfer callback
>   spi: dw: Locally wait for the DMA transfers completion
>   spi: dw: Add SPI Tx-done wait method to DMA-based transfer
>   spi: dw: Add SPI Rx-done wait method to DMA-based transfer
>   spi: dw: Parameterize the DMA Rx/Tx burst length
>   spi: dw: Use DMA max burst to set the request thresholds
>   spi: dw: Fix Rx-only DMA transfers
>   spi: dw: Add core suffix to the DW APB SSI core source file
>   spi: dw: Move Non-DMA code to the DW PCIe-SPI driver
>   spi: dw: Remove DW DMA code dependency from DW_DMAC_PCI
>   spi: dw: Add DW SPI DMA/PCI/MMIO dependency on the DW SPI core
>   spi: dw: Cleanup generic DW DMA code namings
>   spi: dw: Add DMA support to the DW SPI MMIO driver
>   spi: dw: Use regset32 DebugFS method to create regdump file
>   dt-bindings: spi: Convert DW SPI binding to DT schema
> 
>  .../bindings/spi/snps,dw-apb-ssi.txt          |  44 --
>  .../bindings/spi/snps,dw-apb-ssi.yaml         | 127 +++++
>  .../devicetree/bindings/spi/spi-dw.txt        |  24 -
>  drivers/spi/Kconfig                           |  15 +-
>  drivers/spi/Makefile                          |   5 +-
>  drivers/spi/{spi-dw.c => spi-dw-core.c}       |  95 ++--
>  drivers/spi/spi-dw-dma.c                      | 482 ++++++++++++++++++
>  drivers/spi/spi-dw-mid.c                      | 382 --------------
>  drivers/spi/spi-dw-mmio.c                     |   4 +
>  drivers/spi/spi-dw-pci.c                      |  50 +-
>  drivers/spi/spi-dw.h                          |  20 +-
>  11 files changed, 719 insertions(+), 529 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
>  create mode 100644 Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
>  delete mode 100644 Documentation/devicetree/bindings/spi/spi-dw.txt
>  rename drivers/spi/{spi-dw.c => spi-dw-core.c} (82%)
>  create mode 100644 drivers/spi/spi-dw-dma.c
>  delete mode 100644 drivers/spi/spi-dw-mid.c
> 
> -- 
> 2.26.2
> 

-- 
With Best Regards,
Andy Shevchenko


