Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3D0DC3BA
	for <lists+linux-spi@lfdr.de>; Fri, 18 Oct 2019 13:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389125AbfJRLOx (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 18 Oct 2019 07:14:53 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39094 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbfJRLOw (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 18 Oct 2019 07:14:52 -0400
Received: by mail-pf1-f194.google.com with SMTP id v4so3681404pff.6;
        Fri, 18 Oct 2019 04:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PdWA0N6LArMPxWcQPYXRVyly6m34mLC44EP1ORzmGqs=;
        b=m7Y2tbrqYomoSGGnsHw6ioheYXbdmj8e//C2iw7ChjohsJlP3ec3vNTpxwQRqMwQN5
         RcicUxV41Cxaxc2+7F9PK2nnHiJtQLPABk/O9/moEEBVsYZzsZOsL/r31BA3G8ByazfL
         5Ekl9xoxujTOTe/urEnC8wl3hRyAL64aCiPE0MKQhnlZ8gAYzURGficiDHU8m7rwBNNe
         4SO38hPt4KgLNrwEB9zcKaZxiEz1NfYGHkwXlUjVtT5KlRRZEYtdWmPu4PgPLoG6j7RD
         ZHLih4EjQIUDQ8EttFo9q91I/BVNtxLro00YSmClWMBIlJj2fNoSK/AksN5Za1e5Tcrq
         slWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PdWA0N6LArMPxWcQPYXRVyly6m34mLC44EP1ORzmGqs=;
        b=a8INU3d2Il5vyEgXNAIXSM35nIIOUxtryEVeT4to2BA3cvQ5bi+66Fm4EvpIppX84T
         0r6MHGeNV9dFJ4o4JdzLYsYy2v1EMgDFPwcKeK6SZIZ9t1mWxrMXMF9t1UPS4rmDR5bT
         eewQllT/LWmy6eluXdvSMl9nuVa6ZoanJpwS7bK0X/US3taYw8tmEOvwVHsRjgnSe5IR
         CQv+AOya8GgzQLzn19nrKnfJoJMss5t+pRPnRsd0dqSCaRPprszEFAdTbFfWmkEk1cC9
         vAtvoUX7oKoiswybaEKMQ2sgJqSl7yPy6sN2Dfl8hUcCoz6BGTqmNQoiJy7leM9au0TW
         JjiQ==
X-Gm-Message-State: APjAAAWlAlBVOr3vvAfk8KtAvmEjKDmcLjAUdrsEtiu6qDn/JrT34bex
        LFAgUuw3Eyc0H1L0cUKLx+2HN/adiendiI1KilguiptJsHg=
X-Google-Smtp-Source: APXvYqwiDaJWrpqwvInQO/35te4OjSHucMpHdYSAuAh5zBD8mD2bwLeTjsEtPWiayqiwXNGN/hjKBIdcLhBIbjZRB0s=
X-Received: by 2002:a17:90a:9416:: with SMTP id r22mr10644319pjo.20.1571397292091;
 Fri, 18 Oct 2019 04:14:52 -0700 (PDT)
MIME-Version: 1.0
References: <20191017025058.31528-1-hslester96@gmail.com> <CAHp75Vd2SMERjtvNumxAF1HSp8GSThmcyx96zkFzUXKwnD5d2Q@mail.gmail.com>
 <CANhBUQ2yxGbjk_DgXbip=TPT=evzA5naoJSY9t1_Ep47e9oupw@mail.gmail.com>
In-Reply-To: <CANhBUQ2yxGbjk_DgXbip=TPT=evzA5naoJSY9t1_Ep47e9oupw@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 18 Oct 2019 14:14:41 +0300
Message-ID: <CAHp75VeLyTi=gqfNr-=Tg36yQs_fYG__iQAxAEKdks0mqsTbug@mail.gmail.com>
Subject: Re: [PATCH] spi: pxa2xx: Add missed security checks
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Mark Brown <broonie@kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Oct 18, 2019 at 1:39 PM Chuhong Yuan <hslester96@gmail.com> wrote:
>
> On Fri, Oct 18, 2019 at 5:35 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> >
> > On Fri, Oct 18, 2019 at 8:59 AM Chuhong Yuan <hslester96@gmail.com> wrote:
> > >
> > > pxa2xx_spi_init_pdata misses checks for devm_clk_get and
> > > platform_get_irq.
> > > Add checks for them to fix the bugs.
> > >
> > > Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> > > ---
> > >  drivers/spi/spi-pxa2xx.c | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > >
> > > diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
> > > index bb6a14d1ab0f..2e73d75a6ac5 100644
> > > --- a/drivers/spi/spi-pxa2xx.c
> > > +++ b/drivers/spi/spi-pxa2xx.c
> > > @@ -1565,7 +1565,13 @@ pxa2xx_spi_init_pdata(struct platform_device *pdev)
> > >  #endif
> > >
> > >         ssp->clk = devm_clk_get(&pdev->dev, NULL);
> > > +       if (IS_ERR(ssp->clk))
> > > +               return NULL;
> > > +
> > >         ssp->irq = platform_get_irq(pdev, 0);
> > > +       if (ssp->irq < 0)
> > > +               return NULL;
> >
> > I'm not sure they are mandatory for all platforms.
> > To be on the safe side, you simple need to add _optional() to the both
> > call along with above change.
> >
>
> As I know, this is the only one in spi which does not have a check for
> devm_clk_get.

For some it still may be optional. That's why better to check it and
mention in the commit message.

> Even if add _optional(), they still may return errors and need security checks.

Of course, see "along with" in my previous comment.

-- 
With Best Regards,
Andy Shevchenko
