Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35506376D26
	for <lists+linux-spi@lfdr.de>; Sat,  8 May 2021 01:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbhEGXEN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 7 May 2021 19:04:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:59790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229836AbhEGXEJ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 7 May 2021 19:04:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6D5AF6146D
        for <linux-spi@vger.kernel.org>; Fri,  7 May 2021 23:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620428588;
        bh=9we+90XkZC7CYYZK5CuqzJKrr6OiS41AMsawdknXwnk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cUQk5Y5IIX9qKA6Rty5WtKQDIzBbkUuznDoKSD4/3uxU//1JVIAbLmICmtCTkeHWJ
         w49lrRC/4/kQd7+/SEeGrB0RrqeCLAms6695BDYt6kVmjGF2Wk5wxngIzrwZvjtO1i
         ZwztnwDRYxrn00vDHRIluk5tAj8aZioONHgDyBRBup7owajVD4fsn/Cy7YIIhSb4iv
         RDG7HvZqrg5AfGSb/+PjOP0j4hn3mBXhx3FjfH7lHjnCbBgff3ZwUxz1GJXt49FLXw
         PIL0OYVyx6G7sfgttpNx1YInU0CHnZSgnCnfiAbe+TPJuLZil9cYVzPrXzzUWxfBNr
         6yeGZsWUEpl9Q==
Received: by mail-lf1-f54.google.com with SMTP id n138so14919961lfa.3
        for <linux-spi@vger.kernel.org>; Fri, 07 May 2021 16:03:08 -0700 (PDT)
X-Gm-Message-State: AOAM532nlqvnhVIqWb9EN8MrCylmVNf8MEmVDqy9bz4+TBOL2eeT/mos
        OuokSxpLIfHCHIue19yV27i6sDZlkLf2FPhEgOk=
X-Google-Smtp-Source: ABdhPJyIqyUo6dp7dk/YD2GzitA9pnyLyvcZEZPQluMiIhgSbJhO9r9tbztThHRfFufrFUmZxXh+5ZsaeoU0+KjFgDs=
X-Received: by 2002:a05:6512:3c6:: with SMTP id w6mr7931458lfp.294.1620428586476;
 Fri, 07 May 2021 16:03:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210507215319.3882138-1-jonathan.lemon@gmail.com>
In-Reply-To: <20210507215319.3882138-1-jonathan.lemon@gmail.com>
From:   Ricardo Ribalda Delgado <ribalda@kernel.org>
Date:   Sat, 8 May 2021 01:02:49 +0200
X-Gmail-Original-Message-ID: <CAPybu_0eWaEdtaUWAZUaBDGonX7cjeLNCTszsCDEHrJeEC8QGQ@mail.gmail.com>
Message-ID: <CAPybu_0eWaEdtaUWAZUaBDGonX7cjeLNCTszsCDEHrJeEC8QGQ@mail.gmail.com>
Subject: Re: [PATCH] spi: xilinx: Inhibit transmitter while filling TX FIFO
To:     Jonathan Lemon <jonathan.lemon@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Jonathan

Thanks for your patch.

On Fri, May 7, 2021 at 11:53 PM Jonathan Lemon <jonathan.lemon@gmail.com> wrote:
>
> Contrary to the comment in xilinx_spi_txrx_bufs(), the transmitter
> was not disabled on entry.  On my particular board, when sending a PP
> sequence, the first address byte was clocked out 3 times, writing data
> into the wrong location, and generally locking up the chip.

Sorry, what do you mean by PP sequence?

By clocked out 3 times you mean that the sequence is sent like
B0........B1.........B2
instead of:
B0B1B2
?

If your hardware supports IRQ. can you try forcing use_irq to true?

>
> Fix this by inhibiting the transmitter at initialization time, and
> then enabling/disabling it appropriately.
>
> With this patch, I can successfully read/erase/program the flash.

Can you provide a bit more details about your setup? What core version
are you using? C_PARAMS? Flash?
>

In general, I think it makes more sense to title your patch as:
Inhibit transfer while idle. Because the current code already inhibits
before sending data in irq mode.

The current design tries to limit as much as possible the register
access and only enable inhibit in irq mode.

In principle, I believe both approaches shall be equally valid, but if
you have a use case that does not work with the current approach your
patch is very welcome.

