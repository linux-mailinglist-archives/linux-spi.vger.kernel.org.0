Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 080FD45071C
	for <lists+linux-spi@lfdr.de>; Mon, 15 Nov 2021 15:34:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236686AbhKOOgr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 15 Nov 2021 09:36:47 -0500
Received: from mga07.intel.com ([134.134.136.100]:47593 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236809AbhKOOf7 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 15 Nov 2021 09:35:59 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10168"; a="296878469"
X-IronPort-AV: E=Sophos;i="5.87,236,1631602800"; 
   d="scan'208";a="296878469"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2021 06:32:55 -0800
X-IronPort-AV: E=Sophos;i="5.87,236,1631602800"; 
   d="scan'208";a="671527144"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2021 06:32:53 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1mmd2L-0077N4-0D;
        Mon, 15 Nov 2021 16:32:45 +0200
Date:   Mon, 15 Nov 2021 16:32:44 +0200
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Nandhini Srikandan <nandhini.srikandan@intel.com>,
        Andy Shevchenko <andy@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/6] spi: dw: Introduce Synopsys IP-core versions
 interface
Message-ID: <YZJvjAfUoo6dCXaB@smile.fi.intel.com>
References: <20211114223026.13359-1-Sergey.Semin@baikalelectronics.ru>
 <20211114223026.13359-6-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211114223026.13359-6-Sergey.Semin@baikalelectronics.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Nov 15, 2021 at 01:30:25AM +0300, Serge Semin wrote:
> The driver currently supports two IP-core versions. It's DW APB SSI which
> is older version of the controller with APB system bus interface, and DW
> SSI controller with AHB bus interface. The later one is supposed to be a
> new generation high-speed SSI. Even though both of these IP-cores have got
> an almost identical registers space there are some differences. The driver
> differentiates these distinctions by the DW_SPI_CAP_DWC_HSSI capability
> flag. In addition to that each DW SSI IP-core is equipped with a Synopsys
> Component version register, which encodes the IP-core release ID the has
> been synthesized from. Seeing we are going to need the later one to
> differentiate some controller peculiarities it would be better to have a
> unified interface for both IP-core line and release versions instead of
> using each of them separately.
> 
> Introduced here IP-core versioning interface consists of two parts:
> 1) IDs of the IP-core (virtual) and component versions.
> 2) a set of macro helpers to identify current IP-core and component
> versions.
> 
> So the platform code is supposed to assign a proper IP-core version based
> on it's platform -knowledge. The main driver initialization method reads
> the IP-core release ID from the SSI component version register. That data
> is used by the helpers to distinguish one IP-core release from another.
> Thus the rest of the driver can use these macros to implement the
> conditional code execution based on the specified IP-core and version IDs.
> 
> Collect the IP-core versions interface and the defined capabilities at the
> top of the header file since they represent a common device description
> data and so to immediately available for the driver hackers.

Thanks! Fine with me
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> 
> ---
> 
> Note I intentionally haven't used the "%p4cc" format specifier due to
> three reasons. First the component version 4cc string is preserved in the
> little endian format in the DW SSI register thus having '*' in the least
> significant byte.  Such representation do look well when you print it in
> hex, but that's not what the 4cc format print implementation expects
> (fourcc_string() wants to see a most-significant char at the lowest byte).
> Second the 4cc format also prints some pixel-format specific info like
> endiannes, which is irrelevant to the synopsys component version. Finally
> a string in the "v%c.%c%c" format represents the component version better.

Yeah, I guess we might need a specific FourCC for Synopsys IPs. But it's
another story.

