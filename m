Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9410B17E671
	for <lists+linux-spi@lfdr.de>; Mon,  9 Mar 2020 19:08:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbgCISIO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Mar 2020 14:08:14 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44020 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726169AbgCISIN (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 9 Mar 2020 14:08:13 -0400
Received: by mail-ed1-f68.google.com with SMTP id dc19so13082375edb.10;
        Mon, 09 Mar 2020 11:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xAWa2cojuZkkGnmDvcA+gmAfwBz3OdVObOaJQDP8T4g=;
        b=iIu0nzZfM3wH8tw+fsFro5LJ1HPa3xAzCcNtbj0mFuJVKTaEfOj8B5t9AXTp+LEW1d
         tlke81LqfThGLCNhwGXS+KFgIiwv3tTyMzIhEBuuKH4F6HG0eGUNI89l/NZr1819sutd
         Sbsk94FsIFXmen/0TsWOg4qbSxPaGXIOcwitspxSHXBaMRotdlcX5T66VRPHAI96iJif
         NbM8UoVGVmsAGBvBzHdBiZWCZ9lrCOUxgnFbHxPHGZqP+vAu8IZ8A+iI8YhNkdaTDQqv
         4TduZYrv8zf+AFMwtBiB0pJuRNPHvN03S1lcxxKySo4BQVPYU1qcYok1skIsajBEfqNJ
         HwrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xAWa2cojuZkkGnmDvcA+gmAfwBz3OdVObOaJQDP8T4g=;
        b=JNtsHOC0g8eEirRzu0XEJSKyKj/DRtXXpWoKZA6ZcwJ44uG7X2P/ahV1NkrUTH/uJc
         /Dr1o792kd04davweeojZKKH524LNO6GgHi6Cqd03m61xLGyrgWED9G0KBlekV+mW+eS
         La9r36qZYn3l2lBw+dkR0BR8PSd/E8uOiQ35GOjGeJbhZQ9DIVbXBPFpKUosAocYwHdA
         MfXUlE8pBzVxPkMXgCJ7GVmOrDzsBoe9uId8trcvv64S138q05kbU2sAfRsK8xORvKhM
         5jYTytukJUxHEwwylRg+ys+AZi5VmznByxxqHyUb2IqTwTwyENYpEXLRMs9XcPZU4vd6
         DT3A==
X-Gm-Message-State: ANhLgQ2jikGJd3iK1JqZW6YcJtjPJqpxWOzTmTjM//5DmNdyKXeoFw9d
        Yvsef821JtSaHt5Ch9t2C73t4VlH7DqhE3AG1nM=
X-Google-Smtp-Source: ADFU+vttptWy4cBLrBdcelMJhEwZiMA6bIS4p+vofMgcfm26uIq3xNqtOSz408lYuci0Vvqebjl057sw1BLGVTbBlQ8=
X-Received: by 2002:a17:906:76c6:: with SMTP id q6mr15596211ejn.176.1583777289739;
 Mon, 09 Mar 2020 11:08:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200309145624.10026-1-olteanv@gmail.com> <20200309145624.10026-3-olteanv@gmail.com>
 <d8e39e402328b962cdbc25316a27eac8@walle.cc>
In-Reply-To: <d8e39e402328b962cdbc25316a27eac8@walle.cc>
From:   Vladimir Oltean <olteanv@gmail.com>
Date:   Mon, 9 Mar 2020 20:07:58 +0200
Message-ID: <CA+h21hp4vC1c00rCgZo_hwQz3cE4dLBHjcgTHvf-+fS9a9VfxQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] spi: spi-fsl-dspi: Fix little endian access to PUSHR
 CMD and TXDATA
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

