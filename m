Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2946927FE83
	for <lists+linux-spi@lfdr.de>; Thu,  1 Oct 2020 13:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731931AbgJALfv (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 1 Oct 2020 07:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731908AbgJALfv (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 1 Oct 2020 07:35:51 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EADEC0613D0;
        Thu,  1 Oct 2020 04:35:50 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id w7so4222307pfi.4;
        Thu, 01 Oct 2020 04:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XyHiOZw6vpbNqA7DA0wYMswCxzbcImXpu3LbRG5y4FY=;
        b=J8csKkj6C1iGRmU8Z2s9PR8mzu2M2Qs0mdc14WlwmmhCoZpYIUJzTskuONflNLvUar
         hDHqy76EDetoeOGc2IkptlEYVt7STuIyJMvyKAb/c9U1vYLEB3kQ3C6zeNL9hNlxrQKX
         RQybNZtdAlAJ5zzyjSQziT91ycAqz8+Xv2TyUHrezmE96wndFxS3ikyGjNWA76Wdn2Cp
         lG7Yd0h0g/y0ggoMFqHkUakBG4sw6kaUPpe5/PS8gMEa3GUXzRzs5XnByOLD9b6veasw
         riYk30x+vZLMFdUCRQ3GZ+vLxKWowGeso9hDPRbD4qunSpnTJ2iSTguPbkIlPfTnpO1f
         DxkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XyHiOZw6vpbNqA7DA0wYMswCxzbcImXpu3LbRG5y4FY=;
        b=X1pXIJB2Z4TKEvT++9gRsYbGF+U5cdH9XI0kyTQh2K0pGUGxI/0S+PDY9K6VaYxUoU
         xfgIYntm1QIQRJ3BMIo4bmA44HZqLBzc7dt2ge5NcsaX0FTs7Y+jS8lVSd+WmBv7eFna
         ScWCINoJSb8L1UOvtSoFQHxf2LTfpqkCnE7HwFd0vQLnn2OPBNNjdSmwdi87/tFl7wVW
         djB0ZWNQiUe36WsLT3syWcOii4TTA9wmzb4LDOc2sMZBa8kr7Kxf82HSlp5+ah5en5US
         860pL7iAg7kDmJtQyI/0eX0SNx6z3y2YMoQTpm4+hXsSUgfFPsnSelOhJhhzD89m0dpk
         v+lA==
X-Gm-Message-State: AOAM533iWrt0Ybr/dE7sQsCSqjFM7wLtuWLU5vehe3FjsLDZOE8pNpo3
        YYe/uoeFGCiqK0uy7fj779aRdztzr8Uuu8bZt+w=
X-Google-Smtp-Source: ABdhPJwv2e3TtgJ7tZ1wIs2RHI55rGZpOY2rkgaPqc67H6tses5x+SjZHcN+6mlfXIXb+IG2pMfbkzT2pGwSKlPzrBE=
X-Received: by 2002:a63:ec4c:: with SMTP id r12mr5585605pgj.74.1601552149669;
 Thu, 01 Oct 2020 04:35:49 -0700 (PDT)
MIME-Version: 1.0
References: <20201001074415.349739-1-thomas.petazzoni@bootlin.com>
In-Reply-To: <20201001074415.349739-1-thomas.petazzoni@bootlin.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 1 Oct 2020 14:35:31 +0300
Message-ID: <CAHp75VdJBj_1j6JtA7wtbJ4Ji_s5sdjxunckv7mBHsxXE+t7Aw@mail.gmail.com>
Subject: Re: [PATCH v2] serial: max310x: rework RX interrupt handling
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?SmFuIEt1bmRyw6F0?= <jan.kundrat@cesnet.cz>,
        Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Oct 1, 2020 at 10:44 AM Thomas Petazzoni
<thomas.petazzoni@bootlin.com> wrote:
>
> Currently, the RX interrupt logic uses the RXEMPTY interrupt, with the
> RXEMPTYINV bit set, which means we get an RX interrupt as soon as the
> RX FIFO is non-empty.
>
> However, with the MAX310X having a FIFO of 128 bytes, this makes very
> poor use of the FIFO: we trigger an interrupt as soon as the RX FIFO
> has one byte, which means a lot of interrupts, each only collecting a
> few bytes from the FIFO, causing a significant CPU load.
>
> Instead this commit relies on two other RX interrupt events:
>
>  - MAX310X_IRQ_RXFIFO_BIT, which triggers when the RX FIFO has reached
>    a certain threshold, which we define to be half of the FIFO
>    size. This ensure we get an interrupt before the RX FIFO fills up.
>
>  - MAX310X_LSR_RXTO_BIT, which triggers when the RX FIFO has received
>    some bytes, and then no more bytes are received for a certain
>    time. Arbitrarily, this time is defined to the time is takes to
>    receive 4 characters.
>
> On a Microchip SAMA5D3 platform that is receiving 20 bytes every 16ms
> over one MAX310X UART, this patch has allowed to reduce the CPU
> consumption of the interrupt handler thread from ~25% to 6-7%.
>

You missed my tag :-(

> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> ---
> Changes since v1:
> - Fix missing space when closing a comment
> ---
>  drivers/tty/serial/max310x.c | 29 ++++++++++++++++++++++++-----
>  1 file changed, 24 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
> index 8434bd5a8ec7..21130af106bb 100644
> --- a/drivers/tty/serial/max310x.c
> +++ b/drivers/tty/serial/max310x.c
> @@ -1056,9 +1056,9 @@ static int max310x_startup(struct uart_port *port)
>         max310x_port_update(port, MAX310X_MODE1_REG,
>                             MAX310X_MODE1_TRNSCVCTRL_BIT, 0);
>
> -       /* Configure MODE2 register & Reset FIFOs*/
> -       val = MAX310X_MODE2_RXEMPTINV_BIT | MAX310X_MODE2_FIFORST_BIT;
> -       max310x_port_write(port, MAX310X_MODE2_REG, val);
> +       /* Reset FIFOs */
> +       max310x_port_write(port, MAX310X_MODE2_REG,
> +                          MAX310X_MODE2_FIFORST_BIT);
>         max310x_port_update(port, MAX310X_MODE2_REG,
>                             MAX310X_MODE2_FIFORST_BIT, 0);
>
> @@ -1086,8 +1086,27 @@ static int max310x_startup(struct uart_port *port)
>         /* Clear IRQ status register */
>         max310x_port_read(port, MAX310X_IRQSTS_REG);
>
> -       /* Enable RX, TX, CTS change interrupts */
> -       val = MAX310X_IRQ_RXEMPTY_BIT | MAX310X_IRQ_TXEMPTY_BIT;
> +       /*
> +        * Let's ask for an interrupt after a timeout equivalent to
> +        * the receiving time of 4 characters after the last character
> +        * has been received.
> +        */
> +       max310x_port_write(port, MAX310X_RXTO_REG, 4);
> +
> +       /*
> +        * Make sure we also get RX interrupts when the RX FIFO is
> +        * filling up quickly, so get an interrupt when half of the RX
> +        * FIFO has been filled in.
> +        */
> +       max310x_port_write(port, MAX310X_FIFOTRIGLVL_REG,
> +                          MAX310X_FIFOTRIGLVL_RX(MAX310X_FIFO_SIZE / 2));
> +
> +       /* Enable RX timeout interrupt in LSR */
> +       max310x_port_write(port, MAX310X_LSR_IRQEN_REG,
> +                          MAX310X_LSR_RXTO_BIT);
> +
> +       /* Enable LSR, RX FIFO trigger, CTS change interrupts */
> +       val = MAX310X_IRQ_LSR_BIT  | MAX310X_IRQ_RXFIFO_BIT | MAX310X_IRQ_TXEMPTY_BIT;
>         max310x_port_write(port, MAX310X_IRQEN_REG, val | MAX310X_IRQ_CTS_BIT);
>
>         return 0;
> --
> 2.26.2
>


-- 
With Best Regards,
Andy Shevchenko
