Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1D8F47C51A
	for <lists+linux-spi@lfdr.de>; Tue, 21 Dec 2021 18:37:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233723AbhLURhe convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Tue, 21 Dec 2021 12:37:34 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:59525 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231610AbhLURhd (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 21 Dec 2021 12:37:33 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id C09A86000B;
        Tue, 21 Dec 2021 17:37:29 +0000 (UTC)
Date:   Tue, 21 Dec 2021 18:37:28 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Mark Brown <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Michael Walle <michael@walle.cc>,
        <linux-mtd@lists.infradead.org>, Julien Su <juliensu@mxic.com.tw>,
        Jaime Liao <jaimeliao@mxic.com.tw>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Boris Brezillon <boris.brezillon@collabora.com>
Subject: Re: [PATCH v7 07/14] spi: spi-mem: Add an ecc_en parameter to the
 spi_mem_op structure
Message-ID: <20211221183728.6600aae4@xps13>
In-Reply-To: <20211220190227.oqvpcfrro32ic32b@ti.com>
References: <20211217161654.367782-1-miquel.raynal@bootlin.com>
        <20211217161654.367782-8-miquel.raynal@bootlin.com>
        <20211220190227.oqvpcfrro32ic32b@ti.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Pratyush,

p.yadav@ti.com wrote on Tue, 21 Dec 2021 00:32:29 +0530:

> On 17/12/21 05:16PM, Miquel Raynal wrote:
> > Soon the SPI-NAND core will need a way to request a SPI controller to
> > enable ECC support for a given operation. This is because of the
> > pipelined integration of certain ECC engines, which are directly managed
> > by the SPI controller itself.
> > 
> > Introduce a spi_mem_op additional field for this purpose: ecc_en.
> > 
> > So far this field is left unset and checked to be false by all
> > the SPI controller drivers in their ->supports_op() hook, as they all
> > call spi_mem_default_supports_op().
> > 
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > ---
> >  drivers/spi/spi-mem.c       | 5 +++++
> >  include/linux/spi/spi-mem.h | 5 +++++
> >  2 files changed, 10 insertions(+)
> > 
> > diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
> > index cfe1c99db5f3..94758e7e747d 100644
> > --- a/drivers/spi/spi-mem.c
> > +++ b/drivers/spi/spi-mem.c
> > @@ -178,6 +178,11 @@ bool spi_mem_default_supports_op(struct spi_mem *mem,
> >  			return false;
> >  	}
> >  
> > +	if (op->ecc_en) {
> > +		if (!spi_mem_controller_is_capable(ctlr, ecc))
> > +			return false;
> > +	}
> > +
> >  	return spi_mem_check_buswidth(mem, op);
> >  }
> >  EXPORT_SYMBOL_GPL(spi_mem_default_supports_op);
> > diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
> > index d7787c8f3746..e9238a858109 100644
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
> 
> ECC should only concern the data phase right? Would it make more sense 
> to move this field under data?
> 
> Anyway, I don't know much about NAND or ECC so either way,

I've moved the field to the data struct because it makes indeed more
sense. I've also changed the type and name to "u8 ecc : 1;" to match
the style used for the dtr parameter.

> 
> Acked-by: Pratyush Yadav <p.yadav@ti.com>
> 
> >  };
> >  
> >  #define SPI_MEM_OP(__cmd, __addr, __dummy, __data)		\
> > @@ -223,9 +226,11 @@ static inline void *spi_mem_get_drvdata(struct spi_mem *mem)
> >  /**
> >   * struct spi_controller_mem_caps - SPI memory controller capabilities
> >   * @dtr: Supports DTR operations
> > + * @ecc: Supports operations with error correction
> >   */
> >  struct spi_controller_mem_caps {
> >  	bool dtr;
> > +	bool ecc;
> >  };
> >  
> >  #define spi_mem_controller_is_capable(ctlr, cap)		\
> > -- 
> > 2.27.0
> >   
> 


Thanks,
Miquèl
