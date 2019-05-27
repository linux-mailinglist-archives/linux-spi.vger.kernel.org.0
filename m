Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD9C2B590
	for <lists+linux-spi@lfdr.de>; Mon, 27 May 2019 14:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbfE0MnE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Mon, 27 May 2019 08:43:04 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:51783 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbfE0MnD (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 27 May 2019 08:43:03 -0400
Received: from xps13 (aaubervilliers-681-1-27-134.w90-88.abo.wanadoo.fr [90.88.147.134])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 7C5A824000B;
        Mon, 27 May 2019 12:42:51 +0000 (UTC)
Date:   Mon, 27 May 2019 14:42:50 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     masonccyang@mxic.com.tw
Cc:     bbrezillon@kernel.org, broonie@kernel.org,
        christophe.kerello@st.com, computersforpeace@gmail.com,
        devicetree@vger.kernel.org, dwmw2@infradead.org,
        geert@linux-m68k.org, juliensu@mxic.com.tw, lee.jones@linaro.org,
        liang.yang@amlogic.com, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        marcel.ziswiler@toradex.com, marek.vasut@gmail.com,
        mark.rutland@arm.com, paul.burton@mips.com, richard@nod.at,
        robh+dt@kernel.org, stefan@agner.ch, zhengxunli@mxic.com.tw
Subject: Re: [PATCH v3 2/4] mtd: rawnand: Add Macronix MX25F0A NAND
 controller
Message-ID: <20190527144250.71908bd9@xps13>
In-Reply-To: <OFADC47344.0F9941B2-ON48258403.002336E3-48258403.003141F0@mxic.com.tw>
References: <1555320234-15802-1-git-send-email-masonccyang@mxic.com.tw>
        <1555320234-15802-3-git-send-email-masonccyang@mxic.com.tw>
        <20190512151820.4f2dd9da@xps13>
        <OF074A1F06.5C1A58BE-ON482583FD.0031CD95-482583FD.003437AD@mxic.com.tw>
        <20190520142333.390091d5@xps13>
        <OFADC47344.0F9941B2-ON48258403.002336E3-48258403.003141F0@mxic.com.tw>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Mason,

masonccyang@mxic.com.tw wrote on Thu, 23 May 2019 16:58:02 +0800:

> Hi Miquel,
> 
> > >   
> > > > > +
> > > > > +static void mxic_nand_select_chip(struct nand_chip *chip, int   
> chipnr) 
> > > > 
> > > > _select_target() is preferred now   
> > > 
> > > Do you mean I implement mxic_nand_select_target() to control #CS ?
> > > 
> > > If so, I need to call mxic_nand_select_target( ) to control #CS ON
> > > and then #CS OFF in _exec_op() due to nand_select_target()<in   
> nand_base,c>  
> > > is still calling chip->legacy.select_chip ?  
> > 
> > You must forget about the ->select_chip() callback. Now it should be
> > handled directly from the controller driver. Please have a look at the
> > commit pointed against the marvell_nand.c driver.  
> 
> I have no Marvell NFC datasheet and have one question.
> 
> In marvell_nand.c, there is no xxx_deselect_target() or 
> something like that doing #CS OFF.
> marvell_nfc_select_target() seems always to make one of chip or die
> #CS keep low.
> 
> Is it right ?

Yes, AFAIR there is no "de-assert" mechanism in this controller.

> 
> How to make all #CS keep high for NAND to enter 
> low-power standby mode if driver don't use "legacy.select_chip()" ?

See commit 02b4a52604a4 ("mtd: rawnand: Make ->select_chip() optional
when ->exec_op() is implemented") which states:

        "When [->select_chip() is] not implemented, the core is assuming
	the CS line is automatically asserted/deasserted by the driver
	->exec_op() implementation."

Of course, the above is right only when the controller driver supports
the ->exec_op() interface. 

So if you think it is not too time consuming and worth the trouble to
assert/deassert the CS at each operation, you may do it in your driver.


Thanks,
Miquèl
