Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9003481CE
	for <lists+linux-spi@lfdr.de>; Wed, 24 Mar 2021 20:21:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237903AbhCXTVD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 24 Mar 2021 15:21:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:35470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237842AbhCXTUr (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 24 Mar 2021 15:20:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C515B61A1F;
        Wed, 24 Mar 2021 19:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616613647;
        bh=IpRtc2I/K4He/YjHYwXXay+QOQvkt5PH7UrC2G/o+jA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=i/leH4Pov29oe6LP85rCVABrlLzQ+kzpWYkNa05TWNJRUjY8Zl33+RkiTz+5U4+9r
         SkAvr7L5Bk7P3OYeeTPVE24QD2VjBDEN+hgMt0LTUb1DvAhfX2mmjStJktp55L9j/1
         tJKbXYK6Kg8Wb6g6FaLN/us1Wui38jZV0r4sZ5vsuTiXYliR399M4/cfPIlIPNXDPX
         012ZiuZpBTd7gPYuqbjcEA7qsiUwLWSydO2bEW3UQnJp9BrOJYNfS76MwKVAstsCFL
         eDJBgHQBtvtnK5+XK1cEbi6CRKssyKb0j79M8JaK468BY1q+guPkp8+MDQH1qvwWSJ
         6Ieb/K6KTa8Rw==
Received: by mail-ej1-f47.google.com with SMTP id w3so34761318ejc.4;
        Wed, 24 Mar 2021 12:20:46 -0700 (PDT)
X-Gm-Message-State: AOAM5306k56u3JaQoYagC98sUWJMbU8Q7ezxxrdT0C6jwPAjwaVUS1Rj
        MbHWzdYEepJjcx1kY5p1o5gxbT5gKLJHB9CIqA==
X-Google-Smtp-Source: ABdhPJxRpUAXAPclCozJuEZW6ZDhmVnl579S7JzZGmBMNcIx8KrBX3Az00WnWhanL/Km6X+rA/5qkEEd6k9jb0atkVU=
X-Received: by 2002:a17:906:5e01:: with SMTP id n1mr5450325eju.359.1616613645234;
 Wed, 24 Mar 2021 12:20:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210315121518.3710171-1-kuldeep.singh@nxp.com>
 <20210315205440.lb6hcrvzxtqxdb5x@skbuf> <DB6PR0402MB27580AF77ED738B995616EB5E06B9@DB6PR0402MB2758.eurprd04.prod.outlook.com>
 <20210316101506.rkqcxkw6slv4vuhr@skbuf> <20210324181403.GC3320002@robh.at.kernel.org>
 <20210324185302.dxi2wurf7lgr5yxi@skbuf>
In-Reply-To: <20210324185302.dxi2wurf7lgr5yxi@skbuf>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 24 Mar 2021 13:20:33 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+8xXcLr8sLk+gj9y+FOi9kiEtRHTxDUV+yxm9CXS+jbQ@mail.gmail.com>
Message-ID: <CAL_Jsq+8xXcLr8sLk+gj9y+FOi9kiEtRHTxDUV+yxm9CXS+jbQ@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH] dt-bindings: spi: Convert Freescale DSPI to
 json schema
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     Kuldeep Singh <kuldeep.singh@nxp.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Mar 24, 2021 at 12:53 PM Vladimir Oltean <olteanv@gmail.com> wrote:
>
> On Wed, Mar 24, 2021 at 12:14:03PM -0600, Rob Herring wrote:
> > On Tue, Mar 16, 2021 at 12:15:06PM +0200, Vladimir Oltean wrote:
> > > On Tue, Mar 16, 2021 at 06:08:17AM +0000, Kuldeep Singh wrote:
> > > > Compatible entries in conjugation require enum and const pair.
> > > > For example, ls1012a.dtsi uses compatible = "fsl,ls1012a-dspi","fsl,ls1021a-v1.0-dspi";
> > > > Same goes for LS1028 as well.
> > > >
> > > > Therefore, can't mention the compatible entry as single entity otherwise
> > > > it may fail "make dt_binding_check" and "make dtbs_check".
> > > >
> > > > >
> > > > > > +examples:
> > > > > > +  - |
> > > > > > +    #include <dt-bindings/clock/fsl,qoriq-clockgen.h>
> > > > > > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > > > > > +
> > > > > > +    soc {
> > > > > > +        #address-cells = <2>;
> > > > > > +        #size-cells = <2>;
> > > > > > +
> > > > > > +        spi@2100000 {
> > > > > > +            compatible = "fsl,ls1028a-dspi", "fsl,ls1021a-v1.0-dspi";
> > > > >
> > > > > This doesn't need the "fsl,ls1021a-v1.0-dspi" compatible, can you please remove
> > > > > it?
> > > >
> > > > I have taken this example from LS1028a.dtsi and it uses these compatibles in conjugation.
> > > > If "fsl,ls1021a-v1.0-dspi" is not required, then it should also be removed from device-tree
> > > > As well as from bindings both.
> > >
> > > Yes, the second compatible is never required by the driver and should be
> > > removed from existing device trees if that makes "make dtbs_check" fail.
> >
> > Can you say that is true for every possible driver implementation?
> > u-boot, *BSD, etc.?
>
> I don't think other systems are required to follow Linux conventions, so
> I'm not sure why it matters.

Not required, but other projects do in fact use both bindings and dts
files. Bindings and dts files are stored in the kernel tree for
convenience as that's where the most activity is, but they are not
"Linux bindings" or "Linux DT" files.

In addition, "fsl,ls1088a-dspi" is not known by the Linux driver, so a
fallback is needed.

Rob
