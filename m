Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B0911CA84C
	for <lists+linux-spi@lfdr.de>; Fri,  8 May 2020 12:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbgEHK1C (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 8 May 2020 06:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbgEHK1B (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 8 May 2020 06:27:01 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46469C05BD43;
        Fri,  8 May 2020 03:27:00 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id 7so5087990pjo.0;
        Fri, 08 May 2020 03:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DZy9pkcBOrjCjg4Qkt27IkR6JTIiM5cV3+uquhM8WpE=;
        b=Y1RvCu9eoSCgYQeLeMRJWGSFq/GuuBWI1TSDsUK7iiTFqH94KTKwyxJsT1hTpwWcoT
         lJ2c3P57GJQkDIhAVDbhPT3WOol41JCylmoDswHN4iZ84PMqYD+nb/wzezk+xglTBfCb
         g+WIJ4C8KyoEs1Z5yJo6etJKvPbFzZoedopO6JL719invW2D4camVQwVlIB/khCDjp2/
         LT1QOIqdywfL6kNoiUmzy1+x/7LbQXxKFnXMYxm7usNSBYz7wBKMmAqJwVe6FRcZ0DAq
         IclQH+U6hOj8TAQAMJ+vWG5s6NQi8WJuUSzh103tguKXGig2/CdGi6d2QvgccyTC6Uoh
         e7Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DZy9pkcBOrjCjg4Qkt27IkR6JTIiM5cV3+uquhM8WpE=;
        b=tUC9yS5r3SmDG5VKwZGncadzreQK76Fn0oRIUTTOtnbnX1CnIh2L3CPhhDu2uNWz/2
         4S1hQ7bF787NJBr6QBYoRKkjSKQL4gf61vlIjpdzylav9JNm+zO8C35iFWzmTGf1hlp4
         0+kpUfIs52ecNzpcZf9k4qe/JSpB66W7+Sg3GuGjt/eOboS3lnMdBwR/nUGwxtVNKW6L
         RsD+oZ/88TYKrXUOMjgP1JyGlU1un0KCbHfYumGf84nJxEp84aC9t0KupJD2hR/Tbazr
         aUFLzd0pDQnmKlVuWjM3KJPE+Y8xa3d0wkJC5JbvbU5w9mX/Kj08Di5xthHLqx1FhauZ
         aTXA==
X-Gm-Message-State: AGi0Pua18fsC3HNFK38gDxAWSxdC/678bl9hpRaMynFmqPsxedhmgkc0
        cGcDEYj5L20nK+R/vWlrqvq721EPtv6wYHiV490=
X-Google-Smtp-Source: APiQypJqDoxKMk4xvuslikRiRX8ShXnPqbto61mW3jENDen09PX1j2bdXToCAPfWo+d3kRgJCDBnTBhOzAblxyDyzr8=
X-Received: by 2002:a17:90b:94a:: with SMTP id dw10mr5450560pjb.228.1588933619112;
 Fri, 08 May 2020 03:26:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200508093621.31619-1-Sergey.Semin@baikalelectronics.ru>
 <20200508093621.31619-3-Sergey.Semin@baikalelectronics.ru>
 <CAHp75VdtzdX-sOvq2cZdXqGUmU=0rdzQW_USGD_q0D59pUMTWg@mail.gmail.com> <20200508101541.e3yxaocuilaiyutg@mobilestation>
In-Reply-To: <20200508101541.e3yxaocuilaiyutg@mobilestation>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 8 May 2020 13:26:52 +0300
Message-ID: <CAHp75VcaVGHfYN1hjD5eKgpKJkpKEif8NxBGO1YF61_apv82Kg@mail.gmail.com>
Subject: Re: [PATCH 2/2] spi: Add Baikal-T1 System Boot SPI Controller driver
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Mark Brown <broonie@kernel.org>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Lee Jones <lee.jones@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, linux-mips@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        John Garry <john.garry@huawei.com>,
        Chuanhong Guo <gch981213@gmail.com>,
        Eddie James <eajames@linux.ibm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Masahisa Kojima <masahisa.kojima@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, May 8, 2020 at 1:15 PM Serge Semin
<Sergey.Semin@baikalelectronics.ru> wrote:
>
> On Fri, May 08, 2020 at 01:03:11PM +0300, Andy Shevchenko wrote:
> > On Fri, May 8, 2020 at 12:37 PM Serge Semin
> > <Sergey.Semin@baikalelectronics.ru> wrote:
> > >
> > > This SPI-controller is a part of the Baikal-T1 System Controller and
> > > is based on the DW APB SSI IP-core, but with very limited resources:
> > > no IRQ, no DMA, only a single native chip-select and just 8 bytes Tx/Rx
> > > FIFO available. In order to provide a transparent initial boot code
> > > execution this controller is also utilized by an vendor-specific block,
> > > which provides an CS0 SPI flash direct mapping interface. Since both
> > > direct mapping and SPI controller normal utilization are mutual exclusive
> > > only a one of these interfaces can be used to access an external SPI
> > > slave device. Taking into account the peculiarities of the controller
> > > registers and physically mapped SPI flash access, very limited resources
> > > and seeing the normal usecase of the controller is to access an external
> > > SPI-nor flash, we decided to create a dedicated SPI driver for it.
> >
> > It seems a lot of code.
> > Why can't you use spi-dw-mmio.c et al.?
>
> I said above why. Even though the registers set is similar It's too specific
> to be integrated into the generic DW SSI driver.

At least you may do at the beginning is to reuse header spi-dw.h and
put your stuff under
spi-dw-baikal.c or so. Then, look at the spi-dw.c and check what can
be reused (I think a lot).

-- 
With Best Regards,
Andy Shevchenko
