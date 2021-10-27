Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C50743C3C3
	for <lists+linux-spi@lfdr.de>; Wed, 27 Oct 2021 09:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240469AbhJ0HYE (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 27 Oct 2021 03:24:04 -0400
Received: from mail-ua1-f47.google.com ([209.85.222.47]:36846 "EHLO
        mail-ua1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240471AbhJ0HYD (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 27 Oct 2021 03:24:03 -0400
Received: by mail-ua1-f47.google.com with SMTP id e10so3175095uab.3;
        Wed, 27 Oct 2021 00:21:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XEkFa+Ku/oXy3Y71Wa/RXXm6+I0giMexz18AaglX7hA=;
        b=250+CIzlUU/59Sd+f3UO1OhOlITbP+7hy0Qhi8HsOyTbfPDvrzRublON81n1DVl5O5
         l0t6VErruzxoQnNpoyUx9m3UByOgIyhGfIpqxpPuvhFIOb3y8posdsosa7DC3f1loxVn
         9SZ38pDMvGJ0ZFEqrFN7jyPwHy/hlnWdMg6OeAcVe5LthZOLCOFp/lo16s8mmyhQwqVj
         7u58eAPxQsJXonwjo5fnEx+dR9KwrZGPerDI0C/oy6vvF7VnCKJFVmKC3zX1wzRdV+pD
         c5qIee0Vc54TdwehRMKOnY0Q69nyJJKk+BWN1yqHOLaICAOA9HQYLGvZm0hj+UQyPn/m
         af4w==
X-Gm-Message-State: AOAM53347eBIECn7xtVyEgz1kKJbQyzt3VTPZi8fEvY4fEQMLYEIo5sZ
        XnHd6Q6qKIozzlE3hCv7X6ACTtD7Cxum7w==
X-Google-Smtp-Source: ABdhPJw6IL68kkowHN7Yu0essb69SRPCBVccgeJ+WNljMxXXHKCcC5zM0h3UsdoOsuhcE8Y+eldzBw==
X-Received: by 2002:a05:6102:cd2:: with SMTP id g18mr28671857vst.25.1635319297590;
        Wed, 27 Oct 2021 00:21:37 -0700 (PDT)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com. [209.85.222.44])
        by smtp.gmail.com with ESMTPSA id m34sm10655938uad.5.2021.10.27.00.21.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Oct 2021 00:21:36 -0700 (PDT)
Received: by mail-ua1-f44.google.com with SMTP id ba32so3138073uab.6;
        Wed, 27 Oct 2021 00:21:36 -0700 (PDT)
X-Received: by 2002:a05:6102:3a0e:: with SMTP id b14mr747714vsu.41.1635319295910;
 Wed, 27 Oct 2021 00:21:35 -0700 (PDT)
MIME-Version: 1.0
References: <20211025205631.21151-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211025205631.21151-6-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdUjsVRwB0_TH5HD8CrPsM15K1RLatP_ABODMe2bQ4C2ow@mail.gmail.com>
In-Reply-To: <CAMuHMdUjsVRwB0_TH5HD8CrPsM15K1RLatP_ABODMe2bQ4C2ow@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 27 Oct 2021 09:21:24 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX4HfLUfDk2eZkBugP_ysL3w+qvZqKSR3e47HG4RTggXw@mail.gmail.com>
Message-ID: <CAMuHMdX4HfLUfDk2eZkBugP_ysL3w+qvZqKSR3e47HG4RTggXw@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] memory: renesas-rpc-if: Return error in case
 devm_ioremap_resource() fails
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Mark Brown <broonie@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Chris Brandt <Chris.Brandt@renesas.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Oct 27, 2021 at 9:17 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Mon, Oct 25, 2021 at 10:57 PM Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> > Make sure we return error in case devm_ioremap_resource() fails for dirmap
> > resource.
> >
> > Fixes: ca7d8b980b67 ("memory: add Renesas RPC-IF driver")
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
> > Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>
> Thanks for your patch!
>
> > --- a/drivers/memory/renesas-rpc-if.c
> > +++ b/drivers/memory/renesas-rpc-if.c
> > @@ -243,7 +243,7 @@ int rpcif_sw_init(struct rpcif *rpc, struct device *dev)
> >         res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dirmap");
> >         rpc->dirmap = devm_ioremap_resource(&pdev->dev, res);
> >         if (IS_ERR(rpc->dirmap))
> > -               rpc->dirmap = NULL;
> > +               return PTR_ERR(rpc->dirmap);
>
> IIRC, it was intentional to make the dirmap optional (because the
> device can be used without and/or because some variants on other SoCs
> lack it?).  Unfortunately this is not reflected in the DT bindings
> (yet?).  All code using the dirmap does check if rpc->dirmap is
> valid first.
>
> >         rpc->size = resource_size(res);

Of course this will crash if the dirmap is not present, so for now it's better
to just bail out.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> >
> >         rpc->rstc = devm_reset_control_get_exclusive(&pdev->dev, NULL);

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
