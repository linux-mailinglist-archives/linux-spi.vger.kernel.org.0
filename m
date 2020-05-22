Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9541DE505
	for <lists+linux-spi@lfdr.de>; Fri, 22 May 2020 13:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729164AbgEVLGX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 22 May 2020 07:06:23 -0400
Received: from mga14.intel.com ([192.55.52.115]:9263 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728371AbgEVLGX (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 22 May 2020 07:06:23 -0400
IronPort-SDR: XRs3O2dpSFvkbXL0Pd3as093n7g/NEeNuiImE1ocoCbeHtvh2kEHhFUmssjjdMejRIdb420BbF
 wpHHuVsfih9A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2020 04:06:21 -0700
IronPort-SDR: 2aBPZ7H7oP4wUrAMiWnRuOvpa8vghN3jUDyQ6zUOMncD+XFaAfDtEf6mmt9TEPtwcIymDAPGEZ
 VEfD0y5fpMbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,421,1583222400"; 
   d="scan'208";a="283367982"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga002.jf.intel.com with ESMTP; 22 May 2020 04:06:16 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jc5VL-008DYB-IO; Fri, 22 May 2020 14:06:19 +0300
Date:   Fri, 22 May 2020 14:06:19 +0300
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
        devicetree@vger.kernel.org,
        Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 06/16] spi: dw: Parameterize the DMA Rx/Tx burst length
Message-ID: <20200522110619.GU1634618@smile.fi.intel.com>
References: <20200522000806.7381-1-Sergey.Semin@baikalelectronics.ru>
 <20200522000806.7381-7-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200522000806.7381-7-Sergey.Semin@baikalelectronics.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, May 22, 2020 at 03:07:55AM +0300, Serge Semin wrote:
> It isn't good to have numeric literals in the code especially if there
> are multiple of them and they are related. Let's replace the Tx and Rx
> burst level literals with the corresponding constants.


You missed my tag.

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
> index c39bc8758339..1598c36c905f 100644
> --- a/drivers/spi/spi-dw-mid.c
> +++ b/drivers/spi/spi-dw-mid.c
> @@ -20,7 +20,9 @@
>  
>  #define WAIT_RETRIES	5
>  #define RX_BUSY		0
> +#define RX_BURST_LEVEL	16
>  #define TX_BUSY		1
> +#define TX_BURST_LEVEL	16
>  
>  static bool mid_spi_dma_chan_filter(struct dma_chan *chan, void *param)
>  {
> @@ -198,7 +200,7 @@ static struct dma_async_tx_descriptor *dw_spi_dma_prepare_tx(struct dw_spi *dws,
>  	memset(&txconf, 0, sizeof(txconf));
>  	txconf.direction = DMA_MEM_TO_DEV;
>  	txconf.dst_addr = dws->dma_addr;
> -	txconf.dst_maxburst = 16;
> +	txconf.dst_maxburst = TX_BURST_LEVEL;
>  	txconf.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
>  	txconf.dst_addr_width = convert_dma_width(dws->n_bytes);
>  	txconf.device_fc = false;
> @@ -273,7 +275,7 @@ static struct dma_async_tx_descriptor *dw_spi_dma_prepare_rx(struct dw_spi *dws,
>  	memset(&rxconf, 0, sizeof(rxconf));
>  	rxconf.direction = DMA_DEV_TO_MEM;
>  	rxconf.src_addr = dws->dma_addr;
> -	rxconf.src_maxburst = 16;
> +	rxconf.src_maxburst = RX_BURST_LEVEL;
>  	rxconf.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
>  	rxconf.src_addr_width = convert_dma_width(dws->n_bytes);
>  	rxconf.device_fc = false;
> @@ -298,8 +300,8 @@ static int mid_spi_dma_setup(struct dw_spi *dws, struct spi_transfer *xfer)
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


