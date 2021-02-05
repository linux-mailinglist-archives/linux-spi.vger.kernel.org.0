Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3ABB310C38
	for <lists+linux-spi@lfdr.de>; Fri,  5 Feb 2021 14:54:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbhBENx0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Fri, 5 Feb 2021 08:53:26 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:59391 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231463AbhBENvK (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 5 Feb 2021 08:51:10 -0500
X-Originating-IP: 90.89.227.234
Received: from xps13 (lfbn-tou-1-1424-234.w90-89.abo.wanadoo.fr [90.89.227.234])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 059896000D;
        Fri,  5 Feb 2021 13:50:14 +0000 (UTC)
Date:   Fri, 5 Feb 2021 14:50:13 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     zhengxunli <zhengxunli@mxic.com.tw>, <vigneshr@ti.com>,
        <juliensu@mxic.com.tw>, <ycllin@mxic.com.tw>,
        <linux-spi@vger.kernel.org>, <broonie@kernel.org>,
        <linux-mtd@lists.infradead.org>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>
Subject: Re: [PATCH v2 1/2] mtd: spi-nor: macronix: add support for Macronix
 octaflash
Message-ID: <20210205145013.26c90b8a@xps13>
In-Reply-To: <20210205133404.esqqeokhlp4askpq@ti.com>
References: <1612517808-10010-1-git-send-email-zhengxunli@mxic.com.tw>
        <1612517808-10010-2-git-send-email-zhengxunli@mxic.com.tw>
        <20210205104736.2771074c@xps13>
        <20210205133404.esqqeokhlp4askpq@ti.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Pratyush,

+Tudor, I don't know why he was'nt Cc:'ed.

Pratyush Yadav <p.yadav@ti.com> wrote on Fri, 5 Feb 2021 19:04:04 +0530:

> On 05/02/21 10:47AM, Miquel Raynal wrote:
> > Hello,
> > 
> > zhengxunli <zhengxunli@mxic.com.tw> wrote on Fri,  5 Feb 2021 17:36:47
> > +0800:
> >   
> > > The ocatflash is an xSPI compliant octal DTR flash. Add support
> > > for using it in octal DTR mode.
> > > 
> > > Enable Octal DTR mode with 20 dummy cycles to allow running at the
> > > maximum supported frequency of 200Mhz.
> > > 
> > > Try to verify the flash ID to check whether the flash memory in octal
> > > DTR mode is correct. When reading ID in OCTAL DTR mode, ID will appear
> > > in a repeated manner. ex: ID[0] = 0xc2, ID[1] = 0xc2, ID[2] = 0x94,
> > > ID[3] = 0x94... Rearrange the order so that the ID can pass.
> > > 
> > > Signed-off-by: zhengxunli <zhengxunli@mxic.com.tw>
> > > ---
> > >  drivers/mtd/spi-nor/macronix.c | 121 +++++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 121 insertions(+)
> > > 
> > > diff --git a/drivers/mtd/spi-nor/macronix.c b/drivers/mtd/spi-nor/macronix.c
> > > index 9203aba..7498978 100644
> > > --- a/drivers/mtd/spi-nor/macronix.c
> > > +++ b/drivers/mtd/spi-nor/macronix.c
> > > @@ -8,6 +8,16 @@
> > >  
> > >  #include "core.h"
> > >  
> > > +#define SPINOR_OP_RD_CR2		0x71		/* Read configuration register 2 */
> > > +#define SPINOR_OP_WR_CR2		0x72		/* Write configuration register 2 */
> > > +#define SPINOR_OP_MXIC_DTR_RD		0xee		/* Fast Read opcode in DTR mode */
> > > +#define SPINOR_REG_MXIC_CR2_MODE	0x00000000	/* For setting octal DTR mode */
> > > +#define SPINOR_REG_MXIC_OPI_DTR_EN	0x2		/* Enable Octal DTR */
> > > +#define SPINOR_REG_MXIC_OPI_DTR_DIS	0x1		/* Disable Octal DTR */
> > > +#define SPINOR_REG_MXIC_CR2_DC		0x00000300	/* For setting dummy cycles */
> > > +#define SPINOR_REG_MXIC_DC_20		0x0		/* Setting dummy cycles to 20 */
> > > +#define MXIC_MAX_DC			20		/* Maximum value of dummy cycles */
> > > +
> > >  static int
> > >  mx25l25635_post_bfpt_fixups(struct spi_nor *nor,
> > >  			    const struct sfdp_parameter_header *bfpt_header,
> > > @@ -33,6 +43,113 @@
> > >  	.post_bfpt = mx25l25635_post_bfpt_fixups,
> > >  };
> > >  
> > > +/**
> > > + * spi_nor_macronix_octal_dtr_enable() - Enable octal DTR on Macronix flashes.
> > > + * @nor:		pointer to a 'struct spi_nor'
> > > + * @enable:		whether to enable or disable Octal DTR
> > > + *
> > > + * This also sets the memory access dummy cycles to 20 to allow the flash to
> > > + * run at up to 200MHz.
> > > + *
> > > + * Return: 0 on success, -errno otherwise.
> > > + */
> > > +static int spi_nor_macronix_octal_dtr_enable(struct spi_nor *nor, bool enable)
> > > +{
> > > +	struct spi_mem_op op;
> > > +	u8 *buf = nor->bouncebuf, i;
> > > +	int ret;
> > > +
> > > +	if (enable) {
> > > +		/* Use 20 dummy cycles for memory array reads. */
> > > +		ret = spi_nor_write_enable(nor);
> > > +		if (ret)
> > > +			return ret;
> > > +
> > > +		*buf = SPINOR_REG_MXIC_DC_20;
> > > +		op = (struct spi_mem_op)
> > > +			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WR_CR2, 1),
> > > +				   SPI_MEM_OP_ADDR(4, SPINOR_REG_MXIC_CR2_DC, 1),
> > > +				   SPI_MEM_OP_NO_DUMMY,
> > > +				   SPI_MEM_OP_DATA_OUT(1, buf, 1));
> > > +
> > > +		ret = spi_mem_exec_op(nor->spimem, &op);
> > > +		if (ret)
> > > +			return ret;
> > > +
> > > +		ret = spi_nor_wait_till_ready(nor);
> > > +		if (ret)
> > > +			return ret;
> > > +
> > > +		nor->read_dummy = MXIC_MAX_DC;  
> > 
> > I am still not convinced by this constant value.  
> 
> I think a constant value is fine. This dummy cycle value reflects how 
> many cycles the master clock would go through before the flash starts 
> emitting the data. If the master (aka the controller) is running at a 
> lower frequency then those cycles go through slower, but the flash still 
> waits for them to finish before emitting data. And since the master is 
> driving the clock and the flash is just "reading" it, both remain in 
> sync.
> 
> The dummy cycles need to be set for the worst case scenario [0]. The 
> flash usually needs a minimum amount of time before it is ready to emit 
> the data. So for example if the master is at 25 MHz, the clock period is 
> longer so 8 clock cycles [1] might be long enough to exceed that minimum 
> time. But when the master is running at 200 MHz, the clock period is 
> smaller so 8 cycles might not give the flash enough time to prepare. So 
> we need to to wait at least 20 cycles [1] before emitting data.
> 
> This is what my patches do for the Cypress S28 flash. I have tested it 
> on both 25 MHz and 166 MHz with 22 dummy cycles. It is not the most 
> efficient at 25 MHz since 5 dummy cycles is all that is needed for that 
> speed, but its the best we can do right now.
> 
> [0] Since SPI NOR has no way of knowing what speed the controller is 
> running at, assume the fastest speed the flash can run at.
> [1] Hypothetical example. Don't know the actual values for this flash.

Isn't this a precious loss of time?

If there is actually no way to retrieve the actual SPI speed I fully
get your point, but I doubt it. Or at least, I think this should be
optimized.

Perhaps Mark can shed some light on this?

Thanks,
Miquèl
