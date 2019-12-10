Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D144B1187B4
	for <lists+linux-spi@lfdr.de>; Tue, 10 Dec 2019 13:11:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbfLJMLK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 10 Dec 2019 07:11:10 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38424 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727333AbfLJMLJ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 10 Dec 2019 07:11:09 -0500
Received: by mail-lj1-f195.google.com with SMTP id k8so19560667ljh.5
        for <linux-spi@vger.kernel.org>; Tue, 10 Dec 2019 04:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=newoldbits-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GsYcJxpm2M2at5m40Tv+F3e6MbRZ2kQbgAk1/jtt9eY=;
        b=gYPuOc80EwPfttX3HSO19+iyOIkykwcr4cpN8uMt70VzUb8ZofuO3Q3VJwOKMWUzrz
         BoR60Hn3P59MXDMQ0xMrIdCmzDqxmUEQOPIj/iVjg28sDjDeiJ7KUovyOrljqwkCHB9x
         k9wSUCFUTQLIVuo6JFqfZx8+anLThEPFqdjmVJXZ5vMuKSzRQz+PtdTLU2+m5OejtfVt
         QTL2nVRqjsDmQ3HMEwy762i6e0etrKz3qmltTd9lnvkrM/VxbEIeC3mb7KxXAHMxrKhw
         0HK8QzVTvD/Xp22I1oi4oB1NA9sWnGeb6nlpVpbjfGb1BDSY9J2DWiVcuQnbWld9oBi4
         oJ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GsYcJxpm2M2at5m40Tv+F3e6MbRZ2kQbgAk1/jtt9eY=;
        b=EG6DjTLZFk3cWvF84tTN1RBAIbocsriR7fAXP3kMI1MLtr+dYfvFLbmsXZePJKQirg
         f8POom3+H/YpEqj9BGtf+uwZJmtymYieQhO6vUZjm3U3vQ+FQX+lL3qCji7mMyjWd/pM
         D7nK2HirKuz+Gkj/PMISX52vh65ZsKCFusQqOPwqMtvA/CVuMArITuiurjjBvrppfpSU
         75rlT2a6cl/ey2HLB6VsNY7rhkSq0fO7WgFvS8SbAVqtjQubhqu+oMMfOFJ+MnEJyJu6
         WcDX5vG05EdmMKefb8yTrkvXzLi2vp/iXCnmjX9OG21GBGEejAcYE1VkwtkmZppg2c0+
         bK/w==
X-Gm-Message-State: APjAAAXt6mijhS871/KziBMEgBkp5+n6O6shQ3CXtU4byMoHPoQ8xB7Y
        ezIyooZrSekjKhE3fPojyU3n5tPudfjnrBhbssknNg==
X-Google-Smtp-Source: APXvYqx4j92U4xaYpgA6qu4h8BGOZuq4kUojnRS9NmWlZyIhNkuHJjFHfzIvggdsFWRw2VVsbLzY6e2POU9MGgJVxAI=
X-Received: by 2002:a2e:95c4:: with SMTP id y4mr20537268ljh.38.1575979866896;
 Tue, 10 Dec 2019 04:11:06 -0800 (PST)
MIME-Version: 1.0
References: <20191206160007.331801-1-jean.pihet@newoldbits.com>
 <20191206160007.331801-3-jean.pihet@newoldbits.com> <2ea31c73-13ee-a51e-e8b7-69cbe3b83c43@ti.com>
 <CAORVsuX10LqQhf8t0x+=xJs2A9pA2eCT2uKUYb4TAhYn08=2ug@mail.gmail.com> <eab232c1-b521-6a95-8726-5b70e5842d98@ti.com>
In-Reply-To: <eab232c1-b521-6a95-8726-5b70e5842d98@ti.com>
From:   Jean Pihet <jean.pihet@newoldbits.com>
Date:   Tue, 10 Dec 2019 13:10:55 +0100
Message-ID: <CAORVsuWO7RGXUxBZoD-Ww4PE-zPcFCwR1d5yNki02iHot_iOFA@mail.gmail.com>
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

