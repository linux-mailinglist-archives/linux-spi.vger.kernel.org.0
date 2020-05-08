Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 749E81CB4EB
	for <lists+linux-spi@lfdr.de>; Fri,  8 May 2020 18:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgEHQZB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 8 May 2020 12:25:01 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:43686 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726756AbgEHQZB (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 8 May 2020 12:25:01 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 44FF880307C7;
        Fri,  8 May 2020 16:24:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id FDqnx249YwhR; Fri,  8 May 2020 19:24:56 +0300 (MSK)
Date:   Fri, 8 May 2020 19:24:55 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Mark Brown <broonie@kernel.org>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Lee Jones <lee.jones@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, <linux-mips@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        John Garry <john.garry@huawei.com>,
        Chuanhong Guo <gch981213@gmail.com>,
        Eddie James <eajames@linux.ibm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Masahisa Kojima <masahisa.kojima@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
Subject: Re: [PATCH 2/2] spi: Add Baikal-T1 System Boot SPI Controller driver
Message-ID: <20200508162455.3cgfquqmbx7ep2zf@mobilestation>
References: <20200508093621.31619-1-Sergey.Semin@baikalelectronics.ru>
 <20200508093621.31619-3-Sergey.Semin@baikalelectronics.ru>
 <CAHp75VdtzdX-sOvq2cZdXqGUmU=0rdzQW_USGD_q0D59pUMTWg@mail.gmail.com>
 <20200508101541.e3yxaocuilaiyutg@mobilestation>
 <CAHp75VcaVGHfYN1hjD5eKgpKJkpKEif8NxBGO1YF61_apv82Kg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAHp75VcaVGHfYN1hjD5eKgpKJkpKEif8NxBGO1YF61_apv82Kg@mail.gmail.com>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, May 08, 2020 at 01:26:52PM +0300, Andy Shevchenko wrote:
> On Fri, May 8, 2020 at 1:15 PM Serge Semin
> <Sergey.Semin@baikalelectronics.ru> wrote:
> >
> > On Fri, May 08, 2020 at 01:03:11PM +0300, Andy Shevchenko wrote:
> > > On Fri, May 8, 2020 at 12:37 PM Serge Semin
> > > <Sergey.Semin@baikalelectronics.ru> wrote:
> > > >
> > > > This SPI-controller is a part of the Baikal-T1 System Controller and
> > > > is based on the DW APB SSI IP-core, but with very limited resources:
> > > > no IRQ, no DMA, only a single native chip-select and just 8 bytes Tx/Rx
> > > > FIFO available. In order to provide a transparent initial boot code
> > > > execution this controller is also utilized by an vendor-specific block,
> > > > which provides an CS0 SPI flash direct mapping interface. Since both
> > > > direct mapping and SPI controller normal utilization are mutual exclusive
> > > > only a one of these interfaces can be used to access an external SPI
> > > > slave device. Taking into account the peculiarities of the controller
> > > > registers and physically mapped SPI flash access, very limited resources
> > > > and seeing the normal usecase of the controller is to access an external
> > > > SPI-nor flash, we decided to create a dedicated SPI driver for it.
> > >
> > > It seems a lot of code.
> > > Why can't you use spi-dw-mmio.c et al.?
> >
> > I said above why. Even though the registers set is similar It's too specific
> > to be integrated into the generic DW SSI driver.
> 
> At least you may do at the beginning is to reuse header spi-dw.h and
> put your stuff under
> spi-dw-baikal.c or so. Then, look at the spi-dw.c and check what can
> be reused (I think a lot).

Nah, It's not a lot, barely a few things. What is useful is the registers map
(though it has to be shifted and most of the registers are unused), IO operations
(two small read-write methods with questionable design) and possibly a few lines
of config setting procedure.

You think I didn't had in mind to integrate this controller support into
the generic driver or resuse something from there? If it was worth a try I would
have done it.

-Sergey

> 
> -- 
> With Best Regards,
> Andy Shevchenko
