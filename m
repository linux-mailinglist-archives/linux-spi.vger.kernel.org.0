Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1192AF245
	for <lists+linux-spi@lfdr.de>; Wed, 11 Nov 2020 14:36:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbgKKNgd (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 11 Nov 2020 08:36:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727028AbgKKNgW (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 11 Nov 2020 08:36:22 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6988CC0613D4
        for <linux-spi@vger.kernel.org>; Wed, 11 Nov 2020 05:36:20 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id e27so3168600lfn.7
        for <linux-spi@vger.kernel.org>; Wed, 11 Nov 2020 05:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=olXpuWKRZd2WOj54U9lEqVR1jNZf54WvQA2P0HktWA8=;
        b=eRY3pQzc5vWFBm8wrOM4Wk6hZ+JxLZ3rHp0gEIWEeHkhSnhREBOU/e0aVNADZH0ruk
         UVPfX6cy0/3JkT1vtC0PD8U89ubNGTY0mu+ANzfz4qT5e+u0JTLn+M3GvNjHTBfVgTe+
         PdvI0NbRfNiOoz5liE3cjMHkdSjV9DHxIKSK6UMmeigTvdEcN/PlHHmfod0PaE1BbG1d
         9ADjQRW1u2FS132A3xwYY2oUzxt4CDQPOF8SLsrDMqc+1od/wbL+a10ODbVzc8xnnEkC
         8lMsfyrIhqdKFjBc2kxadw9S9WaSWg/wJsfXQTDU1qnlLcqNB8TzootgY44FC+UMFomO
         w8Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=olXpuWKRZd2WOj54U9lEqVR1jNZf54WvQA2P0HktWA8=;
        b=FYL4JooJ5cceBZoZKvr7l7l1wUHqZ38fx5TxPxRAugVqhWUggCm6jel3GmAmrXE14s
         EeoUXJ5HwUmTPSwgL6ZolfiEqvaez9PvlPNbikuoXf4cwfnt3iJ0bxXbyvTWgajqtrzp
         RHh9RvvCkAoo3UK3q+NxprN3QXkpIxZgPYK8l0ngTYitxX7+/lg+fO3j4KlHnRa9/1WK
         9hhMsIT4yB+rChf4wC1s+6pI6ewOPeH3uvm/TISCJFfHLrblA42dd+PFMGDb8MdOQ//9
         BGrCl4S/yN1G3LObZBqq6a0XciTEgBiWuJn90v0xkVtqHWXFDG7pBTra8ypBE9dx7GPs
         3tAw==
X-Gm-Message-State: AOAM530mrpJ9BJE2YNH7sJer4CtgPn67C1LPrVPQ/7ulq+e+gyZ++smZ
        D1dxrQEHpSvJhUxME8UbgQTv5oHj1FovdbhGHSaq4A==
X-Google-Smtp-Source: ABdhPJzKrjwSKLLnsJwC2KZlvsGs1Zr74mP1FjA9nd1bGkwMn4wIkdimLhhhQSoCGGwqcznTPuB8RMSStDXllzU2OgA=
X-Received: by 2002:ac2:4ac7:: with SMTP id m7mr7303223lfp.572.1605101778759;
 Wed, 11 Nov 2020 05:36:18 -0800 (PST)
MIME-Version: 1.0
References: <20201106150706.29089-1-TheSven73@gmail.com> <CAHp75VfP1R7bXV6nWWnovWB5BMFcNNEmwBQXheBCUVDbr=xXGA@mail.gmail.com>
 <CAGngYiVu3cXtzb5PaoDOoyqjuuohLQ+em6Keg-qgDFFn2tdp=Q@mail.gmail.com>
 <CACRpkdagAK1X6FT=sug5FGA1iipXnOT_ujtMBh9cVnep_DpWyA@mail.gmail.com> <20201111123327.GB4847@sirena.org.uk>
In-Reply-To: <20201111123327.GB4847@sirena.org.uk>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 11 Nov 2020 14:36:07 +0100
Message-ID: <CACRpkdZW3G48Yj3yGMTKZGwVEQOSs1VeVTTGLgyoJViM3=Yedg@mail.gmail.com>
Subject: Re: [PATCH v1] spi: fix client driver breakages when using GPIO descriptors
To:     Mark Brown <broonie@kernel.org>,
        Grant Likely <grant.likely@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Sven Van Asbroeck <thesven73@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Simon Han <z.han@kunbus.com>, Lukas Wunner <lukas@wunner.de>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Nov 11, 2020 at 1:33 PM Mark Brown <broonie@kernel.org> wrote:
> On Wed, Nov 11, 2020 at 02:05:19AM +0100, Linus Walleij wrote:

> > I would say that anything that has:
>
> > spi->mode = ...
>
> > is essentially broken.
>
> This is not clear to me, most of these settings are things that are
> constant for the device so it's not clear that they should be being set
> by the device tree in the first place.

This was added initially with some two properties
in drivers/of/of_spi.c in 2008:
commit 284b01897340974000bcc84de87a4e1becc8a83d
"spi: Add OF binding support for SPI busses"

This was around the time ARM was first starting to migrate
to device tree, so I suppose it made sense to them/us back
then.

Some properties were the accumulated over time.

commit d57a4282d04810417c4ed2a49cbbeda8b3569b18
"spi/devicetree: Move devicetree support code into spi directory"
made this part of the SPI subsystem.

This seems as simple as nobody was there to push back and
say "wait the devices can specify that with code, don't put it
as properties in device tree". To be honest we have kind of
moved back and forward on that topic over time. :/

> The idea that the chip select
> might be being inverted like it is by this whole gpiolib/DT/new binding
> thing is breaking expectations too.

OK I think you're right, then this patch probably brings the behaviour
back to expectations and it's how I should have done it in the first
place. My bad code :/
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

> > The core sets up vital things in .mode from e.g. device tree in
> > of_spi_parse_dt():
>
> >         /* Mode (clock phase/polarity/etc.) */
> >         if (of_property_read_bool(nc, "spi-cpha"))
> >                 spi->mode |= SPI_CPHA;
> >         if (of_property_read_bool(nc, "spi-cpol"))
> >                 spi->mode |= SPI_CPOL;
> >         if (of_property_read_bool(nc, "spi-3wire"))
> >                 spi->mode |= SPI_3WIRE;
> >         if (of_property_read_bool(nc, "spi-lsb-first"))
> >                 spi->mode |= SPI_LSB_FIRST;
> >         if (of_property_read_bool(nc, "spi-cs-high"))
> >                 spi->mode |= SPI_CS_HIGH;
>
> > All this gets overwritten and ignored when a client just assigns mode
> > like that. Not just SPI_CS_HIGH. I doubt things are different
> > with ACPI.
>
> OTOH most of these are things the device driver should just get right
> without needing any input from DT, there's a few where there's plausible
> options (eg, you can imagine pin strap configuration for 3 wire mode)

Yes I actually ran into a case where the same Samsung display support
both 4 and 3-wire mode so that needs to be configured in the device
tree depending on the layout of the electronics. Arguably we should have
just standardized the device tree bindings and let the individual SPI
drivers parse that themselves in such cases.

> so generally it's not clear how many of these make sense for anything
> other than spidev.  This binding all predates my involvement so I don't
> know the thought process here.

I dug out some details, let's see if Grant has some historical anecdotes
to add. The usage document from back then doesn't really say what
device properties should be encoded in the device tree and what
should just be assigned by code and e.g. determined from the
compatible-string. It was later that especially Rob pointed out that
random properties on device nodes was overused and that simply
knowing the compatible is often enough.

I don't know if we ever formalized it, there is nowadays a rule akin to

"if a property can be determined from the compatible-string, and if the
 compatible-string is identifying the variant of the electronic component,
 then do not add this property to the device tree description. Just
 deduce it from the compatible-string, assign it with code to the device
 model of the operating system and handle it inside the operating system."

I think this, while clear and intuitive, wasn't at all clear and intuitive in
the recent past.

Yours,
Linus Walleij
