Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99F98295E16
	for <lists+linux-spi@lfdr.de>; Thu, 22 Oct 2020 14:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503915AbgJVMM7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 22 Oct 2020 08:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503681AbgJVMM7 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 22 Oct 2020 08:12:59 -0400
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5f64:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F10FEC0613CE;
        Thu, 22 Oct 2020 05:12:58 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 40AA030000E5D;
        Thu, 22 Oct 2020 14:12:55 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 2DCBEF5996; Thu, 22 Oct 2020 14:12:55 +0200 (CEST)
Date:   Thu, 22 Oct 2020 14:12:54 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Vladimir Oltean <olteanv@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
Subject: Re: Use after free in bcm2835_spi_remove()
Message-ID: <20201022121254.GA3847@wunner.de>
References: <bd6eaa71-46cc-0aca-65ff-ae716864cbe3@gmail.com>
 <20201014140912.GB24850@wunner.de>
 <20201014194035.ukduovokggu37uba@skbuf>
 <20201014202505.GF4580@sirena.org.uk>
 <b094c266-99ce-4462-9041-7d1659b13300@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b094c266-99ce-4462-9041-7d1659b13300@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Oct 14, 2020 at 02:20:16PM -0700, Florian Fainelli wrote:
> In bcm2835_spi_remove(), spi_controller_unregister() will free the ctlr
> reference which will lead to an use after free in bcm2835_release_dma().
> 
> To avoid this use after free, allocate the bcm2835_spi structure with a
> different lifecycle than the spi_controller structure such that we
> unregister the SPI controller, free up all the resources and finally let
> device managed allocations free the bcm2835_spi structure.
[...]
> -	if (ctlr->dma_tx) {
> -		dmaengine_terminate_sync(ctlr->dma_tx);
> +	if (dma_tx) {
> +		dmaengine_terminate_sync(dma_tx);
>  
>  		if (bs->fill_tx_desc)
>  			dmaengine_desc_free(bs->fill_tx_desc);
>  
>  		if (bs->fill_tx_addr)
> -			dma_unmap_page_attrs(ctlr->dma_tx->device->dev,
> +			dma_unmap_page_attrs(dma_tx->device->dev,
>  					     bs->fill_tx_addr, sizeof(u32),
>  					     DMA_TO_DEVICE,
>  					     DMA_ATTR_SKIP_CPU_SYNC);
>  
> -		dma_release_channel(ctlr->dma_tx);
> -		ctlr->dma_tx = NULL;
> +		dma_release_channel(dma_tx);
>  	}

You must set ctlr->dma_tx and ctlr->dma_rx to NULL because the driver
checks their value in a couple of places.

E.g. bcm2835_spi_setup() checks ctlr->dma_rx.

Likewise, the error paths of bcm2835_dma_init() and bcm2835_spi_probe()
call bcm2835_dma_release() and the latter checks ctlr->dma_tx and
ctlr->dma_rx to determine whether DMA was set up, hence needs to be
torn down.


> +	bs = devm_kzalloc(&pdev->dev, sizeof(*bs), GFP_KERNEL);
> +	if (!bs)
> +		return -ENOMEM;
> +
>  	ctlr = spi_alloc_master(&pdev->dev, ALIGN(sizeof(*bs),
>  						  dma_get_cache_alignment()));

You can set the second argument to spi_alloc_master() to 0
to conserve memory.

Thanks,

Lukas
