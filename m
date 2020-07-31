Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0E752345E4
	for <lists+linux-spi@lfdr.de>; Fri, 31 Jul 2020 14:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387411AbgGaMc2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 31 Jul 2020 08:32:28 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:60674 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733299AbgGaMc2 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 31 Jul 2020 08:32:28 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 5DB418040A6A;
        Fri, 31 Jul 2020 12:32:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id vekC1aX7fldT; Fri, 31 Jul 2020 15:32:24 +0300 (MSK)
Date:   Fri, 31 Jul 2020 15:32:23 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Mark Brown <broonie@kernel.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Feng Tang <feng.tang@intel.com>, Vinod Koul <vkoul@kernel.org>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/8] spi: dw-dma: Configure the DMA channels in dma_setup
Message-ID: <20200731123223.kdbbcwabi5b72bem@mobilestation>
References: <20200731075953.14416-1-Sergey.Semin@baikalelectronics.ru>
 <20200731075953.14416-4-Sergey.Semin@baikalelectronics.ru>
 <20200731091638.GJ3703480@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200731091638.GJ3703480@smile.fi.intel.com>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Jul 31, 2020 at 12:16:38PM +0300, Andy Shevchenko wrote:
> On Fri, Jul 31, 2020 at 10:59:48AM +0300, Serge Semin wrote:
> > Mainly this is a preparation patch before adding one-by-one DMA SG entries
> > transmission. But logically the Tx and Rx DMA channels setup should be
> > performed in the dma_setup() callback anyway. So let's move the DMA slave
> > channels src/dst burst lengths, address and address width configuration to
> > the DMA setup stage. While at it make sure the return value of the
> > dmaengine_slave_config() method is checked. It has been unnecessary in
> > case if Dw DMAC is utilized as a DMA engine, since its device_config()
> > callback always returns zero (though it might change in future). But since
> > DW APB SSI driver now supports any DMA back-end we must make sure the
> > DMA device configuration has been successful before proceeding with
> > further setups.
> 
> ...
> 

Part 1:
> > +	if (!xfer->rx_buf)
> > +		return NULL;
> 
> ...
> 

Part 2:
> > +	if (xfer->rx_buf) {
> 
> > +	}
> 
> This looks like a separate change to drop one of them and not hide in the next patch.

Both of these changes are a part of the single alteration introduced to detach two
methods from each other: dw_spi_dma_{config,prepare}_{rx,tx}(). Part 1 is a
statement, which belongs to the method dw_spi_dma_prepare_rx() and is left there
after dw_spi_dma_config_rx() has been detached from it. Part 2 is a logical
part, which must be presented in dw_spi_dma_setup() since we don't need to configure
the Rx DMA channel if rx_buf isn't specified.

Please, read more carefully the commit log. I didn't introduce anything other
than the changes described there.

-Sergey

> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
