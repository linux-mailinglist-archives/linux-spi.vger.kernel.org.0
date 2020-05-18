Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8191D75AB
	for <lists+linux-spi@lfdr.de>; Mon, 18 May 2020 12:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbgERKzi (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 18 May 2020 06:55:38 -0400
Received: from mga09.intel.com ([134.134.136.24]:21892 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726270AbgERKzi (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 18 May 2020 06:55:38 -0400
IronPort-SDR: K13+FudpfalAMFTt62ltW9V4ubV8w4HVMD3YbgU5vtW5ncUglRmGTYNT1oyC2PaF3RAZg3HKSO
 dbyqLJDx22mw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2020 03:55:37 -0700
IronPort-SDR: ZWkvv5rIoMMdGMczjut4UFbGCFFISGf09rzuZ7YZgjzvIoAJhJ4lCyTMmTR89WPzkPmscxkms7
 gf+URf9GPTvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,407,1583222400"; 
   d="scan'208";a="342758814"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga001.jf.intel.com with ESMTP; 18 May 2020 03:55:32 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jadQk-007PJ3-Qm; Mon, 18 May 2020 13:55:34 +0300
Date:   Mon, 18 May 2020 13:55:34 +0300
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
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "wuxu.wu" <wuxu.wu@huawei.com>, Clement Leger <cleger@kalray.eu>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/19] spi: dw: Add Tx/Rx finish wait methods to the
 MID DMA
Message-ID: <20200518105534.GV1634618@smile.fi.intel.com>
References: <20200508132943.9826-1-Sergey.Semin@baikalelectronics.ru>
 <20200515104758.6934-1-Sergey.Semin@baikalelectronics.ru>
 <20200515104758.6934-3-Sergey.Semin@baikalelectronics.ru>
 <20200515120111.GV185537@smile.fi.intel.com>
 <20200515194058.pmpd4wa7lw2dle3g@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515194058.pmpd4wa7lw2dle3g@mobilestation>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, May 15, 2020 at 10:40:58PM +0300, Serge Semin wrote:
> On Fri, May 15, 2020 at 03:01:11PM +0300, Andy Shevchenko wrote:
> > On Fri, May 15, 2020 at 01:47:41PM +0300, Serge Semin wrote:
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

> > You forgot a Fixes tag.
> 
> If you find a commit this patch fixes I'd be glad to add the tag.)

I believe you can do it, but I will help you here, what about

7063c0d942a1 ("spi/dw_spi: add DMA support")

or may be more closer to the reality

30c8eb52cc4a ("spi: dw-mid: split rx and tx callbacks when DMA")

?

...

> I will if v3 is needed.

I guess it will be due to Fixes tag.

-- 
With Best Regards,
Andy Shevchenko


