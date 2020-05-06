Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA7E71C7515
	for <lists+linux-spi@lfdr.de>; Wed,  6 May 2020 17:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729458AbgEFPi7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 6 May 2020 11:38:59 -0400
Received: from mga17.intel.com ([192.55.52.151]:42845 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725887AbgEFPi7 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 6 May 2020 11:38:59 -0400
IronPort-SDR: V9zniGRxmzr/N0rEupUrGTsCjC46QGjdhFLy3uZLcZnLtF20zBBNrJMW6aYAkbGpcWUoY9+sEG
 sElxceRrfT1w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2020 08:38:57 -0700
IronPort-SDR: 55aG4GQ4XHRfy5uFkJgDfxV+hAnt3plcUTnk9dQ1WcbY+d9hZUSqbsWTWb4HIiiEu6DnIZ60kD
 dROYJ2wuKgrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,359,1583222400"; 
   d="scan'208";a="407280476"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.147.136])
  by orsmga004.jf.intel.com with ESMTP; 06 May 2020 08:38:56 -0700
Date:   Wed, 6 May 2020 23:38:55 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Subject: Re: [PATCH v1 1/8] spi: dw: Zero DMA Tx and Rx configurations on
 stack
Message-ID: <20200506153855.GA18389@shbuild999.sh.intel.com>
References: <20200506153025.21441-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506153025.21441-1-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, May 06, 2020 at 06:30:18PM +0300, Andy Shevchenko wrote:
> Some DMA controller drivers do not tolerate non-zero values in
> the DMA configuration structures. Zero them to avoid issues with
> such DMA controller drivers. Even despite above this is a good
> practice per se.
> 
> Fixes: 7063c0d942a1 ("spi/dw_spi: add DMA support")
> Cc: Feng Tang <feng.tang@intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Feng Tang <feng.tang@intel.com>

Thanks,
Feng

> ---
>  drivers/spi/spi-dw-mid.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/spi/spi-dw-mid.c b/drivers/spi/spi-dw-mid.c
> index 9cc010e9737e8..86d9f79267f05 100644
> --- a/drivers/spi/spi-dw-mid.c
> +++ b/drivers/spi/spi-dw-mid.c
> @@ -147,6 +147,7 @@ static struct dma_async_tx_descriptor *dw_spi_dma_prepare_tx(struct dw_spi *dws,
>  	if (!xfer->tx_buf)
>  		return NULL;
>  
> +	memset(&txconf, 0, sizeof(txconf));
>  	txconf.direction = DMA_MEM_TO_DEV;
>  	txconf.dst_addr = dws->dma_addr;
>  	txconf.dst_maxburst = 16;
> @@ -193,6 +194,7 @@ static struct dma_async_tx_descriptor *dw_spi_dma_prepare_rx(struct dw_spi *dws,
>  	if (!xfer->rx_buf)
>  		return NULL;
>  
> +	memset(&rxconf, 0, sizeof(rxconf));
>  	rxconf.direction = DMA_DEV_TO_MEM;
>  	rxconf.src_addr = dws->dma_addr;
>  	rxconf.src_maxburst = 16;
> -- 
> 2.26.2
