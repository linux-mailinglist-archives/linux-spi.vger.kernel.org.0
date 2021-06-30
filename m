Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64DDA3B7F99
	for <lists+linux-spi@lfdr.de>; Wed, 30 Jun 2021 11:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233514AbhF3JGf (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 30 Jun 2021 05:06:35 -0400
Received: from twhmllg3.macronix.com ([122.147.135.201]:40484 "EHLO
        TWHMLLG3.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233442AbhF3JGf (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 30 Jun 2021 05:06:35 -0400
Received: from twhfmlp1.macronix.com (twhfmlp1.macronix.com [172.17.20.91])
        by TWHMLLG3.macronix.com with ESMTP id 15U93W4Q081226;
        Wed, 30 Jun 2021 17:03:32 +0800 (GMT-8)
        (envelope-from zhengxunli@mxic.com.tw)
Received: from MXML06C.mxic.com.tw (mxml06c.mxic.com.tw [172.17.14.55])
        by Forcepoint Email with ESMTP id 5EEB8ACF30658089771D;
        Wed, 30 Jun 2021 17:03:33 +0800 (CST)
In-Reply-To: <59855ba0-31d8-25b4-3000-ca493a83fe00@microchip.com>
References: <1621232088-12567-1-git-send-email-zhengxunli@mxic.com.tw> <1621232088-12567-2-git-send-email-zhengxunli@mxic.com.tw> <59855ba0-31d8-25b4-3000-ca493a83fe00@microchip.com>
To:     <Tudor.Ambarus@microchip.com>
Cc:     broonie@kernel.org, jaimeliao@mxic.com.tw,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        miquel.raynal@bootlin.com, p.yadav@ti.com
Subject: Re: [PATCH v5 1/2] mtd: spi-nor: macronix: add support for Macronix
 octaflash
MIME-Version: 1.0
X-KeepSent: 064E94C6:E4E45300-48258704:002E055A;
 type=4; name=$KeepSent
X-Mailer: Lotus Notes Release 8.5.3FP6 SHF907 April 26, 2018
Message-ID: <OF064E94C6.E4E45300-ON48258704.002E055A-48258704.0031C392@mxic.com.tw>
From:   zhengxunli@mxic.com.tw
Date:   Wed, 30 Jun 2021 17:03:33 +0800
X-MIMETrack: Serialize by Router on MXML06C/TAIWAN/MXIC(Release 9.0.1FP10 HF265|July 25, 2018) at
 2021/06/30 PM 05:03:33,
        Serialize complete at 2021/06/30 PM 05:03:33
Content-Type: text/plain; charset="US-ASCII"
X-MAIL: TWHMLLG3.macronix.com 15U93W4Q081226
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


Hi Tudor,

> Subject
> 
> Re: [PATCH v5 1/2] mtd: spi-nor: macronix: add support for Macronix 
octaflash
> 
> On 5/17/21 9:14 AM, Zhengxun Li wrote:
> > +       { "mx66lm1g45g", INFO(0xc2853b, 0, 32 * 1024, 4096,
> > +                             SECT_4K | SPI_NOR_OCTAL_DTR_READ |
> > +                             SPI_NOR_OCTAL_DTR_PP | 
SPI_NOR_4B_OPCODES)
> > +               .fixups = &octaflash_fixups },
> 
> I have a mx66lm1g45g which does not define SFDP tables, how you'll 
> differentiate
> between the two? Mine will fail after reset. I'm working to address 
> the flash ID
> collisions, will send patches soon. I won't queue any new flash 
> additions until
> we'll solve the ID collisions problem.

I asked our flash team, unfortunately, they said that due to SFDP on 
octaflash not existing from beginning, therefore, some old parts may not 
support the SFDP parameter inside the Flash. For MX66LM1G45G, we have SFDP 
available from 2020/03. However, other flash maybe meet the same problem, 
I will update them later. 

As for ID conflicts, I will discuss with them which series of flash has 
encountered this problem, and I will update it later.

Thanks,
Zhengxun


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

