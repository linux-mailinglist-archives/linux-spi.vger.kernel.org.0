Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 383532E93E0
	for <lists+linux-spi@lfdr.de>; Mon,  4 Jan 2021 12:04:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbhADLDc (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 4 Jan 2021 06:03:32 -0500
Received: from mail-oo1-f46.google.com ([209.85.161.46]:33913 "EHLO
        mail-oo1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726176AbhADLDc (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 4 Jan 2021 06:03:32 -0500
Received: by mail-oo1-f46.google.com with SMTP id x23so6187376oop.1;
        Mon, 04 Jan 2021 03:03:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vgz855DfWv71v/NUg42dMP6FV3P5LJ1Dp9oOf7gYED8=;
        b=lsYYKFRMSBmXyUBKFBWQPzTxJXcIVtxTp2zZBcZ7SB5XQJOwr6WTRcgZ9r8iJ+JQfS
         0EepbijIYcrRnk0xlBGH6jUJDKLdGHwd60eiOiEEltU7EQfhUIBCkSIfWzGHDaE13r2I
         wfMj617x9d+269frPev3Ref27HZ9GTCXnDhOGH4eEJvPycTmVQQm4EvKA+aE4sLv/Kuq
         7AIH40YwUKHy2KmmNlt1+nnX/3W7QBw1QZwQrVmMKivFl4esMxVm92Luy/CtMlLAb+2X
         1cbLHnKauYtwmyP48P8pDx3jL7HEw//mX0OTx7g2glndDZe82I9KBm+ykrw5elbYIvyy
         2dGg==
X-Gm-Message-State: AOAM531BN/uflnC9zut7HkNhjStOnlXQuBhH2//jjB0TGoDEiWkBqjEI
        puav115/wS3cuavg5LH6Rv+WbArM2YWCIbmjpEkcU5dU
X-Google-Smtp-Source: ABdhPJzr1K2Am+N2Q/mJdEccKDCfyY216KRTVXuy/doErF2NeQJAnzf4Bso+QzcOdpp3/DpfE19LAUmx1c+nIkV1eh0=
X-Received: by 2002:a4a:ca14:: with SMTP id w20mr48734783ooq.11.1609758171783;
 Mon, 04 Jan 2021 03:02:51 -0800 (PST)
MIME-Version: 1.0
References: <20210102115412.3402059-1-aford173@gmail.com> <20210102115412.3402059-2-aford173@gmail.com>
In-Reply-To: <20210102115412.3402059-2-aford173@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 4 Jan 2021 12:02:40 +0100
Message-ID: <CAMuHMdXzK=d30RuWSDofR5uB2SmF5eiHMpQ0xakvUqDA7bWhOQ@mail.gmail.com>
Subject: Re: [PATCH V2 2/4] memory: renesas rpc-if: Update Add RZ/G2 to
 Kconfig description
To:     Adam Ford <aford173@gmail.com>
Cc:     Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Adam Ford-BE <aford@beaconembedded.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-spi <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sat, Jan 2, 2021 at 12:54 PM Adam Ford <aford173@gmail.com> wrote:
>
> The Renesas RPC-IF is present on the RZ/G2 Series.  Add that to
> the description.
>
> Suggested-by: Biju Das <biju.das.jz@bp.renesas.com>
> Signed-off-by: Adam Ford <aford173@gmail.com>

Thanks for your patch!

> --- a/drivers/memory/Kconfig
> +++ b/drivers/memory/Kconfig
> @@ -202,9 +202,9 @@ config RENESAS_RPCIF
>         depends on ARCH_RENESAS || COMPILE_TEST
>         select REGMAP_MMIO
>         help
> -         This supports Renesas R-Car Gen3 RPC-IF which provides either SPI
> -         host or HyperFlash. You'll have to select individual components
> -         under the corresponding menu.
> +         This supports Renesas R-Car Gen3 of RZ/G2 RPC-IF which provides

s/of/or/

> +         either SPI host or HyperFlash. You'll have to select individual
> +         components under the corresponding menu.
>
>  config STM32_FMC2_EBI
>         tristate "Support for FMC2 External Bus Interface on STM32MP SoCs"

With the above fixed:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