> Signed-off-by: Jonathan Lemon <jonathan.lemon@gmail.com>
> ---
>  drivers/spi/spi-xilinx.c | 54 +++++++++++++++++++++++++++++++---------
>  1 file changed, 42 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/spi/spi-xilinx.c b/drivers/spi/spi-xilinx.c
> index 523edfdf5dcd..10eccfb09e20 100644
> --- a/drivers/spi/spi-xilinx.c
> +++ b/drivers/spi/spi-xilinx.c
> @@ -179,8 +179,8 @@ static void xspi_init_hw(struct xilinx_spi *xspi)
>         /* Disable the transmitter, enable Manual Slave Select Assertion,
>          * put SPI controller into master mode, and enable it */
>         xspi->write_fn(XSPI_CR_MANUAL_SSELECT | XSPI_CR_MASTER_MODE |
> -               XSPI_CR_ENABLE | XSPI_CR_TXFIFO_RESET | XSPI_CR_RXFIFO_RESET,
> -               regs_base + XSPI_CR_OFFSET);
> +               XSPI_CR_ENABLE | XSPI_CR_TXFIFO_RESET | XSPI_CR_RXFIFO_RESET |
> +               XSPI_CR_TRANS_INHIBIT, regs_base + XSPI_CR_OFFSET);
>  }
>
>  static void xilinx_spi_chipselect(struct spi_device *spi, int is_on)
> @@ -235,14 +235,46 @@ static int xilinx_spi_setup_transfer(struct spi_device *spi,
>         return 0;
>  }
>
> +static void
> +xilinx_spi_inhibit_master(struct xilinx_spi *xspi, bool inhibit)
> +{
> +       u16 cr;
> +
> +       cr = xspi->read_fn(xspi->regs + XSPI_CR_OFFSET);
> +       if (inhibit)
> +               cr |= XSPI_CR_TRANS_INHIBIT;
> +       else
> +               cr &= ~XSPI_CR_TRANS_INHIBIT;
> +       xspi->write_fn(cr, xspi->regs + XSPI_CR_OFFSET);
> +}
> +
> +static void
> +xilinx_spi_enable_transfer(struct xilinx_spi *xspi)
> +{
> +       xilinx_spi_inhibit_master(xspi, false);
> +}
> +
> +static void
> +xilinx_spi_disable_transfer(struct xilinx_spi *xspi)
> +{
> +       xilinx_spi_inhibit_master(xspi, true);
> +}
> +
> +static bool
> +xilinx_spi_is_transfer_disabled(struct xilinx_spi *xspi)
> +{
> +       u16 cr = xspi->read_fn(xspi->regs + XSPI_CR_OFFSET);
> +       return !!(cr & XSPI_CR_TRANS_INHIBIT);
> +}
> +
Although these helper functions make very clear what you want to
achieve, they run a lot of extra register access.
In some platforms register access is VERY slow.
Please embed them into txrx_bufs (use the cr variable as before)

>  static int xilinx_spi_txrx_bufs(struct spi_device *spi, struct spi_transfer *t)
>  {
>         struct xilinx_spi *xspi = spi_master_get_devdata(spi->master);
>         int remaining_words;    /* the number of words left to transfer */
>         bool use_irq = false;
> -       u16 cr = 0;
>
>         /* We get here with transmitter inhibited */
> +       WARN_ON_ONCE(!xilinx_spi_is_transfer_disabled(xspi));
>
>         xspi->tx_ptr = t->tx_buf;
>         xspi->rx_ptr = t->rx_buf;
> @@ -252,14 +284,13 @@ static int xilinx_spi_txrx_bufs(struct spi_device *spi, struct spi_transfer *t)
>                 u32 isr;
>                 use_irq = true;
>                 /* Inhibit irq to avoid spurious irqs on tx_empty*/
You shall remove this comment also
> -               cr = xspi->read_fn(xspi->regs + XSPI_CR_OFFSET);
> -               xspi->write_fn(cr | XSPI_CR_TRANS_INHIBIT,
> -                              xspi->regs + XSPI_CR_OFFSET);
> +
>                 /* ACK old irqs (if any) */
>                 isr = xspi->read_fn(xspi->regs + XIPIF_V123B_IISR_OFFSET);
>                 if (isr)
>                         xspi->write_fn(isr,
>                                        xspi->regs + XIPIF_V123B_IISR_OFFSET);
> +
>                 /* Enable the global IPIF interrupt */
>                 xspi->write_fn(XIPIF_V123B_GINTR_ENABLE,
>                                 xspi->regs + XIPIF_V123B_DGIER_OFFSET);
> @@ -280,9 +311,9 @@ static int xilinx_spi_txrx_bufs(struct spi_device *spi, struct spi_transfer *t)
>                 /* Start the transfer by not inhibiting the transmitter any
>                  * longer
>                  */
> +               xilinx_spi_enable_transfer(xspi);
>
>                 if (use_irq) {
> -                       xspi->write_fn(cr, xspi->regs + XSPI_CR_OFFSET);
>                         wait_for_completion(&xspi->done);
>                         /* A transmit has just completed. Process received data
>                          * and check for more data to transmit. Always inhibit
> @@ -290,8 +321,7 @@ static int xilinx_spi_txrx_bufs(struct spi_device *spi, struct spi_transfer *t)
>                          * register/FIFO, or make sure it is stopped if we're
>                          * done.
This comment is not valid anymore., the ISR does not refill the FIFO.
Can you send a following patch fixing this?
Thanks!
>                          */
> -                       xspi->write_fn(cr | XSPI_CR_TRANS_INHIBIT,
> -                                      xspi->regs + XSPI_CR_OFFSET);
> +                       xilinx_spi_disable_transfer(xspi);
>                         sr = XSPI_SR_TX_EMPTY_MASK;
>                 } else
>                         sr = xspi->read_fn(xspi->regs + XSPI_SR_OFFSET);
> @@ -325,10 +355,10 @@ static int xilinx_spi_txrx_bufs(struct spi_device *spi, struct spi_transfer *t)
>                 remaining_words -= n_words;
>         }
>
> -       if (use_irq) {
> +       if (use_irq)
>                 xspi->write_fn(0, xspi->regs + XIPIF_V123B_DGIER_OFFSET);
> -               xspi->write_fn(cr, xspi->regs + XSPI_CR_OFFSET);
> -       }
> +
> +       xilinx_spi_disable_transfer(xspi);
I believe this shall be moved to after:
remaining_words -= n_words;

and be something like:
if (!use_irq)
  xspi->write_fn(cr | XSPI_CR_TRANS_INHIBIT , xspi->regs + XSPI_CR_OFFSET);

>
>         return t->len;
>  }
> --
> 2.27.0
>
