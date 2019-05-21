Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31E412459C
	for <lists+linux-spi@lfdr.de>; Tue, 21 May 2019 03:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbfEUB3n (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 20 May 2019 21:29:43 -0400
Received: from twhmllg4.macronix.com ([211.75.127.132]:55746 "EHLO
        TWHMLLG4.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727043AbfEUB3n (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 20 May 2019 21:29:43 -0400
Received: from twhfmnt1.mxic.com.tw (twhfm1p2.macronix.com [172.17.20.92])
        by TWHMLLG4.macronix.com with ESMTP id x4L1SY4I018677;
        Tue, 21 May 2019 09:28:34 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
Received: from MXML06C.mxic.com.tw (mxml06c.macronix.com [172.17.14.55])
        by Forcepoint Email with ESMTP id BC4C22738DACF419C5FA;
        Tue, 21 May 2019 09:28:34 +0800 (CST)
In-Reply-To: <CAMuHMdU5a2qXVG52Creftp4wR_nnwB9xk=jFeiOWUO0vJSyV0w@mail.gmail.com>
References: <1556092536-17095-1-git-send-email-masonccyang@mxic.com.tw> <20190507125730.GD29524@dell> <OF08A5650B.8AE8977C-ON482583F4.000E5B1E-482583F4.000F7215@mxic.com.tw> <d229b19e-351c-c576-b5c4-716d10dad1a0@gmail.com> <20190508061119.GB7627@dell> <OFE86674B9.06D723A0-ON482583F5.000AD50C-482583F5.000BA075@mxic.com.tw> <a05cff8f-7df2-1938-c0e7-f9366bece607@cogentembedded.com> <OFB19BCE91.6EBBAA77-ON482583F6.000234E2-482583F6.00061290@mxic.com.tw> <CAMuHMdUP8KU3Dbv6cwOvrY0hWOcm1xqVcsi20+GvazYMDLGGZg@mail.gmail.com> <OFD932ABFC.E3FFCEB8-ON482583F9.003412B1-482583F9.0034D5CA@mxic.com.tw> <b51d1cb7-b3b5-208f-ab4c-145ecb57805d@cogentembedded.com> <44bc8f0a-cbdc-db4a-9a46-b8bae5cc37a2@cogentembedded.com> <OF5AF00898.3CE87C9
 <CAMuHMdU5a2qXVG52Creftp4wR_nnwB9xk=jFeiOWUO0vJSyV0w@mail.gmail.com>
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
        "Rob Herring" <robh@kernel.org>,
        "Sergei Shtylyov" <sergei.shtylyov@cogentembedded.com>,
        zhengxunli@mxic.com.tw
Subject: Re: [PATCH v12 3/3] dt-bindings: mfd: Document Renesas R-Car Gen3 RPC-IF
 MFD bindings
MIME-Version: 1.0
X-KeepSent: 6A21896F:72833899-48258401:0007B494;
 type=4; name=$KeepSent
X-Mailer: Lotus Notes Release 8.5.3FP4 SHF90 June 10, 2013
Message-ID: <OF6A21896F.72833899-ON48258401.0007B494-48258401.00081C05@mxic.com.tw>
From:   masonccyang@mxic.com.tw
Date:   Tue, 21 May 2019 09:28:35 +0800
X-MIMETrack: Serialize by Router on MXML06C/TAIWAN/MXIC(Release 9.0.1FP10 HF265|July 25, 2018) at
 2019/05/21 AM 09:28:34,
        Serialize complete at 2019/05/21 AM 09:28:34
Content-Type: text/plain; charset="US-ASCII"
X-MAIL: TWHMLLG4.macronix.com x4L1SY4I018677
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


Hi Geert,

> 
> On Mon, May 20, 2019 at 9:24 AM <masonccyang@mxic.com.tw> wrote:
> > > >>>   - clocks: should contain 1 entries for the module's clock
> > > >>>   - clock-names: should contain "rpc"
> > > >>
> > > >>    I suspect we'd need the RPC/RPCD2 clocks mentioned as well 
(not
> > sure
> > > > yet)...
> > > >
> > > > Need it ?
> > >
> > >    You seem to call clk_get_rate() on the module clock, I doubt 
that's
> > > correct topologically...
> >
> > I think it's correct but just like Geert mentioned that there is no 
any
> > patch
> > in drivers/clk/renesas/r8a77995-cpg-mssr.c adding RPC-related clocks.
> >
> >
> > I patched dt-bindings/clock/r8a77995-cpg-mssr.h for some simple 
testing
> >
> > -#define R8A77995_CLK_RPC               29
> > -#define R8A77995_CLK_RPCD2             30
> > +#define R8A77995_CLK_RPC               31
> > +#define R8A77995_CLK_RPCD2             32
> 
> That change doesn't make sense to me...
> 
> > by clk_prepare_enable() & clk_disable_unprepare() with CPG_MOD 917
> > on D3 draak board, it is working fine.
> 
> ... and is not sufficient to allow the above two calls.
> 
> Besides, making explicit clk_prepare_enable() calls bypasses Runtime PM
> and the automatic disabling of unused clocks, thus hiding bugs related 
to
> Runtime PM.  Which is probably why your driver doesn't work for 
Sergei...
> 

Got it, thanks for your explanation.

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

