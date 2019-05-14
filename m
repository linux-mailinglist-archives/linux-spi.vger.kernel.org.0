Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CBC11C684
	for <lists+linux-spi@lfdr.de>; Tue, 14 May 2019 12:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbfENKBP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 14 May 2019 06:01:15 -0400
Received: from twhmllg4.macronix.com ([211.75.127.132]:28157 "EHLO
        TWHMLLG4.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbfENKBP (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 14 May 2019 06:01:15 -0400
Received: from twhfmnt1.mxic.com.tw (twhfm1p2.macronix.com [172.17.20.92])
        by TWHMLLG4.macronix.com with ESMTP id x4EA0CRn014521;
        Tue, 14 May 2019 18:00:12 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
Received: from MXML06C.mxic.com.tw (mxml06c.macronix.com [172.17.14.55])
        by Forcepoint Email with ESMTP id 289945F35EA95B20A0AB;
        Tue, 14 May 2019 18:00:13 +0800 (CST)
In-Reply-To: <OFAD9AA573.86373900-ON482583FA.0034781A-482583FA.0035B40C@LocalDomain>
References: <1556092536-17095-1-git-send-email-masonccyang@mxic.com.tw> <20190424212356.GA27103@bogus> <65853dc2-6f3c-1494-7e72-54877797cdd2@gmail.com> <20190507125730.GD29524@dell> <OF08A5650B.8AE8977C-ON482583F4.000E5B1E-482583F4.000F7215@mxic.com.tw> <d229b19e-351c-c576-b5c4-716d10dad1a0@gmail.com> <20190508061119.GB7627@dell> <OFE86674B9.06D723A0-ON482583F5.000AD50C-482583F5.000BA075@mxic.com.tw> <a05cff8f-7df2-1938-c0e7-f9366bece607@cogentembedded.com> <OFB19BCE91.6EBBAA77-ON482583F6.000234E2-482583F6.00061290@mxic.com.tw> <CAMuHMdUP8KU3Dbv6cwOvrY0hWOcm1xqVcsi20+GvazYMDLGGZg@mail.gmail.com> <OFD932ABFC.E3FFCEB8-ON482583F9.003412B1-482583F9.0034D5CA@mxic.com.tw> <b51d1cb7-b3b5-208f-ab4c-145ecb57805d@cogentembedded.com> <OFAD9AA573.86373900-ON482583FA.0034781A-482583FA.0035B40C@LocalDomain>
To:     "Sergei Shtylyov" <sergei.shtylyov@cogentembedded.com>,
        "Geert Uytterhoeven" <geert@linux-m68k.org>,
        "Lee Jones" <lee.jones@linaro.org>
Cc:     "Boris Brezillon" <bbrezillon@kernel.org>,
        "Mark Brown" <broonie@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "Geert Uytterhoeven" <geert@linux-m68k.org>,
        "Geert Uytterhoeven" <geert+renesas@glider.be>,
        "Simon Horman" <horms@verge.net.au>, juliensu@mxic.com.tw,
        "Lee Jones" <lee.jones@linaro.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "Linux-Renesas" <linux-renesas-soc@vger.kernel.org>,
        "linux-spi" <linux-spi@vger.kernel.org>,
        "Marek Vasut" <marek.vasut@gmail.com>,
        "Mark Rutland" <mark.rutland@arm.com>,
        "Rob Herring" <robh@kernel.org>,
        "Sergei Shtylyov" <sergei.shtylyov@cogentembedded.com>,
        zhengxunli@mxic.com.tw
Subject: Re: [PATCH v12 3/3] dt-bindings: mfd: Document Renesas R-Car Gen3 RPC-IF
 MFD bindings
MIME-Version: 1.0
X-KeepSent: ADD61EE8:84C8DE88-482583FA:0036510D;
 type=4; name=$KeepSent
X-Mailer: Lotus Notes Release 8.5.3FP4 SHF90 June 10, 2013
Message-ID: <OFADD61EE8.84C8DE88-ON482583FA.0036510D-482583FA.0036F37A@mxic.com.tw>
From:   masonccyang@mxic.com.tw
Date:   Tue, 14 May 2019 18:00:13 +0800
X-MIMETrack: Serialize by Router on MXML06C/TAIWAN/MXIC(Release 9.0.1FP10 HF265|July 25, 2018) at
 2019/05/14 PM 06:00:13,
        Serialize complete at 2019/05/14 PM 06:00:13
Content-Type: text/plain; charset="US-ASCII"
X-MAIL: TWHMLLG4.macronix.com x4EA0CRn014521
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


Hi Sergei, 

> > 
> >    Could you please indent with 1 or 2 tabs where you used 8 or 16 
spaces?

Sorry, I just copy this new DTS from git to my Notes email system,
therefore, the "tabs space" is not alignment with original file.

> 
> Patch new DTS to
> ===============================================================> 
> 
> +Renesas R-Car Gen3 RPC-IF controller Device Tree Bindings
> +---------------------------------------------------------
> +
> +RPC-IF supports both SPI NOR and HyperFlash (CFI-compliant flash)
> +
> +Required properties:
> +- compatible: should be an SoC-specific compatible value, followed by
> +      "renesas,rcar-gen3-rpc" as a fallback.
> +      supported SoC-specific values are:
> +      "renesas,r8a77995-rpc"   (R-Car D3)
> +- reg: should contain three register areas:
> +   first for RPC-IF registers,
> +   second for the direct mapping read mode and
> +   third for the write buffer area.
> +- reg-names: should contain "regs", "dirmap" and "wbuf"
> +- clocks: should contain 1 entries for the module's clock
> +- clock-names: should contain "rpc"
> +- #address-cells: should be 1
> +- #size-cells: should be 0
> +
> +Example:
> +- SPI mode:
> +
> +   rpc_if: spi@ee200000 {
> +      compatible = "renesas,r8a77995-rpc", "renesas,rcar-gen3-rpc";
> +      reg = <0 0xee200000 0 0x200>, <0 0x08000000 0 0x4000000>,
> +            <0 0xee208000 0 0x100>;
> +      reg-names = "regs", "dirmap", "wbuf";
> +      clocks = <&cpg CPG_MOD 917>;
> +      clock-names = "rpc";
> +      power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
> +      resets = <&cpg 917>;
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      flash@0 {
> +         compatible = "jedec,spi-nor";
> +         reg = <0>;
> +         spi-max-frequency = <40000000>;
> +         spi-tx-bus-width = <1>;
> +         spi-rx-bus-width = <1>;
> +      };
> +   };
> +
> +- HF mode:
> +   rpc_if: hf@ee200000 {
> +      compatible = "renesas,r8a77995-rpc", "renesas,rcar-gen3-rpc";
> +      reg = <0 0xee200000 0 0x200>, <0 0x08000000 0 0x4000000>,
> +            <0 0xee208000 0 0x100>;
> +      reg-names = "regs", "dirmap", "wbuf";
> +      clocks = <&cpg CPG_MOD 917>;
> +      clock-names = "rpc";
> +      power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
> +      resets = <&cpg 917>;
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      flash@0 {
> +         compatible = "cypress,hyperflash", "cfi-flash";
> +         reg = <0>;
> +      };
> +   };
> 
> =======================================================================<

thanks for your review.

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

