Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 914AA3790B9
	for <lists+linux-spi@lfdr.de>; Mon, 10 May 2021 16:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239052AbhEJO2T (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 10 May 2021 10:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238846AbhEJOZb (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 10 May 2021 10:25:31 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD6FC03542C
        for <linux-spi@vger.kernel.org>; Mon, 10 May 2021 06:56:57 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id h4so16717212wrt.12
        for <linux-spi@vger.kernel.org>; Mon, 10 May 2021 06:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TWo92JHOv4O45kTnQfU6qBeMuZJCJHKM/IhhgIAxDHg=;
        b=H4jK7Z+Ls8Plr1xrYBWwE8RtHdjCdSX7DjkvzmsBSoupae2ZsU+80qOmZCHttLf5Xy
         HhwXnU4ozUwSEcRLpLTJqk8IWKWNqEcSb6Aw6x1uhuWudO/V2AgY6qks+KByJJ0p9+nI
         AlYcYbK00msaxElNG9IzAB2JwtDf6GASyRlQN+fK0BTT6RKDDC7kNpyYrQcwKFAr0rJq
         u0CxMb1+rwvTt2liuCVcejxPXcT+/OKkfb57/PTxcZfovXLzCz75RcNQveFvu5JtnQv6
         DsEkdAWrhKe8AjlXUnO+PCtlz7OUJWOnh+xldqp+sJMJKYk7eRmAbCfMNsAPx5WOsQqT
         0LlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TWo92JHOv4O45kTnQfU6qBeMuZJCJHKM/IhhgIAxDHg=;
        b=qihVwHbKwA4gaWtEZGlGmdpifJjMpZaHHxBiwsjWEWYOvJCcXmEMa8wd+JASd1jpi5
         IvJ0UJasc6hl3jkZivAohqEOBDoAaYR4NdSccoB8D3HRt/gNcTC2sT7bsY2D98cgbftq
         ItDk2kddl6YVboSZa6xA4kG1L53ye7gtH+c5qUJSwxbxRd8wccbUWVrshp81YuFjivIX
         o5bSa3V4BJqYBnzrTGBDXceEKz7QFlku9kBWqLSudtk5Dapqpx06of0PyJIsBTsFsmIq
         k96oE1apQKYjqplRmx75C3zFSur22ND+GjaMlqugJGnqL76bjVr/0YlL1Dmsx5wsb/mU
         wVXQ==
X-Gm-Message-State: AOAM5318epsH6dJ9LJdSQ4JSjnIK83ciGRZQonUj7yPrZq4A2f+S4XZs
        f1TIdgLbX+/QpdBBehUPeAae2vWSZcf7JmZC7Q0=
X-Google-Smtp-Source: ABdhPJyYCqHdxy08ObdSqLb8vtS/7EnoH4Ef6tyaSr4EurWQIqvRI5RX1WuB+Jw6yWDUvfzT2lvkLfofldpMCaFZPXI=
X-Received: by 2002:a05:6000:108b:: with SMTP id y11mr31050241wrw.166.1620655015837;
 Mon, 10 May 2021 06:56:55 -0700 (PDT)
MIME-Version: 1.0
References: <YJP6QIl+jnjKPlRo@smile.fi.intel.com> <83ab9b6c-8fb2-b053-ecb3-04230ca34e48@linux.alibaba.com>
 <CAHp75Vev1D5+QWyGCm+HgpdAyT4Uq_OAp7dCemVf9Cdvoay=Og@mail.gmail.com>
 <6bd8f178-51a2-3f45-8a16-80fdd4a3ed8e@linux.alibaba.com> <CAHp75Vfh+jqNLLbwWDe8pi1dQafnNFHak1Hk=5Cw3J+kJX9r3Q@mail.gmail.com>
 <CACRpkdZeKGP6Z8h3GaQ0=EA8mx+yRqzwZaQ5vDJrB4GiYLa26w@mail.gmail.com>
 <CAGngYiW=RTkHoSndJDr0mMUgLFfuB18g=AwKTvi8d2-tdBrroQ@mail.gmail.com>
 <CAHp75VfD5kEnjvvRWUJwpmFaWksnnTf_ewBNDsxz3W3kQMUv+w@mail.gmail.com>
 <CAGngYiVNE1FjsJZeHL5afpWeqf7pRhHqUcKkChML3KQ=6cj=Bw@mail.gmail.com> <YJkaqV4JalpS09bs@smile.fi.intel.com>
In-Reply-To: <YJkaqV4JalpS09bs@smile.fi.intel.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Mon, 10 May 2021 09:56:43 -0400
Message-ID: <CAGngYiW=YP2xuxhiQFxmWD68nd9wKJJ_j+mWswGGT=m+44p3hw@mail.gmail.com>
Subject: Re: [PATCH v1] spi: fix client driver can't register success when use
 GPIO as CS
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "xhao@linux.alibaba.com" <xhao@linux.alibaba.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Andy,

On Mon, May 10, 2021 at 7:36 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> >
> >       device node     | cs-gpio       | CS pin state active | Note
> >       ================+===============+=====================+=====
> >       spi-cs-high     | -             | H                   |
> >       -               | -             | L                   |
> >       spi-cs-high     | ACTIVE_HIGH   | H                   |
> >       -               | ACTIVE_HIGH   | L                   | 1
> >       spi-cs-high     | ACTIVE_LOW    | H                   | 2
> >       -               | ACTIVE_LOW    | L                   |
> >
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/spi/spi-controller.yaml?h=v5.12#n54
>
> This table is incompatible with ACPI. So we can't unify them until each of them
> will play by the same rules. Can't say it won't happen, but it's far from that.

Linus Wallej has added some gpiod OF quirks that checks if the gpio is
used as a chip-select, and if so forces the gpiod polarity to
implement the inversion:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/gpio/gpiolib-of.c?h=v5.13-rc1#n175

If as suggested above, we disable that OF quirk and use the polarity
flag from the SPI mode flags instead, and ignore the built-in gpiod
polarity, the OF table boils down to:

device node    |  CS pin active state
=====================================
-              |  L
spi-cs-high    |  H

which is exactly the same as the ACPI case:
SPI mode flag  |  CS pin active state
=====================================
-              | L
SPI_CS_HIGH    | H

Your github commit says:
> in ACPI case the default polarity
> is active high and can't be altered

So if ACPI gpiods are always active-high then unification can happen
here, correct?

But if I have misunderstood the ACPI case, and ACPI gpiod chip-selects
can have any polarity, then I agree that unification cannot happen.
Like I said earlier, I live mostly in OF-land, so my apologies if I
have not fully grasped the ACPI case.

Sven
