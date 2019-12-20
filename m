Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6AE0127301
	for <lists+linux-spi@lfdr.de>; Fri, 20 Dec 2019 02:45:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727135AbfLTBpy (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 19 Dec 2019 20:45:54 -0500
Received: from twhmllg4.macronix.com ([211.75.127.132]:48474 "EHLO
        TWHMLLG4.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727125AbfLTBpx (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 19 Dec 2019 20:45:53 -0500
Received: from twhfm1p2.macronix.com (twhfm1p2.macronix.com [172.17.20.92])
        by TWHMLLG4.macronix.com with ESMTP id xBK1jKui058465;
        Fri, 20 Dec 2019 09:45:20 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
Received: from MXML06C.mxic.com.tw (mxml06c.mxic.com.tw [172.17.14.55])
        by Forcepoint Email with ESMTP id C202A1DF76EF89CEE2A3;
        Fri, 20 Dec 2019 09:45:20 +0800 (CST)
In-Reply-To: <6f4c5d92-3ca4-2d1d-47c4-cbd52ad428b0@cogentembedded.com>
References: <20191206134202.18784-1-chris.brandt@renesas.com> <922cfa46-efb5-9e6d-67ea-3ac505b8211c@cogentembedded.com> <TY1PR01MB156215E8668C0317FA0826B18A580@TY1PR01MB1562.jpnprd01.prod.outlook.com> <e6a73df5-31c4-3472-f7bc-a0984f1f5380@cogentembedded.com> <TY1PR01MB1562D343E1AB06DCA2973DAC8A550@TY1PR01MB1562.jpnprd01.prod.outlook.com> <590840ce-a250-2512-3d04-c2420d83f7da@cogentembedded.com> <TY1PR01MB1562B9EB96818DCA507079808A510@TY1PR01MB1562.jpnprd01.prod.outlook.com> <bb630141-021c-5618-f266-b98b29956fa8@cogentembedded.com> <TY1PR01MB1562E196AB1C582F186CC74B8A520@TY1PR01MB1562.jpnprd01.prod.outlook.com> <6f4c5d92-3ca4-2d1d-47c4-cbd52ad428b0@cogentembedded.com>
To:     "Sergei Shtylyov" <sergei.shtylyov@cogentembedded.com>
Cc:     "Mark Brown" <broonie@kernel.org>,
        "Chris Brandt" <Chris.Brandt@renesas.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "Geert Uytterhoeven" <geert+renesas@glider.be>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        "Michael Turquette" <mturquette@baylibre.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Stephen Boyd" <sboyd@kernel.org>
Subject: Re: [PATCH v2 0/6] spi: Add Renesas SPIBSC controller
MIME-Version: 1.0
X-KeepSent: 3F92D76C:33FFFBFC-482584D6:00093DAC;
 type=4; name=$KeepSent
X-Mailer: Lotus Notes Release 8.5.3FP4 SHF90 June 10, 2013
Message-ID: <OF3F92D76C.33FFFBFC-ON482584D6.00093DAC-482584D6.0009A51D@mxic.com.tw>
From:   masonccyang@mxic.com.tw
Date:   Fri, 20 Dec 2019 09:45:21 +0800
X-MIMETrack: Serialize by Router on MXML06C/TAIWAN/MXIC(Release 9.0.1FP10 HF265|July 25, 2018) at
 2019/12/20 AM 09:45:20,
        Serialize complete at 2019/12/20 AM 09:45:20
Content-Type: text/plain; charset="US-ASCII"
X-MAIL: TWHMLLG4.macronix.com xBK1jKui058465
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


Hello,
 
> On 12/19/2019 07:57 PM, Chris Brandt wrote:
> 
> >>> So at the moment, there is nothing yet for me to 'try' on the RZ/A 
series,
> >> correct?
> >>
> >>    Why, I can send you a working version of the SPI driver, and even 
HF one
> >> if you're
> >> interested.
> > 
> > The point of this whole discussion is to determine if we should have 2 
drivers
> > for the same Renesas HW IP.
> > 
> > There was a RPC-IF patch series that made it to v17....and is now 
dead.


It's under review by Geert Uytterhoeven

https://patchwork.kernel.org/project/linux-renesas-soc/list/?submitter=181859 


https://patchwork.kernel.org/patch/11078131/ 
https://patchwork.kernel.org/patch/11078133/ 


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

