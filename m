Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1281425330
	for <lists+linux-spi@lfdr.de>; Thu,  7 Oct 2021 14:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241451AbhJGMjB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 7 Oct 2021 08:39:01 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:51412 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241434AbhJGMi7 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 7 Oct 2021 08:38:59 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 197CaODu102544;
        Thu, 7 Oct 2021 07:36:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1633610184;
        bh=pzh+3XNNgPH1GP/1wHzKrd+ZroKZVBls9gsJCZis+JU=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=cjn3129sBIlzuiO/8ycZtPgG8ryjyYackfj93aA4F8Z6SzcNWqzEtYy9TNF5lRmXn
         LRwLr5+PVbiV6z40GiKc7d/bE7VDbA2J6XA4qUd0Uh/qu3EH2R+1/BZPIUYeEBOvgB
         ALbS99WeVpJ2swDcgvau3jR5sUjWnUpasgfWPNRA=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 197CaOPs078494
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 7 Oct 2021 07:36:24 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 7
 Oct 2021 07:36:24 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 7 Oct 2021 07:36:24 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 197CaNgM012093;
        Thu, 7 Oct 2021 07:36:24 -0500
Date:   Thu, 7 Oct 2021 18:06:23 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
CC:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Mark Brown <broonie@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Lima <mauro.lima@eclypsium.com>,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        <linux-mtd@lists.infradead.org>, <linux-spi@vger.kernel.org>
Subject: Re: [PATCH 2/3] mtd: spi-nor: intel-spi: Convert to SPI MEM
Message-ID: <20211007123621.ld4aqasr3hlwq2c7@ti.com>
References: <20210930100719.2176-1-mika.westerberg@linux.intel.com>
 <20210930100719.2176-3-mika.westerberg@linux.intel.com>
 <20211004095239.dyowgkyq5lnfdag2@ti.com>
 <YVrSbyEsSLMOu1bU@lahna>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YVrSbyEsSLMOu1bU@lahna>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 04/10/21 01:07PM, Mika Westerberg wrote:
> Hi,
> 
> On Mon, Oct 04, 2021 at 03:22:41PM +0530, Pratyush Yadav wrote:
> > On 30/09/21 01:07PM, Mika Westerberg wrote:
> > > The preferred way to implement SPI-NOR controller drivers is through SPI
> > > subsubsystem utilizing the SPI MEM core functions. This converts the
> > > Intel SPI flash controller driver over the SPI MEM by moving the driver
> > > from SPI-NOR subsystem to SPI subsystem and in one go make it use the
> > > SPI MEM functions. The driver name will be changed from intel-spi to
> > > spi-intel to match the convention used in the SPI subsystem.
> > > 
> > > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > > ---
> > >  drivers/mtd/spi-nor/controllers/Kconfig       |  36 ---
> > >  drivers/mtd/spi-nor/controllers/Makefile      |   3 -
> > >  drivers/mtd/spi-nor/controllers/intel-spi.h   |  21 --
> > >  drivers/spi/Kconfig                           |  38 +++
> > >  drivers/spi/Makefile                          |   3 +
> > >  .../intel-spi-pci.c => spi/spi-intel-pci.c}   |  20 +-
> > >  .../spi-intel-platform.c}                     |  21 +-
> > >  .../intel-spi.c => spi/spi-intel.c}           | 300 +++++++++++-------
> > >  drivers/spi/spi-intel.h                       |  19 ++
> > >  include/linux/mfd/lpc_ich.h                   |   2 +-
> > >  .../x86/{intel-spi.h => spi-intel.h}          |   6 +-
> > >  11 files changed, 252 insertions(+), 217 deletions(-)
> > >  delete mode 100644 drivers/mtd/spi-nor/controllers/intel-spi.h
> > >  rename drivers/{mtd/spi-nor/controllers/intel-spi-pci.c => spi/spi-intel-pci.c} (86%)
> > >  rename drivers/{mtd/spi-nor/controllers/intel-spi-platform.c => spi/spi-intel-platform.c} (65%)
> > >  rename drivers/{mtd/spi-nor/controllers/intel-spi.c => spi/spi-intel.c} (80%)
> > >  create mode 100644 drivers/spi/spi-intel.h
> > >  rename include/linux/platform_data/x86/{intel-spi.h => spi-intel.h} (89%)
> > > 
> > [...]
> > > +static bool intel_spi_supports_mem_op(struct spi_mem *mem,
> > > +				      const struct spi_mem_op *op)
> > > +{
> > > +	struct intel_spi *ispi = spi_master_get_devdata(mem->spi->master);
> > >  
> > > -			offs += erase_size;
> > > -			len -= erase_size;
> > > +	if (op->cmd.dtr)
> > > +		return false;
> > > +
> > > +	if (ispi->swseq_reg && ispi->locked) {
> > > +		int i;
> > > +
> > > +		for (i = 0; i < ARRAY_SIZE(ispi->opcodes); i++) {
> > > +			if (ispi->opcodes[i] == op->cmd.opcode)
> > > +				return true;
> > >  		}
> > >  
> > > -		return 0;
> > > +		return false;
> > >  	}
> > >  
> > > -	/* Not needed with HW sequencer erase, make sure it is cleared */
> > > -	ispi->atomic_preopcode = 0;
> > > +	switch (op->cmd.opcode) {
> > > +	case SPINOR_OP_RDID:
> > > +	case SPINOR_OP_RDSR:
> > > +	case SPINOR_OP_WRSR:
> > > +		return true;
> > >  
> > > -	while (len > 0) {
> > > -		writel(offs, ispi->base + FADDR);
> > > +	case SPINOR_OP_READ:
> > > +	case SPINOR_OP_READ_FAST:
> > > +	case SPINOR_OP_READ_4B:
> > > +	case SPINOR_OP_READ_FAST_4B:
> > > +		return true;
> > 
> > I think the checks need to be stricter here. For example, I don't see 
> > you pass in protocol width (dual, quad, octal, etc.) to intel_spi_read() 
> > so I assume it can only do a certain protocol. You need to make sure 
> > that other protocols are rejected here.
> > 
> > Similarly, you also don't pass in dummy cycles to intel_spi_read(), so I 
> > assume it can only do a fix number of dummy cycles. Need to make sure 
> > you reject unsupported ones. Same for other opcodes/cases.
> 
> Unfortunately there is no way to tell the controller any of these. It
> simply does "read" or "write" (as we command it) and internally then
> uses whatever it got from the SFDP tables of the flash chip. That's why
> we just claim to support all these operations and let the controller do
> its thing (whatever it is).

That is not ideal. SPI NOR uses this to negotiate the best available 
protocol with the controller. Say you have a flash that is capable of 
octal mode but the controller can only support quad mode. Your driver 
will happily tell SPI NOR that it can support octal mode. I think you 
should check the SPI mode bits to make sure the protocol bus width is 
supported at least (see spi_check_buswidth_req() in spi-mem.c).

As for opcodes, is there no way to find out what opcodes the controller 
discovered via SFDP? Maybe we can't change them, but can we at least 
take a peek at them?

I think this has problems similar to the Cadence xSPI controller [0].

Sorry I only replied to this after you posted a new version. It got lost 
in the heap of emails in my inbox :-(

[0] https://patchwork.kernel.org/project/spi-devel-general/patch/1630499858-20456-1-git-send-email-pthombar@cadence.com/

> 
> Hope this clarifies.

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
