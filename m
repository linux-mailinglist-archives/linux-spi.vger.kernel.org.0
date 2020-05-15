Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF9A01D4DB6
	for <lists+linux-spi@lfdr.de>; Fri, 15 May 2020 14:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbgEOMe2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 15 May 2020 08:34:28 -0400
Received: from mga02.intel.com ([134.134.136.20]:41036 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726135AbgEOMe2 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 15 May 2020 08:34:28 -0400
IronPort-SDR: keOjbwkoTF9lWGhnKGJsTEJvGWiRV0CDML6TwifEUEdzhmvxsQDWIhMznU5fQJ7XZoxikFHPaT
 DR0GZEg36V/g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2020 05:34:27 -0700
IronPort-SDR: cp7Lgk901XUmqKnJIsGc2FR6/YL28h6EFJti6vxQK0auGxok/lx527wJBHVZIzAMf2n7+leKuB
 PPCPyHuCpu/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,395,1583222400"; 
   d="scan'208";a="252020463"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga007.jf.intel.com with ESMTP; 15 May 2020 05:34:20 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jZZXi-006rB1-P0; Fri, 15 May 2020 15:34:22 +0300
Date:   Fri, 15 May 2020 15:34:22 +0300
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
        devicetree@vger.kernel.org,
        Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "wuxu.wu" <wuxu.wu@huawei.com>, Clement Leger <cleger@kalray.eu>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 06/19] spi: dw: Discard static DW DMA slave structures
Message-ID: <20200515123422.GZ185537@smile.fi.intel.com>
References: <20200508132943.9826-1-Sergey.Semin@baikalelectronics.ru>
 <20200515104758.6934-1-Sergey.Semin@baikalelectronics.ru>
 <20200515104758.6934-7-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515104758.6934-7-Sergey.Semin@baikalelectronics.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, May 15, 2020 at 01:47:45PM +0300, Serge Semin wrote:
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

...

> -static struct dw_dma_slave mid_dma_tx = { .dst_id = 1 };
> -static struct dw_dma_slave mid_dma_rx = { .src_id = 0 };

> +	struct dw_dma_slave slave = {0};

I really would like to leave them separated and as in the original form, i.e.

	struct dw_dma_slave tx = { .dst_id = 1 };
	struct dw_dma_slave rx = { .src_id = 0 };

those src and dst IDs are put in that form on purpose...

> +	/* 1. Init rx channel (.src_id = 0, .dst_id = 0) */

...this comment adds a bit of confusion.
(Needs more time to parse and understand what IDs are in use)

> +	slave.dma_dev = &dma_dev->dev;
> +	dws->rxchan = dma_request_channel(mask, mid_spi_dma_chan_filter, &slave);

> +	/* 2. Init tx channel (.src_id = 0, .dst_id = 1) */

Ditto.

P.S. Just a recommendation for the future: in all your patches try to be less
invasive where it's possible.

-- 
With Best Regards,
Andy Shevchenko


