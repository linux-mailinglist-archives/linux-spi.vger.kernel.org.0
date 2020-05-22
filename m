Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88AA51DE91D
	for <lists+linux-spi@lfdr.de>; Fri, 22 May 2020 16:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730083AbgEVOgn (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 22 May 2020 10:36:43 -0400
Received: from mga09.intel.com ([134.134.136.24]:53007 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729879AbgEVOgn (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 22 May 2020 10:36:43 -0400
IronPort-SDR: PNRESnoLTTWrUFmjh2S7uVf/ViOltpUimj0ATAkaB7hqF/++B36fLXIDeAYymtKg+JMhbl7Ypa
 PV+iqeF43h9Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2020 07:36:42 -0700
IronPort-SDR: WNZo8BoCRV9wtlQZiq9woxf7m5ny2JVyE4bhx4igzwWJwFIpt7LGzYskJ0taZyG5btHO00rmXe
 QQTY2nqFiPPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,422,1583222400"; 
   d="scan'208";a="283413455"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga002.jf.intel.com with ESMTP; 22 May 2020 07:36:37 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jc8mt-008FKt-Bm; Fri, 22 May 2020 17:36:39 +0300
Date:   Fri, 22 May 2020 17:36:39 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Mark Brown <broonie@kernel.org>,
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
Message-ID: <20200522143639.GG1634618@smile.fi.intel.com>
References: <20200522000806.7381-2-Sergey.Semin@baikalelectronics.ru>
 <20200522111340.GX1634618@smile.fi.intel.com>
 <20200522115235.rt3ay7lveimrgooa@mobilestation>
 <20200522121221.GA1634618@smile.fi.intel.com>
 <20200522121820.GG5801@sirena.org.uk>
 <20200522123427.GD1634618@smile.fi.intel.com>
 <20200522124406.co7gmteojfsooerc@mobilestation>
 <20200522131013.GH5801@sirena.org.uk>
 <20200522132742.taf2ixfjpyd5u3dt@mobilestation>
 <20200522140025.bmd6bhpjjk5msvsm@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200522140025.bmd6bhpjjk5msvsm@mobilestation>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, May 22, 2020 at 05:00:25PM +0300, Serge Semin wrote:
> On Fri, May 22, 2020 at 04:27:43PM +0300, Serge Semin wrote:
> > On Fri, May 22, 2020 at 02:10:13PM +0100, Mark Brown wrote:
> > > On Fri, May 22, 2020 at 03:44:06PM +0300, Serge Semin wrote:
> > > > On Fri, May 22, 2020 at 03:34:27PM +0300, Andy Shevchenko wrote:

...

> > > > > > Realistically it seems unlikely that the clock will be even as slow as
> > > > > > double digit kHz though, and if we do I'd not be surprised to see other
> > > > > > problems kicking in.  It's definitely good to handle such things if we
> > > > > > can but so long as everything is OK for realistic use cases I'm not sure
> > > > > > it should be a blocker.
> > > 
> > > > As I see it the only way to fix the problem for any use-case is to move the
> > > > busy-wait loop out from the tasklet's callback, add a completion variable to the
> > > > DW SPI data and wait for all the DMA transfers completion in the
> > > > dw_spi_dma_transfer() method. Then execute both busy-wait loops (there we can
> > > > use spi_delay_exec() since it's a work-thread) and call
> > > > spi_finalize_current_transfer() after it. What do you think?
> > > 
> > > I'm concerned that this will add latency for the common case to handle a
> > > potential issue for unrealistically slow buses but yeah, if it's an
> > > issue kicking up to task context is how you'd handle it.
> > 
> > I am not that worried about the latency (most likely it'll be the same as
> > before), but I am mostly concerned regarding a most likely need to re-implement
> > a local version spi_transfer_wait(). We can't afford wait for the completion
> > indefinitely here, so the wait_for_completion_timeout() should be used, for which
> > I would have to calculate a decent timeout based on the transfer capabilities,
> > etc. So basically it would mean to partly copy the spi_transfer_wait() to this
> > module.(
> 
> I'd also wait for Andy's suggestion regarding this, since he's been worried
> about the delay length in the first place. So he may come up with a better
> solution in this regard.

The completion approach sounds quite heavy to me.

Since we haven't got any report for such an issue, I prefer as simplest as
possible approach.

If we add might_sleep() wouldn't it be basically reimplementation of the
spi_delay_exec() again?

And second question, do you experience this warning on your system?

My point is: let's warn and see if anybody comes with a bug report. We will
solve an issue when it appears.

-- 
With Best Regards,
Andy Shevchenko


