Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 444F52CD8BE
	for <lists+linux-spi@lfdr.de>; Thu,  3 Dec 2020 15:16:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730759AbgLCON7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 3 Dec 2020 09:13:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbgLCON6 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 3 Dec 2020 09:13:58 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 896B9C061A4E;
        Thu,  3 Dec 2020 06:13:18 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id o5so1463946pgm.10;
        Thu, 03 Dec 2020 06:13:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hJdtZv74zuOHhxRZN5QLNjv8petoVkByPdy9IOaw9oQ=;
        b=j+XVQcQXM69Gyod3lFmOnpgB+Xgn5XXUiu8AbmEJSTXQZ+QlivDWw0h1ogxGPuN9ym
         B5LRpBRgHZf0MCJ84878bR/BMAwukvIqdvS2X/bVn5qfRSa9N5mew+cemmvg3aFJGWDb
         77O6CJRYmzLih6cPa+s554HCx0RH5wamV/T/S/NJGzjpcgR6FceIRkqhztpgQuz2VWNP
         qfwcrHFbBJrOF+1SP/E6MFUpNJw3qUMK/iBXWhHrx4cG3QA1h5piV/vElgq0Zr0EVAJn
         6VxiXdZ3DEiQoq1pQ0kVV1ompVJD0gdTfTLPTkFDqb5K0gKhqj5y7U/NQ3Q6mLQ67ouG
         +ZhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hJdtZv74zuOHhxRZN5QLNjv8petoVkByPdy9IOaw9oQ=;
        b=rYGiVXLYDvpEi5b42Kzps+HElNXzMqhe4hrnSqImKy/CVTrwRyBgF0BfPnUAEDBxWc
         QcrD43oWr2/NrxqxyxZrvwFgKryfydBzwcBkzihXTCj65ujyCzdJDjgBRwbBPj3X0ab4
         icw1Y818H2gtTqIrIuxpr5yRxFb6K54RWRZ8hMATUfzvdmSSePJVE8cwUC5mDRuHqKdl
         MeXAqYTQPU+cA1r9v1SRm3aLgWgZDBy+oThqh5CN8cxk7FsfBJEQOzqqKuwqV7SUF+Rw
         rAX3EDl2hNC8Xc9v6iQKZkGIQFLni7a2MD7QoB3PmQfDwo278aZgPcSgKwNob34ZY7Te
         e5XA==
X-Gm-Message-State: AOAM530H/dgDGCYkI9ouXvvPEg2uw/qfPPvnb710mGaj5rXanVNmXoWE
        RSCDewzqbm+ptsEZoz9xVY9T3qxxCnqb1UCvKGU=
X-Google-Smtp-Source: ABdhPJxZ1f6fjj+LKhjqBGV0xAmbkEADD7rdlwKP/CRZUdxfoUMQpR8OPFGuTvOF+fuDqji7pci3JgC+WKPTuqNQNFE=
X-Received: by 2002:a63:471f:: with SMTP id u31mr3208115pga.74.1607004797947;
 Thu, 03 Dec 2020 06:13:17 -0800 (PST)
MIME-Version: 1.0
References: <20201203140531.74470-1-alexandru.ardelean@analog.com>
In-Reply-To: <20201203140531.74470-1-alexandru.ardelean@analog.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 3 Dec 2020 16:14:06 +0200
Message-ID: <CAHp75VcFPC6_=+AbWOGyFJ5t+ZXwWJUBdHYUe++DemdbcxRfWQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] spi: uapi: unify SPI modes into a single spi.h header
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     linux-spi <linux-spi@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Bogdan, Dragos" <dragos.bogdan@analog.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Dec 3, 2020 at 4:00 PM Alexandru Ardelean
<alexandru.ardelean@analog.com> wrote:
>
> This change moves all the SPI mode bits into a separate 'spi.h' header in
> uAPI. This is meant to re-use these definitions inside the kernel as well
> as export them to userspace (via uAPI).
>
> The SPI mode definitions have usually been duplicated between between
> 'include/linux/spi/spi.h' and 'include/uapi/linux/spi/spidev.h', so
> whenever adding a new entry, this would need to be put in both headers.
>
> They've been moved from 'include/linux/spi/spi.h', since that seems a bit
> more complete; the bits have descriptions and there is the SPI_MODE_X_MASK.
>
> This change also does a conversion of these bitfields to _BITUL() macro.

