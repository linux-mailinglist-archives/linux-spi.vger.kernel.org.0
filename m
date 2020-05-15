Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C554E1D4D45
	for <lists+linux-spi@lfdr.de>; Fri, 15 May 2020 14:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726221AbgEOMBR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 15 May 2020 08:01:17 -0400
Received: from mga06.intel.com ([134.134.136.31]:16894 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726096AbgEOMBQ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 15 May 2020 08:01:16 -0400
IronPort-SDR: rRFewxJstdZDDS7nINmr3/w1uuYJ1p4qPESzijRH58ZPaR06/4Fj1Cqw9AX/pcZYPV+tBbdbDM
 C1bz88ZK1kqg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2020 05:01:14 -0700
IronPort-SDR: I+50La80ENdqwadNeWtl+xwR55KAgH9ZVtAHzIuhHLlm+U5tSXTDf18laJ2I8DGUb2Ywvps6B1
 krnmB7bTk5QQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,395,1583222400"; 
   d="scan'208";a="410443694"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga004.jf.intel.com with ESMTP; 15 May 2020 05:01:09 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jZZ1b-006qsV-NV; Fri, 15 May 2020 15:01:11 +0300
Date:   Fri, 15 May 2020 15:01:11 +0300
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
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "wuxu.wu" <wuxu.wu@huawei.com>, Clement Leger <cleger@kalray.eu>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/19] spi: dw: Add Tx/Rx finish wait methods to the
 MID DMA
Message-ID: <20200515120111.GV185537@smile.fi.intel.com>
References: <20200508132943.9826-1-Sergey.Semin@baikalelectronics.ru>
 <20200515104758.6934-1-Sergey.Semin@baikalelectronics.ru>
 <20200515104758.6934-3-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515104758.6934-3-Sergey.Semin@baikalelectronics.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, May 15, 2020 at 01:47:41PM +0300, Serge Semin wrote:
> Since DMA transfers are performed asynchronously with actual SPI
> transaction, then even if DMA transfers are finished it doesn't mean
> all data is actually pushed to the SPI bus. Some data might still be
> in the controller FIFO. This is specifically true for Tx-only
> transfers. In this case if the next SPI transfer is recharged while
> a tail of the previous one is still in FIFO, we'll loose that tail
> data. In order to fix this lets add the wait procedure of the Tx/Rx
> SPI transfers completion after the corresponding DMA transactions
> are finished.

General question, doesn't spi core provides us some helpers like
spi_delay_exec()?

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
> - Use conditional statement instead of the ternary operator in the ref
>   clock getter.

> - Move the patch to the head of the series so one could be picked up to
>   the stable kernels as a fix.

You forgot a Fixes tag.

> ---
>  drivers/spi/spi-dw-mid.c | 50 ++++++++++++++++++++++++++++++++++++++++
>  drivers/spi/spi-dw.h     | 10 ++++++++
>  2 files changed, 60 insertions(+)
> 
> diff --git a/drivers/spi/spi-dw-mid.c b/drivers/spi/spi-dw-mid.c
> index 177e1f5ec62b..7a5ae1506365 100644
> --- a/drivers/spi/spi-dw-mid.c
> +++ b/drivers/spi/spi-dw-mid.c
> @@ -16,7 +16,9 @@
>  #include <linux/irqreturn.h>
>  #include <linux/pci.h>
>  #include <linux/platform_data/dma-dw.h>

> +#include <linux/delay.h>

Keep it in order.

