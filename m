Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BCAE36D7C
	for <lists+linux-spi@lfdr.de>; Thu,  6 Jun 2019 09:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbfFFHl3 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 6 Jun 2019 03:41:29 -0400
Received: from twhmllg4.macronix.com ([122.147.135.202]:32594 "EHLO
        TWHMLLG4.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbfFFHl3 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 6 Jun 2019 03:41:29 -0400
Received: from twhfmnt1.mxic.com.tw (twhfm1p2.macronix.com [172.17.20.92])
        by TWHMLLG4.macronix.com with ESMTP id x567ejnl029719;
        Thu, 6 Jun 2019 15:40:45 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
Received: from MXML06C.mxic.com.tw (mxml06c.macronix.com [172.17.14.55])
        by Forcepoint Email with ESMTP id F26E03F4C1666F37E5FA;
        Thu,  6 Jun 2019 15:40:45 +0800 (CST)
In-Reply-To: <02addf64-9f6e-ccc1-2f94-8983456e3ebc@cogentembedded.com>
References: <1558423174-10748-1-git-send-email-masonccyang@mxic.com.tw> <1558423174-10748-4-git-send-email-masonccyang@mxic.com.tw> <0e2994d6-6efc-9f36-f681-609199f20b9f@cogentembedded.com> <20190603130428.GX4797@dell> <02addf64-9f6e-ccc1-2f94-8983456e3ebc@cogentembedded.com>
To:     "Lee Jones" <lee.jones@linaro.org>
Cc:     bbrezillon@kernel.org, broonie@kernel.org,
        devicetree@vger.kernel.org,
        "Geert Uytterhoeven" <geert+renesas@glider.be>,
        "Simon Horman" <horms@verge.net.au>, juliensu@mxic.com.tw,
        "Lee Jones" <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-spi@vger.kernel.org,
        marek.vasut@gmail.com, mark.rutland@arm.com,
        miquel.raynal@bootlin.com, robh+dt@kernel.org,
        "Sergei Shtylyov" <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v13 3/3] dt-bindings: mfd: Document Renesas R-Car Gen3 RPC-IF
 controller bindings
MIME-Version: 1.0
X-KeepSent: DA7648A0:F1733EA5-48258411:002946DF;
 type=4; name=$KeepSent
X-Mailer: Lotus Notes Release 8.5.3FP4 SHF90 June 10, 2013
Message-ID: <OFDA7648A0.F1733EA5-ON48258411.002946DF-48258411.002A2F0D@mxic.com.tw>
From:   masonccyang@mxic.com.tw
Date:   Thu, 6 Jun 2019 15:40:45 +0800
X-MIMETrack: Serialize by Router on MXML06C/TAIWAN/MXIC(Release 9.0.1FP10 HF265|July 25, 2018) at
 2019/06/06 PM 03:40:45,
        Serialize complete at 2019/06/06 PM 03:40:45
Content-Type: text/plain; charset="US-ASCII"
X-MAIL: TWHMLLG4.macronix.com x567ejnl029719
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


Hi Jones,


> Subject
> 
> Re: [PATCH v13 3/3] dt-bindings: mfd: Document Renesas R-Car Gen3 RPC-IF 

