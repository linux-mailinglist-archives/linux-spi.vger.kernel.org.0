Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 380F244562E
	for <lists+linux-spi@lfdr.de>; Thu,  4 Nov 2021 16:20:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbhKDPXA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 4 Nov 2021 11:23:00 -0400
Received: from mail-ua1-f52.google.com ([209.85.222.52]:35678 "EHLO
        mail-ua1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbhKDPW7 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 4 Nov 2021 11:22:59 -0400
Received: by mail-ua1-f52.google.com with SMTP id q13so11508669uaq.2
        for <linux-spi@vger.kernel.org>; Thu, 04 Nov 2021 08:20:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gCCp1dMn9Lg82N5nPLE8EIceWGowxdMGcMi3mgjL66I=;
        b=fN7/h0ykhDVvgpcNIQqbsEv3S/ynKvNAQUYG6VksoizqiR0RCNgeaDnMgQ2DLdbA2d
         sVaq9pemW7pNeHaXDGFFCw43mDoqynGQukxkQKCuBDOnwgCj+kjBmhhAzAZzYivjVjHa
         dlOTY0I3SgifwCI3vcZchAKay9HxxHUcNxloqIG8T0lIxU9QYeNyIJYevXISVOZIP25X
         QMqd212cvkTK3P/e/iMUI5/bY3SsYvy5kqanUpUVvtGvdDejmnjpTAHnKr69/C43xZtG
         skZljW/scSBhxCP+4Nl0mNyGB1/j5k/jzhV3peMygxO/HxjTdEkFXEIJdUqFw7BudQtJ
         RMmA==
X-Gm-Message-State: AOAM53217SaMXoZqIc4zGWnyIqOzlMcKMEaiz1ooV0AN4X84x5A9nOBx
        b0WL0Y/rKYv459Wj3y7cBJDcX6DP2zSuTw==
X-Google-Smtp-Source: ABdhPJyEwmdL2jTEf8kFi+hwu46ZVlo6F8na4xe4jmjaCxR5v/5b2LNBV+fiqpY5TK/K0SQ4d4OJ7w==
X-Received: by 2002:a05:6102:e07:: with SMTP id o7mr29550731vst.46.1636039221175;
        Thu, 04 Nov 2021 08:20:21 -0700 (PDT)
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com. [209.85.222.49])
        by smtp.gmail.com with ESMTPSA id n9sm856790vsl.19.2021.11.04.08.20.20
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Nov 2021 08:20:21 -0700 (PDT)
Received: by mail-ua1-f49.google.com with SMTP id l43so11505025uad.4
        for <linux-spi@vger.kernel.org>; Thu, 04 Nov 2021 08:20:20 -0700 (PDT)
X-Received: by 2002:a05:6102:3a07:: with SMTP id b7mr33101150vsu.35.1636039220677;
 Thu, 04 Nov 2021 08:20:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAETHaKpiZEWHUrKtNw+W3XHAPUA4h=OC=RL4Jbcs94o1MgDj6w@mail.gmail.com>
 <CAMuHMdXwYH2n+C5AEzhCjtH+eX5mBFH=cB1hYAy-XYtPYRn9jw@mail.gmail.com> <CAETHaKrQ-UDPjMm_jpNe3P0VzQg7qDLZGaViqXvz+qVuUuZCgg@mail.gmail.com>
In-Reply-To: <CAETHaKrQ-UDPjMm_jpNe3P0VzQg7qDLZGaViqXvz+qVuUuZCgg@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 4 Nov 2021 16:20:09 +0100
X-Gmail-Original-Message-ID: <CAMuHMdW5HERzd=1wxSRAwUnffAMP87uKLuvDt1Wkf-RLHZJopg@mail.gmail.com>
Message-ID: <CAMuHMdW5HERzd=1wxSRAwUnffAMP87uKLuvDt1Wkf-RLHZJopg@mail.gmail.com>
Subject: Re: spi-ar934x: Using GPIO CS issue
To:     Dave Bender <codehero@gmail.com>
Cc:     linux-spi <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Dave,

On Thu, Nov 4, 2021 at 3:58 PM Dave Bender <codehero@gmail.com> wrote:
> On Thu, Nov 4, 2021 at 5:50 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > Does it work if you change GPIO_ACTIVE_LOW to GPIO_ACTIVE_HIGH?
>
>   There is a pullup resistor on that CS line, so that GPIO must be active low.

I do believe you.  But there's been some issues with inverted CS
gpio behavior when switching from board files to DT, so I thought
I'd better ask to try...

>   Digging deeper into the code, it looks like David Bauer made some
> changes that limit the spi driver's CS usage to only the CS0, CS1, CS2
> pins.
>   There is also no bounds checking on the CS value.
>   I don't understand how this driver can even use generic GPIO if it
> forces use of the CS bits on the SPI_IOC register.

OK, that sounds like a reasonable culprit...

>
> static int ar934x_spi_transfer_one_message(struct spi_controller *master,
>              struct spi_message *m)
> {
>    ....
>    ....
>     for (trx_done = 0; trx_done < t->len; trx_done += 4) {
>
>    .....
>       reg = AR934X_SPI_SHIFT_VAL(spi->chip_select, term,
>                trx_cur * 8);
>       iowrite32(reg, sp->base + AR934X_SPI_REG_SHIFT_CTRL);

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
