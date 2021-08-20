Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 818BA3F2E39
	for <lists+linux-spi@lfdr.de>; Fri, 20 Aug 2021 16:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240840AbhHTOip convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Fri, 20 Aug 2021 10:38:45 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:42421 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231706AbhHTOio (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 20 Aug 2021 10:38:44 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id DA099240004;
        Fri, 20 Aug 2021 14:38:03 +0000 (UTC)
Date:   Fri, 20 Aug 2021 16:38:02 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Apurva Nandan <a-nandan@ti.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, Pratyush Yadav <p.yadav@ti.com>
Subject: Re: [PATCH 08/13] mtd: spinand: Reject 8D-8D-8D op_templates if
 octal_dtr_enale() is missing in manufacturer_op
Message-ID: <20210820163802.529482dd@xps13>
In-Reply-To: <11d173f2-2011-d029-e905-a10fdd0f2b85@ti.com>
References: <20210713130538.646-1-a-nandan@ti.com>
        <20210713130538.646-9-a-nandan@ti.com>
        <20210806210146.3358a85b@xps13>
        <4d428465-59d7-6771-8344-c5090add2a06@ti.com>
        <20210820141413.6c519255@xps13>
        <11d173f2-2011-d029-e905-a10fdd0f2b85@ti.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Apurva,

Apurva Nandan <a-nandan@ti.com> wrote on Fri, 20 Aug 2021 19:24:34
+0530:

> Hi Miquèl,
> 
> On 20/08/21 5:44 pm, Miquel Raynal wrote:
> > Hi Apurva,
> > 
> > Apurva Nandan <a-nandan@ti.com> wrote on Fri, 20 Aug 2021 16:56:50
> > +0530:
> >   
> >> On 07/08/21 12:31 am, Miquel Raynal wrote:  
> >>> Hi Apurva,
> >>>
> >>> Apurva Nandan <a-nandan@ti.com> wrote on Tue, 13 Jul 2021 13:05:33
> >>> +0000:  
> >>>    >>>> The SPI NAND core doesn't know how to switch the flash to Octal DTR  
> >>>> mode (i.e. which operations to perform). If the manufacturer hasn't
> >>>> implemented the octal_dtr_enable() manufacturer_op, the SPI NAND core
> >>>> wouldn't be able to switch to 8D-8D-8D mode and will also not be able
> >>>> to run in 1S-1S-1S mode due to already selected 8D-8D-8D read/write
> >>>> cache op_templates.
> >>>>
> >>>> So, avoid choosing a Octal DTR SPI op_template for read_cache,
> >>>> write_cache and update_cache operations, if the manufacturer_op
> >>>> octal_dtr_enable() is missing.  
> >>>
> >>> After looking at your previous commit I don't see why this patch would
> >>> be needed. octal_dtr_enable() only updates the mode when it succeeds so
> >>> I don't think this patch is really needed.  
> >>>    >>  
> >> I added it to prevent any errors happening dues to a missing implementation of octal_dtr_enable() from manufacturer driver side.
> >> So, if the manufacturers skips the octal_dtr_enable() implementation, we want the spinand core to run in 1s-1s-1s mode.  
> > 
> > I still don't get the point: you fail the probe if the octal bit is
> > enabled but the manufacturer did not implement octal_dtr_enable(), so
> > how could we have issues? Maybe I am overlooking something though, but
> > this seemed completely redundant to my eyes so far.
> >   
> 
> Okay, I feel this may be redundant. This is for the case when the manufacturer has added Octal DTR read/write/update cache variants but hasn't implemented the octal_dtr_enable() method.
> 
> Without this patch, the probe would fail, if the manufacturer did not implement octal_dtr_enable(). But after using this patch, spinand can still use the chip in 1s-1s-1s mode in that case and just skip the Octal DTR op variants during the selection. And also the probe would succeed.

Unless I am overlooking something with this series applied
(with or without this patch) the possibilities are:
- no octal bit -> continue as before
- octal bit and vendor callback -> uses octal mode
- octal bit and no vendor callback -> will return an error from
spinand_init_octal_dtr_enable() which will fail the probe (patch 7)

Anyway we have a choice:
- Either we consider the tables describing chips as pure descriptions
  and we can support these chips in mode 1-1-1 (will require changes in
  your series as this is not what you support as far as I understand
  the code)
- Or we consider these tables as "what is currently supported" and in
  this case we just fail if one adds the octal bit without any callback
  implementation.

I think the latter is better for now. We can update this choice later
if needed anyway.

> 
> >>
> >> Read/write/update op variant selection happens in select_op_variant(), much before octal_dtr_enable(). So just check if there is a definition of octal_dtr_enable in manufacturer ops and then only use 8D op variants.
> >>
> >> Removing this wouldn't break anything in the current implementation.
> >> Do you think we should drop this?
> >>  
> >>>>
> >>>> Signed-off-by: Apurva Nandan <a-nandan@ti.com>
> >>>> ---
> >>>>    drivers/mtd/nand/spi/core.c | 7 ++++++-
> >>>>    1 file changed, 6 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
> >>>> index 19d8affac058..8711e887b795 100644
> >>>> --- a/drivers/mtd/nand/spi/core.c
> >>>> +++ b/drivers/mtd/nand/spi/core.c
> >>>> @@ -1028,6 +1028,8 @@ static int spinand_manufacturer_match(struct spinand_device *spinand,
> >>>>    		if (id[0] != manufacturer->id)
> >>>>    			continue;  
> >>>>    >> +		spinand->manufacturer = manufacturer;  
> >>>> +
> >>>>    		ret = spinand_match_and_init(spinand,
> >>>>    					     manufacturer->chips,
> >>>>    					     manufacturer->nchips,
> >>>> @@ -1035,7 +1037,6 @@ static int spinand_manufacturer_match(struct spinand_device *spinand,
> >>>>    		if (ret < 0)
> >>>>    			continue;  
> >>>>    >> -		spinand->manufacturer = manufacturer;  
> >>>>    		return 0;
> >>>>    	}
> >>>>    	return -ENOTSUPP;
> >>>> @@ -1097,6 +1098,10 @@ spinand_select_op_variant(struct spinand_device *spinand,
> >>>>    		unsigned int nbytes;
> >>>>    		int ret;  
> >>>>    >> +		if (spinand_op_is_octal_dtr(&op) &&  
> >>>> +		    !spinand->manufacturer->ops->octal_dtr_enable)
> >>>> +			continue;
> >>>> +
> >>>>    		nbytes = nanddev_per_page_oobsize(nand) +
> >>>>    			 nanddev_page_size(nand);  
> >>>>    > > Thanks,  
> >>> Miquèl
> >>>
> >>> ______________________________________________________
> >>> Linux MTD discussion mailing list
> >>> http://lists.infradead.org/mailman/listinfo/linux-mtd/  
> >>>    >>  
> >> Thanks,
> >> Apurva Nandan  
> > 
> > 
> > 
> > 
> > Thanks,
> > Miquèl
> >   
> 
> Thanks,
> Apurva Nandan

Thanks,
Miquèl
