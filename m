Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0408F2E94EF
	for <lists+linux-spi@lfdr.de>; Mon,  4 Jan 2021 13:36:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbhADMfJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 4 Jan 2021 07:35:09 -0500
Received: from mail-oi1-f182.google.com ([209.85.167.182]:33312 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbhADMfH (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 4 Jan 2021 07:35:07 -0500
Received: by mail-oi1-f182.google.com with SMTP id d203so31962099oia.0;
        Mon, 04 Jan 2021 04:34:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5wGZ1GPhO3W//V4Lylox6bP5qdJ1wx1nVDn4V/XONEs=;
        b=ek6Wt8xADzp3j6PEtaTHS71pGcg5Vu8G34HeBY0iMfCBh+7ZnniwkZPhdYlrnDY/rb
         s4jQwdJq6klhvfVig4aIBkQlLVuf1hiQEFfwGRCsoIKGhbNkvQ1qNdsR5Fv343H549P2
         E3j8X/wsXNdIq6HSHHF+AAbiVYEgsK1njFGhqEpI955V+zbwlnkIKXLBAepUw59qmez2
         Fqp61BsnDZilQ6axv8DfFfiWY6yQNAjAkmBvfop1HHuJ/XZDFqOOWCZipe30W5c6b2kF
         uYrp8slg/ZyoHHfxGMMnbw/ZzC7BMMuzbD7+xVK/6cBmjEkv24lYljNXdq5fJPe6oSkZ
         ix7g==
X-Gm-Message-State: AOAM532rgylUg1UAjpRNYFTCWfuCR0L03bY1H9BG2dFPXOoTPEfZPABW
        FctydKkpVTfXq0TD1cDwr9+Y1wEskWxHjZE9wb4=
X-Google-Smtp-Source: ABdhPJysTc7KkHukyoh6Hp8SXHzWfHR+MbWcqgt45wqLx93qW4DN7Nc5LRS0kcJXxTVGxdBY5Odt8A1fgV1Gd1cNodo=
X-Received: by 2002:aca:3cc5:: with SMTP id j188mr17782563oia.54.1609763666850;
 Mon, 04 Jan 2021 04:34:26 -0800 (PST)
MIME-Version: 1.0
References: <20201230145708.28544-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20201230145708.28544-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20201230145708.28544-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 4 Jan 2021 13:34:16 +0100
Message-ID: <CAMuHMdVCD52-eTnEwftGz8ExMkZkJRyM=3M8zU11yhn1UNPxxA@mail.gmail.com>
Subject: Re: [PATCH 2/2] spi: rpc-if: Remove CONFIG_PM_SLEEP ifdefery
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Mark Brown <broonie@kernel.org>, Jiri Kosina <trivial@kernel.org>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        Pavel Machek <pavel@denx.de>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Chris Brandt <Chris.Brandt@renesas.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Prabhakar,

On Wed, Dec 30, 2020 at 4:00 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Use __maybe_unused for the suspend()/resume() hooks and get rid of
> the CONFIG_PM_SLEEP ifdefery to improve the code.
>
> Suggested-by: Pavel Machek <pavel@denx.de>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Thanks for your patch!

> --- a/drivers/spi/spi-rpc-if.c
> +++ b/drivers/spi/spi-rpc-if.c
> @@ -176,15 +176,14 @@ static int rpcif_spi_remove(struct platform_device *pdev)
>         return 0;
>  }
>
> -#ifdef CONFIG_PM_SLEEP
> -static int rpcif_spi_suspend(struct device *dev)
> +static int __maybe_unused rpcif_spi_suspend(struct device *dev)
>  {
>         struct spi_controller *ctlr = dev_get_drvdata(dev);
>
>         return spi_controller_suspend(ctlr);
>  }
>
> -static int rpcif_spi_resume(struct device *dev)
> +static int __maybe_unused rpcif_spi_resume(struct device *dev)
>  {
>         struct spi_controller *ctlr = dev_get_drvdata(dev);
>
> @@ -192,17 +191,13 @@ static int rpcif_spi_resume(struct device *dev)
>  }
>
>  static SIMPLE_DEV_PM_OPS(rpcif_spi_pm_ops, rpcif_spi_suspend, rpcif_spi_resume);
> -#define DEV_PM_OPS     (&rpcif_spi_pm_ops)
> -#else
> -#define DEV_PM_OPS     NULL
> -#endif
>
>  static struct platform_driver rpcif_spi_driver = {
>         .probe  = rpcif_spi_probe,
>         .remove = rpcif_spi_remove,
>         .driver = {
>                 .name   = "rpc-if-spi",
> -               .pm     = DEV_PM_OPS,
> +               .pm     = &rpcif_spi_pm_ops,

You're aware rpcif_spi_pm_ops is now always referenced and thus emitted,
increasing kernel size by 92 bytes if CONFIG_PM_SLEEP=n?
This may matter for RZ/A SoCs running from internal SRAM.

>         },
>  };
>  module_platform_driver(rpcif_spi_driver);

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
