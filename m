Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A285F379129
	for <lists+linux-spi@lfdr.de>; Mon, 10 May 2021 16:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234635AbhEJOpV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 10 May 2021 10:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244860AbhEJOoU (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 10 May 2021 10:44:20 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B343AC08EAF2
        for <linux-spi@vger.kernel.org>; Mon, 10 May 2021 07:02:04 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id i190so13614499pfc.12
        for <linux-spi@vger.kernel.org>; Mon, 10 May 2021 07:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VxgI3STb3makrji4losrQx42sUPKczGgxn0b2g7x6MU=;
        b=oHtizQN8AyIADKLbzs0Wa7OWnMcEvLpkW35fjNwLUHdUiMCMj6szyiEdM9rjw7zIiy
         q5P3WL+faXwBu3B63org8x1bB+VEPxBS5mRClAJ3miwmMawkNayCsG/V2VUWFQVmdnSd
         0rxEObxps3L5wb6cG2P5GGfIFPl9Rr2koufgRI7LkDPbrDPbxt/n9Fy328rUZAxX0h9R
         5lDwgQ1tpFTlkdqMdQ6hJm6tjiA1w6YqYPRSlOOiKqZbej2grkgc37eTydhgmRacJVHI
         Ix7IZkSGmARP8tf2qtiVe0AkCgripjDxD267UN7CsxLxHpB7A9XTsJ4fstd3ojyA28yO
         +IdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VxgI3STb3makrji4losrQx42sUPKczGgxn0b2g7x6MU=;
        b=jU/RmxpNloz6DyvhvzQkAa6sAPppbJFt/3yhBPplT/eVufVjWB65NOk7mrRXDjIxul
         ckU9UuabykT0pCHg/LtYc7J16PxezRmz4EXFqYMASUhZE5jo6Qvi6D4g77V8LC3FF4Lc
         1ev0+bPfcORH90I9f0Qz7sqY5VYGHFphW1QqU44ASiZJ8mnJxEbUrerxyD0N3q/QuAsv
         bZa+Eu258QjSlAgqMlwbDIQ0yFnt7XkVw3Sh5pwv5avX5+RlpIV5rCg9oFIGsa2B7iqL
         3/Qgyx1fexpJwBTl5dI3FjZlZCwpG/kqrAVsptdSlUy4mRJL3v5oDPWahM/FyztCi8Jn
         FxEQ==
X-Gm-Message-State: AOAM532hJpDYCcrLEcqXp7v1cuXZ/N7YJ4TBUp66vfEKSdIvOpvRETEE
        vBKXxEcEjnXDQldA7nHYLrTBD4Hqrk+GjasjaU0=
X-Google-Smtp-Source: ABdhPJwTCTjjrRBWrU97hRSEfUoIDxPxw876T0C2rAlZXtymxd8jR5kob2YnHF/0rDXUwKDQJu6uhvwV2CNSFV9e/C0=
X-Received: by 2002:aa7:985c:0:b029:2c4:b940:f77b with SMTP id
 n28-20020aa7985c0000b02902c4b940f77bmr2499738pfq.73.1620655323688; Mon, 10
 May 2021 07:02:03 -0700 (PDT)
MIME-Version: 1.0
References: <YJP6QIl+jnjKPlRo@smile.fi.intel.com> <83ab9b6c-8fb2-b053-ecb3-04230ca34e48@linux.alibaba.com>
 <CAHp75Vev1D5+QWyGCm+HgpdAyT4Uq_OAp7dCemVf9Cdvoay=Og@mail.gmail.com>
 <6bd8f178-51a2-3f45-8a16-80fdd4a3ed8e@linux.alibaba.com> <CAHp75Vfh+jqNLLbwWDe8pi1dQafnNFHak1Hk=5Cw3J+kJX9r3Q@mail.gmail.com>
 <CACRpkdZeKGP6Z8h3GaQ0=EA8mx+yRqzwZaQ5vDJrB4GiYLa26w@mail.gmail.com>
 <CAGngYiW=RTkHoSndJDr0mMUgLFfuB18g=AwKTvi8d2-tdBrroQ@mail.gmail.com>
 <CAHp75VfD5kEnjvvRWUJwpmFaWksnnTf_ewBNDsxz3W3kQMUv+w@mail.gmail.com>
 <CAGngYiVNE1FjsJZeHL5afpWeqf7pRhHqUcKkChML3KQ=6cj=Bw@mail.gmail.com>
 <YJkaqV4JalpS09bs@smile.fi.intel.com> <CAGngYiW=YP2xuxhiQFxmWD68nd9wKJJ_j+mWswGGT=m+44p3hw@mail.gmail.com>
In-Reply-To: <CAGngYiW=YP2xuxhiQFxmWD68nd9wKJJ_j+mWswGGT=m+44p3hw@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 10 May 2021 17:01:47 +0300
Message-ID: <CAHp75VeWqGpXPbO6JW2fA7fL=AsYCDbFdwJobuXwssOgRSdfQA@mail.gmail.com>
Subject: Re: [PATCH v1] spi: fix client driver can't register success when use
 GPIO as CS
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "xhao@linux.alibaba.com" <xhao@linux.alibaba.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, May 10, 2021 at 4:56 PM Sven Van Asbroeck <thesven73@gmail.com> wrote:
> On Mon, May 10, 2021 at 7:36 AM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > >
> > >       device node     | cs-gpio       | CS pin state active | Note
> > >       ================+===============+=====================+=====
> > >       spi-cs-high     | -             | H                   |
> > >       -               | -             | L                   |
> > >       spi-cs-high     | ACTIVE_HIGH   | H                   |
> > >       -               | ACTIVE_HIGH   | L                   | 1
> > >       spi-cs-high     | ACTIVE_LOW    | H                   | 2
> > >       -               | ACTIVE_LOW    | L                   |
> > >
> > >
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/spi/spi-controller.yaml?h=v5.12#n54
> >
> > This table is incompatible with ACPI. So we can't unify them until each of them
> > will play by the same rules. Can't say it won't happen, but it's far from that.
>
> Linus Wallej has added some gpiod OF quirks that checks if the gpio is
> used as a chip-select, and if so forces the gpiod polarity to
> implement the inversion:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/gpio/gpiolib-of.c?h=v5.13-rc1#n175
>
> If as suggested above, we disable that OF quirk and use the polarity
> flag from the SPI mode flags instead, and ignore the built-in gpiod
> polarity, the OF table boils down to:
>
> device node    |  CS pin active state
> =====================================
> -              |  L
> spi-cs-high    |  H
>
> which is exactly the same as the ACPI case:
> SPI mode flag  |  CS pin active state
> =====================================
> -              | L
> SPI_CS_HIGH    | H
>
> Your github commit says:
> > in ACPI case the default polarity
> > is active high and can't be altered

Right. This is the correct statement.

> So if ACPI gpiods are always active-high then unification can happen
> here, correct?

Probably. I really won't dive into OF rabbit hole, if you think it
will work, go for it!

For now I guess my patch is necessary to have. I don't think we may
delay its distribution while developing a better solution, do you
agree on this?

> But if I have misunderstood the ACPI case, and ACPI gpiod chip-selects
> can have any polarity, then I agree that unification cannot happen.
> Like I said earlier, I live mostly in OF-land, so my apologies if I
> have not fully grasped the ACPI case.

-- 
With Best Regards,
Andy Shevchenko
