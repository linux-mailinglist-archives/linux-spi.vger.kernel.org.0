Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 767DF4542FB
	for <lists+linux-spi@lfdr.de>; Wed, 17 Nov 2021 09:51:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233528AbhKQIys (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 17 Nov 2021 03:54:48 -0500
Received: from mail-vk1-f180.google.com ([209.85.221.180]:43765 "EHLO
        mail-vk1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231591AbhKQIyr (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 17 Nov 2021 03:54:47 -0500
Received: by mail-vk1-f180.google.com with SMTP id f7so1171956vkf.10;
        Wed, 17 Nov 2021 00:51:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ogB0Be3VMRxXMWyZSKVkExMjf29Yb3it6P5RHt/MWPI=;
        b=OuOwKd6spnPoT8pgON8wiUW1iX4vAhQ0ZsAh+xyc6VR+2PusCgrlCnH5BSZPM5II1l
         hZcDynyWCe4ulQNzPKL2mZK7Jcv1DY7dqUVktg2Eubmk92cdXzUbY6PuK5SFXpLnu/DM
         7Ir/hZ0z3YfXr8ibyywoQsSgknPqh7g/bHfv9fUAMxnhIBplxTvLkdpgUB89qM+u50dt
         IDGkqu5s5m4rPJxNoa6ThN2gH4d4+FSLFEUknjsYCyK0qonBrcohggwFULn8nzbwkcTh
         6S9t7I20IRIUA8EteG/dpYa1JrM9vaMIwX03UoP0u4XGqdvMLnDF9tOs1RYEQP30YvXd
         I3OQ==
X-Gm-Message-State: AOAM531kUpvmEpPQyg+/2n5FOhWmwOwLR88DzAhbEePvG0IYCB6JoX63
        E+Nm0d67g/TFbfIL2Ed+ACsjtGUN3+t7Wg==
X-Google-Smtp-Source: ABdhPJxyEKJU0lZv3RUXoIROdSDfmVj2tDeVHXAQznR6vv3dmLwNeJYKo1+JunTJIwOylLo1zWjyKw==
X-Received: by 2002:a05:6122:1350:: with SMTP id f16mr42180940vkp.10.1637139108555;
        Wed, 17 Nov 2021 00:51:48 -0800 (PST)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com. [209.85.222.41])
        by smtp.gmail.com with ESMTPSA id g131sm11596914vke.32.2021.11.17.00.51.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Nov 2021 00:51:48 -0800 (PST)
Received: by mail-ua1-f41.google.com with SMTP id n6so4332582uak.1;
        Wed, 17 Nov 2021 00:51:47 -0800 (PST)
X-Received: by 2002:a05:6102:1354:: with SMTP id j20mr65779978vsl.41.1637139107431;
 Wed, 17 Nov 2021 00:51:47 -0800 (PST)
MIME-Version: 1.0
References: <20211117010527.27365-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20211117010527.27365-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20211117010527.27365-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 17 Nov 2021 09:51:36 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWD-bANzURAgksYyZM-u6wPaATiNS-DjVg6NLpk7Stj6g@mail.gmail.com>
Message-ID: <CAMuHMdWD-bANzURAgksYyZM-u6wPaATiNS-DjVg6NLpk7Stj6g@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: spi: renesas,rspi: Document RZ/G2L SoC
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-spi <linux-spi@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Prabhakar,

On Wed, Nov 17, 2021 at 2:05 AM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Add RSPI binding documentation for Renesas RZ/G2L SoC.
>
> RSPI block is identical to one found on RZ/A, so no driver changes are
> required the fallback compatible string "renesas,rspi-rz" will be used

... required. The ...

> on RZ/G2L
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/Documentation/devicetree/bindings/spi/renesas,rspi.yaml
> +++ b/Documentation/devicetree/bindings/spi/renesas,rspi.yaml
> @@ -21,7 +21,8 @@ properties:
>            - enum:
>                - renesas,rspi-r7s72100  # RZ/A1H
>                - renesas,rspi-r7s9210   # RZ/A2
> -          - const: renesas,rspi-rz     # RZ/A
> +              - renesas,r9a07g044-rspi # RZ/G2{L,LC}
> +          - const: renesas,rspi-rz     # RZ/A and RZ/G2{L,LC}
>
>        - items:
>            - enum:
> @@ -116,6 +117,16 @@ allOf:
>        required:
>          - interrupt-names
>
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - renesas,r9a07g044-rspi
> +    then:
> +      required:
> +        - resets
> +

You may want to merge this with the existing section that makes
resets required for renesas,qspi.

>    - if:
>        properties:
>          compatible:

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
