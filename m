Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC6313DD93
	for <lists+linux-spi@lfdr.de>; Thu, 16 Jan 2020 15:38:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbgAPOiP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 16 Jan 2020 09:38:15 -0500
Received: from foss.arm.com ([217.140.110.172]:50308 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726084AbgAPOiO (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 16 Jan 2020 09:38:14 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DA8051396;
        Thu, 16 Jan 2020 06:38:13 -0800 (PST)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A113C3F718;
        Thu, 16 Jan 2020 06:38:12 -0800 (PST)
Date:   Thu, 16 Jan 2020 14:38:09 +0000
From:   Andre Przywara <andre.przywara@arm.com>
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Icenowy Zheng <icenowy@aosc.xyz>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 3/3] dt-bindings: spi: sunxi: Document new compatible
 strings
Message-ID: <20200116143809.123ceee4@donnerap.cambridge.arm.com>
In-Reply-To: <20200116142301.w2t4o6pg3dapp3g6@gilmour.lan>
References: <20200116005654.27672-1-andre.przywara@arm.com>
        <20200116005654.27672-4-andre.przywara@arm.com>
        <20200116142301.w2t4o6pg3dapp3g6@gilmour.lan>
Organization: ARM
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 16 Jan 2020 15:23:01 +0100
Maxime Ripard <mripard@kernel.org> wrote:

Hi,

> On Thu, Jan 16, 2020 at 12:56:54AM +0000, Andre Przywara wrote:
> > The Allwinner H6 SPI controller has advanced features over the H3
> > version, but remains compatible with it.
> > Document the usual "specific", "fallback" compatible string pair.
> > Also add the R40 version while at it.
> >
> > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> > ---
> >  .../devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml     | 12 +++++++++---
> >  1 file changed, 9 insertions(+), 3 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml b/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml
> > index f36c46d236d7..c19dfbe42d90 100644
> > --- a/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml
> > +++ b/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml
> > @@ -18,9 +18,15 @@ properties:
> >    "#size-cells": true
> >
> >    compatible:
> > -    enum:
> > -      - allwinner,sun6i-a31-spi
> > -      - allwinner,sun8i-h3-spi
> > +    oneOf:
> > +      - const: allwinner,sun6i-a31-spi
> > +      - const: allwinner,sun8i-h3-spi
> > +      - items:
> > +          - const: allwinner,sun8i-r40-spi
> > +          - const: allwinner,sun8i-h3-spi
> > +      - items:
> > +          - const: allwinner,sun50i-h6-spi
> > +          - const: allwinner,sun8i-h3-spi  
> 
> Having
> 
> oneOf:
>   - const: allwinner,sun6i-a31-spi
>   - const: allwinner,sun8i-h3-spi
>   - items:
>     - enum:
>       - allwinner,sun8i-r40-spi
>       - allwinner,sun50i-h6-spi
>     - const: allwinner,sun8i-h3-spi
> 
> Will be easier to maintain in the long run

Ah, nice, I tried something like this, based on the example-schema.yaml file, but the example in there is more verbose, and looked much less readable.
But your version seems to hit the sweet spot, so I will go with this.

Thanks,
Andre.
