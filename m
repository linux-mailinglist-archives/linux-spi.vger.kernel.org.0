Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 648406D923
	for <lists+linux-spi@lfdr.de>; Fri, 19 Jul 2019 04:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbfGSCjk (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 18 Jul 2019 22:39:40 -0400
Received: from twhmllg4.macronix.com ([211.75.127.132]:52150 "EHLO
        TWHMLLG4.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbfGSCjj (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 18 Jul 2019 22:39:39 -0400
Received: from twhfmnt1.mxic.com.tw (twhfm1p2.macronix.com [172.17.20.92])
        by TWHMLLG4.macronix.com with ESMTP id x6J2cuaQ072409;
        Fri, 19 Jul 2019 10:38:56 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
Received: from MXML06C.mxic.com.tw (mxml06c.macronix.com [172.17.14.55])
        by Forcepoint Email with ESMTP id B17D5E65125DE4DC5AE3;
        Fri, 19 Jul 2019 10:38:56 +0800 (CST)
In-Reply-To: <CAMuHMdUPmj0tAhJ18DhQEbYxP7g4MMBMe0U_2eQFQ7mOq4ZFLQ@mail.gmail.com>
References: <1561023046-20886-1-git-send-email-masonccyang@mxic.com.tw> <1561023046-20886-3-git-send-email-masonccyang@mxic.com.tw> <CAMuHMdUPmj0tAhJ18DhQEbYxP7g4MMBMe0U_2eQFQ7mOq4ZFLQ@mail.gmail.com>
To:     "Geert Uytterhoeven" <geert@linux-m68k.org>
Cc:     "Boris Brezillon" <bbrezillon@kernel.org>,
        "Mark Brown" <broonie@kernel.org>,
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
Subject: Re: [PATCH v14 2/2] dt-bindings: spi: Document Renesas R-Car Gen3 RPC-IF
 controller bindings
MIME-Version: 1.0
X-KeepSent: 43DF9AAE:9EB63E41-4825843C:000C61B7;
 type=4; name=$KeepSent
X-Mailer: Lotus Notes Release 8.5.3FP4 SHF90 June 10, 2013
Message-ID: <OF43DF9AAE.9EB63E41-ON4825843C.000C61B7-4825843C.000E8D45@mxic.com.tw>
From:   masonccyang@mxic.com.tw
Date:   Fri, 19 Jul 2019 10:38:56 +0800
X-MIMETrack: Serialize by Router on MXML06C/TAIWAN/MXIC(Release 9.0.1FP10 HF265|July 25, 2018) at
 2019/07/19 AM 10:38:56,
        Serialize complete at 2019/07/19 AM 10:38:56
Content-Type: text/plain; charset="US-ASCII"
X-MAIL: TWHMLLG4.macronix.com x6J2cuaQ072409
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


Hi Geert, 
 
Thanks for your review!

Will fix it as 

+Renesas R-Car Gen3 RPC-IF controller Device Tree Bindings
+---------------------------------------------------------
+
+Required properties:
+- compatible: should be an SoC-specific compatible value, followed by
+                                "renesas,rcar-gen3-rpc" as a fallback.
+                                supported SoC-specific values are:
+                                "renesas,r8a77980-rpc"          (R-Car 
V3H)
+                                "renesas,r8a77995-rpc"          (R-Car 
D3)
+- reg: should contain three register areas:
+       first for the base address of RPC-IF registers,
+       second for the direct mapping read mode and
+       third for the write buffer area.
+- reg-names: should contain "regs", "dirmap" and "wbuf"
+- clocks: should contain the clock phandle/specifier pair for the module 
clock.
+- clock-names: should contain "rpc"
+- power-domains: should contain the power domain phandle/secifier pair.
+- resets: should contain the reset controller phandle/specifier pair.
+- #address-cells: should be 1
+- #size-cells: should be 0
+
+  flash: should be represented by a subnode of the RPC-IF node, 
+  which "compatible" property contains "jedec,spi-nor", it presents SPI 
is used.
+
+Example:
+
+                rpc: spi@ee200000 {
+                                compatible = "renesas,r8a77995-rpc", 
"renesas,rcar-gen3-rpc";
+                                reg = <0 0xee200000 0 0x200>, <0 
0x08000000 0 0x4000000>,
+                                      <0 0xee208000 0 0x100>;
+                                reg-names = "regs", "dirmap", "wbuf";
+                                clocks = <&cpg CPG_MOD 917>;
+                                clock-names = "rpc";
+                                power-domains = <&sysc 
R8A77995_PD_ALWAYS_ON>;
+                                resets = <&cpg 917>;
+                                #address-cells = <1>;
+                                #size-cells = <0>;
+
+                                flash@0 {
+                                                compatible = 
"jedec,spi-nor";
+                                                reg = <0>;
+                                                spi-max-frequency = 
<40000000>;
+                                                spi-tx-bus-width = <1>;
+                                                spi-rx-bus-width = <1>;
+                                };
+                };

Is it OK ?

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

