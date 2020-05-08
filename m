Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84D971CB888
	for <lists+linux-spi@lfdr.de>; Fri,  8 May 2020 21:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbgEHTon (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 8 May 2020 15:44:43 -0400
Received: from mga17.intel.com ([192.55.52.151]:5925 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726797AbgEHTon (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 8 May 2020 15:44:43 -0400
IronPort-SDR: +JCo43J6zYH5NryhOTS7QVMhh4w8fT2akZh88a8vJM5e7/k+28gFZFVBBT/KvJZPpfH34Tff3y
 dbP0XAPH+U9g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2020 12:44:43 -0700
IronPort-SDR: 3IRkX/kfHWSVSG1JAB9t0SfwNgiwPppn8pnGu8iPEOQRlmtSxKPMUEjU0kDUIcQxF4QYcefZ1K
 NkL3gpkFdMCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,368,1583222400"; 
   d="scan'208";a="370611050"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga001.fm.intel.com with ESMTP; 08 May 2020 12:44:39 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jX8vJ-005TGv-Ov; Fri, 08 May 2020 22:44:41 +0300
Date:   Fri, 8 May 2020 22:44:41 +0300
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
        Allison Randal <allison@lohutok.net>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, linux-mips@vger.kernel.org,
        devicetree@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "wuxu.wu" <wuxu.wu@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/17] spi: dw: Discard static DW DMA slave structures
Message-ID: <20200508194441.GB185537@smile.fi.intel.com>
References: <20200508132943.9826-1-Sergey.Semin@baikalelectronics.ru>
 <20200508132943.9826-6-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508132943.9826-6-Sergey.Semin@baikalelectronics.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, May 08, 2020 at 04:29:30PM +0300, Serge Semin wrote:
> Having them declared is redundant since each struct dw_dma_chan has
> the same structure embedded and the structure from the passed dma_chan
> private pointer will be copied there as a result of the next calls
> chain:
> dma_request_channel() -> find_candidate() -> dma_chan_get() ->
> device_alloc_chan_resources() = dwc_alloc_chan_resources() ->
> dw_dma_filter().
> So just remove the static dw_dma_chan structures and use a locally
> declared data instance with dst_id/src_id set to the same values as
> the static copies used to have.

I'm not against it, but you may leave if for the future (see spi/for-next).

-- 
With Best Regards,
Andy Shevchenko


