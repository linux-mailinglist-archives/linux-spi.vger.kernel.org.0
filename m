Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41A48C30C9
	for <lists+linux-spi@lfdr.de>; Tue,  1 Oct 2019 12:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729892AbfJAKAU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 1 Oct 2019 06:00:20 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44659 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729579AbfJAKAT (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 1 Oct 2019 06:00:19 -0400
Received: by mail-ot1-f68.google.com with SMTP id 21so10974419otj.11;
        Tue, 01 Oct 2019 03:00:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=faGsizJ3ecBmRT0lC0LHIc1ED5+33ls7KqFDwpGQp1Y=;
        b=fc22cYz14ZLuj+6gUEMxaAyItYCtL/+OMGHN/xCY8SE3ul0KmRozOtLm+G+xPiLNl2
         ce/jxsFL8pL121piU+DSXkHOyIDMwP+60BV63HHsHbYXGCqKB8bFJxRnqNKs7mc40eka
         lyeBQulzXFmc6V0deKK4buLGfV+EyJUlOaBNmLfmkp3vThhSdRaeXIj5+i70K6hJCWtx
         ROxy5t6M4aaOt7CvUOuemVa37HNB0qChf1SW3ipGWxOPG6P0Lro9F/kqTSdcIZO+5jjT
         /wTXuePKSZG0RhHE05UBTcZLrQJzFeU0HeXQq9WaidqU+e52DM/Cmm1MLbNXk5UVNTwd
         sNPg==
X-Gm-Message-State: APjAAAU2Rib0sYM4u9A+3CVBloQHOlh0OUa+l3rE8MeS/lskVEQU9puQ
        65i9rDKnGFX8NIvOFloIIqm/SmLWVuzeclcJcOw=
X-Google-Smtp-Source: APXvYqzcpXgl/rpgg6rFvbP9U9TQV+0VWzYn2phPcW2I8wUeCtVGTFa1h63o2/2Q2yhbCpSR/x0pKN2LSm1Y9LEum2s=
X-Received: by 2002:a9d:404d:: with SMTP id o13mr17642078oti.39.1569924018857;
 Tue, 01 Oct 2019 03:00:18 -0700 (PDT)
MIME-Version: 1.0
References: <20191001090657.25721-1-lukma@denx.de> <CAMuHMdWHTaPkzTdzz-j1rFeT=aAEG+J46fgKiPYrXoAR_DTvtQ@mail.gmail.com>
 <20191001113420.032dbfef@jawa>
In-Reply-To: <20191001113420.032dbfef@jawa>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 1 Oct 2019 12:00:07 +0200
Message-ID: <CAMuHMdWh7xPZqp4J1qG22dXk_g=Q1WtQ9Xu-r3wiFOL3kW+WBg@mail.gmail.com>
Subject: Re: [PATCH] spi: Avoid calling spi_slave_abort() with kfreed spidev
To:     Lukasz Majewski <lukma@denx.de>
Cc:     Mark Brown <broonie@kernel.org>,
        Colin Ian King <colin.king@canonical.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kbuild test robot <lkp@intel.com>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Lukasz,

On Tue, Oct 1, 2019 at 11:34 AM Lukasz Majewski <lukma@denx.de> wrote:
> > On Tue, Oct 1, 2019 at 11:07 AM Lukasz Majewski <lukma@denx.de> wrote:
> > > Call spi_slave_abort() only when the spidev->spi is !NULL and the
> > > structure hasn't already been kfreed.
> > >
> > > Reported-by: kbuild test robot <lkp@intel.com>
> > > Reported-by: Julia Lawall <julia.lawall@lip6.fr>
> > > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > > Signed-off-by: Lukasz Majewski <lukma@denx.de>

> > > --- a/drivers/spi/spidev.c
> > > +++ b/drivers/spi/spidev.c
> > > @@ -600,15 +600,16 @@ static int spidev_open(struct inode *inode,
> > > struct file *filp) static int spidev_release(struct inode *inode,
> > > struct file *filp) {
> > >         struct spidev_data      *spidev;
> > > +       int dofree;
> > >
> > >         mutex_lock(&device_list_lock);
> > >         spidev = filp->private_data;
> > >         filp->private_data = NULL;
> > > +       dofree = 0;
> > >
> > >         /* last close? */
> > >         spidev->users--;
> > >         if (!spidev->users) {
> > > -               int             dofree;
> > >
> > >                 kfree(spidev->tx_buffer);
> > >                 spidev->tx_buffer = NULL;
> > > @@ -628,7 +629,8 @@ static int spidev_release(struct inode *inode,
> > > struct file *filp) kfree(spidev);
> > >         }
> > >  #ifdef CONFIG_SPI_SLAVE
> > > -       spi_slave_abort(spidev->spi);
> > > +       if (!dofree)
> > > +               spi_slave_abort(spidev->spi);
> >
> > Can spidev->spi be NULL, if spidev->users != 0?
>
> No, it shouldn't be.
>
> The "dofree" is only set to true (the spidev->spi == NULL condition is
> checked) if there are no references (spidev->users == 0).
>
> The if (!dofree) prevents from calling spi_slave_abort() when
> spidev->spi == NULL and spidev is kfree'd.

If spidev->users != 0, the block checking spidev->spi == NULL is never
executed, and spi_slave_abort() will be called.

I'm wondering if spidev->spi can be NULL if spidev->users is still positive.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
