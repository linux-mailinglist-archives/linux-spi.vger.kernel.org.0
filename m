Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C43981EB5DC
	for <lists+linux-spi@lfdr.de>; Tue,  2 Jun 2020 08:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725921AbgFBGeH (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 2 Jun 2020 02:34:07 -0400
Received: from twhmllg3.macronix.com ([211.75.127.131]:37240 "EHLO
        TWHMLLG3.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgFBGeG (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 2 Jun 2020 02:34:06 -0400
Received: from twhfmlp1.macronix.com (twhfmlp1.macronix.com [172.17.20.91])
        by TWHMLLG3.macronix.com with ESMTP id 0526WqhW083980;
        Tue, 2 Jun 2020 14:32:52 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
Received: from MXML06C.mxic.com.tw (mxml06c.mxic.com.tw [172.17.14.55])
        by Forcepoint Email with ESMTP id C42C77D7708EA654953F;
        Tue,  2 Jun 2020 14:32:52 +0800 (CST)
In-Reply-To: <20200529092353.56nfczya6ygfbki2@yadavpratyush.com>
References: <1590737775-4798-1-git-send-email-masonccyang@mxic.com.tw> <1590737775-4798-2-git-send-email-masonccyang@mxic.com.tw> <20200529092353.56nfczya6ygfbki2@yadavpratyush.com>
To:     "Pratyush Yadav" <me@yadavpratyush.com>
Cc:     boris.brezillon@collabora.com, broonie@kernel.org,
        juliensu@mxic.com.tw, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        matthias.bgg@gmail.com, miquel.raynal@bootlin.com, p.yadav@ti.com,
        richard@nod.at, tudor.ambarus@microchip.com, vigneshr@ti.com
Subject: Re: [PATCH v4 1/7] mtd: spi-nor: sfdp: get octal mode maximum speed from
 BFPT
MIME-Version: 1.0
X-KeepSent: 61F39C24:01B2337A-4825857B:00238327;
 type=4; name=$KeepSent
X-Mailer: Lotus Notes Release 8.5.3FP4 SHF90 June 10, 2013
Message-ID: <OF61F39C24.01B2337A-ON4825857B.00238327-4825857B.0023F82E@mxic.com.tw>
From:   masonccyang@mxic.com.tw
Date:   Tue, 2 Jun 2020 14:32:53 +0800
X-MIMETrack: Serialize by Router on MXML06C/TAIWAN/MXIC(Release 9.0.1FP10 HF265|July 25, 2018) at
 2020/06/02 PM 02:32:52,
        Serialize complete at 2020/06/02 PM 02:32:52
Content-Type: text/plain; charset="US-ASCII"
X-MAIL: TWHMLLG3.macronix.com 0526WqhW083980
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


Hi Pratyush,

> 
> Subject
> 
> Re: [PATCH v4 1/7] mtd: spi-nor: sfdp: get octal mode maximum speed from 
BFPT
> 
> On 29/05/20 03:36PM, Mason Yang wrote:
> > Get maximum operation speed of device in octal mode from
> > BFPT 20th DWORD.
> 
> I don't like the idea of getting the maximum operation speed from BFPT 
> when the Profile 1.0 table already tells us that. For example, the 
> 200MHz operation dummy cycles field in the 4th DWORD says that a value 
> of 0 means the frequency is not supported. So the Profile 1.0 table 
> already tells us what frequencies the flash can run at in xSPI Profile 
> 1.0 mode.

As JEDEC spec. mentioned that 
Operation faster than 200MHz is not part of the current xSPI Spec. 
However, this does not prevent vendors from making devices that operate at 
higher speed.

In addition, current xSPP profile 1.0 table only defined up to 200MHz.

> 
> So IMO we should use the Profile 1.0 table for this instead because
> it will be a localized change which is easier to maintain. I also get 
> the feeling it will be less prone to mis-interpretations.
> 
> > Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> > ---

thanks for your time & comments.
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

