Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E24FF4530E4
	for <lists+linux-spi@lfdr.de>; Tue, 16 Nov 2021 12:36:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235088AbhKPLjI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 16 Nov 2021 06:39:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235379AbhKPLho (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 16 Nov 2021 06:37:44 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8983AC061198;
        Tue, 16 Nov 2021 03:32:13 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id c32so52344876lfv.4;
        Tue, 16 Nov 2021 03:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0wHfYNBbY8FMdZUkxBiBczwR2At84lrdrMa7+k/uGck=;
        b=auVex1g5JoqReaZ8JAUPU+QM5e9X+3RnRs59GB02CYvHTyNj+hB8jus9eFhGF2Ogxu
         q05TZMZ4rTE4AdEml28q6tpAJRWbI+vB+H0fbazMmUoCUqe64K0E682cTMm6clSCbpLW
         J5w7m9U0j2H5x2Yl+wi7qbtJ0x/M9uc6myC0t0XBq0sZKnVJnBjuP30Dad1itTUSSs8w
         rfl+5fMZtmSh4QY3LzrTHO9PW+mIIJWKWL+cWjRuFwiDdpNW/a3ytxWgC8EFumjVoH2N
         sjbEkMVPgDbbEhMOuP2ruhvEMewF1qVYG8+TcTUCyrGFCtJAU2AGVUuSGu4kp2t05uQp
         Pskg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0wHfYNBbY8FMdZUkxBiBczwR2At84lrdrMa7+k/uGck=;
        b=4FYs2RJzzYh+m1fJJMF6C1rw/msaIqVuZRJA7AQahKHLN2924OnLwW5MHN3D+3QpFu
         xrD3/WLbqGAF8qBdfnKrv0o/3tF7QcN3jJNuxVQR1PwKqaNTUSzu9OkB9oZ2QztLgENK
         Ve5mNkDjvPZUBtjmZ2gUU7hIzlyxvJnASDDwkYrTuyX6C8bnTa7H5A4XV6xqP45AFLrj
         9SUQQIqMoCAcU/tsy2IVneO2uIwgayblYhVlmgWtYYfOnmu1HaTvpxDEE8Z3W5Q6ottG
         OJOoLwk5/EQ5bvXb8AZGyEj13PHE2s5xmzVr6+OiI8Au95o5v5849MQLFUG4aPrGAdru
         2pGg==
X-Gm-Message-State: AOAM532Prp3Fjngto0yH5zHedW+dCnDkLxTEQOeY83Qwl5W8TSqEjSI+
        ipgPrHdX6vWwC7igJt4wHJA=
X-Google-Smtp-Source: ABdhPJwp4ntrXwEtL8pC4eKsuqTGCFz0FKTnz4Mju7GtHehKLTBxsfvLtIWU8o7nFk5VTBaRaXeTdg==
X-Received: by 2002:a05:6512:3f8b:: with SMTP id x11mr5750586lfa.486.1637062331999;
        Tue, 16 Nov 2021 03:32:11 -0800 (PST)
Received: from mobilestation ([95.79.188.236])
        by smtp.gmail.com with ESMTPSA id m20sm1726896lfu.241.2021.11.16.03.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 03:32:11 -0800 (PST)
Date:   Tue, 16 Nov 2021 14:32:09 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Mark Brown <broonie@kernel.org>,
        Nandhini Srikandan <nandhini.srikandan@intel.com>,
        Andy Shevchenko <andy@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 7/7] spi: dw: Define the capabilities in a continuous
 bit-flags set
Message-ID: <20211116113209.n5njzklgh3fmbwwe@mobilestation>
References: <20211115181917.7521-1-Sergey.Semin@baikalelectronics.ru>
 <20211115181917.7521-8-Sergey.Semin@baikalelectronics.ru>
 <YZOEM591s7iulPH1@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YZOEM591s7iulPH1@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Nov 16, 2021 at 12:13:07PM +0200, Andy Shevchenko wrote:
> On Mon, Nov 15, 2021 at 09:19:17PM +0300, Serge Semin wrote:
> > Since the DW_SPI_CAP_DWC_HSSI capability has just been replaced with using
> > the DW SSI IP-core versions interface, the DW SPI capability flags are now
> > represented with a gap. Let's fix it by redefining the DW_SPI_CAP_DFS32
> > macro to setting BIT(2) of the capabilities field.
> > 
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> 

> Fine with me, thanks!
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Great! Thanks to you too for very fast responses and thorough review.

-Sergey

> 
> > ---
> > 
> > Changelog v3:
> > - This is a new patch unpinned from the previous one as of Andy
> >   suggested.
> > ---
> >  drivers/spi/spi-dw.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
> > index 8334e6b35f89..d5ee5130601e 100644
> > --- a/drivers/spi/spi-dw.h
> > +++ b/drivers/spi/spi-dw.h
> > @@ -32,7 +32,7 @@
> >  /* DW SPI controller capabilities */
> >  #define DW_SPI_CAP_CS_OVERRIDE		BIT(0)
> >  #define DW_SPI_CAP_KEEMBAY_MST		BIT(1)
> > -#define DW_SPI_CAP_DFS32		BIT(3)
> > +#define DW_SPI_CAP_DFS32		BIT(2)
> >  
> >  /* Register offsets (Generic for both DWC APB SSI and DWC SSI IP-cores) */
> >  #define DW_SPI_CTRLR0			0x00
> > -- 
> > 2.33.0
> > 
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
