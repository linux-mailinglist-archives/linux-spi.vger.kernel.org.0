Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC8AF1D7BC7
	for <lists+linux-spi@lfdr.de>; Mon, 18 May 2020 16:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbgEROsi (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 18 May 2020 10:48:38 -0400
Received: from mga04.intel.com ([192.55.52.120]:31744 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726918AbgEROsi (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 18 May 2020 10:48:38 -0400
IronPort-SDR: H+r+wI2Uw71V6/c6spsJrUy8UNdXfKwXgW3DzQczYrVgoYgWbx2uSLKd6RrR3tcsctzlJHxIoP
 Ok+rofseahyw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2020 07:48:37 -0700
IronPort-SDR: 18Uv75IZIa38f2SAIcO0y0GV3VWK8Vuxilb8uNi1VYtEemEuJLyhedZ1p2MYO9CKlHxG4XlpmQ
 s2Qn0418B4pA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,407,1583222400"; 
   d="scan'208";a="263977274"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga003.jf.intel.com with ESMTP; 18 May 2020 07:48:32 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1jah4E-007Rnm-Ik; Mon, 18 May 2020 17:48:34 +0300
Date:   Mon, 18 May 2020 17:48:34 +0300
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
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
        devicetree <devicetree@vger.kernel.org>,
        Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Clement Leger <cleger@kalray.eu>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 10/19] spi: dw: Use DMA max burst to set the request
 thresholds
Message-ID: <20200518144834.GD1634618@smile.fi.intel.com>
References: <20200508132943.9826-1-Sergey.Semin@baikalelectronics.ru>
 <20200515104758.6934-1-Sergey.Semin@baikalelectronics.ru>
 <20200515104758.6934-11-Sergey.Semin@baikalelectronics.ru>
 <20200515143842.GG1634618@smile.fi.intel.com>
 <20200516200133.wmaqnfjbr7234fzo@mobilestation>
 <20200518110343.GY1634618@smile.fi.intel.com>
 <20200518125253.r4fpr4mjflclqpym@mobilestation>
 <CAHp75VeMcv-hQViCANQARiNh0LwmugsDWk=MF1c5E3t7z5h02Q@mail.gmail.com>
 <20200518134306.7rvydoasv7pmxwxl@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200518134306.7rvydoasv7pmxwxl@mobilestation>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, May 18, 2020 at 04:43:06PM +0300, Serge Semin wrote:
> On Mon, May 18, 2020 at 04:25:20PM +0300, Andy Shevchenko wrote:
> > On Mon, May 18, 2020 at 3:53 PM Serge Semin
> > <Sergey.Semin@baikalelectronics.ru> wrote:
> > > On Mon, May 18, 2020 at 02:03:43PM +0300, Andy Shevchenko wrote:
> > > > On Sat, May 16, 2020 at 11:01:33PM +0300, Serge Semin wrote:
> > > > > On Fri, May 15, 2020 at 05:38:42PM +0300, Andy Shevchenko wrote:
> > > > > > On Fri, May 15, 2020 at 01:47:49PM +0300, Serge Semin wrote:

...

> > > > > It's not like anyone cared about padding in this structure in the first place)
> > > >
> > > > I think I have been caring (to some extend).
> > >
> > > Well, If you have then instead of asking to rearrange just two members (which
> > > by the way finely grouped by the Tx-Rx affiliation) why not sending a
> > > patch, which would refactor the whole structure so to be optimal for the x64
> > > platforms? I don't really see why this gets very important for you seeing
> > > Mark is Ok with this. My current commit follows the common driver design
> > > including the DW SSI data members grouping. On the second thought I'll leave
> > > it as is then.
> > 
> > Again same issue here. What is really easy to do for you here, will
> > become a burden and additional churn to anybody else.
> > So, why not to minimize it in the first place? Same with comma in
> > another patch. Sorry, I really don't get it.
> 
> If comma is more or less understandable (though adding it is absolutely
> redundant there and doesn't worth even a bit of time spending for the
> discussion), here you consider the patch from padding point of view.
> The driver developer didn't care about it, but did care about grouping the
> members in a corresponding way. The padding burden will be there anyway and
> should be fixed for the whole structure in an additional patch. Until then
> the way of grouping should be preserved.

Like you said, we spent already much more time than that simple change can be
satisfied. And like you said, "deleloper ... did care about groupping members
in a corresponding way". So, if we look at this in the original code, my
suggestion, besides padding benefit, is consistent with existing pattern in
that data structure.

Note, I agree on extern keyword change can be postponed (it was in the original
code), but here you introduce a new code...

-- 
With Best Regards,
Andy Shevchenko


