Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CBD0167E5B
	for <lists+linux-spi@lfdr.de>; Fri, 21 Feb 2020 14:21:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728086AbgBUNU4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 21 Feb 2020 08:20:56 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46411 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbgBUNUz (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 21 Feb 2020 08:20:55 -0500
Received: by mail-lf1-f65.google.com with SMTP id z26so1452827lfg.13
        for <linux-spi@vger.kernel.org>; Fri, 21 Feb 2020 05:20:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rYvYTPnECeG8lqFBUQQuIWBUDAZkViBxaPrKmD2yPJ4=;
        b=y0+7YgdOVYZJ6ch9MtkB8A2K4VSYWwxB+VaaAr0iNSav010g3MEWKW/SjKb51CzdCG
         D+fQmsMvflqA5pEPxKg+DOqbspvUu91OLPVWRxSykuY8ukbgjBLzwz7SqvkcDo2/Kto4
         qW3jVQsrW3ZPTp+xwhbKMt5kcj7EFHlVGD8Bt2H3Aq3hcB8wjBYdroMSMDnQ7LkpMq5x
         IgTFlHfu5KdR2SnOs5XM/20SnD7D1tdsnXAbYlT177QwagUUKXW/SN/y65g1sCmj9Cz2
         o7vUNEEk7sc7jfw3Hkg3LN6dmJlMaWQBkDfI9t0dwlpUyZNtAaQGZBRDHBxNAhTlV2r0
         oG4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rYvYTPnECeG8lqFBUQQuIWBUDAZkViBxaPrKmD2yPJ4=;
        b=i8DxiA0OaKANAuR5MG8ErSyu8QeT/YMHJMUYGdvtwhNUn+OXUeIficr0Idqjp3Blas
         RRsVUbQHkyJq+Q4iB1zsKEkceEZZv7Xxq5p5WuCrvpj/X+heQysEmYznEPQepy+LRElM
         apJwiAi+ferQHQ7+1ZC5gEB9NTZDpU1+o353CpIMOSFkxlpizkj6HjojunfWWqdOUQxr
         fVTX/TKTBJZ8/W7UeC4qrJlSfNJqiuPgAV3XTquqgYlUQZg1LcmjpybmHMSd9XkiuA/L
         Mz8GR177ZVvD8pnZvV2P58PpcmU6UWQx3NcQvZHUs1o4etUDo685zx8zsPsDTEzzTlpz
         SDMg==
X-Gm-Message-State: APjAAAW697he8gm517QTq807q9MFAn4GB1g1aBmqzuCQis1PJ9RE/Eo4
        bi/4o1BotBEpR5GcsTxQVR6Ayb5IC/GMl3TpDigEVmmf0RoXnw==
X-Google-Smtp-Source: APXvYqzm/qerNC4a+ABa6dbm5+YbNrciEte7L/nU1TEl5AdItLOO4f5afxzwt3TE2OGKYIn/cY0hGjRjTGkhug/QlvQ=
X-Received: by 2002:ac2:5dc8:: with SMTP id x8mr19275869lfq.217.1582291252974;
 Fri, 21 Feb 2020 05:20:52 -0800 (PST)
MIME-Version: 1.0
References: <fca3ba7cdc930cd36854666ceac4fbcf01b89028.1582027457.git.lukas@wunner.de>
 <CACRpkdZmzL_bDRuiBehmd-QC93K_xJ5VHM0HaypCFXLU6sZvkQ@mail.gmail.com> <20200220061122.srkb663imntm4c6a@wunner.de>
In-Reply-To: <20200220061122.srkb663imntm4c6a@wunner.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 21 Feb 2020 14:20:41 +0100
Message-ID: <CACRpkdbz1b0W8oP2+tZVnRZgexe17tS6OT_FEVO1KderOAqbxA@mail.gmail.com>
Subject: Re: [PATCH] spi: spidev: Fix CS polarity if GPIO descriptors are used
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Simon Han <z.han@kunbus.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Feb 20, 2020 at 7:11 AM Lukas Wunner <lukas@wunner.de> wrote:
> On Wed, Feb 19, 2020 at 04:47:50PM +0100, Linus Walleij wrote:

> > > +                       if (ctlr->use_gpio_descriptors && ctlr->cs_gpiods &&
> > > +                           ctlr->cs_gpiods[spi->chip_select])
> > > +                               tmp |= SPI_CS_HIGH;
> >
> > Should this be tmp ^= SPI_CS_HIGH?
> >
> > If the device tree node for cs-gpios is actually active high, which
> > happens, then you probably want the opposite of what was
> > requested, right?
>
> I don't quite follow.  Using an XOR here would seem to be inconsistent
> with what you added to of_spi_parse_dt():  In that function, you
> *always* set SPI_CS_HIGH if gpio_descs are used.  So if the polarity
> is specified in the cs-gpios property, anything else is considered
> irrelevant and ignored.

It's not just cs-gpios though: if you look in drivers/gpio/gpiolib-of.c
in the function of_gpio_flags_quirks() you see that the bool property
spi-cs-high in the consumer node will take precedence over the
cs-gpios property and that will also be handled transparently by gpiolib.
(commit 6953c57ab1721 with fixes on top).

But I guess that is what you mean.

Yes as far as I can see this solves the problem of double-specifying
(both in device tree and from userspace) that we want CS high,
so after some thinking:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

> TBH the way commit f3186dd87669 abuses SPI_CS_HIGH seems clumsy to me.

Clumsy programmer, that's me, yeah sometimes :/

> Would it not have been possible to just amend spi_set_cs() like this:
>
> -       if (spi->mode & SPI_CS_HIGH)
> +       if (spi->mode & SPI_CS_HIGH || (ctlr->use_gpio_descriptors &&
> +                                        ctlr->cs_gpiods &&
> +                                        ctlr->cs_gpiods[spi->chip_select]))
>                 enable = !enable;
>
> This would have avoided the regression fixed by my patch.

There is way too much double inversion going on for sure (some
of it dating back before any attempts to use gpiolib for polarity
handling and I just feel partially responsible) but I just haven't
figured out how to properly fix the problem. Maybe it was just
stupid of me to try to move polarity inversion semantics over to
gpiolib before fixing that though.

Patches like the above are also welcome!

Yours,
Linus Walleij
