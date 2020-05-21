Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9471DD1F1
	for <lists+linux-spi@lfdr.de>; Thu, 21 May 2020 17:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729925AbgEUPdY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 21 May 2020 11:33:24 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:39184 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726938AbgEUPdX (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 21 May 2020 11:33:23 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 9C62C8030791;
        Thu, 21 May 2020 15:33:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 4fygftXCxMmn; Thu, 21 May 2020 18:33:20 +0300 (MSK)
Date:   Thu, 21 May 2020 18:33:17 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Feng Tang <feng.tang@intel.com>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Grant Likely <grant.likely@secretlab.ca>,
        Vinod Koul <vkoul@kernel.org>, Alan Cox <alan@linux.intel.com>,
        Linus Walleij <linus.walleij@stericsson.com>,
        Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>, <linux-mips@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Clement Leger <cleger@kalray.eu>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 01/16] spi: dw: Add Tx/Rx finish wait methods to the
 MID DMA
Message-ID: <20200521153317.7wjp2r47q75fm6ge@mobilestation>
References: <20200521012206.14472-1-Sergey.Semin@baikalelectronics.ru>
 <20200521012206.14472-2-Sergey.Semin@baikalelectronics.ru>
 <20200521030924.GA12568@shbuild999.sh.intel.com>
 <20200521114736.b2azyfvym372vkdl@mobilestation>
 <20200521145520.GB12568@shbuild999.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200521145520.GB12568@shbuild999.sh.intel.com>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, May 21, 2020 at 10:55:20PM +0800, Feng Tang wrote:
> Hi Serge,
> 
> On Thu, May 21, 2020 at 02:47:36PM +0300, Serge Semin wrote:
> > Hello Feng,
> > 
> > On Thu, May 21, 2020 at 11:09:24AM +0800, Feng Tang wrote:
> > > Hi Serge,
> > > 
> > > On Thu, May 21, 2020 at 04:21:51AM +0300, Serge Semin wrote:
> > 
> > [nip]
> > 
> > > >  /*
> > > >   * dws->dma_chan_busy is set before the dma transfer starts, callback for rx
> > > >   * channel will clear a corresponding bit.
> > > > @@ -200,6 +267,8 @@ static void dw_spi_dma_rx_done(void *arg)
> > > >  {
> > > >  	struct dw_spi *dws = arg;
> > > >  
> > > > +	dw_spi_dma_wait_rx_done(dws);
> > > 
> > > I can understand the problem about TX, but I don't see how RX
> > > will get hurt, can you elaborate more? thanks
> > > 
> > > - Feng
> > 
> > Your question is correct. You are right with your hypothesis. Ideally upon the
> > dw_spi_dma_rx_done() execution Rx FIFO must be already empty. That's why the
> > commit log signifies the error being mostly related with Tx FIFO. But
> > practically there are many reasons why Rx FIFO might be left with data:
> > DMA engine failures, incorrect DMA configuration (if DW SPI or DW DMA driver
> > messed something up), controller hanging up, and so on. It's better to catch
> > an error at this stage while propagating it up to the SPI device drivers.
> > Especially seeing the wait-check implementation doesn't gives us much of the
> > execution overhead in normal conditions. So by calling dw_spi_dma_wait_rx_done()
> > we make sure that all the data has been fetched and we may freely get the
> > buffers back to the client driver.
> 
> I see your point about checking RX. But I still don't think checking
> RX FIFO level is the right way to detect error. Some data left in
> RX FIFO doesn't always mean a error, say for some case if there is
> 20 words in RX FIFO, and the driver starts a DMA request for 16
> words, then after a sucessful DMA transaction, there are 4 words
> left without any error.

Neither Tx nor Rx FIFO should be left with any data after transaction is
finished. If they are then something has been wrong.

See, every SPI transfer starts with FIFO clearance since we disable/enable the
SPI controller by means of the SSIENR (spi_enable_chip(dws, 0) and
spi_enable_chip(dws, 1) called in the dw_spi_transfer_one() callback). Here is the
SSIENR register description: "It enables and disables all SPI Controller operations.
When disabled, all serial transfers are halted immediately. Transmit and receive
FIFO buffers are cleared when the device is disabled. It is impossible to program
some of the SPI Controller control registers when enabled"

No mater whether we start DMA request or perform the normal IRQ-based PIO, we
request as much data as we need and neither Tx nor Rx FIFO are supposed to
be left with any data after the request is finished. If data is left, then
either we didn't push all of the necessary data to the SPI bus, or we didn't
pull all the data from the FIFO, and this could have happened only due to some
component mulfunction (drivers, DMA engine, SPI device). In any case the SPI
device driver should be notified about the problem.

-Sergey

> 
> Thanks,
> Feng
> 
> > 
> > -Sergey
