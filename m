Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DBCC4507D2
	for <lists+linux-spi@lfdr.de>; Mon, 15 Nov 2021 16:03:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232204AbhKOPGq (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 15 Nov 2021 10:06:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232203AbhKOPGq (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 15 Nov 2021 10:06:46 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D9E9C061714;
        Mon, 15 Nov 2021 07:03:49 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id 13so36156068ljj.11;
        Mon, 15 Nov 2021 07:03:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CSy92pFzsZRQzB8VSXcLRKMYjJ0F9fLrjJbRvXaFW4I=;
        b=maZVkPyfoqAvNfNKkmvlE4j9m0HscMl9azH23A/OPinJb7T38nGyoe/+uvalwRzJqi
         Eu93zi+hiw3sec70zIU5onuVhhilgiv8YXxgiYhpSktBTIpz1LPu/Jm3fzlcHWaNf9YY
         ceJVuQ2+zymkILD+nbqxzVVU/2QAAL+dnm/PAXLiZrKlgcc3y69EgNBdJwAghpo8pwVm
         7BZH2SNZ34UnjCUU78vgB5/fAWMlSNybr8svPRmveUsionHGnIeNN76LAHgprPQ+p6sw
         U1Gwnz7NUC6EbJjts4YwAPsqAjYx4ld8PUmgyoF0yKizfMg/osQtzh7OwfbZt7Liz6Gh
         1g1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CSy92pFzsZRQzB8VSXcLRKMYjJ0F9fLrjJbRvXaFW4I=;
        b=QrZ0TGG6htjTXQLfr1l7E1DFysPwhOUvwHNm33aRMEc/9+ouCxgLURQZanqtoedQOI
         WII1PAWpn2A9CoDI6F4iA3B3EybFjJRHVD5wOv8QZS4g4ml3fxexETmcTIU6Ln/zS5ev
         w1y6A7ds8s2tPOCJkE5pxMx+Dv8D1dVFJ+5v2cvjEpJCnhK5L8RA1zgygOHWPk9bV7sq
         NIj3CnHWD3iSh/HT59fPd8Hhe3JuB6nbEwDipruaPkFkH4bpUqlJpfHvziUMr9gL9esv
         kF/UTGmN061tl87gnhc594wtbq6Jl1pPDYuyz+T7+UDL1tC/wLW2mKEbws3foSFEUjaC
         FvHA==
X-Gm-Message-State: AOAM5325TnPYN8Q/DKdQKxPz/mJ1Eq7aWdycKHUvBa0D8aVovw+KgBFp
        TNmlOyPgO98Bd5o1aWYs/FU=
X-Google-Smtp-Source: ABdhPJyBVpX01ZHfU2xqkwDDNB3FVin+WSkejS84XjXa/HNXYkSGrFQBjOuQKBLF8/FJL9tiqrt6Eg==
X-Received: by 2002:a2e:b894:: with SMTP id r20mr41473581ljp.304.1636988627290;
        Mon, 15 Nov 2021 07:03:47 -0800 (PST)
Received: from mobilestation ([95.79.188.236])
        by smtp.gmail.com with ESMTPSA id d4sm1442920lfg.153.2021.11.15.07.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 07:03:46 -0800 (PST)
Date:   Mon, 15 Nov 2021 18:03:44 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Mark Brown <broonie@kernel.org>,
        Nandhini Srikandan <nandhini.srikandan@intel.com>,
        Andy Shevchenko <andy@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] spi: dw: Add a symbols namespace for the core
 module
Message-ID: <20211115150344.sgrqqnl7nudntrqx@mobilestation>
References: <20211114223026.13359-1-Sergey.Semin@baikalelectronics.ru>
 <20211114223026.13359-2-Sergey.Semin@baikalelectronics.ru>
 <YZJuPrnhupbnPxGt@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YZJuPrnhupbnPxGt@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Nov 15, 2021 at 04:27:10PM +0200, Andy Shevchenko wrote:
> On Mon, Nov 15, 2021 at 01:30:21AM +0300, Serge Semin wrote:
> > The exported from the DW SPI driver core symbols are only used by the
> > spi-dw-{dma,mmio,pci,bt1}.o objects. Add these symbols to a separate
> > namespace then and make sure the depended modules have it imported.
> > 
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> 
> Thanks!
> 

> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> 
> See also below.

Thanks. But see below.

> 
> > ---
> > 
> > Changelog v2:
> > - This is a new patch created as of Andy' suggestion.
> > ---
> >  drivers/spi/spi-dw-bt1.c  |  1 +
> >  drivers/spi/spi-dw-core.c | 14 +++++++-------
> >  drivers/spi/spi-dw-dma.c  |  7 +++++--
> >  drivers/spi/spi-dw-mmio.c |  1 +
> >  drivers/spi/spi-dw-pci.c  |  1 +
> >  5 files changed, 15 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/spi/spi-dw-bt1.c b/drivers/spi/spi-dw-bt1.c
> > index 5be6b7b80c21..ac7e4f30d1da 100644
> > --- a/drivers/spi/spi-dw-bt1.c
> > +++ b/drivers/spi/spi-dw-bt1.c
> > @@ -339,3 +339,4 @@ module_platform_driver(dw_spi_bt1_driver);
> >  MODULE_AUTHOR("Serge Semin <Sergey.Semin@baikalelectronics.ru>");
> >  MODULE_DESCRIPTION("Baikal-T1 System Boot SPI Controller driver");
> >  MODULE_LICENSE("GPL v2");
> > +MODULE_IMPORT_NS(SPI_DW_CORE);
> > diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
> > index a305074c482e..a14940403ab4 100644
> > --- a/drivers/spi/spi-dw-core.c
> > +++ b/drivers/spi/spi-dw-core.c
> > @@ -106,7 +106,7 @@ void dw_spi_set_cs(struct spi_device *spi, bool enable)
> >  	else
> >  		dw_writel(dws, DW_SPI_SER, 0);
> >  }
> > -EXPORT_SYMBOL_GPL(dw_spi_set_cs);
> > +EXPORT_SYMBOL_NS_GPL(dw_spi_set_cs, SPI_DW_CORE);
> >  
> >  /* Return the max entries we can fill into tx fifo */
> >  static inline u32 tx_max(struct dw_spi *dws)
> > @@ -210,7 +210,7 @@ int dw_spi_check_status(struct dw_spi *dws, bool raw)
> >  
> >  	return ret;
> >  }
> > -EXPORT_SYMBOL_GPL(dw_spi_check_status);
> > +EXPORT_SYMBOL_NS_GPL(dw_spi_check_status, SPI_DW_CORE);
> >  
> >  static irqreturn_t dw_spi_transfer_handler(struct dw_spi *dws)
> >  {
> > @@ -345,7 +345,7 @@ void dw_spi_update_config(struct dw_spi *dws, struct spi_device *spi,
> >  		dws->cur_rx_sample_dly = chip->rx_sample_dly;
> >  	}
> >  }
> > -EXPORT_SYMBOL_GPL(dw_spi_update_config);
> > +EXPORT_SYMBOL_NS_GPL(dw_spi_update_config, SPI_DW_CORE);
> >  
> >  static void dw_spi_irq_setup(struct dw_spi *dws)
> >  {
> > @@ -945,7 +945,7 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
> >  	spi_controller_put(master);
> >  	return ret;
> >  }
> > -EXPORT_SYMBOL_GPL(dw_spi_add_host);
> > +EXPORT_SYMBOL_NS_GPL(dw_spi_add_host, SPI_DW_CORE);
> >  
> >  void dw_spi_remove_host(struct dw_spi *dws)
> >  {
> > @@ -960,7 +960,7 @@ void dw_spi_remove_host(struct dw_spi *dws)
> >  
> >  	free_irq(dws->irq, dws->master);
> >  }
> > -EXPORT_SYMBOL_GPL(dw_spi_remove_host);
> > +EXPORT_SYMBOL_NS_GPL(dw_spi_remove_host, SPI_DW_CORE);
> >  
> >  int dw_spi_suspend_host(struct dw_spi *dws)
> >  {
> > @@ -973,14 +973,14 @@ int dw_spi_suspend_host(struct dw_spi *dws)
> >  	spi_shutdown_chip(dws);
> >  	return 0;
> >  }
> > -EXPORT_SYMBOL_GPL(dw_spi_suspend_host);
> > +EXPORT_SYMBOL_NS_GPL(dw_spi_suspend_host, SPI_DW_CORE);
> >  
> >  int dw_spi_resume_host(struct dw_spi *dws)
> >  {
> >  	spi_hw_init(&dws->master->dev, dws);
> >  	return spi_controller_resume(dws->master);
> >  }
> > -EXPORT_SYMBOL_GPL(dw_spi_resume_host);
> > +EXPORT_SYMBOL_NS_GPL(dw_spi_resume_host, SPI_DW_CORE);
> >  
> >  MODULE_AUTHOR("Feng Tang <feng.tang@intel.com>");
> >  MODULE_DESCRIPTION("Driver for DesignWare SPI controller core");
> > diff --git a/drivers/spi/spi-dw-dma.c b/drivers/spi/spi-dw-dma.c
> > index a09831c62192..5687ec05d627 100644
> > --- a/drivers/spi/spi-dw-dma.c
> > +++ b/drivers/spi/spi-dw-dma.c
> > @@ -10,6 +10,7 @@
> >  #include <linux/dmaengine.h>
> >  #include <linux/irqreturn.h>
> >  #include <linux/jiffies.h>
> > +#include <linux/module.h>
> >  #include <linux/pci.h>
> >  #include <linux/platform_data/dma-dw.h>
> >  #include <linux/spi/spi.h>
> > @@ -17,6 +18,8 @@
> >  
> >  #include "spi-dw.h"
> 

