Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 644551D7A42
	for <lists+linux-spi@lfdr.de>; Mon, 18 May 2020 15:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbgERNnM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 18 May 2020 09:43:12 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:47766 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726726AbgERNnM (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 18 May 2020 09:43:12 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id A21AA8030807;
        Mon, 18 May 2020 13:43:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id P0oDyOYnwCBc; Mon, 18 May 2020 16:43:08 +0300 (MSK)
Date:   Mon, 18 May 2020 16:43:06 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Allison Randal <allison@lohutok.net>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Rob Herring <robh+dt@kernel.org>, <linux-mips@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Clement Leger <cleger@kalray.eu>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 10/19] spi: dw: Use DMA max burst to set the request
 thresholds
Message-ID: <20200518134306.7rvydoasv7pmxwxl@mobilestation>
References: <20200508132943.9826-1-Sergey.Semin@baikalelectronics.ru>
 <20200515104758.6934-1-Sergey.Semin@baikalelectronics.ru>
 <20200515104758.6934-11-Sergey.Semin@baikalelectronics.ru>
 <20200515143842.GG1634618@smile.fi.intel.com>
 <20200516200133.wmaqnfjbr7234fzo@mobilestation>
 <20200518110343.GY1634618@smile.fi.intel.com>
 <20200518125253.r4fpr4mjflclqpym@mobilestation>
 <CAHp75VeMcv-hQViCANQARiNh0LwmugsDWk=MF1c5E3t7z5h02Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAHp75VeMcv-hQViCANQARiNh0LwmugsDWk=MF1c5E3t7z5h02Q@mail.gmail.com>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, May 18, 2020 at 04:25:20PM +0300, Andy Shevchenko wrote:
> On Mon, May 18, 2020 at 3:53 PM Serge Semin
> <Sergey.Semin@baikalelectronics.ru> wrote:
> > On Mon, May 18, 2020 at 02:03:43PM +0300, Andy Shevchenko wrote:
> > > On Sat, May 16, 2020 at 11:01:33PM +0300, Serge Semin wrote:
> > > > On Fri, May 15, 2020 at 05:38:42PM +0300, Andy Shevchenko wrote:
> > > > > On Fri, May 15, 2020 at 01:47:49PM +0300, Serge Semin wrote:
> 
> ...
> 
> > > > > >         struct dma_chan         *txchan;
> > > > > > +       u32                     txburst;
> > > > > >         struct dma_chan         *rxchan;
> > > > > > +       u32                     rxburst;
> > > > >
> > > > > Leave u32 together, it may be optimal on 64-bit architectures where ABIs require padding.
> > > >
> > > > It's not like anyone cared about padding in this structure in the first place)
> > >
> > > I think I have been caring (to some extend).
> >
> > Well, If you have then instead of asking to rearrange just two members (which
> > by the way finely grouped by the Tx-Rx affiliation) why not sending a
> > patch, which would refactor the whole structure so to be optimal for the x64
> > platforms? I don't really see why this gets very important for you seeing
> > Mark is Ok with this. My current commit follows the common driver design
> > including the DW SSI data members grouping. On the second thought I'll leave
> > it as is then.
> 
> Again same issue here. What is really easy to do for you here, will
> become a burden and additional churn to anybody else.
> So, why not to minimize it in the first place? Same with comma in
> another patch. Sorry, I really don't get it.

If comma is more or less understandable (though adding it is absolutely
redundant there and doesn't worth even a bit of time spending for the
discussion), here you consider the patch from padding point of view.
The driver developer didn't care about it, but did care about grouping the
members in a corresponding way. The padding burden will be there anyway and
should be fixed for the whole structure in an additional patch. Until then
the way of grouping should be preserved.

-Sergey

> 
> -- 
> With Best Regards,
> Andy Shevchenko
