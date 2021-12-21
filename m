Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7B947BE0A
	for <lists+linux-spi@lfdr.de>; Tue, 21 Dec 2021 11:16:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbhLUKQ0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Tue, 21 Dec 2021 05:16:26 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:33591 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbhLUKQZ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 21 Dec 2021 05:16:25 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 9179B6000C;
        Tue, 21 Dec 2021 10:16:21 +0000 (UTC)
Date:   Tue, 21 Dec 2021 11:16:20 +0100
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
Subject: Re: [PATCH v7 04/14] spi: cadence: Provide a capability structure
Message-ID: <20211221111605.352285f5@xps13>
In-Reply-To: <20211220185515.wujhgn66mnwns7bw@ti.com>
References: <20211217161654.367782-1-miquel.raynal@bootlin.com>
        <20211217161654.367782-5-miquel.raynal@bootlin.com>
        <20211220185515.wujhgn66mnwns7bw@ti.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Pratyush,

p.yadav@ti.com wrote on Tue, 21 Dec 2021 00:25:18 +0530:

> > Subject: [PATCH v7 04/14] spi: cadence: Provide a capability structure  
> 
> s/cadence/cadence-quadspi/

Right.

> 
> On 17/12/21 05:16PM, Miquel Raynal wrote:
> > This controller has DTR support, so advertize it with a capability now
> > that the spi_controller_mem_ops structure contains this new field. This
> > will later be used by the core to discriminate whether an operation is
> > supported or not, in a more generic way than having different helpers.
> > 
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > ---
> >  drivers/spi/spi-cadence-quadspi.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
> > index 101cc71bffa7..98e0cc4236e3 100644
> > --- a/drivers/spi/spi-cadence-quadspi.c
> > +++ b/drivers/spi/spi-cadence-quadspi.c
> > @@ -1388,10 +1388,15 @@ static const char *cqspi_get_name(struct spi_mem *mem)
> >  	return devm_kasprintf(dev, GFP_KERNEL, "%s.%d", dev_name(dev), mem->spi->chip_select);
> >  }
> >  
> > +static const struct spi_controller_mem_caps cqspi_mem_caps = {
> > +	.dtr = true,
> > +};
> > +
> >  static const struct spi_controller_mem_ops cqspi_mem_ops = {
> >  	.exec_op = cqspi_exec_mem_op,
> >  	.get_name = cqspi_get_name,
> >  	.supports_op = cqspi_supports_mem_op,
> > +	.caps = &cqspi_mem_caps,  
> 
> I just noticed you put it under struct spi_mem_ops, not under struct 
> spi_mem. This is not an operation per se so wouldn't it be better if it 
> is moved to struct spi_mem?

I had a hard time taking a decision but my conclusion was that these
caps are static controller capabilities and exclusively tight to the
controller. The spi_mem structure defines a SPI peripheral. The
spi_mem_ops structure is the only spi-mem related field of the
spi-controller structure. I could have added my own field there but
as these caps are only meant to be used by the spi_mem_ops anyway
(exclusively ->supports_op() for now), it seemed to be a good location,
at least better than the spi-mem structure.

> Anyway, the change itself looks good to me. The cqspi_supports_mem_op()
> already checks for mixed DTR modes so we should be good.

Yep!

> 
> >  };
> >  
> >  static int cqspi_setup_flash(struct cqspi_st *cqspi)
> > -- 
> > 2.27.0
> >   
> 


Thanks,
Miquèl
