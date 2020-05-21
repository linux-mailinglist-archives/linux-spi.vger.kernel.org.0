Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 268CA1DCAF3
	for <lists+linux-spi@lfdr.de>; Thu, 21 May 2020 12:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbgEUKXy (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 21 May 2020 06:23:54 -0400
Received: from mga18.intel.com ([134.134.136.126]:59106 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727009AbgEUKXx (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 21 May 2020 06:23:53 -0400
IronPort-SDR: o3ib3vPecimzU9mzkF8RO4jFtd59f+xTHP+EWWDa2DoX+pySusRFDc2aEQ1mN8qFwzk1VqSRWw
 1UFIptqrYtzA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2020 03:23:52 -0700
IronPort-SDR: OvzjCwo1pOHa2LToFMqHaLpR0vxt0elBvEJ28LPE3rKa36dgGkVkUIcCQE9n08O0NgqzFXJ3BW
 mNj7DHy6gyEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,417,1583222400"; 
   d="scan'208";a="283003271"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga002.jf.intel.com with ESMTP; 21 May 2020 03:23:48 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jbiMh-0080w2-1A; Thu, 21 May 2020 13:23:51 +0300
Date:   Thu, 21 May 2020 13:23:51 +0300
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
        Rob Herring <robh+dt@kernel.org>, linux-mips@vger.kernel.org,
        devicetree@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 06/16] spi: dw: Parameterize the DMA Rx/Tx burst length
Message-ID: <20200521102351.GI1634618@smile.fi.intel.com>
References: <20200521012206.14472-1-Sergey.Semin@baikalelectronics.ru>
 <20200521012206.14472-7-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521012206.14472-7-Sergey.Semin@baikalelectronics.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, May 21, 2020 at 04:21:56AM +0300, Serge Semin wrote:
> It isn't good to have numeric literals in the code especially if there
> are multiple of them and they are related. Let's replace the Tx and Rx
> burst level literals with the corresponding constants.

Thanks!
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> 
> Co-developed-by: Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>
> Signed-off-by: Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>
> Co-developed-by: Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>
> Signed-off-by: Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>
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
> - Discard the dws->fifo_len utilization in the Tx FIFO DMA threshold
>   setting.
> ---
>  drivers/spi/spi-dw-mid.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/spi/spi-dw-mid.c b/drivers/spi/spi-dw-mid.c
> index 7bba774885cd..be02fedd87cb 100644
> --- a/drivers/spi/spi-dw-mid.c
> +++ b/drivers/spi/spi-dw-mid.c
> @@ -19,7 +19,9 @@
>  
>  #define WAIT_RETRIES	5
>  #define RX_BUSY		0
> +#define RX_BURST_LEVEL	16
>  #define TX_BUSY		1
> +#define TX_BURST_LEVEL	16
>  
>  static bool mid_spi_dma_chan_filter(struct dma_chan *chan, void *param)
>  {
> @@ -214,7 +216,7 @@ static struct dma_async_tx_descriptor *dw_spi_dma_prepare_tx(struct dw_spi *dws,
>  	memset(&txconf, 0, sizeof(txconf));
>  	txconf.direction = DMA_MEM_TO_DEV;
>  	txconf.dst_addr = dws->dma_addr;
> -	txconf.dst_maxburst = 16;
> +	txconf.dst_maxburst = TX_BURST_LEVEL;
>  	txconf.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
>  	txconf.dst_addr_width = convert_dma_width(dws->n_bytes);
>  	txconf.device_fc = false;
> @@ -288,7 +290,7 @@ static struct dma_async_tx_descriptor *dw_spi_dma_prepare_rx(struct dw_spi *dws,
>  	memset(&rxconf, 0, sizeof(rxconf));
>  	rxconf.direction = DMA_DEV_TO_MEM;
>  	rxconf.src_addr = dws->dma_addr;
> -	rxconf.src_maxburst = 16;
> +	rxconf.src_maxburst = RX_BURST_LEVEL;
>  	rxconf.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
>  	rxconf.src_addr_width = convert_dma_width(dws->n_bytes);
>  	rxconf.device_fc = false;
> @@ -313,8 +315,8 @@ static int mid_spi_dma_setup(struct dw_spi *dws, struct spi_transfer *xfer)
>  {
>  	u16 imr = 0, dma_ctrl = 0;
>  
> -	dw_writel(dws, DW_SPI_DMARDLR, 0xf);
> -	dw_writel(dws, DW_SPI_DMATDLR, 0x10);
> +	dw_writel(dws, DW_SPI_DMARDLR, RX_BURST_LEVEL - 1);
> +	dw_writel(dws, DW_SPI_DMATDLR, TX_BURST_LEVEL);
>  
>  	if (xfer->tx_buf) {
>  		dma_ctrl |= SPI_DMA_TDMAE;
> -- 
> 2.25.1
> 

-- 
With Best Regards,
Andy Shevchenko


