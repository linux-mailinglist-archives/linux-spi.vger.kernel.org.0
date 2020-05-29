Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B93091E86DA
	for <lists+linux-spi@lfdr.de>; Fri, 29 May 2020 20:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725839AbgE2Skz (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 29 May 2020 14:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbgE2Sky (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 29 May 2020 14:40:54 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23639C03E969
        for <linux-spi@vger.kernel.org>; Fri, 29 May 2020 11:40:54 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id z18so415558lji.12
        for <linux-spi@vger.kernel.org>; Fri, 29 May 2020 11:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+PBJeCAJtGOfxMZet2xb8hp9tu73ZodIKa6sq926H8k=;
        b=ejHgKvoZ/cNt0Dv5XTjplXHvE7dYv740jsKctNWTYKZcFq2R1/iStvFt+ewImVbnsn
         Dsbmh4dlVR/0dHkb5R62iv+nKIdKqinIDdrnXox+rZNtN8W+j6SlMj0m6cAQ0bRJnZ3+
         Y70fiyFmeFAQt55pi7gI7ubGr09UznNVbZIYtZnWbLDo2PvZ+Qsd8ydeh43ZAcjg72Ix
         /glIhYwfbDXTom8hg8kxh1EKRU+T4SF9UTGdTKbC+Bprq67Awhj/p+1+pAnobQzYFUnT
         6GC9SGd32G67Kdv10fWvmAh0n0TUWcAHFUoOHsE9AwgscYS1N+gFgZoSR861OXLUoa3Q
         KPcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+PBJeCAJtGOfxMZet2xb8hp9tu73ZodIKa6sq926H8k=;
        b=njxVmBpSAM5qki6h3Kmvnhtp3MXu0lsA1MGbUn6paSDalbLkTLhFz1NDv0NxSp4ILK
         0loEQV60c/2OqtV0ikT3wyBK4fBloFwJfjlHLNIUVreGaqcX9v7ceDsR7mSIZovpP3s8
         fgVkOrda7kr0nCxls0uLykqFWZJ1wIpL+BtQPr1vAiRNy//V/VoaubI1TANcSDJLvdkb
         xsF1Rrh7E03DG3GQZWD/pzmfirQOh5+44kR4eRq/SMXse96ovXcozmrHLaBbPRMjjLPm
         vvI3S6XRWdRu/bIQzy3DdiIVF/7mqzPFelGRr8J30JtyP69xKpp4JT/MM5M++6Mhcsb0
         taTw==
X-Gm-Message-State: AOAM530WqllELbXU/EnlIOvkQNzjz5UpjaYXxhKp7CNPXTM8vJljjjC4
        nnEb8vcfz3iQC2F0PTQns3t6lJ7P
X-Google-Smtp-Source: ABdhPJwyGtbOB1Ynhl5fPsF8uhAx+OnJrjImJLYtExdO5299EpsAy7wNvf1hOhaxq9QSlvDcwrERHQ==
X-Received: by 2002:a05:651c:2c1:: with SMTP id f1mr4565480ljo.440.1590777652479;
        Fri, 29 May 2020 11:40:52 -0700 (PDT)
Received: from mobilestation ([95.79.222.123])
        by smtp.gmail.com with ESMTPSA id h25sm2154409lji.105.2020.05.29.11.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 11:40:51 -0700 (PDT)
Date:   Fri, 29 May 2020 21:40:50 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Subject: Re: [PATCH v2 1/2] spi: dw: Make DMA request line assignments
 explicit for Intel Medfield
Message-ID: <20200529184050.bkn72tash33zgoo4@mobilestation>
References: <20200529183150.44149-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200529183150.44149-1-andriy.shevchenko@linux.intel.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, May 29, 2020 at 09:31:49PM +0300, Andy Shevchenko wrote:
> The 2afccbd283ae ("spi: dw: Discard static DW DMA slave structures")
> did a clean up of global variables, which is fine, but messed up with
> the carefully provided information in the custom DMA slave structures.
> There reader can find an assignment of the DMA request lines in use.
> 
> Partially revert the above mentioned commit to restore readability
> and maintainability of the code.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v2: rebased against latest spi/for-next
>  drivers/spi/spi-dw-dma.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/spi/spi-dw-dma.c b/drivers/spi/spi-dw-dma.c
> index 1b96cec6d8cd..53d5257662e8 100644
> --- a/drivers/spi/spi-dw-dma.c
> +++ b/drivers/spi/spi-dw-dma.c
> @@ -61,10 +61,8 @@ static void dw_spi_dma_maxburst_init(struct dw_spi *dws)
>  
>  static int dw_spi_dma_init_mfld(struct device *dev, struct dw_spi *dws)
>  {
> -	struct dw_dma_slave slave = {
> -		.src_id = 0,
> -		.dst_id = 0
> -	};

> +	struct dw_dma_slave dma_tx = { .dst_id = 1 }, *tx = &dma_tx;
> +	struct dw_dma_slave dma_rx = { .src_id = 0 }, *rx = &dma_rx;

You know my attitude to these changes.) But anyway what's the point in having
the *tx and *rx pointers here? Without any harm to the readability you can use
the structures names directly, don't you?

-Sergey

>  	struct pci_dev *dma_dev;
>  	dma_cap_mask_t mask;
>  
> @@ -80,14 +78,14 @@ static int dw_spi_dma_init_mfld(struct device *dev, struct dw_spi *dws)
>  	dma_cap_set(DMA_SLAVE, mask);
>  
>  	/* 1. Init rx channel */
> -	slave.dma_dev = &dma_dev->dev;
> -	dws->rxchan = dma_request_channel(mask, dw_spi_dma_chan_filter, &slave);
> +	rx->dma_dev = &dma_dev->dev;
> +	dws->rxchan = dma_request_channel(mask, dw_spi_dma_chan_filter, rx);
>  	if (!dws->rxchan)
>  		goto err_exit;
>  
>  	/* 2. Init tx channel */
> -	slave.dst_id = 1;
> -	dws->txchan = dma_request_channel(mask, dw_spi_dma_chan_filter, &slave);
> +	tx->dma_dev = &dma_dev->dev;
> +	dws->txchan = dma_request_channel(mask, dw_spi_dma_chan_filter, tx);
>  	if (!dws->txchan)
>  		goto free_rxchan;
>  
> -- 
> 2.26.2
> 
