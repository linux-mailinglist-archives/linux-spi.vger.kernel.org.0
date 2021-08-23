Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CCAB3F4608
	for <lists+linux-spi@lfdr.de>; Mon, 23 Aug 2021 09:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235300AbhHWHvt (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 23 Aug 2021 03:51:49 -0400
Received: from mail-vs1-f44.google.com ([209.85.217.44]:39760 "EHLO
        mail-vs1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235247AbhHWHvS (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 23 Aug 2021 03:51:18 -0400
Received: by mail-vs1-f44.google.com with SMTP id e9so10495974vst.6;
        Mon, 23 Aug 2021 00:50:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ho3P9pBdgd42CBBqO6PTExhHf40DO+XVUYi0PLvvDcU=;
        b=Tnr5p0YBYnazRD2Ux+8Z2KBq+evjNl1zJuA/CLqhtId2E1EsGsU53PVzpnbCmJuQ8g
         G7UmJR4V+rAxpuSPB9HbIKLj00kLPtTgYX0Dldm09OzfxQso8IhZP4wwon19QEgrrEcS
         IrrkkAskDUNn+ACgpzJBitW0Ln4f2w+XvGyA8ow70mHdRZe1JkiClOI1kN/nTDdkjQcy
         RPTh/jlT2CSKe/Yfp9SGZ5Lln92NW8H5kIuckj4oVt/1MOSDx3+lazEtLHztSvDtp6c8
         WBySiYp+1xryhz1DdwyI3OmauFZE1JuthS8J//8XBwFDk67S+biRlgcpkHI/IMCECuu6
         Pmxg==
X-Gm-Message-State: AOAM530kFAY5SquwExfPqv87d8vYJlvHiOrUOm7UNGxkoBpAUK/l76Jt
        DR6KoY5T7w+8+m/rP1w/TUwBjwZQOcTXKlY3WbQ=
X-Google-Smtp-Source: ABdhPJwnddl0CNzxKVNjXlZCRb2Igz6ludKlJHQ+IsyXtT1SETsb4n8hdAEokGACKnU9D507Yh2RQoDqVqVaLusqNtA=
X-Received: by 2002:a67:c789:: with SMTP id t9mr23194381vsk.60.1629705028211;
 Mon, 23 Aug 2021 00:50:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210304034141.7062-1-brad@pensando.io> <20210304034141.7062-2-brad@pensando.io>
 <CAHp75VcG9KajNpDbewDq7QzotB6t7MfwiGk15FaobX+cmMVSzg@mail.gmail.com>
 <CAK9rFnwrA=W2Vk5yFwG4N_WS=eBXXnhtexA+tqgAYb6xOAO4oQ@mail.gmail.com>
 <CAHp75VdfrJ3JV_gL3xCLHOiw6Tj-5Ep7z5JKWUFKFbUt8gobcw@mail.gmail.com> <CAK9rFnx--z_pr_yR6CqGsH04ddwUtx4rxc7MxNNmy7ZSF86+Mg@mail.gmail.com>
In-Reply-To: <CAK9rFnx--z_pr_yR6CqGsH04ddwUtx4rxc7MxNNmy7ZSF86+Mg@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 23 Aug 2021 09:50:16 +0200
Message-ID: <CAMuHMdUz4vUQzXBHA9AiT3w6L20yBpgd0emVZJb=v_qw70qiJQ@mail.gmail.com>
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

On Mon, Aug 23, 2021 at 3:14 AM Brad Larson <brad@pensando.io> wrote:
> On Mon, Mar 29, 2021 at 3:40 AM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> >
> > On Mon, Mar 29, 2021 at 4:19 AM Brad Larson <brad@pensando.io> wrote:
> > > On Sun, Mar 7, 2021 at 11:21 AM Andy Shevchenko
> > > <andy.shevchenko@gmail.com> wrote:
> > > > On Thu, Mar 4, 2021 at 4:40 PM Brad Larson <brad@pensando.io> wrote:
> >
> > ...
> >
> > > > > +config GPIO_ELBA_SPICS
> > > > > +       bool "Pensando Elba SPI chip-select"
> > > >
> > > > Can't it be a module? Why?
> > >
> > > All Elba SoC based platforms require this driver to be built-in to boot and
> > > removing the module would result in a variety of exceptions/errors.
> >
> > Needs to be at least in the commit message.
> >
> > > > > +       depends on ARCH_PENSANDO_ELBA_SOC
> > > > > +       help
> > > > > +         Say yes here to support the Pensndo Elba SoC SPI chip-select driver

Pensando

> > > >
> > > > Please give more explanation what it is and why users might need it,
> > > > and also tell users how the module will be named (if there is no
> > > > strong argument why it can't be a  module).
> > > >
> > > Fixed the typo.
> >
> > Yeah, according to the above, you better elaborate what this module is
> > and why people would need it.
> > Also can be a good hint to add
> > default ARCH_MY_COOL_PLATFORM
>
> Regarding the above module question and Kconfig definition, since I
> first looked at this and reviewed the comments I realized I should be
> using builtin.  The file gpio/Kconfig is currently this
>
> config GPIO_ELBA_SPICS
>         def_bool y
>         depends on ARCH_PENSANDO_ELBA_SOC || COMPILE_TEST

That means the driver will default to yes by merely enabling
COMPILE_TEST, which is a no-go.

    config GPIO_ELBA_SPICS
            bool "one-line summary"
            depends on ARCH_PENSANDO_ELBA_SOC || COMPILE_TEST
            default y if ARCH_PENSANDO_ELBA_SOC

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
