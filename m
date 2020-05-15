Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71A1E1D4D47
	for <lists+linux-spi@lfdr.de>; Fri, 15 May 2020 14:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbgEOMCB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 15 May 2020 08:02:01 -0400
Received: from mga07.intel.com ([134.134.136.100]:1080 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726118AbgEOMCA (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 15 May 2020 08:02:00 -0400
IronPort-SDR: a2wK/qvcDhR7KL58VM+JL9Ij2JG7HTLPdRVaivCYqd9BT4JQ1H050sJ1T40dP1RgMWFz/7Sd83
 dcPwPAIOEn8A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2020 05:02:00 -0700
IronPort-SDR: 52x/eYphv0+GwAeDB0GS795An+D42Z3563Tzv/uOBkJeCgUWsewkLO9fHSsB1zzLsK1rq8/CJK
 do3WYzhWBQOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,395,1583222400"; 
   d="scan'208";a="341961003"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga001.jf.intel.com with ESMTP; 15 May 2020 05:01:55 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jZZ2M-006qsy-38; Fri, 15 May 2020 15:01:58 +0300
Date:   Fri, 15 May 2020 15:01:58 +0300
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
Subject: Re: [PATCH v2 03/19] spi: dw: Clear DMAC register when done or
 stopped
Message-ID: <20200515120158.GW185537@smile.fi.intel.com>
References: <20200508132943.9826-1-Sergey.Semin@baikalelectronics.ru>
 <20200515104758.6934-1-Sergey.Semin@baikalelectronics.ru>
 <20200515104758.6934-4-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515104758.6934-4-Sergey.Semin@baikalelectronics.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, May 15, 2020 at 01:47:42PM +0300, Serge Semin wrote:
> If DMAC register is left uncleared any further DMAless transfers
> may cause the DMAC hardware handshaking interface getting activated.
> So the next DMA-based Rx/Tx transaction will be started right
> after the dma_async_issue_pending() method is invoked even if no
> DMATDLR/DMARDLR conditions are met. This at the same time may cause
> the Tx/Rx FIFO buffers underrun/overrun. In order to fix this we
> must clear DMAC register after a current DMA-based transaction is
> finished.

After adding a Fixes tag,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> 
> Co-developed-by: Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>
> Signed-off-by: Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
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
> - Move the patch to the head of the series so one could be picked up to
>   the stable kernels as a fix.
> - Clear the DMACR in the DMA exit callback too.
> ---
>  drivers/spi/spi-dw-mid.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/spi/spi-dw-mid.c b/drivers/spi/spi-dw-mid.c
> index 7a5ae1506365..0c597b6bb154 100644
> --- a/drivers/spi/spi-dw-mid.c
> +++ b/drivers/spi/spi-dw-mid.c
> @@ -108,6 +108,8 @@ static void mid_spi_dma_exit(struct dw_spi *dws)
>  		dmaengine_terminate_sync(dws->rxchan);
>  		dma_release_channel(dws->rxchan);
>  	}
> +
> +	dw_writel(dws, DW_SPI_DMACR, 0);
>  }
>  
>  static irqreturn_t dma_transfer(struct dw_spi *dws)
> @@ -178,6 +180,8 @@ static void dw_spi_dma_tx_done(void *arg)
>  	clear_bit(TX_BUSY, &dws->dma_chan_busy);
>  	if (test_bit(RX_BUSY, &dws->dma_chan_busy))
>  		return;
> +
> +	dw_writel(dws, DW_SPI_DMACR, 0);
>  	spi_finalize_current_transfer(dws->master);
>  }
>  
> @@ -249,6 +253,8 @@ static void dw_spi_dma_rx_done(void *arg)
>  	clear_bit(RX_BUSY, &dws->dma_chan_busy);
>  	if (test_bit(TX_BUSY, &dws->dma_chan_busy))
>  		return;
> +
> +	dw_writel(dws, DW_SPI_DMACR, 0);
>  	spi_finalize_current_transfer(dws->master);
>  }
>  
> @@ -342,6 +348,8 @@ static void mid_spi_dma_stop(struct dw_spi *dws)
>  		dmaengine_terminate_sync(dws->rxchan);
>  		clear_bit(RX_BUSY, &dws->dma_chan_busy);
>  	}
> +
> +	dw_writel(dws, DW_SPI_DMACR, 0);
>  }
>  
>  static const struct dw_spi_dma_ops mfld_dma_ops = {
> -- 
> 2.25.1
> 

-- 
With Best Regards,
Andy Shevchenko


