Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CCD736EF9A
	for <lists+linux-spi@lfdr.de>; Thu, 29 Apr 2021 20:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241089AbhD2SmK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 29 Apr 2021 14:42:10 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:37106 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240977AbhD2SmJ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 29 Apr 2021 14:42:09 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 13TIfD4o074410;
        Thu, 29 Apr 2021 13:41:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1619721673;
        bh=lFtIIpno6eT8m/+zS7Csg1jBvtJUiRsjbPFVq89uUHs=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=vtGkLHU0CpJZP8babNKIpua2SXJvzN40x7SrRoSMffHa0UhWI4ULMZeAPtQifTUu+
         9VnSplFizkLu1v9Ri/NxjL7JDB7d8y1eEMlhWMK1Q5Fjs7e0Ho5VYDRBpjgWdAShXC
         u7horZfZnbsZ9vbpFCAIjUqmaibxcDL6XtHqzE3o=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 13TIfDkE029334
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 29 Apr 2021 13:41:13 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 29
 Apr 2021 13:41:12 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 29 Apr 2021 13:41:12 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 13TIfBKu063474;
        Thu, 29 Apr 2021 13:41:12 -0500
Date:   Fri, 30 Apr 2021 00:11:11 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Michael Walle <michael@walle.cc>
CC:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>, <linux-spi@vger.kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: Re: [RFC PATCH 1/6] spi: spi-mem: Tell controller when device is
 ready for calibration
Message-ID: <20210429184109.f2pf3iyaiylumoyp@ti.com>
References: <20210311191216.7363-1-p.yadav@ti.com>
 <20210311191216.7363-2-p.yadav@ti.com>
 <934c8c6f7bb71729bfdaefd39c63a262@walle.cc>
 <20210324080804.x7oemmpt2khi72mp@ti.com>
 <6dfbb3e4107887dc9ee3e19e4940e87c@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6dfbb3e4107887dc9ee3e19e4940e87c@walle.cc>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 29/04/21 06:23PM, Michael Walle wrote:
> Hi Pratyush,
> 
> I've had a look at the LS1028A FlexSPI calibration feature. The
> reference manual is very sparse on details, though. What you need to
> do there is to program a special read command sequence (the whole
> controller is made of these lookup table entries, where you can
> have a short sequence of operations for read/write/program and so
> on). Therefore, for data learning you'll take the read operation
> and insert a LEARN op in between and read a specific data pattern.
> Then the hardware will automatically figure out the correct sample
> phase for the read data pins.
> 
> Unfortunately, it does not mention how often you have to do it. It
> might be the case that is has to be calibrated more than once.

I haven't read the datasheet, I wonder how long this calibration takes. 
If it is too long then the overhead might not even be worth the extra 
read throughput. Especially when using a file system on top which 
generally don't do very large reads in one go.

Anyway, when the do_calibration() is called the controller can save the 
calibration op and use it later as needed. It knows when an exec_op() 
will result in a read since it has access to the whole op.

