Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 840CD1D527E
	for <lists+linux-spi@lfdr.de>; Fri, 15 May 2020 16:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbgEOOwB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 15 May 2020 10:52:01 -0400
Received: from mga05.intel.com ([192.55.52.43]:27030 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726144AbgEOOwA (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 15 May 2020 10:52:00 -0400
IronPort-SDR: mcba1R6OENUDv8qeuAeBMuMpKFu0TewZVwf+BZOafk94r9SFtOGRSamz1cyOB9MEYbptMUIm6Z
 veTCvgsM9VBg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2020 07:51:59 -0700
IronPort-SDR: HwPk1H61Q+H4zsEv20ReDwzqDvKEXNvgEDK9TQ2yu/lH1xQmk6pcwVrQyzaEjrKy38GcLsoRkW
 sro0LQ8ZJSxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,395,1583222400"; 
   d="scan'208";a="341999325"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga001.jf.intel.com with ESMTP; 15 May 2020 07:51:52 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jZbgn-006tLt-NT; Fri, 15 May 2020 17:51:53 +0300
Date:   Fri, 15 May 2020 17:51:53 +0300
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
        Joe Perches <joe@perches.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Masahisa Kojima <masahisa.kojima@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Eddie James <eajames@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Chuhong Yuan <hslester96@gmail.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Raymond Tan <raymond.tan@intel.com>,
        "wuxu.wu" <wuxu.wu@huawei.com>, Clement Leger <cleger@kalray.eu>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 13/19] spi: dw: Move Non-DMA code to the DW PCIe-SPI
 driver
Message-ID: <20200515145153.GJ1634618@smile.fi.intel.com>
References: <20200508132943.9826-1-Sergey.Semin@baikalelectronics.ru>
 <20200515104758.6934-1-Sergey.Semin@baikalelectronics.ru>
 <20200515104758.6934-14-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515104758.6934-14-Sergey.Semin@baikalelectronics.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, May 15, 2020 at 01:47:52PM +0300, Serge Semin wrote:
> This is a preparation patch before adding the DW DMA support into the
> DW SPI MMIO driver. We need to unpin the Non-DMA-specific code from the
> intended to be generic DW APB SSI DMA code. This isn't that hard,
> since the most part of the spi-dw-mid.c driver in fact implements a
> generic DMA interface for the DW SPI controller driver. The only Intel
> MID specifics concern getting the max frequency from the MRST Clock
> Control Unit and fetching the DMA controller channels from
> corresponding PCIe DMA controller. Since first one is related with the
> SPI interface configuration we moved it' implementation into the
> DW PCIe-SPI driver module. After that former spi-dw-mid.c file
> can be just renamed to be the DW SPI DMA module optionally compiled in to
> the DW APB SSI core driver.

Cc list here is huge!

I think this patch should go immediately after bunch of fixes.

...

> -obj-$(CONFIG_SPI_DESIGNWARE)		+= spi-dw.o
> +obj-$(CONFIG_SPI_DESIGNWARE)		+= spi-dw-core.o
> +spi-dw-core-y				:= spi-dw.o
> +spi-dw-core-$(CONFIG_SPI_DW_DMA)	+= spi-dw-dma.o

We may leave module name the same, right?

obj-$(CONFIG_SPI_DESIGNWARE)		+= spi-dw.o
spi-dw-y				:= spi-dw-core.o
spi-dw-$(CONFIG_SPI_DW_DMA)		+= spi-dw-dma.o

>  obj-$(CONFIG_SPI_DW_MMIO)		+= spi-dw-mmio.o
> -obj-$(CONFIG_SPI_DW_PCI)		+= spi-dw-midpci.o
> -spi-dw-midpci-objs			:= spi-dw-pci.o spi-dw-mid.o
> +obj-$(CONFIG_SPI_DW_PCI)		+= spi-dw-pci.o

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
> -int dw_spi_mid_init_mfld(struct dw_spi *dws)
> -{
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
> -	/* Register hook to configure CTRLR0 */
> -	dws->update_cr0 = dw_spi_update_cr0;
> -
> -	dw_spi_mid_setup_dma_mfld(dws);
> -	return 0;
> -}
> -
> -int dw_spi_mid_init_generic(struct dw_spi *dws)
> -{
> -	/* Register hook to configure CTRLR0 */
> -	dws->update_cr0 = dw_spi_update_cr0;
> -
> -	dw_spi_mid_setup_dma_generic(dws);
> -	return 0;
> -}
> +EXPORT_SYMBOL_GPL(dw_spi_mid_setup_dma_generic);
> diff --git a/drivers/spi/spi-dw-pci.c b/drivers/spi/spi-dw-pci.c
> index dde54a918b5d..c13707b8493e 100644
> --- a/drivers/spi/spi-dw-pci.c
> +++ b/drivers/spi/spi-dw-pci.c
> @@ -15,6 +15,15 @@
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
>  struct spi_pci_desc {
>  	int	(*setup)(struct dw_spi *);
>  	u16	num_cs;
> @@ -22,20 +31,55 @@ struct spi_pci_desc {
>  	u32	max_freq;
>  };
>  
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
> +	/* Register hook to configure CTRLR0 */
> +	dws->update_cr0 = dw_spi_update_cr0;
> +
> +	dw_spi_mid_setup_dma_mfld(dws);
> +
> +	return 0;
> +}
> +
> +static int spi_generic_init(struct dw_spi *dws)
> +{
> +	/* Register hook to configure CTRLR0 */
> +	dws->update_cr0 = dw_spi_update_cr0;
> +
> +	dw_spi_mid_setup_dma_generic(dws);
> +
> +	return 0;
> +}
> +
>  static struct spi_pci_desc spi_pci_mid_desc_1 = {
> -	.setup = dw_spi_mid_init_mfld,
> +	.setup = spi_mid_init,
>  	.num_cs = 5,
>  	.bus_num = 0,
>  };
>  
>  static struct spi_pci_desc spi_pci_mid_desc_2 = {
> -	.setup = dw_spi_mid_init_mfld,
> +	.setup = spi_mid_init,
>  	.num_cs = 2,
>  	.bus_num = 1,
>  };
>  
>  static struct spi_pci_desc spi_pci_ehl_desc = {
> -	.setup = dw_spi_mid_init_generic,
> +	.setup = spi_generic_init,
>  	.num_cs = 2,
>  	.bus_num = -1,
>  	.max_freq = 100000000,
> diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
> index d0c8b7d3a5d2..75fdcc5e7642 100644
> --- a/drivers/spi/spi-dw.h
> +++ b/drivers/spi/spi-dw.h
> @@ -265,8 +265,16 @@ extern u32 dw_spi_update_cr0_v1_01a(struct spi_controller *master,
>  				    struct spi_device *spi,
>  				    struct spi_transfer *transfer);
>  
> -/* platform related setup */
> -extern int dw_spi_mid_init_mfld(struct dw_spi *dws);
> -extern int dw_spi_mid_init_generic(struct dw_spi *dws);
> +#ifdef CONFIG_SPI_DW_DMA
> +
> +extern void dw_spi_mid_setup_dma_mfld(struct dw_spi *dws);
> +extern void dw_spi_mid_setup_dma_generic(struct dw_spi *dws);
> +

I would drop blank lines and extern keywords.

> +#else

> +
> +static inline void dw_spi_mid_setup_dma_mfld(struct dw_spi *dws) {}
> +static inline void dw_spi_mid_setup_dma_generic(struct dw_spi *dws) {}
> +

Ditto for blank lines.

> +#endif /* !CONFIG_SPI_DW_DMA */
>  
>  #endif /* DW_SPI_HEADER_H */
> -- 
> 2.25.1
> 

-- 
With Best Regards,
Andy Shevchenko


