Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65F61175F42
	for <lists+linux-spi@lfdr.de>; Mon,  2 Mar 2020 17:12:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbgCBQMk (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 2 Mar 2020 11:12:40 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34317 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727049AbgCBQMk (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 2 Mar 2020 11:12:40 -0500
Received: by mail-ot1-f66.google.com with SMTP id j16so10285685otl.1;
        Mon, 02 Mar 2020 08:12:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IBU1ngp7AZThDbUbO+cKAdOQ9eyjciNaYONj1CU5V7s=;
        b=Us9zSfUJl5C9CRN4cvegRENR/wzVQDIMXSA7wWrhque0TUD2q68OBHFXX7OW50bj1o
         SSdAfmZ47/Lht6W2GDXx7y013dBuK/OtbD/vprh0Hgj0fuea3Tb5Ds2XAltAKCIHJudU
         tysxxQBWAcz+ua38NcC2HQHG3ZsW1iU6L7lBA5MJQ/PjQn005BuRWxh0+He0mQoU8AaP
         K2MQwovpU24MMPg7RTgipWgamdIlI9i9HqE2TyHy1zgp9EsXmd5EOQtsnFiZDBLs+uUR
         nxjaFU8Jv3u/pP0w86OEQCsCFGkpvGovGCTV7qPrrgLMx9jmGKBkPxoenciskDcSONOP
         B3SQ==
X-Gm-Message-State: ANhLgQ3b9KR+klb0ynt1K2v435HpvV0cU2vsGH/Euf2iu5mtJ7uSCPJS
        zV4bIeMEP0iJksE8ycGPNf+czcpyAbNQ6DxeK58=
X-Google-Smtp-Source: ADFU+vvg6cWqaPv6sfkzgh4uXnbYNGWltt0N4bOdGNKjXE/BLlkVjwI45QAekHnzDWDL4MznTQXJzZftVEs/EUTFqwg=
X-Received: by 2002:a05:6830:1e9c:: with SMTP id n28mr623596otr.107.1583165559752;
 Mon, 02 Mar 2020 08:12:39 -0800 (PST)
MIME-Version: 1.0
References: <1582903131-160033-1-git-send-email-john.garry@huawei.com> <1582903131-160033-2-git-send-email-john.garry@huawei.com>
In-Reply-To: <1582903131-160033-2-git-send-email-john.garry@huawei.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 2 Mar 2020 17:12:05 +0100
Message-ID: <CAMuHMdV9v-7eRqi3JjcNaOBpRrC2-gLDCizYOJwhQCjZiLr5dA@mail.gmail.com>
Subject: Re: [PATCH RFC 1/3] spi: Allow SPI controller override device buswidth
To:     John Garry <john.garry@huawei.com>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi John,

Thanks for your patch!

On Fri, Feb 28, 2020 at 4:23 PM John Garry <john.garry@huawei.com> wrote:
> Currently ACPI firmware description for a SPI device does not have any
> method to describe the data buswidth on the board.
>
> So even through the controller and device may support higher modes than
> standard SPI, it cannot be assumed that the board does - as such, that
> device is limited to standard SPI in such a circumstance.

Indeed.

> As a workaround, allow the controller driver supply buswidth override bits,
> which are used inform the core code that the controller driver knows the
> buswidth supported on that board for that device.

I feel this is a bit dangerous, and might bite us one day.

> A host controller driver might know this info from DMI tables, for example.

Can't acpi_register_spi_device() obtain that info from DMI tables,
to avoid contaminating the generic code?

> Signed-off-by: John Garry <john.garry@huawei.com>

> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -510,6 +510,7 @@ struct spi_device *spi_alloc_device(struct spi_controller *ctlr)
>         spi->dev.bus = &spi_bus_type;
>         spi->dev.release = spidev_release;
>         spi->cs_gpio = -ENOENT;
> +       spi->mode = ctlr->buswidth_override_bits;

This could just be moved to acpi_register_spi_device(), right?

>
>         spin_lock_init(&spi->statistics.lock);
>
> @@ -2181,9 +2182,10 @@ static acpi_status acpi_register_spi_device(struct spi_controller *ctlr,
>                 return AE_NO_MEMORY;
>         }
>
> +
>         ACPI_COMPANION_SET(&spi->dev, adev);
>         spi->max_speed_hz       = lookup.max_speed_hz;
> -       spi->mode               = lookup.mode;
> +       spi->mode               |= lookup.mode;
>         spi->irq                = lookup.irq;
>         spi->bits_per_word      = lookup.bits_per_word;
>         spi->chip_select        = lookup.chip_select;
> diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
> index 6d16ba01ff5a..600e3793303e 100644
> --- a/include/linux/spi/spi.h
> +++ b/include/linux/spi/spi.h
> @@ -481,6 +481,9 @@ struct spi_controller {
>         /* spi_device.mode flags understood by this controller driver */
>         u32                     mode_bits;
>
> +       /* spi_device.mode flags override flags for this controller */
> +       u32                     buswidth_override_bits;

And I'd be happy if we could avoid adding this here ;-)

> +
>         /* bitmask of supported bits_per_word for transfers */
>         u32                     bits_per_word_mask;
>  #define SPI_BPW_MASK(bits) BIT((bits) - 1)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
