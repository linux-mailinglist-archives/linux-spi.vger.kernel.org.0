Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE2EC37711F
	for <lists+linux-spi@lfdr.de>; Sat,  8 May 2021 12:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbhEHKCm (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 8 May 2021 06:02:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:47398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229583AbhEHKCl (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Sat, 8 May 2021 06:02:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 675BA61430
        for <linux-spi@vger.kernel.org>; Sat,  8 May 2021 10:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620468100;
        bh=Dg44+170piMGURncVRsGKJxAoxZ/bFZN2ZiXlnl9PPs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FAckYKOylh5fMwq+RypHhmfTxSuChAkmOtMgfIQy0U+ZXOv2Q3TkVhIQnZKiEnzMF
         h8RqZDUBN7hRZZxGIizCArwAVwrGmb9mdYszvkGYeZlO8e9xUskfY6PbUByIEZ+yFP
         mHPxKf0AKKmYHDkeD2O+FL3hfG59fAAaajAIFkvqVuST4oraTo0MmsauC6e4wj2eRY
         WKySC3ImneyMf6XWjL83L5dXM1PagxhNs+m5pS2+yitlMBkOm5cEtW1vZUhp98sOuf
         /bcB5/bUJ8AMlgU7ALFbIuaQmN/q4VlO7ZtQfQXpwKnlVhntjrzDmt2JEVjnmj7as1
         b1P2I+7AgYKdQ==
Received: by mail-lf1-f48.google.com with SMTP id b17so776163lfo.3
        for <linux-spi@vger.kernel.org>; Sat, 08 May 2021 03:01:40 -0700 (PDT)
X-Gm-Message-State: AOAM533Fvtg9iRHsA3kG/7hs/ETDIldenOT49Z4l+Rpgg5i0/jhcTcTm
        d6cKZO3LfN9vbE/7HpC2TK0SzsYZXzjsWwSDdPQ=
X-Google-Smtp-Source: ABdhPJwc9OtHNyXfqMsqwpJFElL4jfeKZ6q7Fe9giogBXXfeJnEmpb4Rwk8eQFfYS1CRARsXlGrQpDv6DKZ7sdOnwdY=
X-Received: by 2002:ac2:5632:: with SMTP id b18mr9295725lff.62.1620468098718;
 Sat, 08 May 2021 03:01:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210507215319.3882138-1-jonathan.lemon@gmail.com>
 <CAPybu_0eWaEdtaUWAZUaBDGonX7cjeLNCTszsCDEHrJeEC8QGQ@mail.gmail.com> <3E382801-224D-4B11-961D-4822F51F5496@gmail.com>
In-Reply-To: <3E382801-224D-4B11-961D-4822F51F5496@gmail.com>
From:   Ricardo Ribalda Delgado <ribalda@kernel.org>
Date:   Sat, 8 May 2021 12:01:22 +0200
X-Gmail-Original-Message-ID: <CAPybu_2zLVCP3672BDALRDyb2sgGchG90MFuZEFd0irdpJW+UA@mail.gmail.com>
Message-ID: <CAPybu_2zLVCP3672BDALRDyb2sgGchG90MFuZEFd0irdpJW+UA@mail.gmail.com>
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

On Sat, May 8, 2021 at 2:47 AM Jonathan Lemon <jonathan.lemon@gmail.com> wr=
ote:
>
> On 7 May 2021, at 16:02, Ricardo Ribalda Delgado wrote:
>
> Hi Jonathan
>
> Thanks for your patch.
>
> On Fri, May 7, 2021 at 11:53 PM Jonathan Lemon <jonathan.lemon@gmail.com>=
 wrote:
>
> Contrary to the comment in xilinx_spi_txrx_bufs(), the transmitter
> was not disabled on entry. On my particular board, when sending a PP
> sequence, the first address byte was clocked out 3 times, writing data
> into the wrong location, and generally locking up the chip.
>
> Sorry, what do you mean by PP sequence?
>
> By clocked out 3 times you mean that the sequence is sent like
> B0........B1.........B2
> instead of:
> B0B1B2
>
> PP: Page program. When I=E2=80=99m trying to write to the flash, the sequ=
ence
> [opcode 02][A1 A2 A3][D1 D2 ..] is sent. The result is a flash write
> at location [A1 A1 A1] =3D [A2 A3 D1 D2 ...]
>
> In other words, the first byte of the address appears to have been
> sent to the chip 3x.

Any chance you could connect chipscope to the spi pins? Or a real
logic analyser?
>
> If your hardware supports IRQ. can you try forcing use_irq to true?
>
> Will try this in a bit. The hw does have an irq registered, but it
> it isn't always set, as it depends on how many how many bytes the
> spi_transfer sets. So sometimes it will set use_irq, and sometimes not.
>
> Fix this by inhibiting the transmitter at initialization time, and
> then enabling/disabling it appropriately.
>
> With this patch, I can successfully read/erase/program the flash.
>
> Can you provide a bit more details about your setup? What core version
> are you using? C_PARAMS? Flash?
>
> Flash: https://media-www.micron.com/-/media/client/global/documents/produ=
cts/data-sheet/nor-flash/serial-nor/n25q/n25q_128mb_3v_65nm.pdf
>
> xlinx-spi: https://www.xilinx.com/support/documentation/ip_documentation/=
axi_quad_spi/v3_2/pg153-axi-quad-spi.pdf

What are your C_PARAMS?

>
> In general, I think it makes more sense to title your patch as:
> Inhibit transfer while idle. Because the current code already inhibits
> before sending data in irq mode.
>
> But irq mode is entered/exited based on t->len:
>
>     if (xspi->irq >=3D 0 &&  remaining_words > xspi->buffer_size) {
>
> So sometimes it will set use_irq, and sometimes not.
>
> The current design tries to limit as much as possible the register
> access and only enable inhibit in irq mode.
>
> In principle, I believe both approaches shall be equally valid, but if
> you have a use case that does not work with the current approach your
> patch is very welcome.
>
> My use case is I have a FPGA with a flash chip on a PCI board, my goal
> is to reflash the firmware through the PCI driver. The existing code
> works for flash reads, but for whatever reason, fails miserably when
> sending the 'page program' write sequence without this patch.

I have been using this for a couple of years now :S




> --
> Jonathan
