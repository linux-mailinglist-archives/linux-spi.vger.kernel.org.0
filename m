Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10D641E77ED
	for <lists+linux-spi@lfdr.de>; Fri, 29 May 2020 10:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725836AbgE2IMJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 29 May 2020 04:12:09 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:46466 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725681AbgE2IMJ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 29 May 2020 04:12:09 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id E447B80307C7;
        Fri, 29 May 2020 08:12:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id DkI_dr0PXQ-3; Fri, 29 May 2020 11:12:05 +0300 (MSK)
Date:   Fri, 29 May 2020 11:12:04 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Arnd Bergmann <arnd@arndb.de>, Feng Tang <feng.tang@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>, <linux-mips@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 03/16] spi: dw: Locally wait for the DMA transactions
 completion
Message-ID: <20200529081204.e2j5unvvfikr2y7v@mobilestation>
References: <20200529035915.20790-1-Sergey.Semin@baikalelectronics.ru>
 <20200529035915.20790-4-Sergey.Semin@baikalelectronics.ru>
 <CAHp75VcT2zKnuRW3uxCQtbF0A65cbS20OFpz9sX0hftbjFp1hA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAHp75VcT2zKnuRW3uxCQtbF0A65cbS20OFpz9sX0hftbjFp1hA@mail.gmail.com>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, May 29, 2020 at 10:55:32AM +0300, Andy Shevchenko wrote:
> On Fri, May 29, 2020 at 7:02 AM Serge Semin
> <Sergey.Semin@baikalelectronics.ru> wrote:
> >
> > Even if DMA transactions are finished it doesn't mean that the SPI
> > transfers are also completed. It's specifically concerns the Tx-only
> > SPI transfers, since there might be data left in the SPI Tx FIFO after
> > the DMA engine notifies that the Tx DMA procedure is done. In order to
> > completely fix the problem first the driver has to wait for the DMA
> > transaction completion, then for the corresponding SPI operations to be
> > finished. In this commit we implement the former part of the solution.
> >
> > Note we can't just move the SPI operations wait procedure to the DMA
> > completion callbacks, since these callbacks might be executed in the
> > tasklet context (and they will be in case of the DW DMA). In case of
> > slow SPI bus it can cause significant system performance drop.
> 

> I read commit message, I read the code. What's going on here since you
> repeated xfer_completion (and its wait routine) from SPI core and I'm
> wondering what happened to it? Why we are not calling
> spi_finalize_current_transfer()?

We discussed that in v4. You complained about using ndelay() for slow SPI bus,
which may cause too long atomic context execution. We agreed. Since we can't wait
in the tasklet context and using a dedicated kernel thread for waiting would be too
much, Me and Mark agreed, that even if it causes us of the local wait-function
re-implementation the best approach would be not to use the generic
spi_transfer_wait() method, but instead wait for the DMA transactions locally
in the DMA driver and just return 0 from the transfer_one callback indicating
that the SPI transfer is finished and there is no need for SPI core to wait. As
a lot of DMA-based SPI drivers do.

If you don't understand what the commit message says, just say so. I'll
reformulate it.

-Sergey

> 
> ...
> 
> >         dws->master->cur_msg->status = -EIO;
> > -       spi_finalize_current_transfer(dws->master);
> > +       complete(&dws->dma_completion);
> >         return IRQ_HANDLED;
> 
> ...
> 
> > +static int dw_spi_dma_wait(struct dw_spi *dws, struct spi_transfer *xfer)
> > +{
> > +       unsigned long long ms;
> > +
> > +       ms = xfer->len * MSEC_PER_SEC * BITS_PER_BYTE;
> > +       do_div(ms, xfer->effective_speed_hz);
> > +       ms += ms + 200;
> > +
> > +       if (ms > UINT_MAX)
> > +               ms = UINT_MAX;
> > +
> > +       ms = wait_for_completion_timeout(&dws->dma_completion,
> > +                                        msecs_to_jiffies(ms));
> > +
> > +       if (ms == 0) {
> > +               dev_err(&dws->master->cur_msg->spi->dev,
> > +                       "DMA transaction timed out\n");
> > +               return -ETIMEDOUT;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> >  /*
> >   * dws->dma_chan_busy is set before the dma transfer starts, callback for tx
> >   * channel will clear a corresponding bit.
> > @@ -155,7 +184,7 @@ static void dw_spi_dma_tx_done(void *arg)
> >                 return;
> >
> >         dw_writel(dws, DW_SPI_DMACR, 0);
> > -       spi_finalize_current_transfer(dws->master);
> > +       complete(&dws->dma_completion);
> >  }
> >
> >  static struct dma_async_tx_descriptor *dw_spi_dma_prepare_tx(struct dw_spi *dws,
> > @@ -204,7 +233,7 @@ static void dw_spi_dma_rx_done(void *arg)
> >                 return;
> >
> >         dw_writel(dws, DW_SPI_DMACR, 0);
> > -       spi_finalize_current_transfer(dws->master);
> > +       complete(&dws->dma_completion);
> >  }
> 
> 
> -- 
> With Best Regards,
> Andy Shevchenko
