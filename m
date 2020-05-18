Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5111E1D76AB
	for <lists+linux-spi@lfdr.de>; Mon, 18 May 2020 13:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbgERLS1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 18 May 2020 07:18:27 -0400
Received: from mga11.intel.com ([192.55.52.93]:31081 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726511AbgERLS1 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 18 May 2020 07:18:27 -0400
IronPort-SDR: AotbJhRsatfmKi4p1KuIVrK8XtNcDS1qtyFx6IgnkcNXeiOawKAYCU/xtiojuw3IYkAGr3SLKK
 TIB/MTLXCYzQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2020 04:18:26 -0700
IronPort-SDR: 6WbUkiHD0hd1SSca3ZnjyexwPggRAgn8KcKwNsrDMbmn7V3bn8X+TCkIXafQl/Py9R1y+Bhzud
 ogcI0sbA2v7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,407,1583222400"; 
   d="scan'208";a="281939008"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga002.jf.intel.com with ESMTP; 18 May 2020 04:18:20 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jadmo-007PXE-Hs; Mon, 18 May 2020 14:18:22 +0300
Date:   Mon, 18 May 2020 14:18:22 +0300
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
Message-ID: <20200518111822.GZ1634618@smile.fi.intel.com>
References: <20200508132943.9826-1-Sergey.Semin@baikalelectronics.ru>
 <20200515104758.6934-1-Sergey.Semin@baikalelectronics.ru>
 <20200515104758.6934-19-Sergey.Semin@baikalelectronics.ru>
 <20200515151056.GQ1634618@smile.fi.intel.com>
 <20200516204634.td52orxfnh7iewg6@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200516204634.td52orxfnh7iewg6@mobilestation>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sat, May 16, 2020 at 11:46:34PM +0300, Serge Semin wrote:
> On Fri, May 15, 2020 at 06:10:56PM +0300, Andy Shevchenko wrote:
> > On Fri, May 15, 2020 at 01:47:57PM +0300, Serge Semin wrote:
> > > DebugFS kernel interface provides a dedicated method to create the
> > > registers dump file. Use it instead of creating a generic DebugFS
> > > file with manually written read callback function.

> > With below nit addressed,
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> > > +#define DW_SPI_DBGFS_REG(_name, _off)	\
> > > +{					\
> > > +	.name = _name,			\
> > 
> > > +	.offset = _off			\
> > 
> > As previously discussed (did I miss your answer?) the comma at the end leaves
> > better pattern for maintenance prospective.
> 
> Ah, sorry. Missed that. This comma is hardly needed seeing the structure
> consists of just two elements. So I'd rather leave it as is.

While it's a really small thing, I consider that it's not good to make
someone's else problem what can be done here. So, please, consider to add a
comma. Look at the other drivers and code in the kernel. This is at least
defacto preferred style.

-- 
With Best Regards,
Andy Shevchenko


