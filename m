Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3B8F20B27E
	for <lists+linux-spi@lfdr.de>; Fri, 26 Jun 2020 15:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726169AbgFZN3Z (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 26 Jun 2020 09:29:25 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:60644 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbgFZN3Z (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 26 Jun 2020 09:29:25 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id C6EE880045E5;
        Fri, 26 Jun 2020 13:29:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ipBs7IZ-gJBt; Fri, 26 Jun 2020 16:29:22 +0300 (MSK)
Date:   Fri, 26 Jun 2020 16:29:21 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
Subject: Re: [RFC] spi: dw: Test the last revision of the DMA module
Message-ID: <20200626132921.tygww3k6b74gq6pl@mobilestation>
References: <20200625220808.hac4egxalgn3pcqk@mobilestation>
 <CAHp75VfF3GhjNEgHaQWn+LqbVZVOn3_mORSompexxxRnmiAFcg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAHp75VfF3GhjNEgHaQWn+LqbVZVOn3_mORSompexxxRnmiAFcg@mail.gmail.com>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Jun 26, 2020 at 01:55:53AM +0300, Andy Shevchenko wrote:
> On Fri, Jun 26, 2020 at 1:08 AM Serge Semin
> <Sergey.Semin@baikalelectronics.ru> wrote:
> 
> > Have you tested the recent revision of the DW APB SSI driver with DMA
> > enabled? I am particularly concerned about the next fix in the driver:
> 
> Yes.
> 
> > > +     dw_writel(dws, DW_SPI_DMATDLR, dws->fifo_len - dws->txburst);
> 
> Yes, this line is problematic.
> However we have experiencing another issue with Tx underrun, that's
> why below has not been shared.

Hm, are you sure you meant ?Tx? underrun? DW APB SSI doesn't provide a status
bit of such an error. I don't even know how it might be possible, except a point
when SPI Tx FIFO just gets empty. If you meant SPI <Rx> FIFO underrun, then
it might be due to an invalid Rx DMA channel configuration: something with
BLOCK-length + DST_TR_WITDH + BURST-length setting. Though I am not sure it
could be connected with any of my recent patches for DW APB SSI or DW DMAC.

> 
> > Generally speaking it must work (even DW APB SSI/DMA databook suggests to have
> > such DMATDLR setting), but in our case of a relatively slow DMA engine (it's
> > clocked with just twice higher frequency with respect to the max SPI bus
> > speed) sometimes SPI Rx FIFO gets overflown when SPI bus is configured to work
> > with maximum speed (there are multiple reasons why this happens, but generally
> > speaking all of them matter only due to the relatively slow DMA engine). The
> > problem is fixed by reducing a value written into the DMATDLR register.
> >
> > I am wondering whether you've tested the last revision of the driver and it
> > worked for your version of the DW APB SSI + DW DMAC IPs. AFAIU DMA engine on
> > your devices is faster than on ours and has LLPs supported. So if you haven't
> > noticed any problem in the recent driver, then I'll send a fixup for our version
> > of the DW APB SSI block only (I'll have to introduce a new compatible string).
> > Otherwise I could get back a setting of dws->txburst into the DW_SPI_DMATDLR
> > register, which isn't that optimal as the current DMATDLR setting
> > of (fifo_len - txburst), but at least will make things working for all DMAs.
> 

> That's what I have locally.
> 
> commit 43d9abb2711f5096e969adcf1a2fb6456fa6e275 (HEAD -> topic/ehl-dma)
> Author: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Date:   Tue Jun 2 15:53:03 2020 +0300
> 
>     DEBUG SPI dw (burst fix?)
> 
>     Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> diff --git a/drivers/spi/spi-dw-dma.c b/drivers/spi/spi-dw-dma.c
> index 5986c520b196..79342528b1f4 100644
> --- a/drivers/spi/spi-dw-dma.c
> +++ b/drivers/spi/spi-dw-dma.c
> @@ -373,7 +373,7 @@ static int dw_spi_dma_setup(struct dw_spi *dws,
> struct spi_transfer *xfer)
>         u16 imr = 0, dma_ctrl = 0;
> 
>         dw_writel(dws, DW_SPI_DMARDLR, dws->rxburst - 1);
> -       dw_writel(dws, DW_SPI_DMATDLR, dws->fifo_len - dws->txburst);
> +       dw_writel(dws, DW_SPI_DMATDLR, dws->txburst);

Yep, that will solve the problem. Though in my case of setting something
like: 
> -       dw_writel(dws, DW_SPI_DMATDLR, dws->fifo_len - dws->txburst);
> +       dw_writel(dws, DW_SPI_DMATDLR, dws->fifo_len / 2 - dws->txburst);

also worked. By doing so we artificially specify a Tx FIFO depth limitation,
which implicitly slows the "SPI Tx <-> Tx DMA channel" down, so occasionally,
if SPI Tx is fast enough while Tx DMA channel isn't, the SPI Tx FIFO might
even get emptied, but at least it will give enough time for the
"SPI Rx <-> Rx DMA channel" pair to fetch the incoming SPI traffic on time and
place the data into the memory (I suppose a text like this should be in a
comment above the line with the DMATDLR register setting). In my case I've
noticed this problem only when I executed several background user-space processes
intensively working with memory (like memory testbenches or just
"dd if=/dev/mem ..." like one-liner). My theory is that the background processes
implicitly slowed the Rx DMA channel down in a way so occasionally the internal
DMA FIFO's got full, due to which the Rx DMA channel couldn't handle the SPI Rx
handshaking interface requests on time to fetch data from the SPI Rx FIFO, so
the SPI Rx FIFO gets overflown. That chain of unfortunate problems is most likely to
happen in case if SPI-bus is fast enough. Obviously if I decrease the SPI bus
frequency, then no overflow will happen.

In case of our hardware setting DMATDLR with a Tx-burst length isn't enough to
completely prevent the SPI Rx FIFO overflow error. We also have to send SG list
entries one-by-one in order to solve the problem with DMA Tx LLP reloaded faster
than the DMA Rx LLP (remember the noLLP problem we've discussed in the DW DMA
mailing list?).

Anyway sorry for the inconvenience my patch caused. I'll send a fixup patch
soon, which will get back the DW_SPI_DMATDLR setting with just "dws->txburst"
value. In addition to that I've discovered a few optimizations for the DW DMAC
driver including a one to speed up the DEV_TO_MEM DMA-slave channel (which will
be useful for the DW APB SSI + DW DMA combination). I'll send a new
DW DMAC-related patchset soon after the current one is finally accepted by Vinod.)

-Sergey

> 
> 
> 
> -- 
> With Best Regards,
> Andy Shevchenko
