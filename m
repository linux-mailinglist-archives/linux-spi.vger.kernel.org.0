Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBFD01D79C0
	for <lists+linux-spi@lfdr.de>; Mon, 18 May 2020 15:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbgERNZc (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 18 May 2020 09:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726726AbgERNZc (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 18 May 2020 09:25:32 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B62C061A0C;
        Mon, 18 May 2020 06:25:32 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id f15so4221310plr.3;
        Mon, 18 May 2020 06:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=881WKNGVvaYzcoBRH7He303GsRzyKlY6cxm3kJ5azqA=;
        b=tNNYBlDgSTP2D9kQLCS+yD32yAFQhzjeNUBbygGq/jJ85V2ugohrJ/A8bn5SV0J32d
         lHBDNXRcrfosYqy4B7l0RIlQkPSvPPHUU2pQLD3pKJGZe2n89pnLMqSKjQzfU+E6SNQv
         JhJ2QXp8WdLE3nZHwZjd4oUPXuaL4ALNbHZMtI8/32YpC7wzQ7FPrsyMpB72QWwmnM2b
         JznNr+SRgd5Y/mnneu76H01hUS1HjvLN6Vbmkq69ziEDSt99wEUiLeavpkiw0DtHD/kZ
         Y9EUoaVC+A5xRXduKMk/d2rt6xtdjcs9UFIjMIyrNfP4Nn6sOrQ616oSlhbov2XSg0OC
         CFrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=881WKNGVvaYzcoBRH7He303GsRzyKlY6cxm3kJ5azqA=;
        b=kIB4/BlzWk+nzhkymAz32v4TgL+iy1UnsqwFpinFIIZcYNCSOq9xPgMOwfeFrW8dHN
         OsPDN1ck5WB5fsVD+fkHjmdKl514n8DpsuhxUZoVXJVh+kFyr6fUvPvnw5/gz4bcXMle
         wlCJdDEtXILbv3dZoGEHjXOEOAT3dTAZvjrFYj4zJTa+3vTIVpVShJOwLVDLVHtaVHgX
         2QgZV+gKzGUKtp1gN9/9mT7fjV146WwPcP7mEwBmYWnP03ztpZ1cTo9lfdoqZfGZWMfF
         hV5q5SgENy5DPfGj+b4Bvif1Fqcp/EkuE/YhnjSP2JDj23XPOvcdHo8wdzhaToLWEqGV
         ISlA==
X-Gm-Message-State: AOAM533pFlTzTiGVep5Iwpvx5ttGCjQOTWf+3NpBqCkK09cefSUvc19j
        o7BKcj1ITn+yb3DkbnEObjeT8boVdn7UlrJWpQU=
X-Google-Smtp-Source: ABdhPJyrmZovUGrfc1E9QcmoitiLZZUcoVkdNiqoTccxGHzp1nu+vtQYLUmXZxPCs3v4OHOBniR6mA8tEnSet1oT+ys=
X-Received: by 2002:a17:902:930c:: with SMTP id bc12mr16453398plb.255.1589808331670;
 Mon, 18 May 2020 06:25:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200508132943.9826-1-Sergey.Semin@baikalelectronics.ru>
 <20200515104758.6934-1-Sergey.Semin@baikalelectronics.ru> <20200515104758.6934-11-Sergey.Semin@baikalelectronics.ru>
 <20200515143842.GG1634618@smile.fi.intel.com> <20200516200133.wmaqnfjbr7234fzo@mobilestation>
 <20200518110343.GY1634618@smile.fi.intel.com> <20200518125253.r4fpr4mjflclqpym@mobilestation>
In-Reply-To: <20200518125253.r4fpr4mjflclqpym@mobilestation>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 18 May 2020 16:25:20 +0300
Message-ID: <CAHp75VeMcv-hQViCANQARiNh0LwmugsDWk=MF1c5E3t7z5h02Q@mail.gmail.com>
Subject: Re: [PATCH v2 10/19] spi: dw: Use DMA max burst to set the request thresholds
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Allison Randal <allison@lohutok.net>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Rob Herring <robh+dt@kernel.org>, linux-mips@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Clement Leger <cleger@kalray.eu>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, May 18, 2020 at 3:53 PM Serge Semin
<Sergey.Semin@baikalelectronics.ru> wrote:
> On Mon, May 18, 2020 at 02:03:43PM +0300, Andy Shevchenko wrote:
> > On Sat, May 16, 2020 at 11:01:33PM +0300, Serge Semin wrote:
> > > On Fri, May 15, 2020 at 05:38:42PM +0300, Andy Shevchenko wrote:
> > > > On Fri, May 15, 2020 at 01:47:49PM +0300, Serge Semin wrote:

...

> > > > >         struct dma_chan         *txchan;
> > > > > +       u32                     txburst;
> > > > >         struct dma_chan         *rxchan;
> > > > > +       u32                     rxburst;
> > > >
> > > > Leave u32 together, it may be optimal on 64-bit architectures where ABIs require padding.
> > >
> > > It's not like anyone cared about padding in this structure in the first place)
> >
> > I think I have been caring (to some extend).
>
> Well, If you have then instead of asking to rearrange just two members (which
> by the way finely grouped by the Tx-Rx affiliation) why not sending a
> patch, which would refactor the whole structure so to be optimal for the x64
> platforms? I don't really see why this gets very important for you seeing
> Mark is Ok with this. My current commit follows the common driver design
> including the DW SSI data members grouping. On the second thought I'll leave
> it as is then.

Again same issue here. What is really easy to do for you here, will
become a burden and additional churn to anybody else.
So, why not to minimize it in the first place? Same with comma in
another patch. Sorry, I really don't get it.

-- 
With Best Regards,
Andy Shevchenko
