Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6A145F023
	for <lists+linux-spi@lfdr.de>; Fri, 26 Nov 2021 15:49:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377639AbhKZOw1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 26 Nov 2021 09:52:27 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:50910 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239136AbhKZOu1 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 26 Nov 2021 09:50:27 -0500
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 7FD1E1F46510;
        Fri, 26 Nov 2021 14:47:12 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1637938033; bh=7Hjrs5DDzQftuc72fSu+h83YKub/H8Od0AhrO2w3qFI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MzMYC8T7zcflgKsRx6wkSldtw5GI2aIL7VjrcjicLBMdJeVvZAYGCurU6Rbqvfh7T
         ESx2FCgYo6ECh3C/HQw/59zwz2vLT21ZTshz/2j+hM1IcIdM1XyBGZhkwsl0CuBeGz
         uvWuO3EYo5jT/3zE8TkvGXo+jV67q+OEZpxKS5BKfkpLnaPasnu0QarpNLMS1yeLL8
         JMdtEkZL0QCmfkaPPmC4VwTAyTh9UdKCvFYznKNDzN3PoBsd0nVDQ8sllfkYBlau36
         O5vqySYe1Racfe0EfNMqdawcREl/Y9jYBjn6Fho4DTaSeJ9317mRXUaJQVr7v7FmMI
         x0Ouh7W9f+G0g==
Date:   Fri, 26 Nov 2021 15:47:06 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>,
        <linux-mtd@lists.infradead.org>, Rob Herring <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>, Mark Brown <broonie@kernel.org>,
        <linux-spi@vger.kernel.org>,
        Xiangsheng Hou <Xiangsheng.Hou@mediatek.com>,
        Julien Su <juliensu@mxic.com.tw>,
        Jaime Liao <jaimeliao@mxic.com.tw>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 15/20] mtd: spinand: Create direct mapping
 descriptors for ECC operations
Message-ID: <20211126154706.2a528e72@collabora.com>
In-Reply-To: <20211126154223.28c71271@xps13>
References: <20211126113924.310459-1-miquel.raynal@bootlin.com>
        <20211126113924.310459-16-miquel.raynal@bootlin.com>
        <20211126151352.3bdd2c1a@collabora.com>
        <20211126154223.28c71271@xps13>
Organization: Collabora
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 26 Nov 2021 15:42:23 +0100
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> > > @@ -866,6 +872,24 @@ static int spinand_create_dirmap(struct spinand_device *spinand,
> > >  
> > >  	spinand->dirmaps[plane].rdesc = desc;
> > >  
> > > +	info.op_tmpl = *spinand->op_templates.update_cache;
> > > +	info.op_tmpl.ecc_en = true;
> > > +	desc = devm_spi_mem_dirmap_create(&spinand->spimem->spi->dev,
> > > +					  spinand->spimem, &info);
> > > +	if (IS_ERR(desc))
> > > +		return PTR_ERR(desc);
> > > +
> > > +	spinand->dirmaps[plane].wdesc_ecc = desc;
> > > +
> > > +	info.op_tmpl = *spinand->op_templates.read_cache;
> > > +	info.op_tmpl.ecc_en = true;
> > > +	desc = devm_spi_mem_dirmap_create(&spinand->spimem->spi->dev,
> > > +					  spinand->spimem, &info);
> > > +	if (IS_ERR(desc))
> > > +		return PTR_ERR(desc);
> > > +
> > > +	spinand->dirmaps[plane].rdesc_ecc = desc;
> > > +    
> > 
> > Direct mappings are not free (they might reserve a piece of MMIO
> > address space depending on the spi-mem controller implementation), so
> > I'd recommend creating those mapping only when strictly needed, that
> > is, when dealing with a pipelined ECC.  
> 
> That's what I tried to do in the first place, but unfortunately the
> direct mappings are instantiated at the time the SPI controller gets
> probed, which happens before the NAND flash being initialized and its
> ECC engine being picked. Hence, at this point, we don't really know what
> engine will be used with this ECC engine. I finally gave up and ended
> up creating 4 dirmaps (per lun). I know it's not optimal and in most
> cases consume more address space than needed but couldn't find a
> better solution yet :/

Why do you have to create the ECC mappings that early? Can't you just
create them after the ECC initialization is done? AFAICT, they won't be
used before that anyway.

