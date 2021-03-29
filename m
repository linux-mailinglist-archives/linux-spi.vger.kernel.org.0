Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A95F134CE0C
	for <lists+linux-spi@lfdr.de>; Mon, 29 Mar 2021 12:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232198AbhC2Kkd (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 29 Mar 2021 06:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbhC2KkB (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 29 Mar 2021 06:40:01 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BEC9C061574;
        Mon, 29 Mar 2021 03:40:01 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id e14so4193202plj.2;
        Mon, 29 Mar 2021 03:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v6A8lkGT7qlDfG5OHFA7dTWCjZVRjtLZtjsAR4wx34Y=;
        b=o15S4Oc4W6Wisr5EVArkn/MoM98iA9zt3Z7a9BPfcrkZuwq/IjnGzlwFxOZELQiVxv
         4uP8RbtXTVyaYb7xFT5oVNy8SwZ1kxh8r/wb10klTriK+oztFTTMOMBpohkVP7C0awWK
         Rdqev+mG3mOq1807VMYcQhUGLBlCYwVOGNOYtGNLjGQuIlN0cQ/u4JN3veExuvqD7BDR
         AIIudAb8hzETq6PXf4rrMPyp+X1Sdityk8cED4+ry00dU3ner0HmgunrQ0rAAaduU1ww
         8NESqpfusXX2QDUQJaNYHwCxwaj0G1ggEjsm2j5unfuLQDIF0443zj2tcA0ciPD4D4ES
         c8nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v6A8lkGT7qlDfG5OHFA7dTWCjZVRjtLZtjsAR4wx34Y=;
        b=WUvGL6xE/pHaHH9mqLeI6VT5zG3pWnuRDuXEtbkgLGBJw7qKO9XBCZeiCs7SEHEDVi
         g8gIgcf8rbsfQwHSM20umNKeeQ19+EfyhDKZZOlBnRPn+6nPSlhwkQLtQkXR66VwvVfO
         p1ukoWEBNGk7T3b9pYHfDWUexWA+VmKRVIqvByrVu5vsz78HKRKIY2DkPIz9eWfRGaBj
         i8S7fwNADg4uuBFiWXsEf7PSZkH1FjR2hY58L5zVRON8jVA9FXXtfJzJ/sU4N/237hn+
         feFXq9HTUAPa9wI5gLf5bNi60l6hbGedObzZT8xfWNF7SCLIxfSzZTdwlYnOHQmAhbnY
         D2Fw==
X-Gm-Message-State: AOAM533qmcWbtiGBvLD2e7L5AYhk7XF3eLx7bVg/DL3oGiiJMvjZWxC1
        gJzfUOlOQrJXkNm/zWn0wSi3P8ZcdENSsIRw1gU=
X-Google-Smtp-Source: ABdhPJxMqjp3WRvYACSDA9CGb4Oltl2JpPqKhGqAKCml3IGmC6SV9SabeXywKUP5qljAGJbNZQYUbFqOZS08vWp6gWA=
X-Received: by 2002:a17:90a:b311:: with SMTP id d17mr26467330pjr.228.1617014400860;
 Mon, 29 Mar 2021 03:40:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210304034141.7062-1-brad@pensando.io> <20210304034141.7062-2-brad@pensando.io>
 <CAHp75VcG9KajNpDbewDq7QzotB6t7MfwiGk15FaobX+cmMVSzg@mail.gmail.com> <CAK9rFnwrA=W2Vk5yFwG4N_WS=eBXXnhtexA+tqgAYb6xOAO4oQ@mail.gmail.com>
In-Reply-To: <CAK9rFnwrA=W2Vk5yFwG4N_WS=eBXXnhtexA+tqgAYb6xOAO4oQ@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 29 Mar 2021 13:39:44 +0300
Message-ID: <CAHp75VdfrJ3JV_gL3xCLHOiw6Tj-5Ep7z5JKWUFKFbUt8gobcw@mail.gmail.com>
Subject: Re: [PATCH 1/8] gpio: Add Elba SoC gpio driver for spi cs control
To:     Brad Larson <brad@pensando.io>
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

On Mon, Mar 29, 2021 at 4:19 AM Brad Larson <brad@pensando.io> wrote:
> On Sun, Mar 7, 2021 at 11:21 AM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Thu, Mar 4, 2021 at 4:40 PM Brad Larson <brad@pensando.io> wrote:

...

> > > +config GPIO_ELBA_SPICS
> > > +       bool "Pensando Elba SPI chip-select"
> >
> > Can't it be a module? Why?
>
> All Elba SoC based platforms require this driver to be built-in to boot and
> removing the module would result in a variety of exceptions/errors.

Needs to be at least in the commit message.

> > > +       depends on ARCH_PENSANDO_ELBA_SOC
> > > +       help
> > > +         Say yes here to support the Pensndo Elba SoC SPI chip-select driver
> >
> > Please give more explanation what it is and why users might need it,
> > and also tell users how the module will be named (if there is no
> > strong argument why it can't be a  module).
> >
> Fixed the typo.

Yeah, according to the above, you better elaborate what this module is
and why people would need it.
Also can be a good hint to add
default ARCH_MY_COOL_PLATFORM

...

> > > +#include <linux/of.h>
> >
> > It's not used here, but you missed mod_devicetable.h.
>
> Removed <linux/of.h>.  There is no dependency on mod_devicetable.h.

What do you mean? You don't use data structures from that?
of_device_id or other ID structures are defined there. Your module
works without them?

...

> > > +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > > +       p->base = devm_ioremap_resource(&pdev->dev, res);
> >
> > p->base = devm_platform_ioremap_resource(pdev, 0);
>
> Implementation follows devm_ioremap_resource() example in lib/devres.c.

So? How does this make it impossible to address my comment?

> > > +       if (IS_ERR(p->base)) {
> >
> > > +               dev_err(&pdev->dev, "failed to remap I/O memory\n");
> >
> > Duplicate noisy message.
> >
> > > +               return PTR_ERR(p->base);
> > > +       }

-- 
With Best Regards,
Andy Shevchenko
