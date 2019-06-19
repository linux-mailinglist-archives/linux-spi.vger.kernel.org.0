Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF7C54B3AA
	for <lists+linux-spi@lfdr.de>; Wed, 19 Jun 2019 10:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731072AbfFSIJT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Wed, 19 Jun 2019 04:09:19 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:54193 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbfFSIJT (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 19 Jun 2019 04:09:19 -0400
X-Originating-IP: 90.88.23.150
Received: from xps13 (aaubervilliers-681-1-81-150.w90-88.abo.wanadoo.fr [90.88.23.150])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 726551BF203;
        Wed, 19 Jun 2019 08:09:05 +0000 (UTC)
Date:   Wed, 19 Jun 2019 10:09:04 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     masonccyang@mxic.com.tw
Cc:     "Boris Brezillon" <boris.brezillon@collabora.com>,
        bbrezillon@kernel.org, broonie@kernel.org,
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
Message-ID: <20190619100904.6b759377@xps13>
In-Reply-To: <OF5EAF94EB.AE31CF59-ON4825841E.002A2C38-4825841E.002C60BF@mxic.com.tw>
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
        <20190618081436.5d488320@collabora.com>
        <20190618092901.3bdd9f61@collabora.com>
        <OF5EAF94EB.AE31CF59-ON4825841E.002A2C38-4825841E.002C60BF@mxic.com.tw>
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

masonccyang@mxic.com.tw wrote on Wed, 19 Jun 2019 16:04:43 +0800:

> Hi Boris,
> 
> > 
> > Re: [PATCH v3 2/4] mtd: rawnand: Add Macronix MX25F0A NAND controller
> > 
> > On Tue, 18 Jun 2019 08:14:36 +0200
> > Boris Brezillon <boris.brezillon@collabora.com> wrote:
> >   
> > > > > > > > 
> > > > > > > > How to make all #CS keep high for NAND to enter 
> > > > > > > > low-power standby mode if driver don't use   
> "legacy.select_chip()" 
> > > > ?   
> > > > > > > 
> > > > > > > See commit 02b4a52604a4 ("mtd: rawnand: Make ->select_chip()    
> > > > optional   
> > > > > > > when ->exec_op() is implemented") which states:
> > > > > > > 
> > > > > > >         "When [->select_chip() is] not implemented, the core   
> is 
> > > > assuming   
> > > > > > >    the CS line is automatically asserted/deasserted by the   
> driver 
> > > > > > >    ->exec_op() implementation."   
> > > > > > > 
> > > > > > > Of course, the above is right only when the controller driver    
>  
> > > > supports   
> > > > > > > the ->exec_op() interface.   
> > > > > > 
> > > > > > Currently, it seems that we will get the incorrect data and   
> error
> > > > > > operation due to CS in error toggling if CS line is controlled   
> in 
> > > > > > ->exec_op().   
> > 
> > Oh, and please provide the modifications you added on top of this patch.
> > Right now we're speculating on what you've done which is definitely not
> > an efficient way to debug this sort of issues.  
> 

We really need to see the datasheet of the NAND chip which has a
problem and how this LPM mode is advertized to understand what the
chip expects and eventually how to work-around it.

> The patch is to add in beginning of ->exec_op() to control CS# low and 
> before return from ->exec_op() to control CS# High.
> i.e,.
> static in mxic_nand_exec_op( )
> {
>  cs_to_low();
> 
> 
> 
>  cs_to_high();
>  return;
> }
> 
> But for nand_onfi_detect(), 
> it calls nand_read_param_page_op() and then nand_read_data_op().
> mxic_nand_exec_op() be called twice for nand_onfi_detect()

Yes, this is expected and usually chips don't care.

> and
> driver will get incorrect ONFI parameter table data from 
> nand_read_data_op().
> 

Thanks,
Miquèl
