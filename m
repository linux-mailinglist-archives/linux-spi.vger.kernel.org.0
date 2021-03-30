Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3760834DE8F
	for <lists+linux-spi@lfdr.de>; Tue, 30 Mar 2021 04:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbhC3CpC (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 29 Mar 2021 22:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbhC3CpA (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 29 Mar 2021 22:45:00 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA9CC061762
        for <linux-spi@vger.kernel.org>; Mon, 29 Mar 2021 19:45:00 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id b7so22486257ejv.1
        for <linux-spi@vger.kernel.org>; Mon, 29 Mar 2021 19:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=32flZyp3WozO8lIXzXD7USfpYU9mLvWV/46KDv96M4c=;
        b=36V+7DKZW42b+x00xPJJkQ8AdCNvVhNdB2easokmT3xnPDOzIFk5JQfPcoYrQS0FV7
         y/lY+UMQMHN7AHc6oKpD3jP2jNpFBziZjFVGC/U/ZxWB8Nw3JT2/l2kO5KErGODjmf4D
         KdNgdRiPBNzzpsoE+P6Y68vkcoaGtCL5Tadh1FV4ach/gvSIbVFBFxL7f4SisSq2dfbf
         kEq6hPyyYmsKQfurZV3/Q3EbHNdvjkZHHPE1L42miViRjss8i0BAyk4AMnWo2tJNX/U2
         yIGysaj0uxLor2j3g06meF5dZf40fCbiysm/DCE6JjWtdJt7jAhyqrAPN7DKnebIeFoG
         ip9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=32flZyp3WozO8lIXzXD7USfpYU9mLvWV/46KDv96M4c=;
        b=dGpKmTJnOlVxeYgV8ItE4boOSTYAySuv+WJgbaNOSRmPenSTvxzE9jBHjkv242q+gR
         pexrn23PWYFF8KtaBYErH+5m6+PUQkB7ZQf34NKuUszf3ifIF4CqTO48h3BDVKY29SKw
         A2EzOKBR3xp6I+bKElEcHMcKJ5sN0cLxXI7W/yOTgBAc/WoRXVa6EosYCRBO6Hq0h05a
         ViYUMEgY3SKAoggXrha9DYpmOvTCNJVYYiSiQBSi43DO8Zk6E65Z/ROAePqd/N47/hLA
         AqMQlcyZJXone6xU8BALVHb6M1eboL7qxTIL1DIEyvqZdfTMDncgD33jpQrTJvMztJfH
         dzqg==
X-Gm-Message-State: AOAM531eXJ56MEdf5Xzh28N/WPfq19MFpROXtF+oC4jKzSQdl5f57HEz
        zc+yX+K1Xafbnz0ZMs4dKgPOrU/0HMeDLC4TS1kFWQ==
X-Google-Smtp-Source: ABdhPJymBNv/wStyAK7Xv3++W1Lyzxdz3kZId4lfpMyLUA0fLgtLQPj8xZGU514By7Gp7E3WvrYyMAVVt4CstCfZulY=
X-Received: by 2002:a17:906:ecaa:: with SMTP id qh10mr31367400ejb.425.1617072298792;
 Mon, 29 Mar 2021 19:44:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210304034141.7062-1-brad@pensando.io> <20210304034141.7062-2-brad@pensando.io>
 <CACRpkdbQD6p7fbGtuu1c92uXfSFDCTwqjqsXHpgnD5Lg4v0Okw@mail.gmail.com>
In-Reply-To: <CACRpkdbQD6p7fbGtuu1c92uXfSFDCTwqjqsXHpgnD5Lg4v0Okw@mail.gmail.com>
From:   Brad Larson <brad@pensando.io>
Date:   Mon, 29 Mar 2021 19:44:48 -0700
Message-ID: <CAK9rFnzD98U_abHWUFkzghBkU5GX5d6Z1hOmQn7aXS=M7t_c8w@mail.gmail.com>
Subject: Re: [PATCH 1/8] gpio: Add Elba SoC gpio driver for spi cs control
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Mar 4, 2021 at 12:29 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> Hi Brad,
>
> thanks for your patch!
>
> On Thu, Mar 4, 2021 at 4:42 AM Brad Larson <brad@pensando.io> wrote:
>
> > This GPIO driver is for the Pensando Elba SoC which
> > provides control of four chip selects on two SPI busses.
> >
> > Signed-off-by: Brad Larson <brad@pensando.io>
> (...)
>
> > +#include <linux/gpio.h>
>
> Use this in new drivers:
> #include <linux/gpio/driver.h>
>
> > + * pin:             3            2        |       1            0
> > + * bit:         7------6------5------4----|---3------2------1------0
> > + *     cs1  cs1_ovr  cs0  cs0_ovr |  cs1  cs1_ovr  cs0  cs0_ovr
> > + *                ssi1            |             ssi0
> > + */
> > +#define SPICS_PIN_SHIFT(pin)   (2 * (pin))
> > +#define SPICS_MASK(pin)                (0x3 << SPICS_PIN_SHIFT(pin))
> > +#define SPICS_SET(pin, val)    ((((val) << 1) | 0x1) << SPICS_PIN_SHIFT(pin))
>
> So 2 bits per GPIO line in one register? (Nice doc!)
>
> > +struct elba_spics_priv {
> > +       void __iomem *base;
> > +       spinlock_t lock;
> > +       struct gpio_chip chip;
> > +};
> > +
> > +static int elba_spics_get_value(struct gpio_chip *chip, unsigned int pin)
> > +{
> > +       return -ENXIO;
> > +}
>
> Write a comment that the chip only supports output mode,
> because it repurposes SPI CS pins as generic GPIO out,
> maybe at the top of the file?
>

I'll add a comment regarding gpio pin mode.  Yes output
only mode as SPI chip-selects.

> I suppose these systems also actually (ab)use the SPI cs
> for things that are not really SPI CS? Because otherwise
> this could just be part of the SPI driver (native chip select).
>
> > +static const struct of_device_id ebla_spics_of_match[] = {
> > +       { .compatible = "pensando,elba-spics" },
>
> Have you documented this?

Yes in Documentation/devicetree/bindings, I'll double check
the content for completeness.  The SPI CS isn't used for
something else, the integrated DesignWare IP doesn't
support 4 chip-selects on two spi busses.

>
> Other than that this is a nice and complete driver.
>
> Yours,
> Linus Walleij

Thanks for the review!
