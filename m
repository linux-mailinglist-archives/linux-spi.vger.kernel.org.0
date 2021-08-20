Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 963B73F2BD6
	for <lists+linux-spi@lfdr.de>; Fri, 20 Aug 2021 14:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234564AbhHTMTG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Fri, 20 Aug 2021 08:19:06 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:34983 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237921AbhHTMTD (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 20 Aug 2021 08:19:03 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 48BC224000C;
        Fri, 20 Aug 2021 12:18:24 +0000 (UTC)
Date:   Fri, 20 Aug 2021 14:18:22 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Apurva Nandan <a-nandan@ti.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, Pratyush Yadav <p.yadav@ti.com>
Subject: Re: [PATCH 11/13] mtd: spinand: Add support for Power-on-Reset
 (PoR) instruction
Message-ID: <20210820141822.03d658b8@xps13>
In-Reply-To: <403a2b26-fd95-31ab-8992-a6e6862249e6@ti.com>
References: <20210713130538.646-1-a-nandan@ti.com>
        <20210713130538.646-12-a-nandan@ti.com>
        <20210806210840.65c06b67@xps13>
        <403a2b26-fd95-31ab-8992-a6e6862249e6@ti.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Apurva,

Apurva Nandan <a-nandan@ti.com> wrote on Fri, 20 Aug 2021 17:09:07
+0530:

> Hi Miquèl,
> 
> On 07/08/21 12:38 am, Miquel Raynal wrote:
> > Hi Apurva,
> > 
> > Apurva Nandan <a-nandan@ti.com> wrote on Tue, 13 Jul 2021 13:05:36
> > +0000:
> >   
> >> Manufacturers like Gigadevice and Winbond are adding Power-on-Reset
> >> functionality in their SPI NAND flash chips. PoR instruction consists
> >> of a 66h command followed by 99h command, and is different from the FFh
> >> reset. The reset command FFh just clears the status only registers,
> >> while the PoR command erases all the configurations written to the
> >> flash and is equivalent to a power-down -> power-up cycle.
> >>
> >> Add support for the Power-on-Reset command for any flash that provides
> >> this feature.
> >>
> >> Datasheet: https://www.winbond.com/export/sites/winbond/datasheet/W35N01JW_Datasheet_Brief.pdf
> >>
> >> Signed-off-by: Apurva Nandan <a-nandan@ti.com>
> >> ---  
> > 
> > [...]
> > 				\  
> >> @@ -218,6 +230,8 @@ struct spinand_device;
> >>    * reading/programming/erasing when the RESET occurs. Since we always
> >>    * issue a RESET when the device is IDLE, 5us is selected for both initial
> >>    * and poll delay.
> >> + * Power on Reset can take max upto 500 us to complete, so sleep for 1000 us  
> > 
> > s/max upto/up to/
> >   
> 
> Okay!
> 
> >> + * to 1200 us safely.  
> > 
> > I don't really get why, if the maximum is 500, then let's wait for
> > 500us.
> >   
> 
> Generally we keep some margin from the maximum time, no?

Well, yes and no.

If you know that an operation will last Xms and have nothing else to
do, then you can take some margin if you are in a probe (called once)
but definitely not if you are in a fast path.

Otherwise the best is to have some kind of signaling but I'm not sure
you'll have one for the reset op...

> 
> >>    */
> >>   #define SPINAND_READ_INITIAL_DELAY_US	6
> >>   #define SPINAND_READ_POLL_DELAY_US	5
> >> @@ -227,6 +241,8 @@ struct spinand_device;
> >>   #define SPINAND_WRITE_POLL_DELAY_US	15
> >>   #define SPINAND_ERASE_INITIAL_DELAY_US	250
> >>   #define SPINAND_ERASE_POLL_DELAY_US	50
> >> +#define SPINAND_POR_MIN_DELAY_US	1000
> >> +#define SPINAND_POR_MAX_DELAY_US	1200  
> >>   >>   #define SPINAND_WAITRDY_TIMEOUT_MS	400
> >>   >> @@ -351,6 +367,7 @@ struct spinand_ecc_info {  
> >>   #define SPINAND_HAS_QE_BIT		BIT(0)
> >>   #define SPINAND_HAS_CR_FEAT_BIT		BIT(1)
> >>   #define SPINAND_HAS_OCTAL_DTR_BIT	BIT(2)
> >> +#define SPINAND_HAS_POR_CMD_BIT		BIT(3)  
> >>   >>   /**  
> >>    * struct spinand_ondie_ecc_conf - private SPI-NAND on-die ECC engine structure  
> > 
> > 
> > 
> > 
> > Thanks,
> > Miquèl
> > 
> > ______________________________________________________
> > Linux MTD discussion mailing list
> > http://lists.infradead.org/mailman/listinfo/linux-mtd/
> >   
> 
> Thanks,
> Apurva Nandan

Thanks,
Miquèl