> > +MODULE_IMPORT_NS(SPI_DW_CORE);
> 
> I would rather see this at the end of file, but it should work either way.

I've just realized it, do I really need the
namespace imported in this object at all?.. It's linked into the
spi-dw-core.ko. See drivers/spi/Makefile:
obj-$(CONFIG_SPI_DESIGNWARE)            += spi-dw.o
spi-dw-y                                := spi-dw-core.o
spi-dw-$(CONFIG_SPI_DW_DMA)             += spi-dw-dma.o
so the object must have got the same namespace.

Yeah, most likely I shouldn't have used the MODULE_IMPORT_NS() here...

-Sergey

> 
> >  #define RX_BUSY		0
> >  #define RX_BURST_LEVEL	16
> >  #define TX_BUSY		1
> > @@ -638,7 +641,7 @@ void dw_spi_dma_setup_mfld(struct dw_spi *dws)
> >  {
> >  	dws->dma_ops = &dw_spi_dma_mfld_ops;
> >  }
> > -EXPORT_SYMBOL_GPL(dw_spi_dma_setup_mfld);
> > +EXPORT_SYMBOL_NS_GPL(dw_spi_dma_setup_mfld, SPI_DW_CORE);
> >  
> >  static const struct dw_spi_dma_ops dw_spi_dma_generic_ops = {
> >  	.dma_init	= dw_spi_dma_init_generic,
> > @@ -653,4 +656,4 @@ void dw_spi_dma_setup_generic(struct dw_spi *dws)
> >  {
> >  	dws->dma_ops = &dw_spi_dma_generic_ops;
> >  }
> > -EXPORT_SYMBOL_GPL(dw_spi_dma_setup_generic);
> > +EXPORT_SYMBOL_NS_GPL(dw_spi_dma_setup_generic, SPI_DW_CORE);
> > diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
> > index 17c06039a74d..711f4d3404c5 100644
> > --- a/drivers/spi/spi-dw-mmio.c
> > +++ b/drivers/spi/spi-dw-mmio.c
> > @@ -377,3 +377,4 @@ module_platform_driver(dw_spi_mmio_driver);
> >  MODULE_AUTHOR("Jean-Hugues Deschenes <jean-hugues.deschenes@octasic.com>");
> >  MODULE_DESCRIPTION("Memory-mapped I/O interface driver for DW SPI Core");
> >  MODULE_LICENSE("GPL v2");
> > +MODULE_IMPORT_NS(SPI_DW_CORE);
> > diff --git a/drivers/spi/spi-dw-pci.c b/drivers/spi/spi-dw-pci.c
> > index 8a91cd58102f..5552240fee55 100644
> > --- a/drivers/spi/spi-dw-pci.c
> > +++ b/drivers/spi/spi-dw-pci.c
> > @@ -213,3 +213,4 @@ module_pci_driver(dw_spi_driver);
> >  MODULE_AUTHOR("Feng Tang <feng.tang@intel.com>");
> >  MODULE_DESCRIPTION("PCI interface driver for DW SPI Core");
> >  MODULE_LICENSE("GPL v2");
> > +MODULE_IMPORT_NS(SPI_DW_CORE);
> > -- 
> > 2.33.0
> > 
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
