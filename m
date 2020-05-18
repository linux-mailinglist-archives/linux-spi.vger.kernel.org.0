Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 269801D75C7
	for <lists+linux-spi@lfdr.de>; Mon, 18 May 2020 13:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbgERLBy (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 18 May 2020 07:01:54 -0400
Received: from mga01.intel.com ([192.55.52.88]:51126 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726279AbgERLBy (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 18 May 2020 07:01:54 -0400
IronPort-SDR: SO86lp8iWukT/WwInBfNlDfIRwQ/MshdUJHeor6AHGy+IWRxVMyNAmGveR2ruB+aQ0CE2H3jHY
 2WzTKf+A6NXA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2020 04:01:53 -0700
IronPort-SDR: 3gUz7Y1e3P1D/HXW+7p6rvQVhAAsWMrOhnfmjtrQ09zy/EXx5p2f+mz47pOeHNs3cCYCWCELKX
 /YLNrnvSL6vQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,407,1583222400"; 
   d="scan'208";a="299734767"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 18 May 2020 04:01:48 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jadWo-007PMV-PU; Mon, 18 May 2020 14:01:50 +0300
Date:   Mon, 18 May 2020 14:01:50 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
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
        Rob Herring <robh+dt@kernel.org>, linux-mips@vger.kernel.org,
        devicetree@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 09/19] spi: dw: Parameterize the DMA Rx/Tx burst length
Message-ID: <20200518110150.GX1634618@smile.fi.intel.com>
References: <20200508132943.9826-1-Sergey.Semin@baikalelectronics.ru>
 <20200515104758.6934-1-Sergey.Semin@baikalelectronics.ru>
 <20200515104758.6934-10-Sergey.Semin@baikalelectronics.ru>
 <20200515140129.GD1634618@smile.fi.intel.com>
 <20200516143353.hw6nny5hbwgiyxfw@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200516143353.hw6nny5hbwgiyxfw@mobilestation>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sat, May 16, 2020 at 05:33:53PM +0300, Serge Semin wrote:
> On Fri, May 15, 2020 at 05:01:29PM +0300, Andy Shevchenko wrote:
> > On Fri, May 15, 2020 at 01:47:48PM +0300, Serge Semin wrote:
> > > It isn't good to have numeric literals in the code especially if there
> > > are multiple of them and they are related. Moreover in current
> > > implementation the Tx DMA transfer activation level isn't optimal,
> > > since it's hardwired to be at 16-32 bytes level, while it's better
> > > to keep the SPI FIFO buffer as full as possible until all available
> > > data is submitted. So lets introduce the DMA burst level
> > > parametrization macros with optimal values - issue Rx transfer if at
> > > least 16 bytes are available in the buffer and execute Tx transaction
> > > if at least 16 bytes room is opened in SPI Tx FIFO.
> > 
> > > -	dw_writel(dws, DW_SPI_DMARDLR, 0xf);
> > > -	dw_writel(dws, DW_SPI_DMATDLR, 0x10);
> > > +	dw_writel(dws, DW_SPI_DMARDLR, RX_BURST_LEVEL - 1);
> > > +	dw_writel(dws, DW_SPI_DMATDLR, dws->fifo_len - TX_BURST_LEVEL);
> > 
> > ...and if FIFO length is less than TX_BURST_LEVEL?
> > 
> > For the patch that introduces definitions, i.e. keeping the last line here as
> > 
> > 	dw_writel(dws, DW_SPI_DMATDLR, TX_BURST_LEVEL);
> > 
> > I'm good. You may put your tag in that case. For fifo_len case we need to
> > discuss in separate patch, perhaps.
> 
> It's fixed in a consequent patch anyway. Though if v3 is required I'll remove
> this change from here.

I consider that here you might have introduced a regression and actually doing
two things in one patch. Why not to split?

-- 
With Best Regards,
Andy Shevchenko


