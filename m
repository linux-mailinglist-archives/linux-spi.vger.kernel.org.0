Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8123A47BDCA
	for <lists+linux-spi@lfdr.de>; Tue, 21 Dec 2021 10:58:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbhLUJ6H convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Tue, 21 Dec 2021 04:58:07 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:54127 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231430AbhLUJ6G (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 21 Dec 2021 04:58:06 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 3659D24000F;
        Tue, 21 Dec 2021 09:58:04 +0000 (UTC)
Date:   Tue, 21 Dec 2021 10:58:03 +0100
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
Subject: Re: [PATCH v7 06/14] spi: spi-mem: Kill the
 spi_mem_dtr_supports_op() helper
Message-ID: <20211221105803.1596cf89@xps13>
In-Reply-To: <20211220185840.ox5hs44hej6nhkxo@ti.com>
References: <20211217161654.367782-1-miquel.raynal@bootlin.com>
        <20211217161654.367782-7-miquel.raynal@bootlin.com>
        <20211220185840.ox5hs44hej6nhkxo@ti.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Pratyush,

p.yadav@ti.com wrote on Tue, 21 Dec 2021 00:28:42 +0530:

> On 17/12/21 05:16PM, Miquel Raynal wrote:
> > Now that spi_mem_default_supports_op() has access to the static
> > controller capabilities (related to memory operations), and now that
> > these capabilities have been filled by the impacted controllers, there
> > is no need for a specific helper checking only DTR operations, so let's
> > just kill spi_mem_dtr_supports_op() and simply use
> > spi_mem_default_supports_op() instead.
> > 
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > ---
> >  drivers/spi/spi-cadence-quadspi.c |  5 +----
> >  drivers/spi/spi-mem.c             | 10 ----------
> >  drivers/spi/spi-mxic.c            | 10 +---------
> >  include/linux/spi/spi-mem.h       | 11 -----------
> >  4 files changed, 2 insertions(+), 34 deletions(-)
> > 
> > diff --git a/drivers/spi/spi-mxic.c b/drivers/spi/spi-mxic.c
> > index e137b1ec85d4..67d05ee8d6a0 100644
> > --- a/drivers/spi/spi-mxic.c
> > +++ b/drivers/spi/spi-mxic.c
> > @@ -335,8 +335,6 @@ static int mxic_spi_data_xfer(struct mxic_spi *mxic, const void *txbuf,
> >  static bool mxic_spi_mem_supports_op(struct spi_mem *mem,
> >  				     const struct spi_mem_op *op)
> >  {
> > -	bool all_false;
> > -
> >  	if (op->data.buswidth > 8 || op->addr.buswidth > 8 ||
> >  	    op->dummy.buswidth > 8 || op->cmd.buswidth > 8)
> >  		return false;
> > @@ -348,13 +346,7 @@ static bool mxic_spi_mem_supports_op(struct spi_mem *mem,
> >  	if (op->addr.nbytes > 7)
> >  		return false;
> >  
> > -	all_false = !op->cmd.dtr && !op->addr.dtr && !op->dummy.dtr &&
> > -		    !op->data.dtr;
> > -
> > -	if (all_false)
> > -		return spi_mem_default_supports_op(mem, op);
> > -	else
> > -		return spi_mem_dtr_supports_op(mem, op);
> > +	return spi_mem_default_supports_op(mem, op);  
> 
> Does this controller support mixed DTR modes? If it doesn't then it 
> should reject mixed DTR ops before calling 
> spi_mem_default_supports_op(). Anyway, the current driver doesn't check 
> for it either so this change does not make anything worse at the very 
> least.

The Cadence SPI driver does something like:

all_true = cmd.dtr && addr.dtr ...;
all_false = !cmd.dtr && !addr.dtr ...;
if (!all_true || !all_false)
	return false;

This basically rules out any mixed DTR operation.

I believe Macronix code is inspired from this function, but they
intentionally dropped the all_true check, making the situation boolean:
either there is at least one DTR op, or there is none. So I believe
this was done on purpose and this controller supports mixed DTR ops.

> Reviewed-by: Pratyush Yadav <p.yadav@ti.com>

Thanks,
Miquèl
