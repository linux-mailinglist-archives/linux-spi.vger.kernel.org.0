Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F95D2F0DB4
	for <lists+linux-spi@lfdr.de>; Mon, 11 Jan 2021 09:16:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725843AbhAKIPw (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 11 Jan 2021 03:15:52 -0500
Received: from mail-ot1-f42.google.com ([209.85.210.42]:39919 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727653AbhAKIPw (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 11 Jan 2021 03:15:52 -0500
Received: by mail-ot1-f42.google.com with SMTP id d8so16121272otq.6
        for <linux-spi@vger.kernel.org>; Mon, 11 Jan 2021 00:15:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UpOKNpHMs9zNWmA6y87U+naG5hy6fNshuvtfHXunZ/I=;
        b=AwEp037HqTbyH3GHgO42v4/kJVAnb1zvI5ETkSESo3I1j+a0R9sP53ZT0jZjaGyUrx
         S3gdoeOsshbNHy6VRpg+X90JLb7dLgL7G5QQV/7wQMVBYtYDGsepXub9Xfzh3vVvRrex
         XMrGMb39GGoyRZUWchN0pxW3sZrzv2xrBLPYXGIebx6anoyQD1ihkjE6kGUZ/MVgoWlB
         FyyTqaBqq5Di5snUZxXduNGHjzGzvGodu9CLWcfvgqphMc8zA/tNEpwO0CZxJJ2NTLe7
         3NVizMcZmDpOQLmkuK0rBPZQc8R0pm/Ma6xruFXM0BL1EduG+Ti0nmmcJUYFD7R4V0aK
         hK/A==
X-Gm-Message-State: AOAM5314KKo3GJtmVAzeqUyNaQqOyUAGEM73xQNpkX/u0ntE19kxkbaB
        tHc2nZPYYWEzWnutpr6Ly+E/dNyRuBl3vl4Gp6FWRjfu
X-Google-Smtp-Source: ABdhPJzDK2mQQE+U4bVbDeaxajWADFA8biuR2VZcVVrpesvF3jh5pSLRm9C/hCYfGeYhM/3Q2vwCj6JnV+rXixwDNQA=
X-Received: by 2002:a05:6830:1f5a:: with SMTP id u26mr10212873oth.250.1610352911206;
 Mon, 11 Jan 2021 00:15:11 -0800 (PST)
MIME-Version: 1.0
References: <20210107115704.3835282-1-siyanteng@loongson.cn> <20210107173004.GA2169893@ubuntu-m3-large-x86>
In-Reply-To: <20210107173004.GA2169893@ubuntu-m3-large-x86>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 11 Jan 2021 09:14:59 +0100
Message-ID: <CAMuHMdUKnwGDf3siiF3WsWw4_tt0Q3_YSfLpjriA56w68my7DQ@mail.gmail.com>
Subject: Re: [PATCH] SPI: Fix distinct pointer types warning for ARCH=MIPS
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Yanteng Si <siyanteng@loongson.cn>,
        Mark Brown <broonie@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-spi <linux-spi@vger.kernel.org>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Yanteng Si <siyanteng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Nathan,

On Thu, Jan 7, 2021 at 6:31 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
> On Thu, Jan 07, 2021 at 07:57:04PM +0800, Yanteng Si wrote:
> > Fix a new warning report by build for make ARCH=MIPS allmodconfig:
> >
> > drivers/spi/spi-cadence-quadspi.c: In function 'cqspi_direct_read_execute':
> >  ./include/linux/minmax.h:18:28: warning: comparison of distinct pointer types lacks a cast
> >     18 |  (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
> >        |                            ^~
> >  ./include/linux/minmax.h:32:4: note: in expansion of macro '__typecheck'
> >     32 |   (__typecheck(x, y) && __no_side_effects(x, y))
> >        |    ^~~~~~~~~~~
> >  ./include/linux/minmax.h:42:24: note: in expansion of macro '__safe_cmp'
> >     42 |  __builtin_choose_expr(__safe_cmp(x, y), \
> >        |                        ^~~~~~~~~~
> >  ./include/linux/minmax.h:58:19: note: in expansion of macro '__careful_cmp'
> >     58 | #define max(x, y) __careful_cmp(x, y, >)
> >        |                   ^~~~~~~~~~~~~
> >  drivers/spi/spi-cadence-quadspi.c:1153:24: note: in expansion of macro 'max'
> >   1153 |       msecs_to_jiffies(max(len, 500UL)))) {
> >        |                        ^~~
> >
> > "len" is unsigned,however,"500" is unsigned long.

len is size_t, which us either unsigned int or unsigned long.

> > Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
> > ---
> >  drivers/spi/spi-cadence-quadspi.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
> > index 06a65e9a8a60..576610ba1118 100644
> > --- a/drivers/spi/spi-cadence-quadspi.c
> > +++ b/drivers/spi/spi-cadence-quadspi.c
> > @@ -1150,7 +1150,7 @@ static int cqspi_direct_read_execute(struct cqspi_flash_pdata *f_pdata,
> >
> >       dma_async_issue_pending(cqspi->rx_chan);
> >       if (!wait_for_completion_timeout(&cqspi->rx_dma_complete,
> > -                                      msecs_to_jiffies(max(len, 500UL)))) {
> > +                                      msecs_to_jiffies(max(len, 500U)))) {
> >               dmaengine_terminate_sync(cqspi->rx_chan);
> >               dev_err(dev, "DMA wait_for_completion_timeout\n");
> >               ret = -ETIMEDOUT;
> > --
> > 2.27.0
> >
>
> Isn't this just going to cause warnings on 64-bit platforms now because
> size_t is defined as unsigned long and it will now be compared against
> unsigned int? This fix should work for everyone, not sure how pretty it

Yes it is!

> is though.

> --- a/drivers/spi/spi-cadence-quadspi.c
> +++ b/drivers/spi/spi-cadence-quadspi.c
> @@ -1150,7 +1150,7 @@ static int cqspi_direct_read_execute(struct cqspi_flash_pdata *f_pdata,
>
>         dma_async_issue_pending(cqspi->rx_chan);
>         if (!wait_for_completion_timeout(&cqspi->rx_dma_complete,
> -                                        msecs_to_jiffies(max(len, 500UL)))) {
> +                                        msecs_to_jiffies(max_t(size_t, len, 500)))) {
>                 dmaengine_terminate_sync(cqspi->rx_chan);
>                 dev_err(dev, "DMA wait_for_completion_timeout\n");
>                 ret = -ETIMEDOUT;

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