>  
> +#define WAIT_RETRIES	5
>  #define RX_BUSY		0
>  #define TX_BUSY		1
>  
> @@ -141,6 +143,28 @@ static enum dma_slave_buswidth convert_dma_width(u32 dma_width) {
>  	return DMA_SLAVE_BUSWIDTH_UNDEFINED;
>  }
>  
> +static inline bool dw_spi_dma_tx_busy(struct dw_spi *dws)
> +{
> +	return !(dw_readl(dws, DW_SPI_SR) & SR_TF_EMPT);
> +}
> +
> +static void dw_spi_dma_wait_tx_done(struct dw_spi *dws)
> +{
> +	int retry = WAIT_RETRIES;
> +	unsigned long ns;
> +
> +	ns = (NSEC_PER_SEC / spi_get_clk(dws)) * dws->n_bytes * BITS_PER_BYTE;
> +	ns *= dw_readl(dws, DW_SPI_TXFLR);
> +

> +	while (dw_spi_dma_tx_busy(dws) && retry--)
> +		ndelay(ns);

This misses power management for CPU and do you really need this to be atomic?
At the end why not to use readx_poll_timeout() ?

> +	if (retry < 0) {

Usually we do

	unsigned int retries = NNNN;

	do {
		...
	} while (--retries);
	if (!retries)
		...

But in any case, see above.

> +		dev_err(&dws->master->dev, "Tx hanged up\n");
> +		dws->master->cur_msg->status = -EIO;
> +	}
> +}

Same comments to Rx part.

> +
>  /*
>   * dws->dma_chan_busy is set before the dma transfer starts, callback for tx
>   * channel will clear a corresponding bit.
> @@ -149,6 +173,8 @@ static void dw_spi_dma_tx_done(void *arg)
>  {
>  	struct dw_spi *dws = arg;
>  
> +	dw_spi_dma_wait_tx_done(dws);
> +
>  	clear_bit(TX_BUSY, &dws->dma_chan_busy);
>  	if (test_bit(RX_BUSY, &dws->dma_chan_busy))
>  		return;
> @@ -188,6 +214,28 @@ static struct dma_async_tx_descriptor *dw_spi_dma_prepare_tx(struct dw_spi *dws,
>  	return txdesc;
>  }
>  
> +static inline bool dw_spi_dma_rx_busy(struct dw_spi *dws)
> +{
> +	return !!(dw_readl(dws, DW_SPI_SR) & SR_RF_NOT_EMPT);
> +}
> +
> +static void dw_spi_dma_wait_rx_done(struct dw_spi *dws)
> +{
> +	int retry = WAIT_RETRIES;
> +	unsigned long ns;
> +
> +	ns = (NSEC_PER_SEC / spi_get_clk(dws)) * dws->n_bytes * BITS_PER_BYTE;
> +	ns *= dw_readl(dws, DW_SPI_RXFLR);
> +
> +	while (dw_spi_dma_rx_busy(dws) && retry--)
> +		ndelay(ns);
> +
> +	if (retry < 0) {
> +		dev_err(&dws->master->dev, "Rx hanged up\n");
> +		dws->master->cur_msg->status = -EIO;
> +	}
> +}
> +
>  /*
>   * dws->dma_chan_busy is set before the dma transfer starts, callback for rx
>   * channel will clear a corresponding bit.
> @@ -196,6 +244,8 @@ static void dw_spi_dma_rx_done(void *arg)
>  {
>  	struct dw_spi *dws = arg;
>  
> +	dw_spi_dma_wait_rx_done(dws);
> +
>  	clear_bit(RX_BUSY, &dws->dma_chan_busy);
>  	if (test_bit(TX_BUSY, &dws->dma_chan_busy))
>  		return;
> diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
> index e92d43b9a9e6..81364f501b7e 100644
> --- a/drivers/spi/spi-dw.h
> +++ b/drivers/spi/spi-dw.h
> @@ -210,6 +210,16 @@ static inline void spi_set_clk(struct dw_spi *dws, u16 div)
>  	dw_writel(dws, DW_SPI_BAUDR, div);
>  }
>  
> +static inline u32 spi_get_clk(struct dw_spi *dws)
> +{
> +	u32 div = dw_readl(dws, DW_SPI_BAUDR);
> +
> +	if (!div)
> +		return 0;
> +
> +	return dws->max_freq / div;
> +}
> +
>  /* Disable IRQ bits */
>  static inline void spi_mask_intr(struct dw_spi *dws, u32 mask)
>  {
> -- 
> 2.25.1
> 

-- 
With Best Regards,
Andy Shevchenko


