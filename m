Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13765446670
	for <lists+linux-spi@lfdr.de>; Fri,  5 Nov 2021 16:50:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233664AbhKEPwh (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 5 Nov 2021 11:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232592AbhKEPwg (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 5 Nov 2021 11:52:36 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC0A7C061714
        for <linux-spi@vger.kernel.org>; Fri,  5 Nov 2021 08:49:56 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id v64so23889922ybi.5
        for <linux-spi@vger.kernel.org>; Fri, 05 Nov 2021 08:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4Xbj3Ku6YUiO61w3VboU4YqQRIR5DoMkSauNTxL+tzM=;
        b=p2F2Ase15R0EHimAtQAKHQxPj9dcSNr+RBRwgNC1cTuXzdsHB52ZyN2wB92pDEs7y3
         ftBcwSPQ8PKU6iuIwWUWOW76GSjFQ9oRnvFe0BMWdjew/XzAcovhj41tkF/9UPyzGNNE
         fjGIp0MVnQ2uy2HvZd/t5huvIfy4bTNGIr7M/tYBBoGf7fAWazUzPJD/m0dnCYF9XghP
         o+Ez+fiW3xk4Dh3Axy3Qa+hLpC+ZIct3TaLFu7/mZUlKMY2LgTME2/XSBupCevI1kSVV
         pFb+w1qu59XF0gYCchAX9cD8xwcypevfYgu1lwfBCYxe0zqxR+zDOtU3EyXDnTCbiqQs
         gaGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4Xbj3Ku6YUiO61w3VboU4YqQRIR5DoMkSauNTxL+tzM=;
        b=r1GC4EMvStdVkPMiFAXFH/l5vtoDu/R23a7DDyjyYbMA4P0OfTugSBhWRTDzuB5OA7
         X+jDaPei40tbfjxtL7jROeo5ms5bA6yF5mlr4KNub9ub38jeOc0OdLICtbp8sCR3YiqN
         QST8D4XvUhNvrabtSUKNhA+tLN5Bp1KMzYZT0jLQDzkICHy9iWK7NJ7w40SUagiC1c+5
         DU7p5TpC0+qP/Flju7EEArcFmzwcOr8jCNKi72mF154i3WyP9vgxvF4Dj0Kqzb2FYG84
         unege9ySsvNcPXxnR6KytJc1KnOshnBEu+4PxNJLDPe09d2+aVV1cbR0Ug8mwi+gkvUS
         jCeQ==
X-Gm-Message-State: AOAM531xecqYu0PWJ4ekVhWI9dxrrC6GkuDZyMPM3JbCrJMd74Tu9S2m
        grY8ifkUVMJ8jbtMXUrl8B5X3+xKql6Z3lzjPAfr6J9L
X-Google-Smtp-Source: ABdhPJxtiNDroeJX4H18Xt84YCkwCJlRhuWVuJ8QEB7uy1dcFf9xVAeLuhJ/ChKR4zR19cJuvI1mOmeYlh8YisbG9D8=
X-Received: by 2002:a25:b3ce:: with SMTP id x14mr63292886ybf.358.1636127396071;
 Fri, 05 Nov 2021 08:49:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAETHaKpiZEWHUrKtNw+W3XHAPUA4h=OC=RL4Jbcs94o1MgDj6w@mail.gmail.com>
 <CAMuHMdXwYH2n+C5AEzhCjtH+eX5mBFH=cB1hYAy-XYtPYRn9jw@mail.gmail.com>
 <CAETHaKrQ-UDPjMm_jpNe3P0VzQg7qDLZGaViqXvz+qVuUuZCgg@mail.gmail.com> <CAMuHMdW5HERzd=1wxSRAwUnffAMP87uKLuvDt1Wkf-RLHZJopg@mail.gmail.com>
In-Reply-To: <CAMuHMdW5HERzd=1wxSRAwUnffAMP87uKLuvDt1Wkf-RLHZJopg@mail.gmail.com>
From:   Dave Bender <codehero@gmail.com>
Date:   Fri, 5 Nov 2021 11:49:45 -0400
Message-ID: <CAETHaKrbHqcsnrA=yWY2Lr0aOqcX3J8R7i6G9p2BtjiY_N2tgA@mail.gmail.com>
Subject: Re: spi-ar934x: Using GPIO CS issue
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-spi <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

I've tried different combinations of GPIO_ACTIVE_HIGH/LOW.
I modified the ar9134x-spi.c driver to allow gpiod descriptors.
I've tried creating a virtual CS of 3, using cs-gpios.

Nothing seems to work and all I get are JEDEC IDs of 0's.

Is there something I else I am missing here?
For reference, this is a Carambola 2 module on a custom board, with an
extra SPI 32Mb chip on GPIO11, which is not "HW" chip select pin.

On Thu, Nov 4, 2021 at 11:20 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Dave,
>
> On Thu, Nov 4, 2021 at 3:58 PM Dave Bender <codehero@gmail.com> wrote:
> > On Thu, Nov 4, 2021 at 5:50 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > Does it work if you change GPIO_ACTIVE_LOW to GPIO_ACTIVE_HIGH?
> >
> >   There is a pullup resistor on that CS line, so that GPIO must be active low.
>
> I do believe you.  But there's been some issues with inverted CS
> gpio behavior when switching from board files to DT, so I thought
> I'd better ask to try...
>
> >   Digging deeper into the code, it looks like David Bauer made some
> > changes that limit the spi driver's CS usage to only the CS0, CS1, CS2
> > pins.
> >   There is also no bounds checking on the CS value.
> >   I don't understand how this driver can even use generic GPIO if it
> > forces use of the CS bits on the SPI_IOC register.
>
> OK, that sounds like a reasonable culprit...
>
> >
> > static int ar934x_spi_transfer_one_message(struct spi_controller *master,
> >              struct spi_message *m)
> > {
> >    ....
> >    ....
> >     for (trx_done = 0; trx_done < t->len; trx_done += 4) {
> >
> >    .....
> >       reg = AR934X_SPI_SHIFT_VAL(spi->chip_select, term,
> >                trx_cur * 8);
> >       iowrite32(reg, sp->base + AR934X_SPI_REG_SHIFT_CTRL);
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
