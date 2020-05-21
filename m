Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEAC81DD089
	for <lists+linux-spi@lfdr.de>; Thu, 21 May 2020 16:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729797AbgEUOz1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 21 May 2020 10:55:27 -0400
Received: from mga02.intel.com ([134.134.136.20]:36814 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728136AbgEUOz1 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 21 May 2020 10:55:27 -0400
IronPort-SDR: KeQBo5ddq7tmHR+Bu0sF68gs3R0Qz7BpnNtTXMyyAJoYuRrA4DzO82kRS+oAFgfiezgqFSb2QN
 GMavpcNbqGTQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2020 07:55:26 -0700
IronPort-SDR: 0N8BDIYEnX5ZztnT6R70YHVdLDe21Txo+hJEhXPPOnQ2+q7jm0oFvzcmzpB1z+oZUds0ho+fJr
 j8sCh6ohBjGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,418,1583222400"; 
   d="scan'208";a="440474678"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.107])
  by orsmga005.jf.intel.com with ESMTP; 21 May 2020 07:55:21 -0700
Date:   Thu, 21 May 2020 22:55:20 +0800
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
Message-ID: <20200521145520.GB12568@shbuild999.sh.intel.com>
References: <20200521012206.14472-1-Sergey.Semin@baikalelectronics.ru>
 <20200521012206.14472-2-Sergey.Semin@baikalelectronics.ru>
 <20200521030924.GA12568@shbuild999.sh.intel.com>
 <20200521114736.b2azyfvym372vkdl@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521114736.b2azyfvym372vkdl@mobilestation>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Serge,

On Thu, May 21, 2020 at 02:47:36PM +0300, Serge Semin wrote:
> Hello Feng,
> 
> On Thu, May 21, 2020 at 11:09:24AM +0800, Feng Tang wrote:
> > Hi Serge,
> > 
> > On Thu, May 21, 2020 at 04:21:51AM +0300, Serge Semin wrote:
> 
> [nip]
> 
> > >  /*
> > >   * dws->dma_chan_busy is set before the dma transfer starts, callback for rx
> > >   * channel will clear a corresponding bit.
> > > @@ -200,6 +267,8 @@ static void dw_spi_dma_rx_done(void *arg)
> > >  {
> > >  	struct dw_spi *dws = arg;
> > >  
> > > +	dw_spi_dma_wait_rx_done(dws);
> > 
> > I can understand the problem about TX, but I don't see how RX
> > will get hurt, can you elaborate more? thanks
> > 
> > - Feng
> 
> Your question is correct. You are right with your hypothesis. Ideally upon the
> dw_spi_dma_rx_done() execution Rx FIFO must be already empty. That's why the
> commit log signifies the error being mostly related with Tx FIFO. But
> practically there are many reasons why Rx FIFO might be left with data:
> DMA engine failures, incorrect DMA configuration (if DW SPI or DW DMA driver
> messed something up), controller hanging up, and so on. It's better to catch
> an error at this stage while propagating it up to the SPI device drivers.
> Especially seeing the wait-check implementation doesn't gives us much of the
> execution overhead in normal conditions. So by calling dw_spi_dma_wait_rx_done()
> we make sure that all the data has been fetched and we may freely get the
> buffers back to the client driver.

I see your point about checking RX. But I still don't think checking
RX FIFO level is the right way to detect error. Some data left in
RX FIFO doesn't always mean a error, say for some case if there is
20 words in RX FIFO, and the driver starts a DMA request for 16
words, then after a sucessful DMA transaction, there are 4 words
left without any error.

Thanks,
Feng

> 
> -Sergey
