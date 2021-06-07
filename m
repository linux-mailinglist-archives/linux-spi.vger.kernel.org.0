Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE5E39D839
	for <lists+linux-spi@lfdr.de>; Mon,  7 Jun 2021 11:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbhFGJGR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 7 Jun 2021 05:06:17 -0400
Received: from gloria.sntech.de ([185.11.138.130]:48620 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230173AbhFGJGR (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 7 Jun 2021 05:06:17 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1lqBBH-0000nU-KF; Mon, 07 Jun 2021 11:04:23 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Jon Lin <jon.lin@rock-chips.com>, broonie@kernel.org,
        Johan Jonker <jbx6244@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 1/6] dt-bindings: spi: spi-rockchip: add description for rv1126 and rk3568
Date:   Mon, 07 Jun 2021 11:04:21 +0200
Message-ID: <3681106.bcXerOTE6V@diego>
In-Reply-To: <ef90ae6d-40bb-8389-f4f8-536a7b610fb7@gmail.com>
References: <20210607063448.29589-1-jon.lin@rock-chips.com> <20210607063448.29589-2-jon.lin@rock-chips.com> <ef90ae6d-40bb-8389-f4f8-536a7b610fb7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Am Montag, 7. Juni 2021, 10:15:30 CEST schrieb Johan Jonker:
> Hi Jon,
> 
> On 6/7/21 8:34 AM, Jon Lin wrote:
> > The description below will be used for rv1126.dtsi or rk3568.dtsi in
> > the future
> > 
> > Signed-off-by: Jon Lin <jon.lin@rock-chips.com>
> > ---
> > 
> > Changes in v4:
> > - Adjust the order patches
> > - Simply commit massage like redundancy "application" content
> > 
> > Changes in v3:
> > - Fix compile error which is find by Sascha in [v2,2/8]
> > 
> >  Documentation/devicetree/bindings/spi/spi-rockchip.yaml | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/spi/spi-rockchip.yaml b/Documentation/devicetree/bindings/spi/spi-rockchip.yaml
> > index 1e6cf29e6388..2d7957f9ae0a 100644
> > --- a/Documentation/devicetree/bindings/spi/spi-rockchip.yaml
> > +++ b/Documentation/devicetree/bindings/spi/spi-rockchip.yaml
> > @@ -27,12 +27,14 @@ properties:
> >        - items:
> >            - enum:
> >                - rockchip,px30-spi
> 
> > +              - rockchip,rv1126-spi
> 
> This list is sort alphabetically.
> Move "rockchip,rv1126-spi" below "rockchip,rk3568-spi"
> 
> >                - rockchip,rk3188-spi
> >                - rockchip,rk3288-spi
> >                - rockchip,rk3308-spi
> >                - rockchip,rk3328-spi
> >                - rockchip,rk3368-spi
> >                - rockchip,rk3399-spi
> > +              - rockchip,rk3568-spi
> 
> 
> >            - const: rockchip,rk3066-spi
> >  
> >    reg:
> > 
> 
> ===
> 
> Your comment in [PATCH v3 3/8]:
> >> Adding "rockchip,rv1126-spi" to rockchip_spi_dt_match[] is strictly not
> >> needed when using "rockchip,rk3066-spi" as fall back string.
> >> Could a maintainer advise?
> >>
> >> Maybe this bug of mine should revert too?? Or is it legacy?
> >> spi: rockchip: add compatible string for px30 rk3308 rk3328
> >> https://lore.kernel.org/r/20200309151004.7780-1-jbx6244@gmail.com
> 
> > I agree with you. If the maintainer doesn't have any comments, I will use
> > "rockchip,spi" as compatible names for the subsequent rk platform.
> 
> Compatibility strings are supposed to be SoC orientated.
> So generic ones like in the manufacturer tree can't be used here.

Johan ist right :-) .

rockchip,spi won't work at all, especially as these controllers always change
over time. [0]

Best example is the iommu. We started with "rockchip,iommu" thinking this
won't change over time, but with the rk3568 we get a new slightly different
iommu.

The vendor-kernel then introduces somewhat random "-vX" additions to
distinguish them, but often they do seem to be very software-centric.

Meaning, hardware-designers moved stuff around and software-developers
then invented the versioning to differentiate between versions.

The devicetree is supposed to describe the hardware though, so going with
the relevant soc-specific compatible gives us the necessary hardware-centric
differentiation.

Also this allows to catch later issues with specific soc implementations ;-)
Like 6 monts down the road we discover some special behaviour on the
rk3568 and devicetree is supposed to be stable.

So having the relevant compatibles in place allows us to just add driver
fixes and have those apply on the rk3568 if that is need at some point.

Heiko



