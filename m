Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8390476B7C
	for <lists+linux-spi@lfdr.de>; Thu, 16 Dec 2021 09:12:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbhLPIL7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Thu, 16 Dec 2021 03:11:59 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:56583 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234769AbhLPIL7 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 16 Dec 2021 03:11:59 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 0235A6000F;
        Thu, 16 Dec 2021 08:11:53 +0000 (UTC)
Date:   Thu, 16 Dec 2021 09:11:52 +0100
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
Subject: Re: [PATCH v5 12/13] spi: mxic: Use spi_mem_generic_supports_op()
Message-ID: <20211216091152.1c6e7596@xps13>
In-Reply-To: <20211215194538.0becb14b@collabora.com>
References: <20211214114140.54629-1-miquel.raynal@bootlin.com>
        <20211214114140.54629-13-miquel.raynal@bootlin.com>
        <20211214172410.2b26c17e@collabora.com>
        <20211215184426.67fd3912@xps13>
        <20211215194538.0becb14b@collabora.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Boris,

boris.brezillon@collabora.com wrote on Wed, 15 Dec 2021 19:45:38 +0100:

> On Wed, 15 Dec 2021 18:44:26 +0100
> Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> 
> > Hi Boris,
> > 
> > boris.brezillon@collabora.com wrote on Tue, 14 Dec 2021 17:24:10 +0100:
> >   
> > > On Tue, 14 Dec 2021 12:41:39 +0100
> > > Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> > >     
> > > > This driver can be simplified a little bit by using
> > > > spi_mem_generic_supports_op() instead of the
> > > > spi_mem_default/dtr_supports_op() couple. The all_false boolean is
> > > > inverted to become a dtr boolean, which checks if at least one of the
> > > > operation member uses dtr mode. The idea behind this change is to
> > > > simplify the introduction of the pipelined ECC engine.
> > > > 
> > > > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > > > ---
> > > >  drivers/spi/spi-mxic.c | 10 +++-------
> > > >  1 file changed, 3 insertions(+), 7 deletions(-)
> > > > 
> > > > diff --git a/drivers/spi/spi-mxic.c b/drivers/spi/spi-mxic.c
> > > > index 485a7f2afb44..5e71aa630504 100644
> > > > --- a/drivers/spi/spi-mxic.c
> > > > +++ b/drivers/spi/spi-mxic.c
> > > > @@ -452,7 +452,7 @@ static ssize_t mxic_spi_mem_dirmap_write(struct spi_mem_dirmap_desc *desc,
> > > >  static bool mxic_spi_mem_supports_op(struct spi_mem *mem,
> > > >  				     const struct spi_mem_op *op)
> > > >  {
> > > > -	bool all_false;
> > > > +	struct spi_mem_controller_caps caps = {};
> > > >  
> > > >  	if (op->data.buswidth > 8 || op->addr.buswidth > 8 ||
> > > >  	    op->dummy.buswidth > 8 || op->cmd.buswidth > 8)
> > > > @@ -465,13 +465,9 @@ static bool mxic_spi_mem_supports_op(struct spi_mem *mem,
> > > >  	if (op->addr.nbytes > 7)
> > > >  		return false;
> > > >  
> > > > -	all_false = !op->cmd.dtr && !op->addr.dtr && !op->dummy.dtr &&
> > > > -		    !op->data.dtr;
> > > > +	caps.dtr = op->cmd.dtr || op->addr.dtr || op->dummy.dtr || op->data.dtr;      
> > > 
> > > Are you sure that's what you want to do? spi_mem_controller_caps is
> > > supposed to encode the controller capabilities, not whether the
> > > operation contains a DTR cycle or not. I'd expect this caps object to be
> > > statically defined, with possibly one instance per-compat if the caps
> > > depend on the HW revision.    
> > 
> > In order to keep the series easy to review I decided to go for the
> > following approach:
> > * Introduce the spi_mem_generic_supports_op_helper() which takes a
> >   capabilities structure. This helper gathers all the checks from
> >   spi_mem_default_supports_op() and spi_mem_dtr_supports_op(). These
> >   two helpers now call the new one with either a NULL pointer in the
> >   former case, or a structure with the .dtr parameter set to true in
> >   the latter.
> > * Change the API of spi_mem_default_supports_op(), this involves
> >   updating many different drivers so this change does only that in a
> >   very transparent way, with no functional changes at all. All the
> >   drivers provide a NULL parameter for the capabilities structure.
> > * Actually make use of the new parameter of
> >   spi_mem_default_supports_op() in the drivers Cadence and Macronix,
> >   which do have DTR support. This kills the spi_mem_dtr_supports_op()
> >   helper.
> > * Kill the temporary spi_mem_generic_supports_op() helper by moving
> >   all the logic back into spi_mem_default_supports_op().
> > 
> > This approach is really straightforward and easily bisectable if
> > needed.  
> 
> I don't really see the benefit of converting drivers one by one for
> such a trivial/mechanical change to be honest. After all, we're talking
> about adding a caps argument to spi_mem_default_supports_op() and
> making all existing callers pass a caps object that's zero initialized.
> I hope we can get this right in one shot...

I'm not converting them one by one, but all in one patch. One by one is
not even an option because it would completely break bisectability.
What I meant is that in a single patch, I was converting all the
drivers using spi_mem_default_supports_op() to pass a third parameter.
In *all* cases, this parameter would be NULL (because I find this
cleaner than providing empty structures for 95% of the drivers). In the
next patch, I would actually convert the users of
spi_mem_dtr_supports_op() to use spi_mem_default_supports_op() by
providing their static capabilities definition.

Thanks,
Miquèl
