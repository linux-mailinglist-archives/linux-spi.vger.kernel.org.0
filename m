Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBE384706CD
	for <lists+linux-spi@lfdr.de>; Fri, 10 Dec 2021 18:15:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbhLJRTG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Fri, 10 Dec 2021 12:19:06 -0500
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:48845 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244243AbhLJRTF (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 10 Dec 2021 12:19:05 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 85A12FF805;
        Fri, 10 Dec 2021 17:15:27 +0000 (UTC)
Date:   Fri, 10 Dec 2021 18:15:25 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>,
        <linux-mtd@lists.infradead.org>, Mark Brown <broonie@kernel.org>,
        <linux-spi@vger.kernel.org>, Julien Su <juliensu@mxic.com.tw>,
        Jaime Liao <jaimeliao@mxic.com.tw>
Subject: Re: [PATCH v4 05/12] spi: spi-mem: Export the
 spi_mem_generic_supports_op() helper
Message-ID: <20211210181525.0f6e0038@xps13>
In-Reply-To: <20211210172717.01fabb05@collabora.com>
References: <20211209174046.535229-1-miquel.raynal@bootlin.com>
        <20211209174046.535229-6-miquel.raynal@bootlin.com>
        <20211210172717.01fabb05@collabora.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Boris,

boris.brezillon@collabora.com wrote on Fri, 10 Dec 2021 17:27:17 +0100:

> On Thu,  9 Dec 2021 18:40:39 +0100
> Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> 
> > The combination of checks against the number of supported operations is
> > going to increase exponentially each time we add a new parameter. So far
> > we only had a dtr parameter. Now we are introducing an ECC parameter. We
> > need to make this helper available for drivers with specific needs,
> > instead of creating another set of helpers each time we want to check
> > something new. In the future if we see that many different drivers use
> > the same parameter values, we might be tempted to create a specific
> > helper for that. But for now, let's just make the generic one available.
> > 
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > ---
> >  drivers/spi/spi-mem.c       |  7 ++++---
> >  include/linux/spi/spi-mem.h | 13 +++++++++++++
> >  2 files changed, 17 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
> > index 9e06cd918273..48b55395178f 100644
> > --- a/drivers/spi/spi-mem.c
> > +++ b/drivers/spi/spi-mem.c
> > @@ -160,9 +160,9 @@ static bool spi_mem_check_buswidth(struct spi_mem *mem,
> >  	return true;
> >  }
> >  
> > -static bool spi_mem_generic_supports_op(struct spi_mem *mem,
> > -					const struct spi_mem_op *op,
> > -					bool dtr, bool ecc)
> > +bool spi_mem_generic_supports_op(struct spi_mem *mem,
> > +				 const struct spi_mem_op *op,
> > +				 bool dtr, bool ecc)  
> 
> Looks like you're replacing a maintenance burden by another. Every time
> you'll add a new capability, you'll have to patch all the wrappers and
> the drivers using this generic function to pass the extra parameter.
> How about passing a
> 
> 	struct spi_mem_controller_caps {
> 		bool dtr;
> 		bool ecc;
> 	};

Oh yeah good idea, I like the structure more than the bitfield.

> or making the caps a bitmask, such that next time you add a new cap, you
> can just assume all drivers have it set to 0 by default.

Thanks,
Miquèl
