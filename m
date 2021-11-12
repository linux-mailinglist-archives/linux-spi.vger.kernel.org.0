Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0975544EE9A
	for <lists+linux-spi@lfdr.de>; Fri, 12 Nov 2021 22:27:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235788AbhKLVas (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 12 Nov 2021 16:30:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235780AbhKLVam (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 12 Nov 2021 16:30:42 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 994CAC061766;
        Fri, 12 Nov 2021 13:27:50 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id c8so42550451ede.13;
        Fri, 12 Nov 2021 13:27:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EV/m3W7GV0huECmk18+0LYkrsRWf8bnSvUV9UoKP49Q=;
        b=ftSynzIJwA4OSYKghkYDd5uOs+bWo1XK6RBCEa2YAtJfTQVpitiopTiKQ0ZgBBLFGX
         IrgL1aj0f/7BzGgEJj9TamU1hSL5pvgkdbF0OD5JL1xW2BEzckYkQME6H/u+CZK38e9C
         79MCbx/b/uKhX/aATaTVkxF+KHKLNgUOsTy+l6chGDZPhFvThySALlY0F7OoSVpIFa5V
         5c48uS+5SmediUbQJ6vokMpN7W5avkpVtE90rgAp7VcgPM9VIfJpAJHi2IUabuSLkytB
         Pz+eLN7jDdTGSAQybRW+bP7Yh0uv8R4ITWS/JZ5J4vFH6IPInC+QJuPnedk825K4/3FK
         wkng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EV/m3W7GV0huECmk18+0LYkrsRWf8bnSvUV9UoKP49Q=;
        b=BdF5K/Q5mQrRshaN1uJ9lK04RSAcyR3kTFTHND+79rav2ugbI5EjQDHem3M4L1Kdlc
         Lplg6FsZ2LdvGUSztZ3v/zlsp4aQ65EHo+cRimPnUKFcfKovUICxfCqJWtzIBPSjUgDJ
         cVJsVjPYBmxPhKMaRz6zAY8ErGQBiKCXgH+L6VZa3KuUn15F2uWE18B7j7aC9j1tbhh8
         aQZU/UGwJ4eZrUZd4GtiAlHiLprjrHWMnjkI1wOsVh89StQtL0EUqv1ucehxNNxii6YS
         mdFfKR9cWxM3rILsHr32m1HOYJv9pvtrR24ZW9HAqwWqO57MPANoYot+pIH6hnFHNNYs
         E/bg==
X-Gm-Message-State: AOAM533FS9V9DyU/N4T1jVyWwU29MKEsqwJgdyMI84MSd2yAKEYzciBY
        qUEMWsaHFd6u/gqpqP6bydIlI7n5K5RlmW+ouRk=
X-Google-Smtp-Source: ABdhPJztovpJ5PuaPqhOAVEshj5TN+zW6CHLY/ptgGhYgugA8DtHULGSoYBnRwMHQA7fPKDWFsI9oNHOl2o1UCi2nFI=
X-Received: by 2002:a05:6402:c89:: with SMTP id cm9mr7765375edb.283.1636752469149;
 Fri, 12 Nov 2021 13:27:49 -0800 (PST)
MIME-Version: 1.0
References: <20211112204927.8830-1-Sergey.Semin@baikalelectronics.ru> <20211112204927.8830-5-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20211112204927.8830-5-Sergey.Semin@baikalelectronics.ru>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 12 Nov 2021 23:27:05 +0200
Message-ID: <CAHp75VeEaj6zNtdRF65t_xriWe=Agx3WuW8tw6XZzBHCXtTgmw@mail.gmail.com>
Subject: Re: [PATCH 4/4] spi: dw: Add Synopsys Component version reading and parsing
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Nandhini Srikandan <nandhini.srikandan@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Nov 12, 2021 at 10:52 PM Serge Semin
<Sergey.Semin@baikalelectronics.ru> wrote:
>
> Each Synopsys DWC SSI controller is equipped with a Synopsys Component
> version register, which encodes a version ID of an IP-core the
> controller has been synthesized from. That can be useful in future for th=
e
> version-based conditional features implementation in the driver.
>
> Note the component version is encoded as an ASCII string so we need to
> convert it from the string to a normal unsigned integer to be easily used
> then in the driver statements.
>
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> ---
>  drivers/spi/spi-dw-core.c | 18 ++++++++++++++++++
>  drivers/spi/spi-dw.h      |  1 +
>  2 files changed, 19 insertions(+)
>
> diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
> index b4cbcd38eaba..1766a29ca790 100644
> --- a/drivers/spi/spi-dw-core.c
> +++ b/drivers/spi/spi-dw-core.c
> @@ -823,6 +823,24 @@ static void dw_spi_hw_init(struct device *dev, struc=
t dw_spi *dws)
>  {
>         dw_spi_reset_chip(dws);
>
> +       /*
> +        * Retrieve the Synopsys component version if it hasn't been spec=
ified
> +        * by the platform. Note the CoreKit version ID is encoded as a 4=
bytes
> +        * ASCII string enclosed with '*' symbol.
> +        */
> +       if (!dws->ver) {
> +               u32 comp;
> +
> +               comp =3D dw_readl(dws, DW_SPI_VERSION);
> +               dws->ver =3D (DW_SPI_GET_BYTE(comp, 3) - '0') * 100;
> +               dws->ver +=3D (DW_SPI_GET_BYTE(comp, 2) - '0') * 10;
> +               dws->ver +=3D (DW_SPI_GET_BYTE(comp, 1) - '0');
> +
> +               dev_dbg(dev, "Synopsys DWC%sSSI v%u.%02u\n",
> +                       (dws->caps & DW_SPI_CAP_DWC_HSSI) ? " " : " APB "=
,
> +                       dws->ver / 100, dws->ver % 100);

Oh l=C3=A0 l=C3=A0, first you multiply then you divide in the same piece of=
 code!
What's wrong with fourcc (and thus keep it in ver filed as is) ? (Also
we have %p4cc)

> +       }
> +
>         /*
>          * Try to detect the FIFO depth if not set by interface driver,
>          * the depth could be from 2 to 256 from HW spec
> diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
> index 634085eadad1..d06857d8d173 100644
> --- a/drivers/spi/spi-dw.h
> +++ b/drivers/spi/spi-dw.h
> @@ -149,6 +149,7 @@ struct dw_spi {
>         u32                     max_mem_freq;   /* max mem-ops bus freq *=
/
>         u32                     max_freq;       /* max bus freq supported=
 */
>
> +       u32                     ver;            /* Synopsys component ver=
sion */
>         u32                     caps;           /* DW SPI capabilities */
>
>         u32                     reg_io_width;   /* DR I/O width in bytes =
*/
> --
> 2.33.0
>


--=20
With Best Regards,
Andy Shevchenko
