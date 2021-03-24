Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99A36347334
	for <lists+linux-spi@lfdr.de>; Wed, 24 Mar 2021 09:09:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbhCXIIx (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 24 Mar 2021 04:08:53 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:58520 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbhCXIIV (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 24 Mar 2021 04:08:21 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12O887IQ106668;
        Wed, 24 Mar 2021 03:08:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1616573287;
        bh=2UJRiiRkSq8MKpjgyNb7yucZwpuFL+5TyST3xBlJn0g=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=U76S+qBVYdBCwWYliaYZKRPUOZreldpKVrDsFMdkOtRVUSLmaiJ4FWPmoBOduuTCm
         tiMcgu/DEQ+mhYRiBKYhdRstm8ACurCE6bDINbjbQEr+Y6+72NEop5eQjpoonGxhVa
         UpqiNQCPUfxs9Ao3knn80kYRb+CWHIRZhFQn74FU=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12O8870l021049
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 24 Mar 2021 03:08:07 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 24
 Mar 2021 03:08:07 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 24 Mar 2021 03:08:07 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12O886mM057538;
        Wed, 24 Mar 2021 03:08:07 -0500
Date:   Wed, 24 Mar 2021 13:38:06 +0530
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
Message-ID: <20210324080804.x7oemmpt2khi72mp@ti.com>
References: <20210311191216.7363-1-p.yadav@ti.com>
 <20210311191216.7363-2-p.yadav@ti.com>
 <934c8c6f7bb71729bfdaefd39c63a262@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <934c8c6f7bb71729bfdaefd39c63a262@walle.cc>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 24/03/21 12:07AM, Michael Walle wrote:
> Hi Pratyush,
> 
> Am 2021-03-11 20:12, schrieb Pratyush Yadav:
> > Some controllers like the Cadence OSPI controller need to perform a
> > calibration sequence to operate at high clock speeds. This calibration
> > should happen after the flash is fully initialized otherwise the
> > calibration might happen in a different SPI mode from the one the flash
> > is finally set to. Add a hook that can be used to tell the controller
> > when the flash is ready for calibration. Whether calibration is needed
> > depends on the controller.
> > 
> > Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> > ---
> >  drivers/spi/spi-mem.c       | 12 ++++++++++++
> >  include/linux/spi/spi-mem.h |  8 ++++++++
> >  2 files changed, 20 insertions(+)
> > 
> > diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
> > index dc713b0c3c4d..e2f05ad3f4dc 100644
> > --- a/drivers/spi/spi-mem.c
> > +++ b/drivers/spi/spi-mem.c
> > @@ -464,6 +464,18 @@ int spi_mem_adjust_op_size(struct spi_mem *mem,
> > struct spi_mem_op *op)
> >  }
> >  EXPORT_SYMBOL_GPL(spi_mem_adjust_op_size);
> > 
> > +int spi_mem_do_calibration(struct spi_mem *mem, struct spi_mem_op *op)
> > +{
> > +	struct spi_controller *ctlr = mem->spi->controller;
> > +
> > +	if (!ctlr->mem_ops || !ctlr->mem_ops->do_calibration)
> > +		return -EOPNOTSUPP;
> > +
> > +	ctlr->mem_ops->do_calibration(mem, op);
> 
> Can't a calibration fail?

It can. If it does, the controller falls back to lower speed transfers. 
There is not much the upper layer can do about this. That's why it is 
not informed whether it succeeded or not.

> 
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(spi_mem_do_calibration);
> > +
> >  static ssize_t spi_mem_no_dirmap_read(struct spi_mem_dirmap_desc *desc,
> >  				      u64 offs, size_t len, void *buf)
> >  {
> > diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
> > index 2b65c9edc34e..97a2d280f2d0 100644
> > --- a/include/linux/spi/spi-mem.h
> > +++ b/include/linux/spi/spi-mem.h
> > @@ -250,6 +250,12 @@ static inline void *spi_mem_get_drvdata(struct
> > spi_mem *mem)
> >   *		  the currently mapped area), and the caller of
> >   *		  spi_mem_dirmap_write() is responsible for calling it again in
> >   *		  this case.
> > + * @do_calibration: perform calibration needed for high SPI clock speed
> > + *		    operation. Should be called after the SPI memory device has
> > + *		    been completely initialized. The op passed should contain
> > + *		    a template for the read operation used for the device so
> > + *		    the controller can decide what type of calibration is
> > + *		    required for this type of read.
> >   *
> >   * This interface should be implemented by SPI controllers providing an
> >   * high-level interface to execute SPI memory operation, which is
> > usually the
> > @@ -274,6 +280,7 @@ struct spi_controller_mem_ops {
> >  			       u64 offs, size_t len, void *buf);
> >  	ssize_t (*dirmap_write)(struct spi_mem_dirmap_desc *desc,
> >  				u64 offs, size_t len, const void *buf);
> > +	void (*do_calibration)(struct spi_mem *mem, struct spi_mem_op *op);
> >  };
> > 
> >  /**
> > @@ -346,6 +353,7 @@ bool spi_mem_dtr_supports_op(struct spi_mem *mem,
> >  #endif /* CONFIG_SPI_MEM */
> > 
> >  int spi_mem_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op);
> > +int spi_mem_do_calibration(struct spi_mem *mem, struct spi_mem_op *op);
> > 
> >  bool spi_mem_supports_op(struct spi_mem *mem,
> >  			 const struct spi_mem_op *op);
> 
> -- 
> -michael

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
