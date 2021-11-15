Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 291044507DF
	for <lists+linux-spi@lfdr.de>; Mon, 15 Nov 2021 16:09:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236263AbhKOPMB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 15 Nov 2021 10:12:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232236AbhKOPL6 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 15 Nov 2021 10:11:58 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E55F2C061570;
        Mon, 15 Nov 2021 07:08:59 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id e11so36151067ljo.13;
        Mon, 15 Nov 2021 07:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NPK4K9Ju2yywKI0BG0IcBEX8s7KRKDyaFbcL4r2WaYU=;
        b=TJ0ECKiv5uOop34/+AEO3WraYEEShcWm9WLrlWmTnbAjBYHH6CSeY98zDIdGJyiRWO
         dxu0y3cMAyZLr/gPumxXQ7JRhw2l5qU5rsu3c2RrUlfxGtf13p8HGGYZy2BVsVWV2vSZ
         +DGdgKA58Mamb9qnS7yQ9BGxHgR81JttEzhecVBpQ+aSZCXZGmxIUoOXibku8cqzowXk
         MZi2F7ks9zd/YwWT+bbKzLwPuQ7A91Hls1KDHpJokIffW3yvU+2abj/lK7DzJXOybY7A
         vrtYOfNhfV7Mszr7I1wvbddMo17m/P2h04YEXlZz4iNHtalIAaUBSf8sCj4HbuJ41/M9
         AGJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NPK4K9Ju2yywKI0BG0IcBEX8s7KRKDyaFbcL4r2WaYU=;
        b=e3GcTC5QWGlDC6yOo0UChreAZM0u1k0Qiw8ewqQgw78vfCWQ5T0kvW0NE1pp3RT09e
         BPg72I+9Q/agfoxlfLCSeEbZapXqXkaA6kPAupSDYGW/PxHIzC0KOAYIO0s2lcXFCx76
         bDk3XJJSIihyCEUfXWgUWc6TBoTjsQJ75ZISJDfcqVflYbJfUYWHbHO6YGlZli73sPpP
         T3uphMiPmb0nnS5N7YjW8y0pJ5fGOJwWREd2AT6eW8FxlsVTSEhBPIUwlL+reLqZIMgg
         319dSXz+B/7+g5EtJIl9iFJEM3m322D9kga8jIsHUfvS+XSNmq8+8CKVVMi2K2wYxv7E
         tG5g==
X-Gm-Message-State: AOAM533J9eDaZupGL/AN+kS8FbioisGp3h6+CLwYRkpzw4Fzd5QCfpqK
        MHSEbFoOrDPg654YEmi+ILSr63vIj8E=
X-Google-Smtp-Source: ABdhPJzPhCg3naIp6+0mRBoh48FksrIVDlsD8k/2eUO3WNaZ1+p5LK/GfQZwFSQPbaZgjLM89f1aWw==
X-Received: by 2002:a2e:bf06:: with SMTP id c6mr39261412ljr.405.1636988938284;
        Mon, 15 Nov 2021 07:08:58 -0800 (PST)
Received: from mobilestation ([95.79.188.236])
        by smtp.gmail.com with ESMTPSA id x3sm1357807lfq.238.2021.11.15.07.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 07:08:57 -0800 (PST)
Date:   Mon, 15 Nov 2021 18:08:56 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Mark Brown <broonie@kernel.org>,
        Nandhini Srikandan <nandhini.srikandan@intel.com>,
        Andy Shevchenko <andy@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/6] spi: dw: Replace DWC_HSSI capability with IP-core
 version checker
Message-ID: <20211115150856.ma2wjg2ev5wylspg@mobilestation>
References: <20211114223026.13359-1-Sergey.Semin@baikalelectronics.ru>
 <20211114223026.13359-7-Sergey.Semin@baikalelectronics.ru>
 <YZJwTgAPZYVvzGpi@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YZJwTgAPZYVvzGpi@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Nov 15, 2021 at 04:35:58PM +0200, Andy Shevchenko wrote:
