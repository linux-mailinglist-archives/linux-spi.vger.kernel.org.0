Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC0327900
	for <lists+linux-spi@lfdr.de>; Thu, 23 May 2019 11:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbfEWJQ4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 23 May 2019 05:16:56 -0400
Received: from twhmllg4.macronix.com ([122.147.135.202]:52423 "EHLO
        TWHMLLG4.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbfEWJQ4 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 23 May 2019 05:16:56 -0400
Received: from twhfmnt1.mxic.com.tw (twhfm1p2.macronix.com [172.17.20.92])
        by TWHMLLG4.macronix.com with ESMTP id x4N9G2se058184;
        Thu, 23 May 2019 17:16:02 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
Received: from MXML06C.mxic.com.tw (mxml06c.macronix.com [172.17.14.55])
        by Forcepoint Email with ESMTP id 9068031A9482045BD690;
        Thu, 23 May 2019 17:16:02 +0800 (CST)
In-Reply-To: <0e2994d6-6efc-9f36-f681-609199f20b9f@cogentembedded.com>
References: <1558423174-10748-1-git-send-email-masonccyang@mxic.com.tw> <1558423174-10748-4-git-send-email-masonccyang@mxic.com.tw> <0e2994d6-6efc-9f36-f681-609199f20b9f@cogentembedded.com>
To:     "Sergei Shtylyov" <sergei.shtylyov@cogentembedded.com>
Cc:     bbrezillon@kernel.org, broonie@kernel.org,
        devicetree@vger.kernel.org,
        "Geert Uytterhoeven" <geert+renesas@glider.be>,
        "Simon Horman" <horms@verge.net.au>, juliensu@mxic.com.tw,
        lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-spi@vger.kernel.org,
        marek.vasut@gmail.com, mark.rutland@arm.com,
        miquel.raynal@bootlin.com, robh+dt@kernel.org
Subject: Re: [PATCH v13 3/3] dt-bindings: mfd: Document Renesas R-Car Gen3 RPC-IF
 controller bindings
MIME-Version: 1.0
X-KeepSent: B9416C97:8812436C-48258403:00329D12;
 type=4; name=$KeepSent
X-Mailer: Lotus Notes Release 8.5.3FP4 SHF90 June 10, 2013
Message-ID: <OFB9416C97.8812436C-ON48258403.00329D12-48258403.0032E82E@mxic.com.tw>
From:   masonccyang@mxic.com.tw
Date:   Thu, 23 May 2019 17:16:03 +0800
X-MIMETrack: Serialize by Router on MXML06C/TAIWAN/MXIC(Release 9.0.1FP10 HF265|July 25, 2018) at
 2019/05/23 PM 05:16:02,
        Serialize complete at 2019/05/23 PM 05:16:02
Content-Type: text/plain; charset="US-ASCII"
X-MAIL: TWHMLLG4.macronix.com x4N9G2se058184
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


Hi Sergei,

> On 05/21/2019 10:19 AM, Mason Yang wrote:
> 
> > Document the bindings used by the Renesas R-Car Gen3 RPC-IF 
controller.
> > 
> > Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> > ---
> >  .../devicetree/bindings/mfd/renesas-rpc-if.txt     | 65 
++++++++++++++++++++++
> >  1 file changed, 65 insertions(+)
> >  create mode 100644 
Documentation/devicetree/bindings/mfd/renesas-rpc-if.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/mfd/renesas-rpc-if.txt 
b/
> Documentation/devicetree/bindings/mfd/renesas-rpc-if.txt
> > new file mode 100644
> > index 0000000..20ec85b
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mfd/renesas-rpc-if.txt
> > @@ -0,0 +1,65 @@
> > +Renesas R-Car Gen3 RPC-IF controller Device Tree Bindings
> > +---------------------------------------------------------
> > +
> > +RPC-IF supports both SPI NOR and HyperFlash (CFI-compliant flash)
> > +
> > +Required properties:
> > +- compatible: should be an SoC-specific compatible value, followed by
> > +      "renesas,rcar-gen3-rpc" as a fallback.
> > +      supported SoC-specific values are:
> > +      "renesas,r8a77995-rpc"   (R-Car D3)
> > +- reg: should contain three register areas:
> > +   first for RPC-IF registers,
> > +   second for the direct mapping read mode and
> > +   third for the write buffer area.
> > +- reg-names: should contain "regs", "dirmap" and "wbuf"
> > +- clocks: should contain 1 entries for the module's clock
> > +- clock-names: should contain "rpc"
> > +- power-domains: should contain system-controller(sysc) for 
power-domain-cell
> > +- resets: should contain clock pulse generator(cpg) for reset-cell,
> > +     power-domain-cell and clock-cell
> 
>    That's just some nonsense, sorry...
>    I suggest that you stop reposting your patches as I'm going to post
> my version of this patchset RSN (based on your patches, of course) and 
I'm
> going to take care of fixing this file as well.

okay, just let me know your patch then.

thanks & best regards,
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

