Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94CD41E79EB
	for <lists+linux-spi@lfdr.de>; Fri, 29 May 2020 11:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725790AbgE2J4s (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 29 May 2020 05:56:48 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:46958 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725681AbgE2J4s (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 29 May 2020 05:56:48 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id E2EF08030807;
        Fri, 29 May 2020 09:56:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Vh2S5JHfX0OB; Fri, 29 May 2020 12:56:44 +0300 (MSK)
Date:   Fri, 29 May 2020 12:56:43 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Arnd Bergmann <arnd@arndb.de>, Feng Tang <feng.tang@intel.com>,
        Rob Herring <robh+dt@kernel.org>, <linux-mips@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 03/16] spi: dw: Locally wait for the DMA transactions
 completion
Message-ID: <20200529095643.q3pa5lqg63dgf3kf@mobilestation>
References: <20200529035915.20790-1-Sergey.Semin@baikalelectronics.ru>
 <20200529035915.20790-4-Sergey.Semin@baikalelectronics.ru>
 <CAHp75VcT2zKnuRW3uxCQtbF0A65cbS20OFpz9sX0hftbjFp1hA@mail.gmail.com>
 <20200529081204.e2j5unvvfikr2y7v@mobilestation>
 <20200529092610.GX1634618@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200529092610.GX1634618@smile.fi.intel.com>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, May 29, 2020 at 12:26:10PM +0300, Andy Shevchenko wrote:
> On Fri, May 29, 2020 at 11:12:04AM +0300, Serge Semin wrote:
> > On Fri, May 29, 2020 at 10:55:32AM +0300, Andy Shevchenko wrote:
> > > On Fri, May 29, 2020 at 7:02 AM Serge Semin
> > > <Sergey.Semin@baikalelectronics.ru> wrote:
> > > >
> > > > Even if DMA transactions are finished it doesn't mean that the SPI
> > > > transfers are also completed. It's specifically concerns the Tx-only
> > > > SPI transfers, since there might be data left in the SPI Tx FIFO after
> > > > the DMA engine notifies that the Tx DMA procedure is done. In order to
> > > > completely fix the problem first the driver has to wait for the DMA
> > > > transaction completion, then for the corresponding SPI operations to be
> > > > finished. In this commit we implement the former part of the solution.
> > > >
> > > > Note we can't just move the SPI operations wait procedure to the DMA
> > > > completion callbacks, since these callbacks might be executed in the
> > > > tasklet context (and they will be in case of the DW DMA). In case of
> > > > slow SPI bus it can cause significant system performance drop.
> > > 
> > 
> > > I read commit message, I read the code. What's going on here since you
> > > repeated xfer_completion (and its wait routine) from SPI core and I'm
> > > wondering what happened to it? Why we are not calling
> > > spi_finalize_current_transfer()?
> > 
> > We discussed that in v4. You complained about using ndelay() for slow SPI bus,
> > which may cause too long atomic context execution. We agreed. Since we can't wait
> > in the tasklet context and using a dedicated kernel thread for waiting would be too
> > much, Me and Mark agreed, that
> 

> > even if it causes us of the local wait-function
> > re-implementation the best approach would be not to use the generic
> > spi_transfer_wait() method, but instead wait for the DMA transactions locally
> > in the DMA driver and just return 0 from the transfer_one callback indicating
> > that the SPI transfer is finished and there is no need for SPI core to wait. As
> > a lot of DMA-based SPI drivers do.
> 
> The above is missed in the commit message.
> 
> > If you don't understand what the commit message says, just say so. I'll
> > reformulate it.
> 
> See above. A bit of elaboration would be good. Thank you!

Agreed. I'll create a more detailed commit description, which will have the
info you cited.

-Sergey

> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
