Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 263A2377122
	for <lists+linux-spi@lfdr.de>; Sat,  8 May 2021 12:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbhEHKED (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 8 May 2021 06:04:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:47740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229583AbhEHKED (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Sat, 8 May 2021 06:04:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 814AF60FE9
        for <linux-spi@vger.kernel.org>; Sat,  8 May 2021 10:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620468182;
        bh=pZTgFlc/lmGLJbRrWOtHC31d0fXUeUgvITWvqQczdfo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ABV0bXgfmXXkIHN2K1z1Bm645qyLtw/Bol0p3PqMrvButFNHvalDF7tRICPW6YzmM
         WiiISzRUMxIp7GrqufkliVQc69GcNOILBATaws+7VR4Rz46qQQo1OAdjWaLqYRneQc
         v+Ngo6/mnFU2MUSc7JaE5yCsKnPpG99wVTuvNC+oouWdDAolOZ8+RxQ3TRjfPIz07i
         v1Lw8130p3oNeIlEOSAwvFAhDFYcI4XjOUd+PgTIzEDIMGbfxwRcZFSICMKs5ZK1sS
         1UwDShcIysT7uZ8Ie4+qwfNO5NzQqmUFOXosPuUMeFlWOD99nZkl5Tu7Q0LKJPdW2q
         J37wo0Br5ESug==
Received: by mail-lj1-f178.google.com with SMTP id y9so14712239ljn.6
        for <linux-spi@vger.kernel.org>; Sat, 08 May 2021 03:03:02 -0700 (PDT)
X-Gm-Message-State: AOAM5334qWBgigSMRqDPx0+QKVW0sWRdWB+i3Wa1zt0YWE4V//m9E9r3
        Rw4MX5mMN9HZZ2jUoFuzAV1PByNC355fJczzmwQ=
X-Google-Smtp-Source: ABdhPJynBVmLFmkqwuVcqbbb/jwrsFVSeXj74uDY0Ve9SrRuYci957j0sCRNMnnR8R1oxwkcF/yvoDDWgbEOaxlWbrw=
X-Received: by 2002:a2e:9e53:: with SMTP id g19mr12042388ljk.58.1620468180914;
 Sat, 08 May 2021 03:03:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210507215319.3882138-1-jonathan.lemon@gmail.com>
 <CAPybu_0eWaEdtaUWAZUaBDGonX7cjeLNCTszsCDEHrJeEC8QGQ@mail.gmail.com>
 <3E382801-224D-4B11-961D-4822F51F5496@gmail.com> <0B4232D1-E80F-404A-B388-C53EFDF70DDA@gmail.com>
In-Reply-To: <0B4232D1-E80F-404A-B388-C53EFDF70DDA@gmail.com>
From:   Ricardo Ribalda Delgado <ribalda@kernel.org>
Date:   Sat, 8 May 2021 12:02:44 +0200
X-Gmail-Original-Message-ID: <CAPybu_2882snhGLqWm4pyoVaeK8yQwixX_vRy38Zn28ktOKKAA@mail.gmail.com>
Message-ID: <CAPybu_2882snhGLqWm4pyoVaeK8yQwixX_vRy38Zn28ktOKKAA@mail.gmail.com>
Subject: Re: [PATCH] spi: xilinx: Inhibit transmitter while filling TX FIFO
To:     Jonathan Lemon <jonathan.lemon@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Jonathan

On Sat, May 8, 2021 at 4:45 AM Jonathan Lemon <jonathan.lemon@gmail.com> wr=
ote:
>
> On 7 May 2021, at 17:46, Jonathan Lemon wrote:
>
> > On 7 May 2021, at 16:02, Ricardo Ribalda Delgado wrote:
> >
> >> Hi Jonathan
> >>
> >> Thanks for your patch.
> >>
> >> On Fri, May 7, 2021 at 11:53 PM Jonathan Lemon
> >> <jonathan.lemon@gmail.com> wrote:
> >>>
> >>> Contrary to the comment in xilinx_spi_txrx_bufs(), the transmitter
> >>> was not disabled on entry.  On my particular board, when sending a
> >>> PP
> >>> sequence, the first address byte was clocked out 3 times, writing
> >>> data
> >>> into the wrong location, and generally locking up the chip.
> >>
> >> Sorry, what do you mean by PP sequence?
> >>
> >> By clocked out 3 times you mean that the sequence is sent like
> >> B0........B1.........B2
> >> instead of:
> >> B0B1B2
> >
> > PP: Page program.  When I=E2=80=99m trying to write to the flash, the
> > sequence
> > [opcode 02][A1 A2 A3][D1 D2 ..] is sent.  The result is a flash write
> > at location [A1 A1 A1] =3D [A2 A3 D1 D2 ...]
> >
> > In other words, the first byte of the address appears to have been
> > sent to the chip 3x.
> >
> >
> >> If your hardware supports IRQ. can you try forcing use_irq to true?
> >
> > Will try this in a bit.  The hw does have an irq registered, but it
> > it isn't always set, as it depends on how many how many bytes the
> > spi_transfer sets.  So sometimes it will set use_irq, and sometimes
> > not.
>
> So I tried the following change:
>
> -       if (xspi->irq >=3D 0 &&  remaining_words > xspi->buffer_size) {
> +       if (xspi->irq >=3D 0) {
>
> And that also allows writes to to through successfully.   Perhaps
> this is a simpler change that would work?

It was just a test... we do not want to disable the non-irq mode,
because for small operations it is much faster.

I think this probes that it might be a timming issue. I would really
like to see the output from your logic analyser/chipscope/

Thanks :)

> --
> Jonathan
