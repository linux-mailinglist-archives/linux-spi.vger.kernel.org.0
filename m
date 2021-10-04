Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99A5B4208FA
	for <lists+linux-spi@lfdr.de>; Mon,  4 Oct 2021 12:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbhJDKJj (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 4 Oct 2021 06:09:39 -0400
Received: from mga11.intel.com ([192.55.52.93]:12170 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229825AbhJDKJj (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 4 Oct 2021 06:09:39 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10126"; a="222816821"
X-IronPort-AV: E=Sophos;i="5.85,345,1624345200"; 
   d="scan'208";a="222816821"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2021 03:07:50 -0700
X-IronPort-AV: E=Sophos;i="5.85,345,1624345200"; 
   d="scan'208";a="622044812"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2021 03:07:45 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 04 Oct 2021 13:07:43 +0300
Date:   Mon, 4 Oct 2021 13:07:43 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Mark Brown <broonie@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Lima <mauro.lima@eclypsium.com>,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH 2/3] mtd: spi-nor: intel-spi: Convert to SPI MEM
Message-ID: <YVrSbyEsSLMOu1bU@lahna>
References: <20210930100719.2176-1-mika.westerberg@linux.intel.com>
 <20210930100719.2176-3-mika.westerberg@linux.intel.com>
 <20211004095239.dyowgkyq5lnfdag2@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211004095239.dyowgkyq5lnfdag2@ti.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

On Mon, Oct 04, 2021 at 03:22:41PM +0530, Pratyush Yadav wrote:
> On 30/09/21 01:07PM, Mika Westerberg wrote:
> > The preferred way to implement SPI-NOR controller drivers is through SPI
> > subsubsystem utilizing the SPI MEM core functions. This converts the
> > Intel SPI flash controller driver over the SPI MEM by moving the driver
> > from SPI-NOR subsystem to SPI subsystem and in one go make it use the
> > SPI MEM functions. The driver name will be changed from intel-spi to
> > spi-intel to match the convention used in the SPI subsystem.
> > 
> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > ---
> >  drivers/mtd/spi-nor/controllers/Kconfig       |  36 ---
> >  drivers/mtd/spi-nor/controllers/Makefile      |   3 -
> >  drivers/mtd/spi-nor/controllers/intel-spi.h   |  21 --
> >  drivers/spi/Kconfig                           |  38 +++
> >  drivers/spi/Makefile                          |   3 +
> >  .../intel-spi-pci.c => spi/spi-intel-pci.c}   |  20 +-
> >  .../spi-intel-platform.c}                     |  21 +-
> >  .../intel-spi.c => spi/spi-intel.c}           | 300 +++++++++++-------
> >  drivers/spi/spi-intel.h                       |  19 ++
> >  include/linux/mfd/lpc_ich.h                   |   2 +-
> >  .../x86/{intel-spi.h => spi-intel.h}          |   6 +-
> >  11 files changed, 252 insertions(+), 217 deletions(-)
> >  delete mode 100644 drivers/mtd/spi-nor/controllers/intel-spi.h
> >  rename drivers/{mtd/spi-nor/controllers/intel-spi-pci.c => spi/spi-intel-pci.c} (86%)
> >  rename drivers/{mtd/spi-nor/controllers/intel-spi-platform.c => spi/spi-intel-platform.c} (65%)
> >  rename drivers/{mtd/spi-nor/controllers/intel-spi.c => spi/spi-intel.c} (80%)
> >  create mode 100644 drivers/spi/spi-intel.h
> >  rename include/linux/platform_data/x86/{intel-spi.h => spi-intel.h} (89%)
> > 
> [...]
> > +static bool intel_spi_supports_mem_op(struct spi_mem *mem,
> > +				      const struct spi_mem_op *op)
> > +{
> > +	struct intel_spi *ispi = spi_master_get_devdata(mem->spi->master);
> >  
> > -			offs += erase_size;
> > -			len -= erase_size;
> > +	if (op->cmd.dtr)
> > +		return false;
> > +
> > +	if (ispi->swseq_reg && ispi->locked) {
> > +		int i;
> > +
> > +		for (i = 0; i < ARRAY_SIZE(ispi->opcodes); i++) {
> > +			if (ispi->opcodes[i] == op->cmd.opcode)
> > +				return true;
> >  		}
> >  
> > -		return 0;
> > +		return false;
> >  	}
> >  
> > -	/* Not needed with HW sequencer erase, make sure it is cleared */
> > -	ispi->atomic_preopcode = 0;
> > +	switch (op->cmd.opcode) {
> > +	case SPINOR_OP_RDID:
> > +	case SPINOR_OP_RDSR:
> > +	case SPINOR_OP_WRSR:
> > +		return true;
> >  
> > -	while (len > 0) {
> > -		writel(offs, ispi->base + FADDR);
> > +	case SPINOR_OP_READ:
> > +	case SPINOR_OP_READ_FAST:
> > +	case SPINOR_OP_READ_4B:
> > +	case SPINOR_OP_READ_FAST_4B:
> > +		return true;
> 
> I think the checks need to be stricter here. For example, I don't see 
> you pass in protocol width (dual, quad, octal, etc.) to intel_spi_read() 
> so I assume it can only do a certain protocol. You need to make sure 
> that other protocols are rejected here.
> 
> Similarly, you also don't pass in dummy cycles to intel_spi_read(), so I 
> assume it can only do a fix number of dummy cycles. Need to make sure 
> you reject unsupported ones. Same for other opcodes/cases.

Unfortunately there is no way to tell the controller any of these. It
simply does "read" or "write" (as we command it) and internally then
uses whatever it got from the SFDP tables of the flash chip. That's why
we just claim to support all these operations and let the controller do
its thing (whatever it is).

Hope this clarifies.