> Changelog v2:
> - Replace the ASCII-to-integer conversion with a unified IP-core versions
>   interface.
> ---
>  drivers/spi/spi-dw-core.c | 14 ++++++++++++++
>  drivers/spi/spi-dw.h      | 36 ++++++++++++++++++++++++++++--------
>  2 files changed, 42 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
> index b9f809989fda..42536b448ddd 100644
> --- a/drivers/spi/spi-dw-core.c
> +++ b/drivers/spi/spi-dw-core.c
> @@ -823,6 +823,20 @@ static void dw_spi_hw_init(struct device *dev, struct dw_spi *dws)
>  {
>  	dw_spi_reset_chip(dws);
>  
> +	/*
> +	 * Retrieve the Synopsys component version if it hasn't been specified
> +	 * by the platform. CoreKit version ID is encoded as a 3-chars ASCII
> +	 * code enclosed with '*' (typical for the most of Synopsys IP-cores).
> +	 */
> +	if (!dws->ver) {
> +		dws->ver = dw_readl(dws, DW_SPI_VERSION);
> +
> +		dev_dbg(dev, "Synopsys DWC%sSSI v%c.%c%c\n",
> +			(dws->caps & DW_SPI_CAP_DWC_HSSI) ? " " : " APB ",
> +			DW_SPI_GET_BYTE(dws->ver, 3), DW_SPI_GET_BYTE(dws->ver, 2),
> +			DW_SPI_GET_BYTE(dws->ver, 1));
> +	}
> +
>  	/*
>  	 * Try to detect the FIFO depth if not set by interface driver,
>  	 * the depth could be from 2 to 256 from HW spec
> diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
> index 634085eadad1..2f7d77024b48 100644
> --- a/drivers/spi/spi-dw.h
> +++ b/drivers/spi/spi-dw.h
> @@ -11,6 +11,30 @@
>  #include <linux/spi/spi-mem.h>
>  #include <linux/bitfield.h>
>  
> +/* Synopsys DW SSI IP-core virtual IDs */
> +#define DW_PSSI_ID			0
> +#define DW_HSSI_ID			1
> +
> +/* Synopsys DW SSI component versions (FourCC sequence) */
> +#define DW_HSSI_102A			0x3130322a
> +
> +/* DW SSI IP-core ID and version check helpers */
> +#define dw_spi_ip_is(_dws, _ip) \
> +	((_dws)->ip == DW_ ## _ip ## _ID)
> +
> +#define __dw_spi_ver_cmp(_dws, _ip, _ver, _op) \
> +	(dw_spi_ip_is(_dws, _ip) && (_dws)->ver _op DW_ ## _ip ## _ver)
> +
> +#define dw_spi_ver_is(_dws, _ip, _ver) __dw_spi_ver_cmp(_dws, _ip, _ver, ==)
> +
> +#define dw_spi_ver_is_ge(_dws, _ip, _ver) __dw_spi_ver_cmp(_dws, _ip, _ver, >=)
> +
> +/* DW SPI controller capabilities */
> +#define DW_SPI_CAP_CS_OVERRIDE		BIT(0)
> +#define DW_SPI_CAP_KEEMBAY_MST		BIT(1)
> +#define DW_SPI_CAP_DWC_HSSI		BIT(2)
> +#define DW_SPI_CAP_DFS32		BIT(3)
> +
>  /* Register offsets (Generic for both DWC APB SSI and DWC SSI IP-cores) */
>  #define DW_SPI_CTRLR0			0x00
>  #define DW_SPI_CTRLR1			0x04
> @@ -113,12 +137,6 @@
>  #define DW_SPI_GET_BYTE(_val, _idx) \
>  	((_val) >> (BITS_PER_BYTE * (_idx)) & 0xff)
>  
> -/* DW SPI capabilities */
> -#define DW_SPI_CAP_CS_OVERRIDE		BIT(0)
> -#define DW_SPI_CAP_KEEMBAY_MST		BIT(1)
> -#define DW_SPI_CAP_DWC_HSSI		BIT(2)
> -#define DW_SPI_CAP_DFS32		BIT(3)
> -
>  /* Slave spi_transfer/spi_mem_op related */
>  struct dw_spi_cfg {
>  	u8 tmode;
> @@ -141,6 +159,10 @@ struct dw_spi_dma_ops {
>  struct dw_spi {
>  	struct spi_controller	*master;
>  
> +	u32			ip;		/* Synopsys DW SSI IP-core ID */
> +	u32			ver;		/* Synopsys component version */
> +	u32			caps;		/* DW SPI capabilities */
> +
>  	void __iomem		*regs;
>  	unsigned long		paddr;
>  	int			irq;
> @@ -149,8 +171,6 @@ struct dw_spi {
>  	u32			max_mem_freq;	/* max mem-ops bus freq */
>  	u32			max_freq;	/* max bus freq supported */
>  
> -	u32			caps;		/* DW SPI capabilities */
> -
>  	u32			reg_io_width;	/* DR I/O width in bytes */
>  	u16			bus_num;
>  	u16			num_cs;		/* supported slave numbers */
> -- 
> 2.33.0
> 

-- 
With Best Regards,
Andy Shevchenko