> On Mon, Nov 15, 2021 at 01:30:26AM +0300, Serge Semin wrote:
> > Since there is a common IP-core and component versions interface available
> > we can use it to differentiate the DW HSSI device features in the code.
> > Let's remove the corresponding DWC_HSSI capability flag then and use the
> > dw_spi_ip_is() macro instead.
> 
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> 
> But see below.
> 
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > 
> > ---
> > 
> > Changelog v2:
> > - This is a new patch created as a logical result of a new DW SSI IP-core
> >   versions internal interface introduced in the previous patch.
> > ---
> >  drivers/spi/spi-dw-core.c | 8 ++++----
> >  drivers/spi/spi-dw-mmio.c | 5 +++--
> >  drivers/spi/spi-dw.h      | 3 +--
> >  3 files changed, 8 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
> > index 42536b448ddd..934cc7a922e8 100644
> > --- a/drivers/spi/spi-dw-core.c
> > +++ b/drivers/spi/spi-dw-core.c
> > @@ -272,7 +272,7 @@ static u32 dw_spi_prepare_cr0(struct dw_spi *dws, struct spi_device *spi)
> >  {
> >  	u32 cr0 = 0;
> >  
> > -	if (!(dws->caps & DW_SPI_CAP_DWC_HSSI)) {
> > +	if (dw_spi_ip_is(dws, PSSI)) {
> >  		/* CTRLR0[ 5: 4] Frame Format */
> >  		cr0 |= FIELD_PREP(DW_PSSI_CTRLR0_FRF_MASK, DW_SPI_CTRLR0_FRF_MOTO_SPI);
> >  
> > @@ -325,7 +325,7 @@ void dw_spi_update_config(struct dw_spi *dws, struct spi_device *spi,
> >  	/* CTRLR0[ 4/3: 0] or CTRLR0[ 20: 16] Data Frame Size */
> >  	cr0 |= (cfg->dfs - 1) << dws->dfs_offset;
> >  
> > -	if (!(dws->caps & DW_SPI_CAP_DWC_HSSI))
> > +	if (dw_spi_ip_is(dws, PSSI))
> >  		/* CTRLR0[ 9:8] Transfer Mode */
> >  		cr0 |= FIELD_PREP(DW_PSSI_CTRLR0_TMOD_MASK, cfg->tmode);
> >  	else
> > @@ -832,7 +832,7 @@ static void dw_spi_hw_init(struct device *dev, struct dw_spi *dws)
> >  		dws->ver = dw_readl(dws, DW_SPI_VERSION);
> >  
> >  		dev_dbg(dev, "Synopsys DWC%sSSI v%c.%c%c\n",
> > -			(dws->caps & DW_SPI_CAP_DWC_HSSI) ? " " : " APB ",
> > +			dw_spi_ip_is(dws, PSSI) ? " APB " : " ",
> >  			DW_SPI_GET_BYTE(dws->ver, 3), DW_SPI_GET_BYTE(dws->ver, 2),
> >  			DW_SPI_GET_BYTE(dws->ver, 1));
> >  	}
> > @@ -860,7 +860,7 @@ static void dw_spi_hw_init(struct device *dev, struct dw_spi *dws)
> >  	 * writability. Note DWC SSI controller also has the extended DFS, but
> >  	 * with zero offset.
> >  	 */
> > -	if (!(dws->caps & DW_SPI_CAP_DWC_HSSI)) {
> > +	if (dw_spi_ip_is(dws, PSSI)) {
> >  		u32 cr0, tmp = dw_readl(dws, DW_SPI_CTRLR0);
> >  
> >  		dw_spi_enable_chip(dws, 0);
> > diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
> > index 0b37bd32b041..c0e5bb6add0a 100644
> > --- a/drivers/spi/spi-dw-mmio.c
> > +++ b/drivers/spi/spi-dw-mmio.c
> > @@ -207,7 +207,7 @@ static int dw_spi_pssi_init(struct platform_device *pdev,
> >  static int dw_spi_hssi_init(struct platform_device *pdev,
> >  			    struct dw_spi_mmio *dwsmmio)
> >  {
> > -	dwsmmio->dws.caps = DW_SPI_CAP_DWC_HSSI;
> > +	dwsmmio->dws.ip = DW_HSSI_ID;
> >  
> >  	dw_spi_dma_setup_generic(&dwsmmio->dws);
> >  
> > @@ -217,7 +217,8 @@ static int dw_spi_hssi_init(struct platform_device *pdev,
> >  static int dw_spi_keembay_init(struct platform_device *pdev,
> >  			       struct dw_spi_mmio *dwsmmio)
> >  {
> > -	dwsmmio->dws.caps = DW_SPI_CAP_KEEMBAY_MST | DW_SPI_CAP_DWC_HSSI;
> > +	dwsmmio->dws.ip = DW_HSSI_ID;
> > +	dwsmmio->dws.caps = DW_SPI_CAP_KEEMBAY_MST;
> >  
> >  	return 0;
> >  }
> > diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
> > index 2f7d77024b48..d5ee5130601e 100644
> > --- a/drivers/spi/spi-dw.h
> > +++ b/drivers/spi/spi-dw.h
> > @@ -32,8 +32,7 @@
> >  /* DW SPI controller capabilities */
> >  #define DW_SPI_CAP_CS_OVERRIDE		BIT(0)
> >  #define DW_SPI_CAP_KEEMBAY_MST		BIT(1)
> > -#define DW_SPI_CAP_DWC_HSSI		BIT(2)
> > -#define DW_SPI_CAP_DFS32		BIT(3)
> > +#define DW_SPI_CAP_DFS32		BIT(2)
> 

> In one patch you move this in the file upper.
> Here you reshuffling it due to dropping one bit.
> 
> Now I'm wondering if you may split these two into a separate patch, which
> brings us to simple
> 
> -#define DW_SPI_CAP_DWC_HSSI		BIT(3)
> 
> here.

I can change the bit-numbers assignment in the previous patch, which
moves this block of macros up to the top of the file. Thus we'll
have just a single 
-#define DW_SPI_CAP_DWC_HSSI		BIT(3)
here. What do you think? Is that what you meant?

-Sergey

> 
> >  
> >  /* Register offsets (Generic for both DWC APB SSI and DWC SSI IP-cores) */
> >  #define DW_SPI_CTRLR0			0x00
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
