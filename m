Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E69049976
	for <lists+linux-spi@lfdr.de>; Tue, 18 Jun 2019 08:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbfFRGxz (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 18 Jun 2019 02:53:55 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:59098 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbfFRGxy (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 18 Jun 2019 02:53:54 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id E20A426D931;
        Tue, 18 Jun 2019 07:14:39 +0100 (BST)
Date:   Tue, 18 Jun 2019 08:14:36 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     masonccyang@mxic.com.tw
Cc:     "Miquel Raynal" <miquel.raynal@bootlin.com>, bbrezillon@kernel.org,
        broonie@kernel.org, christophe.kerello@st.com,
        computersforpeace@gmail.com, devicetree@vger.kernel.org,
        dwmw2@infradead.org, geert@linux-m68k.org, juliensu@mxic.com.tw,
        lee.jones@linaro.org, liang.yang@amlogic.com,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-spi@vger.kernel.org, marcel.ziswiler@toradex.com,
        marek.vasut@gmail.com, mark.rutland@arm.com, paul.burton@mips.com,
        richard@nod.at, robh+dt@kernel.org, stefan@agner.ch,
        zhengxunli@mxic.com.tw
Subject: Re: [PATCH v3 2/4] mtd: rawnand: Add Macronix MX25F0A NAND
 controller
Message-ID: <20190618081436.5d488320@collabora.com>
In-Reply-To: <OF1C1397B4.241DC339-ON4825841D.000482A2-4825841D.0007B67E@mxic.com.tw>
References: <1555320234-15802-1-git-send-email-masonccyang@mxic.com.tw>
        <1555320234-15802-3-git-send-email-masonccyang@mxic.com.tw>
        <20190512151820.4f2dd9da@xps13>
        <OF074A1F06.5C1A58BE-ON482583FD.0031CD95-482583FD.003437AD@mxic.com.tw>
        <20190520142333.390091d5@xps13>
        <OFADC47344.0F9941B2-ON48258403.002336E3-48258403.003141F0@mxic.com.tw>
        <20190527144250.71908bd9@xps13>
        <OFE923A8E5.50375C30-ON48258409.0009AE1B-48258409.00119767@mxic.com.tw>
        <20190617143510.4ded5728@xps13>
        <OF1C1397B4.241DC339-ON4825841D.000482A2-4825841D.0007B67E@mxic.com.tw>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Mason,

On Tue, 18 Jun 2019 09:24:14 +0800
masonccyang@mxic.com.tw wrote:

> Hi Miquel,
> 
> >   
> > > > > > > > > +static void mxic_nand_select_chip(struct nand_chip *chip,   
> int 
> > >   
> > > > > chipnr)   
> > > > > > > > 
> > > > > > > > _select_target() is preferred now   
> > > > > > > 
> > > > > > > Do you mean I implement mxic_nand_select_target() to control   
> #CS ?
> > > > > > > 
> > > > > > > If so, I need to call mxic_nand_select_target( ) to control   
> #CS ON
> > > > > > > and then #CS OFF in _exec_op() due to nand_select_target()<in    
> 
> > > > > nand_base,c>   
> > > > > > > is still calling chip->legacy.select_chip ?   
> > > > > > 
> > > > > > You must forget about the ->select_chip() callback. Now it   
> should be
> > > > > > handled directly from the controller driver. Please have a look   
> at 
> > > the  
> > > > > > commit pointed against the marvell_nand.c driver.   
> > > > > 
> > > > > I have no Marvell NFC datasheet and have one question.
> > > > > 
> > > > > In marvell_nand.c, there is no xxx_deselect_target() or 
> > > > > something like that doing #CS OFF.
> > > > > marvell_nfc_select_target() seems always to make one of chip or   
> die
> > > > > #CS keep low.
> > > > > 
> > > > > Is it right ?   
> > > > 
> > > > Yes, AFAIR there is no "de-assert" mechanism in this controller.
> > > >   
> > > > > 
> > > > > How to make all #CS keep high for NAND to enter 
> > > > > low-power standby mode if driver don't use "legacy.select_chip()"   
> ? 
> > > > 
> > > > See commit 02b4a52604a4 ("mtd: rawnand: Make ->select_chip()   
> optional
> > > > when ->exec_op() is implemented") which states:
> > > > 
> > > >         "When [->select_chip() is] not implemented, the core is   
> assuming
> > > >    the CS line is automatically asserted/deasserted by the driver   
> > > >    ->exec_op() implementation."   
> > > > 
> > > > Of course, the above is right only when the controller driver   
> supports
> > > > the ->exec_op() interface.   
> > > 
> > > Currently, it seems that we will get the incorrect data and error
> > > operation due to CS in error toggling if CS line is controlled in   
> > > ->exec_op().   
> > 
> > Most of the chips today are CS-don't-care, which chip are you using?  
> 
> I think CS-don't-care means read-write operation for NAND device to reside
> on the same memory bus as other Flash or SRAM devices. Other devices on 
> the 
> memory bus can then be accessed while the NAND Flash is busy with internal 
> 
> operations. This capability is very important for designs that require 
> multiple
> NAND Flash devices on the same bus.

Yes, we know what CS-dont-care mean, what we want to know is whether
your chip supports that or not. And if it supports it, I don't
understand why you have a problem when asserting/de-asserting on each
->exec_op() call.

> 
> > 
> > Is this behavior publicly documented?
> >   
> 
> CS# pin goes High enter standby mode to reduce power consumption,
> i.e,. standby mode w/ CS# keep High, standby current: 10 uA (Typ for 3.3V 
> NAND)
>         otherwise, current is more than 1 mA.
> i.e,. page read current, 25 mA (Typ for 3.3V NAND)

That's not what we were looking for. We want to know what happens when
the CS line is de-asserted in the middle of a NAND operation (like read
param page). I'd expect the NAND to retain its state so that the
operation can be resumed when the CS line is asserted again. If that's
not the case that means the NAND is not really CS-dont-care compliant.

>  
> 
> > Is this LPM mode always activated?
> >   
> > > i.e,. 
> > > 
> > > 1) In nand_onfi_detect() to call nand_exec_op() twice by 
> > > nand_read_param_page_op() and annd_read_data_op()
> > > 
> > > 2) In nand_write_page_xxx to call nand_exec_op() many times by
> > > nand_prog_page_begin_op(), nand_write_data_op() and 
> > > nand_prog_page_end_op().
> > > 
> > > 
> > > Should we consider to add a CS line controller in struct   
> nand_controller
> > > i.e,.
> > > 
> > > struct nand_controller {
> > >          struct mutex lock;
> > >          const struct nand_controller_ops *ops;
> > > +          void (*select_chip)(struct nand_chip *chip, int cs);
> > > };
> > > 
> > > to replace legacy.select_chip() ?
> > >   
> > 
> > No, if really needed, we could add a "macro op done" flag in the nand
> > operation structure.
> >   
> 
> Is this "macron op done" flag good for multiple NAND devices on
> the same bus ?

It's completely orthogonal to the multi-chip feature, so yes, it should
work just fine.

> 
> Any other way to control CS# pin? if user application is really
> care of power consumption, i.e,. loT.

No, the user is not in control of the CS pin, only the driver can do
that.

Can you please point us to the datasheet of the NAND you're testing, or
something close enough?

Thanks,

Boris
