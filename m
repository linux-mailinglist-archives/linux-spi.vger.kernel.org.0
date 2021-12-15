Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 157BF4760FC
	for <lists+linux-spi@lfdr.de>; Wed, 15 Dec 2021 19:45:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234562AbhLOSpo (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 15 Dec 2021 13:45:44 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:36978 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232870AbhLOSpn (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 15 Dec 2021 13:45:43 -0500
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 0B0591F458B8;
        Wed, 15 Dec 2021 18:45:42 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1639593942; bh=dVQ+/+gYZ8IQGW/aj4iUhJT9IAnBcvhiGh388cAq+c0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eTBNWyPe4FNZeKpzsvgPrDC6p6L8GwavO7RgC0A3kCDT3hRtfCpScY/aBEvle8dsm
         3moN8PWPMVdNvm2AJ2OLram6TXrcW4No6bZXNc/oNu0UanwykU7ml2R0o1ZkRFm/su
         xQFGQeYWZAbHPHsboenmTfV2Xib5ocyyI+zDuANOFT0WbvoIXrTfHA/nSVNx/sQlbV
         CFLf9Th+4jhJj5YBNpGQMscPO4+At7cd9rekbKqMvLzy2NIZUfGJS7D4qflCFnbkBv
         6QUcXhelHYKXI2cvTOU2vrY+pNs1RvIekMBAskQukCEx6SzpqPu8XgSSQdb/cIuMAO
         auRH0lKoWdI8w==
Date:   Wed, 15 Dec 2021 19:45:38 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
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
Message-ID: <20211215194538.0becb14b@collabora.com>
In-Reply-To: <20211215184426.67fd3912@xps13>
References: <20211214114140.54629-1-miquel.raynal@bootlin.com>
        <20211214114140.54629-13-miquel.raynal@bootlin.com>
        <20211214172410.2b26c17e@collabora.com>
        <20211215184426.67fd3912@xps13>
Organization: Collabora
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 15 Dec 2021 18:44:26 +0100
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> Hi Boris,
> 
> boris.brezillon@collabora.com wrote on Tue, 14 Dec 2021 17:24:10 +0100:
> 
> > On Tue, 14 Dec 2021 12:41:39 +0100
> > Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> >   
> > > This driver can be simplified a little bit by using
> > > spi_mem_generic_supports_op() instead of the
> > > spi_mem_default/dtr_supports_op() couple. The all_false boolean is
> > > inverted to become a dtr boolean, which checks if at least one of the
> > > operation member uses dtr mode. The idea behind this change is to
> > > simplify the introduction of the pipelined ECC engine.
> > > 
> > > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > > ---
> > >  drivers/spi/spi-mxic.c | 10 +++-------
> > >  1 file changed, 3 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/drivers/spi/spi-mxic.c b/drivers/spi/spi-mxic.c
> > > index 485a7f2afb44..5e71aa630504 100644
> > > --- a/drivers/spi/spi-mxic.c
> > > +++ b/drivers/spi/spi-mxic.c
> > > @@ -452,7 +452,7 @@ static ssize_t mxic_spi_mem_dirmap_write(struct spi_mem_dirmap_desc *desc,
> > >  static bool mxic_spi_mem_supports_op(struct spi_mem *mem,
> > >  				     const struct spi_mem_op *op)
> > >  {
> > > -	bool all_false;
> > > +	struct spi_mem_controller_caps caps = {};
> > >  
> > >  	if (op->data.buswidth > 8 || op->addr.buswidth > 8 ||
> > >  	    op->dummy.buswidth > 8 || op->cmd.buswidth > 8)
> > > @@ -465,13 +465,9 @@ static bool mxic_spi_mem_supports_op(struct spi_mem *mem,
> > >  	if (op->addr.nbytes > 7)
> > >  		return false;
> > >  
> > > -	all_false = !op->cmd.dtr && !op->addr.dtr && !op->dummy.dtr &&
> > > -		    !op->data.dtr;
> > > +	caps.dtr = op->cmd.dtr || op->addr.dtr || op->dummy.dtr || op->data.dtr;    
> > 
> > Are you sure that's what you want to do? spi_mem_controller_caps is
> > supposed to encode the controller capabilities, not whether the
> > operation contains a DTR cycle or not. I'd expect this caps object to be
> > statically defined, with possibly one instance per-compat if the caps
> > depend on the HW revision.  
> 
> In order to keep the series easy to review I decided to go for the
> following approach:
> * Introduce the spi_mem_generic_supports_op_helper() which takes a
>   capabilities structure. This helper gathers all the checks from
>   spi_mem_default_supports_op() and spi_mem_dtr_supports_op(). These
>   two helpers now call the new one with either a NULL pointer in the
>   former case, or a structure with the .dtr parameter set to true in
>   the latter.
> * Change the API of spi_mem_default_supports_op(), this involves
>   updating many different drivers so this change does only that in a
>   very transparent way, with no functional changes at all. All the
>   drivers provide a NULL parameter for the capabilities structure.
> * Actually make use of the new parameter of
>   spi_mem_default_supports_op() in the drivers Cadence and Macronix,
>   which do have DTR support. This kills the spi_mem_dtr_supports_op()
>   helper.
> * Kill the temporary spi_mem_generic_supports_op() helper by moving
>   all the logic back into spi_mem_default_supports_op().
> 
> This approach is really straightforward and easily bisectable if
> needed.

I don't really see the benefit of converting drivers one by one for
such a trivial/mechanical change to be honest. After all, we're talking
about adding a caps argument to spi_mem_default_supports_op() and
making all existing callers pass a caps object that's zero initialized.
I hope we can get this right in one shot...
