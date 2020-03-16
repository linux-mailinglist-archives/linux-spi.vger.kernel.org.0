Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A04C1874F4
	for <lists+linux-spi@lfdr.de>; Mon, 16 Mar 2020 22:43:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732691AbgCPVn5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 16 Mar 2020 17:43:57 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:52332 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732652AbgCPVn5 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 16 Mar 2020 17:43:57 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 4283D2005A;
        Mon, 16 Mar 2020 22:43:48 +0100 (CET)
Date:   Mon, 16 Mar 2020 22:43:46 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     dri-devel@lists.freedesktop.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        Alexandre Courbot <acourbot@nvidia.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Brian Masney <masneyb@onstation.org>,
        Chris Zhong <zyw@rock-chips.com>,
        Douglas Anderson <dianders@chromium.org>,
        Guido Gunther <agx@sigxcpu.org>, Heiko Schocher <hs@denx.de>,
        Nikolaus Schaller <hns@goldelico.com>,
        Hoegeun Kwon <hoegeun.kwon@samsung.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Jerry Han <hanxu5@huaqin.corp-partner.google.com>,
        Jonathan Bakker <xc-racer2@live.ca>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Lin Huang <hl@rock-chips.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-spi@vger.kernel.org, Marco Franchi <marco.franchi@nxp.com>,
        Marek Belisko <marek@goldelico.com>,
        Mark Brown <broonie@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Nickey Yang <nickey.yang@rock-chips.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Peter Rosin <peda@axentia.se>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Purism Kernel Team <kernel@puri.sm>,
        Robert Chiras <robert.chiras@nxp.com>,
        Sandeep Panda <spanda@codeaurora.org>,
        Stefan Mavrodiev <stefan@olimex.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Vinay Simha BN <simhavcs@gmail.com>,
        Werner Johansson <werner.johansson@sonymobile.com>
Subject: Re: [PATCH v1 02/36] dt-bindings: spi: support non-spi bindings as
 SPI slaves
Message-ID: <20200316214346.GA23637@ravnborg.org>
References: <20200315134416.16527-1-sam@ravnborg.org>
 <20200315134416.16527-3-sam@ravnborg.org>
 <20200316204850.gggeyjulgiy53i7x@gilmour.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200316204850.gggeyjulgiy53i7x@gilmour.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=eMA9ckh1 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=7gkXJVJtAAAA:8
        a=P-IC7800AAAA:8 a=VwQbUJbxAAAA:8 a=unGCcehtwgLSmkbFn9MA:9
        a=CjuIK1q_8ugA:10 a=E9Po1WZjFZOl8hwRPBS3:22 a=d3PnA9EDa4IxuAV0gXij:22
        a=AjGcO6oz07-iQ99wixmX:22
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Maxime.

On Mon, Mar 16, 2020 at 09:48:50PM +0100, Maxime Ripard wrote:
> Hi Sam,
> 
> On Sun, Mar 15, 2020 at 02:43:42PM +0100, Sam Ravnborg wrote:
> > Independent bindings can be SPI slaves which for example is
> > the case for several panel bindings.
> >
> > Move SPI slave properties to spi-slave.yaml so the independent
> > SPI slave bindings can include spi-slave.yaml rather than
> > duplicating the properties.
> >
> > Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> > Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> > Cc: Rob Herring <robh@kernel.org>
> > Cc: Mark Brown <broonie@kernel.org>
> > Cc: linux-spi@vger.kernel.org
> > ---
> >  .../bindings/spi/spi-controller.yaml          | 63 +-------------
> >  .../devicetree/bindings/spi/spi-slave.yaml    | 83 +++++++++++++++++++
> >  2 files changed, 86 insertions(+), 60 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/spi/spi-slave.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/spi/spi-controller.yaml b/Documentation/devicetree/bindings/spi/spi-controller.yaml
> > index 1e0ca6ccf64b..99531c8d10dd 100644
> > --- a/Documentation/devicetree/bindings/spi/spi-controller.yaml
> > +++ b/Documentation/devicetree/bindings/spi/spi-controller.yaml
> > @@ -67,71 +67,14 @@ patternProperties:
> >    "^.*@[0-9a-f]+$":
> >      type: object
> >
> > +    allOf:
> > +      - $ref: spi-slave.yaml#
> > +
> >      properties:
> >        compatible:
> >          description:
> >            Compatible of the SPI device.
> >
> > -      reg:
> > -        minimum: 0
> > -        maximum: 256
> > -        description:
> > -          Chip select used by the device.
> > -
> > -      spi-3wire:
> > -        $ref: /schemas/types.yaml#/definitions/flag
> > -        description:
> > -          The device requires 3-wire mode.
> > -
> > -      spi-cpha:
> > -        $ref: /schemas/types.yaml#/definitions/flag
> > -        description:
> > -          The device requires shifted clock phase (CPHA) mode.
> > -
> > -      spi-cpol:
> > -        $ref: /schemas/types.yaml#/definitions/flag
> > -        description:
> > -          The device requires inverse clock polarity (CPOL) mode.
> > -
> > -      spi-cs-high:
> > -        $ref: /schemas/types.yaml#/definitions/flag
> > -        description:
> > -          The device requires the chip select active high.
> > -
> > -      spi-lsb-first:
> > -        $ref: /schemas/types.yaml#/definitions/flag
> > -        description:
> > -          The device requires the LSB first mode.
> > -
> > -      spi-max-frequency:
> > -        $ref: /schemas/types.yaml#/definitions/uint32
> > -        description:
> > -          Maximum SPI clocking speed of the device in Hz.
> > -
> > -      spi-rx-bus-width:
> > -        allOf:
> > -          - $ref: /schemas/types.yaml#/definitions/uint32
> > -          - enum: [ 1, 2, 4, 8 ]
> > -          - default: 1
> > -        description:
> > -          Bus width to the SPI bus used for MISO.
> > -
> > -      spi-rx-delay-us:
> > -        description:
> > -          Delay, in microseconds, after a read transfer.
> > -
> > -      spi-tx-bus-width:
> > -        allOf:
> > -          - $ref: /schemas/types.yaml#/definitions/uint32
> > -          - enum: [ 1, 2, 4, 8 ]
> > -          - default: 1
> > -        description:
> > -          Bus width to the SPI bus used for MOSI.
> > -
> > -      spi-tx-delay-us:
> > -        description:
> > -          Delay, in microseconds, after a write transfer.
> > -
> 
> I can see what you're trying to do, but you don't really need to.
> 
> All the SPI devices will be declared under a spi controller node that
> will validate its child nodes (and thus the devices) already.

This was the missing piece - thanks.
And as Mark put it "why is this suddenly an issue"?
Turns out this is already properly handled and I made up an issue.
Maybe Mark tried to explian it to me already...

> 
> Doing it this way would actually make all the checks happen twice,
> once as part of the SPI controller, once as part of the SPI device
> binding, without any good reason.

I had focus on validating the example in the binding
file and not the full picture.

One thing I do not see properly addressed, but maybe I just miss it.
What triggers that we catch properties that are not supposed to be
present?

If we see a unsupported property "foobar":

spi {
    ...
    panel {
       ....
       foobar = <1>;
    };
};

somewhere in a SPI slave binding we should catch this.
If for no other reasons that it could be a simple spelling mistake
that otherwise could go undetected for a long time.
But maybe this is really not feasible to do?

	Sam
