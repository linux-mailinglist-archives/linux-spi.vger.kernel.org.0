Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF211DE6C1
	for <lists+linux-spi@lfdr.de>; Fri, 22 May 2020 14:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728706AbgEVMZK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 22 May 2020 08:25:10 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:44272 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728587AbgEVMZK (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 22 May 2020 08:25:10 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 1F625803087B;
        Fri, 22 May 2020 12:25:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id sTKnDncjxIIZ; Fri, 22 May 2020 15:25:03 +0300 (MSK)
Date:   Fri, 22 May 2020 15:25:02 +0300
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
Message-ID: <20200522122502.g5amuktp342fb66k@mobilestation>
References: <20200521012206.14472-1-Sergey.Semin@baikalelectronics.ru>
 <20200521012206.14472-2-Sergey.Semin@baikalelectronics.ru>
 <20200521030924.GA12568@shbuild999.sh.intel.com>
 <20200521114736.b2azyfvym372vkdl@mobilestation>
 <20200521145520.GB12568@shbuild999.sh.intel.com>
 <20200521153317.7wjp2r47q75fm6ge@mobilestation>
 <20200522075844.GC12568@shbuild999.sh.intel.com>
 <20200522113235.miz6m7u7gs7lsq6n@mobilestation>
 <20200522120325.GD12568@shbuild999.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200522120325.GD12568@shbuild999.sh.intel.com>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, May 22, 2020 at 08:03:25PM +0800, Feng Tang wrote:
> On Fri, May 22, 2020 at 02:32:35PM +0300, Serge Semin wrote:
> > On Fri, May 22, 2020 at 03:58:44PM +0800, Feng Tang wrote:
> > > Hi Serge,
> > > 
> > > On Thu, May 21, 2020 at 06:33:17PM +0300, Serge Semin wrote:
> > > > > > > > +	dw_spi_dma_wait_rx_done(dws);
> > > > > > > 
> > > > > > > I can understand the problem about TX, but I don't see how RX
> > > > > > > will get hurt, can you elaborate more? thanks
> > > > > > > 
> > > > > > > - Feng
> > > > > > 
> > > > > > Your question is correct. You are right with your hypothesis. Ideally upon the
> > > > > > dw_spi_dma_rx_done() execution Rx FIFO must be already empty. That's why the
> > > > > > commit log signifies the error being mostly related with Tx FIFO. But
> > > > > > practically there are many reasons why Rx FIFO might be left with data:
> > > > > > DMA engine failures, incorrect DMA configuration (if DW SPI or DW DMA driver
> > > > > > messed something up), controller hanging up, and so on. It's better to catch
> > > > > > an error at this stage while propagating it up to the SPI device drivers.
> > > > > > Especially seeing the wait-check implementation doesn't gives us much of the
> > > > > > execution overhead in normal conditions. So by calling dw_spi_dma_wait_rx_done()
> > > > > > we make sure that all the data has been fetched and we may freely get the
> > > > > > buffers back to the client driver.
> > > > > 
> > > > > I see your point about checking RX. But I still don't think checking
> > > > > RX FIFO level is the right way to detect error. Some data left in
> > > > > RX FIFO doesn't always mean a error, say for some case if there is
> > > > > 20 words in RX FIFO, and the driver starts a DMA request for 16
> > > > > words, then after a sucessful DMA transaction, there are 4 words
> > > > > left without any error.
> > > > 
> > > > Neither Tx nor Rx FIFO should be left with any data after transaction is
> > > > finished. If they are then something has been wrong.
> > > > 
> > > > See, every SPI transfer starts with FIFO clearance since we disable/enable the
> > > > SPI controller by means of the SSIENR (spi_enable_chip(dws, 0) and
> > > > spi_enable_chip(dws, 1) called in the dw_spi_transfer_one() callback). Here is the
> > > > SSIENR register description: "It enables and disables all SPI Controller operations.
> > > > When disabled, all serial transfers are halted immediately. Transmit and receive
> > > > FIFO buffers are cleared when the device is disabled. It is impossible to program
> > > > some of the SPI Controller control registers when enabled"
> > > > 
> > > > No mater whether we start DMA request or perform the normal IRQ-based PIO, we
> > > > request as much data as we need and neither Tx nor Rx FIFO are supposed to
> > > > be left with any data after the request is finished. If data is left, then
> > > > either we didn't push all of the necessary data to the SPI bus, or we didn't
> > > > pull all the data from the FIFO, and this could have happened only due to some
> > > > component mulfunction (drivers, DMA engine, SPI device). In any case the SPI
> > > > device driver should be notified about the problem.
> > > 
> > > Data left in TX FIFO and Data left in RX FIFO are 2 different stories. The
> > > former in dma case means the dma hw/driver has done its job, and spi hw/driver
> > > hasn't done its job of pushing out the data to spi slave devices,
> > 
> > Agreed.
> > 
> > > while the
> > > latter means the spi hw/driver has done its job, while the dma hw/driver hasn't.
> > 
> > In this particular case agreed, that the data left in the Rx FIFO means DMA
> > hw/driver hasn't done its work right. Though SPI hw could be also a reason of
> > the data left in FIFO (though this only a theoretical consideration).
> 
> Right, that's why I was initially very curious about this RX FIFO thing,
> and if possible, please give some details in commit log about the data
> left in TX FIFO problem, which will help future developers when they
> met simliar bugs.

Ok. I'll add a more descriptive patch log.

> 
> And I'm fine with adding the rx check, no matter the problem is in
> dma side or spi side.
> 
> > > 
> > > And the code is called inside the dma rx channel callback, which means the
> > > dma driver is saying "hey, I've done my job", but apparently it hasn't if
> > > there is data left.
> > 
> > Right, either it hasn't, or the DMA engine claimed it has, but still is doing
> > something (asynchronously or something, depending on the hardware implementation),
> > or it think it has, but in fact it hasn't due to whatever problem happened
> > (software/hardware/etc.). In anyway we have to at least check whether it's
> > really done with fetching data and to be on a safe side give it some time to
> > make sure that the Rx FIFO isn't going to be emptied. Whatever problem it is
> > having a non empty Rx FIFO at the stage of calling spi_finalize_current_transfer()
> > means a certain error.
> > 
> > > 
> > > As for the wait time
> > > 
> > > +	nents = dw_readl(dws, DW_SPI_RXFLR);
> > > +	ns = (NSEC_PER_SEC / spi_get_clk(dws)) * nents * dws->n_bytes *
> > > +	     BITS_PER_BYTE;
> > > 
> > > Using this formula for checking TX makes sense, but it doesn't for RX.
> > > Because the time of pushing data in TX FIFO to spi device depends on
> > > the clk, but the time of transferring RX FIFO to memory is up to
> > > the DMA controller and peripheral bus. 
> > 
> > On this I agree with you. That formulae doesn't describe exactly the time left
> > before the Rx FIFO gets empty. But at least it provides an upper limit on the
> > time needed for the peripheral bus to fetch the data from FIFO. If for some
> > reason the internal APB bus is slower than the SPI bus, then the hardware
> > engineers screwed, since the CPU/DMA won't keep up with pulling data from Rx
> > FIFO on time so the FIFO may get overflown. Though in this case CPU/DMA won't
> > be able to push data to the Tx FIFO fast enough to cause the Rx FIFO overflown,
> > so the problem might be unnoticeable until we enable the EEPROM-read or Rx-only
> > modes of the DW APB SSI controller. Anyway I am pretty much sure all the systems
> > have the internal bus much faster than the external SPI bus.
> > 
> > Getting back to the formulae. I was thinking of how to make it better and here
> > is what we can do. We can't predict neither the DMA controller performance,
> > nor the performance of its driver. In this case we have no choice but to add
> > some assumption to clarify the task. Let's assume that the reason why Rx FIFO is
> > non-empty is that even though we are at the DMA completion callback, but the
> > DMA controller is still fetching data in background (any other reason might be
> > related with a bug, so we'll detect it here anyway). In this case we need to
> > give it a time to finish its work. As far as I can see the DW_apb_ssi interface
> > doesn't use PREADY APB signal, which means the IO access cycle will take 4
> > reference clock periods for each read and write accesses. Thus taking all of
> > these into account we can create the next formulae to measure the time needed to
> > read all the data from the Rx FIFO:
> > 
> > -	ns = (NSEC_PER_SEC / spi_get_clk(dws)) * nents * dws->n_bytes *
> > -	     BITS_PER_BYTE;
> > +	ns = (NSEC_PER_SEC / dws->max_freq) * nents * 4;
> > 
> > By doing several busy-wait loop iteration we'll cover the DMA controller and
> > it's driver possible latency. 
> > 
> > Feng, does it now makes sense for you now? If so, I'll replace the delay
> > calculation formulae in the patch.
> 
> Frankly I don't have a good idea, if it really happens which means
> something is abnormal, explicitly waiting for some micro-seconds may
> also be acceptable?

Well, If we can estimate the real delay, then it will be more preferred solution.
Hard-coding a single number is only an option if there isn't any other way.

> 
> > > 
> > > Also for the
> > > 
> > > +	while (dw_spi_dma_rx_busy(dws) && retry--)
> > > +		ndelay(ns);
> > > +
> > > 
> > > the rx busy bit is cleared after this rx/tx checking, and it should
> > > be always true at this point. Am I mis-reading the code?
> > 
> > Sorry I don't get your logic here. I am not checking the Rx busy bit here,
> > but the Rx FIFO non-empty bit. Also SR register bits aren't cleared on read,
> > so the status bits are left pending until the reason is cleared. In our case
> > until Rx FIFO gets empty, which will happen eventually either at the point of
> > all data finally being extracted from it or when the controller is disabled
> > by means of the SSIENR register.
> 
> I did misread the code, I thought it is checking the busy bits, sorry
> for that. Though the dw_spi_dma_rx_busy() name is a little confusing,
> as checking the emptiness of RX FIFO is not dma bound.

dw_spi_dma_* is a common prefix for all methods implemented in this module.
As I said having the Rx FIFO non-empty could mean that DMA in fact busy reading
data from the Rx FIFO or a bug or etc. Also the naming correlates with the
dw_spi_dma_tx_busy() method, which also doesn't mean DMA is busy with doing
something, but SPI Tx engine is busy with pushing data out to the SPI bus.

-Sergey

> 
> Thanks,
> Feng
