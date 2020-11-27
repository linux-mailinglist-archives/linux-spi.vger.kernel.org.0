Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5A72C67C4
	for <lists+linux-spi@lfdr.de>; Fri, 27 Nov 2020 15:23:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730868AbgK0OWD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 27 Nov 2020 09:22:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730551AbgK0OWD (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 27 Nov 2020 09:22:03 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1385BC0613D1;
        Fri, 27 Nov 2020 06:22:03 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id w6so4746249pfu.1;
        Fri, 27 Nov 2020 06:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NZuPwBGFQNcqFlpY7t4mA2yjp1/UdJ3toB4opd89Aaw=;
        b=EgW10HX+IP6pglsGJGZ1kh14byOc7kx9T88xYwQQd/HjVvrAVuLZ3dMTy7N5qr3OrQ
         rRYq8fo/leDcMAegz12JLkTTkeHA1nVYs3E9/celZ/SXlGhYINZM3mkC4mmPfGrtyzc3
         hq+YfSWg5MdLTJpeZrm35k/GbaB2KMLmQ+maxCB2P0IPYhCntWYxVmGAPzNWK85SdxoX
         eVKXjuyBE1sAPkArPWVVaq3+JcfPokT7EOQMkX8PLWfRWeEdFmPEXDUju5/3Bsfrd4R9
         D0y2HjlQWTiBM3uE/AkEP91iy3ylPgl0cgZImW7kC/Q7C9T7aJ6psFNyLAqZqM4Bj6vi
         pX/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NZuPwBGFQNcqFlpY7t4mA2yjp1/UdJ3toB4opd89Aaw=;
        b=Htw0HTwEOcSU/tU/uRlLjqSR2iemGpR63eal3FJ/Q99xhGrqypCeWn99g1WFXDciCD
         +1UpN97REdHyoViZ8s8a0JyDpTUMYDdgwvMxbk6H/XiBzFmr0Flzh79N6BHbzYfheV5z
         cI8iVG6J29vWzXxE5VTqxrUtgeeBB83ffUJMywNn5c3B7f/M7c/gJuilRPYm54bu7Bt1
         5OpfDx8mXfY+XtPprcQuaPvyBNDbLDiUF1KiBgCxLjDDO9ZzSUfh3uNNnemKPs8SfHFQ
         shmPga6kBZzK5u03M+GD03BWhLgLSQlLZJooScsi1s7HtJvFy9x/xfA+gu46x5GbAbff
         qa1Q==
X-Gm-Message-State: AOAM533lVKi3WimwmGICwSzQqGPXOdLVnWKIc3ArEc9LOKwAPefi287Q
        gen/Soqe8pBwz6oHJySzDIP2SPV+NzLlyNUJBgxL0dB3mnXqJA==
X-Google-Smtp-Source: ABdhPJzD6N/5epoxKsbTqEQY7G2+eoyatzRwU1INHL8EDaJIH5aHrh77mm0BWZBD4J5RdKR8xAAzGBmiWjdoTRDWyQw=
X-Received: by 2002:a63:1514:: with SMTP id v20mr6822588pgl.203.1606486922599;
 Fri, 27 Nov 2020 06:22:02 -0800 (PST)
MIME-Version: 1.0
References: <20201127130834.136348-1-alexandru.ardelean@analog.com> <20201127130834.136348-2-alexandru.ardelean@analog.com>
In-Reply-To: <20201127130834.136348-2-alexandru.ardelean@analog.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 27 Nov 2020 16:22:51 +0200
Message-ID: <CAHp75Vcd4t=RqC31S-b1PXMtd=8sypSLhTrSgRD9hbpSqOphoQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] spi: Add SPI_NO_TX/RX support
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
> Transmit/receive only is a valid SPI mode. For example, the MOSI/TX line
> might be missing from an ADC while for a DAC the MISO/RX line may be
> optional. This patch adds these two new modes: SPI_NO_TX and
> SPI_NO_RX. This way, the drivers will be able to identify if any of
> these two lines is missing and to adjust the transfers accordingly.

...

> +       /*
> +        * check mode to prevent that any two of DUAL, QUAD and NO_MOSI/MISO
> +        * are set at the same time
>          */

Since you are here,
 check -> Check
 time -> time.

...

> +       if ((hweight_long(spi->mode &
> +               (SPI_TX_DUAL | SPI_TX_QUAD | SPI_NO_TX)) > 1) ||
> +           (hweight_long(spi->mode &
> +               (SPI_RX_DUAL | SPI_RX_QUAD | SPI_NO_RX)) > 1)) {
>                 dev_err(&spi->dev,
> -               "setup: can not select dual and quad at the same time\n");
> +               "setup: can not select any two of dual, quad and no-rx/tx "
> +               "at the same time\n");

Don't split literals, and probably rephrase (If I can't set 2, can I set 3?)
   "setup: can't select more than one out of dual, quad, and no-Rx /
no-Tx at the same time\n");

> --- a/include/uapi/linux/spi/spi.h
> +++ b/include/uapi/linux/spi/spi.h
> @@ -43,5 +43,7 @@
>  #define        SPI_TX_OCTAL            0x2000          /* transmit with 8 wires */
>  #define        SPI_RX_OCTAL            0x4000          /* receive with 8 wires */
>  #define        SPI_3WIRE_HIZ           0x8000          /* high impedance turnaround */
> +#define        SPI_NO_TX               0x10000         /* no transmit wire */
> +#define        SPI_NO_RX               0x20000         /* no receive wire */

Is it really material for uAPI?
Perhaps we may have something like
SPI_MODE_USER_MASK in uAPI and
in internal headers

SPI_MODE_KERNEL_MASK with
static_assert(_USER_MASK & _KERNEL_MASK); // check conditional

?

-- 
With Best Regards,
Andy Shevchenko
