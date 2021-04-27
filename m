Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D303C36BF77
	for <lists+linux-spi@lfdr.de>; Tue, 27 Apr 2021 08:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbhD0Gxs (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 27 Apr 2021 02:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbhD0Gxr (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 27 Apr 2021 02:53:47 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09DCCC061574;
        Mon, 26 Apr 2021 23:53:05 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id j6-20020a17090adc86b02900cbfe6f2c96so6694869pjv.1;
        Mon, 26 Apr 2021 23:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AdW+5T+k5u7cNZysyil9KyXcGibUka0VOAb1DAnUCrs=;
        b=qrDHn7yNVUu8BEEAQsysRKJZL6qa99so4j7pM/pOggWZ4LP5VXqr7Eq6uVPDmDHFwc
         8X8nuRKF7jthk7QSwiqu+zMMwBypxSEJsVnluYFx4mJjgK+GfTxiR7ctodLMwgfAXClb
         muFf4/2SHjGHseh4FFvms9SpYnddVAiD5iRQ5HYvGF5Kw7vJq5rOsdWX4b1XrFcAhAkl
         crQ+Z/RgSynsVb28RZha9z9T/EFcSDMp9TuzZ5Pwm/i2nI/Zvq2B5J2y3wN+g5zl0UiN
         d4ge/7FQ7PBCPesnZ2i4oDb7OdXTPS9AwsdLfpq0ktPzYnYnkGW8Ak/cjUqKm+EP/dvB
         mRYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AdW+5T+k5u7cNZysyil9KyXcGibUka0VOAb1DAnUCrs=;
        b=uL9j26sigGo3AsRUxkik3Kn0PKwqbtRqtDDbVQ4uAQc4JB9EosWpgXtK1uw8bOv+1P
         71Tg2KjPIsisOXcEQXc3HZ8iWggQXzpTQKsn9KoFm2vy98OIKtggCNZMJI82A9WBccAE
         W/Q1K53EoO3DfKPPIBo8k4nIMR7HbnQ3IZ7FwA53UDXxt53pQYnf9HZnf528hx4A7gns
         Yu4iycYyK0sfhPZbRqd4eHYh97w7N+1XuUdClMKujwJZNo5CXskvMr5T4FRhS/Y0/nCT
         mx97MI6EfXJ+sr2lA3HG+q/05/cFK6tOcRauOSbSZ+mUAoj8WK5hjJVcnbbu50fAh9qK
         0HHw==
X-Gm-Message-State: AOAM531SowQsn/4QWucowZluLxxXec595T5moZEOCmQ0zIPWuKomBHft
        qZZVZNe8kuCSEJLEA7DFl362ZGLmUwkoau2Ckbc=
X-Google-Smtp-Source: ABdhPJzuBzukcIOSpxqHPoqUr3O6O1Ei2aTHW1grEeudTbKwMG+Sy86hIoi/z014iz8+SFMl6x59BRkGXYbU5VPg5sM=
X-Received: by 2002:a17:902:a406:b029:e6:78c4:71c8 with SMTP id
 p6-20020a170902a406b02900e678c471c8mr22536493plq.17.1619506384517; Mon, 26
 Apr 2021 23:53:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210426235638.1285530-1-saravanak@google.com>
In-Reply-To: <20210426235638.1285530-1-saravanak@google.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 27 Apr 2021 09:52:48 +0300
Message-ID: <CAHp75VeNZ4-TgkevNF5tgmB1eU9E77RNsPWRABp6PvC6eGpQrQ@mail.gmail.com>
Subject: Re: [PATCH] spi: Fix spi device unregister flow
To:     Saravana Kannan <saravanak@google.com>,
        Lukas Wunner <lukas@wunner.de>
Cc:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Android Kernel Team <kernel-team@android.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

+Cc Lukas

On Tue, Apr 27, 2021 at 2:56 AM Saravana Kannan <saravanak@google.com> wrote:
>
> When an SPI device is unregistered, the spi->controller->cleanup() is
> called in the device's release callback. That's wrong for a couple of
> reasons:
>
> 1. spi_dev_put() can be called before spi_add_device() is called. And
>    it's spi_add_device() that calls spi_setup(). This will cause clean()
>    to get called without the spi device ever being setup.
>
> 2. There's no guarantee that the controller's driver would be present by
>    the time the spi device's release function gets called.
>
> 3. It also causes "sleeping in atomic context" stack dump[1] when device
>    link deletion code does a put_device() on the spi device.
>
> Fix these issues by simply moving the cleanup from the device release
> callback to the actual spi_unregister_device() function.
>
> [1] - https://lore.kernel.org/lkml/CAHp75Vc=FCGcUyS0v6fnxme2YJ+qD+Y-hQDQLa2JhWNON9VmsQ@mail.gmail.com/
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>  drivers/spi/spi.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index b08efe88ccd6..7d0d89172a1d 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -47,10 +47,6 @@ static void spidev_release(struct device *dev)
>  {
>         struct spi_device       *spi = to_spi_device(dev);
>
> -       /* spi controllers may cleanup for released devices */
> -       if (spi->controller->cleanup)
> -               spi->controller->cleanup(spi);
> -
>         spi_controller_put(spi->controller);
>         kfree(spi->driver_override);
>         kfree(spi);
> @@ -558,6 +554,12 @@ static int spi_dev_check(struct device *dev, void *data)
>         return 0;
>  }
>
> +static void spi_cleanup(struct spi_device *spi)
> +{
> +       if (spi->controller->cleanup)
> +               spi->controller->cleanup(spi);
> +}
> +
>  /**
>   * spi_add_device - Add spi_device allocated with spi_alloc_device
>   * @spi: spi_device to register
> @@ -622,11 +624,13 @@ int spi_add_device(struct spi_device *spi)
>
>         /* Device may be bound to an active driver when this returns */
>         status = device_add(&spi->dev);
> -       if (status < 0)
> +       if (status < 0) {
>                 dev_err(dev, "can't add %s, status %d\n",
>                                 dev_name(&spi->dev), status);
> -       else
> +               spi_cleanup(spi);
> +       } else {
>                 dev_dbg(dev, "registered child %s\n", dev_name(&spi->dev));
> +       }
>
>  done:
>         mutex_unlock(&spi_add_lock);
> @@ -713,6 +717,8 @@ void spi_unregister_device(struct spi_device *spi)
>         if (!spi)
>                 return;
>
> +       spi_cleanup(spi);
> +
>         if (spi->dev.of_node) {
>                 of_node_clear_flag(spi->dev.of_node, OF_POPULATED);
>                 of_node_put(spi->dev.of_node);
> --
> 2.31.1.498.g6c1eba8ee3d-goog
>


-- 
With Best Regards,
Andy Shevchenko
