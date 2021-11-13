Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5B3344F037
	for <lists+linux-spi@lfdr.de>; Sat, 13 Nov 2021 01:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbhKMAWF (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 12 Nov 2021 19:22:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbhKMAWE (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 12 Nov 2021 19:22:04 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9BF2C061766;
        Fri, 12 Nov 2021 16:19:12 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id m27so1861930lfj.12;
        Fri, 12 Nov 2021 16:19:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=qWK1yN9xJYXBkOMPxPFwMLgzQ/GTVFu4EVi2p1o6eMI=;
        b=MZo7LSnhA8E5WmMP5HBHI9j+rs++t9si4chL78bwK1iEzgMDwDQJ97S1NdyGMEHMv5
         7lnvNZTHNjWrwvFbeAdEhtSzKWwmTfzcNpI46BHoF8kMK7x4PmIEZ8WyyhWnwM0TNRPf
         puiw8dbpUg9vHnpzQgxzE0mD+YMypYwnr4PEjQwEAcx2KETcNg+5fauBjdvoNnr77UnF
         UFfkf73Yzf5p5twrvyP97nmyTIMfXzMV5eJ4N5i+Sg8T5BfTX5aWwz3oV8VIW5RP4Usx
         nk6UW+nDW/vluwPLVstVGhaRMr5VWUO3tDxcAb53j9DtV0DmGQDhJlhVaAcKd5oWWq3L
         Ohew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=qWK1yN9xJYXBkOMPxPFwMLgzQ/GTVFu4EVi2p1o6eMI=;
        b=6gF/rUhaKLEAX652sjfDcG5OtTShpyDoXTmiIyc99ITH8bApW3SZ39FyljoTjCOd1K
         YzBIw0sIpZRbh/VxXn7QLuV+cpWX9lBFLDDuShN3F++LuprYhEytFWJKoZNtMlIo06om
         PkfGGq2RJsEgoA9qyz/qXjqLmj7HWHxqQVKx9agtranwD6b1D/92mfEKetqQV4fxIQf2
         vF7abBxfzoW3AlfSauC+glnGkDtb3+w1yf0RdJhSSzY2jjWoUm6NcMNwbYmTxafisNgO
         86nFIp6GeIFaVZuzm44hd8Cicf8xA3Dmb7jBWfD6ajmtL7eVds8nDIWPAVf6ymr+dFb0
         ymUQ==
X-Gm-Message-State: AOAM533Egn3LLpQJUGu0wnj8m4TMNcQ06wATSxv5JZk1ETyxtkmdHYnq
        dxpEK3E/kl716vazYMR7yDY=
X-Google-Smtp-Source: ABdhPJzjgbhx9prc2bKMvvNCmXJ+6bMdNPdTLkaqhs6ih75ivDeAgpGpZKBnUKHnZ2fGe03ZT2GU4w==
X-Received: by 2002:a05:6512:2350:: with SMTP id p16mr12389416lfu.482.1636762751113;
        Fri, 12 Nov 2021 16:19:11 -0800 (PST)
Received: from mobilestation ([95.79.188.236])
        by smtp.gmail.com with ESMTPSA id z2sm701972lfj.188.2021.11.12.16.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 16:19:10 -0800 (PST)
Date:   Sat, 13 Nov 2021 03:19:08 +0300
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
Message-ID: <20211113001908.yyo62jrbpbpeaxxb@mobilestation>
References: <20211112204927.8830-1-Sergey.Semin@baikalelectronics.ru>
 <20211112204927.8830-5-Sergey.Semin@baikalelectronics.ru>
 <CAHp75VeEaj6zNtdRF65t_xriWe=Agx3WuW8tw6XZzBHCXtTgmw@mail.gmail.com>
 <CAHp75VcXia53YMyL8uZtHsNRYW9QzrbD9Cy31c4CW8jW-iNitA@mail.gmail.com>
 <20211112220537.bddcab6b5zrewbg2@mobilestation>
 <CAHp75VdP6WL=cFn2eaDC8VH7C+fd11xKxp5_qrFuArubD4KgEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VdP6WL=cFn2eaDC8VH7C+fd11xKxp5_qrFuArubD4KgEQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sat, Nov 13, 2021 at 01:14:30AM +0200, Andy Shevchenko wrote:
> On Saturday, November 13, 2021, Serge Semin <fancer.lancer@gmail.com> wrote:
> 
> > On Fri, Nov 12, 2021 at 11:37:36PM +0200, Andy Shevchenko wrote:
> > > On Fri, Nov 12, 2021 at 11:27 PM Andy Shevchenko
> > > <andy.shevchenko@gmail.com> wrote:
> > > > On Fri, Nov 12, 2021 at 10:52 PM Serge Semin
> > > > <Sergey.Semin@baikalelectronics.ru> wrote:
> > >
> > > > > +       /*
> > > > > +        * Retrieve the Synopsys component version if it hasn't been
> > specified
> > > > > +        * by the platform. Note the CoreKit version ID is encoded
> > as a 4bytes
> > > > > +        * ASCII string enclosed with '*' symbol.
> > > > > +        */
> > > > > +       if (!dws->ver) {
> > > > > +               u32 comp;
> > > > > +
> > > > > +               comp = dw_readl(dws, DW_SPI_VERSION);
> > > > > +               dws->ver = (DW_SPI_GET_BYTE(comp, 3) - '0') * 100;
> > > > > +               dws->ver += (DW_SPI_GET_BYTE(comp, 2) - '0') * 10;
> > > > > +               dws->ver += (DW_SPI_GET_BYTE(comp, 1) - '0');
> > > > > +
> > > > > +               dev_dbg(dev, "Synopsys DWC%sSSI v%u.%02u\n",
> > > > > +                       (dws->caps & DW_SPI_CAP_DWC_HSSI) ? " " : "
> > APB ",
> > > > > +                       dws->ver / 100, dws->ver % 100);
> > > >
> >
> > > > Oh là là, first you multiply then you divide in the same piece of code!
> > > > What's wrong with fourcc (and thus keep it in ver filed as is) ? (Also
> > > > we have %p4cc)
> >
> > Please note that's just a dev_DBG() print. So division has been used
> > in there to check whether the conversion was correct. The whole idea
> > behind the code above it was to retrieve the Component version as a
> > single number so then it could be used by the driver code in a simple
> > statement with a normal integer operation. For instance in case if we
> > need to check whether DW SSI IP-core version is greater than 1.01 we'd
> > have something like this: if (dws->ver > 101). Here 101 looks at least
> > close to the original 1.01. How would the statement look with four
> > chars? Of course we could add an another macro which would look like
> > this:
> > #define DW_SSI_VER(_maj, _mid, _min) \
> >         ((_maj) << 24 | (_mid) << 16 | (_min) << 8 | '*')
> > and use it with raw version ID, like this
> > (dws->ver > DW_SSI_VER('1', '0', '1')). But IMO it doesn't look
> > better if not worse.
> > Alternatively we could split the version ID into two parts with
> > major and minor numbers. But normally one doesn't make much sense
> > without another so each statement would need to check both of them
> > at once anyway. So I decided to stick with a simplest solution and
> > combined them into a single storage. Have you got a better idea of
> > how to implement this functionality?
> 
> 
> 

> Then check DWC3 driver which relies on IZp version a lot.

I'm still not convinced that the DWC3 solution would be better in this case.
(I had a similar approach in mind though.) Although it might be suitable
here seeing we could take the IP generation into account in a single
macro. But at the same time having macros defined for each version may
eventually turn into a clumsy set of macros space as it happened in DWC3.

I don't understand what do you see wrong in the suggested here
solution except a math in the debug string? Why would you prefer the
DWC3 approach better than the one implemented in my patch?
I don't really see much benefits in it:
if (dws->ver > 101)
or
if (DW_SPI_VER_AFTER(dws, 101))
In both cases version ID isn't represented in the original
Vendor-defined structure, like "1.01". The only part which could be
considered as better in DWC3 approach is having a macro name, which gives
a bit better notion about the operation. But does it really worth
introducing a new abstraction in the driver?

On the other hand we could intermix the approaches. For instance decode
the Component version as I suggested in this patch and implement a set of
version checking macro. Thus we won't need so many additional macro
encoding the SSI_COMP_VERSION content.

If only we could have a macro like DW_SPI_VER(dws, >=, "1.01a") with no
performance drawbacks I'd be glad to use it. AFAIU compiler can't
operate with the string literal symbols, thus the symbols extraction
like "1.01a"[0] will be performed on each statement execution which isn't
that performant comparing to a simple two integers comparison.

BTW note the DWC3 macros implicitly depend on having a local variable
with dwc name which violates the kernel coding style. 

-Sergey

> 
> 
> >
> > > >
> > > > > +       }
> > >
> >
> > > Have you seen this, btw?
> > >
> > > https://elixir.bootlin.com/linux/latest/source/drivers/
> > tty/serial/8250/8250_dwlib.c#L93
> >
> > It doesn't utilized version ID for something functional, but just
> > prints it to the console. So it isn't that good reference in this
> > case.
> >
> > -Sergey
> >
> > >
> > >
> > > --
> > > With Best Regards,
> > > Andy Shevchenko
> >
> 
> 
> -- 
> With Best Regards,
> Andy Shevchenko
