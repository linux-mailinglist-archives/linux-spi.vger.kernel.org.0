Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 145C01D51A6
	for <lists+linux-spi@lfdr.de>; Fri, 15 May 2020 16:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbgEOOjW (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 15 May 2020 10:39:22 -0400
Received: from mga12.intel.com ([192.55.52.136]:41217 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726185AbgEOOjW (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 15 May 2020 10:39:22 -0400
IronPort-SDR: zvOcTlVh0ChhPHD28o8CxNU7URMXlbPoaVcqpt1fju4Z/wVs4erDWBKojqv5of2KOK1kOtftmH
 beEK7Z409pKw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2020 07:39:21 -0700
IronPort-SDR: s+Uj+MJhNmT8Ky4Zx3wWhU47RZ0AI+uwbIbC6qc9gcfpOg+ZvxxU8gIqKlAhGGjHcEKQ7FZ3vg
 FPVaUa/PQmuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,395,1583222400"; 
   d="scan'208";a="253807187"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga008.fm.intel.com with ESMTP; 15 May 2020 07:39:17 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jZbUd-006tBY-F6; Fri, 15 May 2020 17:39:19 +0300
Date:   Fri, 15 May 2020 17:39:19 +0300
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
        Arnd Bergmann <arnd@arndb.de>,
        Allison Randal <allison@lohutok.net>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Rob Herring <robh+dt@kernel.org>, linux-mips@vger.kernel.org,
        devicetree@vger.kernel.org,
        Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Jay Fang <f.fangjian@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        YueHaibing <yuehaibing@huawei.com>,
        Stephen Boyd <swboyd@chromium.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 11/19] spi: dw: Initialize paddr in DW SPI MMIO
 private data
Message-ID: <20200515143919.GH1634618@smile.fi.intel.com>
References: <20200508132943.9826-1-Sergey.Semin@baikalelectronics.ru>
 <20200515104758.6934-1-Sergey.Semin@baikalelectronics.ru>
 <20200515104758.6934-12-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515104758.6934-12-Sergey.Semin@baikalelectronics.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, May 15, 2020 at 01:47:50PM +0300, Serge Semin wrote:
> This field is used only for the DW SPI DMA code initialization, that's
> why there were no problems with it being uninitialized in Dw SPI MMIO
> driver. Since in a further patch we are going to introduce the DW SPI DMA
> support in the MMIO version of the driver, lets set the field with the
> physical address of the DW SPI controller registers region.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

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
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Allison Randal <allison@lohutok.net>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Gareth Williams <gareth.williams.jx@renesas.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: linux-mips@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> ---
>  drivers/spi/spi-dw-mmio.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
> index 398f7926cf92..0894b4c09496 100644
> --- a/drivers/spi/spi-dw-mmio.c
> +++ b/drivers/spi/spi-dw-mmio.c
> @@ -184,6 +184,7 @@ static int dw_spi_mmio_probe(struct platform_device *pdev)
>  	int (*init_func)(struct platform_device *pdev,
>  			 struct dw_spi_mmio *dwsmmio);
>  	struct dw_spi_mmio *dwsmmio;
> +	struct resource *mem;
>  	struct dw_spi *dws;
>  	int ret;
>  	int num_cs;
> @@ -196,10 +197,12 @@ static int dw_spi_mmio_probe(struct platform_device *pdev)
>  	dws = &dwsmmio->dws;
>  
>  	/* Get basic io resource and map it */
> -	dws->regs = devm_platform_ioremap_resource(pdev, 0);
> +	dws->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &mem);
>  	if (IS_ERR(dws->regs))
>  		return PTR_ERR(dws->regs);
>  
> +	dws->paddr = mem->start;
> +
>  	dws->irq = platform_get_irq(pdev, 0);
>  	if (dws->irq < 0)
>  		return dws->irq; /* -ENXIO */
> -- 
> 2.25.1
> 

-- 
With Best Regards,
Andy Shevchenko


