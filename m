Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE804506E2
	for <lists+linux-spi@lfdr.de>; Mon, 15 Nov 2021 15:28:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235198AbhKOObt (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 15 Nov 2021 09:31:49 -0500
Received: from mga06.intel.com ([134.134.136.31]:11453 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236588AbhKOOaS (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 15 Nov 2021 09:30:18 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10168"; a="294268014"
X-IronPort-AV: E=Sophos;i="5.87,236,1631602800"; 
   d="scan'208";a="294268014"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2021 06:27:21 -0800
X-IronPort-AV: E=Sophos;i="5.87,236,1631602800"; 
   d="scan'208";a="454039990"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2021 06:27:19 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1mmcww-0077Hh-Cf;
        Mon, 15 Nov 2021 16:27:10 +0200
Date:   Mon, 15 Nov 2021 16:27:10 +0200
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Nandhini Srikandan <nandhini.srikandan@intel.com>,
        Andy Shevchenko <andy@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] spi: dw: Add a symbols namespace for the core
 module
Message-ID: <YZJuPrnhupbnPxGt@smile.fi.intel.com>
References: <20211114223026.13359-1-Sergey.Semin@baikalelectronics.ru>
 <20211114223026.13359-2-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211114223026.13359-2-Sergey.Semin@baikalelectronics.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Nov 15, 2021 at 01:30:21AM +0300, Serge Semin wrote:
> The exported from the DW SPI driver core symbols are only used by the
> spi-dw-{dma,mmio,pci,bt1}.o objects. Add these symbols to a separate
> namespace then and make sure the depended modules have it imported.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Thanks!

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

See also below.

> ---
> 
> Changelog v2:
> - This is a new patch created as of Andy' suggestion.
> ---
>  drivers/spi/spi-dw-bt1.c  |  1 +
>  drivers/spi/spi-dw-core.c | 14 +++++++-------
>  drivers/spi/spi-dw-dma.c  |  7 +++++--
>  drivers/spi/spi-dw-mmio.c |  1 +
>  drivers/spi/spi-dw-pci.c  |  1 +
>  5 files changed, 15 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/spi/spi-dw-bt1.c b/drivers/spi/spi-dw-bt1.c
> index 5be6b7b80c21..ac7e4f30d1da 100644
> --- a/drivers/spi/spi-dw-bt1.c
> +++ b/drivers/spi/spi-dw-bt1.c
> @@ -339,3 +339,4 @@ module_platform_driver(dw_spi_bt1_driver);
>  MODULE_AUTHOR("Serge Semin <Sergey.Semin@baikalelectronics.ru>");
>  MODULE_DESCRIPTION("Baikal-T1 System Boot SPI Controller driver");
>  MODULE_LICENSE("GPL v2");
> +MODULE_IMPORT_NS(SPI_DW_CORE);
> diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
> index a305074c482e..a14940403ab4 100644
> --- a/drivers/spi/spi-dw-core.c
> +++ b/drivers/spi/spi-dw-core.c
> @@ -106,7 +106,7 @@ void dw_spi_set_cs(struct spi_device *spi, bool enable)
>  	else
>  		dw_writel(dws, DW_SPI_SER, 0);
>  }
> -EXPORT_SYMBOL_GPL(dw_spi_set_cs);
> +EXPORT_SYMBOL_NS_GPL(dw_spi_set_cs, SPI_DW_CORE);
>  
>  /* Return the max entries we can fill into tx fifo */
>  static inline u32 tx_max(struct dw_spi *dws)
> @@ -210,7 +210,7 @@ int dw_spi_check_status(struct dw_spi *dws, bool raw)
>  
>  	return ret;
>  }
> -EXPORT_SYMBOL_GPL(dw_spi_check_status);
> +EXPORT_SYMBOL_NS_GPL(dw_spi_check_status, SPI_DW_CORE);
>  
>  static irqreturn_t dw_spi_transfer_handler(struct dw_spi *dws)
>  {
> @@ -345,7 +345,7 @@ void dw_spi_update_config(struct dw_spi *dws, struct spi_device *spi,
>  		dws->cur_rx_sample_dly = chip->rx_sample_dly;
>  	}
>  }
> -EXPORT_SYMBOL_GPL(dw_spi_update_config);
> +EXPORT_SYMBOL_NS_GPL(dw_spi_update_config, SPI_DW_CORE);
>  
>  static void dw_spi_irq_setup(struct dw_spi *dws)
>  {
> @@ -945,7 +945,7 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
>  	spi_controller_put(master);
>  	return ret;
>  }
> -EXPORT_SYMBOL_GPL(dw_spi_add_host);
> +EXPORT_SYMBOL_NS_GPL(dw_spi_add_host, SPI_DW_CORE);
>  
>  void dw_spi_remove_host(struct dw_spi *dws)
>  {
> @@ -960,7 +960,7 @@ void dw_spi_remove_host(struct dw_spi *dws)
>  
>  	free_irq(dws->irq, dws->master);
>  }
> -EXPORT_SYMBOL_GPL(dw_spi_remove_host);
> +EXPORT_SYMBOL_NS_GPL(dw_spi_remove_host, SPI_DW_CORE);
>  
>  int dw_spi_suspend_host(struct dw_spi *dws)
>  {
> @@ -973,14 +973,14 @@ int dw_spi_suspend_host(struct dw_spi *dws)
>  	spi_shutdown_chip(dws);
>  	return 0;
>  }
> -EXPORT_SYMBOL_GPL(dw_spi_suspend_host);
> +EXPORT_SYMBOL_NS_GPL(dw_spi_suspend_host, SPI_DW_CORE);
>  
>  int dw_spi_resume_host(struct dw_spi *dws)
>  {
>  	spi_hw_init(&dws->master->dev, dws);
>  	return spi_controller_resume(dws->master);
>  }
> -EXPORT_SYMBOL_GPL(dw_spi_resume_host);
> +EXPORT_SYMBOL_NS_GPL(dw_spi_resume_host, SPI_DW_CORE);
>  
>  MODULE_AUTHOR("Feng Tang <feng.tang@intel.com>");
>  MODULE_DESCRIPTION("Driver for DesignWare SPI controller core");
> diff --git a/drivers/spi/spi-dw-dma.c b/drivers/spi/spi-dw-dma.c
> index a09831c62192..5687ec05d627 100644
> --- a/drivers/spi/spi-dw-dma.c
> +++ b/drivers/spi/spi-dw-dma.c
> @@ -10,6 +10,7 @@
>  #include <linux/dmaengine.h>
>  #include <linux/irqreturn.h>
>  #include <linux/jiffies.h>
> +#include <linux/module.h>
>  #include <linux/pci.h>
>  #include <linux/platform_data/dma-dw.h>
>  #include <linux/spi/spi.h>
> @@ -17,6 +18,8 @@
>  
>  #include "spi-dw.h"

