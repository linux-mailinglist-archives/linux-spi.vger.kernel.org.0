Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02EBD422C74
	for <lists+linux-spi@lfdr.de>; Tue,  5 Oct 2021 17:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236066AbhJEP1z (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 5 Oct 2021 11:27:55 -0400
Received: from mail-vs1-f48.google.com ([209.85.217.48]:36837 "EHLO
        mail-vs1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234440AbhJEP1y (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 5 Oct 2021 11:27:54 -0400
Received: by mail-vs1-f48.google.com with SMTP id y28so10321393vsd.3;
        Tue, 05 Oct 2021 08:26:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KSfoUs1RyncvnmPC5NiMdbUYy+WE1in92GvUJZla4GY=;
        b=lTYDrruJNj2CHAgNSR5f7poVvASO1+IMQuNLlZDtGzJHapP4cRLXvs0YD6dbwBNP6G
         cf5aP9QC10xADxXjShVKnJ3K3bZ1w2H4YUNIO/y02uBlnDJMzUKJS4Z55Hb50fvy14NX
         O6IzaorxbulQxi1jw+fYE93JyBZ1/I0qo7Of3tCq45pyKVPLuHoye84T8aNEsfT5p0QL
         NtN22psd8zSsHQKQVUC0ObZvRni78xK9ycPaIiZ5+KBdnweHwjm8zbrGtNvLg3cSyHI8
         O7z1MnLjS0DFSQXnS6Wg56/esPcQFLhQgWaucTNbcZZZ+6lAFVF7p69VTZnx8ch/care
         31Dg==
X-Gm-Message-State: AOAM531qmkE4Vdy9paW2+NTvG4l6KxBO2T/unSKvL/mQbnleLZqvN0S0
        bFpXnUsGhiHat70DWweAPiwxq2Jc5cDXhBB7tDM=
X-Google-Smtp-Source: ABdhPJywGwfpRqbIeYpGX+HZ2UWKkSYVpZ/hXxSNrmGd7JFi4IsId+z/R5soZJYSH3hdG3qWIJpUMzGfVNXr0Jb1zLM=
X-Received: by 2002:a67:c295:: with SMTP id k21mr16616682vsj.37.1633447562966;
 Tue, 05 Oct 2021 08:26:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210928140721.8805-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20210928140721.8805-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20210928140721.8805-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 5 Oct 2021 17:25:51 +0200
Message-ID: <CAMuHMdXVxOtvXu_DM5FjFzNcPbLtrRJ9W2R6CHmCc0ZJg9JJYw@mail.gmail.com>
Subject: Re: [PATCH 3/6] spi: spi-rpc-if: Check return value of rpcif_sw_init()
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Mark Brown <broonie@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Prabhakar,

Thanks for your patch!

On Tue, Sep 28, 2021 at 4:07 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> rpcif_sw_init() can fail so make sure we check the return value
> of it and on error exit rpcif_spi_probe() callback with error code.

Indeed, it will now fail earlier if CONFIG_RESET_CONTROLLER=n
Patch sent
https://lore.kernel.org/all/d4383bd1a97c0490c0bdc9dae5695f4230d4a420.1633447185.git.geert+renesas@glider.be

> Fixes: eb8d6d464a27 ("spi: add Renesas RPC-IF driver")
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
