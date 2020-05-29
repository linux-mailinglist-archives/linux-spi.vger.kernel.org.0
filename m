Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 936C81E8568
	for <lists+linux-spi@lfdr.de>; Fri, 29 May 2020 19:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725839AbgE2RnP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 29 May 2020 13:43:15 -0400
Received: from mga05.intel.com ([192.55.52.43]:15765 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725601AbgE2RnP (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 29 May 2020 13:43:15 -0400
IronPort-SDR: 0GMQNxtspfvO9n2WV4KXaT5/nEpcR/Tzrj9DPrlyZ5mQ6zLQDaFdzlrCuPUeJRaqmqfgm2Wivj
 lwjCU0PjEMvA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2020 10:43:14 -0700
IronPort-SDR: 0U3ux2djTvRmZBoGuVswrzHuTvOjjj3x8j4Wwlb4QflNcpE+ov/iMsCiFy5ZDECCNVtSqY02px
 XaROONLLQcuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,449,1583222400"; 
   d="scan'208";a="285600081"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga002.jf.intel.com with ESMTP; 29 May 2020 10:43:09 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jej2G-009fMi-NW; Fri, 29 May 2020 20:43:12 +0300
Date:   Fri, 29 May 2020 20:43:12 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Mark Brown <broonie@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Ekaterina Skachko <Ekaterina.Skachko@baikalelectronics.ru>,
        Feng Tang <feng.tang@intel.com>, devicetree@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Alexey Kolotnikov <Alexey.Kolotnikov@baikalelectronics.ru>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vadim Vlasov <V.Vlasov@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        linux-mips@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Arnd Bergmann <arnd@arndb.de>,
        Maxim Kaurkin <Maxim.Kaurkin@baikalelectronics.ru>
Subject: Re: [PATCH v6 00/16] spi: dw: Add generic DW DMA controller support
Message-ID: <20200529174312.GU1634618@smile.fi.intel.com>
References: <20200529131205.31838-1-Sergey.Semin@baikalelectronics.ru>
 <159077271266.17043.13820488074564153429.b4-ty@kernel.org>
 <20200529172642.hcnvyzv2ocizsvpy@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200529172642.hcnvyzv2ocizsvpy@mobilestation>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, May 29, 2020 at 08:26:42PM +0300, Serge Semin wrote:
> On Fri, May 29, 2020 at 06:18:32PM +0100, Mark Brown wrote:
> > On Fri, 29 May 2020 16:11:49 +0300, Serge Semin wrote:
> > > Baikal-T1 SoC provides a DW DMA controller to perform low-speed peripherals
> > > Mem-to-Dev and Dev-to-Mem transaction. This is also applicable to the DW
> > > APB SSI devices embedded into the SoC. Currently the DMA-based transfers
> > > are supported by the DW APB SPI driver only as a middle layer code for
> > > Intel MID/Elkhart PCI devices. Seeing the same code can be used for normal
> > > platform DMAC device we introduced a set of patches to fix it within this
> > > series.

> As you can see it has been acked by Rob. So you can also merge it into your
> repo. Though It has to be rebased first due to the Dinh Nguyen patches
> recently merged in. Do you want me to do the rebasing?

I guess now you need to rebase it, because as I see the Dinh's patches are in
the tree as well as yours.

-- 
With Best Regards,
Andy Shevchenko


