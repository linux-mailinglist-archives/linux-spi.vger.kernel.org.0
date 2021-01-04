Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE6D2EA0B8
	for <lists+linux-spi@lfdr.de>; Tue,  5 Jan 2021 00:26:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727584AbhADXXX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 4 Jan 2021 18:23:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbhADXXW (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 4 Jan 2021 18:23:22 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28B3AC061574;
        Mon,  4 Jan 2021 15:22:42 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id o144so27608775ybc.0;
        Mon, 04 Jan 2021 15:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IHs0gNL0FYkfrPjV8CfFXH60XzdEKDMfQo9YOTLu8ng=;
        b=crfcATRH8ZA7jh72kSOsnKPAdEsZJgta/Z1XwNRlB8h1RfHUTXK2s3+7Jeu+sUUppo
         W+iQZRS+YLavlxBAibp8ISoWy+5kWCHwXM5LdYf/7biMfU+gNW8jg+vILXnN9dfgnR00
         dHGzrDgykxhY7Q/Lei76JJ9ANzriPKRB48+3MtdHWRaGzBtp1xxDbKhsaMt+aH5fOnP9
         wOo6fSRqeKmIS63qizWCL1h4nKGEaGB+J3BnO9fxesHPE81lUhZYRKXoJ3imVmfH5DI1
         Ac8jJ9EA+huVshhjH3zLzPHQUaK8KILgY2LVL0kUny4ZpMfbb02Kp1XK1R+q4zwbZVpg
         F9lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IHs0gNL0FYkfrPjV8CfFXH60XzdEKDMfQo9YOTLu8ng=;
        b=a1Y1cjTWEzAc3W+llgItTNn93RBAd3HSEA4KubbEEKxgMB5M8sXMx06nPYo85it/uY
         uLEg7l8rB3i3dYtsVFj+L6lX1qEZc0eYrMlOyPkSWAYFLVU6fpDHbjyUvmH4Me9w636U
         +RaFuHkk1x0c8vhatd0AaINP0U/n73R9hCnsxq6o7yQ4FQ+wICYZ749/oQnEyUlaR1ET
         wu18yJ5f+qdkO+fQinIDiwQqfy1XBwjjzpHzDz36SHIGMUhOGHqho6+e8iafhCZ+fSR+
         k5GZl8tlcKUy18BErZ9MjK2tzoux8+u82RqqN+3U5laXhjVMr51p2sbPHoAPsniENCw0
         i+tw==
X-Gm-Message-State: AOAM5317D6S4ko0AVagbFKoYRF4VOiG+ssALfKLnKXrXSyceuxMgUpUF
        0hCY2N1xMFJfT446JZKTEqc0F4q39s0x0y9LFwJqH3p6Wzo=
X-Google-Smtp-Source: ABdhPJwzapJndxMAIfyntxa5BfSJmXKUOVwG2h9zBd4WWC1fcSntq1Nnz6Mx9IJ0ZZiHxdPaMxShVqGRRuqTz3uwM10=
X-Received: by 2002:a25:5f07:: with SMTP id t7mr107189415ybb.395.1609795543692;
 Mon, 04 Jan 2021 13:25:43 -0800 (PST)
MIME-Version: 1.0
References: <20201230145708.28544-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20201230145708.28544-3-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdVCD52-eTnEwftGz8ExMkZkJRyM=3M8zU11yhn1UNPxxA@mail.gmail.com>
In-Reply-To: <CAMuHMdVCD52-eTnEwftGz8ExMkZkJRyM=3M8zU11yhn1UNPxxA@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Mon, 4 Jan 2021 21:25:17 +0000
Message-ID: <CA+V-a8tHVkGxCECspfcV9c1UW81bod4N4YzRLJwU8zJ0+awJUw@mail.gmail.com>
Subject: Re: [PATCH 2/2] spi: rpc-if: Remove CONFIG_PM_SLEEP ifdefery
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Mark Brown <broonie@kernel.org>, Pavel Machek <pavel@denx.de>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Jiri Kosina <trivial@kernel.org>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Chris Brandt <Chris.Brandt@renesas.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Geert,

Thank you for the review.

On Mon, Jan 4, 2021 at 12:34 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Prabhakar,
>
> On Wed, Dec 30, 2020 at 4:00 PM Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> > Use __maybe_unused for the suspend()/resume() hooks and get rid of
> > the CONFIG_PM_SLEEP ifdefery to improve the code.
> >
> > Suggested-by: Pavel Machek <pavel@denx.de>
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Thanks for your patch!
>
> > --- a/drivers/spi/spi-rpc-if.c
> > +++ b/drivers/spi/spi-rpc-if.c
> > @@ -176,15 +176,14 @@ static int rpcif_spi_remove(struct platform_device *pdev)
> >         return 0;
> >  }
> >
> > -#ifdef CONFIG_PM_SLEEP
> > -static int rpcif_spi_suspend(struct device *dev)
> > +static int __maybe_unused rpcif_spi_suspend(struct device *dev)
> >  {
> >         struct spi_controller *ctlr = dev_get_drvdata(dev);
> >
> >         return spi_controller_suspend(ctlr);
> >  }
> >
> > -static int rpcif_spi_resume(struct device *dev)
> > +static int __maybe_unused rpcif_spi_resume(struct device *dev)
> >  {
> >         struct spi_controller *ctlr = dev_get_drvdata(dev);
> >
> > @@ -192,17 +191,13 @@ static int rpcif_spi_resume(struct device *dev)
> >  }
> >
> >  static SIMPLE_DEV_PM_OPS(rpcif_spi_pm_ops, rpcif_spi_suspend, rpcif_spi_resume);
> > -#define DEV_PM_OPS     (&rpcif_spi_pm_ops)
> > -#else
> > -#define DEV_PM_OPS     NULL
> > -#endif
> >
> >  static struct platform_driver rpcif_spi_driver = {
> >         .probe  = rpcif_spi_probe,
> >         .remove = rpcif_spi_remove,
> >         .driver = {
> >                 .name   = "rpc-if-spi",
> > -               .pm     = DEV_PM_OPS,
> > +               .pm     = &rpcif_spi_pm_ops,
>
> You're aware rpcif_spi_pm_ops is now always referenced and thus emitted,
> increasing kernel size by 92 bytes if CONFIG_PM_SLEEP=n?
> This may matter for RZ/A SoCs running from internal SRAM.
>
Hmm didn't realise this would be an issue on RZ/A.

Mark, could you please drop this patch from your branch.

Cheers,
Prabhakar

> >         },
> >  };
> >  module_platform_driver(rpcif_spi_driver);
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
