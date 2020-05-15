Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 214241D4F84
	for <lists+linux-spi@lfdr.de>; Fri, 15 May 2020 15:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbgEONt7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 15 May 2020 09:49:59 -0400
Received: from mga12.intel.com ([192.55.52.136]:36886 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726170AbgEONt7 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 15 May 2020 09:49:59 -0400
IronPort-SDR: sXQOCjE5HQ0vSAYPnkz1DhBUyxj9s7CjF7b+bh7qWkxcNYcBL0nzGb10YrUva5ZrVKGGwryvS6
 y+1Qz3DyJe4g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2020 06:49:59 -0700
IronPort-SDR: BibcYwQTyVwhQBhrCBTD249UDIxXGOKHBgoTpppgtNKDlwkBjQMn45YAFZwMteTXHE+E9p+hYb
 AmcNGHPSuTUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,395,1583222400"; 
   d="scan'208";a="253798627"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga008.fm.intel.com with ESMTP; 15 May 2020 06:49:54 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jZaiq-006seQ-Cw; Fri, 15 May 2020 16:49:56 +0300
Date:   Fri, 15 May 2020 16:49:56 +0300
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
        Allison Randal <allison@lohutok.net>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, linux-mips@vger.kernel.org,
        devicetree@vger.kernel.org,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Clement Leger <cleger@kalray.eu>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        "wuxu.wu" <wuxu.wu@huawei.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 08/19] spi: dw: Discard dma_width member of the dw_spi
 structure
Message-ID: <20200515134956.GC1634618@smile.fi.intel.com>
References: <20200508132943.9826-1-Sergey.Semin@baikalelectronics.ru>
 <20200515104758.6934-1-Sergey.Semin@baikalelectronics.ru>
 <20200515104758.6934-9-Sergey.Semin@baikalelectronics.ru>
 <20200515130305.GA1634618@smile.fi.intel.com>
 <20200515130559.psq2zwfhovt6rzhl@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515130559.psq2zwfhovt6rzhl@mobilestation>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, May 15, 2020 at 04:05:59PM +0300, Serge Semin wrote:
> On Fri, May 15, 2020 at 04:03:05PM +0300, Andy Shevchenko wrote:
> > On Fri, May 15, 2020 at 01:47:47PM +0300, Serge Semin wrote:
> > > This member has exactly the same value as n_bytes of the DW SPI private
> > > data object, it's calculated at the same point of the transfer method,
> > > n_bytes isn't changed during the whole transfer, and they even serve for
> > > the same purpose - keep number of bytes per transfer word, though the
> > > dma_width is used only to calculate the DMA source/destination addresses
> > > width, which n_bytes could be also utilized for. Taking all of these
> > > into account let's replace the dma_width member usage with n_bytes one
> > > and remove the former.
> > 
> > I've no strong opinion about this.
> > So, after addressing one issue below,
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

...

> > > -static enum dma_slave_buswidth convert_dma_width(u32 dma_width) {
> > > -	if (dma_width == 1)
> > 
> > > +static enum dma_slave_buswidth convert_dma_width(u8 n_bytes) {
> > 
> > It seems somebody (maybe even me) at some point messed up between enum
> > definition and function that returns an enum.
> > 
> > For what said, { should be on the separate line.
> 
> See the patch 16/19: "spi: dw: Cleanup generic DW DMA code namings"
> in this series.

Since you are touching that line here, it makes sense to do it here rather than
ping-pong to other patch in very same series.

-- 
With Best Regards,
Andy Shevchenko


