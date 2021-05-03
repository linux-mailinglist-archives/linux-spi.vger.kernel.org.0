Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7A73712DA
	for <lists+linux-spi@lfdr.de>; Mon,  3 May 2021 11:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233000AbhECJMR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 3 May 2021 05:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbhECJMR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 3 May 2021 05:12:17 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A475C06174A;
        Mon,  3 May 2021 02:11:24 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id ED90F1F42208;
        Mon,  3 May 2021 10:11:21 +0100 (BST)
Date:   Mon, 3 May 2021 11:11:14 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     <patrice.chotard@foss.st.com>, Mark Brown <broonie@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <christophe.kerello@foss.st.com>
Subject: Re: [PATCH 1/3] spi: spi-mem: add automatic poll status functions
Message-ID: <20210503111114.26b64e25@collabora.com>
In-Reply-To: <20210503084742.7cp77snyohkdwwvv@ti.com>
References: <20210426143934.25275-1-patrice.chotard@foss.st.com>
        <20210426143934.25275-2-patrice.chotard@foss.st.com>
        <20210430185104.377d1bc6@collabora.com>
        <20210503084742.7cp77snyohkdwwvv@ti.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 3 May 2021 14:17:44 +0530
Pratyush Yadav <p.yadav@ti.com> wrote:

> On 30/04/21 06:51PM, Boris Brezillon wrote:
> > On Mon, 26 Apr 2021 16:39:32 +0200
> > <patrice.chotard@foss.st.com> wrote:
> >   
> > > From: Christophe Kerello <christophe.kerello@foss.st.com>
> > > 
> > > With STM32 QSPI, it is possible to poll the status register of the device.
> > > This could be done to offload the CPU during an operation (erase or
> > > program a SPI NAND for example).
> > > 
> > > spi_mem_poll_status API has been added to handle this feature.
> > > 
> > > Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>
> > > Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> > > ---
> > >  drivers/spi/spi-mem.c       | 34 ++++++++++++++++++++++++++++++++++
> > >  include/linux/spi/spi-mem.h |  8 ++++++++
> > >  2 files changed, 42 insertions(+)
> > > 
> > > diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
> > > index 1513553e4080..43dce4b0efa4 100644
> > > --- a/drivers/spi/spi-mem.c
> > > +++ b/drivers/spi/spi-mem.c
> > > @@ -743,6 +743,40 @@ static inline struct spi_mem_driver *to_spi_mem_drv(struct device_driver *drv)
> > >  	return container_of(drv, struct spi_mem_driver, spidrv.driver);
> > >  }
> > >  
> > > +/**
> > > + * spi_mem_poll_status() - Poll memory device status
> > > + * @mem: SPI memory device
> > > + * @op: the memory operation to execute
> > > + * @mask: status bitmask to ckeck
> > > + * @match: status expected value
> > > + * @timeout: timeout
> > > + *
> > > + * This function send a polling status request to the controller driver
> > > + *
> > > + * Return: 0 in case of success, -ETIMEDOUT in case of error,
> > > + *         -EOPNOTSUPP if not supported.
> > > + */
> > > +int spi_mem_poll_status(struct spi_mem *mem,
> > > +			const struct spi_mem_op *op,
> > > +			u8 mask, u8 match, u16 timeout)
> > > +{
> > > +	struct spi_controller *ctlr = mem->spi->controller;
> > > +	int ret = -EOPNOTSUPP;
> > > +
> > > +	if (ctlr->mem_ops && ctlr->mem_ops->poll_status) {
> > > +		ret = spi_mem_access_start(mem);  
> > 
> > You should probably check that op is a single byte read before
> > accepting the command.  
> 
> Please do not discriminate against 8D-8D-8D flashes ;-).

Then mask and match should probably be u16 :P. And the check as it is
seems a bit lax to me. Drivers will of course be able to reject the op
when there's more than one byte (or 16bit word in case of 8D) to read,
but it feels like the core could automate that a bit.

> 
> >   
> > > +		if (ret)
> > > +			return ret;
> > > +
> > > +		ret = ctlr->mem_ops->poll_status(mem, op, mask, match, timeout);  
> > 
> > You also need some sort of ->poll_status_is_supported() to validate
> > that the controller supports the status polling for this specific op (I  
> 
> I don't think a separate function is needed for checking if the poll 
> status op is supported. Return value of -EOPNOTSUPP should be able to 
> signal that. This can also be used to check if Octal DDR capable 
> controllers are able to poll using 2-byte reads.

Yeah, I had something more complex in mind to avoid doing this 'try
native mode and fall back on sw-based more if not supported' dance
every time a status poll is requested (something similar to what we do
for dirmaps, with a status poll desc), but I guess that's a bit
premature (and probably uneeded).

> 
> > can imagine some controllers having a limit on the number of dummy
> > cycles/address bytes). I guess you could just fall back on SW-based
> > status polling if ctlr->mem_ops->poll_status() returns -ENOTSUPP.
> >   
> > > +
> > > +		spi_mem_access_end(mem);
> > > +	}
> > > +
> > > +	return ret;
> > > +}
> > > +EXPORT_SYMBOL_GPL(spi_mem_poll_status);
> > > +
> > >  static int spi_mem_probe(struct spi_device *spi)
> > >  {
> > >  	struct spi_mem_driver *memdrv = to_spi_mem_drv(spi->dev.driver);
> > > diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
> > > index 2b65c9edc34e..5f78917c0f68 100644
> > > --- a/include/linux/spi/spi-mem.h
> > > +++ b/include/linux/spi/spi-mem.h
> > > @@ -250,6 +250,7 @@ static inline void *spi_mem_get_drvdata(struct spi_mem *mem)
> > >   *		  the currently mapped area), and the caller of
> > >   *		  spi_mem_dirmap_write() is responsible for calling it again in
> > >   *		  this case.
> > > + * @poll_status: poll memory device status
> > >   *
> > >   * This interface should be implemented by SPI controllers providing an
> > >   * high-level interface to execute SPI memory operation, which is usually the
> > > @@ -274,6 +275,9 @@ struct spi_controller_mem_ops {
> > >  			       u64 offs, size_t len, void *buf);
> > >  	ssize_t (*dirmap_write)(struct spi_mem_dirmap_desc *desc,
> > >  				u64 offs, size_t len, const void *buf);
> > > +	int (*poll_status)(struct spi_mem *mem,
> > > +			   const struct spi_mem_op *op,
> > > +			   u8 mask, u8 match, u16 timeout);
> > >  };
> > >  
> > >  /**
> > > @@ -369,6 +373,10 @@ devm_spi_mem_dirmap_create(struct device *dev, struct spi_mem *mem,
> > >  void devm_spi_mem_dirmap_destroy(struct device *dev,
> > >  				 struct spi_mem_dirmap_desc *desc);
> > >  
> > > +int spi_mem_poll_status(struct spi_mem *mem,
> > > +			const struct spi_mem_op *op,
> > > +			u8 mask, u8 match, u16 timeout);
> > > +
> > >  int spi_mem_driver_register_with_owner(struct spi_mem_driver *drv,
> > >  				       struct module *owner);
> > >    
> 

