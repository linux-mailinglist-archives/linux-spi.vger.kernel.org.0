Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1004C234612
	for <lists+linux-spi@lfdr.de>; Fri, 31 Jul 2020 14:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730934AbgGaMqu (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 31 Jul 2020 08:46:50 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:60756 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727040AbgGaMqu (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 31 Jul 2020 08:46:50 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 7799C8030802;
        Fri, 31 Jul 2020 12:46:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id mJzSbjY_LpHW; Fri, 31 Jul 2020 15:46:46 +0300 (MSK)
Date:   Fri, 31 Jul 2020 15:46:46 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Feng Tang <feng.tang@intel.com>, Vinod Koul <vkoul@kernel.org>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/8] spi: dw-dma: Move DMA transfers submission to the
 channels prep methods
Message-ID: <20200731124646.2bngx5mgtwrgctzi@mobilestation>
References: <20200731075953.14416-1-Sergey.Semin@baikalelectronics.ru>
 <20200731075953.14416-5-Sergey.Semin@baikalelectronics.ru>
 <20200731091528.GI3703480@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200731091528.GI3703480@smile.fi.intel.com>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Jul 31, 2020 at 12:15:28PM +0300, Andy Shevchenko wrote:
> On Fri, Jul 31, 2020 at 10:59:49AM +0300, Serge Semin wrote:
> > Indeed we can freely move the dmaengine_submit() method invocation and the
> > Tx and Rx busy flag setting into the DMA Tx/Rx prepare methods. By doing
> > so first we implement another preparation before adding the one-by-one DMA
> > SG entries transmission, second we now have the dma_async_tx_descriptor
> > descriptor used locally only in the new DMA transfers submitition methods,
> > which makes the code less complex with no passing around the DMA Tx
> > descriptors, third we make the generic transfer method more readable, where
> > now the functionality of submission, execution and wait procedures is
> > transparently split up instead of having a preparation, intermixed
> > submission/execution and wait procedures. While at it we also add the
> > dmaengine_submit() return value test. It has been unnecessary for
> > DW DMAC, but should be done to support the generic DMA interface.
> > 
> > Note since the DMA channels preparation methods are now responsible for
> > the DMA transactions submission, we also rename them to
> > dw_spi_dma_submit_{tx,rx}().
> 
> ...
> 
> > +	cookie = dmaengine_submit(txdesc);
> > +	ret = dma_submit_error(cookie);
> > +	if (!ret)
> 

> Use traditional pattern
> 	if (ret)
> 		return ret;
> 
> Same for below.

Ok.

> 
> > +		set_bit(TX_BUSY, &dws->dma_chan_busy);
> > +
> > +	return ret;
> 
> ...
> 

> > -	if (!xfer->rx_buf)
> > -		return NULL;
> 
> This seems not related.

I moved it to the upper level for the methods better maintainability.

-Sergey

> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
