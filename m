Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02DA2116C70
	for <lists+linux-spi@lfdr.de>; Mon,  9 Dec 2019 12:42:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbfLILmz (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Dec 2019 06:42:55 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33744 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727394AbfLILmz (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 9 Dec 2019 06:42:55 -0500
Received: by mail-lj1-f194.google.com with SMTP id 21so15280593ljr.0
        for <linux-spi@vger.kernel.org>; Mon, 09 Dec 2019 03:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=newoldbits-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7k3HlCqaKFshxuRHlxcMcV65OGrK6r6/WLyijqH8PHM=;
        b=wEs4Q4f4h9+mcGw8QXMG/lZm+jeZv1DlutXnCJjH5D4T75klWomlwNXYNZfWnI789T
         3KaW7IeIbtbD/tr7DySCTwzxdJHgyptOh50d0VFK4ZRQcR3sgHB0BqhwCS7n8Td3SOlK
         2mmDBKV+LVzO2vX6pzAGjH+tr1s3V1LKCBhMxDZLPlD26F6cxxSA/AkBqUbRFQczNE2i
         NbORkEqkJQ8GdK7N4tTDb2/5Zq1DUJdP2298gZe+i6Q+0Q0mEN6yDX4cwW+X+Kc+CFAq
         lmmffY01ZRU0Pr/HSyshuNdAjRp27WuBvkSSWlRRXGW5moYeFYcpImACTMHDYKSPo5lY
         CENA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7k3HlCqaKFshxuRHlxcMcV65OGrK6r6/WLyijqH8PHM=;
        b=Bv4TFnExfUc/0kFxw2Nq6DH96azulj8z376SPEhMUTkBQa2To90t0w1hSvJy25pyJh
         f8VWzI9wJli/KU0bS+bOdwWIiskGNBGKpeJdFGmCEY1g88wK/CRDBTy4ZEC0Hu+8bLln
         PsZqgrxaRsvT/o3ImNbnDVZHIv9la88i+5s3hb2cGoSzSoA1z2SFmmQEjsBrrt6TwzkY
         +xTCdVVqvG8WIW/cJgM1iWhQPR79tws62ApJcf0PNfeovMF4SlFS27DBly3ix7bFOIwK
         i2TgPP0nyQ+TPAvGepyM224+c3WIDopB7e3DR/HR762JONBkvWl2WGjd4kXhPFToLENi
         hTig==
X-Gm-Message-State: APjAAAWixiIzqQmdlQHxpb4ct3ZOEudTclFXfp01baRiwxRKCYUXnV11
        xzPS+nYiUkrIesLWUw9WaQaEbeMGCFEav+uqqer43w==
X-Google-Smtp-Source: APXvYqw0T3/BP2qTUy5KZTJ24NlMl4YcGlVN5Q5PVe+W2NsYXmdjjq8UF3oOlfV1ZcItNT6zg5MOwofmdztViVzdWUg=
X-Received: by 2002:a2e:99cd:: with SMTP id l13mr2437277ljj.243.1575891773189;
 Mon, 09 Dec 2019 03:42:53 -0800 (PST)
MIME-Version: 1.0
References: <20191206160007.331801-1-jean.pihet@newoldbits.com>
 <20191206160007.331801-3-jean.pihet@newoldbits.com> <2ea31c73-13ee-a51e-e8b7-69cbe3b83c43@ti.com>
In-Reply-To: <2ea31c73-13ee-a51e-e8b7-69cbe3b83c43@ti.com>
From:   Jean Pihet <jean.pihet@newoldbits.com>
Date:   Mon, 9 Dec 2019 12:42:42 +0100
Message-ID: <CAORVsuX10LqQhf8t0x+=xJs2A9pA2eCT2uKUYb4TAhYn08=2ug@mail.gmail.com>
Subject: Re: [PATCH 2/3] TI QSPI: support large flash devices
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

Hi Vignesh,

On Mon, Dec 9, 2019 at 11:27 AM Vignesh Raghavendra <vigneshr@ti.com> wrote:
>
>
>
> On 06/12/19 9:30 pm, Jean Pihet wrote:
> > The TI QSPI IP has limitations:
> > - the MMIO region is 64MB in size
> > - in non-MMIO mode, the transfer can handle 4096 words max.
> >
> > Add support for bigger devices.
> > Use MMIO and DMA transfers below the 64MB boundary, use
> > software generated transfers above.
>
> Could you change the $subject prefix to be "spi: spi-ti-qspi:"

Yes sure.

>
>
> [...]
>
> > -574,6 +601,7 @@ static int ti_qspi_exec_mem_op(struct spi_mem *mem,
> >
> >  static const struct spi_controller_mem_ops ti_qspi_mem_ops = {
> >       .exec_op = ti_qspi_exec_mem_op,
> > +     .adjust_op_size = ti_qspi_adjust_op_size,
> >  };
> >
> >  static int ti_qspi_start_transfer_one(struct spi_master *master,
> > @@ -599,12 +627,11 @@ static int ti_qspi_start_transfer_one(struct spi_master *master,
> >       frame_len_words = 0;
> >       list_for_each_entry(t, &m->transfers, transfer_list)
> >               frame_len_words += t->len / (t->bits_per_word >> 3);
> > -     frame_len_words = min_t(unsigned int, frame_len_words, QSPI_FRAME);
> >
> >       /* setup command reg */
> >       qspi->cmd = 0;
> >       qspi->cmd |= QSPI_EN_CS(spi->chip_select);
> > -     qspi->cmd |= QSPI_FLEN(frame_len_words);
> > +     qspi->cmd |= QSPI_FLEN(QSPI_FRAME);
> >
>
> Hmm, change itself is harmless. But what is the motivation behind the
> change?
Indeed this change does not hurt but is required to prevent an invalid
FLEN value.

Here are the details:
- t->len is in bytes,
- the length passed to qspi_transfer_msg is in bytes,
- frame_len_words is the number of words in the SPI model,
- the words as used by the TI QSPI IP is not the same as
frame_len_words. In TI QSPI the word size depends on the number of
I/Os i in use (SPI_NBITS_xxx and op->data.buswidth).

For example a quad I/O transfer with t->bits_per_word=8 generates 4
bytes of data every 8 clock cycles. In this case frame_len_words =
16384. The maximum of bytes transferred by TI QSPI is 4096 * 4 =
16384. Setting FLEN to frame_len_words leads to an invalid value (max
value is 0xFFF + 1).

So this changes takes the I/O mode into account by limiting the
maximum number of bytes per frame in ti_qspi_adjust_op_size, by
programming FLEN with the maximum allowed value and by stopping the
transfer when the data is transferred.

Does this make sense?

Regards,
Jean
