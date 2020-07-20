Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5959C225CED
	for <lists+linux-spi@lfdr.de>; Mon, 20 Jul 2020 12:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728348AbgGTKv4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 20 Jul 2020 06:51:56 -0400
Received: from mga01.intel.com ([192.55.52.88]:58387 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728273AbgGTKv4 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 20 Jul 2020 06:51:56 -0400
IronPort-SDR: c8asirTTtQNL9ATHToit3YEB8TuSWK2bKTRMxi8Igf6c7Wjeg3yeDLTTsL39eybPaxtkcxSmwH
 kG/gl27aUrZw==
X-IronPort-AV: E=McAfee;i="6000,8403,9687"; a="168018623"
X-IronPort-AV: E=Sophos;i="5.75,374,1589266800"; 
   d="scan'208";a="168018623"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2020 03:51:56 -0700
IronPort-SDR: yWvLB816gbs2y2UuzTblZ+s52FJse74tmtF0K6dpQmkQLbSIRTUZLREdN64h1T3vi/2fWlVQcV
 vydBNbItlpyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,374,1589266800"; 
   d="scan'208";a="301234634"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga002.jf.intel.com with ESMTP; 20 Jul 2020 03:51:54 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1jxTOl-002rnX-9a; Mon, 20 Jul 2020 13:51:55 +0300
Date:   Mon, 20 Jul 2020 13:51:55 +0300
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
Subject: Re: [RFC] spi: dw: Test the last revision of the DMA module
Message-ID: <20200720105155.GT3703480@smile.fi.intel.com>
References: <20200625220808.hac4egxalgn3pcqk@mobilestation>
 <CAHp75VfF3GhjNEgHaQWn+LqbVZVOn3_mORSompexxxRnmiAFcg@mail.gmail.com>
 <20200626132921.tygww3k6b74gq6pl@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200626132921.tygww3k6b74gq6pl@mobilestation>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Jun 26, 2020 at 04:29:21PM +0300, Serge Semin wrote:
> On Fri, Jun 26, 2020 at 01:55:53AM +0300, Andy Shevchenko wrote:
> > On Fri, Jun 26, 2020 at 1:08 AM Serge Semin
> > <Sergey.Semin@baikalelectronics.ru> wrote:
> > 
> > > Have you tested the recent revision of the DW APB SSI driver with DMA
> > > enabled? I am particularly concerned about the next fix in the driver:
> > 
> > Yes.
> > 
> > > > +     dw_writel(dws, DW_SPI_DMATDLR, dws->fifo_len - dws->txburst);
> > 
> > Yes, this line is problematic.
> > However we have experiencing another issue with Tx underrun, that's
> > why below has not been shared.
> 
> Hm, are you sure you meant ?Tx? underrun? DW APB SSI doesn't provide a status
> bit of such an error. I don't even know how it might be possible, except a point
> when SPI Tx FIFO just gets empty. If you meant SPI <Rx> FIFO underrun, then
> it might be due to an invalid Rx DMA channel configuration: something with
> BLOCK-length + DST_TR_WITDH + BURST-length setting. Though I am not sure it
> could be connected with any of my recent patches for DW APB SSI or DW DMAC.

Tx overrun or Rx over-/underrun, wording above is not correct from my side. But
unfortunately I don't remember which one I have got.

> > > Generally speaking it must work (even DW APB SSI/DMA databook suggests to have
> > > such DMATDLR setting), but in our case of a relatively slow DMA engine (it's
> > > clocked with just twice higher frequency with respect to the max SPI bus
> > > speed) sometimes SPI Rx FIFO gets overflown when SPI bus is configured to work
> > > with maximum speed (there are multiple reasons why this happens, but generally
> > > speaking all of them matter only due to the relatively slow DMA engine). The
> > > problem is fixed by reducing a value written into the DMATDLR register.
> > >
> > > I am wondering whether you've tested the last revision of the driver and it
> > > worked for your version of the DW APB SSI + DW DMAC IPs. AFAIU DMA engine on
> > > your devices is faster than on ours and has LLPs supported. So if you haven't
> > > noticed any problem in the recent driver, then I'll send a fixup for our version
> > > of the DW APB SSI block only (I'll have to introduce a new compatible string).
> > > Otherwise I could get back a setting of dws->txburst into the DW_SPI_DMATDLR
> > > register, which isn't that optimal as the current DMATDLR setting
> > > of (fifo_len - txburst), but at least will make things working for all DMAs.
> > 
> 
> > That's what I have locally.
> > 
> > commit 43d9abb2711f5096e969adcf1a2fb6456fa6e275 (HEAD -> topic/ehl-dma)
> > Author: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Date:   Tue Jun 2 15:53:03 2020 +0300
> > 
> >     DEBUG SPI dw (burst fix?)
> > 
> >     Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > 
> > diff --git a/drivers/spi/spi-dw-dma.c b/drivers/spi/spi-dw-dma.c
> > index 5986c520b196..79342528b1f4 100644
> > --- a/drivers/spi/spi-dw-dma.c
> > +++ b/drivers/spi/spi-dw-dma.c
> > @@ -373,7 +373,7 @@ static int dw_spi_dma_setup(struct dw_spi *dws,
> > struct spi_transfer *xfer)
> >         u16 imr = 0, dma_ctrl = 0;
> > 
> >         dw_writel(dws, DW_SPI_DMARDLR, dws->rxburst - 1);
> > -       dw_writel(dws, DW_SPI_DMATDLR, dws->fifo_len - dws->txburst);
> > +       dw_writel(dws, DW_SPI_DMATDLR, dws->txburst);
> 
> Yep, that will solve the problem. Though in my case of setting something
> like: 
> > -       dw_writel(dws, DW_SPI_DMATDLR, dws->fifo_len - dws->txburst);
> > +       dw_writel(dws, DW_SPI_DMATDLR, dws->fifo_len / 2 - dws->txburst);
> 
> also worked. By doing so we artificially specify a Tx FIFO depth limitation,
> which implicitly slows the "SPI Tx <-> Tx DMA channel" down, so occasionally,
> if SPI Tx is fast enough while Tx DMA channel isn't, the SPI Tx FIFO might
> even get emptied, but at least it will give enough time for the
> "SPI Rx <-> Rx DMA channel" pair to fetch the incoming SPI traffic on time and
> place the data into the memory (I suppose a text like this should be in a
> comment above the line with the DMATDLR register setting). In my case I've
> noticed this problem only when I executed several background user-space processes
> intensively working with memory (like memory testbenches or just
> "dd if=/dev/mem ..." like one-liner). My theory is that the background processes
> implicitly slowed the Rx DMA channel down in a way so occasionally the internal
> DMA FIFO's got full, due to which the Rx DMA channel couldn't handle the SPI Rx
> handshaking interface requests on time to fetch data from the SPI Rx FIFO, so
> the SPI Rx FIFO gets overflown. That chain of unfortunate problems is most likely to
> happen in case if SPI-bus is fast enough. Obviously if I decrease the SPI bus
> frequency, then no overflow will happen.
> 
> In case of our hardware setting DMATDLR with a Tx-burst length isn't enough to
> completely prevent the SPI Rx FIFO overflow error. We also have to send SG list
> entries one-by-one in order to solve the problem with DMA Tx LLP reloaded faster
> than the DMA Rx LLP (remember the noLLP problem we've discussed in the DW DMA
> mailing list?).
> 
> Anyway sorry for the inconvenience my patch caused. I'll send a fixup patch
> soon, which will get back the DW_SPI_DMATDLR setting with just "dws->txburst"

Any news about a fix?

-- 
With Best Regards,
Andy Shevchenko


