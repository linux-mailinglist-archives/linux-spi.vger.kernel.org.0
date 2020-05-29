Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF14D1E7A35
	for <lists+linux-spi@lfdr.de>; Fri, 29 May 2020 12:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbgE2KNg (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 29 May 2020 06:13:36 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:47046 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbgE2KNe (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 29 May 2020 06:13:34 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id B76A780307C7;
        Fri, 29 May 2020 10:13:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id c3ZiIxZjxY7z; Fri, 29 May 2020 13:13:30 +0300 (MSK)
Date:   Fri, 29 May 2020 13:13:28 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Grant Likely <grant.likely@secretlab.ca>,
        Linus Walleij <linus.walleij@stericsson.com>,
        Feng Tang <feng.tang@intel.com>,
        Alan Cox <alan@linux.intel.com>, Vinod Koul <vkoul@kernel.org>,
        Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, <linux-mips@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 05/16] spi: dw: Add SPI Rx-done wait method to
 DMA-based transfer
Message-ID: <20200529101328.bfoyyvmwm5gfflxv@mobilestation>
References: <20200529035915.20790-1-Sergey.Semin@baikalelectronics.ru>
 <20200529035915.20790-6-Sergey.Semin@baikalelectronics.ru>
 <20200529094648.GY1634618@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200529094648.GY1634618@smile.fi.intel.com>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, May 29, 2020 at 12:46:48PM +0300, Andy Shevchenko wrote:
> On Fri, May 29, 2020 at 06:59:03AM +0300, Serge Semin wrote:
> > Having any data left in the Rx FIFO after the DMA engine claimed it has
> > finished all DMA transactions is an abnormal situation, since the DW SPI
> > controller driver expects to have all the data being fetched and placed
> > into the SPI Rx buffer at that moment. In case if this has happened we
> > assume that DMA engine still may be doing the data fetching, thus we give
> > it sometime to finish. If after a short period of time the data is still
> > left in the Rx FIFO, the driver will give up waiting and return an error
> > indicating that the SPI controller/DMA engine must have hung up or failed
> > at some point of doing their duties.
> 
> ...
> 
> > +static int dw_spi_dma_wait_rx_done(struct dw_spi *dws)
> > +{
> > +	int retry = WAIT_RETRIES;
> > +	struct spi_delay delay;
> > +	unsigned long ns, us;
> > +	u32 nents;
> > +
> > +	/*
> > +	 * It's unlikely that DMA engine is still doing the data fetching, but
> > +	 * if it's let's give it some reasonable time. The timeout calculation
> > +	 * is based on the synchronous APB/SSI reference clock rate, on a
> > +	 * number of data entries left in the Rx FIFO, times a number of clock
> > +	 * periods normally needed for a single APB read/write transaction
> > +	 * without PREADY signal utilized (which is true for the DW APB SSI
> > +	 * controller).
> > +	 */
> > +	nents = dw_readl(dws, DW_SPI_RXFLR);
> 

> > +	ns = NSEC_PER_SEC / dws->max_freq * 4 * nents;
> 
> I think we may slightly increase precision by writing this like
> 
> 	ns = 4 * NSEC_PER_SEC / dws->max_freq * nents;

Good point. Although both 4 and NSEC_PER_SEC are signed. The later is
1000000000L. Formally speaking on x32 systems (4 * 1000 000 000L) equals
to a negative value. Though overflow still won't happen so the result will
be correct. Anyway to be on a safe side it would be better to use an explicit
unsigned literal:

+       ns = 4U * NSEC_PER_SEC / dws->max_freq * nents;

-Sergey

> 
> 
> > +	if (ns <= NSEC_PER_USEC) {
> > +		delay.unit = SPI_DELAY_UNIT_NSECS;
> > +		delay.value = ns;
> > +	} else {
> > +		us = DIV_ROUND_UP(ns, NSEC_PER_USEC);
> > +		delay.unit = SPI_DELAY_UNIT_USECS;
> > +		delay.value = clamp_val(us, 0, USHRT_MAX);
> > +	}
> > +
> > +	while (dw_spi_dma_rx_busy(dws) && retry--)
> > +		spi_delay_exec(&delay, NULL);
> > +
> > +	if (retry < 0) {
> > +		dev_err(&dws->master->dev, "Rx hanged up\n");
> > +		return -EIO;
> > +	}
> > +
> > +	return 0;
> > +}
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