> +MODULE_IMPORT_NS(SPI_DW_CORE);

I would rather see this at the end of file, but it should work either way.

>  #define RX_BUSY		0
>  #define RX_BURST_LEVEL	16
>  #define TX_BUSY		1
> @@ -638,7 +641,7 @@ void dw_spi_dma_setup_mfld(struct dw_spi *dws)
>  {
>  	dws->dma_ops = &dw_spi_dma_mfld_ops;
>  }
> -EXPORT_SYMBOL_GPL(dw_spi_dma_setup_mfld);
> +EXPORT_SYMBOL_NS_GPL(dw_spi_dma_setup_mfld, SPI_DW_CORE);
>  
>  static const struct dw_spi_dma_ops dw_spi_dma_generic_ops = {
>  	.dma_init	= dw_spi_dma_init_generic,
> @@ -653,4 +656,4 @@ void dw_spi_dma_setup_generic(struct dw_spi *dws)
>  {
>  	dws->dma_ops = &dw_spi_dma_generic_ops;
>  }
> -EXPORT_SYMBOL_GPL(dw_spi_dma_setup_generic);
> +EXPORT_SYMBOL_NS_GPL(dw_spi_dma_setup_generic, SPI_DW_CORE);
> diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
> index 17c06039a74d..711f4d3404c5 100644
> --- a/drivers/spi/spi-dw-mmio.c
> +++ b/drivers/spi/spi-dw-mmio.c
> @@ -377,3 +377,4 @@ module_platform_driver(dw_spi_mmio_driver);
>  MODULE_AUTHOR("Jean-Hugues Deschenes <jean-hugues.deschenes@octasic.com>");
>  MODULE_DESCRIPTION("Memory-mapped I/O interface driver for DW SPI Core");
>  MODULE_LICENSE("GPL v2");
> +MODULE_IMPORT_NS(SPI_DW_CORE);
> diff --git a/drivers/spi/spi-dw-pci.c b/drivers/spi/spi-dw-pci.c
> index 8a91cd58102f..5552240fee55 100644
> --- a/drivers/spi/spi-dw-pci.c
> +++ b/drivers/spi/spi-dw-pci.c
> @@ -213,3 +213,4 @@ module_pci_driver(dw_spi_driver);
>  MODULE_AUTHOR("Feng Tang <feng.tang@intel.com>");
>  MODULE_DESCRIPTION("PCI interface driver for DW SPI Core");
>  MODULE_LICENSE("GPL v2");
> +MODULE_IMPORT_NS(SPI_DW_CORE);
> -- 
> 2.33.0
> 

-- 
With Best Regards,
Andy Shevchenko


