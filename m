Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1406629DF3
	for <lists+linux-spi@lfdr.de>; Tue, 15 Nov 2022 16:46:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238463AbiKOPqh (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 15 Nov 2022 10:46:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238340AbiKOPqN (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 15 Nov 2022 10:46:13 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 933342E68A
        for <linux-spi@vger.kernel.org>; Tue, 15 Nov 2022 07:46:12 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id q1-20020a17090a750100b002139ec1e999so14214535pjk.1
        for <linux-spi@vger.kernel.org>; Tue, 15 Nov 2022 07:46:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pc0OTzikBSgruz4FgT0jP6j4BRJovd/+d95u5Tcx80M=;
        b=PBLJX0ZpSAdE+92rLW1BpDSoALiD5QyJTHYH+weigsiDByWKyqWfgeizcJ5H0D/0AF
         WXIekt+drM3Z3qjHzbOAneoc7tlkPi5MfZzBifF6v1RIigGWKbQcxCRNnTchzChLgYgL
         hfJ8YpPJvAQFq+ONy+XTxrY6ynpVymCFFbK2JUQAKHuhOITc2f/Gc3BoMxOcMtMHUywA
         HpJopT0IXoCEvs0EwjWAcaO8t0ISCOV+wOaQavCGt707NCAp2fLsKLjVaZUxs6yAhcrt
         dclmRppAWwpVGxTFQENB5ZRtTwskCpyAL5Dpvx0Q79b1JAOv+IQYOCFTZSbMOxkZXlTg
         Flnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pc0OTzikBSgruz4FgT0jP6j4BRJovd/+d95u5Tcx80M=;
        b=Ln8NykdWPUpc2C7uwdqOHnapSp5hDVhWvJ0A458pW0rA7zXPRmqUby+vCZ9egrX6gB
         VyuNcOHijDtFt9x5kC52es13ntinqJzxmv5dN6WSKtPJvfXi5tYGe6cWP4HZluoDpEe5
         +gIFmd/iNon4Q8B5+2iB8tWupqsieFwHV7I7hodyGNKGumfhyoV0Lej78VBiGkdokuW/
         J/0ipA8fQRlbfuAbUChQtJPrVt/yEVgls7i/PaAG79XG7Yd+jxXdYFpXPxAvPjOWUWwY
         WnhvfxHWeY4y8w7MaRfs3S0GjkmR3EvwkVfM6Z+Rq/GCGXr/v/KApiK1uIGc8x6xcRec
         DkIw==
X-Gm-Message-State: ANoB5pmF2MWh1hE2MNGnZUn2xbgAfXj8spkRfc8m1WNJU79NPebKmSyE
        K2UQbJSvrT3R3OCbqFFFpxs58xUZ4XntdmMqJ64=
X-Google-Smtp-Source: AA0mqf6+58IIW64m2sINaQR20mtvI+Jfmj04ytucnijUJEFajcOu4qnTDBlC9I98DcZbCtGAlUW6cUNgG/cj81ngr6g=
X-Received: by 2002:a17:902:6b8c:b0:185:4880:91cd with SMTP id
 p12-20020a1709026b8c00b00185488091cdmr4618622plk.130.1668527171969; Tue, 15
 Nov 2022 07:46:11 -0800 (PST)
MIME-Version: 1.0
References: <20221111003032.82371-1-festevam@gmail.com> <20221111105028.7d605632@erd992>
 <CAOMZO5CH9S_RYpLNZbRxChzSVkkZTAd+qpxz1Ycj2UUPROTXpw@mail.gmail.com>
 <20221111135919.63daed2d@erd992> <1c70bfd1-38f6-3a30-9e36-a0f780f82571@kontron.de>
 <Y3ImhoSzY1PYMp+9@sirena.org.uk> <46dc7280-545d-6b8c-ff7f-4bad13486292@kontron.de>
 <20221115125549.iih75abpy7cppiss@pengutronix.de> <ff8c3ba5-fef6-cb9f-cccb-95e300892eba@kontron.de>
In-Reply-To: <ff8c3ba5-fef6-cb9f-cccb-95e300892eba@kontron.de>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 15 Nov 2022 12:45:55 -0300
Message-ID: <CAOMZO5A4DZhox+ZSGu12CyY8ju+G502KODz++UC0xMYbLKR8NQ@mail.gmail.com>
Subject: Re: [PATCH] spi: spi-imx: Revert "spi: spi-imx: add PIO polling support"
To:     Frieder Schrempf <frieder.schrempf@kontron.de>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Mark Brown <broonie@kernel.org>,
        David Jander <david@protonic.nl>, linux-spi@vger.kernel.org,
        stable@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Frieder,

On Tue, Nov 15, 2022 at 11:46 AM Frieder Schrempf
<frieder.schrempf@kontron.de> wrote:

> Both fixes are quite simple (see diff below) and if you agree I will
> send them as formal patches.
>
> Thanks
> Frieder
>
> [1]
> https://elixir.bootlin.com/linux/latest/source/drivers/spi/spi-imx.c#L447
> [2]
> https://elixir.bootlin.com/linux/latest/source/drivers/spi/spi-imx.c#L650
>
> --- a/drivers/spi/spi-imx.c
> +++ b/drivers/spi/spi-imx.c
> @@ -445,7 +445,7 @@ static unsigned int mx51_ecspi_clkdiv(struct
> spi_imx_data *spi_imx,
>         unsigned int fin = spi_imx->spi_clk;
>
>         if (unlikely(fspi > fin))
> -               return 0;
> +               fspi = fin;
>
>         post = fls(fin) - fls(fspi);
>         if (fin > fspi << post)
> @@ -1613,6 +1613,7 @@ static int spi_imx_transfer_one(struct
> spi_controller *controller,
>          */
>         hz_per_byte = polling_limit_us ? ((8 + 4) * USEC_PER_SEC) /
> polling_limit_us : 0;
>         byte_limit = hz_per_byte ? transfer->effective_speed_hz /
> hz_per_byte : 1;
> +       byte_limit = min(byte_limit, spi_imx->devtype_data->fifo_size);

Here, I had to add a cast to avoid a build warning:

byte_limit = min(byte_limit, (unsigned long)spi_imx->devtype_data->fifo_size);

SPI NOR programming worked fine with your proposed changes, thanks:

Tested-by: Fabio Estevam <festevam@gmail.com>

On Tue, Nov 15, 2022 at 11:46 AM Frieder Schrempf
<frieder.schrempf@kontron.de> wrote:
>
> Hi Marc,
>
> On 15.11.22 13:55, Marc Kleine-Budde wrote:
> > On 15.11.2022 11:51:53, Frieder Schrempf wrote:
> >> On 14.11.22 12:29, Mark Brown wrote:
> >>> On Mon, Nov 14, 2022 at 09:30:26AM +0100, Frieder Schrempf wrote:
> >>>
> >>>> As far as I know Fabio also discovered that disabling SDMA also fixes
> >>>> the problem.
> >>>
> >>>> I guess I will try to repeat some tests on latest master and see if
> >>>> there is anything that makes things work again without reducing the
> >>>> clock. If anyone has some more ideas of how to fix this properly, please
> >>>> let me know. If nothing else helps we could also reduce the SPI clock.
> >>>
> >>> It sounds like the commit can stay and that everyone is happy
> >>> that the issue is that the the commit made things run faster and
> >>> exposed some other misconfiguration for these systems?
> >>
> >> Honestly I'm not really sure how to proceed.
> >>
> >> My first impression was to keep the PIO polling support with its
> >> benefits if there's just this single issue with the SPI NOR on our board
> >> and assuming that the performance improvements uncovered a bug somewhere
> >> else. But at the moment I'm not quite sure this is really the case.
> >>
> >> I did another test on v6.1-rc5 and disabling either PIO polling
> >> (spi-imx.polling_limit_us=0) or DMA (spi-imx.use_dma=0), or both of them
> >> makes reading the SPI NOR work again.
> >
> > That was a good hint, I think I've found something.
> >
> > Can you check if this fixes your problem? Just a quick hack to, a proper
> > solution needs some more love.
> >
> > diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
> > index 30d82cc7300b..76021b9bb445 100644
> > --- a/drivers/spi/spi-imx.c
> > +++ b/drivers/spi/spi-imx.c
> > @@ -1270,9 +1270,22 @@ static int spi_imx_setupxfer(struct spi_device *spi,
> >                 spi_imx->dynamic_burst = 0;
> >         }
> >
> > -       if (spi_imx_can_dma(spi_imx->controller, spi, t))
> > -               spi_imx->usedma = true;
> > -       else
> > +       if (spi_imx_can_dma(spi_imx->controller, spi, t)) {
> > +               unsigned long hz_per_byte, byte_limit;
> > +
> > +               /*
> > +                * Calculate the estimated time in us the transfer runs. Find
> > +                * the number of Hz per byte per polling limit.
> > +                */
> > +               hz_per_byte = polling_limit_us ? ((8 + 4) * USEC_PER_SEC) / polling_limit_us : 0;
> > +               byte_limit = hz_per_byte ? t->effective_speed_hz / hz_per_byte : 1;
> > +
> > +               /* run in polling mode for short transfers */
> > +               if (t->len < byte_limit)
> > +                       spi_imx->usedma = false;
> > +               else
> > +                       spi_imx->usedma = true;
> > +       } else
> >                 spi_imx->usedma = false;
> >
> >         spi_imx->rx_only = ((t->tx_buf == NULL)
> > @@ -1597,8 +1610,8 @@ static int spi_imx_transfer_one(struct spi_controller *controller,
> >         struct spi_imx_data *spi_imx = spi_controller_get_devdata(spi->controller);
> >         unsigned long hz_per_byte, byte_limit;
> >
> > -       spi_imx_setupxfer(spi, transfer);
> >         transfer->effective_speed_hz = spi_imx->spi_bus_clk;
> > +       spi_imx_setupxfer(spi, transfer);
> >
> >         /* flush rxfifo before transfer */
> >         while (spi_imx->devtype_data->rx_available(spi_imx))
> >
>
> Thanks for the patch, but unfortunately this doesn't help. I did some
> more debugging and it looks like there are two problems.
>
> In my case on i.MX8MM the SPI is fed by a 50 MHz peripheral clock.
> Requesting 80 MHz for the SPI NOR triggers the fspi > fin condition in
> mx51_ecspi_clkdiv() [1] which in turn leaves *fres uninitialized causing
> spi_imx->spi_bus_clk to be set to an arbitrary/random value in
> mx51_ecspi_prepare_transfer() [2].
>
> This in turn messes up the calculation for the PIO polling byte limit.
> In my case the limit was usually somewhere around 8000 bytes, so the
> 4096 byte SPI NOR messages get transferred via PIO polling.
>
> Having large and inefficient polling transfers shouldn't be a problem
> and lead to corrupted data, but I suspect that it doesn't work because
> the transfer size exceeds the FIFO size in this case.
>
> If my conclusions are correct there are two fixes required (though for
> my use case each one of the alone is enough to make things work):
>
> 1. Make sure spi_bus_clk is correct even if the requested bus clock
> exceeds the input clock.
>
> 2. Limit byte_limit for PIO polling calculation to a maximum of
> fifo_size, so we don't try to poll for transfers that don't fit into the
> FIFO.
>
> Both fixes are quite simple (see diff below) and if you agree I will
> send them as formal patches.
>
> Thanks
> Frieder
>
> [1]
> https://elixir.bootlin.com/linux/latest/source/drivers/spi/spi-imx.c#L447
> [2]
> https://elixir.bootlin.com/linux/latest/source/drivers/spi/spi-imx.c#L650
>
> --- a/drivers/spi/spi-imx.c
> +++ b/drivers/spi/spi-imx.c
> @@ -445,7 +445,7 @@ static unsigned int mx51_ecspi_clkdiv(struct
> spi_imx_data *spi_imx,
>         unsigned int fin = spi_imx->spi_clk;
>
>         if (unlikely(fspi > fin))
> -               return 0;
> +               fspi = fin;
>
>         post = fls(fin) - fls(fspi);
>         if (fin > fspi << post)
> @@ -1613,6 +1613,7 @@ static int spi_imx_transfer_one(struct
> spi_controller *controller,
>          */
>         hz_per_byte = polling_limit_us ? ((8 + 4) * USEC_PER_SEC) /
> polling_limit_us : 0;
>         byte_limit = hz_per_byte ? transfer->effective_speed_hz /
> hz_per_byte : 1;
> +       byte_limit = min(byte_limit, spi_imx->devtype_data->fifo_size);
>
>         /* run in polling mode for short transfers */
>         if (transfer->len < byte_limit)
