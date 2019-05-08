Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3364D16EAC
	for <lists+linux-spi@lfdr.de>; Wed,  8 May 2019 03:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbfEHBhW (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 7 May 2019 21:37:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:59742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726378AbfEHBhW (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 7 May 2019 21:37:22 -0400
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88AC0214C6;
        Wed,  8 May 2019 01:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557279441;
        bh=OIKNrpQ//1+gNyFNJNx5GTrLEgWv7I8DuK91PHiBHGU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YoIj9jBz0ncG68/oormp3IZkK+oscTLcGb8PSX4KzJuQ7lM2ZwkFTsUrfsUc6uwn+
         P1o3R/VHf4Bnai4Bd9WniWYjnFgSSr/bBxalHv9qCm3WjRFIkMY/SFRPnRd4druLg3
         7veiohg9gGuwgwZ0TJS6u5KodZgBdccsb1Yofsv8=
Received: by mail-qk1-f173.google.com with SMTP id g190so2409269qkf.8;
        Tue, 07 May 2019 18:37:21 -0700 (PDT)
X-Gm-Message-State: APjAAAWxoM0AtyLg0VZOTskqZkZtc2xPFC48Ul0NNPy+Z0AW7CqQdRtC
        0nBb15wlP9bLy7oasG1W8Od3HnP4O2N14jVdXg==
X-Google-Smtp-Source: APXvYqyeiy1xlQlbcMBCEKm6e0Cu0M1tx5QYpc220iWQ2Ezm2T8NmPq4Igp3eHP72JG5/Njg7ZMROOL/ApIYZNB2fdY=
X-Received: by 2002:a37:351:: with SMTP id 78mr1234316qkd.147.1557279440735;
 Tue, 07 May 2019 18:37:20 -0700 (PDT)
MIME-Version: 1.0
References: <b7a6095a5c900fa23cc54d1ccd8e8ef0ccf6e788.1557236840.git-series.maxime.ripard@bootlin.com>
 <CAL_JsqKeLWgGLafwbKViTgpw4B=W9YGULaMr8h0p_rWX8PP_UQ@mail.gmail.com> <20190507151353.ns2i72ii5cw6z7lz@flea>
In-Reply-To: <20190507151353.ns2i72ii5cw6z7lz@flea>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 7 May 2019 20:37:09 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+AzBUcJouvOCdYPHK6z8h_V3h5vqYPUuFD756z49wf3w@mail.gmail.com>
Message-ID: <CAL_Jsq+AzBUcJouvOCdYPHK6z8h_V3h5vqYPUuFD756z49wf3w@mail.gmail.com>
Subject: Re: [PATCH 1/4] dt-bindings: spi: Add YAML schemas for the generic
 SPI options
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>, devicetree@vger.kernel.org,
        linux-spi <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, May 7, 2019 at 1:07 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> Hi,
>
> On Tue, May 07, 2019 at 09:35:28AM -0500, Rob Herring wrote:
> > On Tue, May 7, 2019 at 8:48 AM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > >
> > > The SPI controllers have a bunch of generic options that are needed in a
> > > device tree. Add a YAML schemas for those.
> >
> > I'd started on this one, but was planning to move it to the schema
> > repository. The issue there is re-licensing (adding BSD 2 clause).
> > Maybe better to just move it later.
>
> I just found out that dt-doc-validate also chokes on the reference
> URI. Maybe I should just submit it to the repo then once that is
> settled?

I'm not really too excited about chasing down licensing on every file
we want to move and I'd like to avoid per file licenses, so I'd like
local $refs to work. I think I've got something figured out that will
work. It will need a small kernel side change though.

> > > +properties:
> > > +  $nodename:
> > > +    pattern: "^spi(@[a-zA-Z0-9]+)?$"
> >
> > I think we want just "(@.*)". At a minimum, you need to allow for ','.
> > It would be the a bus schema for the parent which should validate unit
> > addresses, so we should pretty much just allow anything here.
>
> The issue with this is that it will also match any node starting with
> spi. In the Allwinner case, that also means the pinctrl nodes with spi
> pins in them, but I'm sure we can find more corner cases.

Maybe I wasn't clear, but I meant changing just the unit-address part. So:

"^spi(@.*)$"

>
> > > +
> > > +  "#address-cells":
> > > +    const: 1
> > > +
> > > +  "#size-cells":
> > > +    const: 0
> > > +
> > > +  cs-gpios:
> > > +    description: |
> > > +      GPIOs used as chip selects.
> > > +      If that property is used, the number of chip selects will be
> > > +      increased automatically with max(cs-gpios, hardware chip selects).
> > > +
> > > +      So if, for example, the controller has 2 CS lines, and the
> > > +      cs-gpios looks like this
> > > +        cs-gpios = <&gpio1 0 0>, <0>, <&gpio1 1 0>, <&gpio1 2 0>;
> > > +
> > > +      Then it should be configured so that num_chipselect = 4, with
> > > +      the following mapping
> > > +        cs0 : &gpio1 0 0
> > > +        cs1 : native
> > > +        cs2 : &gpio1 1 0
> > > +        cs3 : &gpio1 2 0
> > > +
> > > +  num-cs:
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > +    description:
> > > +      Total number of chip selects.
> > > +
> > > +  spi-slave:
> > > +    $ref: /schemas/types.yaml#/definitions/flag
> >
> > "type: boolean" is sufficient here. Maybe we should just remove
> > 'flag'. OTOH, maybe consistency with other types and the abstraction
> > is better as we could add to the flag schema.
>
> I was trying to be consistent. Do you want me to remove it?

No, it's fine.

Rob
