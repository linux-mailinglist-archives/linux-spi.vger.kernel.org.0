Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F285F1C6BAD
	for <lists+linux-spi@lfdr.de>; Wed,  6 May 2020 10:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728595AbgEFI1g (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 6 May 2020 04:27:36 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40656 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728436AbgEFI1f (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 6 May 2020 04:27:35 -0400
Received: by mail-ot1-f67.google.com with SMTP id i27so691825ota.7;
        Wed, 06 May 2020 01:27:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vCxRIS23FoOP0c2W/2eOvh5VSv4P5EkgKVxWMleJAFA=;
        b=XtK74gnw9shrUVLTG2rtJOuI+clhWnXbq2X3iTJK8lS+YQ4hwR5pvrvizAgJHmPzhL
         uRpclv1Lg/XZosFN4UpwYY0AcBwCFZ0MyKz6t7eQycyKjtSlRtHe5AJ+UK48+phQFTDA
         oP9Hi8tTvOxRYpPFdfe4Fe6LtpTXfGC4YFzJYCQFBB679MigjNgrox4txLAkG/JOHsw5
         KDBGxZhJn5h6Y/qWp/9V8Agt6A/pUU/Fex38qFVO+cu6RPiv4zo+JfGcXLZ620xQI1by
         piyMul+GdU2BTXg5rxZqB05f91hSzhiwY8gAadO0eFHDKp6ljOPpwbbbOcRYiVHnL38I
         wsyQ==
X-Gm-Message-State: AGi0PuZsluczeOTDx2xRX52PT05FK1HROB1Lp+ogQu2BOyWKVYyxi7gf
        kxkYOdxQk3/S0DCBwO0sh5YDjh707R/ebiguwd8=
X-Google-Smtp-Source: APiQypId8MqlCuIicyVdeJAq4AzLk9FuRq8+nlSwPhMnLKUA9N4T7je+r8pkSaItm2cixXY805fYVRX8Frp727kVdqo=
X-Received: by 2002:a9d:63da:: with SMTP id e26mr44857otl.107.1588753654870;
 Wed, 06 May 2020 01:27:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200506014135.2941967-1-alistair@alistair23.me>
In-Reply-To: <20200506014135.2941967-1-alistair@alistair23.me>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 6 May 2020 10:27:23 +0200
Message-ID: <CAMuHMdV7qGSbw44O+ykSz3W6h6oxj-ir+9qRbeazKb+p7Z=2Mg@mail.gmail.com>
Subject: Re: [PATCH] spi: sun6i: Add support for GPIO chip select lines
To:     Alistair Francis <alistair@alistair23.me>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, alistair23@gmail.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Alistair,

On Wed, May 6, 2020 at 3:41 AM Alistair Francis <alistair@alistair23.me> wrote:
> Add a setup function that can be used to support using generic GPIO
> lines for the chip select.
>
> Signed-off-by: Alistair Francis <alistair@alistair23.me>
> ---
>  drivers/spi/spi-sun6i.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>
> diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
> index ec7967be9e2f..fd4e19434942 100644
> --- a/drivers/spi/spi-sun6i.c
> +++ b/drivers/spi/spi-sun6i.c
> @@ -10,6 +10,7 @@
>  #include <linux/clk.h>
>  #include <linux/delay.h>
>  #include <linux/device.h>
> +#include <linux/gpio.h>
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
>  #include <linux/module.h>
> @@ -171,6 +172,31 @@ static inline void sun6i_spi_fill_fifo(struct sun6i_spi *sspi, int len)
>         }
>  }
>
> +static int sun6i_spi_setup(struct spi_device *spi)
> +{
> +       int ret;
> +
> +       /* sanity check for native cs */
> +       if (spi->mode & SPI_NO_CS)
> +               return 0;
> +       if (gpio_is_valid(spi->cs_gpio)) {
> +               /* with gpio-cs set the GPIO to the correct level
> +                * and as output (in case the dt has the gpio not configured
> +                * as output but native cs)
> +                */
> +               ret = gpio_direction_output(spi->cs_gpio,
> +                                           (spi->mode & SPI_CS_HIGH) ? 0 : 1);
> +               if (ret)
> +                       dev_err(&spi->dev,
> +                               "could not set gpio %i as output: %i\n",
> +                               spi->cs_gpio, ret);
> +
> +               return ret;
> +       }
> +
> +       return 0;
> +}
> +
>  static void sun6i_spi_set_cs(struct spi_device *spi, bool enable)
>  {
>         struct sun6i_spi *sspi = spi_master_get_devdata(spi->master);
> @@ -470,6 +496,7 @@ static int sun6i_spi_probe(struct platform_device *pdev)
>
>         master->max_speed_hz = 100 * 1000 * 1000;
>         master->min_speed_hz = 3 * 1000;
> +       master->setup = sun6i_spi_setup;
>         master->set_cs = sun6i_spi_set_cs;
>         master->transfer_one = sun6i_spi_transfer_one;
>         master->num_chipselect = 4;

Can't you just set

    master->use_gpio_descriptors = true;

instead and be done with it?
Then drivers/spi/spi.c:spi_get_gpio_descs() will configure the GPIO line
as output for you.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
