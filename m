Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF071DE66D
	for <lists+linux-spi@lfdr.de>; Fri, 22 May 2020 14:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728413AbgEVMM0 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 22 May 2020 08:12:26 -0400
Received: from mga07.intel.com ([134.134.136.100]:42518 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728409AbgEVMM0 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 22 May 2020 08:12:26 -0400
IronPort-SDR: 1cr9hibZolPQMwM8ouNXnbF/OYczOHxxYHvVMRq5NTYWYlCIVQSlqJQEZhhlb5gW6g+1NNNfRN
 fNyjPnhEejGg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2020 05:12:25 -0700
IronPort-SDR: gCTg5O++p2llZr3yD+aZxedjxBKcYhvzPF8SXNhINmwkdpWVoijtM9TDSppQuSFXedW+58udM6
 pEML2Pps+o7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,421,1583222400"; 
   d="scan'208";a="300651143"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga002.fm.intel.com with ESMTP; 22 May 2020 05:12:19 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jc6XF-008E5C-Vu; Fri, 22 May 2020 15:12:21 +0300
Date:   Fri, 22 May 2020 15:12:21 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@stericsson.com>,
        Vinod Koul <vkoul@kernel.org>, Feng Tang <feng.tang@intel.com>,
        Grant Likely <grant.likely@secretlab.ca>,
        Alan Cox <alan@linux.intel.com>,
        Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, linux-mips@vger.kernel.org,
        devicetree@vger.kernel.org,
        Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        "wuxu.wu" <wuxu.wu@huawei.com>, Clement Leger <cleger@kalray.eu>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 01/16] spi: dw: Add Tx/Rx finish wait methods to the
 MID DMA
Message-ID: <20200522121221.GA1634618@smile.fi.intel.com>
References: <20200522000806.7381-1-Sergey.Semin@baikalelectronics.ru>
 <20200522000806.7381-2-Sergey.Semin@baikalelectronics.ru>
 <20200522111340.GX1634618@smile.fi.intel.com>
 <20200522115235.rt3ay7lveimrgooa@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200522115235.rt3ay7lveimrgooa@mobilestation>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, May 22, 2020 at 02:52:35PM +0300, Serge Semin wrote:
> On Fri, May 22, 2020 at 02:13:40PM +0300, Andy Shevchenko wrote:
> > On Fri, May 22, 2020 at 03:07:50AM +0300, Serge Semin wrote:
> > > Since DMA transfers are performed asynchronously with actual SPI
> > > transaction, then even if DMA transfers are finished it doesn't mean
> > > all data is actually pushed to the SPI bus. Some data might still be
> > > in the controller FIFO. This is specifically true for Tx-only
> > > transfers. In this case if the next SPI transfer is recharged while
> > > a tail of the previous one is still in FIFO, we'll loose that tail
> > > data. In order to fix this lets add the wait procedure of the Tx/Rx
> > > SPI transfers completion after the corresponding DMA transactions
> > > are finished.

...

> > > Changelog v4:
> > > - Get back ndelay() method to wait for an SPI transfer completion.
> > >   spi_delay_exec() isn't suitable for the atomic context.
> > 
> > OTOH we may teach spi_delay_exec() to perform atomic sleeps.
> 
> Please, see it's implementation. It does atomic delay when the delay value
> is less than 10us. But selectively gets to the usleep_range() if value is
> greater than that.

Oh, than it means we may do a very long busy loop here which is not good at
all. If we have 10Hz clock, it might take seconds of doing nothing!

...

> > > +	while (dw_spi_dma_tx_busy(dws) && retry--)
> > > +		ndelay(ns);
> > 
> > I might be mistaken, but I think I told that this one misses to keep power
> > management in mind.
> 
> Here we already in nearly atomic context due to the callback executed in the
> tasklet. What power management could be during a tasklet execution? Again we
> can't call sleeping methods in here. What do you suggest in substitution?
> 
> > Have you read Documentation/process/volatile-considered-harmful.rst ?
> 
> That's mentoring tone is redundant. Please, stop it.

I simple gave you pointers to where you may read about power management in busy
loops. Yes, I admit that documentation title and the relation to busy loops is
not obvious.

-- 
With Best Regards,
Andy Shevchenko


