Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED101DE6FC
	for <lists+linux-spi@lfdr.de>; Fri, 22 May 2020 14:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728987AbgEVMec (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 22 May 2020 08:34:32 -0400
Received: from mga14.intel.com ([192.55.52.115]:13814 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728495AbgEVMec (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 22 May 2020 08:34:32 -0400
IronPort-SDR: Oe1m4sbpjZDoODj/9r1ak+ASjqO2TZLU0JtUcoAQllzC4fd4bORjNRseYu0RJuZaKcFkjXgow/
 tSZAK53/yXAQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2020 05:34:30 -0700
IronPort-SDR: whq9lJbDeCB6C/JwWqiv1Tp+i4S6K+d96mtgVT7fTnrcVC1bP62MThrNxmR9SkVKGz5T7AeVCA
 vXS+M7GHyzUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,421,1583222400"; 
   d="scan'208";a="265417271"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga003.jf.intel.com with ESMTP; 22 May 2020 05:34:25 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jc6sd-008EJi-Ae; Fri, 22 May 2020 15:34:27 +0300
Date:   Fri, 22 May 2020 15:34:27 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
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
Message-ID: <20200522123427.GD1634618@smile.fi.intel.com>
References: <20200522000806.7381-1-Sergey.Semin@baikalelectronics.ru>
 <20200522000806.7381-2-Sergey.Semin@baikalelectronics.ru>
 <20200522111340.GX1634618@smile.fi.intel.com>
 <20200522115235.rt3ay7lveimrgooa@mobilestation>
 <20200522121221.GA1634618@smile.fi.intel.com>
 <20200522121820.GG5801@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200522121820.GG5801@sirena.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, May 22, 2020 at 01:18:20PM +0100, Mark Brown wrote:
> On Fri, May 22, 2020 at 03:12:21PM +0300, Andy Shevchenko wrote:
> > On Fri, May 22, 2020 at 02:52:35PM +0300, Serge Semin wrote:
> 
> > > Please, see it's implementation. It does atomic delay when the delay value
> > > is less than 10us. But selectively gets to the usleep_range() if value is
> > > greater than that.
> 
> > Oh, than it means we may do a very long busy loop here which is not good at
> > all. If we have 10Hz clock, it might take seconds of doing nothing!
> 
> Realistically it seems unlikely that the clock will be even as slow as
> double digit kHz though, and if we do I'd not be surprised to see other
> problems kicking in.  It's definitely good to handle such things if we
> can but so long as everything is OK for realistic use cases I'm not sure
> it should be a blocker.

Perhaps some kind of warning? Funny that using spi_delay_exec() will issue such
a warning as a side effect of its implementation.

-- 
With Best Regards,
Andy Shevchenko


