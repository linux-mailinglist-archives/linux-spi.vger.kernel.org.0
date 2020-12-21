Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA5652DFFB0
	for <lists+linux-spi@lfdr.de>; Mon, 21 Dec 2020 19:27:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbgLUS1G (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 21 Dec 2020 13:27:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbgLUS1G (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 21 Dec 2020 13:27:06 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5CF0C0613D3;
        Mon, 21 Dec 2020 10:26:25 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id s2so12220452oij.2;
        Mon, 21 Dec 2020 10:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MuUZbtCbTb/hN/RbaXVanAIRoioLuB8LdxU10guvFcg=;
        b=CvSuRSJC4xSsr+RrU/pacXHzcUmgK/+Le/1SMd70B1QJS72Sk5sUrNRDcbfSnynERm
         SRsrO19ku9tljwSYY43wR8+1eIhRPCiOpO2XFJAp+D74ReBGuAlVse8V16vPH0ioBTBO
         EjWwwIR9+U1iLdeev0SfNCf4DooZAD5r6fNPP81LEyla2RVZ42Y+zbzVn+8CJ/K6e4cJ
         TMujCQK8StZVAfs0OIElf8UdIvGuaBuK5sQtOKJu1ccwur2OiRJsAUN8nXC3hojAyVze
         HDC18wGMXI0gyFc4SfmQ8lBv3M46tBmojdSiOVa/Nxf5crVzOdfdZfofontk3lu5ehie
         3hPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MuUZbtCbTb/hN/RbaXVanAIRoioLuB8LdxU10guvFcg=;
        b=oHHsXjaNO+vgdMgZOU2nOqwZjteY3LbFXZLBSSGgyX2pPr0dLtlWqgZMtTatbKDwIk
         VBog8MvBZ3lcctlpPBlZdcbPRKmrnXG24lIFBgCTqyMdOB495bgHOfPRbykpVyPt0Uav
         880i6zBb9LKDnE+0U/uiLKH8qA94SZ/p8mUvdU1umrmL61wdlPTeFkjc/AbGKzHy0g9W
         eDSi8qfWOUNRy4c5roIZd3k7CaZ2zckGlfGaz0c5zNdZ0fD5viSce0k5oZxX6rP/yljE
         BftBfcR8T9aX45Y/HtvqsIweXF8k13w8w6Q/QRGA0FmFvE+2Z8pqfRr4xMmXahVpToWn
         7utw==
X-Gm-Message-State: AOAM532kkCAPLdGWC6boH50QqqWbpkE78maUb+qKkdJbZzxN2cUL5lSC
        cnQ2UgauIA+k8qmNNxcEKWNccwQEKajyQdksdqHktgFyrCg=
X-Google-Smtp-Source: ABdhPJxkOffu1KIxKHLsiqbddefjuTAYzUZb1how8tbIZW/SLpObNhF5nDortFypR4pmbqvcAxbF8O/i07HKmtAdpuo=
X-Received: by 2002:a17:90b:a17:: with SMTP id gg23mr18470790pjb.129.1608571633700;
 Mon, 21 Dec 2020 09:27:13 -0800 (PST)
MIME-Version: 1.0
References: <20201221152936.53873-1-alexandru.ardelean@analog.com> <20201221152936.53873-2-alexandru.ardelean@analog.com>
In-Reply-To: <20201221152936.53873-2-alexandru.ardelean@analog.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 21 Dec 2020 19:28:02 +0200
Message-ID: <CAHp75VfTiBHJfGPMQJW5K1zcVYKbQHBP=gNsTn0Kah1M92Ok2w@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] spi: Add SPI_NO_TX/RX support
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

On Mon, Dec 21, 2020 at 5:25 PM Alexandru Ardelean
<alexandru.ardelean@analog.com> wrote:
>
> From: Dragos Bogdan <dragos.bogdan@analog.com>
>
> Transmit/receive only is a valid SPI mode. For example, the MOSI/TX line
> might be missing from an ADC while for a DAC the MISO/RX line may be
> optional. This patch adds these two new modes: SPI_NO_TX and
> SPI_NO_RX. This way, the drivers will be able to identify if any of
> these two lines is missing and to adjust the transfers accordingly.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Dragos Bogdan <dragos.bogdan@analog.com>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
>
> Changelog v5 -> v6:
> * https://patchwork.kernel.org/project/spi-devel-general/patch/20201221141906.48922-2-alexandru.ardelean@analog.com/
> * merged on single line message:
>     "setup: can not select any two of dual, quad and no-rx/tx at the same time\n"
> * not adding Reviewed-by: tag for Andy yet, since there was a nit
>
>  drivers/spi/spi.c            | 25 ++++++++++++++++++++-----
>  include/linux/spi/spi.h      | 17 +++++++++++++++++
>  include/uapi/linux/spi/spi.h | 10 ++++++++++
>  3 files changed, 47 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index 51d7c004fbab..ca75f4036eda 100644
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
> @@ -3329,12 +3335,16 @@ int spi_setup(struct spi_device *spi)
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
> +               "setup: can not select any two of dual, quad and no-rx/tx at the same time\n");
>                 return -EINVAL;
>         }
>         /* if it is SPI_3WIRE mode, DUAL and QUAD should be forbidden
> @@ -3348,7 +3358,8 @@ int spi_setup(struct spi_device *spi)
>          * SPI_CS_WORD has a fallback software implementation,
>          * so it is ignored here.
>          */
> -       bad_bits = spi->mode & ~(spi->controller->mode_bits | SPI_CS_WORD);
> +       bad_bits = spi->mode & ~(spi->controller->mode_bits | SPI_CS_WORD |
> +                                SPI_NO_TX | SPI_NO_RX);
>         /* nothing prevents from working with active-high CS in case if it
>          * is driven by GPIO.
>          */
> @@ -3610,6 +3621,8 @@ static int __spi_validate(struct spi_device *spi, struct spi_message *message)
>                  * 2. check tx/rx_nbits match the mode in spi_device
>                  */
>                 if (xfer->tx_buf) {
> +                       if (spi->mode & SPI_NO_TX)
> +                               return -EINVAL;
>                         if (xfer->tx_nbits != SPI_NBITS_SINGLE &&
>                                 xfer->tx_nbits != SPI_NBITS_DUAL &&
>                                 xfer->tx_nbits != SPI_NBITS_QUAD)
> @@ -3623,6 +3636,8 @@ static int __spi_validate(struct spi_device *spi, struct spi_message *message)
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