On Tue, Dec 10, 2019 at 9:40 AM Vignesh Raghavendra <vigneshr@ti.com> wrote:
>
> Hi Jean,
>
> On 09/12/19 5:12 pm, Jean Pihet wrote:
> > Hi Vignesh,
> >
> > On Mon, Dec 9, 2019 at 11:27 AM Vignesh Raghavendra <vigneshr@ti.com> wrote:
> >>
> >>
> >>
> >> On 06/12/19 9:30 pm, Jean Pihet wrote:
> >>> The TI QSPI IP has limitations:
> >>> - the MMIO region is 64MB in size
> >>> - in non-MMIO mode, the transfer can handle 4096 words max.
> >>>
> >>> Add support for bigger devices.
> >>> Use MMIO and DMA transfers below the 64MB boundary, use
> >>> software generated transfers above.
> >>
> >> Could you change the $subject prefix to be "spi: spi-ti-qspi:"
> >
> > Yes sure.
> >
> >>
> >>
> >> [...]
> >>
> >>> -574,6 +601,7 @@ static int ti_qspi_exec_mem_op(struct spi_mem *mem,
> >>>
> >>>  static const struct spi_controller_mem_ops ti_qspi_mem_ops = {
> >>>       .exec_op = ti_qspi_exec_mem_op,
> >>> +     .adjust_op_size = ti_qspi_adjust_op_size,
> >>>  };
> >>>
> >>>  static int ti_qspi_start_transfer_one(struct spi_master *master,
> >>> @@ -599,12 +627,11 @@ static int ti_qspi_start_transfer_one(struct spi_master *master,
> >>>       frame_len_words = 0;
> >>>       list_for_each_entry(t, &m->transfers, transfer_list)
> >>>               frame_len_words += t->len / (t->bits_per_word >> 3);
> >>> -     frame_len_words = min_t(unsigned int, frame_len_words, QSPI_FRAME);
> >>>
> >>>       /* setup command reg */
> >>>       qspi->cmd = 0;
> >>>       qspi->cmd |= QSPI_EN_CS(spi->chip_select);
> >>> -     qspi->cmd |= QSPI_FLEN(frame_len_words);
> >>> +     qspi->cmd |= QSPI_FLEN(QSPI_FRAME);
> >>>
> >>
> >> Hmm, change itself is harmless. But what is the motivation behind the
> >> change?
> > Indeed this change does not hurt but is required to prevent an invalid
> > FLEN value.
> >
> > Here are the details:
> > - t->len is in bytes,
> > - the length passed to qspi_transfer_msg is in bytes,
> > - frame_len_words is the number of words in the SPI model,
> > - the words as used by the TI QSPI IP is not the same as
> > frame_len_words.
>
> > In TI QSPI the word size depends on the number of
> > I/Os i in use (SPI_NBITS_xxx and op->data.buswidth).
> >
>
> How did you get this impression? Word size is independent of number of
> SPI I/O lines in use. There can be a slave of 32 bit word size on a
> 1 bit SPI bus (SPI_NBITS_SINGLE).
>
> Flash devices have word size of 1 byte (IOW byte addressable)
> but buswidth can be 1/2/4. A Quad IO flash does not mean word size of 32 bit
> word size.

The assumption is that every transfer is based on 8 clock cycles (byte
addressable) as for the SPI flash and that
the optimization is about getting the most data bytes from every
transfer (32 bits in quad I/O, 16 bits in dual, 8 bits in single).
Is this a valid assumption?

>
>
> > For example a quad I/O transfer with t->bits_per_word=8 generates 4
> > bytes of data every 8 clock cycles.
>
> > In this case frame_len_words =
> > 16384. The maximum of bytes transferred by TI QSPI is 4096 * 4 =
> > 16384. Setting FLEN to frame_len_words leads to an invalid value (max
> > value is 0xFFF + 1).
> >
>
> But we have:
>
>         list_for_each_entry(t, &m->transfers, transfer_list)
>                 frame_len_words += t->len / (t->bits_per_word >> 3);
>
>         /* Clamps max words to 4096 words */
>         frame_len_words = min_t(unsigned int, frame_len_words, QSPI_FRAME);
>
>         /* setup command reg */
>         qspi->cmd = 0;
>         qspi->cmd |= QSPI_EN_CS(spi->chip_select);
>
>         /* FLEN field is set to max of 4095 bytes as */
>         qspi->cmd |= QSPI_FLEN(frame_len_words);
>
> So, without changes in patch 3/3, there is no need to set FLEN to be set to 0xFFF.
> But FLEN needs to be set to even words in case of dual/quad mode as per AM437x TRM
Correct but in that case the number of bytes received for every
transfer is not optimum, i.e. 4x more data
could be transferred in quad I/O.

The solution is to calculate frame_len_words from the bits_per_word
and rx_nbits.

What do you think?

Thanks & regards,
Jean

>
> > So this changes takes the I/O mode into account by limiting the
> > maximum number of bytes per frame in ti_qspi_adjust_op_size, by
> > programming FLEN with the maximum allowed value and by stopping the
> > transfer when the data is transferred.
> >
> > Does this make sense?
>
> >
> > Regards,
> > Jean
> >
>
> --
> Regards
> Vignesh
