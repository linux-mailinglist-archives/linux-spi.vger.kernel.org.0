Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C90192E0039
	for <lists+linux-spi@lfdr.de>; Mon, 21 Dec 2020 19:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbgLUSoD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 21 Dec 2020 13:44:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbgLUSoC (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 21 Dec 2020 13:44:02 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71126C0613D3;
        Mon, 21 Dec 2020 10:43:22 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id 15so12245611oix.8;
        Mon, 21 Dec 2020 10:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rAygxlR5IF6cU3QV0vjq38jRM5edvhU4wfQpjiY4SE8=;
        b=q6Q2CdQxJMv6Gu5VYpUEYLTfB2oE+DWkypqw+U/nxkrGd6sQ40ksbl30yeneKOplOR
         yYWf72wSO/mbASns6jHi1Sdml9AUgGjP4gc2Lm8RvAd2XOyt3LmEd0qnRh15SBapQzjh
         UQ7a38C9bElx8luWGnjMuh8mrt3bCCw8Hws82x94uHW+jMFmzCOBFdDTkvoiiieGzi4q
         jGsgh3dEO6++J+CtCBQ6GXwmmE9yd6TDGJpjXCJyN6WzhkFU6U1S/Z0ykup+NIsKSgrb
         ZzRPA9NQCXZY9FaguM2PUKepIlDnWWe4UsifFP+bxEdk7nQiMGCeMexDmZoL2TGKJ043
         +2ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rAygxlR5IF6cU3QV0vjq38jRM5edvhU4wfQpjiY4SE8=;
        b=Gh4QYYrIROdQD1w4ZNUALruXZQAtcn8S7cykx/MxboNBgRXi2LaNwLlO7H5dlzvwnJ
         WERaC4vDVlhew2I0uUqXF/n8xVlg7tQWmvYV2z3TIwxgH9Ab6a93fO3a5Hx6WAh7fBt7
         BUeEMbJMbiBxY+woWdu0EWUPsCZWM6bX7NUCez23x+zBguxn2nSIc4ET7DA2I9/I9y5Y
         XvorVd79yoBDk6ABS0Yp6X9MIT0o4eLkLYsKbduQQ9n0FBc3rKVxrz8dd3RDALvuYunA
         py1BAlCHH7UV/hVjLUdF2qytu89Nj+QqlY/7Urn1vZtmofCPzX1TV/4yL56sbjQ6DmAD
         AeFw==
X-Gm-Message-State: AOAM531HGN9hEJmdv+9SJSVbrdWJkCVWR1IDMYCwwaZcuDf7XhVu/InD
        zQJs9cujtMp7NoFJsf3RuLyvclPB/CMWcX9PzwhGoLn/I04=
X-Google-Smtp-Source: ABdhPJwulVniv5YY5m3TGK41PRSeOi9ucOCBAn0Mek3mY7rW06jWm+nOnMjIQjc58ifyy8sjIuHyXaF4bDZQ0UOLlLU=
X-Received: by 2002:a17:90a:c592:: with SMTP id l18mr17633909pjt.228.1608561247488;
 Mon, 21 Dec 2020 06:34:07 -0800 (PST)
MIME-Version: 1.0
References: <20201221141906.48922-1-alexandru.ardelean@analog.com> <20201221141906.48922-2-alexandru.ardelean@analog.com>
In-Reply-To: <20201221141906.48922-2-alexandru.ardelean@analog.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 21 Dec 2020 16:34:55 +0200
Message-ID: <CAHp75VfR1eNMry8JwJoFuaU48KZ6rdBWau=yaR1AnsaRSLTC=g@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] spi: Add SPI_NO_TX/RX support
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     linux-spi <linux-spi@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Bogdan, Dragos" <dragos.bogdan@analog.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Dec 21, 2020 at 4:15 PM Alexandru Ardelean
<alexandru.ardelean@analog.com> wrote:
>
> From: Dragos Bogdan <dragos.bogdan@analog.com>
>
> Transmit/receive only is a valid SPI mode. For example, the MOSI/TX line
> might be missing from an ADC while for a DAC the MISO/RX line may be
> optional. This patch adds these two new modes: SPI_NO_TX and
> SPI_NO_RX. This way, the drivers will be able to identify if any of
> these two lines is missing and to adjust the transfers accordingly.
>
> Signed-off-by: Dragos Bogdan <dragos.bogdan@analog.com>

