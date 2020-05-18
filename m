Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3DF51D75D0
	for <lists+linux-spi@lfdr.de>; Mon, 18 May 2020 13:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbgERLDr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 18 May 2020 07:03:47 -0400
Received: from mga17.intel.com ([192.55.52.151]:12977 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726339AbgERLDq (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 18 May 2020 07:03:46 -0400
IronPort-SDR: 9TSYjEt67+QUw0ueG1L3426g17RjLRkaZiJL9SeOzzl4KYLJUJ5iXvVtEnWtNAWFgs2qFtMAtX
 W3xzd7GZYtTw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2020 04:03:46 -0700
IronPort-SDR: HbTz9zcJkSb0DzYvjUnRf/8uNTcofb415CYOQdzbXVrPhucsQz8+aRcbIkkTKXQ51OlDTC5wGC
 O+lk9RMAE6yQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,407,1583222400"; 
   d="scan'208";a="252855275"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga007.jf.intel.com with ESMTP; 18 May 2020 04:03:41 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jadYd-007PNL-7D; Mon, 18 May 2020 14:03:43 +0300
Date:   Mon, 18 May 2020 14:03:43 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Allison Randal <allison@lohutok.net>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Rob Herring <robh+dt@kernel.org>, linux-mips@vger.kernel.org,
        devicetree@vger.kernel.org,
        Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Clement Leger <cleger@kalray.eu>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 10/19] spi: dw: Use DMA max burst to set the request
 thresholds
Message-ID: <20200518110343.GY1634618@smile.fi.intel.com>
References: <20200508132943.9826-1-Sergey.Semin@baikalelectronics.ru>
 <20200515104758.6934-1-Sergey.Semin@baikalelectronics.ru>
 <20200515104758.6934-11-Sergey.Semin@baikalelectronics.ru>
 <20200515143842.GG1634618@smile.fi.intel.com>
 <20200516200133.wmaqnfjbr7234fzo@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200516200133.wmaqnfjbr7234fzo@mobilestation>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sat, May 16, 2020 at 11:01:33PM +0300, Serge Semin wrote:
> On Fri, May 15, 2020 at 05:38:42PM +0300, Andy Shevchenko wrote:
> > On Fri, May 15, 2020 at 01:47:49PM +0300, Serge Semin wrote:
> > > Each channel of DMA controller may have a limited length of burst
> > > transaction (number of IO operations performed at ones in a single
> > > DMA client request). This parameter can be used to setup the most
> > > optimal DMA Tx/Rx data level values. In order to avoid the Tx buffer
> > > overrun we can set the DMA Tx level to be of FIFO depth minus the
> > > maximum burst transactions length. To prevent the Rx buffer underflow
> > > the DMA Rx level should be set to the maximum burst transactions length.
> > > This commit setups the DMA channels and the DW SPI DMA Tx/Rx levels
> > > in accordance with these rules.

...

> > >  	/* DMA info */
> > >  	struct dma_chan		*txchan;
> > > +	u32			txburst;
> > >  	struct dma_chan		*rxchan;
> > > +	u32			rxburst;
> > 
> > Leave u32 together, it may be optimal on 64-bit architectures where ABIs require padding.
> 
> It's not like anyone cared about padding in this structure in the first place)

I think I have been caring (to some extend).

> Though if v3 is required I'll group these members together.

From what I see v3 is what Mark and me are waiting for. Mark, are we on the
same page here?

-- 
With Best Regards,
Andy Shevchenko


