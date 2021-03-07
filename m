Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB3933043A
	for <lists+linux-spi@lfdr.de>; Sun,  7 Mar 2021 20:22:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232470AbhCGTVa (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 7 Mar 2021 14:21:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232699AbhCGTV2 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 7 Mar 2021 14:21:28 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B75C06174A;
        Sun,  7 Mar 2021 11:21:28 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id kk2-20020a17090b4a02b02900c777aa746fso1873517pjb.3;
        Sun, 07 Mar 2021 11:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UkeqWC55kJTV4Yb9Tbs1HqONBSiHbCRhWpmLfHihoSk=;
        b=EeIzKRdRUihhcdRzRr+axK8QStgSjGHyFURcDfeFYRBhRlBGg9kgYkVk+ZoHJZ9bn2
         sesPp1vse80DR6bfp4h3fw/SIwk6NuJ8SlnqTmRkxzv1FVfhB/p8UhaJlG0qk/hRrCcN
         GXlvv5UwEy38zscq8MnY2ej8fDIYzxVc2C90czxmDcvlANe7Y4rE4gfcpdkSNxCiO63n
         fne0bEFNsUHsiIC4PR5q6fZn0WGqG+JOBnfyUjr9tqqPMcr/q52vnoPXz9ThpG5J5+j8
         /FoRnsDHYZb3K7PDWQauAipHQ4UZO2Wem0ea8pdOp3k5ObU/qcBJXLo/582Cs83QP5CO
         rxQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UkeqWC55kJTV4Yb9Tbs1HqONBSiHbCRhWpmLfHihoSk=;
        b=Dm4JpJrt99sNgUn6H5clqStVaqIzOk7SW/1rgMiLwchROONKRklALpM15pk/94RIdo
         d9c9QtaTzSmPwhiXWBtUgkvMOsxfBTXurrAbFGEZLWtExIEOGIO+k8Xz3lKHg2Moc7qO
         S0kNH9BIRAJRCeR+W2ZSZkuCydealZYRB0l83zyM/qxLXo476tKREO5jIW1vKlS37/aN
         OI8/de3iLqH3KY+YmSq/FwVjNthrU3KLuG1lPrAYwetR+OZiLZLobHU54k8/vfXSImlp
         lNQoMnYgt0BjipntUDtzcQIgQlbA91QhSAAN1X5alAqeiepC/OKm8Wbh0VfmmtYXEBmc
         3J6g==
X-Gm-Message-State: AOAM532fTOGCodgn8pHnvYCV2XsHpVC0l2vzpWg4czSuZbmEQg10bGcg
        bV5I2En0U0qEMSnAShdrpTgMo23E9aW1U8ly81M=
X-Google-Smtp-Source: ABdhPJzatndY+CjO/QtMpVyVcD6ehTMkJVOZqLV3GXbFqCesKeMlUivTQ42umZ2KmyyjRuFLXdTptqERX51VRJhCJaw=
X-Received: by 2002:a17:90a:c84:: with SMTP id v4mr21390102pja.228.1615144887522;
 Sun, 07 Mar 2021 11:21:27 -0800 (PST)
MIME-Version: 1.0
References: <20210304034141.7062-1-brad@pensando.io> <20210304034141.7062-2-brad@pensando.io>
In-Reply-To: <20210304034141.7062-2-brad@pensando.io>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 7 Mar 2021 21:21:11 +0200
Message-ID: <CAHp75VcG9KajNpDbewDq7QzotB6t7MfwiGk15FaobX+cmMVSzg@mail.gmail.com>
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

On Thu, Mar 4, 2021 at 4:40 PM Brad Larson <brad@pensando.io> wrote:
>
> This GPIO driver is for the Pensando Elba SoC which
> provides control of four chip selects on two SPI busses.

I will try to avoid repeating otheris in their reviews, but my comments below.

...

> +config GPIO_ELBA_SPICS
> +       bool "Pensando Elba SPI chip-select"

Can't it be a module? Why?

> +       depends on ARCH_PENSANDO_ELBA_SOC
> +       help
> +         Say yes here to support the Pensndo Elba SoC SPI chip-select driver

Please give more explanation what it is and why users might need it,
and also tell users how the module will be named (if there is no
strong argument why it can't be a  module).

...

> +#include <linux/of.h>

It's not used here, but you missed mod_devicetable.h.

...

> +/*
> + * pin:             3            2        |       1            0
> + * bit:         7------6------5------4----|---3------2------1------0
> + *     cs1  cs1_ovr  cs0  cs0_ovr |  cs1  cs1_ovr  cs0  cs0_ovr
> + *                ssi1            |             ssi0
> + */
> +#define SPICS_PIN_SHIFT(pin)   (2 * (pin))
> +#define SPICS_MASK(pin)                (0x3 << SPICS_PIN_SHIFT(pin))

> +#define SPICS_SET(pin, val)    ((((val) << 1) | 0x1) << SPICS_PIN_SHIFT(pin))

Isn't it easier to define as ((value) << (2 * (pin) + 1) | BIT(2 * (pin)))

...

> +struct elba_spics_priv {
> +       void __iomem *base;
> +       spinlock_t lock;

> +       struct gpio_chip chip;

If you put it as a first member a container_of() becomes a no-op. OTOH
dunno if there is any such container_of() use in the code.

> +};

...

> +static int elba_spics_get_value(struct gpio_chip *chip, unsigned int pin)
> +{
> +       return -ENXIO;

Hmm... Is it really acceptable error code here?

> +}
...

> +static int elba_spics_direction_input(struct gpio_chip *chip, unsigned int pin)
> +{
> +       return -ENXIO;

Ditto.

> +}

...

> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       p->base = devm_ioremap_resource(&pdev->dev, res);

p->base = devm_platform_ioremap_resource(pdev, 0);

> +       if (IS_ERR(p->base)) {

> +               dev_err(&pdev->dev, "failed to remap I/O memory\n");

Duplicate noisy message.

> +               return PTR_ERR(p->base);
> +       }

> +       ret = devm_gpiochip_add_data(&pdev->dev, &p->chip, p);
> +       if (ret) {
> +               dev_err(&pdev->dev, "unable to add gpio chip\n");

> +               return ret;
> +       }
> +
> +       dev_info(&pdev->dev, "elba spics registered\n");
> +       return 0;

if (ret)
  dev_err(...);
return ret;

> +}

-- 
With Best Regards,
Andy Shevchenko
