Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41A63422B6C
	for <lists+linux-spi@lfdr.de>; Tue,  5 Oct 2021 16:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235265AbhJEOsm (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 5 Oct 2021 10:48:42 -0400
Received: from mail-vs1-f51.google.com ([209.85.217.51]:42963 "EHLO
        mail-vs1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233705AbhJEOsj (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 5 Oct 2021 10:48:39 -0400
Received: by mail-vs1-f51.google.com with SMTP id y14so10027862vsm.9;
        Tue, 05 Oct 2021 07:46:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Khxc7wZumOtpS5mwACBEuWfNWBNzntWbNHisFSzTh08=;
        b=5nvLDLj6NOtMwszfcD/jyNwDxMjdK25XmS6Jru/upYZt9VORevIgBKswKydErTOnZ6
         ZkNUT2oyNgOSJioCRH7y67ZPfGT/qpyUzMk8rdKE2VsEgcawqXKB53YoXlG2qWYcNLXk
         cekHvdQZ4cuRXjZQkL/yAuq9z1Pi6vTK2p/6w928HGAal1/+FIZOeTZlC2nGzeuDYEMa
         EiMgaawSuqYKXT4E0DjcUYlD26v8ioZ7YveZpSbGvSngKGf4RezyMJPTlo9uZZ2wItCU
         ZkCFzV6znHrg0BwPTYs1jpUIX23vpfJUGgB0MVccubA+JJf6tcX/6CVzZzt9J7xmYz0c
         TLeA==
X-Gm-Message-State: AOAM533fhUG8oI1XtmPTcJgy7yeIMoENPqniLk/1dc1F4eq1ntowQT3x
        eKC6zUg9M4EN1JdUSrFU/fjlNMAc/KMO3078DqM=
X-Google-Smtp-Source: ABdhPJxIHGhZacfkPIP0QwC6n8pXB9a9H3QfA2yMDeJQ7gBJ7CYF5IWxa2O5+r8IhAP9kqfW3mmB/ggpMuuDqe6hnpk=
X-Received: by 2002:a67:c295:: with SMTP id k21mr16360605vsj.37.1633445208279;
 Tue, 05 Oct 2021 07:46:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210928140721.8805-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20210928140721.8805-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20210928140721.8805-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 5 Oct 2021 16:46:37 +0200
Message-ID: <CAMuHMdVy7RxUSWQOUDKB3-8igjYGBXO4ZYy=DamgQPqknXaUkw@mail.gmail.com>
Subject: Re: [PATCH 1/6] dt-bindings: memory: renesas,rpc-if: Add support for
 the R9A07G044
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
> SPI Multi I/O Bus Controller on RZ/G2L SoC is almost identical to
> the RPC-IF interface found on R-Car Gen3 SoC's.
>
> This patch adds a new compatible string to identify the RZ/G2L family
> so that the timing values on RZ/G2L can be adjusted.
>
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
