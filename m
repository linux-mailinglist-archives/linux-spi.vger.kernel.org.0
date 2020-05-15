Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30DC41D4E5C
	for <lists+linux-spi@lfdr.de>; Fri, 15 May 2020 15:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbgEONDQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 15 May 2020 09:03:16 -0400
Received: from mga14.intel.com ([192.55.52.115]:17722 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbgEONDP (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 15 May 2020 09:03:15 -0400
IronPort-SDR: eKDLOppNzXtQhO6bOZ/9GMroJQLPXBtvX+wyLRENTdy6g9Ei42kHdwnZHell9oT2uppYImlgdC
 gLVZo7VThcXA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2020 06:03:13 -0700
IronPort-SDR: PKjN5VSpRweaEgwde2nYhTaRA/f/RxBzVbIZ0FwXWecKHXGIbKZ7gpUIYyxreDvcR7fnRLV5Yf
 agoJaxnfe9tA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,395,1583222400"; 
   d="scan'208";a="252027692"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga007.jf.intel.com with ESMTP; 15 May 2020 06:03:04 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jZZzV-006s9U-DW; Fri, 15 May 2020 16:03:05 +0300
Date:   Fri, 15 May 2020 16:03:05 +0300
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
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Clement Leger <cleger@kalray.eu>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        "wuxu.wu" <wuxu.wu@huawei.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 08/19] spi: dw: Discard dma_width member of the dw_spi
 structure
Message-ID: <20200515130305.GA1634618@smile.fi.intel.com>
References: <20200508132943.9826-1-Sergey.Semin@baikalelectronics.ru>
 <20200515104758.6934-1-Sergey.Semin@baikalelectronics.ru>
 <20200515104758.6934-9-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515104758.6934-9-Sergey.Semin@baikalelectronics.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, May 15, 2020 at 01:47:47PM +0300, Serge Semin wrote:
> This member has exactly the same value as n_bytes of the DW SPI private
> data object, it's calculated at the same point of the transfer method,
> n_bytes isn't changed during the whole transfer, and they even serve for
> the same purpose - keep number of bytes per transfer word, though the
> dma_width is used only to calculate the DMA source/destination addresses
> width, which n_bytes could be also utilized for. Taking all of these
> into account let's replace the dma_width member usage with n_bytes one
> and remove the former.

I've no strong opinion about this.
So, after addressing one issue below,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

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
>  drivers/spi/spi-dw-mid.c | 10 +++++-----
>  drivers/spi/spi-dw.c     |  1 -
>  drivers/spi/spi-dw.h     |  1 -
>  3 files changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/spi/spi-dw-mid.c b/drivers/spi/spi-dw-mid.c
> index be886e22a1b1..ca8813a693d8 100644
> --- a/drivers/spi/spi-dw-mid.c
> +++ b/drivers/spi/spi-dw-mid.c
> @@ -132,10 +132,10 @@ static bool mid_spi_can_dma(struct spi_controller *master,
>  	return xfer->len > dws->fifo_len;
>  }
>  
> -static enum dma_slave_buswidth convert_dma_width(u32 dma_width) {
> -	if (dma_width == 1)

> +static enum dma_slave_buswidth convert_dma_width(u8 n_bytes) {

It seems somebody (maybe even me) at some point messed up between enum
definition and function that returns an enum.

For what said, { should be on the separate line.

> +	if (n_bytes == 1)
>  		return DMA_SLAVE_BUSWIDTH_1_BYTE;
> -	else if (dma_width == 2)
> +	else if (n_bytes == 2)
>  		return DMA_SLAVE_BUSWIDTH_2_BYTES;
>  
>  	return DMA_SLAVE_BUSWIDTH_UNDEFINED;
> @@ -195,7 +195,7 @@ static struct dma_async_tx_descriptor *dw_spi_dma_prepare_tx(struct dw_spi *dws,
>  	txconf.dst_addr = dws->dma_addr;
>  	txconf.dst_maxburst = 16;
>  	txconf.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
> -	txconf.dst_addr_width = convert_dma_width(dws->dma_width);
> +	txconf.dst_addr_width = convert_dma_width(dws->n_bytes);
>  	txconf.device_fc = false;
>  
>  	dmaengine_slave_config(dws->txchan, &txconf);
> @@ -268,7 +268,7 @@ static struct dma_async_tx_descriptor *dw_spi_dma_prepare_rx(struct dw_spi *dws,
>  	rxconf.src_addr = dws->dma_addr;
>  	rxconf.src_maxburst = 16;
>  	rxconf.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
> -	rxconf.src_addr_width = convert_dma_width(dws->dma_width);
> +	rxconf.src_addr_width = convert_dma_width(dws->n_bytes);
>  	rxconf.device_fc = false;
>  
>  	dmaengine_slave_config(dws->rxchan, &rxconf);
> diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
> index 450c8218caeb..1edb8cdd11ee 100644
> --- a/drivers/spi/spi-dw.c
> +++ b/drivers/spi/spi-dw.c
> @@ -353,7 +353,6 @@ static int dw_spi_transfer_one(struct spi_controller *master,
>  	}
>  
>  	dws->n_bytes = DIV_ROUND_UP(transfer->bits_per_word, BITS_PER_BYTE);
> -	dws->dma_width = DIV_ROUND_UP(transfer->bits_per_word, BITS_PER_BYTE);
>  
>  	cr0 = dws->update_cr0(master, spi, transfer);
>  	dw_writel(dws, DW_SPI_CTRLR0, cr0);
> diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
> index b6ab81e0c747..4902f937c3d7 100644
> --- a/drivers/spi/spi-dw.h
> +++ b/drivers/spi/spi-dw.h
> @@ -136,7 +136,6 @@ struct dw_spi {
>  	void			*rx_end;
>  	int			dma_mapped;
>  	u8			n_bytes;	/* current is a 1/2 bytes op */
> -	u32			dma_width;
>  	irqreturn_t		(*transfer_handler)(struct dw_spi *dws);
>  	u32			current_freq;	/* frequency in hz */
>  
> -- 
> 2.25.1
> 

-- 
With Best Regards,
Andy Shevchenko


