Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2788243C3A8
	for <lists+linux-spi@lfdr.de>; Wed, 27 Oct 2021 09:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240392AbhJ0HUR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 27 Oct 2021 03:20:17 -0400
Received: from mail-ua1-f48.google.com ([209.85.222.48]:41823 "EHLO
        mail-ua1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbhJ0HUQ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 27 Oct 2021 03:20:16 -0400
Received: by mail-ua1-f48.google.com with SMTP id u9so3100168uac.8;
        Wed, 27 Oct 2021 00:17:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m3UqDuembNDHkRgC1yENIlEFdMz5fJYXnnqTuaz01pQ=;
        b=Wz7OBPIouhRZzQ2GKTK1agYLnGk0NhUfBgdsBA0KNFfW5gxim0kDurwG68h8ZKT5P5
         UZcdS0vfzpUgMwBiS6h+wdpD697RN0jgFaYjYFBUTDlrHf6BFqmdrvI8S3HWMjspXG5V
         QZMLc4Emx+1uWdbP4VxrTARWliTIDlY24MXJqOWjjfMP8VOgXELVC85xa55OsbyODFtm
         kWLLfXaGs9ZXVW2ZVAFSGt5sRTAJW2anShmY1N0nmO6CYKa1F9KySV0WWYI4zdDs9Vtz
         bYKxhkAkNrJ0GipikAl3kuMPp5b5W+vYoXVein0EgkGP08D5A0TZSDdFI+chR0rnL1Z/
         HHpA==
X-Gm-Message-State: AOAM531PUmtZ3J1aJFUs5XhLwDsmuupezsRGBf+/vubpODXwjY6fLcfn
        Aa4nZ2n4vh/h+VHMP8S+AZR7ml1DbZUFGw==
X-Google-Smtp-Source: ABdhPJyXQJdKzdA6pE6T2riiHeRD1tpKlZjleDt8fkSWERnm/vm593TcW76jCD6hmNQP1Vh+uNbOSg==
X-Received: by 2002:ab0:812:: with SMTP id a18mr27790678uaf.33.1635319071093;
        Wed, 27 Oct 2021 00:17:51 -0700 (PDT)
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com. [209.85.221.181])
        by smtp.gmail.com with ESMTPSA id n14sm4422861vkc.49.2021.10.27.00.17.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Oct 2021 00:17:50 -0700 (PDT)
Received: by mail-vk1-f181.google.com with SMTP id s201so910382vke.6;
        Wed, 27 Oct 2021 00:17:50 -0700 (PDT)
X-Received: by 2002:a1f:1841:: with SMTP id 62mr27839915vky.26.1635319070166;
 Wed, 27 Oct 2021 00:17:50 -0700 (PDT)
MIME-Version: 1.0
References: <20211025205631.21151-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20211025205631.21151-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20211025205631.21151-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 27 Oct 2021 09:17:39 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUjsVRwB0_TH5HD8CrPsM15K1RLatP_ABODMe2bQ4C2ow@mail.gmail.com>
Message-ID: <CAMuHMdUjsVRwB0_TH5HD8CrPsM15K1RLatP_ABODMe2bQ4C2ow@mail.gmail.com>
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

Hi Prabhakar,

CC seebe

On Mon, Oct 25, 2021 at 10:57 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Make sure we return error in case devm_ioremap_resource() fails for dirmap
> resource.
>
> Fixes: ca7d8b980b67 ("memory: add Renesas RPC-IF driver")
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Thanks for your patch!

> --- a/drivers/memory/renesas-rpc-if.c
> +++ b/drivers/memory/renesas-rpc-if.c
> @@ -243,7 +243,7 @@ int rpcif_sw_init(struct rpcif *rpc, struct device *dev)
>         res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dirmap");
>         rpc->dirmap = devm_ioremap_resource(&pdev->dev, res);
>         if (IS_ERR(rpc->dirmap))
> -               rpc->dirmap = NULL;
> +               return PTR_ERR(rpc->dirmap);

IIRC, it was intentional to make the dirmap optional (because the
device can be used without and/or because some variants on other SoCs
lack it?).  Unfortunately this is not reflected in the DT bindings
(yet?).  All code using the dirmap does check if rpc->dirmap is
valid first.

>         rpc->size = resource_size(res);
>
>         rpc->rstc = devm_reset_control_get_exclusive(&pdev->dev, NULL);

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
