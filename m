Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCAA92C6799
	for <lists+linux-spi@lfdr.de>; Fri, 27 Nov 2020 15:13:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730815AbgK0OME (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 27 Nov 2020 09:12:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730393AbgK0OME (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 27 Nov 2020 09:12:04 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45412C0613D1;
        Fri, 27 Nov 2020 06:12:04 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id t3so4429171pgi.11;
        Fri, 27 Nov 2020 06:12:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=thEI5TlbSvSoaCh8wwqL+CLGgAjmzWPp9dwbcmScx2s=;
        b=JqBFDUjSj9NA37E3AUvc0WkPF4MNRLnHL1PdMsDQPq03vfRv8em77dlRNZItLe3z6H
         ALcDpC5n45LDMTYz7DAXBPuMH3tKsryVX6wm7zMy2X6t+cQmN1OEUCtfWwVDGUSEFS6e
         JvZXFBfhiMSBu+R4NNpayy5A0d+pvjjTtItEKaclXIDSDXTzGQru/a84VZYvZ7jYdxgp
         D1IWU/Ly6ARFmIVuprLIHlRIe/Lohr+DCRScV4aXf+c3w+dXYW405JtzafgybtHK7iE0
         vdeDB5QU1g5ghfQ93n9srCzjbNBKmVwv/uUVhIK92I3OcIwVyQ1kNdMEwzlcvnadvtcC
         IQtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=thEI5TlbSvSoaCh8wwqL+CLGgAjmzWPp9dwbcmScx2s=;
        b=Sq/WNjhLNSwL7gLvuilB5riRB/azPWM7OOkeUCv7y8Nn60SYnob1S4zrTmbhhf4lDR
         XaYOHwYhZUYV5oFmMD7OZlHSKp96rY9JRw3OMgzUcuSkw6N/OXgzH5V/WGeljXGx3PTi
         e9yO782T6g3WEx41WrfqBZVvIkzBPs5qmJTvGy9F+YFDUhpxk5NDJIxN10WMphkoORxD
         IJTF8hJDJp870ajwUE1qEq41D8m6YOfCr3NkVXlDW2cV5YfyHY0gNIx8YjM5JLn2jgE7
         RRP+oPgXTUWYAQKWnphuY1CUwirrmukjK9duxxH4eYMSlc53sFY7qF9mY3YqQer31jTy
         pucg==
X-Gm-Message-State: AOAM5321vw1BhPGw+u25zvMYN+0IFzmCS27UnCGuAv88apYXFqT0x5S/
        cyDKdppJ26r3oyL+bcdxumZu+yiSIux1xuXP144=
X-Google-Smtp-Source: ABdhPJwNOvaD6rNl53GPgGkHBCQBWxkJBbs7OvfxviLpeNWkte3BkUyzxABD/Lf2TEOfBaaFmuZqAfozIvq5GF7YgDc=
X-Received: by 2002:a63:8f1b:: with SMTP id n27mr6756219pgd.74.1606486323651;
 Fri, 27 Nov 2020 06:12:03 -0800 (PST)
MIME-Version: 1.0
References: <20201127130834.136348-1-alexandru.ardelean@analog.com>
In-Reply-To: <20201127130834.136348-1-alexandru.ardelean@analog.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 27 Nov 2020 16:12:52 +0200
Message-ID: <CAHp75VeSS+-m=V59Z36n2maGtu499UwuKk=t9VB=JwqqvO=Qaw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] spi: uapi: unify SPI modes into a single spi.h header
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     linux-spi <linux-spi@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        "Bogdan, Dragos" <dragos.bogdan@analog.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Nov 27, 2020 at 3:08 PM Alexandru Ardelean
<alexandru.ardelean@analog.com> wrote:
>
> This change moves all the SPI mode bits into a separate 'spi.h' header in
> uapi. This is meant to re-use these definitions inside the kernel as well
> as export them to userspace (via uapi).

uapi -> UAPI (or uAPI) here and everywhere else where it makes sense.

> The SPI mode definitions have usually been duplicated between between
> 'include/linux/spi/spi.h' and 'include/uapi/linux/spi/spidev.h', so
> whenever adding a new entry, this would need to be put in both headers.
>
> They've been moved from 'include/linux/spi/spi.h', since that seems a bit
> more complete; the bits have descriptions and there is the SPI_MODE_X_MASK.
>
> For now, this change does a simple move; no conversions to BIT() macros are
> being done at this point. This can be done later, as that requires also
> another header inclusion (the 'const.h' header).
> The change as-is makes this 'spi.h' header more standalone.
>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
>
> Personally, I am not sure whether to convert the bitfield tos _BITUL()
> macros or not. I feel that not-having these macros makes this uapi spi.h
> header more standalone.
> If there's a strong insistence to use those _BITUL() macros, I'll do it.
> I'm hesitant now, because it requires that this spi.h includes the
> 'const.h' header.

_BITUL is a part of uAPI, why not to use it?
In general BIT() type of macros makes values easier to read and less
error prone (in big numbers it's easy to miss 0).
It's not a strong opinion, it's just the rationale behind how I see it.

> Changelog v2 -> v3:
> * https://lore.kernel.org/linux-spi/20201124102152.16548-1-alexandru.ardelean@analog.com/
> * dropped 'spi: convert to BIT() all spi_device flags '
>   added 'spi: uapi: unify SPI modes into a single spi.h header'
>
>  include/linux/spi/spi.h         | 22 +--------------
>  include/uapi/linux/spi/spi.h    | 47 +++++++++++++++++++++++++++++++++
>  include/uapi/linux/spi/spidev.h | 30 +--------------------
>  3 files changed, 49 insertions(+), 50 deletions(-)
>  create mode 100644 include/uapi/linux/spi/spi.h
>
> diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
> index aa09fdc8042d..a4fedb33d34b 100644
> --- a/include/linux/spi/spi.h
> +++ b/include/linux/spi/spi.h
> @@ -14,6 +14,7 @@
>  #include <linux/scatterlist.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/ptp_clock_kernel.h>
> +#include <uapi/linux/spi/spi.h>
>
>  struct dma_chan;
>  struct property_entry;
> @@ -165,27 +166,6 @@ struct spi_device {
>         u8                      bits_per_word;
>         bool                    rt;
>         u32                     mode;
> -#define        SPI_CPHA        0x01                    /* clock phase */
> -#define        SPI_CPOL        0x02                    /* clock polarity */
> -#define        SPI_MODE_0      (0|0)                   /* (original MicroWire) */
> -#define        SPI_MODE_1      (0|SPI_CPHA)
> -#define        SPI_MODE_2      (SPI_CPOL|0)
> -#define        SPI_MODE_3      (SPI_CPOL|SPI_CPHA)
> -#define        SPI_MODE_X_MASK (SPI_CPOL|SPI_CPHA)
> -#define        SPI_CS_HIGH     0x04                    /* chipselect active high? */
> -#define        SPI_LSB_FIRST   0x08                    /* per-word bits-on-wire */
> -#define        SPI_3WIRE       0x10                    /* SI/SO signals shared */
> -#define        SPI_LOOP        0x20                    /* loopback mode */
> -#define        SPI_NO_CS       0x40                    /* 1 dev/bus, no chipselect */
> -#define        SPI_READY       0x80                    /* slave pulls low to pause */
> -#define        SPI_TX_DUAL     0x100                   /* transmit with 2 wires */
> -#define        SPI_TX_QUAD     0x200                   /* transmit with 4 wires */
> -#define        SPI_RX_DUAL     0x400                   /* receive with 2 wires */
> -#define        SPI_RX_QUAD     0x800                   /* receive with 4 wires */
> -#define        SPI_CS_WORD     0x1000                  /* toggle cs after each word */
> -#define        SPI_TX_OCTAL    0x2000                  /* transmit with 8 wires */
> -#define        SPI_RX_OCTAL    0x4000                  /* receive with 8 wires */
> -#define        SPI_3WIRE_HIZ   0x8000                  /* high impedance turnaround */
>         int                     irq;
>         void                    *controller_state;
>         void                    *controller_data;
> diff --git a/include/uapi/linux/spi/spi.h b/include/uapi/linux/spi/spi.h
> new file mode 100644
> index 000000000000..ae028d64c779
> --- /dev/null
> +++ b/include/uapi/linux/spi/spi.h
> @@ -0,0 +1,47 @@
> +/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
> +/*
> + * include/linux/spi/spi.h
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> +  */

Do we still need this boilerplate license header?

> +
> +#ifndef _UAPI_SPI_H
> +#define _UAPI_SPI_H
> +
> +#define        SPI_CPHA                0x01            /* clock phase */
> +#define        SPI_CPOL                0x02            /* clock polarity */
> +
> +#define        SPI_MODE_0              (0|0)           /* (original MicroWire) */
> +#define        SPI_MODE_1              (0|SPI_CPHA)
> +#define        SPI_MODE_2              (SPI_CPOL|0)
> +#define        SPI_MODE_3              (SPI_CPOL|SPI_CPHA)
> +#define        SPI_MODE_X_MASK         (SPI_CPOL|SPI_CPHA)
> +
> +#define        SPI_CS_HIGH             0x04            /* chipselect active high? */
> +#define        SPI_LSB_FIRST           0x08            /* per-word bits-on-wire */
> +#define        SPI_3WIRE               0x10            /* SI/SO signals shared */
> +#define        SPI_LOOP                0x20            /* loopback mode */
> +#define        SPI_NO_CS               0x40            /* 1 dev/bus, no chipselect */
> +#define        SPI_READY               0x80            /* slave pulls low to pause */
> +#define        SPI_TX_DUAL             0x100           /* transmit with 2 wires */
> +#define        SPI_TX_QUAD             0x200           /* transmit with 4 wires */
> +#define        SPI_RX_DUAL             0x400           /* receive with 2 wires */
> +#define        SPI_RX_QUAD             0x800           /* receive with 4 wires */
> +#define        SPI_CS_WORD             0x1000          /* toggle cs after each word */
> +#define        SPI_TX_OCTAL            0x2000          /* transmit with 8 wires */
> +#define        SPI_RX_OCTAL            0x4000          /* receive with 8 wires */
> +#define        SPI_3WIRE_HIZ           0x8000          /* high impedance turnaround */
> +
> +#endif /* _UAPI_SPI_H */
> diff --git a/include/uapi/linux/spi/spidev.h b/include/uapi/linux/spi/spidev.h
> index d56427c0b3e0..0c3da08f2aff 100644
> --- a/include/uapi/linux/spi/spidev.h
> +++ b/include/uapi/linux/spi/spidev.h
> @@ -25,35 +25,7 @@
>
>  #include <linux/types.h>
>  #include <linux/ioctl.h>
> -
> -/* User space versions of kernel symbols for SPI clocking modes,
> - * matching <linux/spi/spi.h>
> - */
> -
> -#define SPI_CPHA               0x01
> -#define SPI_CPOL               0x02
> -
> -#define SPI_MODE_0             (0|0)
> -#define SPI_MODE_1             (0|SPI_CPHA)
> -#define SPI_MODE_2             (SPI_CPOL|0)
> -#define SPI_MODE_3             (SPI_CPOL|SPI_CPHA)
> -
> -#define SPI_CS_HIGH            0x04
> -#define SPI_LSB_FIRST          0x08
> -#define SPI_3WIRE              0x10
> -#define SPI_LOOP               0x20
> -#define SPI_NO_CS              0x40
> -#define SPI_READY              0x80
> -#define SPI_TX_DUAL            0x100
> -#define SPI_TX_QUAD            0x200
> -#define SPI_RX_DUAL            0x400
> -#define SPI_RX_QUAD            0x800
> -#define SPI_CS_WORD            0x1000
> -#define SPI_TX_OCTAL           0x2000
> -#define SPI_RX_OCTAL           0x4000
> -#define SPI_3WIRE_HIZ          0x8000
> -
> -/*---------------------------------------------------------------------------*/
> +#include <linux/spi/spi.h>
>
>  /* IOCTL commands */
>
> --
> 2.27.0
>


-- 
With Best Regards,
Andy Shevchenko