> 
> I'm just mentioning this so it won't be lost. If needed, it can
> be added later.
> 
> Am 2021-03-24 09:08, schrieb Pratyush Yadav:
> > On 24/03/21 12:07AM, Michael Walle wrote:
> > > Am 2021-03-11 20:12, schrieb Pratyush Yadav:
> > > > Some controllers like the Cadence OSPI controller need to perform a
> > > > calibration sequence to operate at high clock speeds. This calibration
> > > > should happen after the flash is fully initialized otherwise the
> > > > calibration might happen in a different SPI mode from the one the flash
> > > > is finally set to. Add a hook that can be used to tell the controller
> > > > when the flash is ready for calibration. Whether calibration is needed
> > > > depends on the controller.
> > > >
> > > > Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> > > > ---
> > > >  drivers/spi/spi-mem.c       | 12 ++++++++++++
> > > >  include/linux/spi/spi-mem.h |  8 ++++++++
> > > >  2 files changed, 20 insertions(+)
> > > >
> > > > diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
> > > > index dc713b0c3c4d..e2f05ad3f4dc 100644
> > > > --- a/drivers/spi/spi-mem.c
> > > > +++ b/drivers/spi/spi-mem.c
> > > > @@ -464,6 +464,18 @@ int spi_mem_adjust_op_size(struct spi_mem *mem,
> > > > struct spi_mem_op *op)
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(spi_mem_adjust_op_size);
> > > >
> > > > +int spi_mem_do_calibration(struct spi_mem *mem, struct spi_mem_op *op)
> > > > +{
> > > > +	struct spi_controller *ctlr = mem->spi->controller;
> > > > +
> > > > +	if (!ctlr->mem_ops || !ctlr->mem_ops->do_calibration)
> > > > +		return -EOPNOTSUPP;
> > > > +
> > > > +	ctlr->mem_ops->do_calibration(mem, op);
> > > 
> > > Can't a calibration fail?
> > 
> > It can. If it does, the controller falls back to lower speed transfers.
> > There is not much the upper layer can do about this. That's why it is
> > not informed whether it succeeded or not.
> 
> Ok, if needed, that should be an easy change.
> 
> op is there to decide if we need a calibration at all, correct?

Yes. It can also be used to choose which calibration algorithm to use. 
For example on the Cadence controller, there are different algorithms 
for 8S and 8D operations.

> What if there are different factors, like frequency? For example
> on the LS1028A its just a matter of the SCK frequency. It seems
> that this parameter is tailored to the OPHY.

As of now there is no way in SPI MEM to tell the controller the expected 
speed of the operation. AFAIK most controllers get the speed via device 
tree. So in the current case, the controller already knows the speed it 
should run at, and can decide if calibration is needed or not.

But if operation speed is eventually added to SPI MEM, I would assume it 
would be part of struct spi_mem_op. The op passed in would have this 
information filled, and the controller can use that information to 
decide if it needs to perform the calibration or not.

I am all for making this API flexible, but with very few controllers 
supporting this feature in the wild, it is difficult to predict all the 
information that might be needed. In the current state, I think the API 
provides a fair bit of information to the controller about how a read 
operation would look like.

> 
> -michael
> 
> > > > +	return 0;
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(spi_mem_do_calibration);
> > > > +
> > > >  static ssize_t spi_mem_no_dirmap_read(struct spi_mem_dirmap_desc *desc,
> > > >  				      u64 offs, size_t len, void *buf)
> > > >  {
> > > > diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
> > > > index 2b65c9edc34e..97a2d280f2d0 100644
> > > > --- a/include/linux/spi/spi-mem.h
> > > > +++ b/include/linux/spi/spi-mem.h
> > > > @@ -250,6 +250,12 @@ static inline void *spi_mem_get_drvdata(struct
> > > > spi_mem *mem)
> > > >   *		  the currently mapped area), and the caller of
> > > >   *		  spi_mem_dirmap_write() is responsible for calling it again in
> > > >   *		  this case.
> > > > + * @do_calibration: perform calibration needed for high SPI clock speed
> > > > + *		    operation. Should be called after the SPI memory device has
> > > > + *		    been completely initialized. The op passed should contain
> > > > + *		    a template for the read operation used for the device so
> > > > + *		    the controller can decide what type of calibration is
> > > > + *		    required for this type of read.
> > > >   *
> > > >   * This interface should be implemented by SPI controllers providing an
> > > >   * high-level interface to execute SPI memory operation, which is
> > > > usually the
> > > > @@ -274,6 +280,7 @@ struct spi_controller_mem_ops {
> > > >  			       u64 offs, size_t len, void *buf);
> > > >  	ssize_t (*dirmap_write)(struct spi_mem_dirmap_desc *desc,
> > > >  				u64 offs, size_t len, const void *buf);
> > > > +	void (*do_calibration)(struct spi_mem *mem, struct spi_mem_op *op);
> > > >  };
> > > >
> > > >  /**
> > > > @@ -346,6 +353,7 @@ bool spi_mem_dtr_supports_op(struct spi_mem *mem,
> > > >  #endif /* CONFIG_SPI_MEM */
> > > >
> > > >  int spi_mem_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op);
> > > > +int spi_mem_do_calibration(struct spi_mem *mem, struct spi_mem_op *op);
> > > >
> > > >  bool spi_mem_supports_op(struct spi_mem *mem,
> > > >  			 const struct spi_mem_op *op);
> > > 
> 

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
