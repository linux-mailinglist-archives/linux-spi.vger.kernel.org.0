Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF4471CB802
	for <lists+linux-spi@lfdr.de>; Fri,  8 May 2020 21:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbgEHTQU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 8 May 2020 15:16:20 -0400
Received: from mga18.intel.com ([134.134.136.126]:2802 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726767AbgEHTQU (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 8 May 2020 15:16:20 -0400
IronPort-SDR: yDSqlp6oXUxNhHNWAE/5VjSYVho4VIdqG05nyQixLuAodwzrsg/7clu6E8lwAl1/kdRHlEDLEk
 JUvFZoVvaesg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2020 12:16:19 -0700
IronPort-SDR: 8G2zCsDqKGaOduzD/IjbrrS6blG/2s5vQ0UKKYK15vyTo+SBvKQ0E7rECdq/GyzxSeDFZIb2wL
 x/lFs9aLEeeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,368,1583222400"; 
   d="scan'208";a="264485636"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga006.jf.intel.com with ESMTP; 08 May 2020 12:16:15 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jX8Tp-005T1w-MM; Fri, 08 May 2020 22:16:17 +0300
Date:   Fri, 8 May 2020 22:16:17 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Maxim Kaurkin <Maxim.Kaurkin@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Ekaterina Skachko <Ekaterina.Skachko@baikalelectronics.ru>,
        Vadim Vlasov <V.Vlasov@baikalelectronics.ru>,
        Alexey Kolotnikov <Alexey.Kolotnikov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Allison Randal <allison@lohutok.net>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Rob Herring <robh+dt@kernel.org>, linux-mips@vger.kernel.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/17] spi: dw: Add generic DW DMA controller support
Message-ID: <20200508191617.GR185537@smile.fi.intel.com>
References: <20200508132943.9826-1-Sergey.Semin@baikalelectronics.ru>
 <20200508173609.GQ4820@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508173609.GQ4820@sirena.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, May 08, 2020 at 06:36:09PM +0100, Mark Brown wrote:
> On Fri, May 08, 2020 at 04:29:25PM +0300, Serge Semin wrote:
> > Baikal-T1 SoC provides DW DMA controller to perform low-speed peripherals
> > Mem-to-Dev and Dev-to-Mem transaction. This is also applicable to the DW
> > APB SSI devices embedded into the SoC. Currently this type DMA device is
> 
> This basically all looks good to me (without any hardware specific
> knowledge), I had a few comments but they were mostly procedural ones -
> mainly getting these bug fixes you've done merged as such.  Nice work.

Agree that is nice work!
Though, can you please give us chance to review next version of the series and test on our hardware?

Serge, I think you should base it on spi/for-next rather than vanilla.

-- 
With Best Regards,
Andy Shevchenko


