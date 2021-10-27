Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89DFC43C3CA
	for <lists+linux-spi@lfdr.de>; Wed, 27 Oct 2021 09:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238612AbhJ0HYv (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 27 Oct 2021 03:24:51 -0400
Received: from mail-vk1-f170.google.com ([209.85.221.170]:33315 "EHLO
        mail-vk1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231641AbhJ0HYu (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 27 Oct 2021 03:24:50 -0400
Received: by mail-vk1-f170.google.com with SMTP id d130so950480vke.0;
        Wed, 27 Oct 2021 00:22:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/iJZSwBfMB4rhQgp9Yn6aeYD+316WLPLDz4u9JiASsw=;
        b=NYPsxVcRSyoO3cSk8zEzhSDP3YqdFO9u1nzM+WKOOqEtXJjkU3MSVreLE2GYBUdf43
         U4NnhvdbkNmP+ABcGBJJY4RD7M7RGFQCYoiLEvebSxoB3Z6r1XyEgH6ZbZExAYTL3dGv
         DdOVskVV5l4bhtRh/bowgYszZw0E4P7HG4UGY/ebjZvNTy5Ye+DPMwsZjXFxjygylqra
         V5wxy07mgRIzovHLfn9AEr+oz1hQNMD4k7RqVysDTY3SwykJoQlj5zcggYOwyNXNmED/
         1Wk2JWhCMS5JK0sOWdbWI/yVcV9/BYvWES5R+ycadUvlMudtPMc+dCPlQBNuDYlVArOL
         BAuQ==
X-Gm-Message-State: AOAM533zGhH09HrITRWZNVszz7cAAkD8YJYEGjefKm2mTB2ElzBpDQq4
        GnnHkjpUB5MlVf62V5XuNSQlGLz+/x07Cw==
X-Google-Smtp-Source: ABdhPJzZoW6F2xjCoU7CkCRXuAbqAgc1ek/bC0U9grdO+Os1sNB3b8HCbsmxb2oM4L2u9dg8lAkk2w==
X-Received: by 2002:a1f:f20f:: with SMTP id q15mr13637378vkh.3.1635319344845;
        Wed, 27 Oct 2021 00:22:24 -0700 (PDT)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com. [209.85.222.45])
        by smtp.gmail.com with ESMTPSA id c12sm223539vkn.2.2021.10.27.00.22.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Oct 2021 00:22:24 -0700 (PDT)
Received: by mail-ua1-f45.google.com with SMTP id v20so3109351uaj.9;
        Wed, 27 Oct 2021 00:22:23 -0700 (PDT)
X-Received: by 2002:a67:f4c9:: with SMTP id s9mr18113716vsn.35.1635319343494;
 Wed, 27 Oct 2021 00:22:23 -0700 (PDT)
MIME-Version: 1.0
References: <20211025205631.21151-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20211025205631.21151-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20211025205631.21151-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 27 Oct 2021 09:22:12 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVt0o++AiP=A0jsZPUAfvWgn1V8ZwtGT2ha-v1zw1cY_Q@mail.gmail.com>
Message-ID: <CAMuHMdVt0o++AiP=A0jsZPUAfvWgn1V8ZwtGT2ha-v1zw1cY_Q@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] memory: renesas-rpc-if: Drop usage of
 RPCIF_DIRMAP_SIZE macro
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Mark Brown <broonie@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Oct 25, 2021 at 10:57 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> RPCIF_DIRMAP_SIZE may differ on various SoC's. Instead of using
> RPCIF_DIRMAP_SIZE macro use resource size to get dirmap size
> which is already part of struct rpcif.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
