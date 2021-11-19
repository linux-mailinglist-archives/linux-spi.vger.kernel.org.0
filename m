Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13DB8456B55
	for <lists+linux-spi@lfdr.de>; Fri, 19 Nov 2021 09:10:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbhKSINQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 19 Nov 2021 03:13:16 -0500
Received: from mail-ua1-f47.google.com ([209.85.222.47]:41727 "EHLO
        mail-ua1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbhKSINP (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 19 Nov 2021 03:13:15 -0500
Received: by mail-ua1-f47.google.com with SMTP id p37so19570940uae.8;
        Fri, 19 Nov 2021 00:10:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J1gDAcCkc8fWxiWhAvxS3kef+UAmFirMbL8DQWh2ZXo=;
        b=6yKuA/7QzeHKpDPkvHZY4e32i2mYRqhHua48sffG2O1nTbysq2/f0pVV4NVUoQk8lC
         cKxd+0NUnrbtY9cYq3Jb4UZtvFspTgCOMiqNuDuYOy1pfI/On3vu4eVv2GVjBx+WFwJu
         WmGDzALzoT2/c7yZumMgUb9Uyz0JIegtJ8HWYTiDqv+34/VW3A4Qzxea6xv08h5f7TG0
         usQmSNEqqDCl7GnP50A3xLWialFVQZkWwlt1+Y4xGhhWUzKAvaI2VHBHCVW/aP6IdYwP
         t9PwqkmHHRATwDnweaw5wjzoH6oNoRJGa09CuJ0LIfsqUjzGIeMvmroBVnv+sjebnvoJ
         kzLQ==
X-Gm-Message-State: AOAM530FjZarJbAfXm9IYOR0YuuYZYehzLIIo6cIXRfUTXkzvboE2AgL
        ciO1EwbrP14hXdct/Lz4FuhE8yynM9gUMg==
X-Google-Smtp-Source: ABdhPJxmuz/3FMleHdMIvsp4K6E8/bRmk8Hznl1NhrxlYfgZNa5MGK4RNS9TFDYBpX0lDiTWyDttfg==
X-Received: by 2002:a67:c38f:: with SMTP id s15mr91083018vsj.50.1637309413917;
        Fri, 19 Nov 2021 00:10:13 -0800 (PST)
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com. [209.85.222.47])
        by smtp.gmail.com with ESMTPSA id f7sm1260866vkm.31.2021.11.19.00.10.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Nov 2021 00:10:13 -0800 (PST)
Received: by mail-ua1-f47.google.com with SMTP id n6so19673146uak.1;
        Fri, 19 Nov 2021 00:10:13 -0800 (PST)
X-Received: by 2002:a05:6102:e82:: with SMTP id l2mr91057734vst.37.1637309413223;
 Fri, 19 Nov 2021 00:10:13 -0800 (PST)
MIME-Version: 1.0
References: <20211118213143.2345041-1-javierm@redhat.com>
In-Reply-To: <20211118213143.2345041-1-javierm@redhat.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 19 Nov 2021 09:10:01 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVcsfE6TZbu8SJZP7CNKyjwBZdBiN0nDRQCibaGgpLF0g@mail.gmail.com>
Message-ID: <CAMuHMdVcsfE6TZbu8SJZP7CNKyjwBZdBiN0nDRQCibaGgpLF0g@mail.gmail.com>
Subject: Re: [PATCH] spi: docs: improve the SPI userspace API documentation
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        linux-spi <linux-spi@vger.kernel.org>,
        Ralph Siemsen <ralph.siemsen@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Javier,

On Thu, Nov 18, 2021 at 10:32 PM Javier Martinez Canillas
<javierm@redhat.com> wrote:
> This doc is fairly outdated and only uses legacy device instantiation
> terminology. Let us update it and also mention the OF and ACPI device
> tables, to make easier for users to figure out how should be defined.
>
> Also, mention that devices bind could be done in user-space now using
> the "driver_override" sysfs entry.
>
> Suggested-by: Ralph Siemsen <ralph.siemsen@linaro.org>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>

Thanks for your patch!

> --- a/Documentation/spi/spidev.rst
> +++ b/Documentation/spi/spidev.rst
> @@ -29,15 +29,39 @@ of the driver stack) that are not accessible to userspace.
>
>  DEVICE CREATION, DRIVER BINDING
>  ===============================
> -The simplest way to arrange to use this driver is to just list it in the
> -spi_board_info for a device as the driver it should use:  the "modalias"
> -entry is "spidev", matching the name of the driver exposing this API.
> +
> +The spidev driver contains lists of SPI devices that are supported for
> +the different hardware topology representations.
> +
> +The following are the SPI device tables supported by the spidev driver:
> +
> +    - struct spi_device_id spidev_spi_ids[]: list of devices that can be
> +      bound when these are defined using a struct spi_board_info with a
> +      .modalias field matching one of the entries in the table.
> +
> +    - struct of_device_id spidev_dt_ids[]: list of devices that can be
> +      bound when these are defined using a Device Tree node that has a
> +      compatible string matching one of the entries in the table.
> +
> +    - struct acpi_device_id spidev_acpi_ids[]: list of devices that can
> +      be bound when these are defined using a ACPI device object with a
> +      _HID matching one of the entries in the table.
> +
> +NOTE: it used to be supported to define an SPI device using the "spidev"
> +      name.  For example as .modalias = "spidev" or compatible = "spidev".
> +      But this is no longer supported by the Linux kernel and instead a
> +      real SPI device name as listed in one of the tables should be used.

This reads as the tables are fixed.
Perhaps add

    You are encouraged to add an entry for your SPI device name to
     one of the tables.

> +
>  Set up the other device characteristics (bits per word, SPI clocking,
>  chipselect polarity, etc) as usual, so you won't always need to override
>  them later.
>
> -(Sysfs also supports userspace driven binding/unbinding of drivers to
> -devices.  That mechanism might be supported here in the future.)
> +Sysfs also supports userspace driven binding/unbinding of drivers to
> +devices.  The mechanism works by writing to the device "driver_overrride"
> +entry.  For example:
> +
> +    echo spidev > /sys/bus/spi/devices/spiX.Y/driver_override
> +    echo spiB.C > /sys/bus/spi/drivers/spidev/bind
>
>  When you do that, the sysfs node for the SPI device will include a child
>  device node with a "dev" attribute that will be understood by udev or mdev.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