> controller bindings
> 
> Hello!
> 
> On 06/03/2019 04:04 PM, Lee Jones wrote:
> 
> >>> Document the bindings used by the Renesas R-Car Gen3 RPC-IF 
controller.
> >>>
> >>> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> >>> ---
> >>>  .../devicetree/bindings/mfd/renesas-rpc-if.txt     | 65 
++++++++++++++++++++++
> >>>  1 file changed, 65 insertions(+)
> >>>  create mode 100644 
Documentation/devicetree/bindings/mfd/renesas-rpc-if.txt
> >>>
> >>> diff --git 
a/Documentation/devicetree/bindings/mfd/renesas-rpc-if.txt b/
> Documentation/devicetree/bindings/mfd/renesas-rpc-if.txt
> >>> new file mode 100644
> >>> index 0000000..20ec85b
> >>> --- /dev/null
> >>> +++ b/Documentation/devicetree/bindings/mfd/renesas-rpc-if.txt
> >>> @@ -0,0 +1,65 @@
> >>> +Renesas R-Car Gen3 RPC-IF controller Device Tree Bindings
> >>> +---------------------------------------------------------
> >>> +
> >>> +RPC-IF supports both SPI NOR and HyperFlash (CFI-compliant flash)
> >>> +
> >>> +Required properties:
> >>> +- compatible: should be an SoC-specific compatible value, followed 
by
> >>> +      "renesas,rcar-gen3-rpc" as a fallback.
> >>> +      supported SoC-specific values are:
> >>> +      "renesas,r8a77995-rpc"   (R-Car D3)
> >>> +- reg: should contain three register areas:
> >>> +   first for RPC-IF registers,
> >>> +   second for the direct mapping read mode and
> >>> +   third for the write buffer area.
> >>> +- reg-names: should contain "regs", "dirmap" and "wbuf"
> >>> +- clocks: should contain 1 entries for the module's clock
> >>> +- clock-names: should contain "rpc"
> >>> +- power-domains: should contain system-controller(sysc) for 
power-domain-cell
> >>> +- resets: should contain clock pulse generator(cpg) for reset-cell,
> >>> +     power-domain-cell and clock-cell
> >>
> >>    That's just some nonsense, sorry...
> >>    I suggest that you stop reposting your patches as I'm going to 
post
> >> my version of this patchset RSN (based on your patches, of course) 
and I'm
> >> going to take care of fixing this file as well.
> > 
> > Why is this necessary?
> 
>    Because Mason doesn't want to develop the HyperFlash driver (or even 
move his code
> in preparation to this driver being developed). I must develop this 
driver, and I'd
> like to avoid the extra churn of mving the code between the MFD and SPI 
drivers.
> 

There might be some misunderstandings.

I had been requested to boot R-CAR from the OctaFlash and finally I have 
achieved it 
by patching SPI framework for OctaFlash operation and RPC-IF SPI driver. 

We were aware of the lacking support of RPC-IF in the Linux kernel at that 
time and 
I though I could contribute what I had developed.

At that time for my first submission of RPC-IF SPI on 15 NOv 2018, there 
was no any 
HyperFlash (or Hyper Bus) patches. And we did not consider it because the 
resource
of HyperFlash was shortage to us.

RPC-IF SPI was applied by Mark on 12,Feb 2019 but Marek comment to add 
supporting
MFD for RPC-IF and then I patched RPC-IF to MFD and SPI till this v13.

I always think about:

Is RPC-IF really good/suitable for MFD ?
RPC-IF works either in SPI or HyperFlash is decided by external hardware 
pins 
configuration and it can NOT switch it's operation mode in the run time. 
This is not like my understanding of MFD.

As your comments:
------------------------------------------------------------------------>
> +              flash = of_get_next_child(pdev->dev.of_node, NULL);
> +              if (!flash) {
> +                              dev_warn(&pdev->dev, "no flash node 
found\n");
> +                              return -ENODEV;
> +              }
> +
> +              if (of_device_is_compatible(flash, "jedec,spi-nor")) {
> +                              cell = &rpc_spi_ctlr;
> +              } else if (of_device_is_compatible(flash, "cfi-flash")) {
> +                              cell = &rpc_hf_ctlr;
> +              } else {
> +                              dev_warn(&pdev->dev, "unknown flash 
type\n");
> +                              return -ENODEV;
> +              }

Are there going to be more children coming?

If not, I'd argue that this is not an MFD.
<-------------------------------------------------------------------

I agreed with your opinion and I will resubmit RPC-IF in SPI only
if you also agree with it.


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