Missed Co-developed-by: Alexandru ... ?

Anyway, looks good to me,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
>
> Changelog v4 -> v5:
> * https://lore.kernel.org/linux-spi/20201203140531.74470-2-alexandru.ardelean@analog.com/
> * using static_assert() vs BUILD_BUG_ON()
> * added comments for SPI_MODE_KERNEL_MASK & SPI_MODE_USER_MASK
> * using shorter form defining SPI_MODE_KERNEL_MASK & SPI_MODE_USER_MASK
>
>  drivers/spi/spi.c            | 26 +++++++++++++++++++++-----
>  include/linux/spi/spi.h      | 17 +++++++++++++++++
>  include/uapi/linux/spi/spi.h | 10 ++++++++++
>  3 files changed, 48 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index 51d7c004fbab..0b69934698c3 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -1941,6 +1941,9 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
>         /* Device DUAL/QUAD mode */
>         if (!of_property_read_u32(nc, "spi-tx-bus-width", &value)) {
>                 switch (value) {
> +               case 0:
> +                       spi->mode |= SPI_NO_TX;
> +                       break;
>                 case 1:
>                         break;
>                 case 2:
> @@ -1962,6 +1965,9 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
>
>         if (!of_property_read_u32(nc, "spi-rx-bus-width", &value)) {
>                 switch (value) {
> +               case 0:
> +                       spi->mode |= SPI_NO_RX;
> +                       break;
>                 case 1:
>                         break;
>                 case 2:
> @@ -3329,12 +3335,17 @@ int spi_setup(struct spi_device *spi)
>         unsigned        bad_bits, ugly_bits;
>         int             status;
>
> -       /* check mode to prevent that DUAL and QUAD set at the same time
> +       /*
> +        * check mode to prevent that any two of DUAL, QUAD and NO_MOSI/MISO
> +        * are set at the same time
>          */
> -       if (((spi->mode & SPI_TX_DUAL) && (spi->mode & SPI_TX_QUAD)) ||
> -               ((spi->mode & SPI_RX_DUAL) && (spi->mode & SPI_RX_QUAD))) {
> +       if ((hweight_long(spi->mode &
> +               (SPI_TX_DUAL | SPI_TX_QUAD | SPI_NO_TX)) > 1) ||
> +           (hweight_long(spi->mode &
> +               (SPI_RX_DUAL | SPI_RX_QUAD | SPI_NO_RX)) > 1)) {
>                 dev_err(&spi->dev,
> -               "setup: can not select dual and quad at the same time\n");
> +               "setup: can not select any two of dual, quad and no-rx/tx "
> +               "at the same time\n");
>                 return -EINVAL;
>         }
>         /* if it is SPI_3WIRE mode, DUAL and QUAD should be forbidden
> @@ -3348,7 +3359,8 @@ int spi_setup(struct spi_device *spi)
>          * SPI_CS_WORD has a fallback software implementation,
>          * so it is ignored here.
>          */
> -       bad_bits = spi->mode & ~(spi->controller->mode_bits | SPI_CS_WORD);
> +       bad_bits = spi->mode & ~(spi->controller->mode_bits | SPI_CS_WORD |
> +                                SPI_NO_TX | SPI_NO_RX);
>         /* nothing prevents from working with active-high CS in case if it
>          * is driven by GPIO.
>          */
> @@ -3610,6 +3622,8 @@ static int __spi_validate(struct spi_device *spi, struct spi_message *message)
>                  * 2. check tx/rx_nbits match the mode in spi_device
>                  */
>                 if (xfer->tx_buf) {
> +                       if (spi->mode & SPI_NO_TX)
> +                               return -EINVAL;
>                         if (xfer->tx_nbits != SPI_NBITS_SINGLE &&
>                                 xfer->tx_nbits != SPI_NBITS_DUAL &&
>                                 xfer->tx_nbits != SPI_NBITS_QUAD)
> @@ -3623,6 +3637,8 @@ static int __spi_validate(struct spi_device *spi, struct spi_message *message)
>                 }
>                 /* check transfer rx_nbits */
>                 if (xfer->rx_buf) {
> +                       if (spi->mode & SPI_NO_RX)
> +                               return -EINVAL;
>                         if (xfer->rx_nbits != SPI_NBITS_SINGLE &&
>                                 xfer->rx_nbits != SPI_NBITS_DUAL &&
>                                 xfer->rx_nbits != SPI_NBITS_QUAD)
> diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
> index a08c3f37e202..9bfdfaf286eb 100644
> --- a/include/linux/spi/spi.h
> +++ b/include/linux/spi/spi.h
> @@ -6,6 +6,7 @@
>  #ifndef __LINUX_SPI_H
>  #define __LINUX_SPI_H
>
> +#include <linux/bits.h>
>  #include <linux/device.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/slab.h>
> @@ -166,6 +167,18 @@ struct spi_device {
>         u8                      chip_select;
>         u8                      bits_per_word;
>         bool                    rt;
> +#define SPI_NO_TX      BIT(31)         /* no transmit wire */
> +#define SPI_NO_RX      BIT(30)         /* no receive wire */
> +       /*
> +        * All bits defined above should be covered by SPI_MODE_KERNEL_MASK.
> +        * The SPI_MODE_KERNEL_MASK has the SPI_MODE_USER_MASK counterpart,
> +        * which is defined in 'include/uapi/linux/spi/spi.h'.
> +        * The bits defined here are from bit 31 downwards, while in
> +        * SPI_MODE_USER_MASK are from 0 upwards.
> +        * These bits must not overlap. A static assert check should make sure of that.
> +        * If adding extra bits, make sure to decrease the bit index below as well.
> +        */
> +#define SPI_MODE_KERNEL_MASK   (~(BIT(30) - 1))
>         u32                     mode;
>         int                     irq;
>         void                    *controller_state;
> @@ -189,6 +202,10 @@ struct spi_device {
>          */
>  };
>
> +/* Make sure that SPI_MODE_KERNEL_MASK & SPI_MODE_USER_MASK don't overlap */
> +static_assert((SPI_MODE_KERNEL_MASK & SPI_MODE_USER_MASK) == 0,
> +             "SPI_MODE_USER_MASK & SPI_MODE_KERNEL_MASK must not overlap");
> +
>  static inline struct spi_device *to_spi_device(struct device *dev)
>  {
>         return dev ? container_of(dev, struct spi_device, dev) : NULL;
> diff --git a/include/uapi/linux/spi/spi.h b/include/uapi/linux/spi/spi.h
> index 703b586f35df..236a85f08ded 100644
> --- a/include/uapi/linux/spi/spi.h
> +++ b/include/uapi/linux/spi/spi.h
> @@ -28,4 +28,14 @@
>  #define        SPI_RX_OCTAL            _BITUL(14)      /* receive with 8 wires */
>  #define        SPI_3WIRE_HIZ           _BITUL(15)      /* high impedance turnaround */
>
> +/*
> + * All the bits defined above should be covered by SPI_MODE_USER_MASK.
> + * The SPI_MODE_USER_MASK has the SPI_MODE_KERNEL_MASK counterpart in
> + * 'include/linux/spi/spi.h'. The bits defined here are from bit 0 upwards
> + * while in SPI_MODE_KERNEL_MASK they are from the other end downwards.
> + * These bits must not overlap. A static assert check should make sure of that.
> + * If adding extra bits, make sure to increase the bit index below as well.
> + */
> +#define SPI_MODE_USER_MASK     (_BITUL(16) - 1)
> +
>  #endif /* _UAPI_SPI_H */
> --
> 2.17.1
>


-- 
With Best Regards,
Andy Shevchenko
