Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B16241CB87E
	for <lists+linux-spi@lfdr.de>; Fri,  8 May 2020 21:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbgEHTlf (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 8 May 2020 15:41:35 -0400
Received: from mga02.intel.com ([134.134.136.20]:54129 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727097AbgEHTlf (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 8 May 2020 15:41:35 -0400
IronPort-SDR: i9ihioUmJoj3x4vyVsA3zhcKcka4yKgZcgr0Mzf49hrJ1n6+WzxJAcZhlur7TJQloj3ZmIwL09
 ZuXKnLMVZ/gg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2020 12:41:34 -0700
IronPort-SDR: fhabmOqBcdC+XBCYtEWhLT4FdVREruEpU4fdXul7v54ugQw01rf8nndo4AXb868/H0V5QIZOPd
 f4TFruPgphLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,368,1583222400"; 
   d="scan'208";a="285581357"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga004.fm.intel.com with ESMTP; 08 May 2020 12:41:27 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jX8sD-005TEr-0Y; Fri, 08 May 2020 22:41:29 +0300
Date:   Fri, 8 May 2020 22:41:29 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Mark Brown <broonie@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Allison Randal <allison@lohutok.net>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Chuanhong Guo <gch981213@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Masahisa Kojima <masahisa.kojima@linaro.org>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Eddie James <eajames@linux.ibm.com>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Raymond Tan <raymond.tan@intel.com>,
        Chuhong Yuan <hslester96@gmail.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "wuxu.wu" <wuxu.wu@huawei.com>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/17] spi: dw: Split up the generic DMA code and Intel
 MID driver
Message-ID: <20200508194129.GZ185537@smile.fi.intel.com>
References: <20200508132943.9826-1-Sergey.Semin@baikalelectronics.ru>
 <20200508132943.9826-4-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508132943.9826-4-Sergey.Semin@baikalelectronics.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, May 08, 2020 at 04:29:28PM +0300, Serge Semin wrote:
> This is an initial preparation patch before adding the DW DMA support
> into the DW SPI MMIO driver. We need to unpin the DMA-specific code
> from the code intended to be used for Intel MID. This isn't that hard,
> since most part of the spi-dw-mid.c driver in fact implements a generic
> DW DMA interface for the DW SPI controller driver. The only Intel MID
> specifics concern getting the max frequency from the MRST Clock
> Control Unit and fetching the DMA controller channels from
> corresponding PCIe DMA controller. Since first one is related with the
> SPI interface configuration we moved it' implementation into the
> DW PCIe-SPI driver object. While seeing there is no other than Medfield
> board with DW DMA controller currently supported we left the DMA
> channels search procedure in the DW SPI DMA module. After being
> cleaned up of the Intel MID specifics former spi-dw-mid.c module
> can be just renamed to be the DW SPI DMA driver.

And I guess this already been done in spi/for-next in less invasive way.

> 
> Co-developed-by: Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>
> Signed-off-by: Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>
> Co-developed-by: Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>
> Signed-off-by: Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: Paul Burton <paulburton@kernel.org>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Allison Randal <allison@lohutok.net>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Gareth Williams <gareth.williams.jx@renesas.com>
> Cc: linux-mips@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> ---
>  drivers/spi/Kconfig                        |  8 ++---
>  drivers/spi/Makefile                       |  4 +--
>  drivers/spi/{spi-dw-mid.c => spi-dw-dma.c} | 36 ++------------------
>  drivers/spi/spi-dw-pci.c                   | 38 ++++++++++++++++++++--
>  drivers/spi/spi-dw.h                       | 12 +++++--
>  5 files changed, 55 insertions(+), 43 deletions(-)
>  rename drivers/spi/{spi-dw-mid.c => spi-dw-dma.c} (88%)
> 
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index 741b9140992a..9653c7f271e9 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -226,14 +226,14 @@ config SPI_DESIGNWARE
>  	help
>  	  general driver for SPI controller core from DesignWare
>  
> +config SPI_DW_DMA
> +	tristate "DMA support for DW SPI controller"
> +	depends on SPI_DESIGNWARE && DW_DMAC_PCI
> +
>  config SPI_DW_PCI
>  	tristate "PCI interface driver for DW SPI core"
>  	depends on SPI_DESIGNWARE && PCI
>  
> -config SPI_DW_MID_DMA
> -	bool "DMA support for DW SPI controller on Intel MID platform"
> -	depends on SPI_DW_PCI && DW_DMAC_PCI
> -
>  config SPI_DW_MMIO
>  	tristate "Memory-mapped io interface driver for DW SPI core"
>  	depends on SPI_DESIGNWARE
> diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
> index 28f601327f8c..15eb760412a9 100644
> --- a/drivers/spi/Makefile
> +++ b/drivers/spi/Makefile
> @@ -36,9 +36,9 @@ obj-$(CONFIG_SPI_COLDFIRE_QSPI)		+= spi-coldfire-qspi.o
>  obj-$(CONFIG_SPI_DAVINCI)		+= spi-davinci.o
>  obj-$(CONFIG_SPI_DLN2)			+= spi-dln2.o
>  obj-$(CONFIG_SPI_DESIGNWARE)		+= spi-dw.o
> +obj-$(CONFIG_SPI_DW_DMA)		+= spi-dw-dma.o
>  obj-$(CONFIG_SPI_DW_MMIO)		+= spi-dw-mmio.o
> -obj-$(CONFIG_SPI_DW_PCI)		+= spi-dw-midpci.o
> -spi-dw-midpci-objs			:= spi-dw-pci.o spi-dw-mid.o
> +obj-$(CONFIG_SPI_DW_PCI)		+= spi-dw-pci.o
>  obj-$(CONFIG_SPI_EFM32)			+= spi-efm32.o
>  obj-$(CONFIG_SPI_EP93XX)		+= spi-ep93xx.o
>  obj-$(CONFIG_SPI_FALCON)		+= spi-falcon.o
> diff --git a/drivers/spi/spi-dw-mid.c b/drivers/spi/spi-dw-dma.c
> similarity index 88%
> rename from drivers/spi/spi-dw-mid.c
> rename to drivers/spi/spi-dw-dma.c
> index 0d86c37e0aeb..0230b4252611 100644
> --- a/drivers/spi/spi-dw-mid.c
> +++ b/drivers/spi/spi-dw-dma.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /*
> - * Special handling for DW core on Intel MID platform
> + * Special handling for DW DMA core
>   *
>   * Copyright (c) 2009, 2014 Intel Corporation.
>   */
> @@ -14,7 +14,6 @@
>  
>  #include "spi-dw.h"
>  
> -#ifdef CONFIG_SPI_DW_MID_DMA
>  #include <linux/pci.h>
>  #include <linux/platform_data/dma-dw.h>
>  
> @@ -283,40 +282,11 @@ static const struct dw_spi_dma_ops mid_dma_ops = {
>  	.dma_transfer	= mid_spi_dma_transfer,
>  	.dma_stop	= mid_spi_dma_stop,
>  };
> -#endif
>  
> -/* Some specific info for SPI0 controller on Intel MID */
> -
> -/* HW info for MRST Clk Control Unit, 32b reg per controller */
> -#define MRST_SPI_CLK_BASE	100000000	/* 100m */
> -#define MRST_CLK_SPI_REG	0xff11d86c
> -#define CLK_SPI_BDIV_OFFSET	0
> -#define CLK_SPI_BDIV_MASK	0x00000007
> -#define CLK_SPI_CDIV_OFFSET	9
> -#define CLK_SPI_CDIV_MASK	0x00000e00
> -#define CLK_SPI_DISABLE_OFFSET	8
> -
> -int dw_spi_mid_init(struct dw_spi *dws)
> +void dw_spi_pci_dma_setup(struct dw_spi *dws)
>  {
> -	void __iomem *clk_reg;
> -	u32 clk_cdiv;
> -
> -	clk_reg = ioremap(MRST_CLK_SPI_REG, 16);
> -	if (!clk_reg)
> -		return -ENOMEM;
> -
> -	/* Get SPI controller operating freq info */
> -	clk_cdiv = readl(clk_reg + dws->bus_num * sizeof(u32));
> -	clk_cdiv &= CLK_SPI_CDIV_MASK;
> -	clk_cdiv >>= CLK_SPI_CDIV_OFFSET;
> -	dws->max_freq = MRST_SPI_CLK_BASE / (clk_cdiv + 1);
> -
> -	iounmap(clk_reg);
> -
> -#ifdef CONFIG_SPI_DW_MID_DMA
>  	dws->dma_tx = &mid_dma_tx;
>  	dws->dma_rx = &mid_dma_rx;
>  	dws->dma_ops = &mid_dma_ops;
> -#endif
> -	return 0;
>  }
> +EXPORT_SYMBOL_GPL(dw_spi_pci_dma_setup);
> diff --git a/drivers/spi/spi-dw-pci.c b/drivers/spi/spi-dw-pci.c
> index 12c131b5fb4e..068f6897b903 100644
> --- a/drivers/spi/spi-dw-pci.c
> +++ b/drivers/spi/spi-dw-pci.c
> @@ -16,6 +16,17 @@
>  
>  #define DRIVER_NAME "dw_spi_pci"
>  
> +/* HW info for MRST Clk Control Unit, 32b reg per controller */
> +#define MRST_SPI_CLK_BASE	100000000	/* 100m */
> +#define MRST_CLK_SPI_REG	0xff11d86c
> +#define CLK_SPI_BDIV_OFFSET	0
> +#define CLK_SPI_BDIV_MASK	0x00000007
> +#define CLK_SPI_CDIV_OFFSET	9
> +#define CLK_SPI_CDIV_MASK	0x00000e00
> +#define CLK_SPI_DISABLE_OFFSET	8
> +
> +static int spi_mid_init(struct dw_spi *dws);
> +
>  struct spi_pci_desc {
>  	int	(*setup)(struct dw_spi *);
>  	u16	num_cs;
> @@ -24,13 +35,13 @@ struct spi_pci_desc {
>  };
>  
>  static struct spi_pci_desc spi_pci_mid_desc_1 = {
> -	.setup = dw_spi_mid_init,
> +	.setup = spi_mid_init,
>  	.num_cs = 5,
>  	.bus_num = 0,
>  };
>  
>  static struct spi_pci_desc spi_pci_mid_desc_2 = {
> -	.setup = dw_spi_mid_init,
> +	.setup = spi_mid_init,
>  	.num_cs = 2,
>  	.bus_num = 1,
>  };
> @@ -41,6 +52,29 @@ static struct spi_pci_desc spi_pci_ehl_desc = {
>  	.max_freq = 100000000,
>  };
>  
> +/* Some specific info for SPI0 controller on Intel MID */
> +static int spi_mid_init(struct dw_spi *dws)
> +{
> +	void __iomem *clk_reg;
> +	u32 clk_cdiv;
> +
> +	clk_reg = ioremap(MRST_CLK_SPI_REG, 16);
> +	if (!clk_reg)
> +		return -ENOMEM;
> +
> +	/* Get SPI controller operating freq info */
> +	clk_cdiv = readl(clk_reg + dws->bus_num * sizeof(u32));
> +	clk_cdiv &= CLK_SPI_CDIV_MASK;
> +	clk_cdiv >>= CLK_SPI_CDIV_OFFSET;
> +	dws->max_freq = MRST_SPI_CLK_BASE / (clk_cdiv + 1);
> +
> +	iounmap(clk_reg);
> +
> +	dw_spi_pci_dma_setup(dws);
> +
> +	return 0;
> +}
> +
>  static int spi_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  {
>  	struct dw_spi *dws;
> diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
> index 1bf5713e047d..0a4e0890ef85 100644
> --- a/drivers/spi/spi-dw.h
> +++ b/drivers/spi/spi-dw.h
> @@ -253,6 +253,14 @@ extern void dw_spi_remove_host(struct dw_spi *dws);
>  extern int dw_spi_suspend_host(struct dw_spi *dws);
>  extern int dw_spi_resume_host(struct dw_spi *dws);
>  
> -/* platform related setup */
> -extern int dw_spi_mid_init(struct dw_spi *dws); /* Intel MID platforms */
> +#ifdef CONFIG_SPI_DW_DMA
> +
> +extern void dw_spi_pci_dma_setup(struct dw_spi *dws);
> +
> +#else /* !CONFIG_SPI_DW_DMA */
> +
> +static inline void dw_spi_pci_dma_setup(struct dw_spi *dws) {}
> +
> +#endif /* !CONFIG_SPI_DW_DMA */
> +
>  #endif /* DW_SPI_HEADER_H */
> -- 
> 2.25.1
> 

-- 
With Best Regards,
Andy Shevchenko


