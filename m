Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 816D6450729
	for <lists+linux-spi@lfdr.de>; Mon, 15 Nov 2021 15:36:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234939AbhKOOjX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 15 Nov 2021 09:39:23 -0500
Received: from mga01.intel.com ([192.55.52.88]:21564 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236278AbhKOOjH (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 15 Nov 2021 09:39:07 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10168"; a="257198994"
X-IronPort-AV: E=Sophos;i="5.87,236,1631602800"; 
   d="scan'208";a="257198994"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2021 06:36:09 -0800
X-IronPort-AV: E=Sophos;i="5.87,236,1631602800"; 
   d="scan'208";a="453833971"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2021 06:36:07 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1mmd5S-0077Pv-Hd;
        Mon, 15 Nov 2021 16:35:58 +0200
Date:   Mon, 15 Nov 2021 16:35:58 +0200
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Nandhini Srikandan <nandhini.srikandan@intel.com>,
        Andy Shevchenko <andy@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/6] spi: dw: Replace DWC_HSSI capability with IP-core
 version checker
Message-ID: <YZJwTgAPZYVvzGpi@smile.fi.intel.com>
References: <20211114223026.13359-1-Sergey.Semin@baikalelectronics.ru>
 <20211114223026.13359-7-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211114223026.13359-7-Sergey.Semin@baikalelectronics.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Nov 15, 2021 at 01:30:26AM +0300, Serge Semin wrote:
> Since there is a common IP-core and component versions interface available
> we can use it to differentiate the DW HSSI device features in the code.
> Let's remove the corresponding DWC_HSSI capability flag then and use the
> dw_spi_ip_is() macro instead.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

But see below.

> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 
> ---
> 
> Changelog v2:
> - This is a new patch created as a logical result of a new DW SSI IP-core
>   versions internal interface introduced in the previous patch.
> ---
>  drivers/spi/spi-dw-core.c | 8 ++++----
>  drivers/spi/spi-dw-mmio.c | 5 +++--
>  drivers/spi/spi-dw.h      | 3 +--
>  3 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
> index 42536b448ddd..934cc7a922e8 100644
> --- a/drivers/spi/spi-dw-core.c
> +++ b/drivers/spi/spi-dw-core.c
> @@ -272,7 +272,7 @@ static u32 dw_spi_prepare_cr0(struct dw_spi *dws, struct spi_device *spi)
>  {
>  	u32 cr0 = 0;
>  
> -	if (!(dws->caps & DW_SPI_CAP_DWC_HSSI)) {
> +	if (dw_spi_ip_is(dws, PSSI)) {
>  		/* CTRLR0[ 5: 4] Frame Format */
>  		cr0 |= FIELD_PREP(DW_PSSI_CTRLR0_FRF_MASK, DW_SPI_CTRLR0_FRF_MOTO_SPI);
>  
> @@ -325,7 +325,7 @@ void dw_spi_update_config(struct dw_spi *dws, struct spi_device *spi,
>  	/* CTRLR0[ 4/3: 0] or CTRLR0[ 20: 16] Data Frame Size */
>  	cr0 |= (cfg->dfs - 1) << dws->dfs_offset;
>  
> -	if (!(dws->caps & DW_SPI_CAP_DWC_HSSI))
> +	if (dw_spi_ip_is(dws, PSSI))
>  		/* CTRLR0[ 9:8] Transfer Mode */
>  		cr0 |= FIELD_PREP(DW_PSSI_CTRLR0_TMOD_MASK, cfg->tmode);
>  	else
> @@ -832,7 +832,7 @@ static void dw_spi_hw_init(struct device *dev, struct dw_spi *dws)
>  		dws->ver = dw_readl(dws, DW_SPI_VERSION);
>  
>  		dev_dbg(dev, "Synopsys DWC%sSSI v%c.%c%c\n",
> -			(dws->caps & DW_SPI_CAP_DWC_HSSI) ? " " : " APB ",
> +			dw_spi_ip_is(dws, PSSI) ? " APB " : " ",
>  			DW_SPI_GET_BYTE(dws->ver, 3), DW_SPI_GET_BYTE(dws->ver, 2),
>  			DW_SPI_GET_BYTE(dws->ver, 1));
>  	}
> @@ -860,7 +860,7 @@ static void dw_spi_hw_init(struct device *dev, struct dw_spi *dws)
>  	 * writability. Note DWC SSI controller also has the extended DFS, but
>  	 * with zero offset.
>  	 */
> -	if (!(dws->caps & DW_SPI_CAP_DWC_HSSI)) {
> +	if (dw_spi_ip_is(dws, PSSI)) {
>  		u32 cr0, tmp = dw_readl(dws, DW_SPI_CTRLR0);
>  
>  		dw_spi_enable_chip(dws, 0);
> diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
> index 0b37bd32b041..c0e5bb6add0a 100644
> --- a/drivers/spi/spi-dw-mmio.c
> +++ b/drivers/spi/spi-dw-mmio.c
> @@ -207,7 +207,7 @@ static int dw_spi_pssi_init(struct platform_device *pdev,
>  static int dw_spi_hssi_init(struct platform_device *pdev,
>  			    struct dw_spi_mmio *dwsmmio)
>  {
> -	dwsmmio->dws.caps = DW_SPI_CAP_DWC_HSSI;
> +	dwsmmio->dws.ip = DW_HSSI_ID;
>  
>  	dw_spi_dma_setup_generic(&dwsmmio->dws);
>  
> @@ -217,7 +217,8 @@ static int dw_spi_hssi_init(struct platform_device *pdev,
>  static int dw_spi_keembay_init(struct platform_device *pdev,
>  			       struct dw_spi_mmio *dwsmmio)
>  {
> -	dwsmmio->dws.caps = DW_SPI_CAP_KEEMBAY_MST | DW_SPI_CAP_DWC_HSSI;
> +	dwsmmio->dws.ip = DW_HSSI_ID;
> +	dwsmmio->dws.caps = DW_SPI_CAP_KEEMBAY_MST;
>  
>  	return 0;
>  }
> diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
> index 2f7d77024b48..d5ee5130601e 100644
> --- a/drivers/spi/spi-dw.h
> +++ b/drivers/spi/spi-dw.h
> @@ -32,8 +32,7 @@
>  /* DW SPI controller capabilities */
>  #define DW_SPI_CAP_CS_OVERRIDE		BIT(0)
>  #define DW_SPI_CAP_KEEMBAY_MST		BIT(1)
> -#define DW_SPI_CAP_DWC_HSSI		BIT(2)
> -#define DW_SPI_CAP_DFS32		BIT(3)
> +#define DW_SPI_CAP_DFS32		BIT(2)

In one patch you move this in the file upper.
Here you reshuffling it due to dropping one bit.

Now I'm wondering if you may split these two into a separate patch, which
brings us to simple

-#define DW_SPI_CAP_DWC_HSSI		BIT(3)

here.

>  
>  /* Register offsets (Generic for both DWC APB SSI and DWC SSI IP-cores) */
>  #define DW_SPI_CTRLR0			0x00

-- 
With Best Regards,
Andy Shevchenko


