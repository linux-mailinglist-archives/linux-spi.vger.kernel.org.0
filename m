Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32A4139B7E1
	for <lists+linux-spi@lfdr.de>; Fri,  4 Jun 2021 13:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbhFDLaA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 4 Jun 2021 07:30:00 -0400
Received: from mga04.intel.com ([192.55.52.120]:58763 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229962AbhFDLaA (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 4 Jun 2021 07:30:00 -0400
IronPort-SDR: PKUrdDjppca3sNjq3t6yoLI6E/+EmiB5Z5T8Dl3YU7Qe/5hh9OmidVdM9CpHaCB0XxdlWmF0Z1
 cavl96ab69ng==
X-IronPort-AV: E=McAfee;i="6200,9189,10004"; a="202414569"
X-IronPort-AV: E=Sophos;i="5.83,248,1616482800"; 
   d="scan'208";a="202414569"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2021 04:28:13 -0700
IronPort-SDR: GsoL7S40iTOxvAVj62EE10SEu7FOG7583ynSch6fVy9+ICOAyKD/ZiV6/D+AqPWF1WSO2c8zCE
 cPY2osG/PjYg==
X-IronPort-AV: E=Sophos;i="5.83,248,1616482800"; 
   d="scan'208";a="446661891"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2021 04:28:10 -0700
Received: by lahna (sSMTP sendmail emulation); Fri, 04 Jun 2021 14:28:08 +0300
Date:   Fri, 4 Jun 2021 14:28:08 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Michael Walle <michael@walle.cc>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>, linux-mtd@lists.infradead.org,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH] mtd: spi-nor: intel-spi: Add support for second flash
 chip
Message-ID: <YLoOSMxeGXP07Tfw@lahna.fi.intel.com>
References: <20210525160318.35802-1-mika.westerberg@linux.intel.com>
 <20210525191414.dc45h27rzqen4dce@ti.com>
 <20210526091250.GY291593@lahna.fi.intel.com>
 <20210526092417.GA291593@lahna.fi.intel.com>
 <e82f44552d0d4284fc5ed22ee0bee85a@walle.cc>
 <20210526102810.GB291593@lahna.fi.intel.com>
 <YLTILUh+bPhZ4ToR@lahna.fi.intel.com>
 <YLi3/DRqGzdlosNf@lahna.fi.intel.com>
 <20210603180843.hjzynysgby3d3e5r@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210603180843.hjzynysgby3d3e5r@ti.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Jun 03, 2021 at 11:38:45PM +0530, Pratyush Yadav wrote:
> +Mark, linux-spi list,
> 
> On 03/06/21 02:07PM, Mika Westerberg wrote:
> > Hi Tudor,
> > 
> > On Mon, May 31, 2021 at 02:29:59PM +0300, Mika Westerberg wrote:
> > > Hi guys,
> > > 
> > > On Wed, May 26, 2021 at 01:28:16PM +0300, Mika Westerberg wrote:
> > > > Hi,
> > > > 
> > > > On Wed, May 26, 2021 at 11:31:58AM +0200, Michael Walle wrote:
> > > > > > Oh, I see now this commit:
> > > > > > 
> > > > > > a314f6367787 ("mtd: spi-nor: Convert cadence-quadspi to use spi-mem
> > > > > > framework")
> > > > > > 
> > > > > > So "SPI MEM" means generic SPI subsystem for memory mapped devices.
> > > > > > Unfortunately Intel controller at least is not capable of running
> > > > > > generic SPI transactions. It only supports accessing SPI-NOR flashes and
> > > > > > for those there is small set of commands that supports. I don't think it
> > > > > > is even possible to convert the driver to generic SPI subsystem.
> > > > > 
> > > > > AFAIK it stands for SPI memory device (memory mapped is not a requirement).
> > > > > Eg. spi-nxp-fspi doesn't support generic SPI devices either, but just SPI
> > > > > flashes. So I'd guess SPI MEM is exactly what you are looking for.
> > > > 
> > > > OK, I see that there is ->mem_ops that can be used to implement
> > > > different higher level commands. What I'm not seeing is that how the
> > > > child SPI flash is created using this scheme? DeviceTree and ACPI are
> > > > supported fine but what about scanning? I mean the intel_spi driver has
> > > > this:
> > > > 
> > > >   spi_nor_scan(&ispi->nor, NULL, &hwcaps);
> > > > 
> > > > But if the driver is to be moved under drivers/spi/* you can't really
> > > > call these functions anymore or can you? Or the point is to keep the
> > > > driver under controllers/ and just call spi_nor_scan(), and in addition
> > > > implement the new mem_ops?
> > > > 
> > > > Thanks in advance and sorry about many questions but there does not seem
> > > > to be a conversion guide nor any (non-DT/ACPI) examples that I can take
> > > > a look. :-)
> > > 
> > > Can you provide some guidance here? So in order to use the generic SPI
> > > subsystem with "SPI MEM" parts of it, I would need to be able to create
> > > the child SPI-NOR flash device without using ACPI or DT (as these
> > > systems do not have any ACPI/DT description), or use spi_nor_scan() but
> > > none of the driver under drivers/spi are calling it.
> > 
> > As the main SPI-NOR maintainer, what's your take on this?
> 
> I think this is more of a SPI or SPI MEM question, and less of a SPI NOR 
> question. SPI MEM would call spi_nor_probe() which in turn calls 
> spi_nor_scan().
> 
> So the question that needs to be answered is how to probe SPI MEM based
> drivers without ACPI/DT.

Yes, exactly. With ACPI/DT the SPI core handles this after the SPI
master device is registered and that would result spi_nor_probe() to be
called for the children. However, with this one there is no ACPI node
for the controller (it is PCI enumerated) so there would need to be some
way to create that child device. In the old days that would be "platform
data" but that's pretty much frowned upon these days ;-)
