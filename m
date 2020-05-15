Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D21341D4DD9
	for <lists+linux-spi@lfdr.de>; Fri, 15 May 2020 14:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbgEOMi1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 15 May 2020 08:38:27 -0400
Received: from mga07.intel.com ([134.134.136.100]:3357 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726144AbgEOMi1 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 15 May 2020 08:38:27 -0400
IronPort-SDR: vmOVCjeoYqyfrZoIZVeVOihqSQ793G60qjiJ/U0NJkRU38JxaIsfhz2VFf5JJ3qziU7RmfIzBu
 OhkVoQ2emEqg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2020 05:38:26 -0700
IronPort-SDR: AOM6JheAe7dIdYRzcBx6pLczsGNik9Ktz+q65bTBzKNtWzIDkpRPxkH5ij8g0VhpKWCkej5+wM
 vd8cUu4QS8dA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,395,1583222400"; 
   d="scan'208";a="253785230"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga008.fm.intel.com with ESMTP; 15 May 2020 05:38:22 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jZZbc-006rEO-7B; Fri, 15 May 2020 15:38:24 +0300
Date:   Fri, 15 May 2020 15:38:24 +0300
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
        "wuxu.wu" <wuxu.wu@huawei.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Clement Leger <cleger@kalray.eu>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 07/19] spi: dw: Discard unused void priv pointer
Message-ID: <20200515123824.GB185537@smile.fi.intel.com>
References: <20200508132943.9826-1-Sergey.Semin@baikalelectronics.ru>
 <20200515104758.6934-1-Sergey.Semin@baikalelectronics.ru>
 <20200515104758.6934-8-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515104758.6934-8-Sergey.Semin@baikalelectronics.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, May 15, 2020 at 01:47:46PM +0300, Serge Semin wrote:
> Seeing the "void *priv" member of the dw_spi data structure is unused
> let's remove it. The glue-layers can embed the DW APB SSI controller
> descriptor into their private data object. MMIO driver for instance
> already utilizes that design pattern.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Cc: Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>
> Cc: Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>
> Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: Paul Burton <paulburton@kernel.org>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Allison Randal <allison@lohutok.net>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Gareth Williams <gareth.williams.jx@renesas.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: linux-mips@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> 
> ---
> 
> Changelog v2:
> - It's a new patch created as a result of more thorough driver study.
> ---
>  drivers/spi/spi-dw.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
> index 60e9e430ce7b..b6ab81e0c747 100644
> --- a/drivers/spi/spi-dw.h
> +++ b/drivers/spi/spi-dw.h
> @@ -147,8 +147,6 @@ struct dw_spi {
>  	dma_addr_t		dma_addr; /* phy address of the Data register */
>  	const struct dw_spi_dma_ops *dma_ops;
>  
> -	/* Bus interface info */
> -	void			*priv;
>  #ifdef CONFIG_DEBUG_FS
>  	struct dentry *debugfs;
>  #endif
> -- 
> 2.25.1
> 

-- 
With Best Regards,
Andy Shevchenko


