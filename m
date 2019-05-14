Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06AD81D020
	for <lists+linux-spi@lfdr.de>; Tue, 14 May 2019 21:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726036AbfENTo7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 14 May 2019 15:44:59 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:41954 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbfENToz (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 14 May 2019 15:44:55 -0400
Received: by mail-yw1-f68.google.com with SMTP id o65so247677ywd.8
        for <linux-spi@vger.kernel.org>; Tue, 14 May 2019 12:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WWNzgUR578IGEFBbLtpCrpyvIXcz+Pq8uV/vbHZGD+s=;
        b=OXIGVEAclJ24CckrLwHBe7KOlCnYTPq5OOSitVLOpgVht6ZiCChl6+yJ7aViSYPpGG
         9HvafLnLPzRF7WTia1W/ogZktH7Y1zNQdDO5C4+g+ctGVR8yqDtV789qJ/hmv0u79aWn
         N1Gh12znkPe1RXUlTVzjwqOTzT8BP/iDSGPg4wvQktMNZxi4o5Gnti4yFH0njCQSYr90
         QeRfMooTXFqqP4heorGGkr/7435EboXPhnO1GLpleZQNJtVFJVhew8xXfSk9wpSMbcis
         H8CMdDo7bs4IaRmG9Ahp7GgrHPIpHiD+p2RDNOqGL+8ERsu32UKtkDtqUAm67ugQ4DDB
         L/Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WWNzgUR578IGEFBbLtpCrpyvIXcz+Pq8uV/vbHZGD+s=;
        b=LnRlw4hYTASbvbnq83qBQR+BihUg0gniaUFHe1Ml4ZleLueTljuitSbpKCaSAANyvm
         7pFmO3NtBR3sgfTGmdf1xHlg3hSve1T1QwT1tGMOj04AJ2cLT4zrxnUBqZJ2R+7tme6w
         dksiGNWCP2R/qkq4AJhWH1tREGWK/BqgSrysOcQXO9HTiAoICg04rTy3u9d17lGN9vx0
         Brh0HF86h0sqJQ4ZMPaG0aLKOELGiFlINzbDlgTRCksJuFMr+HlHNf5rTnKe1Ap8h+A+
         DWV5F1rE91GHGv8nAUZAeKa4GPTlMMn7tLmRp/YTKf5vYPVWUt0cKSjeclFEVPHSr14m
         aAQQ==
X-Gm-Message-State: APjAAAU6t+F5o81+IRCQiT0i2Sx+HoD9b8PFJN80U8CVNHZndbyKpjeV
        qqa4V+6x5A39OSM7TMnHV3+hVGCBV47REL5jpJrjHg==
X-Google-Smtp-Source: APXvYqx9Q+7nW0k0HhrbLDn+euVlJ8+dDDSqHxkodW9CqTuwRx1EbaZHRhc2S2IKSuQF/Pyrgiz6q2gHxOQRNronuo4=
X-Received: by 2002:a81:2513:: with SMTP id l19mr13039829ywl.299.1557863093359;
 Tue, 14 May 2019 12:44:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190514183935.143463-1-dianders@chromium.org> <20190514183935.143463-3-dianders@chromium.org>
In-Reply-To: <20190514183935.143463-3-dianders@chromium.org>
From:   Guenter Roeck <groeck@google.com>
Date:   Tue, 14 May 2019 12:44:42 -0700
Message-ID: <CABXOdTdiEgF2Jypha1qZ4s1X2bkYqVTmT7XNYge19WQtSarSVw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] spi: Allow SPI devices to request the pumping
 thread be realtime
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

