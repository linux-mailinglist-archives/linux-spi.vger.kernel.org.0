Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9F121CD060
	for <lists+linux-spi@lfdr.de>; Mon, 11 May 2020 05:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbgEKDYq (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 10 May 2020 23:24:46 -0400
Received: from twhmllg3.macronix.com ([211.75.127.131]:52611 "EHLO
        TWHMLLG3.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbgEKDYq (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 10 May 2020 23:24:46 -0400
Received: from twhfmlp1.macronix.com (twhfmlp1.macronix.com [172.17.20.91])
        by TWHMLLG3.macronix.com with ESMTP id 04B3NVVL077104;
        Mon, 11 May 2020 11:23:31 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
Received: from MXML06C.mxic.com.tw (mxml06c.macronix.com [172.17.14.55])
        by Forcepoint Email with ESMTP id 1866BA869F7CCFC0A268;
        Mon, 11 May 2020 11:23:32 +0800 (CST)
In-Reply-To: <3e33ffae-3267-015a-8535-6e1667b03e39@ti.com>
References: <1587451187-6889-1-git-send-email-masonccyang@mxic.com.tw> <20200421092328.129308f6@collabora.com> <20200427175536.2mmei2fy6f7bg6jm@yadavpratyush.com> <OF18214CA5.6A9B2B30-ON48258558.001D894C-48258558.002249E0@mxic.com.tw> <20200428085401.574wmo6qddmumd7q@yadavpratyush.com> <OF04289CE2.B346916F-ON48258559.002280BD-48258559.00295800@mxic.com.tw> <3e33ffae-3267-015a-8535-6e1667b03e39@ti.com>
To:     "Vignesh Raghavendra" <vigneshr@ti.com>
Cc:     "Boris Brezillon" <boris.brezillon@collabora.com>,
        broonie@kernel.org, juliensu@mxic.com.tw,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-spi@vger.kernel.org, "Pratyush Yadav" <me@yadavpratyush.com>,
        miquel.raynal@bootlin.com, "Pratyush Yadav" <p.yadav@ti.com>,
        richard@nod.at, tudor.ambarus@microchip.com
Subject: Re: [PATCH v2 0/5] mtd: spi-nor: Add support for Octal 8D-8D-8D mode
MIME-Version: 1.0
X-KeepSent: 8A6B0341:0CDED2CF-48258565:000F3369;
 type=4; name=$KeepSent
X-Mailer: Lotus Notes Release 8.5.3FP4 SHF90 June 10, 2013
Message-ID: <OF8A6B0341.0CDED2CF-ON48258565.000F3369-48258565.0012A22D@mxic.com.tw>
From:   masonccyang@mxic.com.tw
Date:   Mon, 11 May 2020 11:23:32 +0800
X-MIMETrack: Serialize by Router on MXML06C/TAIWAN/MXIC(Release 9.0.1FP10 HF265|July 25, 2018) at
 2020/05/11 AM 11:23:32,
        Serialize complete at 2020/05/11 AM 11:23:32
Content-Type: text/plain; charset="US-ASCII"
X-MAIL: TWHMLLG3.macronix.com 04B3NVVL077104
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


Hi Vignesh,

> >>>
> >>> Our mx25uw51245g supports BFPT DWORD-18,19 and 20 data and xSPI 
> > profile 
> >>> 1.0,
> >>> and it comply with BFPT DWORD-19, octal mode enable sequences by 
write 
> > CFG 
> >>> Reg2 
> >>> with instruction 0x72. Therefore, I can't apply your patches.
> >>
> >> I didn't mean apply my patches directly. I meant more along the lines 
of 
> > 
> >> edit your patches to work on top of my series. It should be as easy 
as 
> >> adding your flash's fixup hooks and its octal DTR enable hook, but if 
my 
> > 
> >> series is missing something you need (like complete Profile 1.0 
parsing, 
> > 
> >> which I left out because I wanted to be conservative and didn't see 
any 
> >> immediate use-case for us), let me know, and we can work together to 
> >> address it.
> > 
> > yes,sure!
> > let's work together to upstream the Octal 8D-8D-8D driver to mainline.
> > 
> > The main concern is where and how to enable xSPI octal mode?
> > 
> > Vignesh don't agree to enable it in fixup hooks and that's why I 
patched
> > it to spi_nor_late_init_params() and confirmed the device support xSPI 

> > Octal mode after BFPT DWORD-19 and xSPI pf 1.0 have been parsed.
> > 
> 
> My suggestion was to use SFDP wherever possible.. E.g: it is possible to
> get opcode extension type from BFPT...
> 
> But using BFPT DWORD-19 is not correct for switching to 8D-8D-8D mode:
> 
> Per JESD216D.01 Bits 22:20 of  19th DWORD of BFPT:
> 
> Octal Enable Requirements:
> 
> This field describes whether the device contains a Octal Enable bit used
> to enable 1-1-8 and 1-
> 8-8 octal read or octal program operations.
> 
> So, this cannot be used for enabling 8D-8D-8D mode... Flashes that only
> support 1S-1S-1S and 8D-8D-8D will set this field to 0.

yes, you are right, the bits 22~20 your mentioned are for 1-1-8 and 1-8-8 
mode enable requirements and they are zero if Flash only supports 
1S-1S-1S,
8S-8S-8S and 8D-8D-8D, just like mx25xx series.

There are bits 8~4 for 8S-8S-8S and 8D-8D-8D mode enable sequences and
I have patched these in this patches. 

By bits 8~4 in 19 th DWORD of BFPT, driver will know enable 8S-8S-8S or
8D-8D-8D by either issue two instruction (06h and E8h) or 
by Write CFG Reg 2.

mx25xx series supports enable Octal 8S-8S-8S/8D-8D-8D mode by Write CFG 
Reg 2.


> 
> There is a separate table to enable 8D mode called
> "Command Sequences to Change to Octal DDR (8D-8D-8D) mode". But if flash
> does not have the table or has bad data, fixup hook is the only way...
> 
> If mx25* supports above table, please build on top of Pratyush's series
> to add support for parsing this table. Otherwise, macronix would have to
> use a fixup hook too...

mx25xx series also supports "Command Sequences to Change to Octal DDR 
(8D-8D-8D) mode" for sure. I will patch them in next version.

For mx25* series, a fixup hook will only setup specific dummy cycles to 
device for various frequency after xSPI 1.0 table has been parsed.


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

