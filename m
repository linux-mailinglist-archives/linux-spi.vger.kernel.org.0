Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 386061CB884
	for <lists+linux-spi@lfdr.de>; Fri,  8 May 2020 21:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbgEHTn0 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 8 May 2020 15:43:26 -0400
Received: from mga11.intel.com ([192.55.52.93]:11955 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726797AbgEHTn0 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 8 May 2020 15:43:26 -0400
IronPort-SDR: W2hh3Yk7D5BgXCGZVL1zh17r148hyZGVl3hm0oU38vMu+VoRB1GRUOwJVdB7ku0oRZo9xSCufm
 b7KGMU5UrrqA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2020 12:43:26 -0700
IronPort-SDR: Gyxa3URZkGtu3corhomGSoSrRhznemd4bWjlTNSCz2v4cAZBDgsDGn2PKkS7Fvxo58vl9BLehG
 IB45HsrJmG+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,368,1583222400"; 
   d="scan'208";a="249846692"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga007.jf.intel.com with ESMTP; 08 May 2020 12:43:21 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jX8u4-005TFh-DJ; Fri, 08 May 2020 22:43:24 +0300
Date:   Fri, 8 May 2020 22:43:24 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Mark Brown <broonie@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
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
        devicetree@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/17] spi: dw: Cleanup generic DW DMA code namings
Message-ID: <20200508194324.GA185537@smile.fi.intel.com>
References: <20200508132943.9826-1-Sergey.Semin@baikalelectronics.ru>
 <20200508132943.9826-5-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508132943.9826-5-Sergey.Semin@baikalelectronics.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, May 08, 2020 at 04:29:29PM +0300, Serge Semin wrote:
> Since from now the former Intel MID platform layer will be used
> as a generic DW SPI DMA module, lets alter the internal methods
> naming to be DMA-related instead of having the "mid_" prefix. In
> addition the DW PCI-DMA specific methods and structures should
> be named with pci-suffexes, since we'll implement the DW MMIO DMA
> specific functions and objects soon.

I think we rather leave Intel Medfield things alone.  And I think I did this already in spi/for-next in less invasive way.

-- 
With Best Regards,
Andy Shevchenko


