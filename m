Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95F4145F016
	for <lists+linux-spi@lfdr.de>; Fri, 26 Nov 2021 15:44:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353358AbhKZOrv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Fri, 26 Nov 2021 09:47:51 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:58267 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353445AbhKZOpv (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 26 Nov 2021 09:45:51 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id C166A240010;
        Fri, 26 Nov 2021 14:42:23 +0000 (UTC)
Date:   Fri, 26 Nov 2021 15:42:23 +0100
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
Message-ID: <20211126154223.28c71271@xps13>
In-Reply-To: <20211126151352.3bdd2c1a@collabora.com>
References: <20211126113924.310459-1-miquel.raynal@bootlin.com>
        <20211126113924.310459-16-miquel.raynal@bootlin.com>
        <20211126151352.3bdd2c1a@collabora.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Boris,

boris.brezillon@collabora.com wrote on Fri, 26 Nov 2021 15:13:52 +0100:

> On Fri, 26 Nov 2021 12:39:19 +0100
> Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> 
> > In order for pipelined ECC engines to be able to enable/disable the ECC
> > engine only when needed and avoid races when future parallel-operations
> > will be supported, we need to provide the information about the use of
> > the ECC engine in the direct mapping hooks. As direct mapping
> > configurations are meant to be static, it is best to create two new
> > mappings: one for regular 'raw' accesses and one for accesses involving
> > correction. It is up to the driver to use or not the new ECC enable
> > boolean contained in the spi-mem operation.
> > 
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > ---
> >  drivers/mtd/nand/spi/core.c | 28 ++++++++++++++++++++++++++--
> >  include/linux/mtd/spinand.h |  2 ++
> >  include/linux/spi/spi-mem.h |  3 +++  
> 
> I'd split that patch in 2: one adding the ecc_en field to spi_mem_op
> and the other one using it in spinand.

As this new spi_mem_op could not be used without the SPI-NAND changes
I decided to put everything in a single patch, but no problem, I'll
split it.

> 
> >  3 files changed, 31 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
> > index 7027c09925e2..10ccffb6bf0d 100644
> > --- a/drivers/mtd/nand/spi/core.c
> > +++ b/drivers/mtd/nand/spi/core.c
> > @@ -381,7 +381,10 @@ static int spinand_read_from_cache_op(struct spinand_device *spinand,
> >  		}
> >  	}
> >  
> > -	rdesc = spinand->dirmaps[req->pos.plane].rdesc;
> > +	if (req->mode == MTD_OPS_RAW)
> > +		rdesc = spinand->dirmaps[req->pos.plane].rdesc;
> > +	else
> > +		rdesc = spinand->dirmaps[req->pos.plane].rdesc_ecc;
> >  
> >  	while (nbytes) {
> >  		ret = spi_mem_dirmap_read(rdesc, column, nbytes, buf);
> > @@ -452,7 +455,10 @@ static int spinand_write_to_cache_op(struct spinand_device *spinand,
> >  			       req->ooblen);
> >  	}
> >  
> > -	wdesc = spinand->dirmaps[req->pos.plane].wdesc;
> > +	if (req->mode == MTD_OPS_RAW)
> > +		wdesc = spinand->dirmaps[req->pos.plane].wdesc;
> > +	else
> > +		wdesc = spinand->dirmaps[req->pos.plane].wdesc_ecc;
> >  
> >  	while (nbytes) {
> >  		ret = spi_mem_dirmap_write(wdesc, column, nbytes, buf);
> > @@ -866,6 +872,24 @@ static int spinand_create_dirmap(struct spinand_device *spinand,
> >  
> >  	spinand->dirmaps[plane].rdesc = desc;
> >  
> > +	info.op_tmpl = *spinand->op_templates.update_cache;
> > +	info.op_tmpl.ecc_en = true;
> > +	desc = devm_spi_mem_dirmap_create(&spinand->spimem->spi->dev,
> > +					  spinand->spimem, &info);
> > +	if (IS_ERR(desc))
> > +		return PTR_ERR(desc);
> > +
> > +	spinand->dirmaps[plane].wdesc_ecc = desc;
> > +
> > +	info.op_tmpl = *spinand->op_templates.read_cache;
> > +	info.op_tmpl.ecc_en = true;
> > +	desc = devm_spi_mem_dirmap_create(&spinand->spimem->spi->dev,
> > +					  spinand->spimem, &info);
> > +	if (IS_ERR(desc))
> > +		return PTR_ERR(desc);
> > +
> > +	spinand->dirmaps[plane].rdesc_ecc = desc;
> > +  
> 
> Direct mappings are not free (they might reserve a piece of MMIO
> address space depending on the spi-mem controller implementation), so
> I'd recommend creating those mapping only when strictly needed, that
> is, when dealing with a pipelined ECC.

That's what I tried to do in the first place, but unfortunately the
direct mappings are instantiated at the time the SPI controller gets
probed, which happens before the NAND flash being initialized and its
ECC engine being picked. Hence, at this point, we don't really know what
engine will be used with this ECC engine. I finally gave up and ended
up creating 4 dirmaps (per lun). I know it's not optimal and in most
cases consume more address space than needed but couldn't find a
better solution yet :/

> > diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
> > index 6988956b8492..3aa28240a77f 100644
> > --- a/include/linux/mtd/spinand.h
> > +++ b/include/linux/mtd/spinand.h
> > @@ -389,6 +389,8 @@ struct spinand_info {
> >  struct spinand_dirmap {
> >  	struct spi_mem_dirmap_desc *wdesc;
> >  	struct spi_mem_dirmap_desc *rdesc;
> > +	struct spi_mem_dirmap_desc *wdesc_ecc;
> > +	struct spi_mem_dirmap_desc *rdesc_ecc;
> >  };
> >  
> >  /**
> > diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
> > index 85e2ff7b840d..3be594be24c0 100644
> > --- a/include/linux/spi/spi-mem.h
> > +++ b/include/linux/spi/spi-mem.h
> > @@ -94,6 +94,7 @@ enum spi_mem_data_dir {
> >   *		 operation does not involve transferring data
> >   * @data.buf.in: input buffer (must be DMA-able)
> >   * @data.buf.out: output buffer (must be DMA-able)
> > + * @ecc_en: error correction is required
> >   */
> >  struct spi_mem_op {
> >  	struct {
> > @@ -126,6 +127,8 @@ struct spi_mem_op {
> >  			const void *out;
> >  		} buf;
> >  	} data;
> > +
> > +	bool ecc_en;
> >  };
> >  
> >  #define SPI_MEM_OP(__cmd, __addr, __dummy, __data)		\  
> 

Thanks,
Miquèl
