Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50BBB1800DA
	for <lists+linux-spi@lfdr.de>; Tue, 10 Mar 2020 15:56:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbgCJO4y (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 10 Mar 2020 10:56:54 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44939 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727532AbgCJO4y (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 10 Mar 2020 10:56:54 -0400
Received: by mail-ed1-f67.google.com with SMTP id g19so16658507eds.11;
        Tue, 10 Mar 2020 07:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3tBZ7IlogX5/PA8Gk/q6l+Q+QQ9JEW0HnkSIb+T0XY8=;
        b=BKkCb0vnCaYKiD8zFlTBrP+dwrak2K1qXKhs7nDNLNKtnIMiPtN2hQxnBt4PAYKhVm
         ftDc9lzxtxDHDBYQilawEfB+/4jdxtfctVnRZZ3komg/hxrc9+J1Z+4TELcwNYpfffZ/
         uXzmk7zzExhNfZxqRyj7rnQMtZehQ3betPOcMcz+IHRgdPiciGLiKJoJclokySzsi5jp
         AzMsr8aiaC+GWeuZ/Yw16eKM0YDzDbNgtXgDniiO88jWoT5K6T22Kxqjett1ExJ+AHeg
         7KJLl1c0OgylHvJ/XD05VvrSUO6D891l++3AnPRi6KqDA2qG5XJ1RLTh37VUW0dfttvI
         027g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3tBZ7IlogX5/PA8Gk/q6l+Q+QQ9JEW0HnkSIb+T0XY8=;
        b=Bp183aljcmRWr91l8U+xrVCdfib6WR3VyndatmA24/sCxXdRTznT6xHc4wWTD+qD3e
         2uMVhjSrRkJ1SNQkRr6azonrLC9LyXaFMx+m6NJ1TlgCeVRwtYx35FbMdn02kCu2QiDf
         gq3d9zkhTIWGpWtTfYRzdNcANAd1eAhEyrU3axDDeWRTk43LC8uwo7UvQ1kHQECHXjjg
         Ll8p3h3dTG+l4e2WwLEF4zklyH6B78njI8bblhVvztqIPiQg7EVdhgpr88Q+4WumbNAc
         vL9HkX6MUIk8zV78kNIqja3/nbg6MatOfWg+3ztD9+/YyKcclcUYS4qbxkTGAs5qM3/K
         o7lg==
X-Gm-Message-State: ANhLgQ3dlMVeAKNZr0naxUfuX43551Zhl5RUwyDQCRGOzNgnX/hr6jbN
        tmkqKT+y4eqjJOjJqL5ChYjTrvDYZAs+l3deg7Y=
X-Google-Smtp-Source: ADFU+vvV4BJ5Q01DPTC1SXAIfh/z8Wj4OYX4DvkBj6FtrhuQgaiDZaJI4i0vQNonaDpV/NYMAD4l7KAUvVSi/I0hMjA=
X-Received: by 2002:aa7:d98b:: with SMTP id u11mr23211295eds.318.1583852212265;
 Tue, 10 Mar 2020 07:56:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200310125542.5939-1-olteanv@gmail.com> <615284875b709f602d57e4a4621a83c1@walle.cc>
In-Reply-To: <615284875b709f602d57e4a4621a83c1@walle.cc>
From:   Vladimir Oltean <olteanv@gmail.com>
Date:   Tue, 10 Mar 2020 16:56:39 +0200
Message-ID: <CA+h21hrYoHVDvsxT1EPWhYprL+zNHfE4MW7k4HxiK7ma4ZWn1g@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] NXP DSPI bugfixes and support for LS1028A
To:     Michael Walle <michael@walle.cc>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Esben Haabendal <eha@deif.com>,
        angelo@sysam.it, andrew.smirnov@gmail.com,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Wei Chen <weic@nvidia.com>, Mohamed Hosny <mhosny@nvidia.com>,
        peng.ma@nxp.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Michael,

On Tue, 10 Mar 2020 at 16:11, Michael Walle <michael@walle.cc> wrote:
>

>
> XSPI mode, while now I cannot reproduce the kernel oops anymore, I've
> found two
> other problems (1), (2). Which are likely the same underlying problem.
> DMA mode
> works "better" now, still one problem (3).
>
> (1) It seems like the first write/read/erase after the aborted
> instruction
> don't get through:
>
> # hexdump -C /dev/mtd0
> 00000000  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
> |................|
> *
> [  627.914654] fsl-dspi 2120000.spi: Waiting for transfer to complete
> failed!
> ^C[  627.921649] spi_master spi1: failed to transfer one message from
> queue
>
> #
> # echo huhu > /dev/mtd0
> # hexdump -C /dev/mtd0
> 00000000  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
> |................|
> *
> hexdump: /dev/mtd0: Input/output error
> 003df000
> # echo huhu > /dev/mtd0
> # hexdump -C /dev/mtd0
> 00000000  68 75 68 75 0a ff ff ff  ff ff ff ff ff ff ff ff
> |huhu............|
> 00000010  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
> |................|
> *
> [  642.738905] fsl-dspi 2120000.spi: Waiting for transfer to complete
> failed!
> ^C[  642.745832] spi_master spi1: failed to transfer one message from
> queue
> #
> # flash_erase /dev/mtd0 0 1
> Erasing 4 Kibyte @ 0 -- 100 % complete
> #
> # hexdump -C /dev/mtd0
> 00000000  68 75 68 75 0a ff ff ff  ff ff ff ff ff ff ff ff
> |huhu............|
> 00000010  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
> |................|
> *
> hexdump: /dev/mtd0: Input/output error
> 0023d000
> # hexdump -C /dev/mtd0
> 00000000  68 75 68 75 0a ff ff ff  ff ff ff ff ff ff ff ff
> |huhu............|
> 00000010  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
> |................|
> *
>
> (2) Also, reading the flash, every second time there is (reproducibly)
> an
> IO error:
>
> # hexdump -C /dev/mtd0
> 00000000  68 75 68 75 0a ff ff ff  ff ff ff ff ff ff ff ff
> |huhu............|
> 00000010  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
> |................|
> *
> 01000000
> # hexdump -C /dev/mtd0
> 00000000  68 75 68 75 0a ff ff ff  ff ff ff ff ff ff ff ff
> |huhu............|
> 00000010  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
> |................|
> *
> hexdump: /dev/mtd0: Input/output error
> 00dc0000
> # hexdump -C /dev/mtd0
> 00000000  68 75 68 75 0a ff ff ff  ff ff ff ff ff ff ff ff
> |huhu............|
> 00000010  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
> |................|
> *
> 01000000
> # hexdump -C /dev/mtd0
> 00000000  68 75 68 75 0a ff ff ff  ff ff ff ff ff ff ff ff
> |huhu............|
> 00000010  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
> |................|
> *
> hexdump: /dev/mtd0: Input/output error
> 00e6a000
>

Just to be clear, issue 2 is seen only after you abort another
transaction, right?

> (3) Depening on the content length there is also an IO error. Funny
> enough,
> the content is still written to the SPI flash.
>
> # echo -n 1 > /dev/mtd10
> # echo -n 12 > /dev/mtd10
> # echo -n 123 > /dev/mtd10
> # echo -n 1234 > /dev/mtd10
> # echo -n 12345 > /dev/mtd10
> sh: write error: Input/output error
> # echo -n 123456 > /dev/mtd10
> # echo -n 1234567 > /dev/mtd10
> sh: write error: Input/output error
> # echo -n 12345678 > /dev/mtd10
> # echo -n 123456789 > /dev/mtd10
> # echo -n 1234567890 > /dev/mtd10
> # echo -n 12345678901 > /dev/mtd10
> # echo -n 123456789012 > /dev/mtd10
> # echo -n 1234567890123 > /dev/mtd10
> sh: write error: Input/output error
> # echo -n 12345678901234 > /dev/mtd10
> # echo -n 123456789012345 > /dev/mtd10
> sh: write error: Input/output error
> # echo -n 1234567890123456 > /dev/mtd10
> # echo -n 12345678901234567 > /dev/mtd10
> # echo -n 123456789012345678 > /dev/mtd10
>
>
> # flash_erase /dev/mtd10 0 1
> Erasing 4 Kibyte @ 0 -- 100 % complete
> # hexdump -C /dev/mtd10
> 00000000  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
> |................|
> *
> ^C
> # echo -n 12345 > /dev/mtd10
> sh: write error: Input/output error
> # hexdump -C /dev/mtd10
> 00000000  31 32 33 34 35 ff ff ff  ff ff ff ff ff ff ff ff
> |12345...........|
> 00000010  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
> |................|
> *
> ^C
>

For this one, I think the reported message->actual_length is incorrect
in dspi_dma_xfer, which makes spi-mem scream.

>
> -michael
>
> >
> > Vladimir Oltean (7):
> >   spi: spi-fsl-dspi: Don't access reserved fields in SPI_MCR
> >   spi: spi-fsl-dspi: Avoid use-after-free in interrupt mode
> >   spi: spi-fsl-dspi: Fix little endian access to PUSHR CMD and TXDATA
> >   spi: spi-fsl-dspi: Fix bits-per-word acceleration in DMA mode
> >   spi: spi-fsl-dspi: Add support for LS1028A
> >   arm64: dts: ls1028a: Specify the DMA channels for the DSPI
> > controllers
> >   arm64: dts: ls1028a-rdb: Add a spidev node for the mikroBUS
> >
> >  .../boot/dts/freescale/fsl-ls1028a-rdb.dts    |  14 ++
> >  .../arm64/boot/dts/freescale/fsl-ls1028a.dtsi |   6 +
> >  drivers/spi/spi-fsl-dspi.c                    | 188 +++++++++++-------
> >  3 files changed, 134 insertions(+), 74 deletions(-)

Thanks,
-Vladimir
