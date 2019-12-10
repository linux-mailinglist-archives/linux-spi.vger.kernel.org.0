Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01F5E118C0C
	for <lists+linux-spi@lfdr.de>; Tue, 10 Dec 2019 16:08:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbfLJPIg (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 10 Dec 2019 10:08:36 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41647 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727642AbfLJPIf (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 10 Dec 2019 10:08:35 -0500
Received: by mail-lj1-f194.google.com with SMTP id h23so20272616ljc.8
        for <linux-spi@vger.kernel.org>; Tue, 10 Dec 2019 07:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=newoldbits-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wY25iks8fJgWV/3zpHQrx9JVu0mthHmG9auK6uwALnY=;
        b=fVERc1pnKdmGBv2cbWYya9jrkMgNneTi9IQcC/WQDmOZ3jMSm/qlbvB/AXSgtAz4XB
         v2ik8F8G8bahGpgEn7TZDn2aVMJBWad57YaB5CbwdBbDXLAfj35ksf/LJJPhMheBj9IR
         wvC08aF4qUSpM6N0TGbThOMxraCIZ2wOJwQWdDVXMzNZ9aj3dGToBZSahKpjOt+/yxuB
         P93j/7emG53rYP6Pqd+z1HCgbcw4APZaHMrF/AsEHv3G9ZWe1SZk5oEWepn9SX3/QQTI
         kZ0z1k9iOZX8FWH2yr55fYaI/9PMJgCvWVE0zf44nrGJ4EU7JjXdhF7bTltMvo6CMJpP
         heRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wY25iks8fJgWV/3zpHQrx9JVu0mthHmG9auK6uwALnY=;
        b=mx/tCz7hDZHF/HXXY6z/xXRfHusFhlIrQL9ySjH6fsULExEv2aYY8eAt4wy8fJisWm
         n8ffbO8w5F74TA4Q1TfCm3ZWFRzMDBquCYJ+4ChGwfV1riwQ8NiNJ6sq6KGVYXTaLebb
         gnCMM6PlD7ekK7H8Mzd6QkoUQHDnPDv2ZvcC7fxPnUFm0/vVVQgBaWHrbXBE8y0dOrxH
         Kpo0yxYmA+yqaSBFkRdVbZYMU72P3m+BtTuLlNQLXXn/EtJApDQabViX3Zt9iU0JIV9V
         2TEStimqNF47fhemL3buFNJbdElAs7K21MM0QgLrGzu0/GPnJsNJX6NOWCZJ2ws1G5jd
         Q1dw==
X-Gm-Message-State: APjAAAWgCwtzprV6Inl5lzaMf7JqEIORqozM9FUm82hRe1pWv7V0ap/d
        GBejL1PeGNJs5Wb86iiNG4bAQG0U598u6LalcOiqqg==
X-Google-Smtp-Source: APXvYqzthjCcE9Zr5oKmkbiWubbD4WVFzx4CDo7PmlTtn60lZH2RU/KXqgdahf/7GYJkHC59oGbuIfVRpjuGd0BjkIw=
X-Received: by 2002:a2e:9610:: with SMTP id v16mr21434215ljh.88.1575990513036;
 Tue, 10 Dec 2019 07:08:33 -0800 (PST)
MIME-Version: 1.0
References: <20191206160007.331801-1-jean.pihet@newoldbits.com>
 <20191206160007.331801-4-jean.pihet@newoldbits.com> <2efd2981-73d1-6975-a385-871809ec43f1@ti.com>
 <CAORVsuU8b1-50STYAbY7CJ-VkLWXHbEz0dDCfLYfS4YM36vSgg@mail.gmail.com>
 <6d6808af-77b3-72b2-b247-58ed033cb4dc@ti.com> <CAORVsuXehEMi0xy6bm_OZuUowvx0K_Ogp2tXAjeruck3mYX=PQ@mail.gmail.com>
 <b56f079f-9fc0-c745-6c39-384e76896d21@ti.com>
In-Reply-To: <b56f079f-9fc0-c745-6c39-384e76896d21@ti.com>
From:   Jean Pihet <jean.pihet@newoldbits.com>
Date:   Tue, 10 Dec 2019 16:08:21 +0100
Message-ID: <CAORVsuUj2QFaATk2vvwLAqdyiUVhao8QMn9kSgZza_xSkzLm6w@mail.gmail.com>
Subject: Re: [PATCH 3/3] TI QSPI: optimize transfers for dual and quad read
To:     Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Mark Brown <broonie@kernel.org>, Tero Kristo <t-kristo@ti.com>,
        linux-omap@vger.kernel.org, linux-spi@vger.kernel.org,
        Ryan Barnett <ryan.barnett@rockwellcollins.com>,
        Conrad Ratschan <conrad.ratschan@rockwellcollins.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Vignesh,

On Tue, Dec 10, 2019 at 2:17 PM Vignesh Raghavendra <vigneshr@ti.com> wrote:
>
>
>
> On 10/12/19 6:31 pm, Jean Pihet wrote:
> > On Tue, Dec 10, 2019 at 1:55 PM Vignesh Raghavendra <vigneshr@ti.com> wrote:
> >>
> >>
> >>
> >> On 10/12/19 5:55 pm, Jean Pihet wrote:
> >>> Hi Vignesh,
> >>>
> >>> On Tue, Dec 10, 2019 at 9:40 AM Vignesh Raghavendra <vigneshr@ti.com> wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 06/12/19 9:30 pm, Jean Pihet wrote:
> >>>>> By reading the 32 bits data register and copy the contents to the
> >>>>> receive buffer, according to the single/dual/quad read mode and
> >>>>> the data length to read.
> >>>>>
> >>>>> The speed improvement is 3.5x using quad read.
> >>>>> ---
> >>>>>  drivers/spi/spi-ti-qspi.c | 48 ++++++++++++++++++++++++++-------------
> >>>>>  1 file changed, 32 insertions(+), 16 deletions(-)
> >>>>>
> >>>>> diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
> >>>>> index 13916232a959..65ec3bcb25ae 100644
> >>>>> --- a/drivers/spi/spi-ti-qspi.c
> >>>>> +++ b/drivers/spi/spi-ti-qspi.c
> >>>>> @@ -313,24 +313,25 @@ static int qspi_write_msg(struct ti_qspi *qspi, struct spi_transfer *t,
> >>>>>  static int qspi_read_msg(struct ti_qspi *qspi, struct spi_transfer *t,
> >>>>>                        int count)
> >>>>>  {
> >>>>> -     int wlen;
> >>>>>       unsigned int cmd;
> >>>>> +     u32 rx;
> >>>>>       u8 *rxbuf;
> >>>>> +     u8 xfer_len;
> >>>>>
> >>>>>       rxbuf = t->rx_buf;
> >>>>>       cmd = qspi->cmd;
> >>>>> +     /* Optimize the transfers for dual and quad read */
> >>>>>       switch (t->rx_nbits) {
> >>>>> -     case SPI_NBITS_DUAL:
> >>>>> -             cmd |= QSPI_RD_DUAL;
> >>>>> -             break;
> >>>>>       case SPI_NBITS_QUAD:
> >>>>> -             cmd |= QSPI_RD_QUAD;
> >>>>> +             cmd |= QSPI_RD_QUAD | QSPI_WLEN(32);
> >>>>
> >>>> Why does QUAD mode mean 32 bit words?
> >>> This is based on the assumption that every transfer is multiple of 8
> >>> clock cycles.
> >>> For SPI flash devices where bits_per_word is 8, the original code
> >>> always reads data by 1 byte, which
> >>> can be optimized.
> >>>
> >>>>
> >>>> IO mode and word size are independent of each other. If you want to
> >>>> optimize for speed, why not set FLEN field to max and WLEN to max and
> >>>> use ti_qspi_adjust_op_size to clamp max read size to 4096 words when
> >>>> required. This should work irrespective of IO modes.
> >>>> Driver already does something similar to this in the write path.
> >>>
> >>> Ok! A new patch series is coming.
> >>>
> >>>>
> >>>>> +             break;
> >>>>> +     case SPI_NBITS_DUAL:
> >>>>> +             cmd |= QSPI_RD_DUAL | QSPI_WLEN(16);
> >>>>>               break;
> >>>>>       default:
> >>>>> -             cmd |= QSPI_RD_SNGL;
> >>>>> +             cmd |= QSPI_RD_SNGL | QSPI_WLEN(8);
> >>>>>               break;
> >>>>>       }
> >>>>> -     wlen = t->bits_per_word >> 3;   /* in bytes */
> >>>>>
> >>>>>       while (count) {
> >>>>>               dev_dbg(qspi->dev, "rx cmd %08x dc %08x\n", cmd, qspi->dc);
> >>>>> @@ -342,19 +343,34 @@ static int qspi_read_msg(struct ti_qspi *qspi, struct spi_transfer *t,
> >>>>>                       dev_err(qspi->dev, "read timed out\n");
> >>>>>                       return -ETIMEDOUT;
> >>>>>               }
> >>>>> -             switch (wlen) {
> >>>>> -             case 1:
> >>>>> -                     *rxbuf = readb(qspi->base + QSPI_SPI_DATA_REG);
> >>>>> +
> >>>>> +             /* Optimize the transfers for dual and quad read */
> >>>>> +             rx = readl(qspi->base + QSPI_SPI_DATA_REG);
> >>>>> +             switch (t->rx_nbits) {
> >>>>> +             case SPI_NBITS_QUAD:
> >>>>> +                     if (count >= 1)
> >>>>> +                             *rxbuf++ = rx >> 24;
> >>>>> +                     if (count >= 2)
> >>>>> +                             *rxbuf++ = rx >> 16;
> >>>>> +                     if (count >= 3)
> >>>>> +                             *rxbuf++ = rx >> 8;
> >>>>> +                     if (count >= 4)
> >>>>> +                             *rxbuf++ = rx;
> >>>>> +                     xfer_len = min(count, 4);
> >>>>>                       break;
> >>>>> -             case 2:
> >>>>> -                     *((u16 *)rxbuf) = readw(qspi->base + QSPI_SPI_DATA_REG);
> >>>>> +             case SPI_NBITS_DUAL:
> >>>>> +                     if (count >= 1)
> >>>>> +                             *rxbuf++ = rx >> 8;
> >>>>> +                     if (count >= 2)
> >>>>> +                             *rxbuf++ = rx;
> >>>>> +                     xfer_len = min(count, 2);
> >>>>>                       break;
> >>>>> -             case 4:
> >>>>> -                     *((u32 *)rxbuf) = readl(qspi->base + QSPI_SPI_DATA_REG);
> >>>>> +             default:
> >>>>> +                     *rxbuf++ = rx;
> >>>>> +                     xfer_len = 1;
> >>>>>                       break;
> >>>>
> >>>> This will fail in case of t->rx_nbits = 1 and t->bits_per_word = 32
> >>>> (1 bit SPI bus bit slave with 32-bit addressable registers)
> >>> I do not see why this would fail. If bits_per_word is 32, count (in
> >>> bytes) is a multiple of 4 and 1 byte will be read every time the loop
> >>> runs.
> >>> Is that correct? Can you elaborate more on why this would fail?
> >>>
> >>
> >> With t->rx_nbits = 1 and t->bits_per_word = 32, controller should always
> >> read in 4 byte chunks on the SPI bus, but we have:
> >>
> >>>>> +             cmd |= QSPI_RD_SNGL | QSPI_WLEN(8);
> >>
> >> which sets word size to 8 bits and thus breaks the transaction to 1 byte
> >> chunks on the bus, which is bad.
> >
> > In that case there are 4 1-byte reads on the bus, which succeeds. The
> > trace on the logic analyzer shows 4 times 8 clock cycles.
> >
>
> Ah, sorry, there is no CS toggle, so this case will work. Although its
> less efficient as you could have set WLEN to 32 and read entire
> QSPI_SPI_DATA_REG in one transaction.
>
> But this patch definitely changes the behvior when t->rx_nbits = 4 and
> t->bits_per_word = 32. Previous code did:
>
>                *((u32 *)rxbuf) = readl(qspi->base + QSPI_SPI_DATA_REG);
>
> This patch does:
>
> +             rx = readl(qspi->base + QSPI_SPI_DATA_REG);
>                 [...]
> +             case SPI_NBITS_QUAD:
> +                     if (count >= 1)
> +                             *rxbuf++ = rx >> 24;
> +                     if (count >= 2)
> +                             *rxbuf++ = rx >> 16;
> +                     if (count >= 3)
> +                             *rxbuf++ = rx >> 8;
> +                     if (count >= 4)
> +                             *rxbuf++ = rx;
>
>
> So there is change in the endianess...
Oh! The cases where bits_per_word is different than 8 definitely needs
more thinking. I have tested the patches
with SPI flash only. How to test it with 32 bits per word?

Thanks & regards;
Jean

>
> --
> Regards
> Vignesh
