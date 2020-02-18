Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE96D16250D
	for <lists+linux-spi@lfdr.de>; Tue, 18 Feb 2020 11:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgBRK5F (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 18 Feb 2020 05:57:05 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:43236 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbgBRK5F (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 18 Feb 2020 05:57:05 -0500
Received: by mail-oi1-f195.google.com with SMTP id p125so19642114oif.10;
        Tue, 18 Feb 2020 02:57:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xfa6hP9vzbmQbDBcIM+/XCkbFHlGpgKlLUtHMFECOoc=;
        b=ZxRqMdfHqSjyhxpnVG45N8+0kXmfSpoZeqWit75xvjkCxtBkzAPs5ZUTieY4/yu9vh
         TEoYHqEq13u0Bj0wAlRAh4an6l9Pnk5JAKO2yHOyhLD1c83oLNL+Db7He9BFmsI0aJNt
         8RIPG2hck/OesGosZQ/8WYCpDtlHmWPYGpQHFl9o6VJtbmCadobJyQXNIMQgaP00AJh2
         qnqIsd/a0M7ClR849AVO9mKfb8dDuIy7SiKc3i5DDXTtSGcgKNfoQzrgKRgbNrxOxg8K
         BZKZPb/lpnVgeDXDo+tyeAGS6arFE3iw0VQjdm+Scp9fz4/Kdght4e7bnhKa/YzYef+D
         gSew==
X-Gm-Message-State: APjAAAVQmPPj6w4jzuFHTGFU6bKfQfEiHG+1sc/E/QB9ZS7hNMvGg7rb
        63bVV6+puska8XgbHNa4eWJKlA8pAjss+sD0nm0=
X-Google-Smtp-Source: APXvYqzeFu9EMu/mSkMblDwtbhxXeLk6RZlyMokY2IhOLYaDpg5DOfwcUxWkCUViiQQUOz5D9IaLC2RgIIJr97jBZ30=
X-Received: by 2002:aca:c4d2:: with SMTP id u201mr855233oif.54.1582023423863;
 Tue, 18 Feb 2020 02:57:03 -0800 (PST)
MIME-Version: 1.0
References: <1554282541-8952-1-git-send-email-na-hoan@jinso.co.jp>
In-Reply-To: <1554282541-8952-1-git-send-email-na-hoan@jinso.co.jp>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 18 Feb 2020 11:56:52 +0100
Message-ID: <CAMuHMdXQvjWDNh+qogw+3a4=U97rq_GPnYYJNqHiDZNPWJU4sA@mail.gmail.com>
Subject: Re: [PATCH] spi: rspi: Add configuration for LSB/MSB
To:     Nguyen An Hoan <na-hoan@jinso.co.jp>
Cc:     Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        =?UTF-8?B?56iy5ZCJ?= <h-inayoshi@jinso.co.jp>,
        =?UTF-8?B?44Kr44Kq44O744O044Kh44Oz44O744OJ44Oz?= 
        <cv-dong@jinso.co.jp>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Hoan-san,

On Wed, Apr 3, 2019 at 11:09 AM Nguyen An Hoan <na-hoan@jinso.co.jp> wrote:
> From: Hoan Nguyen An <na-hoan@jinso.co.jp>
>
> SPI controllers can support LSB or MSB depending on
> the structure of the message that Slave requires,
> Add support.
>
> Signed-off-by: Hoan Nguyen An <na-hoan@jinso.co.jp>

Thanks for your patch!

> --- a/drivers/spi/spi-rspi.c
> +++ b/drivers/spi/spi-rspi.c
> @@ -950,6 +950,8 @@ static int rspi_prepare_message(struct spi_controller *ctlr,
>                 rspi->spcmd |= SPCMD_CPOL;
>         if (spi->mode & SPI_CPHA)
>                 rspi->spcmd |= SPCMD_CPHA;
> +       if (spi->mode & SPI_LSB_FIRST)
> +               rspi->spcmd |= SPCMD_LSBF;
>
>         /* CMOS output mode and MOSI signal from previous transfer */
>         rspi->sppcr = 0;

Unfortunately this is not sufficient.  The driver should also inform the
SPI core that it supports this flag. Will fix.

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
