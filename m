Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20F84169E2
	for <lists+linux-spi@lfdr.de>; Tue,  7 May 2019 20:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbfEGSHi (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 7 May 2019 14:07:38 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:36195 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726378AbfEGSHi (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 7 May 2019 14:07:38 -0400
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 7E4F124000B;
        Tue,  7 May 2019 18:07:33 +0000 (UTC)
Date:   Tue, 7 May 2019 17:13:53 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>, devicetree@vger.kernel.org,
        linux-spi <linux-spi@vger.kernel.org>
Subject: Re: [PATCH 1/4] dt-bindings: spi: Add YAML schemas for the generic
 SPI options
Message-ID: <20190507151353.ns2i72ii5cw6z7lz@flea>
References: <b7a6095a5c900fa23cc54d1ccd8e8ef0ccf6e788.1557236840.git-series.maxime.ripard@bootlin.com>
 <CAL_JsqKeLWgGLafwbKViTgpw4B=W9YGULaMr8h0p_rWX8PP_UQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqKeLWgGLafwbKViTgpw4B=W9YGULaMr8h0p_rWX8PP_UQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

On Tue, May 07, 2019 at 09:35:28AM -0500, Rob Herring wrote:
> On Tue, May 7, 2019 at 8:48 AM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> >
> > The SPI controllers have a bunch of generic options that are needed in a
> > device tree. Add a YAML schemas for those.
>
> I'd started on this one, but was planning to move it to the schema
> repository. The issue there is re-licensing (adding BSD 2 clause).
> Maybe better to just move it later.

I just found out that dt-doc-validate also chokes on the reference
URI. Maybe I should just submit it to the repo then once that is
settled?

> > +properties:
> > +  $nodename:
> > +    pattern: "^spi(@[a-zA-Z0-9]+)?$"
>
> I think we want just "(@.*)". At a minimum, you need to allow for ','.
> It would be the a bus schema for the parent which should validate unit
> addresses, so we should pretty much just allow anything here.

The issue with this is that it will also match any node starting with
spi. In the Allwinner case, that also means the pinctrl nodes with spi
pins in them, but I'm sure we can find more corner cases.

> > +
> > +  "#address-cells":
> > +    const: 1
> > +
> > +  "#size-cells":
> > +    const: 0
> > +
> > +  cs-gpios:
> > +    description: |
> > +      GPIOs used as chip selects.
> > +      If that property is used, the number of chip selects will be
> > +      increased automatically with max(cs-gpios, hardware chip selects).
> > +
> > +      So if, for example, the controller has 2 CS lines, and the
> > +      cs-gpios looks like this
> > +        cs-gpios = <&gpio1 0 0>, <0>, <&gpio1 1 0>, <&gpio1 2 0>;
> > +
> > +      Then it should be configured so that num_chipselect = 4, with
> > +      the following mapping
> > +        cs0 : &gpio1 0 0
> > +        cs1 : native
> > +        cs2 : &gpio1 1 0
> > +        cs3 : &gpio1 2 0
> > +
> > +  num-cs:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description:
> > +      Total number of chip selects.
> > +
> > +  spi-slave:
> > +    $ref: /schemas/types.yaml#/definitions/flag
>
> "type: boolean" is sufficient here. Maybe we should just remove
> 'flag'. OTOH, maybe consistency with other types and the abstraction
> is better as we could add to the flag schema.

I was trying to be consistent. Do you want me to remove it?

> > +      spi-rx-bus-width:
> > +        allOf:
> > +          - $ref: /schemas/types.yaml#/definitions/uint32
> > +          - enum: [ 1, 2, 4, 8 ]
>
> Is the old doc out of date and 8 is allowed now?

It's not, it's a copy and paste mistake.

I'll respin this with your fixes, thanks!
Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