On Tue, May 14, 2019 at 11:40 AM Douglas Anderson <dianders@chromium.org> wrote:
>
> Right now the only way to get the SPI pumping thread bumped up to
> realtime priority is for the controller to request it.  However it may
> be that the controller works fine with the normal priority but
> communication to a particular SPI device on the bus needs realtime
> priority.
>
> Let's add a way for devices to request realtime priority when they set
> themselves up.
>
> NOTE: this will just affect the priority of transfers that end up on
> the SPI core's pumping thread.  In many cases transfers happen in the
> context of the caller so if you need realtime priority for all
> transfers you should ensure the calling context is also realtime
> priority.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
>
> Changes in v3:
> - SPI core change now like patch v1 patch #2 (with name "rt").
>
> Changes in v2:
> - Now only force transfers to the thread for devices that want it.
> - Squashed patch #1 and #2 together.
> - Renamed variable to "force_rt_transfers".
>
>  drivers/spi/spi.c       | 36 ++++++++++++++++++++++++++++++------
>  include/linux/spi/spi.h |  2 ++
>  2 files changed, 32 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index 8eb7460dd744..466984796dd9 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -1364,10 +1364,32 @@ static void spi_pump_messages(struct kthread_work *work)
>         __spi_pump_messages(ctlr, true);
>  }
>
> -static int spi_init_queue(struct spi_controller *ctlr)
> +/**
> + * spi_set_thread_rt - set the controller to pump at realtime priority
> + * @ctlr: controller to boost priority of
> + *
> + * This can be called because the controller requested realtime priority
> + * (by setting the ->rt value before calling spi_register_controller()) or
> + * because a device on the bus said that its transfers needed realtime
> + * priority.
> + *
> + * NOTE: at the moment if any device on a bus says it needs realtime then
> + * the thread will be at realtime priority for all transfers on that
> + * controller.  If this eventually becomes a problem we may see if we can
> + * find a way to boost the priority only temporarily during relevant
> + * transfers.
> + */
> +static void spi_set_thread_rt(struct spi_controller *ctlr)
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
> @@ -1387,11 +1409,8 @@ static int spi_init_queue(struct spi_controller *ctlr)
>          * request and the scheduling of the message pump thread. Without this
>          * setting the message pump thread will remain at default priority.
>          */
> -       if (ctlr->rt) {
> -               dev_info(&ctlr->dev,
> -                       "will run message pump with realtime priority\n");
> -               sched_setscheduler(ctlr->kworker_task, SCHED_FIFO, &param);
> -       }
> +       if (ctlr->rt)
> +               spi_set_thread_rt(ctlr);
>
>         return 0;
>  }
> @@ -2982,6 +3001,11 @@ int spi_setup(struct spi_device *spi)
>
>         spi_set_cs(spi, false);
>
> +       if (spi->rt && !spi->controller->rt) {
> +               spi->controller->rt = true;
> +               spi_set_thread_rt(spi->controller);
> +       }
> +
>         dev_dbg(&spi->dev, "setup mode %d, %s%s%s%s%u bits/w, %u Hz max --> %d\n",
>                         (int) (spi->mode & (SPI_CPOL | SPI_CPHA)),
>                         (spi->mode & SPI_CS_HIGH) ? "cs_high, " : "",
> diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
> index 053abd22ad31..15505c2485d6 100644
> --- a/include/linux/spi/spi.h
> +++ b/include/linux/spi/spi.h
> @@ -109,6 +109,7 @@ void spi_statistics_add_transfer_stats(struct spi_statistics *stats,
>   *     This may be changed by the device's driver, or left at the
>   *     default (0) indicating protocol words are eight bit bytes.
>   *     The spi_transfer.bits_per_word can override this for each transfer.
> + * @rt: Make the pump thread real time priority.
>   * @irq: Negative, or the number passed to request_irq() to receive
>   *     interrupts from this device.
>   * @controller_state: Controller's runtime state
> @@ -143,6 +144,7 @@ struct spi_device {
>         u32                     max_speed_hz;
>         u8                      chip_select;
>         u8                      bits_per_word;
> +       bool                    rt;
>         u32                     mode;
>  #define        SPI_CPHA        0x01                    /* clock phase */
>  #define        SPI_CPOL        0x02                    /* clock polarity */
> --
> 2.21.0.1020.gf2820cf01a-goog
>
