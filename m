Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C51F43F42DC
	for <lists+linux-spi@lfdr.de>; Mon, 23 Aug 2021 03:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234497AbhHWBOo (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 22 Aug 2021 21:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234383AbhHWBOo (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 22 Aug 2021 21:14:44 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D129C061757
        for <linux-spi@vger.kernel.org>; Sun, 22 Aug 2021 18:14:02 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id lc21so1030826ejc.7
        for <linux-spi@vger.kernel.org>; Sun, 22 Aug 2021 18:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L2x6wvetmC+m3UtkL6g+zeogyV7VcFydZqaTYT0Kj0E=;
        b=f6WZ0aMYqLMnLSFNcuxgKdLhyI7/W0P27ao7SR9Kc+qqodcoakQ85WKGOafWNzUXMd
         h2WG+KWDZ0UHdOmJAhErULZrM5xIKaRGgqGDeEuAF+40+yVN7wbf84SQzPf+zgjoV/k+
         bkTvLJD2KnYD7sGZmfRxYe+iiq93N0cL8DFnhLLjWpmfslVf0Mhae59Dwnanex0R2wiv
         EbkGZ9pgt5zl8JjmkCLuJEVGLU1eb9VsjwXg1vwTIxZkZsX6ZBolUVi+bT3jUYAupleK
         ur5PBioCl8pOrWnNJ8cRo3cHYOcxgj6ytr8C2kVuxdkAR0gxsQyV9X7H3KnBYVcsRvbN
         wpNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L2x6wvetmC+m3UtkL6g+zeogyV7VcFydZqaTYT0Kj0E=;
        b=kszBYeVNvrvNIQecpgQ/VQLstf75MRZ0Upfn1C3hWHSrNAsinZfUslpKq42wJQe654
         a1MZAgVIiKL2b5ajYubPANL1CvBbrkHkiI0tEjGE+Y0Umt1RiNr0JPB5l1+T4UvOQJ2M
         QuCJeH9h5LhOvVowKxDXEAv2Q2LF0QIbHniNEnJSZsP29T6vBkuCfSp/8UAxc/hAuxji
         qDxcJnipbVEi9xzw6UPggYb4cwFT3kwuqT6FzcfdvVFTsfSUWoIQsa4zoLG7Eaclzj3R
         lXwDzGBjGjxN/ppPegG4knXYxRg9stpWSmxZrTQliPuYW6es63glAX8bc8OPXaH0We7X
         AgkA==
X-Gm-Message-State: AOAM533J21UJ/bY6ZEvbl9nA9N0ajPE+KxzZiazA7TxWxQ8Z1DtBRFSq
        rK7CwQdtWh3f0F73oNa+YBX+8wc6e9d8aBZGhl6RNQ==
X-Google-Smtp-Source: ABdhPJx/ilGFoEBONN+wOqzr/Rs2Jbpamch8GsxeU1GPLtfMrCOMPkXfFgX7Vkr74BvouHL25Sh1oxDmLMtRialHZx4=
X-Received: by 2002:a17:906:38c8:: with SMTP id r8mr33459917ejd.172.1629681240780;
 Sun, 22 Aug 2021 18:14:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210304034141.7062-1-brad@pensando.io> <20210304034141.7062-2-brad@pensando.io>
 <CAHp75VcG9KajNpDbewDq7QzotB6t7MfwiGk15FaobX+cmMVSzg@mail.gmail.com>
 <CAK9rFnwrA=W2Vk5yFwG4N_WS=eBXXnhtexA+tqgAYb6xOAO4oQ@mail.gmail.com> <CAHp75VdfrJ3JV_gL3xCLHOiw6Tj-5Ep7z5JKWUFKFbUt8gobcw@mail.gmail.com>
In-Reply-To: <CAHp75VdfrJ3JV_gL3xCLHOiw6Tj-5Ep7z5JKWUFKFbUt8gobcw@mail.gmail.com>
From:   Brad Larson <brad@pensando.io>
Date:   Sun, 22 Aug 2021 18:13:50 -0700
Message-ID: <CAK9rFnx--z_pr_yR6CqGsH04ddwUtx4rxc7MxNNmy7ZSF86+Mg@mail.gmail.com>
Subject: Re: [PATCH 1/8] gpio: Add Elba SoC gpio driver for spi cs control
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
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

Hi Andy,

On Mon, Mar 29, 2021 at 3:40 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Mon, Mar 29, 2021 at 4:19 AM Brad Larson <brad@pensando.io> wrote:
> > On Sun, Mar 7, 2021 at 11:21 AM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > > On Thu, Mar 4, 2021 at 4:40 PM Brad Larson <brad@pensando.io> wrote:
>
> ...
>
> > > > +config GPIO_ELBA_SPICS
> > > > +       bool "Pensando Elba SPI chip-select"
> > >
> > > Can't it be a module? Why?
> >
> > All Elba SoC based platforms require this driver to be built-in to boot and
> > removing the module would result in a variety of exceptions/errors.
>
> Needs to be at least in the commit message.
>
>
>
> > > > +       depends on ARCH_PENSANDO_ELBA_SOC
> > > > +       help
> > > > +         Say yes here to support the Pensndo Elba SoC SPI chip-select driver
> > >
> > > Please give more explanation what it is and why users might need it,
> > > and also tell users how the module will be named (if there is no
> > > strong argument why it can't be a  module).
> > >
> > Fixed the typo.
>
> Yeah, according to the above, you better elaborate what this module is
> and why people would need it.
> Also can be a good hint to add
> default ARCH_MY_COOL_PLATFORM

Regarding the above module question and Kconfig definition, since I
first looked at this and reviewed the comments I realized I should be
using builtin.  The file gpio/Kconfig is currently this

config GPIO_ELBA_SPICS
        def_bool y
        depends on ARCH_PENSANDO_ELBA_SOC || COMPILE_TEST

> ...
>
> > > > +#include <linux/of.h>
> > >
> > > It's not used here, but you missed mod_devicetable.h.
> >
> > Removed <linux/of.h>.  There is no dependency on mod_devicetable.h.
>
> What do you mean? You don't use data structures from that?
> of_device_id or other ID structures are defined there. Your module
> works without them?
>
I typed the wrong filename.  I do still have <linux/of.h>

> > > > +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > > > +       p->base = devm_ioremap_resource(&pdev->dev, res);
> > >
> > > p->base = devm_platform_ioremap_resource(pdev, 0);
> >
> > Implementation follows devm_ioremap_resource() example in lib/devres.c.
>
> So? How does this make it impossible to address my comment?

I was simply stating that I followed the recommended API per the
source code although I don't recall if I was looking at 4.14, 5.10 or
linux-next at the time.  Changed to using
devm_platform_ioremap_resource().

> > > > +       if (IS_ERR(p->base)) {
> > >
> > > > +               dev_err(&pdev->dev, "failed to remap I/O memory\n");
> > >
> > > Duplicate noisy message.
> > >
> > > > +               return PTR_ERR(p->base);
> > > > +       }

Yep, I've removed the extraneous log message.

Regards,
Brad
