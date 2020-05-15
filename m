Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67C6B1D4D59
	for <lists+linux-spi@lfdr.de>; Fri, 15 May 2020 14:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbgEOMFZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 15 May 2020 08:05:25 -0400
Received: from mga07.intel.com ([134.134.136.100]:1322 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726168AbgEOMFY (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 15 May 2020 08:05:24 -0400
IronPort-SDR: Ugf58e9f/6IPi/RDFs/Mb64SEO1EI8c/y3qJ+SFQSq6faO1m1YqCX10uSDKgk3N0s2Hs2pIFzh
 5Tednkmq6FMA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2020 05:05:17 -0700
IronPort-SDR: I6Wn7AwZIvcUrD++sALforAjGf8WE4z/6KSboxCDBePEIuvcpJ7kd2ah2WcEj3fHXBSB/+5QhO
 K7rFjQh8eXBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,395,1583222400"; 
   d="scan'208";a="253779837"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga008.fm.intel.com with ESMTP; 15 May 2020 05:05:12 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jZZ5W-006quz-9s; Fri, 15 May 2020 15:05:14 +0300
Date:   Fri, 15 May 2020 15:05:14 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
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
        devicetree@vger.kernel.org,
        Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
        Clement Leger <cleger@kalray.eu>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        "wuxu.wu" <wuxu.wu@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/19] spi: dw: Fix native CS being unset
Message-ID: <20200515120514.GX185537@smile.fi.intel.com>
References: <20200508132943.9826-1-Sergey.Semin@baikalelectronics.ru>
 <20200515104758.6934-1-Sergey.Semin@baikalelectronics.ru>
 <20200515104758.6934-5-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515104758.6934-5-Sergey.Semin@baikalelectronics.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, May 15, 2020 at 01:47:43PM +0300, Serge Semin wrote:
> Commit 6e0a32d6f376 ("spi: dw: Fix default polarity of native
> chipselect") attempted to fix the problem when GPIO active-high
> chip-select is utilized to communicate with some SPI slave. It fixed
> the problem, but broke the normal native CS support. At the same time
> the reversion commit ada9e3fcc175 ("spi: dw: Correct handling of native
> chipselect") didn't solve the problem either, since it just inverted
> the set_cs() polarity perception without taking into account that
> CS-high might be applicable. Here is what is done to finally fix the
> problem.
> 
> DW SPI controller demands any native CS being set in order to proceed
> with data transfer. So in order to activate the SPI communications we
> must set any bit in the Slave Select DW SPI controller register no
> matter whether the platform requests the GPIO- or native CS. Preferably
> it should be the bit corresponding to the SPI slave CS number. But
> currently the dw_spi_set_cs() method activates the chip-select
> only if the second argument is false. Since the second argument of the
> set_cs callback is expected to be a boolean with "is-high" semantics
> (actual chip-select pin state value), the bit in the DW SPI Slave
> Select register will be set only if SPI core requests the driver
> to set the CS in the low state. So this will work for active-low
> GPIO-based CS case, and won't work for active-high CS setting
> the bit when SPI core actually needs to deactivate the CS.
> 
> This commit fixes the problem for all described cases. So no matter
> whether an SPI slave needs GPIO- or native-based CS with active-high
> or low signal the corresponding bit will be set in SER.

Nice catch!
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Fixes: ada9e3fcc175 ("spi: dw: Correct handling of native chipselect")
> Fixes: 6e0a32d6f376 ("spi: dw: Fix default polarity of native chipselect")
> Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Cc: Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>
> Cc: Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>
> Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: Paul Burton <paulburton@kernel.org>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Allison Randal <allison@lohutok.net>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Gareth Williams <gareth.williams.jx@renesas.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: linux-mips@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> 
> ---
> 
> Changelog v2:
> - Add a comment about SER register, that it must be set to activate the
>   SPI communications.
> ---
>  drivers/spi/spi-dw.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
> index 6de196df9c96..450c8218caeb 100644
> --- a/drivers/spi/spi-dw.c
> +++ b/drivers/spi/spi-dw.c
> @@ -124,8 +124,16 @@ static inline void dw_spi_debugfs_remove(struct dw_spi *dws)
>  void dw_spi_set_cs(struct spi_device *spi, bool enable)
>  {
>  	struct dw_spi *dws = spi_controller_get_devdata(spi->controller);
> +	bool cs_high = !!(spi->mode & SPI_CS_HIGH);
>  
> -	if (!enable)
> +	/*
> +	 * DW SPI controller demands any native CS being set in order to
> +	 * proceed with data transfer. So in order to activate the SPI
> +	 * communications we must set a corresponding bit in the Slave
> +	 * Enable register no matter whether the SPI core is configured to
> +	 * support active-high or active-low CS level.
> +	 */
> +	if (cs_high == enable)
>  		dw_writel(dws, DW_SPI_SER, BIT(spi->chip_select));
>  	else if (dws->cs_override)
>  		dw_writel(dws, DW_SPI_SER, 0);
> -- 
> 2.25.1
> 

-- 
With Best Regards,
Andy Shevchenko


