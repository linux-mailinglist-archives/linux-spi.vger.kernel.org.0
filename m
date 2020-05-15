Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5B861D52E5
	for <lists+linux-spi@lfdr.de>; Fri, 15 May 2020 17:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbgEOPCz (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 15 May 2020 11:02:55 -0400
Received: from mga01.intel.com ([192.55.52.88]:37779 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726144AbgEOPCz (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 15 May 2020 11:02:55 -0400
IronPort-SDR: u+rA+49iOEPwsbt5dbBxeyPlKRnijZBiXeGfVBdKT/40l157xFP6U+clmRKIuvzI5NgskqgZ3A
 MG7Yq/MwXv0Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2020 08:02:55 -0700
IronPort-SDR: pPF5tDZcqhcLLPzgTY2JMxf40nbuiZdzldG4JbZkozpoJFkWqLEGENyw6lvT2Up2dOxF0YS3Wh
 d8P87UJjILpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,395,1583222400"; 
   d="scan'208";a="464752447"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga005.fm.intel.com with ESMTP; 15 May 2020 08:02:50 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jZbrQ-006tS4-AY; Fri, 15 May 2020 18:02:52 +0300
Date:   Fri, 15 May 2020 18:02:52 +0300
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
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Masahisa Kojima <masahisa.kojima@linaro.org>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 14/19] spi: dw: Remove DW DMA code dependency from
 DW_DMAC_PCI
Message-ID: <20200515150252.GL1634618@smile.fi.intel.com>
References: <20200508132943.9826-1-Sergey.Semin@baikalelectronics.ru>
 <20200515104758.6934-1-Sergey.Semin@baikalelectronics.ru>
 <20200515104758.6934-15-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515104758.6934-15-Sergey.Semin@baikalelectronics.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, May 15, 2020 at 01:47:53PM +0300, Serge Semin wrote:
> Since there is a generic method available to initialize the DW SPI DMA
> interface on any DT and ACPI-based platforms, which in general can be
> designed with not only DW DMAC but with any DMA engine on board, we can
> freely remove the CONFIG_DW_DMAC_PCI config from dependency list of
> CONFIG_SPI_DW_DMA. Especially seeing that we don't use anything DW DMAC
> specific in the new driver.

Right, and used data structures are always available at compile time.
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

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
>  drivers/spi/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index 03b061975f70..6a84f3dad35c 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -228,7 +228,7 @@ config SPI_DESIGNWARE
>  
>  config SPI_DW_DMA
>  	bool "DMA support for DW SPI controller"
> -	depends on SPI_DESIGNWARE && DW_DMAC_PCI
> +	depends on SPI_DESIGNWARE
>  
>  config SPI_DW_PCI
>  	tristate "PCI interface driver for DW SPI core"
> -- 
> 2.25.1
> 

-- 
With Best Regards,
Andy Shevchenko


