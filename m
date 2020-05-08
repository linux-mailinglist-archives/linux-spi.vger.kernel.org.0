Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8892B1CB832
	for <lists+linux-spi@lfdr.de>; Fri,  8 May 2020 21:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgEHTV5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 8 May 2020 15:21:57 -0400
Received: from mga09.intel.com ([134.134.136.24]:41431 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726807AbgEHTV5 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 8 May 2020 15:21:57 -0400
IronPort-SDR: TxLCXveHalteOVedoKqHRLv0VSbSLPGXJ8ynLSq0G8mu0My3SJ/jXXYyZJgdeaS9Lsy7PS2bm9
 VZPWlhU41DFA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2020 12:21:50 -0700
IronPort-SDR: WtEjrSXbSnOWs5TBQNk5R7op6mLpBt6gGXyX97G5Ac5a/xqHKi5k55kCWw70iiMy8Jm7xxgn8G
 lvOn7hsN4uMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,368,1583222400"; 
   d="scan'208";a="462690689"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga006.fm.intel.com with ESMTP; 08 May 2020 12:21:41 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jX8Z6-005T5P-5V; Fri, 08 May 2020 22:21:44 +0300
Date:   Fri, 8 May 2020 22:21:44 +0300
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
        devicetree@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        YueHaibing <yuehaibing@huawei.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/17] spi: dw: Initialize paddr in DW SPI MMIO private
 data
Message-ID: <20200508192144.GT185537@smile.fi.intel.com>
References: <20200508132943.9826-1-Sergey.Semin@baikalelectronics.ru>
 <20200508132943.9826-14-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508132943.9826-14-Sergey.Semin@baikalelectronics.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, May 08, 2020 at 04:29:38PM +0300, Serge Semin wrote:
> This field is used only for the DW SPI DMA code initialization, that's
> why there were no problems with it being uninitialized in Dw SPI MMIO
> driver. Since in a further patch we are going to introduce the DW SPI DMA
> support in the MMIO version of the driver, lets set the field with the
> physical address of the DW SPI controller registers region.

...

> -	dws->regs = devm_platform_ioremap_resource(pdev, 0);
> +	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	dws->regs = devm_ioremap_resource(&pdev->dev, mem);

There is a helper
	dws->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &mem);


>  	if (IS_ERR(dws->regs)) {
>  		dev_err(&pdev->dev, "SPI region map failed\n");
>  		return PTR_ERR(dws->regs);
>  	}
> +	dws->paddr = mem->start;
>  
>  	dws->irq = platform_get_irq(pdev, 0);
>  	if (dws->irq < 0)
> -- 
> 2.25.1
> 

-- 
With Best Regards,
Andy Shevchenko


