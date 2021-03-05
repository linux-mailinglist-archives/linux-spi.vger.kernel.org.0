Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98E0A32ECAC
	for <lists+linux-spi@lfdr.de>; Fri,  5 Mar 2021 14:58:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbhCEN5y (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 5 Mar 2021 08:57:54 -0500
Received: from mail-vs1-f47.google.com ([209.85.217.47]:44872 "EHLO
        mail-vs1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbhCEN5m (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 5 Mar 2021 08:57:42 -0500
Received: by mail-vs1-f47.google.com with SMTP id d25so980988vsr.11;
        Fri, 05 Mar 2021 05:57:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wlv2raXctHckbeXP1zL3FcneicW28YXK69//DrBPOK4=;
        b=tdtJrAcUbrToxEtM2TRpna6tv9k49Qr/0H9WtkYttdTOYj6CN3dp+UB5Ucetd1bKjk
         GXFaYQbbqecZdU35Dvyqv+LmI7fTJVAkFOfUANigRmecnyEsfWelVRKHJheGjYf55dOX
         PyhZ0s2eztf8hwARqLMvAyzOJwMKVw9d+UeNl0bAJaMH217Mu8QL1Z6LABbyY0+T8aiY
         wB+1mN1OaM9tuHaeQPCPbcd8r5DV1yoZyJMDPc6K3Ur7RRZJo6LdqDrgtrubJYN4URE7
         N5LN6zMn26rUYmWpZR/EU8yd5XaIp5Ps1YuFEKL16DvjjxDF6PgeanHcgjoon848MmXo
         DARw==
X-Gm-Message-State: AOAM5308ati/nniXK1f5EIDApuzGNIPgI61n2jMqKf2iZwqWjw3ugosi
        heaaV7AZObceHa+BJl9aotSWN254ZcoSUi933V8=
X-Google-Smtp-Source: ABdhPJw0V2g02eK+sAULP8zrVz/fuz3tVVUfaWr3omUwlkrp6fuCKZw8yaHGFawnjKLWZ05hjvKPz2X/m7/k7/1fOYg=
X-Received: by 2002:a05:6102:2403:: with SMTP id j3mr5822400vsi.40.1614952661682;
 Fri, 05 Mar 2021 05:57:41 -0800 (PST)
MIME-Version: 1.0
References: <20210304034141.7062-1-brad@pensando.io> <20210304034141.7062-2-brad@pensando.io>
In-Reply-To: <20210304034141.7062-2-brad@pensando.io>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 5 Mar 2021 14:57:30 +0100
Message-ID: <CAMuHMdUsFb-qpssVXkxv0gV8qpi6mUNx+3o+ZUhc5UMCKppzrQ@mail.gmail.com>
Subject: Re: [PATCH 1/8] gpio: Add Elba SoC gpio driver for spi cs control
To:     Brad Larson <brad@pensando.io>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
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
        Linux MMC List <linux-mmc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Brad,

On Thu, Mar 4, 2021 at 4:59 AM Brad Larson <brad@pensando.io> wrote:
> This GPIO driver is for the Pensando Elba SoC which
> provides control of four chip selects on two SPI busses.
>
> Signed-off-by: Brad Larson <brad@pensando.io>

Thanks for your patch!

> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -241,6 +241,12 @@ config GPIO_EIC_SPRD
>         help
>           Say yes here to support Spreadtrum EIC device.
>
> +config GPIO_ELBA_SPICS
> +       bool "Pensando Elba SPI chip-select"
> +       depends on ARCH_PENSANDO_ELBA_SOC

Any specific reason this can't be "... || COMPILE_TEST"?

> +       help
> +         Say yes here to support the Pensndo Elba SoC SPI chip-select driver
> +
>  config GPIO_EM
>         tristate "Emma Mobile GPIO"
>         depends on (ARCH_EMEV2 || COMPILE_TEST) && OF_GPIO

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
