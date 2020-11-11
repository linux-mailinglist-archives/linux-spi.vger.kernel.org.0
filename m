Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC6F22AF39C
	for <lists+linux-spi@lfdr.de>; Wed, 11 Nov 2020 15:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbgKKOcR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 11 Nov 2020 09:32:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:44210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726338AbgKKOcR (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 11 Nov 2020 09:32:17 -0500
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7DDD9207BB;
        Wed, 11 Nov 2020 14:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605105136;
        bh=muSLYibs0ZGONy3L3c3n/+gux1chNtnCxNxW3stscoY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hFrzd16CQbRJJPLAQQTpdLQo9C4aF3SuO8TVnJGuUByiW/sFMF7U+EjQcJUgQWl8q
         jT9hFgWFtHhUE2CXdk2ELs2U4FsIWQ1qB7qnEyINQQ+BFMIXXvXLTNnvwtf33vgQl0
         06CfiJvGvJuGCsWAn9fthW6u8Of7C0n1Dv8/H0FQ=
Received: by mail-oi1-f176.google.com with SMTP id m17so2372584oie.4;
        Wed, 11 Nov 2020 06:32:16 -0800 (PST)
X-Gm-Message-State: AOAM531NAuFq9m1ALadD7tdYO2toDm9sZ5TC98+hOz8qDCVgE6TfDCZR
        FxdyAXq8avsGWHFmn3OeHf74bRwnRnFVNxj5cA==
X-Google-Smtp-Source: ABdhPJyBAmSgmXMjpq6AAOkmqmbZGZptg0qCA3HGPghqhOTq/+URiIjllWXA/wYIci1U+X2mffVzaZzIIAj2IJIQudY=
X-Received: by 2002:aca:5dc2:: with SMTP id r185mr2316288oib.106.1605105135706;
 Wed, 11 Nov 2020 06:32:15 -0800 (PST)
MIME-Version: 1.0
References: <20201107081420.60325-1-damien.lemoal@wdc.com> <20201107081420.60325-25-damien.lemoal@wdc.com>
 <20201109153625.GB1330401@bogus> <04b266c7-bba9-d847-a526-f64f76c11a50@gmail.com>
In-Reply-To: <04b266c7-bba9-d847-a526-f64f76c11a50@gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 11 Nov 2020 08:32:04 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJy_6ALEKdk7ZOEaM58Xi6NLBYd_aYNeVr2CpyjSBVpmA@mail.gmail.com>
Message-ID: <CAL_JsqJy_6ALEKdk7ZOEaM58Xi6NLBYd_aYNeVr2CpyjSBVpmA@mail.gmail.com>
Subject: Re: [PATCH 24/32] dt-bindings: Document kendryte,k210-fpioa bindings
To:     Sean Anderson <seanga2@gmail.com>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>,
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

On Mon, Nov 9, 2020 at 9:45 AM Sean Anderson <seanga2@gmail.com> wrote:
>
> On 11/9/20 10:36 AM, Rob Herring wrote:
> > On Sat, Nov 07, 2020 at 05:14:12PM +0900, Damien Le Moal wrote:
> >> Document the device tree bindings for the Kendryte K210 SoC Fully
> >> Programmable IO Array (FPIOA) pinctrl driver in
> >> Documentation/devicetree/bindings/pinctrl/kendryte,k210-fpioa.yaml
> >>
> >> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> >> ---
> >>  .../bindings/pinctrl/kendryte,k210-fpioa.yaml | 106 ++++++++++++++++++
> >>  1 file changed, 106 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/pinctrl/kendryte,k210-fpioa.yaml
> >>
> >> diff --git a/Documentation/devicetree/bindings/pinctrl/kendryte,k210-fpioa.yaml b/Documentation/devicetree/bindings/pinctrl/kendryte,k210-fpioa.yaml
> >> new file mode 100644
> >> index 000000000000..8730add88ee0
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/pinctrl/kendryte,k210-fpioa.yaml
> >> @@ -0,0 +1,106 @@
> >> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >> +%YAML 1.2
> >> +---
> >> +$id: http://devicetree.org/schemas/pinctrl/kendryte,k210-fpioa.yaml#
> >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >> +
> >> +title: Kendryte K210 FPIOA (Fully Programmable IO Array) Device Tree Bindings
> >> +
> >> +maintainers:
> >> +  - Damien Le Moal <damien.lemoal@wdc.com>
> >> +
> >> +description:
> >> +  The Kendryte K210 SoC Fully Programmable IO Array controller allows assiging
> >> +  any of 256 possible functions to any of 48 IO pins. Pin function configuration
> >> +  is performed on a per-pin basis.
> >> +
> >> +properties:
> >> +  compatible:
> >> +    const: kendryte,k210-fpioa
> >> +
> >> +  reg:
> >> +    description: FPIOA controller register space base address and size
> >> +
> >> +  clocks:
> >> +    minItems: 2
> >> +    maxItems: 2
> >
> > Can drop these. Implied by 'items' length.
> >
> >> +    items:
> >> +      - description: Controller reference clock source
> >> +      - description: APB interface clock source
> >> +
> >> +  clock-names:
> >> +    minItems: 2
> >> +    maxItems: 2
> >> +    items:
> >> +      - const: ref
> >> +      - const: pclk
> >> +
> >> +  resets:
> >> +    maxItems: 1
> >> +
> >> +  kendryte,sysctl:
> >> +    minItems: 1
> >> +    maxItems: 1
> >> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> >> +    description: |
> >> +      phandle to the system controller node
> >> +
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

Okay, please make that clear in the description. You can combine the
above 2 properties into one which is a phandle+offset.

Rob
