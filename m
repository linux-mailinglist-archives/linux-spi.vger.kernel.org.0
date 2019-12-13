Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4162C11E1A8
	for <lists+linux-spi@lfdr.de>; Fri, 13 Dec 2019 11:08:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726016AbfLMKIl (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 13 Dec 2019 05:08:41 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33225 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfLMKIl (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 13 Dec 2019 05:08:41 -0500
Received: by mail-lf1-f66.google.com with SMTP id n25so1548539lfl.0
        for <linux-spi@vger.kernel.org>; Fri, 13 Dec 2019 02:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=plzX2TYUBISoj1xjK+ykemXu/ypGkxTaA9T5X4hrIN8=;
        b=G3KYxpvA7NfYIDhGeSizbouF5wm6QlSUMkAkbo177pGTUkK1XxnPumNds0kqTgL5mt
         iUweCpwy75QnNz638H0/5hX9cWu4zCyt8AO7Q8fvuLXYqwHImhBzkjCoL4al9YyeEQV6
         JlhDdOneHZC6L+acEeLMln1xhlfQA5+NTFuCTzEo/v+hdNf3FoF69zQoyqfIrHL1SAMD
         LKNBFXt1NjatPYW5aBitUCzoCxaby6e0jrkXKuvGJYGwi6+8iHKE3QRDffrgThom/NGe
         rb91oxmoXKs64jGIzUx/bXujuWTcdb+hoUOh0vIeMsVTo3pDK5ZnjfhEEjBCo0VKyfHs
         KAlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=plzX2TYUBISoj1xjK+ykemXu/ypGkxTaA9T5X4hrIN8=;
        b=dQ4K/G4BMybeChV5uwHEwwAm77GQfNRn4iMii5pFRT1FGYEWasbMAw9e3jdKDXVrgy
         hm/EQIWHrmGvzKoiEsTPQPZnWV2Vnl6k0Kfk2lLRFabw1BpZI4oo1uIdG+XKbYaW7TpY
         7HIhGyJ684bnoeznmhCB5QSo+tOvzfo15sCRyteyUVK4QRc4jJvpbkk4tVE7/mz6K4zu
         weuYU3qjM9+DbbhurwhWHSHpA+yK/DTxWm816Yncg7M8PBIvXzjRRt/jhHCdAbrVWYzx
         EuTIanJcWyXDQTDV9zsMotNTJ9CF9A8/cEwvc1uW1SbWEKA44IvETTDTQ1rqaKZ7rLtU
         6EAw==
X-Gm-Message-State: APjAAAU/ko5U3TUV0E1CQ24hyrj4cVQxuEoGqRhf0d9xWfqgU/LRD6hL
        bMbP0UdtjBMzpvayD/Pl/KJIQL1mubf9sPmGA6bNh6yFHkE=
X-Google-Smtp-Source: APXvYqx9wJGEDYVQgFnbVmcu8aeElGRaZL3nGW1h6c+HmEj4s9hXfqOz6zn7OmUZNpDSnuE0e/UDn1veeBfWaPoFfUQ=
X-Received: by 2002:ac2:55a8:: with SMTP id y8mr8278391lfg.117.1576231718959;
 Fri, 13 Dec 2019 02:08:38 -0800 (PST)
MIME-Version: 1.0
References: <20191205083915.27650-1-linus.walleij@linaro.org> <cbe69b98-39a9-4e87-77d2-cf7a4753a6ce@baylibre.com>
In-Reply-To: <cbe69b98-39a9-4e87-77d2-cf7a4753a6ce@baylibre.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 13 Dec 2019 11:08:27 +0100
Message-ID: <CACRpkdYgLoO8jPEWSxteZrdi2-dMjpCX0zKfXR1Zrv6RH=MJ=A@mail.gmail.com>
Subject: Re: [PATCH] spi: meson-spicc: Use GPIO descriptors
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Sunny Luo <sunny.luo@amlogic.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Dec 5, 2019 at 10:12 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
> On 05/12/2019 09:39, Linus Walleij wrote:
> > Instead of grabbing GPIOs using the legacy interface and
> > handling them in the setup callback, just let the core
> > grab and use the GPIOs using descriptors.
> >
> > Cc: Neil Armstrong <narmstrong@baylibre.com>
> > Cc: Sunny Luo <sunny.luo@amlogic.com>
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> > ---
> >  drivers/spi/spi-meson-spicc.c | 25 ++-----------------------
> >  1 file changed, 2 insertions(+), 23 deletions(-)
> >
> > diff --git a/drivers/spi/spi-meson-spicc.c b/drivers/spi/spi-meson-spicc.c
> > index f3f10443f9e2..7f5680fe2568 100644
> > --- a/drivers/spi/spi-meson-spicc.c
> > +++ b/drivers/spi/spi-meson-spicc.c
> > @@ -19,7 +19,6 @@
> >  #include <linux/types.h>
> >  #include <linux/interrupt.h>
> >  #include <linux/reset.h>
> > -#include <linux/gpio.h>
> >
> >  /*
> >   * The Meson SPICC controller could support DMA based transfers, but is not
> > @@ -467,35 +466,14 @@ static int meson_spicc_unprepare_transfer(struct spi_master *master)
> >
> >  static int meson_spicc_setup(struct spi_device *spi)
> >  {
> > -     int ret = 0;
> > -
> >       if (!spi->controller_state)
> >               spi->controller_state = spi_master_get_devdata(spi->master);
> > -     else if (gpio_is_valid(spi->cs_gpio))
> > -             goto out_gpio;
> > -     else if (spi->cs_gpio == -ENOENT)
> > -             return 0;
> > -
> > -     if (gpio_is_valid(spi->cs_gpio)) {
> > -             ret = gpio_request(spi->cs_gpio, dev_name(&spi->dev));
> > -             if (ret) {
> > -                     dev_err(&spi->dev, "failed to request cs gpio\n");
> > -                     return ret;
> > -             }
> > -     }
> > -
> > -out_gpio:
> > -     ret = gpio_direction_output(spi->cs_gpio,
> > -                     !(spi->mode & SPI_CS_HIGH));
> >
> > -     return ret;
> > +     return 0;
> >  }
> >
> >  static void meson_spicc_cleanup(struct spi_device *spi)
> >  {
> > -     if (gpio_is_valid(spi->cs_gpio))
> > -             gpio_free(spi->cs_gpio);
> > -
> >       spi->controller_state = NULL;
> >  }
> >
> > @@ -564,6 +542,7 @@ static int meson_spicc_probe(struct platform_device *pdev)
> >       master->prepare_message = meson_spicc_prepare_message;
> >       master->unprepare_transfer_hardware = meson_spicc_unprepare_transfer;
> >       master->transfer_one = meson_spicc_transfer_one;
> > +     master->use_gpio_descriptors = true;
> >
> >       /* Setup max rate according to the Meson GX datasheet */
> >       if ((rate >> 2) > SPICC_MAX_FREQ)
> >
>
> Hmm, I did this because the SPI core was buggy, so I assume it has been fixed ?
>
> gpio_request/free was not done by the core, thus needing to be done in the setup/cleanup callback.

Yes and no. I convert to using descriptors which are devm managed
resources.

If you use the legacy API for requesting GPIO (by number) which is
what happens without ->use_gpio_descriptors then this need for
the driver to request the GPIOs still exist.

Here we solve two problems at the same time:

- Get rid of the need to explicitly request the lines
- Convert to use descriptors

Isn't it great.

Yours,
Linus Walleij
