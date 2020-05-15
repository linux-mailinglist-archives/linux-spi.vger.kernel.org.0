Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B79C1D518F
	for <lists+linux-spi@lfdr.de>; Fri, 15 May 2020 16:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728215AbgEOOis (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 15 May 2020 10:38:48 -0400
Received: from mga07.intel.com ([134.134.136.100]:12181 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728305AbgEOOiq (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 15 May 2020 10:38:46 -0400
IronPort-SDR: VBdJGM+6FEOt7f270+tz0qAc9CQkkNw1/uXBETl1+XoghfSA/tFR/I/cJKvb8JYHR4lsuODwKD
 ZYB7q8BL2AHw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2020 07:38:44 -0700
IronPort-SDR: PD+AYiubg3C62FfKS8r9a0bj7vD8rH+SxOT6MhaEKi4ZHN5L0aST1DwpDrwFQjE7dmGEMLQQ5M
 v4NPqCcAXmuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,395,1583222400"; 
   d="scan'208";a="252392201"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga007.fm.intel.com with ESMTP; 15 May 2020 07:38:39 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jZbU2-006tAz-3l; Fri, 15 May 2020 17:38:42 +0300
Date:   Fri, 15 May 2020 17:38:42 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Mark Brown <broonie@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Allison Randal <allison@lohutok.net>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Rob Herring <robh+dt@kernel.org>, linux-mips@vger.kernel.org,
        devicetree@vger.kernel.org,
        Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Clement Leger <cleger@kalray.eu>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 10/19] spi: dw: Use DMA max burst to set the request
 thresholds
Message-ID: <20200515143842.GG1634618@smile.fi.intel.com>
References: <20200508132943.9826-1-Sergey.Semin@baikalelectronics.ru>
 <20200515104758.6934-1-Sergey.Semin@baikalelectronics.ru>
 <20200515104758.6934-11-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515104758.6934-11-Sergey.Semin@baikalelectronics.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, May 15, 2020 at 01:47:49PM +0300, Serge Semin wrote:
> Each channel of DMA controller may have a limited length of burst
> transaction (number of IO operations performed at ones in a single
> DMA client request). This parameter can be used to setup the most
> optimal DMA Tx/Rx data level values. In order to avoid the Tx buffer
> overrun we can set the DMA Tx level to be of FIFO depth minus the
> maximum burst transactions length. To prevent the Rx buffer underflow
> the DMA Rx level should be set to the maximum burst transactions length.
> This commit setups the DMA channels and the DW SPI DMA Tx/Rx levels
> in accordance with these rules.

It's good one, but see my comments.


I think this patch should go before previous one.
(and without changes regarding FIFO length)

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

> +	dws->rxburst = (def_burst > max_burst) ? max_burst : def_burst;

min() ?

> +
> +	ret = dma_get_slave_caps(dws->txchan, &caps);
> +	if (!ret && caps.max_burst)
> +		max_burst = caps.max_burst;
> +	else
> +		max_burst = TX_BURST_LEVEL;
> +

> +	dws->txburst = (def_burst > max_burst) ? max_burst : def_burst;

Ditto.

> +}
> +
>  static int mid_spi_dma_init_mfld(struct device *dev, struct dw_spi *dws)
>  {
>  	struct dw_dma_slave slave = {0};
> @@ -67,6 +92,8 @@ static int mid_spi_dma_init_mfld(struct device *dev, struct dw_spi *dws)
>  	dws->master->dma_rx = dws->rxchan;
>  	dws->master->dma_tx = dws->txchan;
>  
> +	mid_spi_maxburst_init(dws);
> +
>  	return 0;
>  
>  free_rxchan:
> @@ -92,6 +119,8 @@ static int mid_spi_dma_init_generic(struct device *dev, struct dw_spi *dws)
>  	dws->master->dma_rx = dws->rxchan;
>  	dws->master->dma_tx = dws->txchan;
>  
> +	mid_spi_maxburst_init(dws);
> +
>  	return 0;
>  }
>  
> @@ -195,7 +224,7 @@ static struct dma_async_tx_descriptor *dw_spi_dma_prepare_tx(struct dw_spi *dws,
>  	memset(&txconf, 0, sizeof(txconf));
>  	txconf.direction = DMA_MEM_TO_DEV;
>  	txconf.dst_addr = dws->dma_addr;
> -	txconf.dst_maxburst = TX_BURST_LEVEL;
> +	txconf.dst_maxburst = dws->txburst;
>  	txconf.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
>  	txconf.dst_addr_width = convert_dma_width(dws->n_bytes);
>  	txconf.device_fc = false;
> @@ -268,7 +297,7 @@ static struct dma_async_tx_descriptor *dw_spi_dma_prepare_rx(struct dw_spi *dws,
>  	memset(&rxconf, 0, sizeof(rxconf));
>  	rxconf.direction = DMA_DEV_TO_MEM;
>  	rxconf.src_addr = dws->dma_addr;
> -	rxconf.src_maxburst = RX_BURST_LEVEL;
> +	rxconf.src_maxburst = dws->rxburst;
>  	rxconf.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
>  	rxconf.src_addr_width = convert_dma_width(dws->n_bytes);
>  	rxconf.device_fc = false;
> @@ -293,8 +322,8 @@ static int mid_spi_dma_setup(struct dw_spi *dws, struct spi_transfer *xfer)
>  {
>  	u16 imr = 0, dma_ctrl = 0;
>  
> -	dw_writel(dws, DW_SPI_DMARDLR, RX_BURST_LEVEL - 1);
> -	dw_writel(dws, DW_SPI_DMATDLR, dws->fifo_len - TX_BURST_LEVEL);
> +	dw_writel(dws, DW_SPI_DMARDLR, dws->rxburst - 1);
> +	dw_writel(dws, DW_SPI_DMATDLR, dws->fifo_len - dws->txburst);
>  
>  	if (xfer->tx_buf) {
>  		dma_ctrl |= SPI_DMA_TDMAE;

...

>  	/* DMA info */
>  	struct dma_chan		*txchan;
> +	u32			txburst;
>  	struct dma_chan		*rxchan;
> +	u32			rxburst;

Leave u32 together, it may be optimal on 64-bit architectures where ABIs require padding.

-- 
With Best Regards,
Andy Shevchenko


