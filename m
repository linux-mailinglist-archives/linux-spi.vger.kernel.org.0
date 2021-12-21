Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 420C647BCF3
	for <lists+linux-spi@lfdr.de>; Tue, 21 Dec 2021 10:35:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234513AbhLUJfi convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Tue, 21 Dec 2021 04:35:38 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:41605 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233216AbhLUJfi (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 21 Dec 2021 04:35:38 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 71A42240004;
        Tue, 21 Dec 2021 09:35:33 +0000 (UTC)
Date:   Tue, 21 Dec 2021 10:35:31 +0100
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
Subject: Re: [PATCH v7 02/14] spi: spi-mem: Introduce a capability structure
Message-ID: <20211221103531.1fc1c788@xps13>
In-Reply-To: <20211220184323.cfbd5ypintmz2xrq@ti.com>
References: <20211217161654.367782-1-miquel.raynal@bootlin.com>
        <20211217161654.367782-3-miquel.raynal@bootlin.com>
        <20211220184323.cfbd5ypintmz2xrq@ti.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Pratyush,

p.yadav@ti.com wrote on Tue, 21 Dec 2021 00:13:25 +0530:

> On 17/12/21 05:16PM, Miquel Raynal wrote:
> > Create a spi_controller_mem_caps structure and put it within the
> > spi_controller_mem_ops structure as these are highly related. So far the
> > only field in this structure is the support for dtr operations, but soon
> > we will add another parameter.
> > 
> > Also create a helper to parse the capabilities and check if the
> > requested capability has been set or not.
> > 
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > ---
> >  include/linux/spi/spi-mem.h | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> > 
> > diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
> > index 85e2ff7b840d..045ecb7c6f50 100644
> > --- a/include/linux/spi/spi-mem.h
> > +++ b/include/linux/spi/spi-mem.h
> > @@ -220,6 +220,17 @@ static inline void *spi_mem_get_drvdata(struct spi_mem *mem)
> >  	return mem->drvpriv;
> >  }
> >  
> > +/**
> > + * struct spi_controller_mem_caps - SPI memory controller capabilities
> > + * @dtr: Supports DTR operations
> > + */
> > +struct spi_controller_mem_caps {
> > +	bool dtr;  
> 
> I assume this would mean DTR is supported on _all_ phases? I am not sure 
> if we would ever need to encode DTR support per-phase, but that can 
> probably come later. Or the controller's supports_op() hook can do those 
> checks before calling spi_mem_default_supports_op().

If we ever need this there is no problem: the idea here is to provide a
default (and for this one the naming is rather good =) ) helper to do
basic checks. A controller either supports DTR ops or not. If it does
not support them, then this check will fail. But like the Cadence SPI
controller driver does, if only one specific configuration is not
supported by the driver, then the ->supports_op() hook of the driver
should check that beforehand and return an error [1].


[1] https://elixir.bootlin.com/linux/latest/source/drivers/spi/spi-cadence-quadspi.c#L1253

> > +};
> > +
> > +#define spi_mem_controller_is_capable(ctlr, cap)		\
> > +	((ctlr)->mem_ops->caps && (ctlr)->mem_ops->caps->cap)	\
> > +
> >  /**
> >   * struct spi_controller_mem_ops - SPI memory operations
> >   * @adjust_op_size: shrink the data xfer of an operation to match controller's
> > @@ -253,6 +264,7 @@ static inline void *spi_mem_get_drvdata(struct spi_mem *mem)
> >   * @poll_status: poll memory device status until (status & mask) == match or
> >   *               when the timeout has expired. It fills the data buffer with
> >   *               the last status value.
> > + * @caps: controller capabilities for the handling of the above operations.
> >   *
> >   * This interface should be implemented by SPI controllers providing an
> >   * high-level interface to execute SPI memory operation, which is usually the
> > @@ -283,6 +295,7 @@ struct spi_controller_mem_ops {
> >  			   unsigned long initial_delay_us,
> >  			   unsigned long polling_rate_us,
> >  			   unsigned long timeout_ms);
> > +	const struct spi_controller_mem_caps *caps;  
> 
> I feel like this would be better passed in as an argument to the 
> spi_mem_default_supports_op() function. But I see that Mark and you feel 
> differently so I won't insist on it.

As these properties are supposes to be more or less static over the
lifetime of the controller we assumed there was no need for something
more dynamic. Anyway this is a default helper, drivers are pleased to
implement their own if needed. Plus, doing so prevents the need for
hacking into dozens of drivers, which is certainly the reason I
personally like the most :p 

Thanks,
Miquèl
