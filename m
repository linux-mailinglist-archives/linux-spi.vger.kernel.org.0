Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4131D4D03
	for <lists+linux-spi@lfdr.de>; Fri, 15 May 2020 13:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726122AbgEOLt5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 15 May 2020 07:49:57 -0400
Received: from mga18.intel.com ([134.134.136.126]:1219 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726084AbgEOLt5 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 15 May 2020 07:49:57 -0400
IronPort-SDR: Uy+BPBh3xaDFbG6LgcrL4vNEIJezNM/L1Z4DHUc6fw/AzBdzlKoWapIJahCibvJsuW1t0JBXYO
 k9srYy3ztgpQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2020 04:49:52 -0700
IronPort-SDR: 8O7jW9xSSJ6WuT0BVasoqIpi3i5Bd4zqbJldzc/HY9bAncbuSixFlF1Oj54J+8lcFvLAkvYjVZ
 nqd/kA7+iB/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,395,1583222400"; 
   d="scan'208";a="410441620"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga004.jf.intel.com with ESMTP; 15 May 2020 04:49:47 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jZYqc-006qmq-Kp; Fri, 15 May 2020 14:49:50 +0300
Date:   Fri, 15 May 2020 14:49:50 +0300
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
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Allison Randal <allison@lohutok.net>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Rob Herring <robh+dt@kernel.org>, linux-mips@vger.kernel.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/19] spi: dw: Add generic DW DMA controller support
Message-ID: <20200515114950.GT185537@smile.fi.intel.com>
References: <20200508132943.9826-1-Sergey.Semin@baikalelectronics.ru>
 <20200515104758.6934-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515104758.6934-1-Sergey.Semin@baikalelectronics.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, May 15, 2020 at 01:47:39PM +0300, Serge Semin wrote:
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

Thanks! I'm going to review it soon.

Hint for the next time, please start always a new thread with new version.

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
> Cc: Paul Burton <paulburton@kernel.org>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Allison Randal <allison@lohutok.net>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Gareth Williams <gareth.williams.jx@renesas.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: linux-mips@vger.kernel.org
> Cc: linux-spi@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> 
> ---
> 
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
> Serge Semin (19):
>   dt-bindings: spi: dw: Add Tx/Rx DMA properties
>   spi: dw: Add Tx/Rx finish wait methods to the MID DMA
>   spi: dw: Clear DMAC register when done or stopped
>   spi: dw: Fix native CS being unset
>   spi: dw: Enable interrupts in accordance with DMA xfer mode
>   spi: dw: Discard static DW DMA slave structures
>   spi: dw: Discard unused void priv pointer
>   spi: dw: Discard dma_width member of the dw_spi structure
>   spi: dw: Parameterize the DMA Rx/Tx burst length
>   spi: dw: Use DMA max burst to set the request thresholds
>   spi: dw: Initialize paddr in DW SPI MMIO private data
>   spi: dw: Fix Rx-only DMA transfers
>   spi: dw: Move Non-DMA code to the DW PCIe-SPI driver
>   spi: dw: Remove DW DMA code dependency from DW_DMAC_PCI
>   spi: dw: Add DW SPI DMA/PCI/MMIO dependency on the DW SPI core
>   spi: dw: Cleanup generic DW DMA code namings
>   spi: dw: Add DMA support to the DW SPI MMIO driver
>   spi: dw: Use regset32 DebugFS method to create regdump file
>   dt-bindings: spi: Convert DW SPI binding to DT schema
> 
>  .../bindings/spi/snps,dw-apb-ssi.txt          |  42 ---
>  .../bindings/spi/snps,dw-apb-ssi.yaml         | 127 +++++++++
>  .../devicetree/bindings/spi/spi-dw.txt        |  24 --
>  drivers/spi/Kconfig                           |  15 +-
>  drivers/spi/Makefile                          |   7 +-
>  drivers/spi/{spi-dw-mid.c => spi-dw-dma.c}    | 257 ++++++++++--------
>  drivers/spi/spi-dw-mmio.c                     |   9 +-
>  drivers/spi/spi-dw-pci.c                      |  50 +++-
>  drivers/spi/spi-dw.c                          |  98 +++----
>  drivers/spi/spi-dw.h                          |  33 ++-
>  10 files changed, 405 insertions(+), 257 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
>  create mode 100644 Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
>  delete mode 100644 Documentation/devicetree/bindings/spi/spi-dw.txt
>  rename drivers/spi/{spi-dw-mid.c => spi-dw-dma.c} (53%)
> 
> -- 
> 2.25.1
> 

-- 
With Best Regards,
Andy Shevchenko


