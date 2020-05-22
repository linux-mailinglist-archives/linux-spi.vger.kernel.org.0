Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 977491DE521
	for <lists+linux-spi@lfdr.de>; Fri, 22 May 2020 13:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728705AbgEVLNq (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 22 May 2020 07:13:46 -0400
Received: from mga18.intel.com ([134.134.136.126]:35945 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728657AbgEVLNp (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 22 May 2020 07:13:45 -0400
IronPort-SDR: 5nZ6cGtJpu/BqelmJBVFY6bt9IHwuHcrWXWe1b4R4/q5eYWaJ+ll01tsjkT64o/6KfTGJeCoUJ
 EA2hc9+FpRNA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2020 04:13:43 -0700
IronPort-SDR: YuqBZU0ak8gcKa2K2aEEyKTccCzb7sOYyacUb1SqLSzh8LYIUXnWK4lETim8E4sIZVi9AL7hlA
 RTx0hq4s9PVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,421,1583222400"; 
   d="scan'208";a="467149192"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga005.fm.intel.com with ESMTP; 22 May 2020 04:13:38 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jc5cS-008Dbm-I2; Fri, 22 May 2020 14:13:40 +0300
Date:   Fri, 22 May 2020 14:13:40 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@stericsson.com>,
        Vinod Koul <vkoul@kernel.org>, Feng Tang <feng.tang@intel.com>,
        Grant Likely <grant.likely@secretlab.ca>,
        Alan Cox <alan@linux.intel.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, linux-mips@vger.kernel.org,
        devicetree@vger.kernel.org,
        Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        "wuxu.wu" <wuxu.wu@huawei.com>, Clement Leger <cleger@kalray.eu>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 01/16] spi: dw: Add Tx/Rx finish wait methods to the
 MID DMA
Message-ID: <20200522111340.GX1634618@smile.fi.intel.com>
References: <20200522000806.7381-1-Sergey.Semin@baikalelectronics.ru>
 <20200522000806.7381-2-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200522000806.7381-2-Sergey.Semin@baikalelectronics.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, May 22, 2020 at 03:07:50AM +0300, Serge Semin wrote:
> Since DMA transfers are performed asynchronously with actual SPI
> transaction, then even if DMA transfers are finished it doesn't mean
> all data is actually pushed to the SPI bus. Some data might still be
> in the controller FIFO. This is specifically true for Tx-only
> transfers. In this case if the next SPI transfer is recharged while
> a tail of the previous one is still in FIFO, we'll loose that tail
> data. In order to fix this lets add the wait procedure of the Tx/Rx
> SPI transfers completion after the corresponding DMA transactions
> are finished.

...

> Fixes: 7063c0d942a1 ("spi/dw_spi: add DMA support")

Usually we put this before any other tags.

> Cc: Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>
> Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: Paul Burton <paulburton@kernel.org>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Cc: Rob Herring <robh+dt@kernel.org>

Are you sure Rob needs this to see?
You really need to shrink Cc lists of the patches to send them on common sense basis.

> Cc: linux-mips@vger.kernel.org

> Cc: devicetree@vger.kernel.org

Ditto.

...

> Changelog v4:
> - Get back ndelay() method to wait for an SPI transfer completion.
>   spi_delay_exec() isn't suitable for the atomic context.

OTOH we may teach spi_delay_exec() to perform atomic sleeps.

...

> +	while (dw_spi_dma_tx_busy(dws) && retry--)
> +		ndelay(ns);

I might be mistaken, but I think I told that this one misses to keep power
management in mind.

Have you read Documentation/process/volatile-considered-harmful.rst ?

...

> +	while (dw_spi_dma_rx_busy(dws) && retry--)
> +		ndelay(ns);

Ditto.

-- 
With Best Regards,
Andy Shevchenko


