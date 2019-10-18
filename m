Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 690F8DC406
	for <lists+linux-spi@lfdr.de>; Fri, 18 Oct 2019 13:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390367AbfJRLhO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 18 Oct 2019 07:37:14 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36652 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389955AbfJRLhO (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 18 Oct 2019 07:37:14 -0400
Received: by mail-ed1-f67.google.com with SMTP id h2so4317737edn.3;
        Fri, 18 Oct 2019 04:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vfacdRIZROtgaYKyvVVlViTaU4E6jqDJejGD7tuz/+s=;
        b=TvUQBq/NsvkK0uCyK5aaB1cOiOq38Cq7pGNXyhyOMe3ai76NPGio2T0PBOiFlsDSLZ
         R1sshtOTbas68n6dMsqEFSXVaqG4IevQuXPdjVu1uEIG6biMwYUGzfYiYtAI82R/BHDQ
         93FUxB1OwxHTphdgReKffJfPJ+UwhufDFKK7AoYI7qJrCzkXl1ewHruSYOkaAv7oZQPf
         qROubUq5dNJqlQt3Jn6QT3+p36Ij8wTlbM+kF7U05qeTtXpOV+L19PUsMIm32ErniBaY
         Ed2mj1G6gOS6Tuj2Nzck3c4Gx2RKyCehPdoOBwpR1QSXzbSyeJ3MjUCkprA0q8skNpxR
         C/UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vfacdRIZROtgaYKyvVVlViTaU4E6jqDJejGD7tuz/+s=;
        b=ilfIHWBw7gukntxxwviQUyknN7wT3K9ax9eAUnZjBqg10HcXzD0MiZctaOJezGNkoe
         pnmQz4HkUh5h45Z4pOh+7Jugn8Dzlg9VuugYEc03p64gEYP/y/f7mAIJsXXOQ++zjyzY
         dzkIEnEVbnaeXR4Ll6xNNyQ/ETgfTHB5LzbhI5Mw/q2CjS2K1v91KokG4XDuj0Mu+yHv
         h/tGZBqVRC/GxfRDUtZyTnDeqfaiOqfpO9+vanA6CUYghZCioIjIzHWdhYHjEi3tQ17e
         EJuWpul7CRyC2y2frKHMClv/DpgfOSdudC9hghNrCgP2XTv337VJyS7gvx0hX8F10IZR
         Fw8Q==
X-Gm-Message-State: APjAAAWDlfSnAVz2eMVESANfePY3BC1w5B0A2iX9HGh/mRBE7lxD0a6b
        2c7Z763uCfk9Fj11B+0NX2cvwlGJTktso9y9MuY=
X-Google-Smtp-Source: APXvYqxUlMOimXUQfuCPwVTgyEMSYOoYavmpO7+8E+tfkwKA7hFgTUZ0o1J9m28yzcNWZg5OMp9rzMEP5i8JNur5xEo=
X-Received: by 2002:a17:907:4182:: with SMTP id mz2mr8019392ejb.326.1571398632465;
 Fri, 18 Oct 2019 04:37:12 -0700 (PDT)
MIME-Version: 1.0
References: <20191017025058.31528-1-hslester96@gmail.com> <CAHp75Vd2SMERjtvNumxAF1HSp8GSThmcyx96zkFzUXKwnD5d2Q@mail.gmail.com>
 <CANhBUQ2yxGbjk_DgXbip=TPT=evzA5naoJSY9t1_Ep47e9oupw@mail.gmail.com> <CAHp75VeLyTi=gqfNr-=Tg36yQs_fYG__iQAxAEKdks0mqsTbug@mail.gmail.com>
In-Reply-To: <CAHp75VeLyTi=gqfNr-=Tg36yQs_fYG__iQAxAEKdks0mqsTbug@mail.gmail.com>
From:   Chuhong Yuan <hslester96@gmail.com>
Date:   Fri, 18 Oct 2019 19:37:00 +0800
Message-ID: <CANhBUQ1CnCHiY8tkCMcXZ3DAPcfnQZgfA_Fj4qf3yYBKGg10Wg@mail.gmail.com>
Subject: Re: [PATCH] spi: pxa2xx: Add missed security checks
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
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

On Fri, Oct 18, 2019 at 7:14 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Fri, Oct 18, 2019 at 1:39 PM Chuhong Yuan <hslester96@gmail.com> wrote:
> >
> > On Fri, Oct 18, 2019 at 5:35 PM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > >
> > > On Fri, Oct 18, 2019 at 8:59 AM Chuhong Yuan <hslester96@gmail.com> wrote:
> > > >
> > > > pxa2xx_spi_init_pdata misses checks for devm_clk_get and
> > > > platform_get_irq.
> > > > Add checks for them to fix the bugs.
> > > >
> > > > Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> > > > ---
> > > >  drivers/spi/spi-pxa2xx.c | 6 ++++++
> > > >  1 file changed, 6 insertions(+)
> > > >
> > > > diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
> > > > index bb6a14d1ab0f..2e73d75a6ac5 100644
> > > > --- a/drivers/spi/spi-pxa2xx.c
> > > > +++ b/drivers/spi/spi-pxa2xx.c
> > > > @@ -1565,7 +1565,13 @@ pxa2xx_spi_init_pdata(struct platform_device *pdev)
> > > >  #endif
> > > >
> > > >         ssp->clk = devm_clk_get(&pdev->dev, NULL);
> > > > +       if (IS_ERR(ssp->clk))
> > > > +               return NULL;
> > > > +
> > > >         ssp->irq = platform_get_irq(pdev, 0);
> > > > +       if (ssp->irq < 0)
> > > > +               return NULL;
> > >
> > > I'm not sure they are mandatory for all platforms.
> > > To be on the safe side, you simple need to add _optional() to the both
> > > call along with above change.
> > >
> >
> > As I know, this is the only one in spi which does not have a check for
> > devm_clk_get.
>
> For some it still may be optional. That's why better to check it and
> mention in the commit message.
>
> > Even if add _optional(), they still may return errors and need security checks.
>
> Of course, see "along with" in my previous comment.
>

Got it. I will send version 2 in which both _optional() and security
checks will be added.

> --
> With Best Regards,
> Andy Shevchenko
