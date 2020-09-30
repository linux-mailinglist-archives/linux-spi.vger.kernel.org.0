Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8B5B27EADA
	for <lists+linux-spi@lfdr.de>; Wed, 30 Sep 2020 16:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730226AbgI3OZI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 30 Sep 2020 10:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbgI3OZI (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 30 Sep 2020 10:25:08 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D68C061755;
        Wed, 30 Sep 2020 07:25:08 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id f18so1266103pfa.10;
        Wed, 30 Sep 2020 07:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dvxon4aT+Bg3rAts8pR1bLNojjfXE3Ky0aA3JZDUcx8=;
        b=nWeK/jJwo5ZkPmRf95inipyriwQxrPqxCrvC884mzhPSYf8a7caYKeUAMxQ/h/D/o3
         clK0CqRJeyHVkiKzxyWeq2ylBVQmXlLGD21V7wlvcjmR93pw4JVPOxuGOWdaZaUC+0QJ
         aIB00iZnC5rAnUv1BmyrhP3GkZMpaSNhlW7KdDdCfXBg+hqFTmvgtLstcKJvMkaY0Y9L
         odrMJk/k/ot2qd0CHp+sEQaw7cBbthIsjvKqjm9weB87m0krj3uxADbWCLfwWGVDsImB
         OfaHJFPYQLSdOZsEADXisQ82j3//sNSbZiKlonT04dHJq4VNDyoOFJ9gLP6Ff6EkWNk1
         8Tfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dvxon4aT+Bg3rAts8pR1bLNojjfXE3Ky0aA3JZDUcx8=;
        b=TJTZaGynBhjhWxysChNLbB8+NoJm6JsbzNOLY6kVRPOHHGT0RrJG65mp6uCDyVLQ9m
         0panPclyiGZqHF79CwYqhWaE24ibC9/Hb85zq2vlw+/9In0c5FRmfUxFgVTMmwTeGlNO
         3mTfkbiaVhfq23/10SB0KTz30NSE1Ub854m9lJjf/jDv76N0CSXtyi6sXeH0pdDIPf1w
         Xb+BHTGqmI+fG0n6e6HoiYJCKFZLVC9j064KG7nfMlbvmfXG6cnht/VzRXcXPnoR4lkM
         GZi9fPHqECvJzMcLSI8/MvSs5cLeVuNJdQcx4sYBjtWLVZHcJC3Qhb58rp8mGGxv93LZ
         kSqA==
X-Gm-Message-State: AOAM531g/Rsvqm5vu0a2Rf03OYgxlNYeaDPoPBGcVrZImmXO4ghYrqI+
        4Ajy5TD7LoVtf3Bqn5U72wI8gxrtRYGWiUN8riTnGtbSuLyRlw==
X-Google-Smtp-Source: ABdhPJyK6kwL4RbqmtHbGFJ8lc7L7BO4ojk5IpGz04DgVDWdNVCLqWmC9Lt/eSC0udBcdIIPLTm7hJcEMhbccltOaKI=
X-Received: by 2002:a62:7b55:0:b029:13e:7367:2b2e with SMTP id
 w82-20020a627b550000b029013e73672b2emr2603827pfc.7.1601475907421; Wed, 30 Sep
 2020 07:25:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200930135137.197592-1-thomas.petazzoni@bootlin.com>
In-Reply-To: <20200930135137.197592-1-thomas.petazzoni@bootlin.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 30 Sep 2020 17:24:48 +0300
Message-ID: <CAHp75VccK7hu51qCdRC4GaTO3XaSaYLD6TeuuqHLY9Tf1Tb67A@mail.gmail.com>
Subject: Re: [PATCH] serial: max310x: rework RX interrupt handling
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

On Wed, Sep 30, 2020 at 4:51 PM Thomas Petazzoni
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

Was it always like this?
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
See one nit-pick below.

> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> ---
>  drivers/tty/serial/max310x.c | 29 ++++++++++++++++++++++++-----
>  1 file changed, 24 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
> index 8434bd5a8ec78..a1c80850d77ed 100644
> --- a/drivers/tty/serial/max310x.c
> +++ b/drivers/tty/serial/max310x.c
> @@ -1056,9 +1056,9 @@ static int max310x_startup(struct uart_port *port)
>         max310x_port_update(port, MAX310X_MODE1_REG,
>                             MAX310X_MODE1_TRNSCVCTRL_BIT, 0);
>
> -       /* Configure MODE2 register & Reset FIFOs*/
> -       val = MAX310X_MODE2_RXEMPTINV_BIT | MAX310X_MODE2_FIFORST_BIT;
> -       max310x_port_write(port, MAX310X_MODE2_REG, val);
> +       /* Reset FIFOs*/

Add a space before the asterisk.

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
