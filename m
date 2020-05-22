Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 322441DE16D
	for <lists+linux-spi@lfdr.de>; Fri, 22 May 2020 09:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728794AbgEVH6w (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 22 May 2020 03:58:52 -0400
Received: from mga14.intel.com ([192.55.52.115]:23088 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728371AbgEVH6w (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 22 May 2020 03:58:52 -0400
IronPort-SDR: SSDT+KjdkyIGtrErUb5qURx8xKoNW2Eyp0nYskeHTKGn8Ot7YtU/3IJ62fDfGz4KBWUfvYerrZ
 sPKpR87SZMlA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2020 00:58:49 -0700
IronPort-SDR: Ba1UgqVNnQbJe3HN+feIC07RravYuDuHBXYUUY3XENWN37smKU3h68nyJO90j0LbE41qZLmeIu
 exY7CO5KlG5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,420,1583222400"; 
   d="scan'208";a="467102644"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.107])
  by fmsmga005.fm.intel.com with ESMTP; 22 May 2020 00:58:44 -0700
Date:   Fri, 22 May 2020 15:58:44 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
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
        Rob Herring <robh+dt@kernel.org>, linux-mips@vger.kernel.org,
        devicetree@vger.kernel.org,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Clement Leger <cleger@kalray.eu>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 01/16] spi: dw: Add Tx/Rx finish wait methods to the
 MID DMA
Message-ID: <20200522075844.GC12568@shbuild999.sh.intel.com>
References: <20200521012206.14472-1-Sergey.Semin@baikalelectronics.ru>
 <20200521012206.14472-2-Sergey.Semin@baikalelectronics.ru>
 <20200521030924.GA12568@shbuild999.sh.intel.com>
 <20200521114736.b2azyfvym372vkdl@mobilestation>
 <20200521145520.GB12568@shbuild999.sh.intel.com>
 <20200521153317.7wjp2r47q75fm6ge@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521153317.7wjp2r47q75fm6ge@mobilestation>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Serge,

On Thu, May 21, 2020 at 06:33:17PM +0300, Serge Semin wrote:
> > > > > +	dw_spi_dma_wait_rx_done(dws);
> > > > 
> > > > I can understand the problem about TX, but I don't see how RX
> > > > will get hurt, can you elaborate more? thanks
> > > > 
> > > > - Feng
> > > 
> > > Your question is correct. You are right with your hypothesis. Ideally upon the
> > > dw_spi_dma_rx_done() execution Rx FIFO must be already empty. That's why the
> > > commit log signifies the error being mostly related with Tx FIFO. But
> > > practically there are many reasons why Rx FIFO might be left with data:
> > > DMA engine failures, incorrect DMA configuration (if DW SPI or DW DMA driver
> > > messed something up), controller hanging up, and so on. It's better to catch
> > > an error at this stage while propagating it up to the SPI device drivers.
> > > Especially seeing the wait-check implementation doesn't gives us much of the
> > > execution overhead in normal conditions. So by calling dw_spi_dma_wait_rx_done()
> > > we make sure that all the data has been fetched and we may freely get the
> > > buffers back to the client driver.
> > 
> > I see your point about checking RX. But I still don't think checking
> > RX FIFO level is the right way to detect error. Some data left in
> > RX FIFO doesn't always mean a error, say for some case if there is
> > 20 words in RX FIFO, and the driver starts a DMA request for 16
> > words, then after a sucessful DMA transaction, there are 4 words
> > left without any error.
> 
> Neither Tx nor Rx FIFO should be left with any data after transaction is
> finished. If they are then something has been wrong.
> 
> See, every SPI transfer starts with FIFO clearance since we disable/enable the
> SPI controller by means of the SSIENR (spi_enable_chip(dws, 0) and
> spi_enable_chip(dws, 1) called in the dw_spi_transfer_one() callback). Here is the
> SSIENR register description: "It enables and disables all SPI Controller operations.
> When disabled, all serial transfers are halted immediately. Transmit and receive
> FIFO buffers are cleared when the device is disabled. It is impossible to program
> some of the SPI Controller control registers when enabled"
> 
> No mater whether we start DMA request or perform the normal IRQ-based PIO, we
> request as much data as we need and neither Tx nor Rx FIFO are supposed to
> be left with any data after the request is finished. If data is left, then
> either we didn't push all of the necessary data to the SPI bus, or we didn't
> pull all the data from the FIFO, and this could have happened only due to some
> component mulfunction (drivers, DMA engine, SPI device). In any case the SPI
> device driver should be notified about the problem.

Data left in TX FIFO and Data left in RX FIFO are 2 different stories. The
former in dma case means the dma hw/driver has done its job, and spi hw/driver
hasn't done its job of pushing out the data to spi slave devices, while the
latter means the spi hw/driver has done its job, while the dma hw/driver hasn't. 

And the code is called inside the dma rx channel callback, which means the
dma driver is saying "hey, I've done my job", but apparently it hasn't if
there is data left.

As for the wait time

+	nents = dw_readl(dws, DW_SPI_RXFLR);
+	ns = (NSEC_PER_SEC / spi_get_clk(dws)) * nents * dws->n_bytes *
+	     BITS_PER_BYTE;

Using this formula for checking TX makes sense, but it doesn't for RX.
Because the time of pushing data in TX FIFO to spi device depends on
the clk, but the time of transferring RX FIFO to memory is up to
the DMA controller and peripheral bus. 

Also for the

+	while (dw_spi_dma_rx_busy(dws) && retry--)
+		ndelay(ns);
+

the rx busy bit is cleared after this rx/tx checking, and it should
be always true at this point. Am I mis-reading the code?

Thanks,
Feng

> 
> -Sergey
> 
