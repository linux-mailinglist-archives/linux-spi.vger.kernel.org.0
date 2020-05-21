Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 826151DCD3F
	for <lists+linux-spi@lfdr.de>; Thu, 21 May 2020 14:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729323AbgEUMt2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 21 May 2020 08:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729077AbgEUMt2 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 21 May 2020 08:49:28 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C01C061A0E;
        Thu, 21 May 2020 05:49:27 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id 5so2983613pjd.0;
        Thu, 21 May 2020 05:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=afUW27qJQI6L1BqqdvJMIc66fON07qLZGi9GUZOv8ik=;
        b=Iebxwsjrefxk79lRwX2J8Ay+BytWYfinZA9yX5UhwQZEbYU7Qxx4WRoyHsGy0Zam9T
         d1hqJX5b37L0aONdsg5eNcpcjTiDB9yvzk8hzfLKjyD1TbKIA/5sAJBa5CNneKY6zTWQ
         MfzQwEKJQdFIdx9F7wGcfcXmk9tYB7uoNFDDhzRjrgBo51hnh4IwxVBia7ria/pUETWu
         1LVBitiSJJH4KxVa9wwLGxqibX8OfMimyCgbbq2qDdknYOMMXjBiT1BTRf9e/ZzBzrOM
         vxqmP+bVfhOtUdCQlJabhyac9/yyb98T1O7zkoSBhs49u/mAebeIBAtHWmu+2L7r5OAX
         Ocsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=afUW27qJQI6L1BqqdvJMIc66fON07qLZGi9GUZOv8ik=;
        b=KccRzhN7GulWQNsSI6Bn5lnQaFDjykZPc+kNocmCj5QSfMA50szCkIzVCAxTXg87V6
         CYjb2oa899WxSKop3rpej4VgrQ1etDrwNUW76e0KIFaWfmj57jBRyYYDdSVlbwutf15h
         cWkJlK4YBZlnbSJ+yP/NMg7S2ma3K5PBWFu7S1kSklBCIaComnde2+UvkMmeP5qmTRZX
         7S19tzUpCs1k3dLFJhzdz4aRzkt6HdFpGW3b32BNmdEW3+Iu7Jgwt2uYc7+1MmX4eHfy
         iWCKP/ON7Y3ug+I+0WCCWn8lJ8uM2dNocVu7l1peQ/cHRaZt8awXaTiRuxqf+KbbVzfB
         OALQ==
X-Gm-Message-State: AOAM532cydcsbtUnf3FSQJyTDZ78pzAmLKpRI3MNtQ97xsx5V+RtvFPG
        SRWnxk9CiywaRf09TPgXQTT0aMmaaqkGW+S0/zg=
X-Google-Smtp-Source: ABdhPJy1auqg02ic06nl0aIxcRQqYxvrGRv1Zyix0E5OxAP2IKGL2uJlyU/UaGEVw0y4+EwNAKMzkE5a4FyiOsuTpD0=
X-Received: by 2002:a17:90a:1704:: with SMTP id z4mr10976564pjd.181.1590065367229;
 Thu, 21 May 2020 05:49:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200521012206.14472-1-Sergey.Semin@baikalelectronics.ru>
 <20200521012206.14472-4-Sergey.Semin@baikalelectronics.ru>
 <CAHp75VcOX-hZSxHqro_W2X=KzSShg1V=jAsxdz8L5TZpW0kBYA@mail.gmail.com> <20200521121228.aqplh6eftylnys3p@mobilestation>
In-Reply-To: <20200521121228.aqplh6eftylnys3p@mobilestation>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 21 May 2020 15:49:10 +0300
Message-ID: <CAHp75VcPSBBZu+bhnpojry3SFK7-qF7Tuif2MnsPEfbMf72_JA@mail.gmail.com>
Subject: Re: [PATCH v3 03/16] spi: dw: Discard static DW DMA slave structures
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, linux-mips@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Clement Leger <cleger@kalray.eu>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, May 21, 2020 at 3:12 PM Serge Semin
<Sergey.Semin@baikalelectronics.ru> wrote:
> On Thu, May 21, 2020 at 12:57:17PM +0300, Andy Shevchenko wrote:
> > On Thu, May 21, 2020 at 4:23 AM Serge Semin
> > <Sergey.Semin@baikalelectronics.ru> wrote:

...

> > Thanks for an update, but that's not what I asked for...
> >
> > > -static struct dw_dma_slave mid_dma_tx = { .dst_id = 1 };
> > > -static struct dw_dma_slave mid_dma_rx = { .src_id = 0 };
> >
> > >  static int mid_spi_dma_init_mfld(struct device *dev, struct dw_spi *dws)
> > >  {
> > > +       struct dw_dma_slave slave = {
> > > +               .src_id = 0,
> > > +               .dst_id = 0
> > > +       };

> > > -       struct dw_dma_slave *tx = dws->dma_tx;
> > > -       struct dw_dma_slave *rx = dws->dma_rx;
> >
> > May we simple do
> >
> > struct dw_dma_slave tx = { .dst_id = 1 };
> > struct dw_dma_slave rx = { .src_id = 0 };
> >
> > please?
>
> Well, for me both solutions are equal

I don't think so.

> except mine consumes less stack memory.

And brought confusion and less readability. :-(

> The only reason why your solution might be better is that if DW DMA driver or
> the DMA engine subsystem changed the dw_dma_slave structure instance passed to
> the dma_request_channel() method, which non of them do. So I'll leave this for
> Mark to decide. Mark, could you give us your final word about this?

I explained already why I prefer to see them in that form. Reader can
easily understand what request line is used for what channel.
In your code it's hidden somewhere and on top of that that _one_
structure on the stack adds more confusion.

-- 
With Best Regards,
Andy Shevchenko
