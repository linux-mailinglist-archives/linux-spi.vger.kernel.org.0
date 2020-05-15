Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02E171D51EF
	for <lists+linux-spi@lfdr.de>; Fri, 15 May 2020 16:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbgEOOky (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 15 May 2020 10:40:54 -0400
Received: from mga06.intel.com ([134.134.136.31]:28147 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726275AbgEOOky (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 15 May 2020 10:40:54 -0400
IronPort-SDR: j7NeS0c8vCQJlJT0B2FckR9uTMK+3uKCEq7fK2xCmYs4hk97gMbrKHdv+5H9ie+moA734p+tll
 iGb0VLQIp54w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2020 07:40:54 -0700
IronPort-SDR: sE4KrJfb+F950VrQYghbTdseYseoCD3GtYpM+afg0mMFUPGBgSSsRVnmo6M9PHNfcRnmX+ydfZ
 w+2wluTqA70Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,395,1583222400"; 
   d="scan'208";a="263206144"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga003.jf.intel.com with ESMTP; 15 May 2020 07:40:48 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jZbW6-006tCc-Uq; Fri, 15 May 2020 17:40:50 +0300
Date:   Fri, 15 May 2020 17:40:50 +0300
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
        devicetree@vger.kernel.org,
        Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
        Clement Leger <cleger@kalray.eu>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        "wuxu.wu" <wuxu.wu@huawei.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 12/19] spi: dw: Fix Rx-only DMA transfers
Message-ID: <20200515144050.GI1634618@smile.fi.intel.com>
References: <20200508132943.9826-1-Sergey.Semin@baikalelectronics.ru>
 <20200515104758.6934-1-Sergey.Semin@baikalelectronics.ru>
 <20200515104758.6934-13-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515104758.6934-13-Sergey.Semin@baikalelectronics.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, May 15, 2020 at 01:47:51PM +0300, Serge Semin wrote:
> Tx-only DMA transfers are working perfectly fine since in this case
> the code just ignores the Rx FIFO overflow interrupts. But it turns
> out the SPI Rx-only transfers are broken since nothing pushing any
> data to the shift registers, so the Rx FIFO is left empty and the
> SPI core subsystems just returns a timeout error. Since DW DMAC
> driver doesn't support something like cyclic write operations of
> a single byte to a device register, the only way to support the
> Rx-only SPI transfers is to fake it by using a dummy Tx-buffer.
> This is what we intend to fix in this commit by setting the
> SPI_CONTROLLER_MUST_TX flag for DMA-capable platform.

I'm fine with this if Mark considers this right thing to do.
So, conditionally
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
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
> ---
>  drivers/spi/spi-dw.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
> index 1edb8cdd11ee..31607b40147d 100644
> --- a/drivers/spi/spi-dw.c
> +++ b/drivers/spi/spi-dw.c
> @@ -517,6 +517,7 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
>  			dev_warn(dev, "DMA init failed\n");
>  		} else {
>  			master->can_dma = dws->dma_ops->can_dma;
> +			master->flags |= SPI_CONTROLLER_MUST_TX;
>  		}
>  	}
>  
> -- 
> 2.25.1
> 

-- 
With Best Regards,
Andy Shevchenko


