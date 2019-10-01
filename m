Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48308C2FD3
	for <lists+linux-spi@lfdr.de>; Tue,  1 Oct 2019 11:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733288AbfJAJP2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 1 Oct 2019 05:15:28 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39965 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733274AbfJAJP2 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 1 Oct 2019 05:15:28 -0400
Received: by mail-ot1-f66.google.com with SMTP id y39so10901143ota.7;
        Tue, 01 Oct 2019 02:15:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/icWJGEb8mzT5dGk0n3CZD6I5aQgqmHlkE413k8oPWE=;
        b=eD1HbmPWdSkHCunVONDNge7u0nJ1lYramhT/VJv1U5bJxxIttZWNgfyIUNRaCffY+u
         RrZNDheqyDq4pKZOjD2R313fL6wboFO1PdYqyKEyx9SPjTe0viFu6KwszMAwRaEsLBl/
         VD8y7AIfkn7cOmD2XjA1AESrX7gLvGQf88XSIX55bto6EhkaLk6Y9fsApM3+UYgyU2yf
         ITg3R93l3STJqy3vpTRgDkTNHIvjX4TuE2/BHXmfBXgWQcVs8yqyvIcKEfjDpY6k52s3
         7j1bx3AHTjT8TFpqR4IIgyDjpsasx3C81LqsJfxz0T8ZDHX7oNJGKr+xU4JE5I2CPRi1
         fcXg==
X-Gm-Message-State: APjAAAXAIrTjMKl0LheAWkkRlvmopK1MZC2ZCBKKJuCl51yPP6o/73oC
        VZiAEDkSTSg2hlfVqSwXK2w2pu47+3PcREDtbpw=
X-Google-Smtp-Source: APXvYqxrnOLn/FOpZNAEw2K6rnx/WFik/O4j9sVWfQ7FunXXut3/cO7/6JJ4UzlffC/xfEbknNZ9HgKmXXXipYZLISs=
X-Received: by 2002:a9d:730d:: with SMTP id e13mr16379131otk.145.1569921328021;
 Tue, 01 Oct 2019 02:15:28 -0700 (PDT)
MIME-Version: 1.0
References: <20191001090657.25721-1-lukma@denx.de>
In-Reply-To: <20191001090657.25721-1-lukma@denx.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 1 Oct 2019 11:15:16 +0200
Message-ID: <CAMuHMdWHTaPkzTdzz-j1rFeT=aAEG+J46fgKiPYrXoAR_DTvtQ@mail.gmail.com>
Subject: Re: [PATCH] spi: Avoid calling spi_slave_abort() with kfreed spidev
To:     Lukasz Majewski <lukma@denx.de>
Cc:     Mark Brown <broonie@kernel.org>,
        Colin Ian King <colin.king@canonical.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kbuild test robot <lkp@intel.com>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Lukasz,

On Tue, Oct 1, 2019 at 11:07 AM Lukasz Majewski <lukma@denx.de> wrote:
> Call spi_slave_abort() only when the spidev->spi is !NULL and the
> structure hasn't already been kfreed.
>
> Reported-by: kbuild test robot <lkp@intel.com>
> Reported-by: Julia Lawall <julia.lawall@lip6.fr>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Lukasz Majewski <lukma@denx.de>

Thanks for your patch!

> --- a/drivers/spi/spidev.c
> +++ b/drivers/spi/spidev.c
> @@ -600,15 +600,16 @@ static int spidev_open(struct inode *inode, struct file *filp)
>  static int spidev_release(struct inode *inode, struct file *filp)
>  {
>         struct spidev_data      *spidev;
> +       int dofree;

bool?

>
>         mutex_lock(&device_list_lock);
>         spidev = filp->private_data;
>         filp->private_data = NULL;
> +       dofree = 0;

Why not initialize it at declaration time?

>
>         /* last close? */
>         spidev->users--;
>         if (!spidev->users) {
> -               int             dofree;
>
>                 kfree(spidev->tx_buffer);
>                 spidev->tx_buffer = NULL;
> @@ -628,7 +629,8 @@ static int spidev_release(struct inode *inode, struct file *filp)
>                         kfree(spidev);
>         }
>  #ifdef CONFIG_SPI_SLAVE
> -       spi_slave_abort(spidev->spi);
> +       if (!dofree)
> +               spi_slave_abort(spidev->spi);

Can spidev->spi be NULL, if spidev->users != 0?

>  #endif
>         mutex_unlock(&device_list_lock);

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
