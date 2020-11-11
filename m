Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 493112AE547
	for <lists+linux-spi@lfdr.de>; Wed, 11 Nov 2020 02:05:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731713AbgKKBFg (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 10 Nov 2020 20:05:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727275AbgKKBFd (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 10 Nov 2020 20:05:33 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F02FC0613D1
        for <linux-spi@vger.kernel.org>; Tue, 10 Nov 2020 17:05:32 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id d17so828074lfq.10
        for <linux-spi@vger.kernel.org>; Tue, 10 Nov 2020 17:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zQ2YZ7wvYdXCryYm5A3rqiOGevl/hLPKyvgu8SbKo14=;
        b=OIAHF4sUEZIlYdTykmcU7LXhEJz+9V6MsuW9lWVY8EIBo6fIuf+nzL9mybVcKjYtg9
         BxcKPbSxQn4CuFNnIpVqe/OFYrEjmBKLT5W1DAQQc2krQau/NxBr8UxJd9YEzNcf2M14
         i0/OQdBnyys2Pv84Lo87gx2wBgYyQjyeWW3yteKgseOyEjGhfN28F7HMfKLkxlUUs8Ui
         wrlpd8B6dO5UnYqXDksXG4naiVmVM+Nz2cDmCFZgF7fPoW2bhFTzWzMiEW0VRgbuHaJ1
         yPY1uoSYtiRuTOnjHY62FOz3ld69uI7KvWaP4rZqBz8exBloe1k74C2urxnvA+DksIBU
         Qg+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zQ2YZ7wvYdXCryYm5A3rqiOGevl/hLPKyvgu8SbKo14=;
        b=aF4o/NDOI6a1l7I9R6gXwxhJhJu/PsuNwPw44VzouYuIwbJ6AG93N8dGkmMEgZk8DT
         47ywsr2Tk0hJhLYjs/ySQr1w0GcciDfhxtxOtdjZ39d4X6fI1BxftwdvE+c6DRd+vet1
         zB9YJeYrsSXMQs9+JeM+uGqGTL0DCJckHX9XmlXaTXREspGdtuqhoXPPann+FKm1R++H
         aUJ46skFn1ErsXxzHVOEzBaBOOZcwIhQiAydm/P7ziDl96d0odnhQ+mj+Akb+xip+WPC
         fa7MW2ULG1RG6ClAUoQe9QiqJ4qAyHf0Z794uBrrdUhNYsNZNhuC41Ks1TnnpKfQn2sj
         SfuQ==
X-Gm-Message-State: AOAM531650Aa9dHIJK8j0g8zJOMly9Q18ujUB5aoCAoKnlY/xGhsFFzi
        y77C5uE9tAShpAlbbN9Gff5QdUJt/JAYzZQEXLAVVEJqjTlf3b0a
X-Google-Smtp-Source: ABdhPJxleCZln6csvKBM5WS9AaFou3IqhZl3LxfI+NQUXV6wm+54Mhg/YCD9sXS5A+XIb+CHs69sHx6ywxt1PZYsJrc=
X-Received: by 2002:a05:6512:3225:: with SMTP id f5mr8058036lfe.441.1605056730290;
 Tue, 10 Nov 2020 17:05:30 -0800 (PST)
MIME-Version: 1.0
References: <20201106150706.29089-1-TheSven73@gmail.com> <CAHp75VfP1R7bXV6nWWnovWB5BMFcNNEmwBQXheBCUVDbr=xXGA@mail.gmail.com>
 <CAGngYiVu3cXtzb5PaoDOoyqjuuohLQ+em6Keg-qgDFFn2tdp=Q@mail.gmail.com>
In-Reply-To: <CAGngYiVu3cXtzb5PaoDOoyqjuuohLQ+em6Keg-qgDFFn2tdp=Q@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 11 Nov 2020 02:05:19 +0100
Message-ID: <CACRpkdagAK1X6FT=sug5FGA1iipXnOT_ujtMBh9cVnep_DpWyA@mail.gmail.com>
Subject: Re: [PATCH v1] spi: fix client driver breakages when using GPIO descriptors
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Simon Han <z.han@kunbus.com>, Lukas Wunner <lukas@wunner.de>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Nov 9, 2020 at 3:41 PM Sven Van Asbroeck <thesven73@gmail.com> wrote:
> On Mon, Nov 9, 2020 at 9:24 AM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> >
> > Sounds like "many SPI drivers have to be fixed".
>
> I don't disagree. Fact is that after the imx cspi bus driver was converted
> to gpio descriptors, most spi client drivers broke. It would be great if this
> could be fixed. Any method that the community can find a consensus on,
> would be great :)

I think your patch is the quick fix.

I would say that anything that has:

spi->mode = ...

is essentially broken.

The core sets up vital things in .mode from e.g. device tree in
of_spi_parse_dt():

        /* Mode (clock phase/polarity/etc.) */
        if (of_property_read_bool(nc, "spi-cpha"))
                spi->mode |= SPI_CPHA;
        if (of_property_read_bool(nc, "spi-cpol"))
                spi->mode |= SPI_CPOL;
        if (of_property_read_bool(nc, "spi-3wire"))
                spi->mode |= SPI_3WIRE;
        if (of_property_read_bool(nc, "spi-lsb-first"))
                spi->mode |= SPI_LSB_FIRST;
        if (of_property_read_bool(nc, "spi-cs-high"))
                spi->mode |= SPI_CS_HIGH;

All this gets overwritten and ignored when a client just assigns mode
like that. Not just SPI_CS_HIGH. I doubt things are different
with ACPI.

> One the one hand: the fact that many spi client drivers just overwrite
> flags and values in their parent bus structure, doesn't sound idiomatic.
> I guess those spi->... values should really be opaque, and we should
> be using accessor functions, eg.:
>
>     static int acme_probe(struct spi_device *spi)
>     {
>         ...
>         // won't touch SPI_CS_HIGH flag
>         spi_set_mode_clock(spi, SPI_MODE_0);
>         ...
>     }

I would just make sure to affect the flags that matters to my driver,
it's just bits.

spi->mode &= ~FOO;
spi->mode |= BAR;

> On the other hand, it sounds very confusing to set SPI_CS_HIGH on
> all spi buses that use gpio descriptors: especially because gpiolib
> already handles absolutely everything related to polarity.

As long as gpiolib gets a 1 for asserted and a 0 for deasserted
it will be happy.

I'm not against your patch, it makes the codepath cleaner
so in a way it is good.

Yours,
Linus Walleij