Looks nice to me now, FWIW,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
>
> Changelog v3 -> v4:
> * https://lore.kernel.org/linux-spi/20201127130834.136348-1-alexandru.ardelean@analog.com/
> * uapi -> uAPI in comment
> * removed extra license text in 'uapi/linux/spi/spi.h'
> * using _BITUL() macro
>
>  include/linux/spi/spi.h         | 23 ++---------------------
>  include/uapi/linux/spi/spi.h    | 31 +++++++++++++++++++++++++++++++
>  include/uapi/linux/spi/spidev.h | 30 +-----------------------------
>  3 files changed, 34 insertions(+), 50 deletions(-)
>  create mode 100644 include/uapi/linux/spi/spi.h
>
> diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
> index aa09fdc8042d..a08c3f37e202 100644
> --- a/include/linux/spi/spi.h
> +++ b/include/linux/spi/spi.h
> @@ -15,6 +15,8 @@
>  #include <linux/gpio/consumer.h>
>  #include <linux/ptp_clock_kernel.h>
>
> +#include <uapi/linux/spi/spi.h>
> +
>  struct dma_chan;
>  struct property_entry;
>  struct spi_controller;
> @@ -165,27 +167,6 @@ struct spi_device {
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
> index 000000000000..703b586f35df
> --- /dev/null
> +++ b/include/uapi/linux/spi/spi.h
> @@ -0,0 +1,31 @@
> +/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
> +#ifndef _UAPI_SPI_H
> +#define _UAPI_SPI_H
> +
> +#include <linux/const.h>
> +
> +#define        SPI_CPHA                _BITUL(0)       /* clock phase */
> +#define        SPI_CPOL                _BITUL(1)       /* clock polarity */
> +
> +#define        SPI_MODE_0              (0|0)           /* (original MicroWire) */
> +#define        SPI_MODE_1              (0|SPI_CPHA)
> +#define        SPI_MODE_2              (SPI_CPOL|0)
> +#define        SPI_MODE_3              (SPI_CPOL|SPI_CPHA)
> +#define        SPI_MODE_X_MASK         (SPI_CPOL|SPI_CPHA)
> +
> +#define        SPI_CS_HIGH             _BITUL(2)       /* chipselect active high? */
> +#define        SPI_LSB_FIRST           _BITUL(3)       /* per-word bits-on-wire */
> +#define        SPI_3WIRE               _BITUL(4)       /* SI/SO signals shared */
> +#define        SPI_LOOP                _BITUL(5)       /* loopback mode */
> +#define        SPI_NO_CS               _BITUL(6)       /* 1 dev/bus, no chipselect */
> +#define        SPI_READY               _BITUL(7)       /* slave pulls low to pause */
> +#define        SPI_TX_DUAL             _BITUL(8)       /* transmit with 2 wires */
> +#define        SPI_TX_QUAD             _BITUL(9)       /* transmit with 4 wires */
> +#define        SPI_RX_DUAL             _BITUL(10)      /* receive with 2 wires */
> +#define        SPI_RX_QUAD             _BITUL(11)      /* receive with 4 wires */
> +#define        SPI_CS_WORD             _BITUL(12)      /* toggle cs after each word */
> +#define        SPI_TX_OCTAL            _BITUL(13)      /* transmit with 8 wires */
> +#define        SPI_RX_OCTAL            _BITUL(14)      /* receive with 8 wires */
> +#define        SPI_3WIRE_HIZ           _BITUL(15)      /* high impedance turnaround */
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
> 2.17.1
>


-- 
With Best Regards,
Andy Shevchenko
