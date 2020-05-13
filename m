Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7AE1D12AD
	for <lists+linux-spi@lfdr.de>; Wed, 13 May 2020 14:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731809AbgEMMaj (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 13 May 2020 08:30:39 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:57894 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbgEMMai (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 13 May 2020 08:30:38 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 83C56803088B;
        Wed, 13 May 2020 12:30:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id o_-9KXxNQ0-u; Wed, 13 May 2020 15:30:35 +0300 (MSK)
Date:   Wed, 13 May 2020 15:30:33 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Allison Randal <allison@lohutok.net>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Rob Herring <robh+dt@kernel.org>, <linux-mips@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Stephen Boyd <swboyd@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        YueHaibing <yuehaibing@huawei.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 13/17] spi: dw: Initialize paddr in DW SPI MMIO private
 data
Message-ID: <20200513123033.in3uksakteze3y5t@mobilestation>
References: <20200508132943.9826-1-Sergey.Semin@baikalelectronics.ru>
 <20200508132943.9826-14-Sergey.Semin@baikalelectronics.ru>
 <20200508192144.GT185537@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200508192144.GT185537@smile.fi.intel.com>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, May 08, 2020 at 10:21:44PM +0300, Andy Shevchenko wrote:
> On Fri, May 08, 2020 at 04:29:38PM +0300, Serge Semin wrote:
> > This field is used only for the DW SPI DMA code initialization, that's
> > why there were no problems with it being uninitialized in Dw SPI MMIO
> > driver. Since in a further patch we are going to introduce the DW SPI DMA
> > support in the MMIO version of the driver, lets set the field with the
> > physical address of the DW SPI controller registers region.
> 
> ...
> 
> > -	dws->regs = devm_platform_ioremap_resource(pdev, 0);
> > +	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	dws->regs = devm_ioremap_resource(&pdev->dev, mem);
> 

> There is a helper
> 	dws->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &mem);

Oh, good point. It has been just added, in kernel v5.7. v5.6 didn't provide such
a convenient helper. Thanks for the suggestion.

-Sergey

> 
> 
> >  	if (IS_ERR(dws->regs)) {
> >  		dev_err(&pdev->dev, "SPI region map failed\n");
> >  		return PTR_ERR(dws->regs);
> >  	}
> > +	dws->paddr = mem->start;
> >  
> >  	dws->irq = platform_get_irq(pdev, 0);
> >  	if (dws->irq < 0)
> > -- 
> > 2.25.1
> > 
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
