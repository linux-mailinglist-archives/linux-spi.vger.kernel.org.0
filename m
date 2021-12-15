Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2562F475CF6
	for <lists+linux-spi@lfdr.de>; Wed, 15 Dec 2021 17:12:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244509AbhLOQLx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Wed, 15 Dec 2021 11:11:53 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:42439 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235029AbhLOQLx (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 15 Dec 2021 11:11:53 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 097411C000F;
        Wed, 15 Dec 2021 16:11:47 +0000 (UTC)
Date:   Wed, 15 Dec 2021 17:11:46 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Michael Walle <michael@walle.cc>,
        <linux-mtd@lists.infradead.org>, Mark Brown <broonie@kernel.org>,
        <linux-spi@vger.kernel.org>, Julien Su <juliensu@mxic.com.tw>,
        Jaime Liao <jaimeliao@mxic.com.tw>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Xiangsheng Hou <xiangsheng.hou@mediatek.com>
Subject: Re: [PATCH v5 04/13] spi: spi-mem: Create a helper to gather all
 the supports_op checks
Message-ID: <20211215171146.2697f6f5@xps13>
In-Reply-To: <20211214195315.f7wr6ao6bdma47cn@ti.com>
References: <20211214114140.54629-1-miquel.raynal@bootlin.com>
        <20211214114140.54629-5-miquel.raynal@bootlin.com>
        <20211214195315.f7wr6ao6bdma47cn@ti.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Pratyush,

p.yadav@ti.com wrote on Wed, 15 Dec 2021 01:23:17 +0530:

> Hi Miquel,
> 
> On 14/12/21 12:41PM, Miquel Raynal wrote:
> > So far we check the support for:
> > - regular operations
> > - dtr operations
> > Soon, we will also need to check the support for ECC operations.
> > 
> > As the combinatorial will increase exponentially, let's gather all the
> > checks in a single generic function which takes a capabilities structure
> > as input. This new helper is supposed to be called by the currently
> > exported functions instead of repeating a similar implementation.  
> 
> Nice! I think this is a very good idea.

Thanks!

> 
> > 
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > ---
> >  drivers/spi/spi-mem.c       | 34 +++++++++++++++++++++++++---------
> >  include/linux/spi/spi-mem.h |  8 ++++++++
> >  2 files changed, 33 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
> > index 37f4443ce9a0..4c6944d7b174 100644
> > --- a/drivers/spi/spi-mem.c
> > +++ b/drivers/spi/spi-mem.c
> > @@ -160,26 +160,42 @@ static bool spi_mem_check_buswidth(struct spi_mem *mem,
> >  	return true;
> >  }
> >  
> > +static bool spi_mem_generic_supports_op(struct spi_mem *mem,
> > +					const struct spi_mem_op *op,
> > +					struct spi_mem_controller_caps *caps)
> > +{
> > +	if (!caps->dtr) {  
> 
> Nitpick: Please turn the order of the if-else around:
> 
>   if (caps->dtr)
>     ...
>   else
>     ...

Yup

> 
> > +		if (op->cmd.dtr || op->addr.dtr ||
> > +		    op->dummy.dtr || op->data.dtr)
> > +			return false;
> > +
> > +		if (op->cmd.nbytes != 1)
> > +			return false;
> > +	} else {
> > +		if (op->cmd.nbytes != 2)
> > +			return false;
> > +	}
> > +
> > +	return spi_mem_check_buswidth(mem, op);
> > +}
> > +
> >  bool spi_mem_dtr_supports_op(struct spi_mem *mem,
> >  			     const struct spi_mem_op *op)
> >  {
> > -	if (op->cmd.nbytes != 2)
> > -		return false;
> > +	struct spi_mem_controller_caps caps = {
> > +		.dtr = true,
> > +	};
> >  
> > -	return spi_mem_check_buswidth(mem, op);
> > +	return spi_mem_generic_supports_op(mem, op, &caps);
> >  }
> >  EXPORT_SYMBOL_GPL(spi_mem_dtr_supports_op);
> >  
> >  bool spi_mem_default_supports_op(struct spi_mem *mem,
> >  				 const struct spi_mem_op *op)  
> 
> I know this would require a little bit more work from you, but can we 
> make spi_mem_default_supports_op() accept the caps as a parameter? And 
> drop spi_mem_dtr_supports_op() while we are at it? This would be a lot 
> neater I think since we won't have lots of wrapper functions lying 
> around.

Following Boris' review I planned to kill spi_mem_dtr_supports_op(). I
might as well update spi_mem_default_supports_op() so that controllers
can provide their static capacities if any.

> >  {
> > -	if (op->cmd.dtr || op->addr.dtr || op->dummy.dtr || op->data.dtr)
> > -		return false;
> > +	struct spi_mem_controller_caps caps = {};
> >  
> > -	if (op->cmd.nbytes != 1)
> > -		return false;
> > -
> > -	return spi_mem_check_buswidth(mem, op);
> > +	return spi_mem_generic_supports_op(mem, op, &caps);
> >  }
> >  EXPORT_SYMBOL_GPL(spi_mem_default_supports_op);
> >  
> > diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
> > index 85e2ff7b840d..f365efcfb719 100644
> > --- a/include/linux/spi/spi-mem.h
> > +++ b/include/linux/spi/spi-mem.h
> > @@ -220,6 +220,14 @@ static inline void *spi_mem_get_drvdata(struct spi_mem *mem)
> >  	return mem->drvpriv;
> >  }
> >  
> > +/**
> > + * struct spi_mem_controller_caps - SPI memory controller capabilities
> > + * @dtr: Supports DTR operations
> > + */
> > +struct spi_mem_controller_caps {
> > +	bool dtr;
> > +};
> > +
> >  /**
> >   * struct spi_controller_mem_ops - SPI memory operations
> >   * @adjust_op_size: shrink the data xfer of an operation to match controller's
> > -- 
> > 2.27.0
> >   
> 


Thanks,
Miquèl
