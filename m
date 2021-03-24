Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAEF634732D
	for <lists+linux-spi@lfdr.de>; Wed, 24 Mar 2021 09:05:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232459AbhCXIFJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 24 Mar 2021 04:05:09 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:48412 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbhCXIEt (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 24 Mar 2021 04:04:49 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12O84T2N043735;
        Wed, 24 Mar 2021 03:04:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1616573069;
        bh=6H1aesmlYIQY1gMDqIA98xvXLO/tQxyI/+0fx/1If18=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=iWMQE982gdUcdheAQLJxDlHjxAv1ou2IO0quK9du4FH4OMxiWlf+HRSLXmObjPPbn
         FHVEltI4d4Bbi0ivBZqC9dv5Jpo7bLeF3q9BRtNDdy9U+pEajljPDXQ56zSY+ARuAO
         Urug7YBC0vC0p5a2fjE69YmlBamXW0lehW8Jzmik=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12O84TAi014287
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 24 Mar 2021 03:04:29 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 24
 Mar 2021 03:04:29 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 24 Mar 2021 03:04:29 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12O84S16050686;
        Wed, 24 Mar 2021 03:04:28 -0500
Date:   Wed, 24 Mar 2021 13:34:27 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Michael Walle <michael@walle.cc>
CC:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>, <linux-spi@vger.kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: Re: [RFC PATCH 2/6] mtd: spi-nor: core: consolidate read op creation
Message-ID: <20210324080425.c4ospw4p6w7lrjok@ti.com>
References: <20210311191216.7363-1-p.yadav@ti.com>
 <20210311191216.7363-3-p.yadav@ti.com>
 <77a4d73b65bd371e93538886038f1acb@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <77a4d73b65bd371e93538886038f1acb@walle.cc>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 24/03/21 12:17AM, Michael Walle wrote:
> Am 2021-03-11 20:12, schrieb Pratyush Yadav:
> > Currently the spi_mem_op to read from the flash is used in two places:
> > spi_nor_create_read_dirmap() and spi_nor_spimem_read_data(). In a later
> > commit this number will increase to three. Instead of repeating the same
> > code thrice, add a function that returns a template of the read op. The
> > callers can then fill in the details like address, data length, data
> > buffer location.
> > 
> > Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> > ---
> >  drivers/mtd/spi-nor/core.c | 62 ++++++++++++++++++++------------------
> >  1 file changed, 32 insertions(+), 30 deletions(-)
> > 
> > diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> > index 4a315cb1c4db..88888df009f0 100644
> > --- a/drivers/mtd/spi-nor/core.c
> > +++ b/drivers/mtd/spi-nor/core.c
> > @@ -183,6 +183,33 @@ static int spi_nor_controller_ops_erase(struct
> > spi_nor *nor, loff_t offs)
> >  	return nor->controller_ops->erase(nor, offs);
> >  }
> > 
> > +/**
> > + * spi_nor_spimem_get_read_op() - return a template for the spi_mem_op
> > used for
> > + *                                reading data from the flash via
> > spi-mem.
> > + * @nor:        pointer to 'struct spi_nor'
> > + *
> > + * Return: A template of the 'struct spi_mem_op' for used for reading
> > data from
> > + * the flash. The caller is expected to fill in the address, data
> > length, and
> > + * the data buffer.
> > + */
> > +static struct spi_mem_op spi_nor_spimem_get_read_op(struct spi_nor
> > *nor)
> > +{
> > +	struct spi_mem_op op =
> > +		SPI_MEM_OP(SPI_MEM_OP_CMD(nor->read_opcode, 0),
> > +			   SPI_MEM_OP_ADDR(nor->addr_width, 0, 0),
> > +			   SPI_MEM_OP_DUMMY(nor->read_dummy, 0),
> > +			   SPI_MEM_OP_DATA_IN(1, NULL, 0));
> > +
> > +	spi_nor_spimem_setup_op(nor, &op, nor->read_proto);
> > +
> > +	/* convert the dummy cycles to the number of bytes */
> > +	op.dummy.nbytes = (nor->read_dummy * op.dummy.buswidth) / 8;
> > +	if (spi_nor_protocol_is_dtr(nor->read_proto))
> > +		op.dummy.nbytes *= 2;
> > +
> > +	return op;
> > +}
> > +
> >  /**
> >   * spi_nor_spimem_read_data() - read data from flash's memory region
> > via
> >   *                              spi-mem
> > @@ -196,21 +223,14 @@ static int spi_nor_controller_ops_erase(struct
> > spi_nor *nor, loff_t offs)
> >  static ssize_t spi_nor_spimem_read_data(struct spi_nor *nor, loff_t
> > from,
> >  					size_t len, u8 *buf)
> >  {
> > -	struct spi_mem_op op =
> > -		SPI_MEM_OP(SPI_MEM_OP_CMD(nor->read_opcode, 0),
> > -			   SPI_MEM_OP_ADDR(nor->addr_width, from, 0),
> > -			   SPI_MEM_OP_DUMMY(nor->read_dummy, 0),
> > -			   SPI_MEM_OP_DATA_IN(len, buf, 0));
> > +	struct spi_mem_op op = spi_nor_spimem_get_read_op(nor);
> >  	bool usebouncebuf;
> >  	ssize_t nbytes;
> >  	int error;
> > 
> > -	spi_nor_spimem_setup_op(nor, &op, nor->read_proto);
> > -
> > -	/* convert the dummy cycles to the number of bytes */
> > -	op.dummy.nbytes = (nor->read_dummy * op.dummy.buswidth) / 8;
> > -	if (spi_nor_protocol_is_dtr(nor->read_proto))
> > -		op.dummy.nbytes *= 2;
> > +	op.addr.val = from;
> > +	op.data.nbytes = len;
> > +	op.data.buf.in = buf;
> > 
> >  	usebouncebuf = spi_nor_spimem_bounce(nor, &op);
> > 
> > @@ -3581,28 +3601,10 @@ EXPORT_SYMBOL_GPL(spi_nor_scan);
> >  static int spi_nor_create_read_dirmap(struct spi_nor *nor)
> >  {
> >  	struct spi_mem_dirmap_info info = {
> > -		.op_tmpl = SPI_MEM_OP(SPI_MEM_OP_CMD(nor->read_opcode, 0),
> > -				      SPI_MEM_OP_ADDR(nor->addr_width, 0, 0),
> > -				      SPI_MEM_OP_DUMMY(nor->read_dummy, 0),
> > -				      SPI_MEM_OP_DATA_IN(0, NULL, 0)),
> > +		.op_tmpl = spi_nor_spimem_get_read_op(nor),
> >  		.offset = 0,
> >  		.length = nor->mtd.size,
> >  	};
> > -	struct spi_mem_op *op = &info.op_tmpl;
> > -
> > -	spi_nor_spimem_setup_op(nor, op, nor->read_proto);
> > -
> > -	/* convert the dummy cycles to the number of bytes */
> > -	op->dummy.nbytes = (nor->read_dummy * op->dummy.buswidth) / 8;
> > -	if (spi_nor_protocol_is_dtr(nor->read_proto))
> > -		op->dummy.nbytes *= 2;
> > -
> > -	/*
> > -	 * Since spi_nor_spimem_setup_op() only sets buswidth when the number
> > -	 * of data bytes is non-zero, the data buswidth won't be set here. So,
> > -	 * do it explicitly.
> > -	 */
> > -	op->data.buswidth = spi_nor_get_protocol_data_nbits(nor->read_proto);
> 
> I guess this isn't needed anymore because spi_nor_spimem_get_read_op() uses
> a
> data length of 1, right?

Yes.

> 
> > 
> >  	nor->dirmap.rdesc = devm_spi_mem_dirmap_create(nor->dev, nor->spimem,
> >  						       &info);
> 
> -michael

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
