Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C01A430DAB
	for <lists+linux-spi@lfdr.de>; Mon, 18 Oct 2021 03:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238617AbhJRBpn (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 17 Oct 2021 21:45:43 -0400
Received: from twhmllg3.macronix.com ([211.75.127.131]:11089 "EHLO
        TWHMLLG3.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235368AbhJRBpn (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 17 Oct 2021 21:45:43 -0400
Received: from twhfmlp1.macronix.com (twhfmlp1.macronix.com [172.17.20.91])
        by TWHMLLG3.macronix.com with ESMTP id 19I1gdGm015281;
        Mon, 18 Oct 2021 09:42:39 +0800 (GMT-8)
        (envelope-from jaimeliao@mxic.com.tw)
Received: from MXML06C.mxic.com.tw (mxml06c.mxic.com.tw [172.17.14.55])
        by Forcepoint Email with ESMTP id D550E851C17E8086009A;
        Mon, 18 Oct 2021 09:42:39 +0800 (CST)
In-Reply-To: <YWC8jgI74FgTudSD@robh.at.kernel.org>
References: <20211008162228.1753083-1-miquel.raynal@bootlin.com> <20211008162228.1753083-4-miquel.raynal@bootlin.com> <YWC8jgI74FgTudSD@robh.at.kernel.org>
To:     "Rob Herring" <robh@kernel.org>
Cc:     "Boris Brezillon" <bbrezillon@kernel.org>,
        "Mark Brown" <broonie@kernel.org>, devicetree@vger.kernel.org,
        juliensu@mxic.com.tw, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        "Miquel Raynal" <miquel.raynal@bootlin.com>,
        "Richard Weinberger" <richard@nod.at>,
        "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>,
        "Tudor Ambarus" <Tudor.Ambarus@microchip.com>,
        "Vignesh Raghavendra" <vigneshr@ti.com>,
        "Xiangsheng Hou" <Xiangsheng.Hou@mediatek.com>
Subject: =?Big5?B?pl6rSDogUmU6IFtSRkMgUEFUQ0ggMDMvMTBdIGR0LWJpbmRpbmdzOiB2ZW5kb3It?=
 =?Big5?B?cHJlZml4ZXM6IFVwZGF0ZSBNYWNyb25peCBwcmVmaXg=?=
MIME-Version: 1.0
X-KeepSent: 9A15BF2B:E4A73AE9-48258772:00093984;
 type=4; name=$KeepSent
X-Mailer: Lotus Notes Release 8.5.3FP6 SHF907 April 26, 2018
Message-ID: <OF9A15BF2B.E4A73AE9-ON48258772.00093984-48258772.00096628@mxic.com.tw>
From:   jaimeliao@mxic.com.tw
Date:   Mon, 18 Oct 2021 09:42:39 +0800
X-MIMETrack: Serialize by Router on MXML06C/TAIWAN/MXIC(Release 9.0.1FP10 HF265|July 25, 2018) at
 2021/10/18 AM 09:42:39,
        Serialize complete at 2021/10/18 AM 09:42:39
Content-Type: text/plain; charset="US-ASCII"
X-MAIL: TWHMLLG3.macronix.com 19I1gdGm015281
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


Hi Rob

> 
> Re: [RFC PATCH 03/10] dt-bindings: vendor-prefixes: Update Macronix 
prefix
> 
> On Fri, Oct 08, 2021 at 06:22:21PM +0200, Miquel Raynal wrote:
> > When looking at compatible prefixes, Macronix is sometimes referred as
> > mxicy:
> > - mxicy,mx25r1635f
> > - mxicy,mx25u6435f
> > - mxicy,mx25v8035f
> > - mxicy,mx25f0a-spi
> > and sometimes as mxic:
> > - mxic,multi-itfc-v009-nand-controller
> > - mxic,enable-randomizer-otp
> > 
> > It looks like the more up-to-date way is mxic so declare this prefix 
and
> > mark the other one as deprecated.
> 
> mxicy is more widely used with flash parts. There's not a single dts 
> file with 'mxic' which only seems to be some nand controller.
Yes, you are right.

Hi Miquel

Please keep using "mxicy,*" consistently for the compatible property, 
thanks.

> 
> > 
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > ---
> >  Documentation/devicetree/bindings/vendor-prefixes.yaml | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/vendor-
> prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> > index b868cefc7c55..013a87850cd5 100644
> > --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> > +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> > @@ -758,8 +758,11 @@ patternProperties:
> >      description: Mundo Reader S.L.
> >    "^murata,.*":
> >      description: Murata Manufacturing Co., Ltd.
> > +  "^mxic,.*":
> > +    description: Macronix International Co., Ltd.
> >    "^mxicy,.*":
> >      description: Macronix International Co., Ltd.
> > +    deprecated: true
> >    "^myir,.*":
> >      description: MYIR Tech Limited
> >    "^national,.*":
> > -- 
> > 2.27.0
> > 
> > 


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

