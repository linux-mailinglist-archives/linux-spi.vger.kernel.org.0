Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E736A421504
	for <lists+linux-spi@lfdr.de>; Mon,  4 Oct 2021 19:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233977AbhJDRSF (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 4 Oct 2021 13:18:05 -0400
Received: from mail-vs1-f44.google.com ([209.85.217.44]:38880 "EHLO
        mail-vs1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233446AbhJDRSE (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 4 Oct 2021 13:18:04 -0400
Received: by mail-vs1-f44.google.com with SMTP id y141so4802845vsy.5;
        Mon, 04 Oct 2021 10:16:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/cIKwqiiuLgobXDQ2FDfJfThXFQMEGwTN5ZwOTn9O4c=;
        b=pQ4iaKDNP+C76ASPJ2mNlCnDlix1tg5tvrHS3GvszQjLs03q47lolUVyHOsEcux8pb
         qTVmxfw+2rQIgYxAWauzoUgPFJ2+6k2aUDcApDf7D0P1KMsvxYAusx9oX/HnoHAIQojP
         IMd3iv6wNA1iZPZWe0Z0s2RueHGBQTwAhV2GK0gpIEXgqD5JMNC3Ccsck0ksheTG3o2t
         i4jNcFf/E3raLQNKNIqaCHoyUEkPMnUZlEzeVD7LfVi6CrnKLXtQp0VwshXmwGtzp/xX
         B3r8cYKH98L8taa9sTz/QLQegdb4GWG85eRNs6/3naEDFpNfmb+P9adh1ogvR5G9GZLr
         mQ4w==
X-Gm-Message-State: AOAM533OFF1PJzZqhDPtV1AS6vCsilbXlb5xnkemZ2x63igvuRDiY6MF
        V8hizUAykX+p9OtrDzU6FWhPeSc/x/x2XAN8mFA=
X-Google-Smtp-Source: ABdhPJwNIZzHrryVaq03dDhlSZqDVIvNqhD8sTXheMyiIkrcLXtixi70I9evUxN+y2x4M+IJ+XLbx0Evor3VmO5CVqA=
X-Received: by 2002:a67:c295:: with SMTP id k21mr11443962vsj.37.1633367774534;
 Mon, 04 Oct 2021 10:16:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210304034141.7062-1-brad@pensando.io> <20210304034141.7062-2-brad@pensando.io>
 <CAHp75VcG9KajNpDbewDq7QzotB6t7MfwiGk15FaobX+cmMVSzg@mail.gmail.com>
 <CAK9rFnwrA=W2Vk5yFwG4N_WS=eBXXnhtexA+tqgAYb6xOAO4oQ@mail.gmail.com>
 <CAHp75VdfrJ3JV_gL3xCLHOiw6Tj-5Ep7z5JKWUFKFbUt8gobcw@mail.gmail.com>
 <CAK9rFnx--z_pr_yR6CqGsH04ddwUtx4rxc7MxNNmy7ZSF86+Mg@mail.gmail.com>
 <CAMuHMdUz4vUQzXBHA9AiT3w6L20yBpgd0emVZJb=v_qw70qiJQ@mail.gmail.com>
 <CAK9rFnw-j8whcsK-NQ4w4+sCdrumCk7Bb=J+KfsF9ZO2Tf5r5g@mail.gmail.com>
 <CAMuHMdW0s=x+DBZffeuEcyifDRfy8YM3c_wEAZscO7twR2wj3Q@mail.gmail.com> <CAK9rFnwCry1G7RqdWL9W1vq6Q3RV9tRxmDD6UErY=hQB6W-=_Q@mail.gmail.com>
In-Reply-To: <CAK9rFnwCry1G7RqdWL9W1vq6Q3RV9tRxmDD6UErY=hQB6W-=_Q@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 4 Oct 2021 19:16:03 +0200
Message-ID: <CAMuHMdUCESsnrbsh981OeNfnuiGn7w49wbUctxc_FnsZyP8GZA@mail.gmail.com>
Subject: Re: [PATCH 1/8] gpio: Add Elba SoC gpio driver for spi cs control
To:     Brad Larson <brad@pensando.io>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Brad,

On Mon, Oct 4, 2021 at 7:14 PM Brad Larson <brad@pensando.io> wrote:
> On Mon, Aug 23, 2021 at 1:11 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Mon, Aug 23, 2021 at 6:31 PM Brad Larson <brad@pensando.io> wrote:
> > > On Mon, Aug 23, 2021 at 12:50 AM Geert Uytterhoeven
> > > <geert@linux-m68k.org> wrote:
> > > > On Mon, Aug 23, 2021 at 3:14 AM Brad Larson <brad@pensando.io> wrote:
> > > > > On Mon, Mar 29, 2021 at 3:40 AM Andy Shevchenko
> > > [...]
> > > > > Regarding the above module question and Kconfig definition, since I
> > > > > first looked at this and reviewed the comments I realized I should be
> > > > > using builtin.  The file gpio/Kconfig is currently this
> > > > >
> > > > > config GPIO_ELBA_SPICS
> > > > >         def_bool y
> > > > >         depends on ARCH_PENSANDO_ELBA_SOC || COMPILE_TEST
> > > >
> > > > That means the driver will default to yes by merely enabling
> > > > COMPILE_TEST, which is a no-go.
> > > >
> > > >     config GPIO_ELBA_SPICS
> > > >             bool "one-line summary"
> > > >             depends on ARCH_PENSANDO_ELBA_SOC || COMPILE_TEST
> > > >             default y if ARCH_PENSANDO_ELBA_SOC
> > >
> > > Thanks Geert, changed to this
> > >
> > > --- a/drivers/gpio/Kconfig
> > > +++ b/drivers/gpio/Kconfig
> > > @@ -241,8 +241,9 @@ config GPIO_EIC_SPRD
> > >           Say yes here to support Spreadtrum EIC device.
> > >
> > >  config GPIO_ELBA_SPICS
> > > +       bool "Pensando Elba SoC SPI Chip Select as GPIO support"
> > > +       depends on ARCH_PENSANDO_ELBA_SOC
> > >         def_bool y
> > > -       depends on ARCH_PENSANDO_ELBA_SOC || COMPILE_TEST
> >
> > So we're losing the COMPILE_TEST ability again?
> >
>
> Hi Geert,
>
> The gpio-elba-spics.c driver is being deleted with the spi chip-select
> control integrated into spi-dw-mmio.c.  The GPIO_ELBA_SPICS config
> option goes away and fixes my breakage of COMPILE_TEST.

OK. Thanks for the follow-up.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
