Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A01031D78CB
	for <lists+linux-spi@lfdr.de>; Mon, 18 May 2020 14:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbgERMlH (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 18 May 2020 08:41:07 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:47220 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbgERMlH (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 18 May 2020 08:41:07 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 7BF6C8030875;
        Mon, 18 May 2020 12:41:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id PZtu6njJ1E1I; Mon, 18 May 2020 15:41:03 +0300 (MSK)
Date:   Mon, 18 May 2020 15:41:02 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Allison Randal <allison@lohutok.net>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Rob Herring <robh+dt@kernel.org>, <linux-mips@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 09/19] spi: dw: Parameterize the DMA Rx/Tx burst length
Message-ID: <20200518124102.vg4eb53wp4toyti3@mobilestation>
References: <20200508132943.9826-1-Sergey.Semin@baikalelectronics.ru>
 <20200515104758.6934-1-Sergey.Semin@baikalelectronics.ru>
 <20200515104758.6934-10-Sergey.Semin@baikalelectronics.ru>
 <20200515140129.GD1634618@smile.fi.intel.com>
 <20200516143353.hw6nny5hbwgiyxfw@mobilestation>
 <20200518110150.GX1634618@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200518110150.GX1634618@smile.fi.intel.com>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, May 18, 2020 at 02:01:50PM +0300, Andy Shevchenko wrote:
> On Sat, May 16, 2020 at 05:33:53PM +0300, Serge Semin wrote:
> > On Fri, May 15, 2020 at 05:01:29PM +0300, Andy Shevchenko wrote:
> > > On Fri, May 15, 2020 at 01:47:48PM +0300, Serge Semin wrote:
> > > > It isn't good to have numeric literals in the code especially if there
> > > > are multiple of them and they are related. Moreover in current
> > > > implementation the Tx DMA transfer activation level isn't optimal,
> > > > since it's hardwired to be at 16-32 bytes level, while it's better
> > > > to keep the SPI FIFO buffer as full as possible until all available
> > > > data is submitted. So lets introduce the DMA burst level
> > > > parametrization macros with optimal values - issue Rx transfer if at
> > > > least 16 bytes are available in the buffer and execute Tx transaction
> > > > if at least 16 bytes room is opened in SPI Tx FIFO.
> > > 
> > > > -	dw_writel(dws, DW_SPI_DMARDLR, 0xf);
> > > > -	dw_writel(dws, DW_SPI_DMATDLR, 0x10);
> > > > +	dw_writel(dws, DW_SPI_DMARDLR, RX_BURST_LEVEL - 1);
> > > > +	dw_writel(dws, DW_SPI_DMATDLR, dws->fifo_len - TX_BURST_LEVEL);
> > > 
> > > ...and if FIFO length is less than TX_BURST_LEVEL?
> > > 
> > > For the patch that introduces definitions, i.e. keeping the last line here as
> > > 
> > > 	dw_writel(dws, DW_SPI_DMATDLR, TX_BURST_LEVEL);
> > > 
> > > I'm good. You may put your tag in that case. For fifo_len case we need to
> > > discuss in separate patch, perhaps.
> > 
> > It's fixed in a consequent patch anyway. Though if v3 is required I'll remove
> > this change from here.
> 
> I consider that here you might have introduced a regression and actually doing
> two things in one patch. Why not to split?

Theoretically I could, but only for a hardware with FIFO smaller than 16 bytes.
So did I, seeing this module has been dedicated for the Intel Medfield/Elkhart chips
only?

Anyway as I said this change is mostly redundant, since further in this patchset I'll
replace the constants used here with burst length properly calculated based on the
fifo-length and max-burst-length specific to the DMA.

-Sergey

> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
