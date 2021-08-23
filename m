Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5233F51BA
	for <lists+linux-spi@lfdr.de>; Mon, 23 Aug 2021 22:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232016AbhHWUMX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 23 Aug 2021 16:12:23 -0400
Received: from mail-ua1-f48.google.com ([209.85.222.48]:41889 "EHLO
        mail-ua1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231716AbhHWUMW (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 23 Aug 2021 16:12:22 -0400
Received: by mail-ua1-f48.google.com with SMTP id 75so8628582uav.8;
        Mon, 23 Aug 2021 13:11:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AUpBckzMvXVbMxlgD0BPIwC+4lv7J+IVl66jvYDUuHo=;
        b=b/b73x2JZ4KjhsEwbh5qDWlakyitUjKztvAIJ2rAAS4I4bNKH+9KGyptdIZoxFWiDs
         xQ/JCbD6F/C+01FIMrGXBChGCGpFU8WOaTevRNKmehs/N1R1QuDMmDQvQqtFoAwFSQcS
         nHwi55DtxdZh7Ti9Vvjqwh4TOGEq2ZccpGCkDiiZkl34QyVdGaOzdAB3dNugpW6ItK2A
         i8FNJobWm6h2P6tNbJEbh6zdm7bko7rp/n+06ZbOqLaDwOEihCYapfnXO/SnHl4Fo8Yz
         KxTOcqZkMrBKZWH06K0/wurAt6tuwMu9t36vhdnGK3T8mYFytmwnNVfALqScEc4hMqkC
         Ydjw==
X-Gm-Message-State: AOAM530bdWMhqCjhvhTk+pTYI9PsLqsxz4jvhMEzCNeWqOd3888NK55r
        UarhKBuKCqKEwMvXHvR/MjVBdfIeBkGr1IokwoA=
X-Google-Smtp-Source: ABdhPJwDCxee7jV2n8a1Svw2CcluiW33jrACAl+tVwINni9XvoTwC+e80Xv1R19D9/bVXLChNcBX2LeY5QOT0/9jxzU=
X-Received: by 2002:a67:c789:: with SMTP id t9mr25809822vsk.60.1629749499174;
 Mon, 23 Aug 2021 13:11:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210304034141.7062-1-brad@pensando.io> <20210304034141.7062-2-brad@pensando.io>
 <CAHp75VcG9KajNpDbewDq7QzotB6t7MfwiGk15FaobX+cmMVSzg@mail.gmail.com>
 <CAK9rFnwrA=W2Vk5yFwG4N_WS=eBXXnhtexA+tqgAYb6xOAO4oQ@mail.gmail.com>
 <CAHp75VdfrJ3JV_gL3xCLHOiw6Tj-5Ep7z5JKWUFKFbUt8gobcw@mail.gmail.com>
 <CAK9rFnx--z_pr_yR6CqGsH04ddwUtx4rxc7MxNNmy7ZSF86+Mg@mail.gmail.com>
 <CAMuHMdUz4vUQzXBHA9AiT3w6L20yBpgd0emVZJb=v_qw70qiJQ@mail.gmail.com> <CAK9rFnw-j8whcsK-NQ4w4+sCdrumCk7Bb=J+KfsF9ZO2Tf5r5g@mail.gmail.com>
In-Reply-To: <CAK9rFnw-j8whcsK-NQ4w4+sCdrumCk7Bb=J+KfsF9ZO2Tf5r5g@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 23 Aug 2021 22:11:27 +0200
Message-ID: <CAMuHMdW0s=x+DBZffeuEcyifDRfy8YM3c_wEAZscO7twR2wj3Q@mail.gmail.com>
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

On Mon, Aug 23, 2021 at 6:31 PM Brad Larson <brad@pensando.io> wrote:
> On Mon, Aug 23, 2021 at 12:50 AM Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> > On Mon, Aug 23, 2021 at 3:14 AM Brad Larson <brad@pensando.io> wrote:
> > > On Mon, Mar 29, 2021 at 3:40 AM Andy Shevchenko
> [...]
> > > Regarding the above module question and Kconfig definition, since I
> > > first looked at this and reviewed the comments I realized I should be
> > > using builtin.  The file gpio/Kconfig is currently this
> > >
> > > config GPIO_ELBA_SPICS
> > >         def_bool y
> > >         depends on ARCH_PENSANDO_ELBA_SOC || COMPILE_TEST
> >
> > That means the driver will default to yes by merely enabling
> > COMPILE_TEST, which is a no-go.
> >
> >     config GPIO_ELBA_SPICS
> >             bool "one-line summary"
> >             depends on ARCH_PENSANDO_ELBA_SOC || COMPILE_TEST
> >             default y if ARCH_PENSANDO_ELBA_SOC
>
> Thanks Geert, changed to this
>
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -241,8 +241,9 @@ config GPIO_EIC_SPRD
>           Say yes here to support Spreadtrum EIC device.
>
>  config GPIO_ELBA_SPICS
> +       bool "Pensando Elba SoC SPI Chip Select as GPIO support"
> +       depends on ARCH_PENSANDO_ELBA_SOC
>         def_bool y
> -       depends on ARCH_PENSANDO_ELBA_SOC || COMPILE_TEST

So we're losing the COMPILE_TEST ability again?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
