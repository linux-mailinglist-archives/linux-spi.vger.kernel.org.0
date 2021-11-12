Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 297AC44EF09
	for <lists+linux-spi@lfdr.de>; Fri, 12 Nov 2021 23:05:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234832AbhKLWId (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 12 Nov 2021 17:08:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234266AbhKLWId (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 12 Nov 2021 17:08:33 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C914BC061766;
        Fri, 12 Nov 2021 14:05:41 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id z34so25629026lfu.8;
        Fri, 12 Nov 2021 14:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=jtNHW5WVhHqK4HBplGfHBqvREXDwIFNxIZ73FeR2LHg=;
        b=en0o94EmzExp3bOKDmBmSBT+UFkDP5S6Y1vZKy+5112kyermWAVN4sDOdwxZhnPV0W
         l+F7H6jeQPC1qo+b3lxpJSf3yAdInLSm2vbhxg/6+O9x9ld4rB5B7S/bryQpJgxux9ux
         UR6NF9F3OurR0dGucIJIrrdRWw3+ixnxa510GcCtMdnSw7prrJeOlEyyQEa6tfh8tVRR
         +74u9lb5U+ieUSeMw6YIclRdChuK/6Qr36qUFxHc4LQn7fVi3FWPL/yiKoO7RLqFZHBY
         HltecHD0rBzav93qNhuEOM3B6V5Ld1wXXpVxNw2P5prWOiaZ2wOEJBCus3bYIbGVVCec
         YkXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=jtNHW5WVhHqK4HBplGfHBqvREXDwIFNxIZ73FeR2LHg=;
        b=hiSB9usKqkHGsEXyttHi4zc8fqALSd6705wARKQZW00Lo+l7kAYOscbL6D+nmxdXy9
         VQH4h2lm0927qufx0zGbHqsWN2oxzxIg8zOzKdSEeIxNqdmkp1qWN/d/ZenxboERbrd0
         B1F+gem6jmK3jmA49qzc+O5sgfBysn5dRIaeWCH5GIRnWtyyDfhz55Hl8vgoYHBrFTGn
         itp5vh1774fjgElOnicN51JjSUHkuwm/xu6u4rzhtuOn0ehfc96WtiGrwBwzWqOkpnQg
         FXW8u290Cn8vvHyB6xxlPdSFi29b8YMDn1Pr7WsIUk19RkLRO9lkdmVSaYI4qDOklaLj
         72/Q==
X-Gm-Message-State: AOAM530WWqRcUC41i2Z8AswLfHr60jKaRrv1uINvGGR5vo5TJ6F+0M51
        zPy7IDe7i9iXjrH4x47Rq/w=
X-Google-Smtp-Source: ABdhPJxWd0q0LqiUc6J4u6A+MNCk6ez2SjxowOYS6rXwJBlN1d7fcDjyj94XwgJQ6bo0ClXVHk7k+w==
X-Received: by 2002:a05:6512:3e09:: with SMTP id i9mr17098603lfv.239.1636754740139;
        Fri, 12 Nov 2021 14:05:40 -0800 (PST)
Received: from mobilestation ([95.79.188.236])
        by smtp.gmail.com with ESMTPSA id c37sm678496lfv.152.2021.11.12.14.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 14:05:39 -0800 (PST)
Date:   Sat, 13 Nov 2021 01:05:37 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Mark Brown <broonie@kernel.org>,
        Nandhini Srikandan <nandhini.srikandan@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] spi: dw: Add Synopsys Component version reading and
 parsing
Message-ID: <20211112220537.bddcab6b5zrewbg2@mobilestation>
References: <20211112204927.8830-1-Sergey.Semin@baikalelectronics.ru>
 <20211112204927.8830-5-Sergey.Semin@baikalelectronics.ru>
 <CAHp75VeEaj6zNtdRF65t_xriWe=Agx3WuW8tw6XZzBHCXtTgmw@mail.gmail.com>
 <CAHp75VcXia53YMyL8uZtHsNRYW9QzrbD9Cy31c4CW8jW-iNitA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VcXia53YMyL8uZtHsNRYW9QzrbD9Cy31c4CW8jW-iNitA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Nov 12, 2021 at 11:37:36PM +0200, Andy Shevchenko wrote:
> On Fri, Nov 12, 2021 at 11:27 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Fri, Nov 12, 2021 at 10:52 PM Serge Semin
> > <Sergey.Semin@baikalelectronics.ru> wrote:
> 
> > > +       /*
> > > +        * Retrieve the Synopsys component version if it hasn't been specified
> > > +        * by the platform. Note the CoreKit version ID is encoded as a 4bytes
> > > +        * ASCII string enclosed with '*' symbol.
> > > +        */
> > > +       if (!dws->ver) {
> > > +               u32 comp;
> > > +
> > > +               comp = dw_readl(dws, DW_SPI_VERSION);
> > > +               dws->ver = (DW_SPI_GET_BYTE(comp, 3) - '0') * 100;
> > > +               dws->ver += (DW_SPI_GET_BYTE(comp, 2) - '0') * 10;
> > > +               dws->ver += (DW_SPI_GET_BYTE(comp, 1) - '0');
> > > +
> > > +               dev_dbg(dev, "Synopsys DWC%sSSI v%u.%02u\n",
> > > +                       (dws->caps & DW_SPI_CAP_DWC_HSSI) ? " " : " APB ",
> > > +                       dws->ver / 100, dws->ver % 100);
> >

> > Oh là là, first you multiply then you divide in the same piece of code!
> > What's wrong with fourcc (and thus keep it in ver filed as is) ? (Also
> > we have %p4cc)

Please note that's just a dev_DBG() print. So division has been used
in there to check whether the conversion was correct. The whole idea
behind the code above it was to retrieve the Component version as a
single number so then it could be used by the driver code in a simple
statement with a normal integer operation. For instance in case if we
need to check whether DW SSI IP-core version is greater than 1.01 we'd
have something like this: if (dws->ver > 101). Here 101 looks at least
close to the original 1.01. How would the statement look with four
chars? Of course we could add an another macro which would look like
this:
#define DW_SSI_VER(_maj, _mid, _min) \
	((_maj) << 24 | (_mid) << 16 | (_min) << 8 | '*')
and use it with raw version ID, like this
(dws->ver > DW_SSI_VER('1', '0', '1')). But IMO it doesn't look
better if not worse.
Alternatively we could split the version ID into two parts with
major and minor numbers. But normally one doesn't make much sense
without another so each statement would need to check both of them
at once anyway. So I decided to stick with a simplest solution and
combined them into a single storage. Have you got a better idea of
how to implement this functionality?

> >
> > > +       }
> 

> Have you seen this, btw?
> 
> https://elixir.bootlin.com/linux/latest/source/drivers/tty/serial/8250/8250_dwlib.c#L93

It doesn't utilized version ID for something functional, but just
prints it to the console. So it isn't that good reference in this
case.

-Sergey

> 
> 
> -- 
> With Best Regards,
> Andy Shevchenko
