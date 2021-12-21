Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5643047BE3B
	for <lists+linux-spi@lfdr.de>; Tue, 21 Dec 2021 11:41:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233587AbhLUKlq (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 21 Dec 2021 05:41:46 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:56872 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbhLUKlq (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 21 Dec 2021 05:41:46 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1BLAfCNJ093095;
        Tue, 21 Dec 2021 04:41:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1640083272;
        bh=qn2jvH244ipckEXqKUMilRypfBZUGqN1bzy/MrQdTqU=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=Gs+GpSbnY9T/cMOACj6wLghKu3sFRe7ceUFtXEQ+vtNb8/kqG2Gti6nEltCwcAEkx
         2Mr0KCfl5mr7qQXIWBnm6wb5ZYtWWEaP+3zbhUBdQPdCCf2HaKTdZmz/V+Sd7Za2dv
         Qera68gIzWU/GlbQira6tyYVV7Qbbfdnu87BJbiI=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1BLAfCTC021119
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 21 Dec 2021 04:41:12 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 21
 Dec 2021 04:41:11 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 21 Dec 2021 04:41:11 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1BLAfBEa014648;
        Tue, 21 Dec 2021 04:41:11 -0600
Date:   Tue, 21 Dec 2021 16:11:10 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     Mark Brown <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Michael Walle <michael@walle.cc>,
        <linux-mtd@lists.infradead.org>, Julien Su <juliensu@mxic.com.tw>,
        Jaime Liao <jaimeliao@mxic.com.tw>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Boris Brezillon <boris.brezillon@collabora.com>
Subject: Re: [PATCH v7 04/14] spi: cadence: Provide a capability structure
Message-ID: <20211221104108.t563gg2hulfqt2uh@ti.com>
References: <20211217161654.367782-1-miquel.raynal@bootlin.com>
 <20211217161654.367782-5-miquel.raynal@bootlin.com>
 <20211220185515.wujhgn66mnwns7bw@ti.com>
 <20211221111605.352285f5@xps13>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211221111605.352285f5@xps13>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 21/12/21 11:16AM, Miquel Raynal wrote:
> Hi Pratyush,
> 
> p.yadav@ti.com wrote on Tue, 21 Dec 2021 00:25:18 +0530:
> 
> > > Subject: [PATCH v7 04/14] spi: cadence: Provide a capability structure  
> > 
> > s/cadence/cadence-quadspi/
> 
> Right.
> 
> > 
> > On 17/12/21 05:16PM, Miquel Raynal wrote:
> > > This controller has DTR support, so advertize it with a capability now
> > > that the spi_controller_mem_ops structure contains this new field. This
> > > will later be used by the core to discriminate whether an operation is
> > > supported or not, in a more generic way than having different helpers.
> > > 
> > > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > > ---
> > >  drivers/spi/spi-cadence-quadspi.c | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > > 
> > > diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
> > > index 101cc71bffa7..98e0cc4236e3 100644
> > > --- a/drivers/spi/spi-cadence-quadspi.c
> > > +++ b/drivers/spi/spi-cadence-quadspi.c
> > > @@ -1388,10 +1388,15 @@ static const char *cqspi_get_name(struct spi_mem *mem)
> > >  	return devm_kasprintf(dev, GFP_KERNEL, "%s.%d", dev_name(dev), mem->spi->chip_select);
> > >  }
> > >  
> > > +static const struct spi_controller_mem_caps cqspi_mem_caps = {
> > > +	.dtr = true,
> > > +};
> > > +
> > >  static const struct spi_controller_mem_ops cqspi_mem_ops = {
> > >  	.exec_op = cqspi_exec_mem_op,
> > >  	.get_name = cqspi_get_name,
> > >  	.supports_op = cqspi_supports_mem_op,
> > > +	.caps = &cqspi_mem_caps,  
> > 
> > I just noticed you put it under struct spi_mem_ops, not under struct 
> > spi_mem. This is not an operation per se so wouldn't it be better if it 
> > is moved to struct spi_mem?
> 
> I had a hard time taking a decision but my conclusion was that these
> caps are static controller capabilities and exclusively tight to the
> controller. The spi_mem structure defines a SPI peripheral. The
> spi_mem_ops structure is the only spi-mem related field of the
> spi-controller structure. I could have added my own field there but
> as these caps are only meant to be used by the spi_mem_ops anyway
> (exclusively ->supports_op() for now), it seemed to be a good location,
> at least better than the spi-mem structure.

Can we have a 3rd person chime in and break the tie? :-)

> 
> > Anyway, the change itself looks good to me. The cqspi_supports_mem_op()
> > already checks for mixed DTR modes so we should be good.
> 
> Yep!
> 
> > 
> > >  };
> > >  
> > >  static int cqspi_setup_flash(struct cqspi_st *cqspi)
> > > -- 
> > > 2.27.0
> > >   
> > 
> 
> 
> Thanks,
> Miquèl

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
