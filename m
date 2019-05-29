Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 185772D427
	for <lists+linux-spi@lfdr.de>; Wed, 29 May 2019 05:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725917AbfE2DNz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Tue, 28 May 2019 23:13:55 -0400
Received: from twhmllg3.macronix.com ([211.75.127.131]:21263 "EHLO
        TWHMLLG3.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbfE2DNz (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 28 May 2019 23:13:55 -0400
Received: from twhfmlp1.macronix.com (twhfm1p1.macronix.com [172.17.20.91])
        by TWHMLLG3.macronix.com with ESMTP id x4T3C9Cr060053;
        Wed, 29 May 2019 11:12:09 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
Received: from MXML06C.mxic.com.tw (mxml06c.macronix.com [172.17.14.55])
        by Forcepoint Email with ESMTP id EDCE24567F9C6873D729;
        Wed, 29 May 2019 11:12:08 +0800 (CST)
In-Reply-To: <20190527144250.71908bd9@xps13>
References: <1555320234-15802-1-git-send-email-masonccyang@mxic.com.tw> <1555320234-15802-3-git-send-email-masonccyang@mxic.com.tw>
        <20190512151820.4f2dd9da@xps13> <OF074A1F06.5C1A58BE-ON482583FD.0031CD95-482583FD.003437AD@mxic.com.tw>
        <20190520142333.390091d5@xps13> <OFADC47344.0F9941B2-ON48258403.002336E3-48258403.003141F0@mxic.com.tw> <20190527144250.71908bd9@xps13>
To:     "Miquel Raynal" <miquel.raynal@bootlin.com>
Cc:     bbrezillon@kernel.org, broonie@kernel.org,
        christophe.kerello@st.com, computersforpeace@gmail.com,
        devicetree@vger.kernel.org, dwmw2@infradead.org,
        geert@linux-m68k.org, juliensu@mxic.com.tw, lee.jones@linaro.org,
        liang.yang@amlogic.com, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        marcel.ziswiler@toradex.com, marek.vasut@gmail.com,
        mark.rutland@arm.com, paul.burton@mips.com, richard@nod.at,
        robh+dt@kernel.org, stefan@agner.ch, zhengxunli@mxic.com.tw
Subject: Re: [PATCH v3 2/4] mtd: rawnand: Add Macronix MX25F0A NAND controller
MIME-Version: 1.0
X-KeepSent: E923A8E5:50375C30-48258409:0009AE1B;
 type=4; name=$KeepSent
X-Mailer: Lotus Notes Release 8.5.3FP4 SHF90 June 10, 2013
Message-ID: <OFE923A8E5.50375C30-ON48258409.0009AE1B-48258409.00119767@mxic.com.tw>
From:   masonccyang@mxic.com.tw
Date:   Wed, 29 May 2019 11:12:08 +0800
X-MIMETrack: Serialize by Router on MXML06C/TAIWAN/MXIC(Release 9.0.1FP10 HF265|July 25, 2018) at
 2019/05/29 AM 11:12:09,
        Serialize complete at 2019/05/29 AM 11:12:09
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-MAIL: TWHMLLG3.macronix.com x4T3C9Cr060053
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


Hi Miquel,

> > > > > > +static void mxic_nand_select_chip(struct nand_chip *chip, int 
 
> > chipnr) 
> > > > > 
> > > > > _select_target() is preferred now 
> > > > 
> > > > Do you mean I implement mxic_nand_select_target() to control #CS ?
> > > > 
> > > > If so, I need to call mxic_nand_select_target( ) to control #CS ON
> > > > and then #CS OFF in _exec_op() due to nand_select_target()<in 
> > nand_base,c> 
> > > > is still calling chip->legacy.select_chip ? 
> > > 
> > > You must forget about the ->select_chip() callback. Now it should be
> > > handled directly from the controller driver. Please have a look at 
the
> > > commit pointed against the marvell_nand.c driver. 
> > 
> > I have no Marvell NFC datasheet and have one question.
> > 
> > In marvell_nand.c, there is no xxx_deselect_target() or 
> > something like that doing #CS OFF.
> > marvell_nfc_select_target() seems always to make one of chip or die
> > #CS keep low.
> > 
> > Is it right ?
> 
> Yes, AFAIR there is no "de-assert" mechanism in this controller.
> 
> > 
> > How to make all #CS keep high for NAND to enter 
> > low-power standby mode if driver don't use "legacy.select_chip()" ?
> 
> See commit 02b4a52604a4 ("mtd: rawnand: Make ->select_chip() optional
> when ->exec_op() is implemented") which states:
> 
>         "When [->select_chip() is] not implemented, the core is assuming
>    the CS line is automatically asserted/deasserted by the driver
>    ->exec_op() implementation."
> 
> Of course, the above is right only when the controller driver supports
> the ->exec_op() interface. 

Currently, it seems that we will get the incorrect data and error
operation due to CS in error toggling if CS line is controlled in 
->exec_op().
i.e,. 

1) In nand_onfi_detect() to call nand_exec_op() twice by 
nand_read_param_page_op() and annd_read_data_op()

2) In nand_write_page_xxx to call nand_exec_op() many times by
nand_prog_page_begin_op(), nand_write_data_op() and 
nand_prog_page_end_op().


Should we consider to add a CS line controller in struct nand_controller
i.e,.

struct nand_controller {
         struct mutex lock;
         const struct nand_controller_ops *ops;
+          void (*select_chip)(struct nand_chip *chip, int cs);
};

to replace legacy.select_chip() ?


To patch in nand_select_target() and nand_deselect_target()

void nand_select_target(struct nand_chip *chip, unsigned int cs)
{
        /*
         * cs should always lie between 0 and chip->numchips, when that's 
not
         * the case it's a bug and the caller should be fixed.
         */
        if (WARN_ON(cs > chip->numchips))
                return;

        chip->cur_cs = cs;

+       if (chip->controller->select_chip)
+               chip->controller->select_chip(chip, cs);
+
        if (chip->legacy.select_chip)
                chip->legacy.select_chip(chip, cs);
}

void nand_deselect_target(struct nand_chip *chip)
{
+       if (chip->controller->select_chip)
+               chip->controller->select_chip(chip, -1);
+
        if (chip->legacy.select_chip)
                chip->legacy.select_chip(chip, -1);

        chip->cur_cs = -1;
}


> 
> So if you think it is not too time consuming and worth the trouble to
> assert/deassert the CS at each operation, you may do it in your driver.
> 
> 
> Thanks,
> Miquèl

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

