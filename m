Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7D88483F1B
	for <lists+linux-spi@lfdr.de>; Tue,  4 Jan 2022 10:24:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbiADJYj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Tue, 4 Jan 2022 04:24:39 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:38451 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiADJYi (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 4 Jan 2022 04:24:38 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id E0A671C0002;
        Tue,  4 Jan 2022 09:24:34 +0000 (UTC)
Date:   Tue, 4 Jan 2022 10:24:33 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>,
        <linux-mtd@lists.infradead.org>, Mark Brown <broonie@kernel.org>,
        <linux-spi@vger.kernel.org>, Julien Su <juliensu@mxic.com.tw>,
        Jaime Liao <jaimeliao@mxic.com.tw>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Xiangsheng Hou <xiangsheng.hou@mediatek.com>
Subject: Re: [PATCH v9 06/13] spi: spi-mem: Add an ecc parameter to the
 spi_mem_op structure
Message-ID: <20220104102433.0ad3bb2c@xps13>
In-Reply-To: <20220104100230.1076beed@collabora.com>
References: <20220104083631.40776-1-miquel.raynal@bootlin.com>
        <20220104083631.40776-7-miquel.raynal@bootlin.com>
        <20220104100230.1076beed@collabora.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello Boris,

boris.brezillon@collabora.com wrote on Tue, 4 Jan 2022 10:02:30 +0100:

> On Tue,  4 Jan 2022 09:36:24 +0100
> Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> 
> > Soon the SPI-NAND core will need a way to request a SPI controller to
> > enable ECC support for a given operation. This is because of the
> > pipelined integration of certain ECC engines, which are directly managed
> > by the SPI controller itself.
> > 
> > Introduce a spi_mem_op additional field for this purpose: ecc.
> > 
> > So far this field is left unset and checked to be false by all
> > the SPI controller drivers in their ->supports_op() hook, as they all
> > call spi_mem_default_supports_op().
> > 
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > Acked-by: Pratyush Yadav <p.yadav@ti.com>
> > ---
> >  drivers/spi/spi-mem.c       | 5 +++++
> >  include/linux/spi/spi-mem.h | 5 +++++
> >  2 files changed, 10 insertions(+)
> > 
> > diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
> > index ed966d8129eb..f38ac31961c9 100644
> > --- a/drivers/spi/spi-mem.c
> > +++ b/drivers/spi/spi-mem.c
> > @@ -178,6 +178,11 @@ bool spi_mem_default_supports_op(struct spi_mem *mem,
> >  			return false;
> >  	}
> >  
> > +	if (op->data.ecc) {
> > +		if (!spi_mem_controller_is_capable(ctlr, ecc))
> > +			return false;
> > +	}  
> 
> Nit:
> 
> 	if (op->data.ecc &&
> 	    !spi_mem_controller_is_capable(ctlr, ecc))
> 		return false;
> 

Actually I wanted on purpose to distinguish the different checks:

if (dtr) {
	do something here;
}

if (ecc) {
	do something else;
}

return;

and in order to keep them tidy I used independent if statements within
each of these :)

> > +
> >  	return spi_mem_check_buswidth(mem, op);
> >  }
> >  EXPORT_SYMBOL_GPL(spi_mem_default_supports_op);
> > diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
> > index 4a1bfe689872..051050b40309 100644
> > --- a/include/linux/spi/spi-mem.h
> > +++ b/include/linux/spi/spi-mem.h
> > @@ -89,6 +89,7 @@ enum spi_mem_data_dir {
> >   * @dummy.dtr: whether the dummy bytes should be sent in DTR mode or not
> >   * @data.buswidth: number of IO lanes used to send/receive the data
> >   * @data.dtr: whether the data should be sent in DTR mode or not
> > + * @data.ecc: whether error correction is required or not
> >   * @data.dir: direction of the transfer
> >   * @data.nbytes: number of data bytes to send/receive. Can be zero if the
> >   *		 operation does not involve transferring data
> > @@ -119,6 +120,7 @@ struct spi_mem_op {
> >  	struct {
> >  		u8 buswidth;
> >  		u8 dtr : 1;
> > +		u8 ecc : 1;
> >  		enum spi_mem_data_dir dir;
> >  		unsigned int nbytes;
> >  		union {
> > @@ -126,6 +128,7 @@ struct spi_mem_op {
> >  			const void *out;
> >  		} buf;
> >  	} data;
> > +
> >  };
> >  
> >  #define SPI_MEM_OP(__cmd, __addr, __dummy, __data)		\
> > @@ -288,9 +291,11 @@ struct spi_controller_mem_ops {
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
> >  #define spi_mem_controller_is_capable(ctlr, cap)	\  
> 


Thanks,
Miquèl
