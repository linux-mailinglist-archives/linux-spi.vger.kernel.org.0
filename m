Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 966BC44F34B
	for <lists+linux-spi@lfdr.de>; Sat, 13 Nov 2021 14:16:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbhKMNTN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 13 Nov 2021 08:19:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231555AbhKMNTM (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 13 Nov 2021 08:19:12 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D560CC061766;
        Sat, 13 Nov 2021 05:16:19 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id w1so49545063edd.10;
        Sat, 13 Nov 2021 05:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=12LWIKJS6KxPkj1XMTK6dOTPSCAD+/1s4hQInSJsjf8=;
        b=IxFJwMheKouCSzDen6sW9HQnTw3SD1Aal5i+ndyhJjze/E4OX7KhrrlwSYG7T7LqE0
         Ir0ckdOJlrVPyO/25NPwf+IggbbFH0LfdkGQzcAYCNa2n15LCew5LAtLnwqxvU5V8vNs
         1KZ0Pyc7T8JAQPwPqDBFGiYBZuibESnw4K2yYIRTV+I8qPT9td/ryJmY4Fv02fa1g/L7
         6zPP42zthYtz2iSZsRK7oZPT2jdfGfZ7fwHyLI8Zv56aVp3dmj+bQ4i66W5ixlTb2gzb
         NSW4FiYj7CxrOu9UXRj6CAUPAB+z+SBKQ23TYIVqNs4vgKZmf3gW4nPJL7PVVkv+vJQf
         MmnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=12LWIKJS6KxPkj1XMTK6dOTPSCAD+/1s4hQInSJsjf8=;
        b=jSIN2vYOpM+UwV0O1g4wNo95g7j88bGX5BEfGjv7zt5tvVViJMs4hZ8j6lQAP2Ora8
         KVTc3xFVcsX8g/+Bm7299tVxZmeqcBQG3UI2JWDNoM9TQ1+Iuq61LUirdj2rjsfa60K4
         wxSuaH3FaclRQ731kFh2AbAfPnxHUmTRdbuefDm09LTQYYD9AHRryWwZJ8K3bXcuQGiZ
         U3KYs4zilG+f5xDllCAjHNguiPZ0NCi2bd0zhSDdAmf0hbchZW/6QyCqcwvLR8USVY1x
         YbF3b/l3jFQa9LWzDDnke1Q+op+J2TWifsK045D6+IVDw8neveyDPWuCA98Nn91fSrTR
         tNAQ==
X-Gm-Message-State: AOAM533Haw55VTFyzMQunNC61Cszzfpc4KdWaPAb4l/oQ05KEgzHE3du
        AAJe2hctruL/3fbyTW57yzczZ89/orlk1Yb3tYo=
X-Google-Smtp-Source: ABdhPJzt5aVvdItiv6cFVFzB0AhjCbXLzm3dF94rsQXYE7E5T9yUZKzXu6WvNwZcNFo+6MxUNG3PP/094UulzOD9wKA=
X-Received: by 2002:a17:907:869e:: with SMTP id qa30mr28337161ejc.356.1636809378071;
 Sat, 13 Nov 2021 05:16:18 -0800 (PST)
MIME-Version: 1.0
References: <20211112204927.8830-1-Sergey.Semin@baikalelectronics.ru>
 <20211112204927.8830-5-Sergey.Semin@baikalelectronics.ru> <CAHp75VeEaj6zNtdRF65t_xriWe=Agx3WuW8tw6XZzBHCXtTgmw@mail.gmail.com>
 <CAHp75VcXia53YMyL8uZtHsNRYW9QzrbD9Cy31c4CW8jW-iNitA@mail.gmail.com>
 <20211112220537.bddcab6b5zrewbg2@mobilestation> <CAHp75VdP6WL=cFn2eaDC8VH7C+fd11xKxp5_qrFuArubD4KgEQ@mail.gmail.com>
 <20211113001908.yyo62jrbpbpeaxxb@mobilestation>
In-Reply-To: <20211113001908.yyo62jrbpbpeaxxb@mobilestation>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 13 Nov 2021 15:15:41 +0200
Message-ID: <CAHp75VfeWrSVGQ6v3pb9XvySH=GDmhQHa7-Y_RFeG95OVZFjfA@mail.gmail.com>
Subject: Re: [PATCH 4/4] spi: dw: Add Synopsys Component version reading and parsing
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Mark Brown <broonie@kernel.org>,
        Nandhini Srikandan <nandhini.srikandan@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sat, Nov 13, 2021 at 2:19 AM Serge Semin <fancer.lancer@gmail.com> wrote=
:
> On Sat, Nov 13, 2021 at 01:14:30AM +0200, Andy Shevchenko wrote:
> > On Saturday, November 13, 2021, Serge Semin <fancer.lancer@gmail.com> w=
rote:
> > > On Fri, Nov 12, 2021 at 11:37:36PM +0200, Andy Shevchenko wrote:
> > > > On Fri, Nov 12, 2021 at 11:27 PM Andy Shevchenko
> > > > <andy.shevchenko@gmail.com> wrote:
> > > > > On Fri, Nov 12, 2021 at 10:52 PM Serge Semin
> > > > > <Sergey.Semin@baikalelectronics.ru> wrote:

...

> > > > > > +       /*
> > > > > > +        * Retrieve the Synopsys component version if it hasn't=
 been
> > > specified
> > > > > > +        * by the platform. Note the CoreKit version ID is enco=
ded
> > > as a 4bytes
> > > > > > +        * ASCII string enclosed with '*' symbol.
> > > > > > +        */
> > > > > > +       if (!dws->ver) {
> > > > > > +               u32 comp;
> > > > > > +
> > > > > > +               comp =3D dw_readl(dws, DW_SPI_VERSION);
> > > > > > +               dws->ver =3D (DW_SPI_GET_BYTE(comp, 3) - '0') *=
 100;
> > > > > > +               dws->ver +=3D (DW_SPI_GET_BYTE(comp, 2) - '0') =
* 10;
> > > > > > +               dws->ver +=3D (DW_SPI_GET_BYTE(comp, 1) - '0');
> > > > > > +
> > > > > > +               dev_dbg(dev, "Synopsys DWC%sSSI v%u.%02u\n",
> > > > > > +                       (dws->caps & DW_SPI_CAP_DWC_HSSI) ? " "=
 : "
> > > APB ",
> > > > > > +                       dws->ver / 100, dws->ver % 100);
> > > > >
> > >
> > > > > Oh l=C4=85 l=C4=85, first you multiply then you divide in the sam=
e piece of code!
> > > > > What's wrong with fourcc (and thus keep it in ver filed as is) ? =
(Also
> > > > > we have %p4cc)
> > >
> > > Please note that's just a dev_DBG() print. So division has been used
> > > in there to check whether the conversion was correct. The whole idea
> > > behind the code above it was to retrieve the Component version as a
> > > single number so then it could be used by the driver code in a simple
> > > statement with a normal integer operation. For instance in case if we
> > > need to check whether DW SSI IP-core version is greater than 1.01 we'=
d
> > > have something like this: if (dws->ver > 101). Here 101 looks at leas=
t
> > > close to the original 1.01. How would the statement look with four
> > > chars? Of course we could add an another macro which would look like
> > > this:
> > > #define DW_SSI_VER(_maj, _mid, _min) \
> > >         ((_maj) << 24 | (_mid) << 16 | (_min) << 8 | '*')
> > > and use it with raw version ID, like this
> > > (dws->ver > DW_SSI_VER('1', '0', '1')). But IMO it doesn't look
> > > better if not worse.
> > > Alternatively we could split the version ID into two parts with
> > > major and minor numbers. But normally one doesn't make much sense
> > > without another so each statement would need to check both of them
> > > at once anyway. So I decided to stick with a simplest solution and
> > > combined them into a single storage. Have you got a better idea of
> > > how to implement this functionality?
>
> > Then check DWC3 driver which relies on IZp version a lot.
>
> I'm still not convinced that the DWC3 solution would be better in this ca=
se.
> (I had a similar approach in mind though.) Although it might be suitable
> here seeing we could take the IP generation into account in a single
> macro. But at the same time having macros defined for each version may
> eventually turn into a clumsy set of macros space as it happened in DWC3.
>
> I don't understand what do you see wrong in the suggested here
> solution except a math in the debug string?

The transformation ruins the fourcc [1] representation. We know that
this is an ASCII. We know the position and meaning of each from 4
characters.

[1]: https://en.wikipedia.org/wiki/FourCC

> Why would you prefer the
> DWC3 approach better than the one implemented in my patch?

You asked what is _better_ implementation than yours. It doesn't mean
the DWC3 approach fully fits here, but
- SPI DW has the same issue as DWC3 solves, i.e. different version
lines for two or more IPs of the same kind (see DWC3, DWC31, DWC32)
- it doesn't ruins 4cc

In case if we need to print it, I would rather see something in %p4cc
implementation than customized 100500 approaches spreaded over the
entire kernel.

> I don't really see much benefits in it:
> if (dws->ver > 101)
> or
> if (DW_SPI_VER_AFTER(dws, 101))
> In both cases version ID isn't represented in the original
> Vendor-defined structure, like "1.01". The only part which could be
> considered as better in DWC3 approach is having a macro name, which gives
> a bit better notion about the operation. But does it really worth
> introducing a new abstraction in the driver?
>
> On the other hand we could intermix the approaches. For instance decode
> the Component version as I suggested in this patch and implement a set of
> version checking macro. Thus we won't need so many additional macro
> encoding the SSI_COMP_VERSION content.
>
> If only we could have a macro like DW_SPI_VER(dws, >=3D, "1.01a") with no
> performance drawbacks I'd be glad to use it. AFAIU compiler can't
> operate with the string literal symbols, thus the symbols extraction
> like "1.01a"[0] will be performed on each statement execution which isn't
> that performant comparing to a simple two integers comparison.
>
> BTW note the DWC3 macros implicitly depend on having a local variable
> with dwc name which violates the kernel coding style.

> > > > > > +       }
> > >
> > > > Have you seen this, btw?
> > > >
> > > > https://elixir.bootlin.com/linux/latest/source/drivers/
> > > tty/serial/8250/8250_dwlib.c#L93
> > >
> > > It doesn't utilized version ID for something functional, but just
> > > prints it to the console. So it isn't that good reference in this
> > > case.

Depends what you would like to do with this. If it's only for
information to the developer, then it fits, if you need to compare,
then see above.

--=20
With Best Regards,
Andy Shevchenko
