Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 916F51D5331
	for <lists+linux-spi@lfdr.de>; Fri, 15 May 2020 17:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbgEOPIV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 15 May 2020 11:08:21 -0400
Received: from mga06.intel.com ([134.134.136.31]:30332 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726248AbgEOPIV (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 15 May 2020 11:08:21 -0400
IronPort-SDR: 03KPQs3+8c13VIvq/NtdVP3rq732cgCH+NnjvI2mK9bJmLaSymBZUcKI9/8Y/TuzLIlfhVz58g
 wuiCCLosyTRA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2020 08:08:21 -0700
IronPort-SDR: KN+Wg87nK8SnMqebrA5QJEz/3xsD/rYTEyQsxaeuNjYdmePiwQbiGrKQN3c/S0v5063fyk0q1N
 z8hCmYZjdaSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,395,1583222400"; 
   d="scan'208";a="253813911"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga008.fm.intel.com with ESMTP; 15 May 2020 08:08:16 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jZbwg-006tV6-Bb; Fri, 15 May 2020 18:08:18 +0300
Date:   Fri, 15 May 2020 18:08:18 +0300
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
Subject: Re: [PATCH v2 17/19] spi: dw: Add DMA support to the DW SPI MMIO
 driver
Message-ID: <20200515150818.GP1634618@smile.fi.intel.com>
References: <20200508132943.9826-1-Sergey.Semin@baikalelectronics.ru>
 <20200515104758.6934-1-Sergey.Semin@baikalelectronics.ru>
 <20200515104758.6934-18-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515104758.6934-18-Sergey.Semin@baikalelectronics.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, May 15, 2020 at 01:47:56PM +0300, Serge Semin wrote:
> Since the common code in the spi-dw-dma.c driver is ready to be used
> by the MMIO driver and now provides a method to generically (on any
> DT or ACPI-based platforms) retrieve the Tx/Rx DMA channel handlers,
> we can use it and a set of the common DW SPI DMA callbacks to enable
> DMA at least for generic "snps,dw-apb-ssi" and "snps,dwc-ssi-1.01a"
> devices.

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
>  drivers/spi/spi-dw-mmio.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
> index 0894b4c09496..e23d0c53a664 100644
> --- a/drivers/spi/spi-dw-mmio.c
> +++ b/drivers/spi/spi-dw-mmio.c
> @@ -149,6 +149,8 @@ static int dw_spi_dw_apb_init(struct platform_device *pdev,
>  	/* Register hook to configure CTRLR0 */
>  	dwsmmio->dws.update_cr0 = dw_spi_update_cr0;
>  
> +	dw_spi_dma_setup_generic(&dwsmmio->dws);
> +
>  	return 0;
>  }
>  
> @@ -158,6 +160,8 @@ static int dw_spi_dwc_ssi_init(struct platform_device *pdev,
>  	/* Register hook to configure CTRLR0 */
>  	dwsmmio->dws.update_cr0 = dw_spi_update_cr0_v1_01a;
>  
> +	dw_spi_dma_setup_generic(&dwsmmio->dws);
> +
>  	return 0;
>  }
>  
> -- 
> 2.25.1
> 

-- 
With Best Regards,
Andy Shevchenko


