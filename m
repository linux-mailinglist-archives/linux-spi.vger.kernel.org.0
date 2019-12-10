Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 773E0118910
	for <lists+linux-spi@lfdr.de>; Tue, 10 Dec 2019 14:01:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbfLJNBj (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 10 Dec 2019 08:01:39 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39143 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727462AbfLJNBj (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 10 Dec 2019 08:01:39 -0500
Received: by mail-lj1-f193.google.com with SMTP id e10so19765289ljj.6
        for <linux-spi@vger.kernel.org>; Tue, 10 Dec 2019 05:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=newoldbits-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u4ChaaEY/hOtAz04gGcHyIl/7pfalBe0U/T2QSu07W8=;
        b=iGQpSPNimn2HAbE2qCv+NoECRp1mqJnE5XoYx06zuaOQBRSHMVpigiN+ou3S+vW/h9
         lvL3zQzFxCKzECY/qKigJTv0oCl6jFO65IaxC6LOL0q6xNfnkEjmVv6spmp4vXErspbR
         bo87XhHk4n+ZBlkc8TiEA0ETAW3i773ASP1TNZ0rQomR+Wmq7/nYRJyBQ5m4j5p7QZjt
         pNqmHj5m4yMvnSpRWg548rnyLN8wVtaII4Kvl92p516xdFLUIKLPU8PNIeAAvidTecYL
         x4rSncQnkt+hNsZCd5UZ9Z9eXfk6FcWfnH9xylQi48AEouu9chkIMeGKx4EhIokSMHN/
         EXZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u4ChaaEY/hOtAz04gGcHyIl/7pfalBe0U/T2QSu07W8=;
        b=obLnskScndCiD/hNeGbo3FzZT/wMTWCJS4eq5cze0jTWAZFhYO6CklKFr8iir1wM/7
         89UpFdgCIFerGWNFIqx4JFg6Bjw6/5r5dLpHtFRqMBRCuUEBbkEENi+GKIdY5EUGln4T
         MsVXAMuBnd7XbZkyypc4H8zkXi6mYR5kFh9M+AoEGm2riBD3prxAwtVRMAufdu3UecE+
         Bj/fLIpOm0NtuhScEWOpc8xgDH2V3S7WDR5uI7lIY/VA0Aid331tXA/RMAMam6wJPC+3
         5Y6jywPMBirF+2qiT1IJYRgcAnTKDGappLQncJxJzCT2ATvHXMZbgpN2xM0GGAEZpx9Y
         8WLg==
X-Gm-Message-State: APjAAAVY2253vSguLRgTjpW4HZgZxr/vc3jb3FMseLP6ecFJoABf2fIZ
        ayl8Z6EXhEb2hQlgk0KZXomIBBMegEAyif7zNI08mg==
X-Google-Smtp-Source: APXvYqy71XR/BcLHxLOQhJogWscWwSmdzmOd1nFJjAZrQoR4qqQiDe/dhrz0LIQbBA2hFEaGceGQcNlOOxCOfJox07Y=
X-Received: by 2002:a2e:7816:: with SMTP id t22mr20497555ljc.161.1575982897360;
 Tue, 10 Dec 2019 05:01:37 -0800 (PST)
MIME-Version: 1.0
References: <20191206160007.331801-1-jean.pihet@newoldbits.com>
 <20191206160007.331801-4-jean.pihet@newoldbits.com> <2efd2981-73d1-6975-a385-871809ec43f1@ti.com>
 <CAORVsuU8b1-50STYAbY7CJ-VkLWXHbEz0dDCfLYfS4YM36vSgg@mail.gmail.com> <6d6808af-77b3-72b2-b247-58ed033cb4dc@ti.com>
In-Reply-To: <6d6808af-77b3-72b2-b247-58ed033cb4dc@ti.com>
From:   Jean Pihet <jean.pihet@newoldbits.com>
Date:   Tue, 10 Dec 2019 14:01:26 +0100
Message-ID: <CAORVsuXehEMi0xy6bm_OZuUowvx0K_Ogp2tXAjeruck3mYX=PQ@mail.gmail.com>
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

On Tue, Dec 10, 2019 at 1:55 PM Vignesh Raghavendra <vigneshr@ti.com> wrote:
>
>
>
> On 10/12/19 5:55 pm, Jean Pihet wrote:
> > Hi Vignesh,
> >
> > On Tue, Dec 10, 2019 at 9:40 AM Vignesh Raghavendra <vigneshr@ti.com> wrote:
> >>
> >>
> >>
> >> On 06/12/19 9:30 pm, Jean Pihet wrote:
> >>> By reading the 32 bits data register and copy the contents to the
> >>> receive buffer, according to the single/dual/quad read mode and
> >>> the data length to read.
> >>>
> >>> The speed improvement is 3.5x using quad read.
> >>> ---
> >>>  drivers/spi/spi-ti-qspi.c | 48 ++++++++++++++++++++++++++-------------
> >>>  1 file changed, 32 insertions(+), 16 deletions(-)
> >>>
> >>> diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
> >>> index 13916232a959..65ec3bcb25ae 100644
> >>> --- a/drivers/spi/spi-ti-qspi.c
> >>> +++ b/drivers/spi/spi-ti-qspi.c
> >>> @@ -313,24 +313,25 @@ static int qspi_write_msg(struct ti_qspi *qspi, struct spi_transfer *t,
> >>>  static int qspi_read_msg(struct ti_qspi *qspi, struct spi_transfer *t,
> >>>                        int count)
> >>>  {
> >>> -     int wlen;
> >>>       unsigned int cmd;
> >>> +     u32 rx;
> >>>       u8 *rxbuf;
> >>> +     u8 xfer_len;
> >>>
> >>>       rxbuf = t->rx_buf;
> >>>       cmd = qspi->cmd;
> >>> +     /* Optimize the transfers for dual and quad read */
> >>>       switch (t->rx_nbits) {
> >>> -     case SPI_NBITS_DUAL:
> >>> -             cmd |= QSPI_RD_DUAL;
> >>> -             break;
> >>>       case SPI_NBITS_QUAD:
> >>> -             cmd |= QSPI_RD_QUAD;
> >>> +             cmd |= QSPI_RD_QUAD | QSPI_WLEN(32);
> >>
> >> Why does QUAD mode mean 32 bit words?
> > This is based on the assumption that every transfer is multiple of 8
> > clock cycles.
> > For SPI flash devices where bits_per_word is 8, the original code
> > always reads data by 1 byte, which
> > can be optimized.
> >
> >>
> >> IO mode and word size are independent of each other. If you want to
> >> optimize for speed, why not set FLEN field to max and WLEN to max and
> >> use ti_qspi_adjust_op_size to clamp max read size to 4096 words when
> >> required. This should work irrespective of IO modes.
> >> Driver already does something similar to this in the write path.
> >
> > Ok! A new patch series is coming.
> >
> >>
> >>> +             break;
> >>> +     case SPI_NBITS_DUAL:
> >>> +             cmd |= QSPI_RD_DUAL | QSPI_WLEN(16);
> >>>               break;
> >>>       default:
> >>> -             cmd |= QSPI_RD_SNGL;
> >>> +             cmd |= QSPI_RD_SNGL | QSPI_WLEN(8);
> >>>               break;
> >>>       }
> >>> -     wlen = t->bits_per_word >> 3;   /* in bytes */
> >>>
> >>>       while (count) {
> >>>               dev_dbg(qspi->dev, "rx cmd %08x dc %08x\n", cmd, qspi->dc);
> >>> @@ -342,19 +343,34 @@ static int qspi_read_msg(struct ti_qspi *qspi, struct spi_transfer *t,
> >>>                       dev_err(qspi->dev, "read timed out\n");
> >>>                       return -ETIMEDOUT;
> >>>               }
> >>> -             switch (wlen) {
> >>> -             case 1:
> >>> -                     *rxbuf = readb(qspi->base + QSPI_SPI_DATA_REG);
> >>> +
> >>> +             /* Optimize the transfers for dual and quad read */
> >>> +             rx = readl(qspi->base + QSPI_SPI_DATA_REG);
> >>> +             switch (t->rx_nbits) {
> >>> +             case SPI_NBITS_QUAD:
> >>> +                     if (count >= 1)
> >>> +                             *rxbuf++ = rx >> 24;
> >>> +                     if (count >= 2)
> >>> +                             *rxbuf++ = rx >> 16;
> >>> +                     if (count >= 3)
> >>> +                             *rxbuf++ = rx >> 8;
> >>> +                     if (count >= 4)
> >>> +                             *rxbuf++ = rx;
> >>> +                     xfer_len = min(count, 4);
> >>>                       break;
> >>> -             case 2:
> >>> -                     *((u16 *)rxbuf) = readw(qspi->base + QSPI_SPI_DATA_REG);
> >>> +             case SPI_NBITS_DUAL:
> >>> +                     if (count >= 1)
> >>> +                             *rxbuf++ = rx >> 8;
> >>> +                     if (count >= 2)
> >>> +                             *rxbuf++ = rx;
> >>> +                     xfer_len = min(count, 2);
> >>>                       break;
> >>> -             case 4:
> >>> -                     *((u32 *)rxbuf) = readl(qspi->base + QSPI_SPI_DATA_REG);
> >>> +             default:
> >>> +                     *rxbuf++ = rx;
> >>> +                     xfer_len = 1;
> >>>                       break;
> >>
> >> This will fail in case of t->rx_nbits = 1 and t->bits_per_word = 32
> >> (1 bit SPI bus bit slave with 32-bit addressable registers)
> > I do not see why this would fail. If bits_per_word is 32, count (in
> > bytes) is a multiple of 4 and 1 byte will be read every time the loop
> > runs.
> > Is that correct? Can you elaborate more on why this would fail?
> >
>
> With t->rx_nbits = 1 and t->bits_per_word = 32, controller should always
> read in 4 byte chunks on the SPI bus, but we have:
>
> >>> +             cmd |= QSPI_RD_SNGL | QSPI_WLEN(8);
>
> which sets word size to 8 bits and thus breaks the transaction to 1 byte
> chunks on the bus, which is bad.

In that case there are 4 1-byte reads on the bus, which succeeds. The
trace on the logic analyzer shows 4 times 8 clock cycles.

>
> Regards
> Vignesh
>
> > Thanks for reviewing, regards,
> > Jean
> >
> >>
> >> bits_per_word indicate the address granularity within SPI Slave
> >> (represented by WLEN field in TI QSPI) and rx_nbits tells about buswidth
> >> (bits received per bus clock)
> >>
> >>>               }
> >>> -             rxbuf += wlen;
> >>> -             count -= wlen;
> >>> +             count -= xfer_len;
> >>>       }
> >>>
> >>>       return 0;
> >>>
> >>
> >> --
> >> Regards
> >> Vignesh
>
> --
> Regards
> Vignesh
