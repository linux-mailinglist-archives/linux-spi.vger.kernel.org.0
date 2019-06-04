Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 385BD33FFA
	for <lists+linux-spi@lfdr.de>; Tue,  4 Jun 2019 09:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbfFDHWp (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 4 Jun 2019 03:22:45 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40246 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbfFDHWp (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 4 Jun 2019 03:22:45 -0400
Received: by mail-lj1-f196.google.com with SMTP id a21so3433805ljh.7
        for <linux-spi@vger.kernel.org>; Tue, 04 Jun 2019 00:22:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EPxzCfbw5LB9FxGQ7bomvp2EjErK7+kGr1tgNmgeY+M=;
        b=WRk/lzBIHzPMS6pp+nq9IhihNupw91uvldgxGPKVwWibWsM/gXmo2d9/RWjuE3+iCN
         aSrdevZM0yZufTEXU+gTNN3zDWK4OS4/ZIVWWko82lBCGLbrJIW+QcbyUbMFqy42UR2t
         SZKsF/RTxbGFVfAbW65JCe3YxVunaY+x0JZwP1RwD5Z3yo6fiTWswUsH6WnxJOhad2FC
         Go1zejRe5UrpHfDb0pONIEogLcuMf7FzUKfHX0HAWVryyPCMr/2wp12/YSXg8uSlXm2p
         zABvWEbUnRX+Aa+W9b9wvzcscDswU7Llg5McqaSJbY5asVVFVd1xsJZODe5pb0ImLxXo
         5PTQ==
X-Gm-Message-State: APjAAAXP3qH74rRHsWrNVAxQLhNM4gOPaKIBe7eGieUydqPSTtoICSQm
        j15AKmXNTRdnu9axWiUqNyR3K5Y9qgneWWvoFfU=
X-Google-Smtp-Source: APXvYqyvAPvIBHgTsY67gRow7k9Urh/iqd1vP93NCsRmyBnFlU6Po4bNhJmtjQMSTI7OcbTSLh8T8PauBKYhvbN1x+4=
X-Received: by 2002:a2e:2b8d:: with SMTP id r13mr3395531ljr.145.1559632962851;
 Tue, 04 Jun 2019 00:22:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190604025129.20387-1-festevam@gmail.com>
In-Reply-To: <20190604025129.20387-1-festevam@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 4 Jun 2019 09:22:30 +0200
Message-ID: <CAMuHMdV8hdVQAxw6ookb695K3TZuqy4VEv78=3gUBE17J=4aYg@mail.gmail.com>
Subject: Re: [PATCH] spidev: Use dev_dbg() instead of pr_debug()
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Fabio,

On Tue, Jun 4, 2019 at 4:53 AM Fabio Estevam <festevam@gmail.com> wrote:
> dev_dbg() is more appropriate for printing debug messages inside
> drivers, so switch to dev_dbg().
>
> Signed-off-by: Fabio Estevam <festevam@gmail.com>

Thanks for your patch!

> --- a/drivers/spi/spidev.c
> +++ b/drivers/spi/spidev.c
> @@ -560,7 +560,8 @@ static int spidev_open(struct inode *inode, struct file *filp)
>         }
>
>         if (status) {
> -               pr_debug("spidev: nothing for minor %d\n", iminor(inode));
> +               dev_dbg(&spidev->spi->dev, "spidev: nothing for minor %d\n",
> +                       iminor(inode));

This doesn't look correct to me, as a non-zero status indicates that the
corresponding spidev was not found, and thus spidev is not a valid
object pointer to dereference.

>                 goto err_find_dev;
>         }
>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
