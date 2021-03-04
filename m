Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAFDE32CF60
	for <lists+linux-spi@lfdr.de>; Thu,  4 Mar 2021 10:13:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233175AbhCDJLZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 4 Mar 2021 04:11:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233302AbhCDJLK (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 4 Mar 2021 04:11:10 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB57C06175F;
        Thu,  4 Mar 2021 01:10:29 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id d3so41933300lfg.10;
        Thu, 04 Mar 2021 01:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lYt7mYpM9/m04UA7Mdu92MabZprxTpAcM5FOuDuthS4=;
        b=fmPBN3OVw4OwkdjJx8DpFvbIIja2mK2GdJqOtQW1Ioet6C2AJbxyHtAZ43/5yCOrfX
         YIhF1TjFDL94mY63OlkM7Tq6ADqjKKprw16c8Rsl1jpf2nBbSqTnFGk2RXPVonxnt9mT
         fptNyLQvpVUQ/TG+NGemc2z47SIYdWwdjRXzM17FTZhE5A031EofI372xV0+oqP5UZVq
         nIyNDc0PwajjCfDf0tRpSuO0P0eR5eXRnz3KYdEiM2KwNi0pRoBf5K7MFlmaXIvBjzBt
         Fbr9yiWSaoKtGJwoFQbveoUS5IWzzmBgTS0OU1XKvhO64UA+q/yHFcctocMAHLsJSuZB
         DG+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lYt7mYpM9/m04UA7Mdu92MabZprxTpAcM5FOuDuthS4=;
        b=TdMNexNqEuHK2H5ayU55TCMRLVj/kE8KdYt3/HQiQsf9nUE2bfvdAby1f6MOKWzpGE
         wj+HjAojFGpFdNIlhCM3C1IfFcCIid2ItVdbrfrenvbEwuEI70QEDOOg5kYsIhZDwXtN
         l/iYiyimWGiSYEBGq4QtL4HEo3z1anVXLgTiPxnr4AhJy+WaU0oHYft5bciHXArw9HY6
         M9gKywl8S3rRPASyCjRflPf1PLbBNBxDyGqFQK+I2E+IqIiAs5UD690S0sUDbGyE89bm
         7lDdYvDCqLTarfeRs54oyRxK2cf6jqGA6q5Hxi44lpyBG5G9xR3SB0wm50GDZYIJfTH9
         2HxA==
X-Gm-Message-State: AOAM532ha5sSKb/XyPBJUxwVT3R6uVB+s4n1uvp4a5y+8GxsN76vBxJ6
        nm957asXoFfQFTetHR16NGE=
X-Google-Smtp-Source: ABdhPJwlzUi5evrB7tfs/CevoAu3N1l1PJFqqId94eiMubcRbH8Dlr2a1CzIcdo2ScMeyBt/EDehfA==
X-Received: by 2002:ac2:5232:: with SMTP id i18mr1839362lfl.30.1614849028522;
        Thu, 04 Mar 2021 01:10:28 -0800 (PST)
Received: from mobilestation ([95.79.88.254])
        by smtp.gmail.com with ESMTPSA id e24sm2536883lfn.62.2021.03.04.01.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 01:10:28 -0800 (PST)
Date:   Thu, 4 Mar 2021 12:10:25 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Brad Larson <brad@pensando.io>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/8] gpio: Add Elba SoC gpio driver for spi cs control
Message-ID: <20210304091025.ny52qjm7wbfvmjgl@mobilestation>
References: <20210304034141.7062-1-brad@pensando.io>
 <20210304034141.7062-2-brad@pensando.io>
 <CACRpkdbQD6p7fbGtuu1c92uXfSFDCTwqjqsXHpgnD5Lg4v0Okw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdbQD6p7fbGtuu1c92uXfSFDCTwqjqsXHpgnD5Lg4v0Okw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello Linus,

I started reviewing from the DW APB SPI driver part of this series,
that's why I suggested to remove the CS callback from there seeing it
doesn't really differ much from the generic one. But after looking at
the dts file and in this driver I think that the alterations layout
needs to be a bit different.

This module looks more like being a part of a SoC System Controller
seeing it's just a single register. Corresponding pins seem like
being multiplexed between SPI controller and GPO (being directly driven
by setting a bit in the corresponding register). See the next comment.

On Thu, Mar 04, 2021 at 09:29:33AM +0100, Linus Walleij wrote:
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
> > + *             cs1  cs1_ovr  cs0  cs0_ovr |  cs1  cs1_ovr  cs0  cs0_ovr
> > + *                        ssi1            |             ssi0
> > + */
> > +#define SPICS_PIN_SHIFT(pin)   (2 * (pin))
> > +#define SPICS_MASK(pin)                (0x3 << SPICS_PIN_SHIFT(pin))
> > +#define SPICS_SET(pin, val)    ((((val) << 1) | 0x1) << SPICS_PIN_SHIFT(pin))
> 

> So 2 bits per GPIO line in one register? (Nice doc!)

I suppose the first bit is the CS-pin-override flag. So when it's set
the output is directly driven by the second bit, otherwise the
corresponding DW APB SPI controller drives it. That's how the
multiplexing is implemented here.

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

> I suppose these systems also actually (ab)use the SPI cs
> for things that are not really SPI CS?

I haven't noticed that in the dts file submitted by Brad. So most
likely these are just CS pins, which can be either automatically
driven by the DW APB SPI controller (yeah, DW APB SPI controller
doesn't provide a way to directly set he native CS value, it
sets the CS value low automatically when starts SPI xfers) or can be
manually set low/high by means of that SPI-CS register.

> Because otherwise
> this could just be part of the SPI driver (native chip select).

That's what I suggested in my comment to the patch
[PATCH 7/8] arm64: dts: Add Pensando Elba SoC support
in this series. Although imho it's better to be done by means
of a System Controller.

-Sergey

> 
> > +static const struct of_device_id ebla_spics_of_match[] = {
> > +       { .compatible = "pensando,elba-spics" },
> 
> Have you documented this?
> 
> Other than that this is a nice and complete driver.
> 
> Yours,
> Linus Walleij
