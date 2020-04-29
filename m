Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 335BB1BD450
	for <lists+linux-spi@lfdr.de>; Wed, 29 Apr 2020 08:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbgD2GAY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 29 Apr 2020 02:00:24 -0400
Received: from twhmllg3.macronix.com ([211.75.127.131]:11644 "EHLO
        TWHMLLG3.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbgD2GAX (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 29 Apr 2020 02:00:23 -0400
Received: from twhfmlp1.macronix.com (twhfmlp1.macronix.com [172.17.20.91])
        by TWHMLLG3.macronix.com with ESMTP id 03T5xaO9000906;
        Wed, 29 Apr 2020 13:59:36 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
Received: from MXML06C.mxic.com.tw (mxml06c.macronix.com [172.17.14.55])
        by Forcepoint Email with ESMTP id D119FB1EA87A141E4B92;
        Wed, 29 Apr 2020 13:59:36 +0800 (CST)
In-Reply-To: <20200428083423.4fafd187@collabora.com>
References: <1587451187-6889-1-git-send-email-masonccyang@mxic.com.tw>  <20200421092328.129308f6@collabora.com>
        <20200427175536.2mmei2fy6f7bg6jm@yadavpratyush.com>     <OF18214CA5.6A9B2B30-ON48258558.001D894C-48258558.002249E0@mxic.com.tw> <20200428083423.4fafd187@collabora.com>
To:     "Boris Brezillon" <boris.brezillon@collabora.com>
Cc:     broonie@kernel.org, juliensu@mxic.com.tw,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-spi@vger.kernel.org, "Pratyush Yadav" <me@yadavpratyush.com>,
        miquel.raynal@bootlin.com, "Pratyush Yadav" <p.yadav@ti.com>,
        richard@nod.at, tudor.ambarus@microchip.com, vigneshr@ti.com
Subject: Re: [PATCH v2 0/5] mtd: spi-nor: Add support for Octal 8D-8D-8D mode
MIME-Version: 1.0
X-KeepSent: C28C41CE:C7A0DF28-48258559:00209CD2;
 type=4; name=$KeepSent
X-Mailer: Lotus Notes Release 8.5.3FP4 SHF90 June 10, 2013
Message-ID: <OFC28C41CE.C7A0DF28-ON48258559.00209CD2-48258559.0020EC27@mxic.com.tw>
From:   masonccyang@mxic.com.tw
Date:   Wed, 29 Apr 2020 13:59:36 +0800
X-MIMETrack: Serialize by Router on MXML06C/TAIWAN/MXIC(Release 9.0.1FP10 HF265|July 25, 2018) at
 2020/04/29 PM 01:59:36,
        Serialize complete at 2020/04/29 PM 01:59:36
Content-Type: text/plain; charset="US-ASCII"
X-MAIL: TWHMLLG3.macronix.com 03T5xaO9000906
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


Hi Boris,

> > > > On Tue, 21 Apr 2020 14:39:42 +0800
> > > > Mason Yang <masonccyang@mxic.com.tw> wrote:
> > > > 
> > > > > Hello,
> > > > > 
> > > > > This is repost of patchset from Boris Brezillon's
> > > > > [RFC,00/18] mtd: spi-nor: Proposal for 8-8-8 mode support [1]. 
> > > > 
> > > > I only quickly went through the patches you sent and saying it's a
> > > > repost of the RFC is a bit of a lie. You completely ignored the 
state
> > > > tracking I was trying to do to avoid leaving the flash in 8D mode 
when
> > > > suspending/resetting the board, and I think that part is crucial. 
If I
> > > > remember correctly, we already had this discussion so I must say 
I'm a
> > > > bit disappointed.
> > > > 
> > > > Can you sync with Pratyush? I think his series [1] is better in 
that 
> > it
> > > > tries to restore the flash in single-SPI mode before suspend (it's
> > > > missing the shutdown case, but that can be easily added I think). 
Of
> > > > course that'd be even better to have proper state tracking at the 
SPI
> > > > NOR level. 
> > > 
> > > Hi Mason,
> > > 
> > > I posted a re-roll of my series here [0]. Could you please base your 

> > > changes on top of it? Let me know if the series is missing something 
you 
> > 
> > > need.
> > > 
> > > [0] 
> > 
https://lore.kernel.org/linux-mtd/20200424184410.8578-1-p.yadav@ti.com/
> > 
> > 
> > Our mx25uw51245g supports BFPT DWORD-18,19 and 20 data and xSPI 
profile 
> > 1.0,
> > and it comply with BFPT DWORD-19, octal mode enable sequences by write 
CFG 
> > Reg2 
> > with instruction 0x72. Therefore, I can't apply your patches.
> > 
> > I quickly went through your patches but can't reply them in each your 
> > patches.
> 
> Why?!! Aren't you registered to the MTD mailing list? Sorry but having
> reviews outside of the original thread is far from ideal. Please find a
> way to reply to the original patchset.
> 
> > 
> > i.e,.
> > 1) [v4,03/16] spi: spi-mem: allow specifying a command's extension
> > 
> > -                                u8 opcode;
> > +                                u16 opcode;
> > 
> > big/little Endian issue, right?
> 
> There's no endianness issue since it's SPI controller responsibility to
> interpret this field.
> 
> > why not just u8 ext_opcode;
> 
> Because I see the ext_ext_code comimg, and it's also more consistent
> with the addr field if we use an u16 and a number of cmd cycles.
> 
> > No any impact for exist code and actually only xSPI device use 
extension 
> > command.
> 
> And extending the opcode field to an u16 has no impact either.
> 

okay, got your point.

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

