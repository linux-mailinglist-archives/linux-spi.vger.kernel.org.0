Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEC541E8728
	for <lists+linux-spi@lfdr.de>; Fri, 29 May 2020 21:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgE2TEW (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 29 May 2020 15:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726549AbgE2TEV (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 29 May 2020 15:04:21 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9103C03E969
        for <linux-spi@vger.kernel.org>; Fri, 29 May 2020 12:04:20 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id l15so520357lje.9
        for <linux-spi@vger.kernel.org>; Fri, 29 May 2020 12:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UlorwJFsGs3RhHEqh2b/E8v/dDLOHe+di5coXAplRw8=;
        b=TvQ+s6oxyYxGfRjj90Aylgw1pVP/KDTHWLG4iAA19VWwWjINIfFoqus2aunxuLqbvO
         ptn9lL+M4TdsA6pskQ/92nOjvYZKdIJAiUtOTNS1WDdkXntfh5Cb38DLFmn+AiZ8MUZa
         6kCxGBjhyhqZkqN+RQFfdpUU23FmEauC8KAatjddoG7SOSugaliTvoMnOEkjUQbAyqeG
         oD5Y8SwqU/oeTGBKnorvaZYcxI+24lTwtCDVHOzY1PX+TDPNkdMN/MbhjVsYIPW9li3E
         1uPyAgAyTPMRlbWe+NJyOWAztaiNFOwqU49sGoU+eVsQbW9eoFRuHY8EKSDhGcHrPiVe
         4J4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UlorwJFsGs3RhHEqh2b/E8v/dDLOHe+di5coXAplRw8=;
        b=HFrXt0WKZNvyn5v9n+rVYl8QpdikLIHT8VJHWYf3QeJk4Y+zaL+RF9WuuBCdZfLooG
         8zIY7N/N89SpN/jiuMCEKua45SKoqQhUT1vqtypaFxWVmaPxxi+ErR9iAnCxl+LrIzSu
         HvuCsaBco7vzIXq5jEyIDFqKMlkPxOTuZyHrGiMr3MdHxGtUMNgNtY/fT5kCwJgyURkj
         /BjTz10Y86PFUwB+daRa3MpH9GSNHHt9jxKWJJ8fqobOBEMjtHFB3CBpzWSAS1bfI2uq
         DGrZhOSD4tVkhAGpke+HVaLJpb+8AK01flGQDb/RD0XvRHGlSHNf+xfra7UpmFmvGV67
         HoyQ==
X-Gm-Message-State: AOAM530/reyry061NSek3sHlyzqvjBq1WsScRX2t+dRc5AS/n23mAmIx
        3E1QmmWwDROD0bbikOChVmyipT5C
X-Google-Smtp-Source: ABdhPJxvIYgZS3pSXdYM6rhTar6639VCencPENIDmkTCi4ocrgavk8nXU19otPWD6E2geRKVh5zpYA==
X-Received: by 2002:a2e:9792:: with SMTP id y18mr4844018lji.389.1590779059141;
        Fri, 29 May 2020 12:04:19 -0700 (PDT)
Received: from mobilestation ([95.79.222.123])
        by smtp.gmail.com with ESMTPSA id 205sm2437164lfe.73.2020.05.29.12.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 12:04:18 -0700 (PDT)
Date:   Fri, 29 May 2020 22:04:16 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Subject: Re: [PATCH v2 1/2] spi: dw: Make DMA request line assignments
 explicit for Intel Medfield
Message-ID: <20200529190416.lwou54v6a3suicfd@mobilestation>
References: <20200529183150.44149-1-andriy.shevchenko@linux.intel.com>
 <20200529184050.bkn72tash33zgoo4@mobilestation>
 <20200529184955.GY1634618@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200529184955.GY1634618@smile.fi.intel.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, May 29, 2020 at 09:49:55PM +0300, Andy Shevchenko wrote:
> On Fri, May 29, 2020 at 09:40:50PM +0300, Serge Semin wrote:
> > On Fri, May 29, 2020 at 09:31:49PM +0300, Andy Shevchenko wrote:
> > > The 2afccbd283ae ("spi: dw: Discard static DW DMA slave structures")
> > > did a clean up of global variables, which is fine, but messed up with
> > > the carefully provided information in the custom DMA slave structures.
> > > There reader can find an assignment of the DMA request lines in use.
> > > 
> > > Partially revert the above mentioned commit to restore readability
> > > and maintainability of the code.
> > > 
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > ---
> > > v2: rebased against latest spi/for-next
> > >  drivers/spi/spi-dw-dma.c | 14 ++++++--------
> > >  1 file changed, 6 insertions(+), 8 deletions(-)
> > > 
> > > diff --git a/drivers/spi/spi-dw-dma.c b/drivers/spi/spi-dw-dma.c
> > > index 1b96cec6d8cd..53d5257662e8 100644
> > > --- a/drivers/spi/spi-dw-dma.c
> > > +++ b/drivers/spi/spi-dw-dma.c
> > > @@ -61,10 +61,8 @@ static void dw_spi_dma_maxburst_init(struct dw_spi *dws)
> > >  
> > >  static int dw_spi_dma_init_mfld(struct device *dev, struct dw_spi *dws)
> > >  {
> > > -	struct dw_dma_slave slave = {
> > > -		.src_id = 0,
> > > -		.dst_id = 0
> > > -	};
> > 
> > > +	struct dw_dma_slave dma_tx = { .dst_id = 1 }, *tx = &dma_tx;
> > > +	struct dw_dma_slave dma_rx = { .src_id = 0 }, *rx = &dma_rx;
> > 


> > You know my attitude to these changes.) But anyway what's the point in having
> > the *tx and *rx pointers here? Without any harm to the readability you can use
> > the structures names directly, don't you?
> 
> I will wait for Mark to decide.

So no response to a review comment? Shall I do the same when get a review from
you?.)

I am not asking about the whole patch purpose. You know what I think about it.
My question was about why *tx and *rx pointers are required? Just wondering, I
may misunderstand something... As I see it you could use dma_tx and dma_rx here
directly with the same level of readability.

-Sergey
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
