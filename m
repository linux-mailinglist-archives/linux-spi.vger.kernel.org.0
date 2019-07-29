Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54FC47887E
	for <lists+linux-spi@lfdr.de>; Mon, 29 Jul 2019 11:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727979AbfG2JfF (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 29 Jul 2019 05:35:05 -0400
Received: from twhmllg3.macronix.com ([211.75.127.131]:25098 "EHLO
        TWHMLLG3.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbfG2JfF (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 29 Jul 2019 05:35:05 -0400
Received: from twhfmlp1.macronix.com (twhfm1p1.macronix.com [172.17.20.91])
        by TWHMLLG3.macronix.com with ESMTP id x6T9YN3b083443;
        Mon, 29 Jul 2019 17:34:23 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
Received: from MXML06C.mxic.com.tw (mxml06c.mxic.com.tw [172.17.14.55])
        by Forcepoint Email with ESMTP id 806C1D4D4A3E8D87A0E0;
        Mon, 29 Jul 2019 17:34:23 +0800 (CST)
In-Reply-To: <CAMuHMdWVuQa1LLXPqrdSw6wdRzwQapAkk6Est=XrjESPF9zQwg@mail.gmail.com>
References: <1564108975-27423-1-git-send-email-masonccyang@mxic.com.tw> <1564108975-27423-3-git-send-email-masonccyang@mxic.com.tw> <CAMuHMdWVuQa1LLXPqrdSw6wdRzwQapAkk6Est=XrjESPF9zQwg@mail.gmail.com>
To:     "Geert Uytterhoeven" <geert@linux-m68k.org>
Cc:     "Mark Brown" <broonie@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "Geert Uytterhoeven" <geert+renesas@glider.be>,
        "Simon Horman" <horms@verge.net.au>, juliensu@mxic.com.tw,
        "Lee Jones" <lee.jones@linaro.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "Linux-Renesas" <linux-renesas-soc@vger.kernel.org>,
        "linux-spi" <linux-spi@vger.kernel.org>,
        "Marek Vasut" <marek.vasut@gmail.com>,
        "Mark Rutland" <mark.rutland@arm.com>,
        "Miquel Raynal" <miquel.raynal@bootlin.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Sergei Shtylyov" <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v15 2/2] dt-bindings: spi: Document Renesas R-Car Gen3 RPC-IF
 controller bindings
MIME-Version: 1.0
X-KeepSent: FF9D8385:D8395BBD-48258446:0033FD62;
 type=4; name=$KeepSent
X-Mailer: Lotus Notes Release 8.5.3FP4 SHF90 June 10, 2013
Message-ID: <OFFF9D8385.D8395BBD-ON48258446.0033FD62-48258446.00349608@mxic.com.tw>
From:   masonccyang@mxic.com.tw
Date:   Mon, 29 Jul 2019 17:34:22 +0800
X-MIMETrack: Serialize by Router on MXML06C/TAIWAN/MXIC(Release 9.0.1FP10 HF265|July 25, 2018) at
 2019/07/29 PM 05:34:23,
        Serialize complete at 2019/07/29 PM 05:34:23
Content-Type: text/plain; charset="US-ASCII"
X-MAIL: TWHMLLG3.macronix.com x6T9YN3b083443
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


Hi Geert,

 
> On Fri, Jul 26, 2019 at 4:19 AM Mason Yang <masonccyang@mxic.com.tw> 
wrote:
> > Dcument the bindings used by the Renesas R-Car Gen3 RPC-IF controller.
> 
> Document

Oops, sorry !

> 
> >
> > Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> 
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt
> > @@ -0,0 +1,46 @@
> 
> [...]
> 
> > +- flash: should be represented by a subnode of the RPC-IF node,
> > +        which "compatible" property contains "jedec,spi-nor", it 
presents
> > +        SPI is used.
> 
> Sorry, I failed to parse the last subsentence.


Fix it to:
- flash: should be represented by a subnode of the RPC-IF node,
         its "compatible" property contains "jedec,spi-nor" presents
         SPI is used.

OK?

> 
> > +
> > +Example:
> > +
> > +       rpc: spi@ee200000 {
> > +               compatible = "renesas,r8a77995-rpc", 
"renesas,rcar-gen3-rpc";
> > +               reg = <0 0xee200000 0 0x200>, <0 0x08000000 0 
0x4000000>,
> > +                     <0 0xee208000 0 0x100>;
> > +               reg-names = "regs", "dirmap", "wbuf";
> > +               clocks = <&cpg CPG_MOD 917>;
> > +               clock-names = "rpc";
> > +               power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
> > +               resets = <&cpg 917>;
> > +               #address-cells = <1>;
> > +               #size-cells = <0>;
> > +
> > +               flash@0 {
> > +                       compatible = "jedec,spi-nor";
> > +                       reg = <0>;
> > +                       spi-max-frequency = <40000000>;
> > +                       spi-tx-bus-width = <1>;
> > +                       spi-rx-bus-width = <1>;
> 
> Shouldn't those <1> be <4>, as this is QSPI?

okay, fix them to <4>


thanks for your time & review.

best regards,
Mason


CONFIDENTIALITY NOTE:

This e-mail and any attachments may contain confidential information 
and/or personal data, which is protected by applicable laws. Please be 
reminded that duplication, disclosure, distribution, or use of this e-mail 
(and/or its attachments) or any part thereof is prohibited. If you receive 
this e-mail in error, please notify us immediately and delete this mail as 
well as its attachment(s) from your system. In addition, please be 
informed that collection, processing, and/or use of personal data is 
prohibited unless expressly permitted by personal data protection laws. 
Thank you for your attention and cooperation.

Macronix International Co., Ltd.

=====================================================================



============================================================================

CONFIDENTIALITY NOTE:

This e-mail and any attachments may contain confidential information and/or personal data, which is protected by applicable laws. Please be reminded that duplication, disclosure, distribution, or use of this e-mail (and/or its attachments) or any part thereof is prohibited. If you receive this e-mail in error, please notify us immediately and delete this mail as well as its attachment(s) from your system. In addition, please be informed that collection, processing, and/or use of personal data is prohibited unless expressly permitted by personal data protection laws. Thank you for your attention and cooperation.

Macronix International Co., Ltd.

=====================================================================

