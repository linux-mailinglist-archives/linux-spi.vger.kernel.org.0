Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 061B61D2F8C
	for <lists+linux-spi@lfdr.de>; Thu, 14 May 2020 14:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727890AbgENMWS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 14 May 2020 08:22:18 -0400
Received: from mga12.intel.com ([192.55.52.136]:34995 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725955AbgENMWR (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 14 May 2020 08:22:17 -0400
IronPort-SDR: jq2G9j4l+MtmXiBskeawpsxih7yy4UmJ+LGfE9+Lk1E9tY6Q3W5xMH79i5d4wHG7PLmfYN7wg4
 t4Z3FDFHyuyg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2020 05:22:17 -0700
IronPort-SDR: g4YTAvFTxqNPtU0jkIbc5r78CO9/Y4ylYkQmK+EhgU7xCpQhcG80N1AgmABpc/Vg8MOpmJRO+L
 MmVc/XiEeHqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,391,1583222400"; 
   d="scan'208";a="464312030"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga005.fm.intel.com with ESMTP; 14 May 2020 05:22:12 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jZCsQ-006cUm-3m; Thu, 14 May 2020 15:22:14 +0300
Date:   Thu, 14 May 2020 15:22:14 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Mark Brown <broonie@kernel.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
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
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Thor Thayer <thor.thayer@linux.intel.com>,
        "wuxu.wu" <wuxu.wu@huawei.com>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 11/17] spi: dw: Fix native CS being unset
Message-ID: <20200514122214.GC185537@smile.fi.intel.com>
References: <20200508132943.9826-1-Sergey.Semin@baikalelectronics.ru>
 <20200508132943.9826-12-Sergey.Semin@baikalelectronics.ru>
 <CACRpkdY=wkgnYPcqSzyzNpS6ckJZs-9kXfTfdwa1E+POzOBQGA@mail.gmail.com>
 <20200513001347.dyt357erev7vzy3l@mobilestation>
 <CACRpkdZTH1DNHvi4r48nLNWp4rqyYDZTzT12hw0eTNcYmgSr3Q@mail.gmail.com>
 <20200514115558.e6cqnuxqyqkysfn7@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200514115558.e6cqnuxqyqkysfn7@mobilestation>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, May 14, 2020 at 02:55:58PM +0300, Serge Semin wrote:
> On Thu, May 14, 2020 at 10:31:13AM +0200, Linus Walleij wrote:
> > On Wed, May 13, 2020 at 2:13 AM Serge Semin
> > <Sergey.Semin@baikalelectronics.ru> wrote:

> BTW I experience a problem with vger.kernel.org. For some reason a few days ago
> it started bouncing my emails back sent to the GPIO/MIPS/SPI/kernel mailing lists.
> I've sent multiple backward messages to the postmaster (postmaster (dog) vger.kernel.org)
> with the bounce text, but still with no response. Could you tell me who should I
> bother with this problem to get a help with its solution? 

Perhaps, helpdesk@kernel.org ?

-- 
With Best Regards,
Andy Shevchenko


