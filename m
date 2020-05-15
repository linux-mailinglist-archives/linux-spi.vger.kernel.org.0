Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 859761D530C
	for <lists+linux-spi@lfdr.de>; Fri, 15 May 2020 17:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbgEOPEX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 15 May 2020 11:04:23 -0400
Received: from mga18.intel.com ([134.134.136.126]:15625 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726171AbgEOPDz (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 15 May 2020 11:03:55 -0400
IronPort-SDR: gSJMJU+NZAQr9DsqTBBq2wIOWQLfq3BxecP9zfEBRNuxHTX0FIow1j6r8d8UgqkcXAEa2bzuNK
 TXv6zZj+5XaQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2020 08:03:54 -0700
IronPort-SDR: oeebT3F+ujbIeM9EWX7T/No0xt0Pr8AR5msV70GdGtgm5+5lr2eznhAaLNmS9kKoJGwA4lmXlK
 ZkzISOFVMs1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,395,1583222400"; 
   d="scan'208";a="281243099"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga002.jf.intel.com with ESMTP; 15 May 2020 08:03:49 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jZbsN-006tSa-HL; Fri, 15 May 2020 18:03:51 +0300
Date:   Fri, 15 May 2020 18:03:51 +0300
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
        devicetree@vger.kernel.org, John Garry <john.garry@huawei.com>,
        Chuanhong Guo <gch981213@gmail.com>,
        Masahisa Kojima <masahisa.kojima@linaro.org>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 15/19] spi: dw: Add DW SPI DMA/PCI/MMIO dependency on
 the DW SPI core
Message-ID: <20200515150351.GM1634618@smile.fi.intel.com>
References: <20200508132943.9826-1-Sergey.Semin@baikalelectronics.ru>
 <20200515104758.6934-1-Sergey.Semin@baikalelectronics.ru>
 <20200515104758.6934-16-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515104758.6934-16-Sergey.Semin@baikalelectronics.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, May 15, 2020 at 01:47:54PM +0300, Serge Semin wrote:
> Seeing all of the DW SPI driver components like DW SPI DMA/PCI/MMIO
> depend on the DW SPI core code it's better to use the if-endif
> conditional kernel config statement to signify that common dependency.

Makes sense!
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
>  drivers/spi/Kconfig | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index 6a84f3dad35c..3cdf8310d185 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -226,17 +226,20 @@ config SPI_DESIGNWARE
>  	help
>  	  general driver for SPI controller core from DesignWare
>  
> +if SPI_DESIGNWARE
> +
>  config SPI_DW_DMA
>  	bool "DMA support for DW SPI controller"
> -	depends on SPI_DESIGNWARE
>  
>  config SPI_DW_PCI
>  	tristate "PCI interface driver for DW SPI core"
> -	depends on SPI_DESIGNWARE && PCI
> +	depends on PCI
>  
>  config SPI_DW_MMIO
>  	tristate "Memory-mapped io interface driver for DW SPI core"
> -	depends on SPI_DESIGNWARE
> +	depends on HAS_IOMEM
> +
> +endif
>  
>  config SPI_DLN2
>         tristate "Diolan DLN-2 USB SPI adapter"
> -- 
> 2.25.1
> 

-- 
With Best Regards,
Andy Shevchenko


