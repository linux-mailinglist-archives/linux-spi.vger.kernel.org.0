Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2410E39A9CA
	for <lists+linux-spi@lfdr.de>; Thu,  3 Jun 2021 20:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbhFCSKw (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 3 Jun 2021 14:10:52 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:39336 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbhFCSKw (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 3 Jun 2021 14:10:52 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 153I8lYL099709;
        Thu, 3 Jun 2021 13:08:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1622743727;
        bh=a6woUSiRPwVmYHSHy6o5MrXffOKGnDS3P4j3dK8UANk=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=xg3OPg6rNtFCU9Pc5KdgP9ZM8Ebzq7sPtK9q+4OSIqeE8li2Wq9UQrrlxhLiFxDRX
         C/+Gzdk+hulinYs5zbO6T4A3g+mKKRF71yyBz/BIPAMZTyNcY39LpOXHk1ThaKMT64
         NCEZToQFaxLqTa6cgQQVSlrK62qzqftCUj+MlSuw=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 153I8lac092999
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 3 Jun 2021 13:08:47 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 3 Jun
 2021 13:08:47 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 3 Jun 2021 13:08:47 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 153I8kUq050570;
        Thu, 3 Jun 2021 13:08:46 -0500
Date:   Thu, 3 Jun 2021 23:38:45 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
CC:     Michael Walle <michael@walle.cc>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>,
        <linux-mtd@lists.infradead.org>, <linux-spi@vger.kernel.org>
Subject: Re: [PATCH] mtd: spi-nor: intel-spi: Add support for second flash
 chip
Message-ID: <20210603180843.hjzynysgby3d3e5r@ti.com>
References: <20210525160318.35802-1-mika.westerberg@linux.intel.com>
 <20210525191414.dc45h27rzqen4dce@ti.com>
 <20210526091250.GY291593@lahna.fi.intel.com>
 <20210526092417.GA291593@lahna.fi.intel.com>
 <e82f44552d0d4284fc5ed22ee0bee85a@walle.cc>
 <20210526102810.GB291593@lahna.fi.intel.com>
 <YLTILUh+bPhZ4ToR@lahna.fi.intel.com>
 <YLi3/DRqGzdlosNf@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YLi3/DRqGzdlosNf@lahna.fi.intel.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

+Mark, linux-spi list,

On 03/06/21 02:07PM, Mika Westerberg wrote:
> Hi Tudor,
> 
> On Mon, May 31, 2021 at 02:29:59PM +0300, Mika Westerberg wrote:
> > Hi guys,
> > 
> > On Wed, May 26, 2021 at 01:28:16PM +0300, Mika Westerberg wrote:
> > > Hi,
> > > 
> > > On Wed, May 26, 2021 at 11:31:58AM +0200, Michael Walle wrote:
> > > > > Oh, I see now this commit:
> > > > > 
> > > > > a314f6367787 ("mtd: spi-nor: Convert cadence-quadspi to use spi-mem
> > > > > framework")
> > > > > 
> > > > > So "SPI MEM" means generic SPI subsystem for memory mapped devices.
> > > > > Unfortunately Intel controller at least is not capable of running
> > > > > generic SPI transactions. It only supports accessing SPI-NOR flashes and
> > > > > for those there is small set of commands that supports. I don't think it
> > > > > is even possible to convert the driver to generic SPI subsystem.
> > > > 
> > > > AFAIK it stands for SPI memory device (memory mapped is not a requirement).
> > > > Eg. spi-nxp-fspi doesn't support generic SPI devices either, but just SPI
> > > > flashes. So I'd guess SPI MEM is exactly what you are looking for.
> > > 
> > > OK, I see that there is ->mem_ops that can be used to implement
> > > different higher level commands. What I'm not seeing is that how the
> > > child SPI flash is created using this scheme? DeviceTree and ACPI are
> > > supported fine but what about scanning? I mean the intel_spi driver has
> > > this:
> > > 
> > >   spi_nor_scan(&ispi->nor, NULL, &hwcaps);
> > > 
> > > But if the driver is to be moved under drivers/spi/* you can't really
> > > call these functions anymore or can you? Or the point is to keep the
> > > driver under controllers/ and just call spi_nor_scan(), and in addition
> > > implement the new mem_ops?
> > > 
> > > Thanks in advance and sorry about many questions but there does not seem
> > > to be a conversion guide nor any (non-DT/ACPI) examples that I can take
> > > a look. :-)
> > 
> > Can you provide some guidance here? So in order to use the generic SPI
> > subsystem with "SPI MEM" parts of it, I would need to be able to create
> > the child SPI-NOR flash device without using ACPI or DT (as these
> > systems do not have any ACPI/DT description), or use spi_nor_scan() but
> > none of the driver under drivers/spi are calling it.
> 
> As the main SPI-NOR maintainer, what's your take on this?

I think this is more of a SPI or SPI MEM question, and less of a SPI NOR 
question. SPI MEM would call spi_nor_probe() which in turn calls 
spi_nor_scan().

So the question that needs to be answered is how to probe SPI MEM based
drivers without ACPI/DT.

> 
> Thanks!

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
