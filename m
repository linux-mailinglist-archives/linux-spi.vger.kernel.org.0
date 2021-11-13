Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 282D944F57A
	for <lists+linux-spi@lfdr.de>; Sat, 13 Nov 2021 22:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236034AbhKMVdu (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 13 Nov 2021 16:33:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234306AbhKMVds (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 13 Nov 2021 16:33:48 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4CBDC061766;
        Sat, 13 Nov 2021 13:30:54 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id 13so26068391ljj.11;
        Sat, 13 Nov 2021 13:30:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=n4spAWLcpHUtmgBZOpY7TirfBUkG48sAlicEYd0Urdg=;
        b=gavEYbacmhTdU/FsuM9UYPoXnap2WaldpKfJmc1RuofScxxj0DpijAqkDf/Ppp5qtO
         UjQm+xjo9hPTjGiSiGjLBOFCFaBzjGpsM+WBXN4cNTXIt5MILjm2Bml22mQ1xGv6dFxm
         59soV3Hn6tHnCmEk46b/0HIQu6AUbQA0H+uEm93R7hXUS8BmUhFdLBPmTXsY4+7ipNGd
         XCVraRt4HPOmoRgQBChAdv+F596W/owSDcBOToA4FnhY3Em251mYq/4dyD833rcEkw80
         cg/sXi9q0eRgh877UvstbsAq/EqwAnUW+80UTw8nnDCGbHUNzzEl+UpkphPorqVQ8IEq
         oPqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=n4spAWLcpHUtmgBZOpY7TirfBUkG48sAlicEYd0Urdg=;
        b=gCR2aQ3eaDteBilbu9JyA7bjvx2PXyGQ0eZMUDg5FyCRsM2gL/UaQAneLvDk+midMo
         7l5J6jlCQvJVo50t6q2WmPJxNQnOv0QlcflZ+Uonzx7Cbt5UHUCC06g+a3bqtrD8cHyt
         wYCHampgB2bWzPZWo23fFE8kYrgvxI8ysU/ueY2UBBDeabeqinaoNXeEV+CI4PzfZwsb
         nZ5TEpazr4ydXWxj+AY71Qea0sMXiDlzF6cqCe4jdeUywqltlOybbAGjVAGPIXXJmD7M
         xcwKeo21GfUv85vl0NTegrWiLNaAWfCFdTp46O3RZBjMa+gqxkXc+fIiaOLyG/oULNIH
         q41g==
X-Gm-Message-State: AOAM532KMSTgpMQ6SYkM82TDphG09jI/JmIODP3j6Dd5jRwsexTes/fg
        PYzqFzxw1y57KJLk27lrcmY=
X-Google-Smtp-Source: ABdhPJwhyP7RwNsg9+95qzNkwybOXKICuerXy4WNbzCl5hCansbERw1MujWoBErE76XVLTL4TfGYJQ==
X-Received: by 2002:a2e:bc21:: with SMTP id b33mr23165340ljf.497.1636839053082;
        Sat, 13 Nov 2021 13:30:53 -0800 (PST)
Received: from mobilestation ([95.79.188.236])
        by smtp.gmail.com with ESMTPSA id a4sm594441lfo.291.2021.11.13.13.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Nov 2021 13:30:52 -0800 (PST)
Date:   Sun, 14 Nov 2021 00:30:50 +0300
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
Message-ID: <20211113213050.qjm7usvt43vygry4@mobilestation>
References: <20211112204927.8830-1-Sergey.Semin@baikalelectronics.ru>
 <20211112204927.8830-5-Sergey.Semin@baikalelectronics.ru>
 <CAHp75VeEaj6zNtdRF65t_xriWe=Agx3WuW8tw6XZzBHCXtTgmw@mail.gmail.com>
 <CAHp75VcXia53YMyL8uZtHsNRYW9QzrbD9Cy31c4CW8jW-iNitA@mail.gmail.com>
 <20211112220537.bddcab6b5zrewbg2@mobilestation>
 <CAHp75VdP6WL=cFn2eaDC8VH7C+fd11xKxp5_qrFuArubD4KgEQ@mail.gmail.com>
 <20211113001908.yyo62jrbpbpeaxxb@mobilestation>
 <CAHp75VfeWrSVGQ6v3pb9XvySH=GDmhQHa7-Y_RFeG95OVZFjfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VfeWrSVGQ6v3pb9XvySH=GDmhQHa7-Y_RFeG95OVZFjfA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sat, Nov 13, 2021 at 03:15:41PM +0200, Andy Shevchenko wrote:
> On Sat, Nov 13, 2021 at 2:19 AM Serge Semin <fancer.lancer@gmail.com> wrote:
> > On Sat, Nov 13, 2021 at 01:14:30AM +0200, Andy Shevchenko wrote:
> > > On Saturday, November 13, 2021, Serge Semin <fancer.lancer@gmail.com> wrote:
> > > > On Fri, Nov 12, 2021 at 11:37:36PM +0200, Andy Shevchenko wrote:
> > > > > On Fri, Nov 12, 2021 at 11:27 PM Andy Shevchenko
> > > > > <andy.shevchenko@gmail.com> wrote:
> > > > > > On Fri, Nov 12, 2021 at 10:52 PM Serge Semin
> > > > > > <Sergey.Semin@baikalelectronics.ru> wrote:
> 
> ...
> 
> > > > > > > +       /*
> > > > > > > +        * Retrieve the Synopsys component version if it hasn't been
> > > > specified
> > > > > > > +        * by the platform. Note the CoreKit version ID is encoded
> > > > as a 4bytes
> > > > > > > +        * ASCII string enclosed with '*' symbol.
> > > > > > > +        */
> > > > > > > +       if (!dws->ver) {
> > > > > > > +               u32 comp;
> > > > > > > +
> > > > > > > +               comp = dw_readl(dws, DW_SPI_VERSION);
> > > > > > > +               dws->ver = (DW_SPI_GET_BYTE(comp, 3) - '0') * 100;
> > > > > > > +               dws->ver += (DW_SPI_GET_BYTE(comp, 2) - '0') * 10;
> > > > > > > +               dws->ver += (DW_SPI_GET_BYTE(comp, 1) - '0');
> > > > > > > +
> > > > > > > +               dev_dbg(dev, "Synopsys DWC%sSSI v%u.%02u\n",
> > > > > > > +                       (dws->caps & DW_SPI_CAP_DWC_HSSI) ? " " : "
> > > > APB ",
> > > > > > > +                       dws->ver / 100, dws->ver % 100);
> > > > > >
> > > >
> > > > > > Oh lą lą, first you multiply then you divide in the same piece of code!
> > > > > > What's wrong with fourcc (and thus keep it in ver filed as is) ? (Also
> > > > > > we have %p4cc)
> > > >
> > > > Please note that's just a dev_DBG() print. So division has been used
> > > > in there to check whether the conversion was correct. The whole idea
> > > > behind the code above it was to retrieve the Component version as a
> > > > single number so then it could be used by the driver code in a simple
> > > > statement with a normal integer operation. For instance in case if we
> > > > need to check whether DW SSI IP-core version is greater than 1.01 we'd
> > > > have something like this: if (dws->ver > 101). Here 101 looks at least
> > > > close to the original 1.01. How would the statement look with four
> > > > chars? Of course we could add an another macro which would look like
> > > > this:
> > > > #define DW_SSI_VER(_maj, _mid, _min) \
> > > >         ((_maj) << 24 | (_mid) << 16 | (_min) << 8 | '*')
> > > > and use it with raw version ID, like this
> > > > (dws->ver > DW_SSI_VER('1', '0', '1')). But IMO it doesn't look
> > > > better if not worse.
> > > > Alternatively we could split the version ID into two parts with
> > > > major and minor numbers. But normally one doesn't make much sense
> > > > without another so each statement would need to check both of them
> > > > at once anyway. So I decided to stick with a simplest solution and
> > > > combined them into a single storage. Have you got a better idea of
> > > > how to implement this functionality?
> >
> > > Then check DWC3 driver which relies on IZp version a lot.
> >
> > I'm still not convinced that the DWC3 solution would be better in this case.
> > (I had a similar approach in mind though.) Although it might be suitable
> > here seeing we could take the IP generation into account in a single
> > macro. But at the same time having macros defined for each version may
> > eventually turn into a clumsy set of macros space as it happened in DWC3.
> >
> > I don't understand what do you see wrong in the suggested here
> > solution except a math in the debug string?
> 

> The transformation ruins the fourcc [1] representation. We know that
> this is an ASCII. We know the position and meaning of each from 4
> characters.
> 
> [1]: https://en.wikipedia.org/wiki/FourCC

So that four-CC thing wasn't Synopsys invention after all, but a sort
of a relatively common approach. Your point finally starts making
sense to me.

> 
> > Why would you prefer the
> > DWC3 approach better than the one implemented in my patch?
> 
> You asked what is _better_ implementation than yours. It doesn't mean
> the DWC3 approach fully fits here, but
> - SPI DW has the same issue as DWC3 solves, i.e. different version
> lines for two or more IPs of the same kind (see DWC3, DWC31, DWC32)
> - it doesn't ruins 4cc
> 
> In case if we need to print it, I would rather see something in %p4cc
> implementation than customized 100500 approaches spreaded over the
> entire kernel.

Yep, these are the main pros of the DWC3 approach. Just to note
in fact AFAICS Synopsys doesn't utilize the denoted components
versioning for all its IP-cores. At least DW (G|X-G|XL-G)?MACs define
either a normal one-byte component version ID (for instance version
3.3 looks as 0x33) or two-bytes with pair - IP-core and version IDs.
But that likely is an exception, while the most of DWCs are indeed
identified by the ASCII tuple.

In our case we don't have the IP-core version explicitly encoded in
the Component version register, so it is determined by the
platform-specific code. With a minor effort I'll be able to just
convert the DW_SPI_CAP_DWC_HSSI capability into two macros with virtual
IP-core ID thus we'd have a more-or-less coherent versioning API. In
this case we can retain the ASCII Version ID. Settled then. I'll send
v2 with this patch reworked as you suggest.

-Sergey

> 
> > I don't really see much benefits in it:
> > if (dws->ver > 101)
> > or
> > if (DW_SPI_VER_AFTER(dws, 101))
> > In both cases version ID isn't represented in the original
> > Vendor-defined structure, like "1.01". The only part which could be
> > considered as better in DWC3 approach is having a macro name, which gives
> > a bit better notion about the operation. But does it really worth
> > introducing a new abstraction in the driver?
> >
> > On the other hand we could intermix the approaches. For instance decode
> > the Component version as I suggested in this patch and implement a set of
> > version checking macro. Thus we won't need so many additional macro
> > encoding the SSI_COMP_VERSION content.
> >
> > If only we could have a macro like DW_SPI_VER(dws, >=, "1.01a") with no
> > performance drawbacks I'd be glad to use it. AFAIU compiler can't
> > operate with the string literal symbols, thus the symbols extraction
> > like "1.01a"[0] will be performed on each statement execution which isn't
> > that performant comparing to a simple two integers comparison.
> >
> > BTW note the DWC3 macros implicitly depend on having a local variable
> > with dwc name which violates the kernel coding style.
> 
> > > > > > > +       }
> > > >
> > > > > Have you seen this, btw?
> > > > >
> > > > > https://elixir.bootlin.com/linux/latest/source/drivers/
> > > > tty/serial/8250/8250_dwlib.c#L93
> > > >
> > > > It doesn't utilized version ID for something functional, but just
> > > > prints it to the console. So it isn't that good reference in this
> > > > case.
> 
> Depends what you would like to do with this. If it's only for
> information to the developer, then it fits, if you need to compare,
> then see above.
> 
> -- 
> With Best Regards,
> Andy Shevchenko
