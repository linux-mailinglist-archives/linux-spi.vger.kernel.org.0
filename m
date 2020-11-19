Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 670302B907E
	for <lists+linux-spi@lfdr.de>; Thu, 19 Nov 2020 11:59:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbgKSK6E (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 19 Nov 2020 05:58:04 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:37043 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726644AbgKSK6E (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 19 Nov 2020 05:58:04 -0500
Received: by mail-oi1-f196.google.com with SMTP id j15so523011oih.4;
        Thu, 19 Nov 2020 02:58:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PBDnVKEHNkn0XEpRmNcq0P71nm9E4KnrTMVqPCmJvVk=;
        b=gULQlgNCCiAVA+08fePW9YwbLQCXpUvT6HSlj4SXQxAdixG7m+jsdqWIC2hQBvHQSh
         L++Ut1o4psn1GS1g4yD/uCBXf5+tocQ5hJV/ZAAO1Li5W/QTgUkgBn9pIhwGc/IwkDcK
         gaccRF+9nQXdTvAPETH7dRzRDlAPdCr33JejGKfzd5OfBh8ObZWAkpdX/N8MrgOjOsqQ
         BPu3HG1GAB50Ft0QQ3al5fKeNtLcGoHpO9GtEkdfYDgs8QHPo2oiOeuKGFt+YaKA2jIr
         p1vNrjwvF7gboGCmmwZWY5eT/ZvbBW5hYqmFNkcXf3qUesJTaztgyMOvue7Ia3gEVk9U
         fjAQ==
X-Gm-Message-State: AOAM533UIneEhpX4R5A4mszQ7K+WP4FjAe9XUL7m2Fvx6c4tOvG1qq0T
        E6gfMhyfk0TU2zqZMrrroEWC1vdpqSgc/8F2fmUY7RaZec8=
X-Google-Smtp-Source: ABdhPJyc0kbDdNA5pI8yJr3UWxbQERyJ/f1qUShZVxXxSs6+FyWRdbsuMRhkSp143Tedxp9sefucC/ULV5Ar4S3QU28=
X-Received: by 2002:aca:c3c4:: with SMTP id t187mr2269568oif.148.1605783483057;
 Thu, 19 Nov 2020 02:58:03 -0800 (PST)
MIME-Version: 1.0
References: <20201107081420.60325-1-damien.lemoal@wdc.com> <20201107081420.60325-25-damien.lemoal@wdc.com>
 <20201109153625.GB1330401@bogus> <04b266c7-bba9-d847-a526-f64f76c11a50@gmail.com>
In-Reply-To: <04b266c7-bba9-d847-a526-f64f76c11a50@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 19 Nov 2020 11:57:51 +0100
Message-ID: <CAMuHMdV0GL-GoY5=cgsW5QEWPB=ySK-8EyVeKLwt=6oODV4z3A@mail.gmail.com>
Subject: Re: [PATCH 24/32] dt-bindings: Document kendryte,k210-fpioa bindings
To:     Damien Le Moal <damien.lemoal@wdc.com>,
        Sean Anderson <seanga2@gmail.com>
Cc:     Rob Herring <robh@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Frank Rowand <frowand.list@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Damien, Sean,

On Mon, Nov 9, 2020 at 4:46 PM Sean Anderson <seanga2@gmail.com> wrote:
> On 11/9/20 10:36 AM, Rob Herring wrote:
> > On Sat, Nov 07, 2020 at 05:14:12PM +0900, Damien Le Moal wrote:
> >> Document the device tree bindings for the Kendryte K210 SoC Fully
> >> Programmable IO Array (FPIOA) pinctrl driver in
> >> Documentation/devicetree/bindings/pinctrl/kendryte,k210-fpioa.yaml
> >>
> >> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>

> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/pinctrl/kendryte,k210-fpioa.yaml

> >> +  kendryte,power-offset:
> >> +    minItems: 1
> >> +    maxItems: 1
> >> +    $ref: /schemas/types.yaml#/definitions/uint32
> >> +    description: |
> >> +      Offset of the power domain control register of the system controller.
> >
> > Sounds like you should be using power-domains binding.
>
> This is for pin power domains. E.g. pins 0-5 can be set to 1V8 or 3V3 logic levels.

Which brings to my attention the power-source property is not
documented below...

> >> +      The value should be the macro K210_SYSCTL_POWER_SEL defined in
> >> +      dt-bindings/mfd/k210-sysctl.h.
> >> +
> >> +patternProperties:
> >> +  '^.*$':
> >> +    if:
> >> +      type: object
> >> +    then:

As the driver supports e.g. bias and drive-strength, these should be
documented here, too.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
