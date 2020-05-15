Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84BEA1D4381
	for <lists+linux-spi@lfdr.de>; Fri, 15 May 2020 04:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgEOC1h (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 14 May 2020 22:27:37 -0400
Received: from twhmllg4.macronix.com ([211.75.127.132]:10014 "EHLO
        TWHMLLG4.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbgEOC1h (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 14 May 2020 22:27:37 -0400
Received: from twhfm1p2.macronix.com (twhfmlp2.macronix.com [172.17.20.92])
        by TWHMLLG4.macronix.com with ESMTP id 04F2Q5pA045600;
        Fri, 15 May 2020 10:26:05 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
Received: from MXML06C.mxic.com.tw (mxml06c.macronix.com [172.17.14.55])
        by Forcepoint Email with ESMTP id 8019D69F055CB487B644;
        Fri, 15 May 2020 10:26:05 +0800 (CST)
In-Reply-To: <20200506094028.2asq56goslfd2ngo@yadavpratyush.com>
References: <1587451187-6889-1-git-send-email-masonccyang@mxic.com.tw> <20200421092328.129308f6@collabora.com> <20200427175536.2mmei2fy6f7bg6jm@yadavpratyush.com> <OF18214CA5.6A9B2B30-ON48258558.001D894C-48258558.002249E0@mxic.com.tw> <20200428085401.574wmo6qddmumd7q@yadavpratyush.com> <OF04289CE2.B346916F-ON48258559.002280BD-48258559.00295800@mxic.com.tw> <20200429181856.kkavelcczylg4yxf@yadavpratyush.com> <OF28AE0642.4F34D6BB-ON4825855F.002D6E58-4825855F.003458C9@mxic.com.tw> <20200506094028.2asq56goslfd2ngo@yadavpratyush.com>
To:     "Pratyush Yadav" <me@yadavpratyush.com>
Cc:     "Boris Brezillon" <boris.brezillon@collabora.com>,
        broonie@kernel.org, juliensu@mxic.com.tw,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-spi@vger.kernel.org, miquel.raynal@bootlin.com,
        "Pratyush Yadav" <p.yadav@ti.com>, richard@nod.at,
        tudor.ambarus@microchip.com, vigneshr@ti.com
Subject: Re: [PATCH v2 0/5] mtd: spi-nor: Add support for Octal 8D-8D-8D mode
MIME-Version: 1.0
X-KeepSent: 03B5329E:56965A70-48258569:000878CE;
 type=4; name=$KeepSent
X-Mailer: Lotus Notes Release 8.5.3FP4 SHF90 June 10, 2013
Message-ID: <OF03B5329E.56965A70-ON48258569.000878CE-48258569.000D5FFD@mxic.com.tw>
From:   masonccyang@mxic.com.tw
Date:   Fri, 15 May 2020 10:26:05 +0800
X-MIMETrack: Serialize by Router on MXML06C/TAIWAN/MXIC(Release 9.0.1FP10 HF265|July 25, 2018) at
 2020/05/15 AM 10:26:05,
        Serialize complete at 2020/05/15 AM 10:26:05
Content-Type: text/plain; charset="US-ASCII"
X-MAIL: TWHMLLG4.macronix.com 04F2Q5pA045600
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


Hi Pratyush,

> > > > I can't apply your patches to enable xSPI Octal mode for 
> > > > mx25uw51245g because your patches set up Octal protocol first and 
> > > > then using Octal protocol to write Configuration Register 2(CFG 
> > > > Reg2). I think driver
> > > > should write CFG Reg2 in SPI 1-1-1 mode (power on state) and make 
sure
> > > > write CFG Reg 2 is success and then setup Octa protocol in the 
last.
> > > 
> > > Register writes should work in 1S mode, because nor->reg_proto is 
only 
> > > set _after_ 8D mode is enabled (see spi_nor_octal_dtr_enable()). In 
> > > fact, both patch 15 and 16 in my series use register writes in 1S 
mode.
> > 
> > but I didn't see driver roll back "nor->read/write_proto = 1" 
> > if xxx->octal_dtr_enable() return failed!
> 
> I copied what spi_nor_quad_enable() did, and made failure fatal. So if 
> xxx->octal_dtr_enable() fails, the probe would fail and the flash would 
> be unusable. You can try your hand at a fallback system where you try 

IMHO, it's not a good for system booting from SPI-NOR, 
driver should still keep system alive in SPI 1-1-1 mode in case of 
enable Octal/Quad failed.

Therefore, my patches is to setup nor->read/write_proto = 8 in case 
driver enable Octal mode is success. And to enable Octal mode in
spi_nor_late_init_params()rather than as spi_nor_quad_enable()did.

> all possible protocols available, but I think that should be a different 

> patchset.
> 
> -- 
> Regards,
> Pratyush Yadav

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

