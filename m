Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C518C4B32F
	for <lists+linux-spi@lfdr.de>; Wed, 19 Jun 2019 09:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731210AbfFSHg6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 19 Jun 2019 03:36:58 -0400
Received: from twhmllg3.macronix.com ([122.147.135.201]:54836 "EHLO
        TWHMLLG3.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbfFSHg5 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 19 Jun 2019 03:36:57 -0400
Received: from twhfmlp1.macronix.com (twhfm1p1.macronix.com [172.17.20.91])
        by TWHMLLG3.macronix.com with ESMTP id x5J7aIhW016432;
        Wed, 19 Jun 2019 15:36:18 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
Received: from MXML06C.mxic.com.tw (mxml06c.macronix.com [172.17.14.55])
        by Forcepoint Email with ESMTP id AEE003E5F394D6571948;
        Wed, 19 Jun 2019 15:36:18 +0800 (CST)
In-Reply-To: <2671d488-82a1-8720-d9a1-03554d955a38@gmail.com>
References: <1558423174-10748-1-git-send-email-masonccyang@mxic.com.tw> <1558423174-10748-4-git-send-email-masonccyang@mxic.com.tw> <0e2994d6-6efc-9f36-f681-609199f20b9f@cogentembedded.com> <20190603130428.GX4797@dell> <02addf64-9f6e-ccc1-2f94-8983456e3ebc@cogentembedded.com> <OFDA7648A0.F1733EA5-ON48258411.002946DF-48258411.002A2F0D@mxic.com.tw> <2671d488-82a1-8720-d9a1-03554d955a38@gmail.com>
To:     "Marek Vasut" <marek.vasut@gmail.com>
Cc:     bbrezillon@kernel.org, broonie@kernel.org,
        devicetree@vger.kernel.org,
        "Geert Uytterhoeven" <geert+renesas@glider.be>,
        "Simon Horman" <horms@verge.net.au>, juliensu@mxic.com.tw,
        "Lee Jones" <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-spi@vger.kernel.org,
        mark.rutland@arm.com, miquel.raynal@bootlin.com,
        robh+dt@kernel.org,
        "Sergei Shtylyov" <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v13 3/3] dt-bindings: mfd: Document Renesas R-Car Gen3 RPC-IF
 controller bindings
MIME-Version: 1.0
X-KeepSent: E8CD77A1:CDBE040B-4825841E:00288DA8;
 type=4; name=$KeepSent
X-Mailer: Lotus Notes Release 8.5.3FP4 SHF90 June 10, 2013
Message-ID: <OFE8CD77A1.CDBE040B-ON4825841E.00288DA8-4825841E.0029C76F@mxic.com.tw>
From:   masonccyang@mxic.com.tw
Date:   Wed, 19 Jun 2019 15:36:20 +0800
X-MIMETrack: Serialize by Router on MXML06C/TAIWAN/MXIC(Release 9.0.1FP10 HF265|July 25, 2018) at
 2019/06/19 PM 03:36:18,
        Serialize complete at 2019/06/19 PM 03:36:18
Content-Type: text/plain; charset="US-ASCII"
X-MAIL: TWHMLLG3.macronix.com x5J7aIhW016432
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


Hi Marek, 

> Subject
> 
> Re: [PATCH v13 3/3] dt-bindings: mfd: Document Renesas R-Car Gen3 RPC-IF 

> controller bindings
> 
> On 6/6/19 9:40 AM, masonccyang@mxic.com.tw wrote:
> [...]
> 
> > RPC-IF works either in SPI or HyperFlash is decided by external 
hardware 
> > pins 
> > configuration and it can NOT switch it's operation mode in the run 
time. 
> > This is not like my understanding of MFD.
> 
> Which external hardware pins decide the RPC configuration ?
> 
> It seems to me like PHYCNT register, PHYMEM bitfield, selects what
> device is connected, and then a couple of other bits control the
> communication, but I see nothing which would be tied to any external
> configuration pins.
> 

You may refer to R-Car D3 Draak Eva. board hardware manual 
and start-up guide, i.e., 
Table 2.12 Pin Multiplexing of R-Car D3 Mode setting pins and
set by hardware switch 1, 2, 3, 13, 31 and 10 to configure
booting from SPI mode or HyperFlash mode.

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

