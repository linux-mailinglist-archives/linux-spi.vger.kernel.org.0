Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E60B1D75BF
	for <lists+linux-spi@lfdr.de>; Mon, 18 May 2020 13:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbgERLAI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 18 May 2020 07:00:08 -0400
Received: from mga12.intel.com ([192.55.52.136]:2258 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726499AbgERLAH (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 18 May 2020 07:00:07 -0400
IronPort-SDR: D7O++Fu3RnV3NEH+9Wam9rpicUSEOjobnARVNMOq7FokPj5qEp2u+pudJVqj3oGmWfgoxbZSrq
 8u2L+IqtKFoQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2020 04:00:07 -0700
IronPort-SDR: aKcaZ1vbO9Y+Pw38A4DR+r+cMf54BrnU9FSzgbihFrsRh7ZSK3XynoJGRv7/lzlWh9TxWwR5Vp
 ReoEmWfYeYmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,407,1583222400"; 
   d="scan'208";a="254413961"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga008.fm.intel.com with ESMTP; 18 May 2020 04:00:02 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jadV6-007PLQ-Tv; Mon, 18 May 2020 14:00:04 +0300
Date:   Mon, 18 May 2020 14:00:04 +0300
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
        Allison Randal <allison@lohutok.net>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, linux-mips@vger.kernel.org,
        devicetree@vger.kernel.org,
        Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "wuxu.wu" <wuxu.wu@huawei.com>, Clement Leger <cleger@kalray.eu>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 06/19] spi: dw: Discard static DW DMA slave structures
Message-ID: <20200518110004.GW1634618@smile.fi.intel.com>
References: <20200508132943.9826-1-Sergey.Semin@baikalelectronics.ru>
 <20200515104758.6934-1-Sergey.Semin@baikalelectronics.ru>
 <20200515104758.6934-7-Sergey.Semin@baikalelectronics.ru>
 <20200515123422.GZ185537@smile.fi.intel.com>
 <20200516142030.kburieaxjg4n7c42@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200516142030.kburieaxjg4n7c42@mobilestation>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sat, May 16, 2020 at 05:20:30PM +0300, Serge Semin wrote:
> On Fri, May 15, 2020 at 03:34:22PM +0300, Andy Shevchenko wrote:
> > On Fri, May 15, 2020 at 01:47:45PM +0300, Serge Semin wrote:
> > > Having them declared is redundant since each struct dw_dma_chan has
> > > the same structure embedded and the structure from the passed dma_chan
> > > private pointer will be copied there as a result of the next calls
> > > chain:
> > > dma_request_channel() -> find_candidate() -> dma_chan_get() ->
> > > device_alloc_chan_resources() = dwc_alloc_chan_resources() ->
> > > dw_dma_filter().
> > > So just remove the static dw_dma_chan structures and use a locally
> > > declared data instance with dst_id/src_id set to the same values as
> > > the static copies used to have.
> > 
> > ...
> > 
> > > -static struct dw_dma_slave mid_dma_tx = { .dst_id = 1 };
> > > -static struct dw_dma_slave mid_dma_rx = { .src_id = 0 };
> > 
> > > +	struct dw_dma_slave slave = {0};
> > 
> > I really would like to leave them separated and as in the original form, i.e.
> > 
> > 	struct dw_dma_slave tx = { .dst_id = 1 };
> > 	struct dw_dma_slave rx = { .src_id = 0 };
> > 
> > those src and dst IDs are put in that form on purpose...
> 
> As long as you don't tell us what purpose it is, my position won't change.

It's not the way when your changes makes this the older (upstreamed) stuff's
issue, it's an opposite. But I will help you here...

> These structures declared here just hold the static memory and nothing
> else. Allocating them on stack is better.

I'm not talking about stack, it's fine for me, what I'm talking about is *how*
they are being initialized. Read my message again carefully, please.

-- 
With Best Regards,
Andy Shevchenko


