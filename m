Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA5FC36EE14
	for <lists+linux-spi@lfdr.de>; Thu, 29 Apr 2021 18:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240730AbhD2QYj (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 29 Apr 2021 12:24:39 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:35339 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232724AbhD2QYi (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 29 Apr 2021 12:24:38 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 6767C22173;
        Thu, 29 Apr 2021 18:23:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1619713430;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bWL3CNDjMb7nz1cZKkLAw3O1cGMY+QoFR9KqySt0db8=;
        b=ZD1lH0+lsVqZBevm1a4HCNgWdi/+b3VWuzjXso1qeVDK1xIiSBdD19MS6uDfMSYXcJHkBn
        ZUkrBkmAaZwUY8TmZD6hD4jq+CBOpuh/Jeorn853kpal/Ubsu6U6yj3GK0TY7B/8A+dHZQ
        EVXT/eZ/PGxjCQe2WgU26b0pKqzjQA0=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 29 Apr 2021 18:23:50 +0200
From:   Michael Walle <michael@walle.cc>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-spi@vger.kernel.org, Lokesh Vutla <lokeshvutla@ti.com>
Subject: Re: [RFC PATCH 1/6] spi: spi-mem: Tell controller when device is
 ready for calibration
In-Reply-To: <20210324080804.x7oemmpt2khi72mp@ti.com>
References: <20210311191216.7363-1-p.yadav@ti.com>
 <20210311191216.7363-2-p.yadav@ti.com>
 <934c8c6f7bb71729bfdaefd39c63a262@walle.cc>
 <20210324080804.x7oemmpt2khi72mp@ti.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <6dfbb3e4107887dc9ee3e19e4940e87c@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Pratyush,

I've had a look at the LS1028A FlexSPI calibration feature. The
reference manual is very sparse on details, though. What you need to
do there is to program a special read command sequence (the whole
controller is made of these lookup table entries, where you can
have a short sequence of operations for read/write/program and so
on). Therefore, for data learning you'll take the read operation
and insert a LEARN op in between and read a specific data pattern.
Then the hardware will automatically figure out the correct sample
phase for the read data pins.

Unfortunately, it does not mention how often you have to do it. It
might be the case that is has to be calibrated more than once.

I'm just mentioning this so it won't be lost. If needed, it can
be added later.

Am 2021-03-24 09:08, schrieb Pratyush Yadav:
> On 24/03/21 12:07AM, Michael Walle wrote:
>> Am 2021-03-11 20:12, schrieb Pratyush Yadav:
>> > Some controllers like the Cadence OSPI controller need to perform a
>> > calibration sequence to operate at high clock speeds. This calibration
>> > should happen after the flash is fully initialized otherwise the
>> > calibration might happen in a different SPI mode from the one the flash
>> > is finally set to. Add a hook that can be used to tell the controller
>> > when the flash is ready for calibration. Whether calibration is needed
>> > depends on the controller.
>> >
>> > Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
>> > ---
>> >  drivers/spi/spi-mem.c       | 12 ++++++++++++
>> >  include/linux/spi/spi-mem.h |  8 ++++++++
>> >  2 files changed, 20 insertions(+)
>> >
>> > diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
>> > index dc713b0c3c4d..e2f05ad3f4dc 100644
>> > --- a/drivers/spi/spi-mem.c
>> > +++ b/drivers/spi/spi-mem.c
>> > @@ -464,6 +464,18 @@ int spi_mem_adjust_op_size(struct spi_mem *mem,
>> > struct spi_mem_op *op)
>> >  }
>> >  EXPORT_SYMBOL_GPL(spi_mem_adjust_op_size);
>> >
>> > +int spi_mem_do_calibration(struct spi_mem *mem, struct spi_mem_op *op)
>> > +{
>> > +	struct spi_controller *ctlr = mem->spi->controller;
>> > +
>> > +	if (!ctlr->mem_ops || !ctlr->mem_ops->do_calibration)
>> > +		return -EOPNOTSUPP;
>> > +
>> > +	ctlr->mem_ops->do_calibration(mem, op);
>> 
>> Can't a calibration fail?
> 
> It can. If it does, the controller falls back to lower speed transfers.
> There is not much the upper layer can do about this. That's why it is
> not informed whether it succeeded or not.

Ok, if needed, that should be an easy change.

op is there to decide if we need a calibration at all, correct?
What if there are different factors, like frequency? For example
on the LS1028A its just a matter of the SCK frequency. It seems
that this parameter is tailored to the OPHY.

-michael

>> > +	return 0;
>> > +}
>> > +EXPORT_SYMBOL_GPL(spi_mem_do_calibration);
>> > +
>> >  static ssize_t spi_mem_no_dirmap_read(struct spi_mem_dirmap_desc *desc,
>> >  				      u64 offs, size_t len, void *buf)
>> >  {
>> > diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
>> > index 2b65c9edc34e..97a2d280f2d0 100644
>> > --- a/include/linux/spi/spi-mem.h
>> > +++ b/include/linux/spi/spi-mem.h
>> > @@ -250,6 +250,12 @@ static inline void *spi_mem_get_drvdata(struct
>> > spi_mem *mem)
>> >   *		  the currently mapped area), and the caller of
>> >   *		  spi_mem_dirmap_write() is responsible for calling it again in
>> >   *		  this case.
>> > + * @do_calibration: perform calibration needed for high SPI clock speed
>> > + *		    operation. Should be called after the SPI memory device has
>> > + *		    been completely initialized. The op passed should contain
>> > + *		    a template for the read operation used for the device so
>> > + *		    the controller can decide what type of calibration is
>> > + *		    required for this type of read.
>> >   *
>> >   * This interface should be implemented by SPI controllers providing an
>> >   * high-level interface to execute SPI memory operation, which is
>> > usually the
>> > @@ -274,6 +280,7 @@ struct spi_controller_mem_ops {
>> >  			       u64 offs, size_t len, void *buf);
>> >  	ssize_t (*dirmap_write)(struct spi_mem_dirmap_desc *desc,
>> >  				u64 offs, size_t len, const void *buf);
>> > +	void (*do_calibration)(struct spi_mem *mem, struct spi_mem_op *op);
>> >  };
>> >
>> >  /**
>> > @@ -346,6 +353,7 @@ bool spi_mem_dtr_supports_op(struct spi_mem *mem,
>> >  #endif /* CONFIG_SPI_MEM */
>> >
>> >  int spi_mem_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op);
>> > +int spi_mem_do_calibration(struct spi_mem *mem, struct spi_mem_op *op);
>> >
>> >  bool spi_mem_supports_op(struct spi_mem *mem,
>> >  			 const struct spi_mem_op *op);
>> 

