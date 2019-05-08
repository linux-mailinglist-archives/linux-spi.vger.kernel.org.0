Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41F8E17202
	for <lists+linux-spi@lfdr.de>; Wed,  8 May 2019 09:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbfEHHCa (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 8 May 2019 03:02:30 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:38963 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbfEHHCa (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 8 May 2019 03:02:30 -0400
Received: by mail-vk1-f196.google.com with SMTP id s80so4701510vke.6;
        Wed, 08 May 2019 00:02:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s3snM+V6eXPtc3suucMMZZ/lK+LHa/OrZBjLjSByG20=;
        b=CykxoTpcT9zU5Q/RpdVfPWYZ7Yd/Hkg4CwX59NuEGsQL6KFKRoTcg/Vo2x9QirPjNo
         4KOa/cyxHHEHeBQAnMyaE2lQq3XcQVKzauygnId9WbBuDbvEixn3cWJ1yiJyHIINq8aM
         H9CsAk1Gs4+g+NoiOkc2psHM44qkT7af3ZRiSTozb0VHCwCu1BuQcSQfAXgnVdVzb4b6
         47kGS+j33ETqgaSO15pdorwduIxble6vcIwDmXbgYzDL9oA0T5IiEOSbMyXNx+whiuB5
         qCQh+qIEvwHjDjwjZpZR8wASFIlcGB3qoWmP8tn/mWKR6hjPLPtsbAtoLnMe/CJErZ4q
         fxlQ==
X-Gm-Message-State: APjAAAXI7mQR6jBwfnart0RmySiY0cYdqv1vNokmO/0mIXG059Wjz6bs
        C4MJPxyRZ8X1KliJB/441f3649zBlcQXAg77AwY=
X-Google-Smtp-Source: APXvYqza/1hvaxWQdWLSj9zXnCXHGz/kbH9GtVmvA3jR7MZPios+I6UtHlJUbjkjBLz4KluTkPylBVYsMYSX9Ufq2UQ=
X-Received: by 2002:a1f:c2c1:: with SMTP id s184mr10230817vkf.65.1557298949399;
 Wed, 08 May 2019 00:02:29 -0700 (PDT)
MIME-Version: 1.0
References: <b7a6095a5c900fa23cc54d1ccd8e8ef0ccf6e788.1557236840.git-series.maxime.ripard@bootlin.com>
 <CAL_JsqKeLWgGLafwbKViTgpw4B=W9YGULaMr8h0p_rWX8PP_UQ@mail.gmail.com>
In-Reply-To: <CAL_JsqKeLWgGLafwbKViTgpw4B=W9YGULaMr8h0p_rWX8PP_UQ@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 8 May 2019 09:02:17 +0200
Message-ID: <CAMuHMdX7KjJf4yDiEBBXLogHGbo9LcfTM5TvCHAXu_0Bvf0uzA@mail.gmail.com>
Subject: Re: [PATCH 1/4] dt-bindings: spi: Add YAML schemas for the generic
 SPI options
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Mark Brown <broonie@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, May 7, 2019 at 4:35 PM Rob Herring <robh+dt@kernel.org> wrote:
> On Tue, May 7, 2019 at 8:48 AM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > The SPI controllers have a bunch of generic options that are needed in a
> > device tree. Add a YAML schemas for those.
> >
> > Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>

> > index 1f6e86f787ef..000000000000
> > --- a/Documentation/devicetree/bindings/spi/spi-bus.txt
> > +++ /dev/null

> > -In master mode, the SPI controller node requires the following additional
> > -properties:
> > -- #address-cells  - number of cells required to define a chip select
> > -               address on the SPI bus.
> > -- #size-cells     - should be zero.
> > -
> > -In slave mode, the SPI controller node requires one additional property:
> > -- spi-slave       - Empty property.

> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/spi/spi-controller.yaml

> > +  spi-slave:
> > +    $ref: /schemas/types.yaml#/definitions/flag
>
> "type: boolean" is sufficient here. Maybe we should just remove
> 'flag'. OTOH, maybe consistency with other types and the abstraction
> is better as we could add to the flag schema.
>
> > +    description:
> > +      The SPI controller acts as a slave, instead of a master.
> > +
> > +required:
> > +  - "#address-cells"
> > +  - "#size-cells"
>
> Only if there are child nodes...

... and spi-slave is not present.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
