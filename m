Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B15AB35FF
	for <lists+linux-spi@lfdr.de>; Mon, 16 Sep 2019 09:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbfIPHy7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 16 Sep 2019 03:54:59 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:51770 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbfIPHy7 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 16 Sep 2019 03:54:59 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 5549D25B705;
        Mon, 16 Sep 2019 17:54:56 +1000 (AEST)
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id 4E17B944602; Mon, 16 Sep 2019 09:54:54 +0200 (CEST)
Date:   Mon, 16 Sep 2019 09:54:54 +0200
From:   Simon Horman <horms@verge.net.au>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Mark Rutland <mark.rutland@arm.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Yoshihiro Kaneko <ykaneko0929@gmail.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "open list:MEDIA DRIVERS FOR RENESAS - FCP" 
        <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: hspi: Convert bindings to json-schema
Message-ID: <20190916075454.ab7cg5icp72sa6qx@verge.net.au>
References: <20190913122151.20264-1-horms+renesas@verge.net.au>
 <CAL_JsqKEym4i74AuTFvawBaB0_zBeh5KcBOY_OFheUV1oF4yEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqKEym4i74AuTFvawBaB0_zBeh5KcBOY_OFheUV1oF4yEg@mail.gmail.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Sep 13, 2019 at 03:22:10PM -0500, Rob Herring wrote:
> On Fri, Sep 13, 2019 at 7:22 AM Simon Horman <horms+renesas@verge.net.au> wrote:
> >
> > Convert Renesas HSPI bindings documentation to json-schema.
> > Also name bindings documentation file according to the compat string
> > being documented.
> >
> > As a side effect of this change all currently supported/used compat
> > strings are listed while no while card compat string is documented.
> > This, in my opinion, is desirable as only supported hardware should
> > be documented.
> >
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Hi Rob,

thanks for your review. I have sent v2 which I believe addresses
the issues you have raised.

> > ---
> > Based on v5.3-rc1
> > Tested using:
> >   make dtbs_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/spi/renesas,hspi.yaml
> > ---
> >  .../devicetree/bindings/spi/renesas,hspi.yaml      | 54 ++++++++++++++++++++++
> >  Documentation/devicetree/bindings/spi/sh-hspi.txt  | 26 -----------
> >  2 files changed, 54 insertions(+), 26 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/spi/renesas,hspi.yaml
> >  delete mode 100644 Documentation/devicetree/bindings/spi/sh-hspi.txt
> >
> > diff --git a/Documentation/devicetree/bindings/spi/renesas,hspi.yaml b/Documentation/devicetree/bindings/spi/renesas,hspi.yaml
> > new file mode 100644
> > index 000000000000..94a64a33daf4
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/spi/renesas,hspi.yaml
> > @@ -0,0 +1,54 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/spi/renesas,hspi.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Renesas HSPI
> > +
> > +maintainers:
> > +  - Geert Uytterhoeven <geert+renesas@glider.be>
> 
> Add:
> 
> allOf:
>   - $ref: spi-controller.yaml#
> 
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - enum:
> > +        - renesas,hspi-r8a7778 # R-Car M1A
> > +        - renesas,hspi-r8a7779 # R-Car H1
> > +      - const: renesas,hspi
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> 
> > +  '#address-cells':
> > +    const: 1
> > +
> > +  '#size-cells':
> > +    const: 0
> 
> And then these 2 can be dropped.
> 
> > +
> > +  # Pinctrl properties might be needed, too.
> > +  # See Documentation/devicetree/bindings/pinctrl/renesas,*.
> 
> If only a single state, you don't. For multiple states, we need to
> document the names.
> 
> If not present, then they get added automagically so that
> 'additionalProperties: false' works. But you can't use that here as
> you'll have child nodes.
> 
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - '#address-cells'
> > +  - '#size-cells'
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +
> > +    hspi0: spi@fffc7000 {
> > +        compatible = "renesas,hspi-r8a7778", "renesas,hspi";
> > +        reg = <0xfffc7000 0x18>;
> > +        interrupt-parent = <&gic>;
> > +        interrupts = <0 63 IRQ_TYPE_LEVEL_HIGH>;
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +    };
> > +
> 
