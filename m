Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16F034B45D
	for <lists+linux-spi@lfdr.de>; Wed, 19 Jun 2019 10:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730996AbfFSIuY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Wed, 19 Jun 2019 04:50:24 -0400
Received: from twhmllg3.macronix.com ([122.147.135.201]:11343 "EHLO
        TWHMLLG3.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730783AbfFSIuY (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 19 Jun 2019 04:50:24 -0400
Received: from twhfmlp1.macronix.com (twhfm1p1.macronix.com [172.17.20.91])
        by TWHMLLG3.macronix.com with ESMTP id x5J8mg1Q004932;
        Wed, 19 Jun 2019 16:48:42 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
Received: from MXML06C.mxic.com.tw (mxml06c.macronix.com [172.17.14.55])
        by Forcepoint Email with ESMTP id 6458BBF1EB3AC5549737;
        Wed, 19 Jun 2019 16:48:43 +0800 (CST)
In-Reply-To: <20190619100904.6b759377@xps13>
References: <1555320234-15802-1-git-send-email-masonccyang@mxic.com.tw> <1555320234-15802-3-git-send-email-masonccyang@mxic.com.tw>
        <20190512151820.4f2dd9da@xps13> <OF074A1F06.5C1A58BE-ON482583FD.0031CD95-482583FD.003437AD@mxic.com.tw>
        <20190520142333.390091d5@xps13> <OFADC47344.0F9941B2-ON48258403.002336E3-48258403.003141F0@mxic.com.tw>
        <20190527144250.71908bd9@xps13> <OFE923A8E5.50375C30-ON48258409.0009AE1B-48258409.00119767@mxic.com.tw>
        <20190617143510.4ded5728@xps13> <OF1C1397B4.241DC339-ON4825841D.000482A2-4825841D.0007B67E@mxic.com.tw>
        <20190618081436.5d488320@collabora.com> <20190618092901.3bdd9f61@collabora.com>
        <OF5EAF94EB.AE31CF59-ON4825841E.002A2C38-4825841E.002C60BF@mxic.com.tw> <20190619100904.6b759377@xps13>
To:     "Miquel Raynal" <miquel.raynal@bootlin.com>
Cc:     bbrezillon@kernel.org,
        "Boris Brezillon" <boris.brezillon@collabora.com>,
        broonie@kernel.org, christophe.kerello@st.com,
        computersforpeace@gmail.com, devicetree@vger.kernel.org,
        dwmw2@infradead.org, geert@linux-m68k.org, juliensu@mxic.com.tw,
        lee.jones@linaro.org, liang.yang@amlogic.com,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-spi@vger.kernel.org, marcel.ziswiler@toradex.com,
        marek.vasut@gmail.com, mark.rutland@arm.com, paul.burton@mips.com,
        richard@nod.at, robh+dt@kernel.org, stefan@agner.ch,
        zhengxunli@mxic.com.tw
Subject: Re: [PATCH v3 2/4] mtd: rawnand: Add Macronix MX25F0A NAND controller
MIME-Version: 1.0
X-KeepSent: ACBC7B27:1732CFB6-4825841E:0030075C;
 type=4; name=$KeepSent
X-Mailer: Lotus Notes Release 8.5.3FP4 SHF90 June 10, 2013
Message-ID: <OFACBC7B27.1732CFB6-ON4825841E.0030075C-4825841E.0030689C@mxic.com.tw>
From:   masonccyang@mxic.com.tw
Date:   Wed, 19 Jun 2019 16:48:44 +0800
X-MIMETrack: Serialize by Router on MXML06C/TAIWAN/MXIC(Release 9.0.1FP10 HF265|July 25, 2018) at
 2019/06/19 PM 04:48:43,
        Serialize complete at 2019/06/19 PM 04:48:43
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-MAIL: TWHMLLG3.macronix.com x5J8mg1Q004932
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


Hi Miquel,

> > > 
> > > Re: [PATCH v3 2/4] mtd: rawnand: Add Macronix MX25F0A NAND 
controller
> > > 
> > > On Tue, 18 Jun 2019 08:14:36 +0200
> > > Boris Brezillon <boris.brezillon@collabora.com> wrote:
> > > 
> > > > > > > > > 
> > > > > > > > > How to make all #CS keep high for NAND to enter 
> > > > > > > > > low-power standby mode if driver don't use 
> > "legacy.select_chip()" 
> > > > > ? 
> > > > > > > > 
> > > > > > > > See commit 02b4a52604a4 ("mtd: rawnand: Make 
->select_chip() 
> > > > > optional 
> > > > > > > > when ->exec_op() is implemented") which states:
> > > > > > > > 
> > > > > > > >         "When [->select_chip() is] not implemented, the 
core 
> > is 
> > > > > assuming 
> > > > > > > >    the CS line is automatically asserted/deasserted by the 
 
> > driver 
> > > > > > > >    ->exec_op() implementation." 
> > > > > > > > 
> > > > > > > > Of course, the above is right only when the controller 
driver 
> > 
> > > > > supports 
> > > > > > > > the ->exec_op() interface. 
> > > > > > > 
> > > > > > > Currently, it seems that we will get the incorrect data and  

> > error
> > > > > > > operation due to CS in error toggling if CS line is 
controlled 
> > in 
> > > > > > > ->exec_op(). 
> > > 
> > > Oh, and please provide the modifications you added on top of this 
patch.
> > > Right now we're speculating on what you've done which is definitely 
not
> > > an efficient way to debug this sort of issues. 
> > 
> 
> We really need to see the datasheet of the NAND chip which has a
> problem and how this LPM mode is advertized to understand what the
> chip expects and eventually how to work-around it.

okay, got it and thanks.

> 
> > The patch is to add in beginning of ->exec_op() to control CS# low and 

> > before return from ->exec_op() to control CS# High.
> > i.e,.
> > static in mxic_nand_exec_op( )
> > {
> >  cs_to_low();
> > 
> > 
> > 
> >  cs_to_high();
> >  return;
> > }
> > 
> > But for nand_onfi_detect(), 
> > it calls nand_read_param_page_op() and then nand_read_data_op().
> > mxic_nand_exec_op() be called twice for nand_onfi_detect()
> 
> Yes, this is expected and usually chips don't care.

got it and I will try to fix it on my NFC driver.

> 
> > and
> > driver will get incorrect ONFI parameter table data from 
> > nand_read_data_op().
> > 
> 
> Thanks,
> Miquèl

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

