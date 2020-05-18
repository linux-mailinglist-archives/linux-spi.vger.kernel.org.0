Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B61A31D7C58
	for <lists+linux-spi@lfdr.de>; Mon, 18 May 2020 17:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbgERPHF (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 18 May 2020 11:07:05 -0400
Received: from mga03.intel.com ([134.134.136.65]:56823 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727006AbgERPHF (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 18 May 2020 11:07:05 -0400
IronPort-SDR: bq4hgVFZ8dchReh2T46aaLSVBB1aS1v9bGHvXs4JzRDhS4+yBdUoC+Uh0i3zUhiJJ0HYkvPSQQ
 glYfCn1jb8FQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2020 08:07:04 -0700
IronPort-SDR: xijzf8j5EImrpdafZMqoJlWby9gfaCzai1/z9TN7sPPodRGqYM7lscEXvdeyWCKAmX4lgathKu
 aI5M8PY+D/PA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,407,1583222400"; 
   d="scan'208";a="254465282"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga008.fm.intel.com with ESMTP; 18 May 2020 08:06:54 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jahM0-007Ry1-EZ; Mon, 18 May 2020 18:06:56 +0300
Date:   Mon, 18 May 2020 18:06:56 +0300
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
        devicetree@vger.kernel.org,
        Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Clement Leger <cleger@kalray.eu>,
        "wuxu.wu" <wuxu.wu@huawei.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 18/19] spi: dw: Use regset32 DebugFS method to create
 regdump file
Message-ID: <20200518150656.GE1634618@smile.fi.intel.com>
References: <20200508132943.9826-1-Sergey.Semin@baikalelectronics.ru>
 <20200515104758.6934-1-Sergey.Semin@baikalelectronics.ru>
 <20200515104758.6934-19-Sergey.Semin@baikalelectronics.ru>
 <20200515151056.GQ1634618@smile.fi.intel.com>
 <20200516204634.td52orxfnh7iewg6@mobilestation>
 <20200518111822.GZ1634618@smile.fi.intel.com>
 <20200518140825.jnkfpybxnwq7fx2m@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200518140825.jnkfpybxnwq7fx2m@mobilestation>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, May 18, 2020 at 05:08:25PM +0300, Serge Semin wrote:
> On Mon, May 18, 2020 at 02:18:22PM +0300, Andy Shevchenko wrote:
> > On Sat, May 16, 2020 at 11:46:34PM +0300, Serge Semin wrote:
> > > On Fri, May 15, 2020 at 06:10:56PM +0300, Andy Shevchenko wrote:
> > > > On Fri, May 15, 2020 at 01:47:57PM +0300, Serge Semin wrote:
> > > > > DebugFS kernel interface provides a dedicated method to create the
> > > > > registers dump file. Use it instead of creating a generic DebugFS
> > > > > file with manually written read callback function.

> > > > With below nit addressed,
> > > > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > 
> > > > > +#define DW_SPI_DBGFS_REG(_name, _off)	\
> > > > > +{					\
> > > > > +	.name = _name,			\
> > > > 
> > > > > +	.offset = _off			\
> > > > 
> > > > As previously discussed (did I miss your answer?) the comma at the end leaves
> > > > better pattern for maintenance prospective.
> > > 
> > > Ah, sorry. Missed that. This comma is hardly needed seeing the structure
> > > consists of just two elements. So I'd rather leave it as is.
> > 
> > While it's a really small thing, I consider that it's not good to make
> > someone's else problem what can be done here. So, please, consider to add a
> > comma. Look at the other drivers and code in the kernel. This is at least
> > defacto preferred style.
> 
> Andy, you never give up, don't you? =)

First of all, I really appreciate work you have done so far (I mean it).
Now to the point.

You see, I always try to have a rationale behind any proposed comment. I agree,
that some of them can be considered as a bikeshedding for a certain developer,
but on big picture with this scale of project even small change (being made or
being rejected to be made) can provoke additional churn with a good magnitude,
if we consider all possible cases where somebody, e.g., can take into account
existing code to copy'n'paste from). So, I would easy give up on something if
there will be a stronger (than mine) argument why the proposed thing is not
good to be done (at least as a part of the discussed patch set). I also want
to and will learn from the developers as a reviewer.

Hope that above will clarify my reviewer's point of view to the code.

> Agreed then. I'll add comma to the
> initializer and also after the last member here:
>         DW_SPI_DBGFS_REG("ISR", DW_SPI_ISR),
>         DW_SPI_DBGFS_REG("DMACR", DW_SPI_DMACR),
>         DW_SPI_DBGFS_REG("DMATDLR", DW_SPI_DMATDLR),
> -       DW_SPI_DBGFS_REG("DMARDLR", DW_SPI_DMARDLR)
> +       DW_SPI_DBGFS_REG("DMARDLR", DW_SPI_DMARDLR),

Good catch, thanks for taking it into consideration as well.

>  };
>  
>  static int dw_spi_debugfs_init(struct dw_spi *dws)

-- 
With Best Regards,
Andy Shevchenko


