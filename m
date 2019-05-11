Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07C171A5C6
	for <lists+linux-spi@lfdr.de>; Sat, 11 May 2019 02:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbfEKAbq (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 10 May 2019 20:31:46 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:36060 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728034AbfEKAbq (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 10 May 2019 20:31:46 -0400
Received: by mail-yw1-f67.google.com with SMTP id q185so6133976ywe.3
        for <linux-spi@vger.kernel.org>; Fri, 10 May 2019 17:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=37gYHYklWiUK8DeeVO0yWIPtkgijLNy1XhumPu2c5I0=;
        b=udkGlzZPnlyiJWvLbW1X17eM6DhssyqZqs16WwVz4guEuDEsAh8rTt+WIdkaoDw2oW
         LQtL8cPNZJ6YP1k5+phgdBQeCIGaVjUz7autVFWsCpmJihlRPgL80CwEKAe7b58Yb+mO
         CHkvQ4qdPoux5SCP59vpVj3sxBowimctiCjRo1yVWA2AjRhClomJNpPaCTn5PWm2VYW4
         hzJw/9nZBnQJOy0x7CIDI9KjHDxXGkz49UD+5bSUBHmSB4HemnFhr5BHpwYBIsClLYp2
         6n155/erwIumXrsjcNgfFGnLsIbHVq5oJh+RfNE9oEvC8EZm9GycY1I+b5Dg+OtFvfSA
         Pfzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=37gYHYklWiUK8DeeVO0yWIPtkgijLNy1XhumPu2c5I0=;
        b=rR+bdYSvHs9S8BTiEcycKHZe6pFsoOe2mTIjBtwYelr3svgGE+Lng33g2cT9kTBF9a
         /QE9ZvInh6taX21tSJOCmk7NFZmhca0U7s2kDQO/IRRyzRAopRrA0k2anoYTSqj1KzPk
         PK5CnTzICjZAOJLBSAwR6C9SsxjSzn4jM8QuDriqkuHCWvq7hPvZc7ZKwDfH/TgBIU/B
         W6P7MOJcWENYsrSr4i8WhItUR3ugn1tIix1Jru3lxdt7istLlqACd6vu7Dy5ry5n+f9C
         A08WmKIi3y+GS+5vOfQUCRyDL1uLu6f0aQ0EPTt3vUseJ7MRpV2NT82D/hryMdEN2R1P
         rBYg==
X-Gm-Message-State: APjAAAX2vZZ06BwpFdsp2DJlXPeIqAZHGb9taiuIj1vmKcZvWS5z8jP2
        cni8/xPE6CZBB54qhDsbyuA6ADxIfUwITNJdKUFqaQ==
X-Google-Smtp-Source: APXvYqw0QybtLpZFbHcZuSEwYx/GP5Q6qTzWStLD3kj7kXDzOp9qOhnX5eq+XzYwkaMJFaBb7ksQRi8wwR85zUhCRp8=
X-Received: by 2002:a81:6cc6:: with SMTP id h189mr7514731ywc.320.1557534704776;
 Fri, 10 May 2019 17:31:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190510223437.84368-1-dianders@chromium.org> <20190510223437.84368-3-dianders@chromium.org>
In-Reply-To: <20190510223437.84368-3-dianders@chromium.org>
From:   Guenter Roeck <groeck@google.com>
Date:   Fri, 10 May 2019 17:31:33 -0700
Message-ID: <CABXOdTdgxfsAWLzAdcTuwyj4kbcSGi-UKCr5x2GJyiLfoCR=tA@mail.gmail.com>
Subject: Re: [PATCH 2/4] spi: Allow SPI devices to specify that they are
 timing sensitive
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-spi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Douglas Anderson <dianders@chromium.org>
Date: Fri, May 10, 2019 at 3:35 PM
To: Mark Brown, Benson Leung, Enric Balletbo i Serra
Cc: <linux-rockchip@lists.infradead.org>, <drinkcat@chromium.org>,
Guenter Roeck, <briannorris@chromium.org>, <mka@chromium.org>, Douglas
Anderson, <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>

> If a device on the SPI bus is very sensitive to timing then it may be
> necessary (for correctness) not to get interrupted during a transfer.
> One example is the EC (Embedded Controller) on Chromebooks.  The
> Chrome OS EC will drop a transfer if more than ~8ms passes between the
> chip select being asserted and the transfer finishing.
>
> The SPI framework already has code to handle the case where transfers
> are timing senstive.  It can set its message pumping thread to
> realtime to to minimize interruptions during the transfer.  However,
> at the moment, this mode can only be requested by a SPI controller.
> Let's allow the drivers for SPI devices to also request this mode.
>
> NOTE: at the moment if a given device on a bus says that it's timing
> sensitive then we'll pump all messages on that bus at high priority.
> It is possible we might want to relax this in the future but it seems
> like it should be fine for now.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Nitpick: I would use 'rt' instead of 'timing_sensitive' as name for the
new variable.

Otherwise:

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
>
>  drivers/spi/spi.c       | 34 ++++++++++++++++++++++++++++------
>  include/linux/spi/spi.h |  3 +++
>  2 files changed, 31 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index 0597f7086de3..d117ab3adafa 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -1367,10 +1367,30 @@ static void spi_pump_messages(struct kthread_work *work)
>         __spi_pump_messages(ctlr, true);
>  }
>
> -static int spi_init_queue(struct spi_controller *ctlr)
> +/**
> + * spi_boost_thread_priority - set the controller to pump at realtime priority
> + * @ctlr: controller to boost priority of
> + *
> + * This can be called because the controller requested realtime priority
> + * (by setting the ->rt value before calling spi_register_controller()) or
> + * because a device on the bus said that its transfers were timing senstive.
> + *
> + * NOTE: at the moment if any device on a bus says it is timing sensitive then
> + * all the devices on this bus will do transfers at realtime priority.  If
> + * this eventually becomes a problem we may see if we can find a way to boost
> + * the priority only temporarily during relevant transfers.
> + */
> +static void spi_boost_thread_priority(struct spi_controller *ctlr)
>  {
>         struct sched_param param = { .sched_priority = MAX_RT_PRIO - 1 };
>
> +       dev_info(&ctlr->dev,
> +               "will run message pump with realtime priority\n");
> +       sched_setscheduler(ctlr->kworker_task, SCHED_FIFO, &param);
> +}
> +
> +static int spi_init_queue(struct spi_controller *ctlr)
> +{
>         ctlr->running = false;
>         ctlr->busy = false;
>
> @@ -1390,11 +1410,8 @@ static int spi_init_queue(struct spi_controller *ctlr)
>          * request and the scheduling of the message pump thread. Without this
>          * setting the message pump thread will remain at default priority.
>          */
> -       if (ctlr->rt) {
> -               dev_info(&ctlr->dev,
> -                       "will run message pump with realtime priority\n");
> -               sched_setscheduler(ctlr->kworker_task, SCHED_FIFO, &param);
> -       }
> +       if (ctlr->rt)
> +               spi_boost_thread_priority(ctlr);
>
>         return 0;
>  }
> @@ -2985,6 +3002,11 @@ int spi_setup(struct spi_device *spi)
>
>         spi_set_cs(spi, false);
>
> +       if (spi->timing_sensitive && !spi->controller->rt) {
> +               spi->controller->rt = true;
> +               spi_boost_thread_priority(spi->controller);
> +       }
> +
>         dev_dbg(&spi->dev, "setup mode %d, %s%s%s%s%u bits/w, %u Hz max --> %d\n",
>                         (int) (spi->mode & (SPI_CPOL | SPI_CPHA)),
>                         (spi->mode & SPI_CS_HIGH) ? "cs_high, " : "",
> diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
> index 053abd22ad31..ef6bdd4d25f2 100644
> --- a/include/linux/spi/spi.h
> +++ b/include/linux/spi/spi.h
> @@ -109,6 +109,8 @@ void spi_statistics_add_transfer_stats(struct spi_statistics *stats,
>   *     This may be changed by the device's driver, or left at the
>   *     default (0) indicating protocol words are eight bit bytes.
>   *     The spi_transfer.bits_per_word can override this for each transfer.
> + * @timing_sensitive: Transfers for this device are senstive to timing
> + *     so we should do our transfer at high priority.
>   * @irq: Negative, or the number passed to request_irq() to receive
>   *     interrupts from this device.
>   * @controller_state: Controller's runtime state
> @@ -143,6 +145,7 @@ struct spi_device {
>         u32                     max_speed_hz;
>         u8                      chip_select;
>         u8                      bits_per_word;
> +       bool                    timing_sensitive;
>         u32                     mode;
>  #define        SPI_CPHA        0x01                    /* clock phase */
>  #define        SPI_CPOL        0x02                    /* clock polarity */
> --
> 2.21.0.1020.gf2820cf01a-goog
>