On Mon, 9 Mar 2020 at 19:59, Michael Walle <michael@walle.cc> wrote:
>
> Am 2020-03-09 15:56, schrieb Vladimir Oltean:
> > From: Vladimir Oltean <vladimir.oltean@nxp.com>
> >
> > In XSPI mode, the 32-bit PUSHR register can be written to separately:
> > the higher 16 bits are for commands and the lower 16 bits are for data.
> >
> > This has nicely been hacked around, by defining a second regmap with a
> > width of 16 bits, and effectively splitting a 32-bit register into 2
> > 16-bit ones, from the perspective of this regmap_pushr.
> >
> > The problem is the assumption about the controller's endianness. If the
> > controller is little endian (such as anything post-LS1046A), then the
> > first 2 bytes, in the order imposed by memory layout, will actually
> > hold
> > the TXDATA, and the last 2 bytes will hold the CMD.
> >
> > So take the controller's endianness into account when performing split
> > writes to PUSHR. The obvious and simple solution would have been to
> > call
> > regmap_get_val_endian(), but that is an internal regmap function and we
> > don't want to change regmap just for this. Therefore, we define the
> > offsets per-instantiation, in the devtype_data structure. This means
> > that we have to know from the driver which controllers are big- and
> > which are little-endian (which is fine, we do, but it makes the device
> > tree binding itself a little redundant except for regmap_config).
> >
> > This patch does not apply cleanly to stable trees, and a punctual fix
> > to
> > the commit cannot be provided given this constraint of lack of access
> > to
> > regmap_get_val_endian(). The per-SoC devtype_data structures (and
> > therefore the premises to fix this bug) have been introduced only a few
> > commits ago, in commit d35054010b57 ("spi: spi-fsl-dspi: Use specific
> > compatible strings for all SoC instantiations")
> >
> > Fixes: 58ba07ec79e6 ("spi: spi-fsl-dspi: Add support for XSPI mode
> > registers")
> > Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> > ---
> >  drivers/spi/spi-fsl-dspi.c | 28 ++++++++++++++++++++++------
> >  1 file changed, 22 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
> > index 0ce26c1cbf62..a8e56abe20ac 100644
> > --- a/drivers/spi/spi-fsl-dspi.c
> > +++ b/drivers/spi/spi-fsl-dspi.c
> > @@ -103,10 +103,6 @@
> >  #define SPI_FRAME_BITS(bits)         SPI_CTAR_FMSZ((bits) - 1)
> >  #define SPI_FRAME_EBITS(bits)                SPI_CTARE_FMSZE(((bits) - 1) >> 4)
> >
> > -/* Register offsets for regmap_pushr */
> > -#define PUSHR_CMD                    0x0
> > -#define PUSHR_TX                     0x2
> > -
> >  #define DMA_COMPLETION_TIMEOUT               msecs_to_jiffies(3000)
> >
> >  struct chip_data {
> > @@ -124,6 +120,12 @@ struct fsl_dspi_devtype_data {
> >       u8                      max_clock_factor;
> >       int                     fifo_size;
> >       int                     dma_bufsize;
> > +     /*
> > +      * Offsets for CMD and TXDATA within SPI_PUSHR when accessed
> > +      * individually (in XSPI mode)
> > +      */
> > +     int                     pushr_cmd;
> > +     int                     pushr_tx;
> >  };
>
> Shouldn't this just read the "little-endian" property of the
> device tree node?

This is exactly what the driver did prior to this commit from 2014:
https://patchwork.kernel.org/patch/4732711/
Since then, "little-endian" and "big-endian" became generic regmap properties.

> Like it worked before with regmap, which takes
> the little-endian/big-endian property into account.
>

So XSPI mode allows you, among other things, to send 32 bits words at a time.
In my opinion this was tested only the big-endian DSPI controllers
(LS1021A, LS1043A etc).
On the little-endian controllers (LS2, LX2, LS1028A) I suspect this
was actually never tested.
The reason why we see it now is because we're "accelerating" even
8-bit words to 32-bit.
So it is incorrect to say "like it worked before": it never worked before.

> If I understand this correctly, this solution would mix the methods
> how the IP endianess is determined. Eg. regmap_xx uses the
> little-endian property and this driver then also uses the compatible
> string to also distinguish between the endianess.
>

Yup. Otherwise we effectively have to duplicate the logic from the
internal regmap_get_val_endian function. I found no other way to
figure out what endianness the regmap_config has. Suggestions welcome.

> -michael
>

Thanks,
-Vladimir
