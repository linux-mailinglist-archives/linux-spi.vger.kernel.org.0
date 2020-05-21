Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6A731DCB5C
	for <lists+linux-spi@lfdr.de>; Thu, 21 May 2020 12:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbgEUKtH (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 21 May 2020 06:49:07 -0400
Received: from mga17.intel.com ([192.55.52.151]:48336 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727034AbgEUKtG (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 21 May 2020 06:49:06 -0400
IronPort-SDR: ubYYU07HwqI7YVj7lwR9jUnoduzOyvfO4T0rhvQVngXRkCu1WnIyTWs0+RyDq78JCdeRu5ZO6s
 4QASHYGjI/ow==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2020 03:49:06 -0700
IronPort-SDR: j54tVNWAMKZQp/4fVJ75sZHIhe48xnM00KcoMaDyIP50TxlVD/PYD+y0lwjG06H3ynBd1zGGQv
 u2uXTKzu5nvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,417,1583222400"; 
   d="scan'208";a="268592021"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga006.jf.intel.com with ESMTP; 21 May 2020 03:49:01 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jbil6-00819S-9w; Thu, 21 May 2020 13:49:04 +0300
Date:   Thu, 21 May 2020 13:49:04 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Mark Brown <broonie@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, linux-mips@vger.kernel.org,
        devicetree@vger.kernel.org,
        Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Clement Leger <cleger@kalray.eu>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 07/16] spi: dw: Use DMA max burst to set the request
 thresholds
Message-ID: <20200521104904.GK1634618@smile.fi.intel.com>
References: <20200521012206.14472-1-Sergey.Semin@baikalelectronics.ru>
 <20200521012206.14472-8-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521012206.14472-8-Sergey.Semin@baikalelectronics.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, May 21, 2020 at 04:21:57AM +0300, Serge Semin wrote:
> Each channel of DMA controller may have a limited length of burst
> transaction (number of IO operations performed at ones in a single
> DMA client request). This parameter can be used to setup the most
> optimal DMA Tx/Rx data level values. In order to avoid the Tx buffer
> overrun we can set the DMA Tx level to be of FIFO depth minus the
> maximum burst transactions length. To prevent the Rx buffer underflow
> the DMA Rx level should be set to the maximum burst transactions length.
> This commit setups the DMA channels and the DW SPI DMA Tx/Rx levels
> in accordance with these rules.

Besides one bikeshedding point, looks good to me.
Feel free to add

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: Paul Burton <paulburton@kernel.org>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: linux-mips@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> 
> ---
> 
> Changelog v3:
> - Use min() method to calculate the optimal burst values.
> ---
>  drivers/spi/spi-dw-mid.c | 37 +++++++++++++++++++++++++++++++++----
>  drivers/spi/spi-dw.h     |  2 ++
>  2 files changed, 35 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/spi/spi-dw-mid.c b/drivers/spi/spi-dw-mid.c
> index be02fedd87cb..0e95d8bc85c5 100644
> --- a/drivers/spi/spi-dw-mid.c
> +++ b/drivers/spi/spi-dw-mid.c
> @@ -34,6 +34,31 @@ static bool mid_spi_dma_chan_filter(struct dma_chan *chan, void *param)
>  	return true;
>  }
>  
> +static void mid_spi_maxburst_init(struct dw_spi *dws)
> +{
> +	struct dma_slave_caps caps;
> +	u32 max_burst, def_burst;
> +	int ret;
> +
> +	def_burst = dws->fifo_len / 2;
> +
> +	ret = dma_get_slave_caps(dws->rxchan, &caps);
> +	if (!ret && caps.max_burst)
> +		max_burst = caps.max_burst;
> +	else
> +		max_burst = RX_BURST_LEVEL;
> +
> +	dws->rxburst = min(max_burst, def_burst);
> +
> +	ret = dma_get_slave_caps(dws->txchan, &caps);
> +	if (!ret && caps.max_burst)
> +		max_burst = caps.max_burst;
> +	else
> +		max_burst = TX_BURST_LEVEL;
> +
> +	dws->txburst = min(max_burst, def_burst);
> +}
> +
>  static int mid_spi_dma_init_mfld(struct device *dev, struct dw_spi *dws)
>  {
>  	struct dw_dma_slave slave = {
> @@ -69,6 +94,8 @@ static int mid_spi_dma_init_mfld(struct device *dev, struct dw_spi *dws)
>  	dws->master->dma_rx = dws->rxchan;
>  	dws->master->dma_tx = dws->txchan;
>  
> +	mid_spi_maxburst_init(dws);
> +
>  	return 0;
>  
>  free_rxchan:
> @@ -94,6 +121,8 @@ static int mid_spi_dma_init_generic(struct device *dev, struct dw_spi *dws)
>  	dws->master->dma_rx = dws->rxchan;
>  	dws->master->dma_tx = dws->txchan;
>  
> +	mid_spi_maxburst_init(dws);
> +
>  	return 0;
>  }
>  
> @@ -216,7 +245,7 @@ static struct dma_async_tx_descriptor *dw_spi_dma_prepare_tx(struct dw_spi *dws,
>  	memset(&txconf, 0, sizeof(txconf));
>  	txconf.direction = DMA_MEM_TO_DEV;
>  	txconf.dst_addr = dws->dma_addr;
> -	txconf.dst_maxburst = TX_BURST_LEVEL;
> +	txconf.dst_maxburst = dws->txburst;
>  	txconf.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
>  	txconf.dst_addr_width = convert_dma_width(dws->n_bytes);
>  	txconf.device_fc = false;
> @@ -290,7 +319,7 @@ static struct dma_async_tx_descriptor *dw_spi_dma_prepare_rx(struct dw_spi *dws,
>  	memset(&rxconf, 0, sizeof(rxconf));
>  	rxconf.direction = DMA_DEV_TO_MEM;
>  	rxconf.src_addr = dws->dma_addr;
> -	rxconf.src_maxburst = RX_BURST_LEVEL;
> +	rxconf.src_maxburst = dws->rxburst;
>  	rxconf.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
>  	rxconf.src_addr_width = convert_dma_width(dws->n_bytes);
>  	rxconf.device_fc = false;
> @@ -315,8 +344,8 @@ static int mid_spi_dma_setup(struct dw_spi *dws, struct spi_transfer *xfer)
>  {
>  	u16 imr = 0, dma_ctrl = 0;
>  
> -	dw_writel(dws, DW_SPI_DMARDLR, RX_BURST_LEVEL - 1);
> -	dw_writel(dws, DW_SPI_DMATDLR, TX_BURST_LEVEL);
> +	dw_writel(dws, DW_SPI_DMARDLR, dws->rxburst - 1);
> +	dw_writel(dws, DW_SPI_DMATDLR, dws->fifo_len - dws->txburst);
>  
>  	if (xfer->tx_buf) {
>  		dma_ctrl |= SPI_DMA_TDMAE;
> diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
> index 4902f937c3d7..d0c8b7d3a5d2 100644
> --- a/drivers/spi/spi-dw.h
> +++ b/drivers/spi/spi-dw.h
> @@ -141,7 +141,9 @@ struct dw_spi {
>  
>  	/* DMA info */
>  	struct dma_chan		*txchan;
> +	u32			txburst;
>  	struct dma_chan		*rxchan;
> +	u32			rxburst;
>  	unsigned long		dma_chan_busy;
>  	dma_addr_t		dma_addr; /* phy address of the Data register */
>  	const struct dw_spi_dma_ops *dma_ops;
> -- 
> 2.25.1
> 

-- 
With Best Regards,
Andy Shevchenko


