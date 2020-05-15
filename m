Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F8771D4FD0
	for <lists+linux-spi@lfdr.de>; Fri, 15 May 2020 16:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbgEOOBg (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 15 May 2020 10:01:36 -0400
Received: from mga18.intel.com ([134.134.136.126]:10555 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726160AbgEOOBg (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 15 May 2020 10:01:36 -0400
IronPort-SDR: xB/NYODIL6CrfaxkHe4phBt+W9BS6lHAX3zPlIWwr3GERobISCbVojAeqap/ePiA6MmWc/j9s3
 shxURgOMvAqA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2020 07:01:36 -0700
IronPort-SDR: mO5mOnnaXf+xAHg4vktp5Kso1bd2B6CRlRvudhFB9+5yoE3ifWCEHl2Y26622CqWQ1p/XMoN65
 HZjJbZ+ffrzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,395,1583222400"; 
   d="scan'208";a="410470019"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga004.jf.intel.com with ESMTP; 15 May 2020 07:01:27 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jZau1-006smV-Oj; Fri, 15 May 2020 17:01:29 +0300
Date:   Fri, 15 May 2020 17:01:29 +0300
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
        Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 09/19] spi: dw: Parameterize the DMA Rx/Tx burst length
Message-ID: <20200515140129.GD1634618@smile.fi.intel.com>
References: <20200508132943.9826-1-Sergey.Semin@baikalelectronics.ru>
 <20200515104758.6934-1-Sergey.Semin@baikalelectronics.ru>
 <20200515104758.6934-10-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515104758.6934-10-Sergey.Semin@baikalelectronics.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, May 15, 2020 at 01:47:48PM +0300, Serge Semin wrote:
> It isn't good to have numeric literals in the code especially if there
> are multiple of them and they are related. Moreover in current
> implementation the Tx DMA transfer activation level isn't optimal,
> since it's hardwired to be at 16-32 bytes level, while it's better
> to keep the SPI FIFO buffer as full as possible until all available
> data is submitted. So lets introduce the DMA burst level
> parametrization macros with optimal values - issue Rx transfer if at
> least 16 bytes are available in the buffer and execute Tx transaction
> if at least 16 bytes room is opened in SPI Tx FIFO.

> -	dw_writel(dws, DW_SPI_DMARDLR, 0xf);
> -	dw_writel(dws, DW_SPI_DMATDLR, 0x10);
> +	dw_writel(dws, DW_SPI_DMARDLR, RX_BURST_LEVEL - 1);
> +	dw_writel(dws, DW_SPI_DMATDLR, dws->fifo_len - TX_BURST_LEVEL);

...and if FIFO length is less than TX_BURST_LEVEL?

For the patch that introduces definitions, i.e. keeping the last line here as

	dw_writel(dws, DW_SPI_DMATDLR, TX_BURST_LEVEL);

I'm good. You may put your tag in that case. For fifo_len case we need to
discuss in separate patch, perhaps.

-- 
With Best Regards,
Andy Shevchenko


