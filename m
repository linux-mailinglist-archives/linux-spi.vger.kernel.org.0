Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC9445F036
	for <lists+linux-spi@lfdr.de>; Fri, 26 Nov 2021 15:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344328AbhKZO45 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Fri, 26 Nov 2021 09:56:57 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:33781 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239892AbhKZOy4 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 26 Nov 2021 09:54:56 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id E6C5724000F;
        Fri, 26 Nov 2021 14:51:30 +0000 (UTC)
Date:   Fri, 26 Nov 2021 15:51:28 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>,
        <linux-mtd@lists.infradead.org>, Rob Herring <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>, Mark Brown <broonie@kernel.org>,
        <linux-spi@vger.kernel.org>,
        Xiangsheng Hou <Xiangsheng.Hou@mediatek.com>,
        Julien Su <juliensu@mxic.com.tw>,
        Jaime Liao <jaimeliao@mxic.com.tw>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 15/20] mtd: spinand: Create direct mapping
 descriptors for ECC operations
Message-ID: <20211126155128.5fba7ec0@xps13>
In-Reply-To: <20211126154706.2a528e72@collabora.com>
References: <20211126113924.310459-1-miquel.raynal@bootlin.com>
        <20211126113924.310459-16-miquel.raynal@bootlin.com>
        <20211126151352.3bdd2c1a@collabora.com>
        <20211126154223.28c71271@xps13>
        <20211126154706.2a528e72@collabora.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Boris,

boris.brezillon@collabora.com wrote on Fri, 26 Nov 2021 15:47:06 +0100:

> On Fri, 26 Nov 2021 15:42:23 +0100
> Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> 
> > > > @@ -866,6 +872,24 @@ static int spinand_create_dirmap(struct spinand_device *spinand,
> > > >  
> > > >  	spinand->dirmaps[plane].rdesc = desc;
> > > >  
> > > > +	info.op_tmpl = *spinand->op_templates.update_cache;
> > > > +	info.op_tmpl.ecc_en = true;
> > > > +	desc = devm_spi_mem_dirmap_create(&spinand->spimem->spi->dev,
> > > > +					  spinand->spimem, &info);
> > > > +	if (IS_ERR(desc))
> > > > +		return PTR_ERR(desc);
> > > > +
> > > > +	spinand->dirmaps[plane].wdesc_ecc = desc;
> > > > +
> > > > +	info.op_tmpl = *spinand->op_templates.read_cache;
> > > > +	info.op_tmpl.ecc_en = true;
> > > > +	desc = devm_spi_mem_dirmap_create(&spinand->spimem->spi->dev,
> > > > +					  spinand->spimem, &info);
> > > > +	if (IS_ERR(desc))
> > > > +		return PTR_ERR(desc);
> > > > +
> > > > +	spinand->dirmaps[plane].rdesc_ecc = desc;
> > > > +      
> > > 
> > > Direct mappings are not free (they might reserve a piece of MMIO
> > > address space depending on the spi-mem controller implementation), so
> > > I'd recommend creating those mapping only when strictly needed, that
> > > is, when dealing with a pipelined ECC.    
> > 
> > That's what I tried to do in the first place, but unfortunately the
> > direct mappings are instantiated at the time the SPI controller gets
> > probed, which happens before the NAND flash being initialized and its
> > ECC engine being picked. Hence, at this point, we don't really know what
> > engine will be used with this ECC engine. I finally gave up and ended
> > up creating 4 dirmaps (per lun). I know it's not optimal and in most
> > cases consume more address space than needed but couldn't find a
> > better solution yet :/  
> 
> Why do you have to create the ECC mappings that early? Can't you just
> create them after the ECC initialization is done? AFAICT, they won't be
> used before that anyway.

Yeah that's right, maybe we don't need them that early. I'll move
things around and try that out.

Thanks!
Miquèl
