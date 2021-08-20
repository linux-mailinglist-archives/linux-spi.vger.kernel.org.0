Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E29E43F2BB7
	for <lists+linux-spi@lfdr.de>; Fri, 20 Aug 2021 14:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238215AbhHTMHh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Fri, 20 Aug 2021 08:07:37 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:48089 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237764AbhHTMHh (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 20 Aug 2021 08:07:37 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 9DFEF1BF207;
        Fri, 20 Aug 2021 12:06:57 +0000 (UTC)
Date:   Fri, 20 Aug 2021 14:06:56 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Apurva Nandan <a-nandan@ti.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, Pratyush Yadav <p.yadav@ti.com>
Subject: Re: [PATCH 04/13] mtd: spinand: Fix odd byte addr and data phase in
 read/write reg op and write VCR op for Octal DTR mode
Message-ID: <20210820140656.72819d90@xps13>
In-Reply-To: <a0decde4-c68e-9494-9ce5-97d60916f9ad@ti.com>
References: <20210713130538.646-1-a-nandan@ti.com>
        <20210713130538.646-5-a-nandan@ti.com>
        <20210806204334.5fedea42@xps13>
        <a0decde4-c68e-9494-9ce5-97d60916f9ad@ti.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Apurva,

Apurva Nandan <a-nandan@ti.com> wrote on Fri, 20 Aug 2021 15:57:36
+0530:

> Hi Miquèl,
> 
> On 07/08/21 12:13 am, Miquel Raynal wrote:
> > Hi Apurva,
> > 
> > Apurva Nandan <a-nandan@ti.com> wrote on Tue, 13 Jul 2021 13:05:29
> > +0000:
> >   
> >> In Octal DTR SPI mode, 2 bytes of data gets transmitted over one clock
> >> cycle, and half-cycle instruction phases aren't supported yet. So,
> >> every DTR spi_mem_op needs to have even nbytes in all phases for
> >> non-erratic behaviour from the SPI controller.
> >>
> >> The odd length cmd and dummy phases get handled by spimem_setup_op()
> >> but the odd length address and data phases need to be handled according
> >> to the use case. For example in Octal DTR mode, read register operation
> >> has one byte long address and data phase. So it needs to extend it
> >> by adding a suitable extra byte in addr and reading 2 bytes of data,
> >> discarding the second byte.
> >>
> >> Handle address and data phases for Octal DTR mode in read/write
> >> register and write volatile configuration register operations
> >> by adding a suitable extra byte in the address and data phase.
> >>
> >> Create spimem_setup_reg_op() helper function to ease setting up
> >> read/write register operations in other functions, e.g. wait().
> >>
> >> Signed-off-by: Apurva Nandan <a-nandan@ti.com>
> >> ---
> >>   drivers/mtd/nand/spi/core.c | 26 +++++++++++++++++++++-----
> >>   1 file changed, 21 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
> >> index 2e59faecc8f5..a5334ad34f96 100644
> >> --- a/drivers/mtd/nand/spi/core.c
> >> +++ b/drivers/mtd/nand/spi/core.c
> >> @@ -65,12 +65,27 @@ static void spinand_setup_op(const struct spinand_device *spinand,
> >>   	}
> >>   }  
> >>   >> +static void spinand_setup_reg_op(const struct spinand_device *spinand,  
> >> +				 struct spi_mem_op *op)  
> > 
> > Same remark about the naming. In fact I believe we could have this
> > logic in _setup_op() (or whatever its name) and add a specific
> > parameter for it?
> >   
> 
> Okay, I will add a parameter in argument and include this logic in _setup_op().
> 
> >> +{
> >> +	if (spinand->reg_proto == SPINAND_OCTAL_DTR) {
> >> +		/*
> >> +		 * Assigning same first and second byte will result in constant
> >> +		 * bits on ths SPI bus between positive and negative clock edges  
> > 
> >                             the
> >   
> 
> Ok.
> 
> >> +		 */
> >> +		op->addr.val = (op->addr.val << 8) | op->addr.val;  
> > 
> > I am not sure to understand what you do here?
> >   
> 
> In Octal DTR mode, 2 bytes of data are sent in a clock cycle. So, we need to append one extra byte when sending a single byte. This extra byte would be sent on the negative edge.
> 
> It will make sense to keep both the bytes same, as when it will be set on the SPI pins, the bits on the SPI IO ports will remain constant between the positive and negative edges (as 1 complete byte is set in one clock edge in MSB order). There are no restrictions by the manufacturers on this, the relevant address byte needs to be on positive edge and second byte on negative edge is don't care.

I was bothered by the shift but actually my head was mixing with the
raw NAND core where these addresses are in an array but here it is a
u64 which is then fine.

(I will continue answering probably next week)

Thanks,
Miquèl
