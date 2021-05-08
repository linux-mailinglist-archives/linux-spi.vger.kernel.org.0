Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8D17376EDD
	for <lists+linux-spi@lfdr.de>; Sat,  8 May 2021 04:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbhEHCiK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 7 May 2021 22:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbhEHCiK (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 7 May 2021 22:38:10 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B19C061574
        for <linux-spi@vger.kernel.org>; Fri,  7 May 2021 19:37:08 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id m9so11040614wrx.3
        for <linux-spi@vger.kernel.org>; Fri, 07 May 2021 19:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NJxaRPY0ZL3PjVP5ITH2Bmmpb0pT1kmJzWINEgWYK84=;
        b=K8NjdVwCB9/XsPSzterq/GKY9lalaR5Mjr0mZ0gtMKftjdkY7YtjupHIUNkCCd6FKV
         lBcDtXAZKOflXBqZeU5Xbo/fY6DVHEiq0593zr59Edjk9Nvho7RrAEL6JiPa/1JxqGxn
         ot1T6GjQaJgLwp4acEXzH5FVOgFnusiwOKK1V5jTbLEax5lilgaAy+jwfawbd/ZWFMPj
         COG6atlA84iZy8yYwDkTDnyX+/RnLndK5Z3pjtEpkXkq241om0s8l1t2mIFRf5KnOreJ
         EnmXKztomeSshpQNEARdXOtogHPIe/M5+CLaKWQ0TbWqXC7BtK2Jr4aDWP/PchAcOALx
         OFSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NJxaRPY0ZL3PjVP5ITH2Bmmpb0pT1kmJzWINEgWYK84=;
        b=RKTob1Nsl2w6mGBRvb2rO80HS64Jwr67ZoENZCu4PsOSak0rK62c9BLiWRGNVDpWJT
         uYlDGAzIYerYJNuzZ4N1umHBYE4coeTuRFiV66eoJ5ct0APiMBNktGocZ4I3LyxLX/ns
         Izx0jUnyOw3oNEZaP5tnmBtuG+26DIq0mOEiJwEmg2RJjK9eox6hwkXEDHo6DUmOkiQV
         5W9Ith0006VF5dpVzm8lgWKrBmCGswadlbISzXMvq3IPCbFEi0A+8Uy/1DErplabOZ8f
         r0M2KvT5YHa/g1ti7dAN5bAT8Vdzgk4PaV4bTPFIKh4UeGoiIql5p2SEDhTloGeFOW0U
         6cjQ==
X-Gm-Message-State: AOAM532ryqXZ0EbqK7JVcSZXiK7iCs4esXWf5hk5IYU0vX5XVCRUfa7p
        G6wE+pa/H67tZ5a4LMfDiF4HRfvsAoLurIND0jxxbHYtmVy7Dw==
X-Google-Smtp-Source: ABdhPJzFalQhj2u4vDNI913MNUzoPq604X8+Vrxn3OpX/5hDTpj/jNgP3Nwus+usYHByp2aeYS4VL4M422IXkQPYaVk=
X-Received: by 2002:adf:d215:: with SMTP id j21mr16653067wrh.251.1620441426736;
 Fri, 07 May 2021 19:37:06 -0700 (PDT)
MIME-Version: 1.0
References: <YJP6QIl+jnjKPlRo@smile.fi.intel.com> <83ab9b6c-8fb2-b053-ecb3-04230ca34e48@linux.alibaba.com>
 <CAHp75Vev1D5+QWyGCm+HgpdAyT4Uq_OAp7dCemVf9Cdvoay=Og@mail.gmail.com>
 <6bd8f178-51a2-3f45-8a16-80fdd4a3ed8e@linux.alibaba.com> <CAHp75Vfh+jqNLLbwWDe8pi1dQafnNFHak1Hk=5Cw3J+kJX9r3Q@mail.gmail.com>
 <CACRpkdZeKGP6Z8h3GaQ0=EA8mx+yRqzwZaQ5vDJrB4GiYLa26w@mail.gmail.com>
In-Reply-To: <CACRpkdZeKGP6Z8h3GaQ0=EA8mx+yRqzwZaQ5vDJrB4GiYLa26w@mail.gmail.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Fri, 7 May 2021 22:36:55 -0400
Message-ID: <CAGngYiW=RTkHoSndJDr0mMUgLFfuB18g=AwKTvi8d2-tdBrroQ@mail.gmail.com>
Subject: Re: [PATCH v1] spi: fix client driver can't register success when use
 GPIO as CS
To:     Linus Walleij <linus.walleij@linaro.org>,
        "broonie@kernel.org" <broonie@kernel.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        "xhao@linux.alibaba.com" <xhao@linux.alibaba.com>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Mike, Linus, Andy, XinHao,

On Fri, May 7, 2021 at 5:33 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> But I think Andy's approach is the best.

I too like Andy's approach. It would fix XinHao's use case (acpi) and
not break OF.

But, we have to be careful not to put work-around on top of
work-around, and complicate the code too much. Sometimes when logic
gets hard to follow, there's an opportunity to refactor and simplify.
Perhaps if we put our heads together here, we can find that
opportunity? Let's try?

For reasons explained below, the gpiod OF code moves the SPI
chip-select inverting logic from the SPI mode flags to the gpiods. If
I understand XinHao/Andy's problem correctly, this breaks ACPI
chip-selects, because the ACPI gpio code has no way to know that it's
part of a SPI bus, and apply quirks. Does that sound right so far?

If we were able to store the polarity in the SPI mode flag, then we
could refactor very elegantly:

1. Simplify Linus's OF gpio quirks, so:
- they print warnings in case of polarity conflicts
- but no longer change the gpiod polarity (i.e. they just keep what
was specified in OF)

2. Drive the gpiod chip select using the raw value, ignoring the
built-in polarity, which treats it the same as a gpio_xxx. Nice!

in driver/spi/spi.c:
+       /*
+        * invert the enable line, as active low is
+        * default for SPI.
+        */
        if (spi->cs_gpiod)
-               /* polarity handled by gpiolib */
-               gpiod_set_value_cansleep(spi->cs_gpiod,
-                                        enable1);
+               gpiod_set_raw_value_cansleep(spi->cs_gpiod, !enable);
        else
-               /*
-                * invert the enable line, as active low is
-                * default for SPI.
-                */
                gpio_set_value_cansleep(spi->cs_gpio, !enable);

Andy/XinHao, is it correct that this will fix the ACPI case?
Example: enable ACPI CS when SPI_CS_HIGH:
        enable = true
        mode & SPI_CS_HIGH => invert enable => false
        gpiod_set_raw_value_cansleep(!enable => true)
        ACPI gpiod: always active high
        chip select goes high.

Now we get to the tricky bit. Storing the polarity in the SPI mode
breaks a lot of OF spi client drivers. Why? Hardware designers love to
put chip-selects behind inverting gates. This is quite common in case
a voltage domain shift is needed - a single transistor will work, but
is inverting. So depending on the hardware topology (OF), sometimes
client device X has SPI_CS_HIGH set, sometimes it doesn't.

That would all be fine, but... a common pattern in SPI client drivers is this:

drivers/net/phy/spi_ks8995.c:
        spi->mode = SPI_MODE_0;
        spi->bits_per_word = 8;
        err = spi_setup(spi);

In its zeal to specify the correct mode, the driver "plows" right over
the SPI_CS_HIGH mode flag. That'll break stuff.

If there was some way to prevent this from happening, we could make
our code a lot simpler. So I'd like to reach out to Mike Brown to hear
his opinion.

In case of a SPI bus described by OF or ACPI, the mode flags have
already been filled out, so there should be no need for the
initialization in the driver? Could we perhaps replace the pattern
with the following code?

        spi->mode = spi->mode ? : SPI_MODE_0;
        spi->bits_per_word = 8;
        err = spi_setup(spi);

I am not sure in which cases the spi->mode has not been filled out
yet. I live mostly in the OF world, so I'm a bit myopic here.

Even if Mike Brown agrees to change the pattern, it still means lots
of changes to spi client drivers, all over the place. So in terms of
stability, Andy's solution might be preferable.

Looking forward to hearing your opinions,
Sven
