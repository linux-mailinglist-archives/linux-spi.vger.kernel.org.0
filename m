Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 014A54266CE
	for <lists+linux-spi@lfdr.de>; Fri,  8 Oct 2021 11:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238661AbhJHJ3O (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 8 Oct 2021 05:29:14 -0400
Received: from mail-vs1-f44.google.com ([209.85.217.44]:40810 "EHLO
        mail-vs1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238620AbhJHJ3K (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 8 Oct 2021 05:29:10 -0400
Received: by mail-vs1-f44.google.com with SMTP id p18so9731692vsu.7;
        Fri, 08 Oct 2021 02:27:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vIxqZ8vYkfX7BBcbiKGGKsrdng7+H+Cq45sUTEZMSXg=;
        b=f+9fIB6QxOnpz8coOql3lefpsTc1NKKkxlocop+DeBN7eoGt1P45RRnZFtvnU5Mh18
         /XK4H7DMZuHNtXQYV3HY3hFxvx8EAgE4cPtDFB7YNI6sotLGi2TC3M/wv0KAjQFr+Sg2
         JCB4uiG47LCLfln1qkDGiE32BdXGsvPyd4MnOi034PsabXisoDHrBC9JB9Oj6bYXvGxb
         ix5nwlVJp0Tw5kF275vOuJB6jwECvxIqO589q5hyA7y/0T41tz4j/jxk1U0MJGoHKifr
         6lojJ6BFQBh4BMRmWkvEnGimEZlIQlQvAF3tSN4rUzPH6guGntU+9A/5hoDfoGv2gyiK
         yXCQ==
X-Gm-Message-State: AOAM532Hy9TSTNXi/sScdxKcbfyRHdaZY1ELSASMzSM6WdaSfKAqaqNU
        yU2YCtuZLvjLAVVIeVIpSppPXMvqOOAj6m4UCWg=
X-Google-Smtp-Source: ABdhPJzo2GMDwS4XL8GaqtAxYSHO5tU8oRsCkFAUO5XMKVVRxBe8G5avT2hGBR+Rk6tHcw+u6K58Nb/PFfsDHGycMak=
X-Received: by 2002:a05:6102:d8c:: with SMTP id d12mr2395147vst.35.1633685234262;
 Fri, 08 Oct 2021 02:27:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210928140721.8805-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20210928140721.8805-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20210928140721.8805-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 8 Oct 2021 11:27:03 +0200
Message-ID: <CAMuHMdW_X+ji9316DkKP20zgwjn+AzXTXKKJ4nox5XkeiwQQ8w@mail.gmail.com>
Subject: Re: [PATCH 4/6] mtd: hyperbus: rpc-if: Check return value of rpcif_sw_init()
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
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

On Tue, Sep 28, 2021 at 4:07 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> rpcif_sw_init() can fail so make sure we check the return value
> of it and on error exit rpcif_hb_probe() callback with error code.
>
> Fixes: 5de15b610f78 ("mtd: hyperbus: add Renesas RPC-IF driver")
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
