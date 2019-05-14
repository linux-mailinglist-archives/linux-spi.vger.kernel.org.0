Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6501C0B2
	for <lists+linux-spi@lfdr.de>; Tue, 14 May 2019 04:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbfENCdk (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 13 May 2019 22:33:40 -0400
Received: from twhmllg3.macronix.com ([211.75.127.131]:22985 "EHLO
        TWHMLLG3.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbfENCdk (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 13 May 2019 22:33:40 -0400
Received: from twhfmlp1.macronix.com (twhfm1p1.macronix.com [172.17.20.91])
        by TWHMLLG3.macronix.com with ESMTP id x4E2XAxF017497;
        Tue, 14 May 2019 10:33:10 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
Received: from MXML06C.mxic.com.tw (mxml06c.mxic.com.tw [172.17.14.55])
        by Forcepoint Email with ESMTP id 8D513CCBE407EB61FA46;
        Tue, 14 May 2019 10:33:10 +0800 (CST)
In-Reply-To: <CAMuHMdWsZPevpYg0HfbgaXPD89RFdOOEPawvvZDt3Kp4=PeLRQ@mail.gmail.com>
References: <1556092536-17095-1-git-send-email-masonccyang@mxic.com.tw> <1556092536-17095-4-git-send-email-masonccyang@mxic.com.tw> <20190424212356.GA27103@bogus> <65853dc2-6f3c-1494-7e72-54877797cdd2@gmail.com> <20190507125730.GD29524@dell> <OF08A5650B.8AE8977C-ON482583F4.000E5B1E-482583F4.000F7215@mxic.com.tw> <d229b19e-351c-c576-b5c4-716d10dad1a0@gmail.com> <20190508061119.GB7627@dell> <OFE86674B9.06D723A0-ON482583F5.000AD50C-482583F5.000BA075@mxic.com.tw> <a05cff8f-7df2-1938-c0e7-f9366bece607@cogentembedded.com> <OFB19BCE91.6EBBAA77-ON482583F6.000234E2-482583F6.00061290@mxic.com.tw> <CAMuHMdUP8KU3Dbv6cwOvrY0hWOcm1xqVcsi20+GvazYMDLGGZg@mail.gmail.com> <OFD932ABFC.E3FFCEB8-ON482583F9.003412B1-482583F9.0034D5CA@mxic.com.tw> <CAMuHMdWsZPevpYg0HfbgaXPD89RFdOOEPawvvZDt3Kp4=PeLRQ@mail.gmail.com>
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
        "Rob Herring" <robh@kernel.org>,
        "Sergei Shtylyov" <sergei.shtylyov@cogentembedded.com>,
        zhengxunli@mxic.com.tw
Subject: Re: [PATCH v12 3/3] dt-bindings: mfd: Document Renesas R-Car Gen3 RPC-IF
 MFD bindings
MIME-Version: 1.0
X-KeepSent: D347E742:50D5CB45-482583FA:000D5FC2;
 type=4; name=$KeepSent
X-Mailer: Lotus Notes Release 8.5.3FP4 SHF90 June 10, 2013
Message-ID: <OFD347E742.50D5CB45-ON482583FA.000D5FC2-482583FA.000E05BB@mxic.com.tw>
From:   masonccyang@mxic.com.tw
Date:   Tue, 14 May 2019 10:33:10 +0800
X-MIMETrack: Serialize by Router on MXML06C/TAIWAN/MXIC(Release 9.0.1FP10 HF265|July 25, 2018) at
 2019/05/14 AM 10:33:10,
        Serialize complete at 2019/05/14 AM 10:33:10
Content-Type: text/plain; charset="US-ASCII"
X-MAIL: TWHMLLG3.macronix.com x4E2XAxF017497
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


Hi Geert,

> Subject
> 
> Re: [PATCH v12 3/3] dt-bindings: mfd: Document Renesas R-Car Gen3 RPC-IF 
MFD bindings
> 
> Hi Mason,
> 
> Note that if you send multipart/text+html emails, they will be dropped 
silently
> by most Linux mailing lists.
> Hence I'm quoting your last email fully, to give other people a chance
> reading it (and commenting).

Thanks for your remind !
I have configured my Lotus Notes to plain text mode only and it should be 
OK
for Linux mailing lists now.

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

