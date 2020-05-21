Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA24C1DCB4E
	for <lists+linux-spi@lfdr.de>; Thu, 21 May 2020 12:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729008AbgEUKrs (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 21 May 2020 06:47:48 -0400
Received: from mga01.intel.com ([192.55.52.88]:47357 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728720AbgEUKrs (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 21 May 2020 06:47:48 -0400
IronPort-SDR: RN5qEcrqeY5dNqTkv3GtxXBQ/PlouTn1FSrSuTkGFJyRsguG1tJiZdy1l8+Rfbj63Vb4YwLCK7
 2dcvna7d+2Hg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2020 03:47:47 -0700
IronPort-SDR: EbbdmfNXgB5HerMGnt9TrnxUjACn3DwlvQylqK2/2C+wBpBrF77UdyXTgra7sYLt4CgW7O2PoH
 i0PVcBBiO4wA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,417,1583222400"; 
   d="scan'208";a="283008388"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga002.jf.intel.com with ESMTP; 21 May 2020 03:47:41 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jbijn-00818f-QE; Thu, 21 May 2020 13:47:43 +0300
Date:   Thu, 21 May 2020 13:47:43 +0300
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
        Arnd Bergmann <arnd@arndb.de>, linux-mips@vger.kernel.org,
        devicetree@vger.kernel.org, Chuanhong Guo <gch981213@gmail.com>,
        John Garry <john.garry@huawei.com>,
        Eddie James <eajames@linux.ibm.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Masahisa Kojima <masahisa.kojima@linaro.org>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Clement Leger <cleger@kalray.eu>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "wuxu.wu" <wuxu.wu@huawei.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 09/16] spi: dw: Add core suffix to the DW APB SSI core
 source file
Message-ID: <20200521104743.GJ1634618@smile.fi.intel.com>
References: <20200521012206.14472-1-Sergey.Semin@baikalelectronics.ru>
 <20200521012206.14472-10-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521012206.14472-10-Sergey.Semin@baikalelectronics.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, May 21, 2020 at 04:21:59AM +0300, Serge Semin wrote:
> Generic DMA support is going to be part of the DW APB SSI core object.
> In order to preserve the kernel loadable module name as spi-dw.ko, let's
> add the "-core" suffix to the object with generic DW APB SSI code and
> build it into the target spi-dw.ko driver.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>
> Cc: Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>
> Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: Paul Burton <paulburton@kernel.org>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: linux-mips@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> 
> ---
> 
> Changelog v3:
> - This is a new patch added as a result of the discussion with Andy
>   Shevchenko.
> ---
>  drivers/spi/Makefile                    | 1 +
>  drivers/spi/{spi-dw.c => spi-dw-core.c} | 0
>  2 files changed, 1 insertion(+)
>  rename drivers/spi/{spi-dw.c => spi-dw-core.c} (100%)
> 
> diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
> index 28f601327f8c..70ebc2a62e5f 100644
> --- a/drivers/spi/Makefile
> +++ b/drivers/spi/Makefile
> @@ -36,6 +36,7 @@ obj-$(CONFIG_SPI_COLDFIRE_QSPI)		+= spi-coldfire-qspi.o
>  obj-$(CONFIG_SPI_DAVINCI)		+= spi-davinci.o
>  obj-$(CONFIG_SPI_DLN2)			+= spi-dln2.o
>  obj-$(CONFIG_SPI_DESIGNWARE)		+= spi-dw.o
> +spi-dw-y				:= spi-dw-core.o
>  obj-$(CONFIG_SPI_DW_MMIO)		+= spi-dw-mmio.o
>  obj-$(CONFIG_SPI_DW_PCI)		+= spi-dw-midpci.o
>  spi-dw-midpci-objs			:= spi-dw-pci.o spi-dw-mid.o
> diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw-core.c
> similarity index 100%
> rename from drivers/spi/spi-dw.c
> rename to drivers/spi/spi-dw-core.c
> -- 
> 2.25.1
> 

-- 
With Best Regards,
Andy Shevchenko


