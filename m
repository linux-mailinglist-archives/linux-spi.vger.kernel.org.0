Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F06F1CB844
	for <lists+linux-spi@lfdr.de>; Fri,  8 May 2020 21:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbgEHT1Q (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 8 May 2020 15:27:16 -0400
Received: from mga09.intel.com ([134.134.136.24]:41791 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726797AbgEHT1P (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 8 May 2020 15:27:15 -0400
IronPort-SDR: tbv4hXfWchF6PCZmTplrmPmt7/LAXTeO/c8ByLxhYYEPwakH0iqNA1yp0VghnXTwQZx/UTC7tQ
 lJEnjiAbygmA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2020 12:27:14 -0700
IronPort-SDR: pF8J1l9o4UpgFzGa4LQtsBx8ZZ5N7thHTdGIUSDujb0t2rGFj6tppeSRizzVjKjK8TeeEQPU9X
 yLJeu0cRBDUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,368,1583222400"; 
   d="scan'208";a="252042190"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga008.fm.intel.com with ESMTP; 08 May 2020 12:27:08 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jX8eM-005T81-HP; Fri, 08 May 2020 22:27:10 +0300
Date:   Fri, 8 May 2020 22:27:10 +0300
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
        Linus Walleij <linus.walleij@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        Thor Thayer <thor.thayer@linux.intel.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        "wuxu.wu" <wuxu.wu@huawei.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 16/17] spi: dw: Fix Rx-only DMA transfers
Message-ID: <20200508192710.GV185537@smile.fi.intel.com>
References: <20200508132943.9826-1-Sergey.Semin@baikalelectronics.ru>
 <20200508132943.9826-17-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508132943.9826-17-Sergey.Semin@baikalelectronics.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, May 08, 2020 at 04:29:41PM +0300, Serge Semin wrote:
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

Hmm... If Mark consider this a right thing to do, then it's fine.
I didn't investigate what this flag may produce as a side effect.

> --- a/drivers/spi/spi-dw.c
> +++ b/drivers/spi/spi-dw.c
> @@ -524,6 +524,7 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
>  			dws->dma_inited = 0;
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


