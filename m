Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 257CC422286
	for <lists+linux-spi@lfdr.de>; Tue,  5 Oct 2021 11:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232723AbhJEJni (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 5 Oct 2021 05:43:38 -0400
Received: from mga06.intel.com ([134.134.136.31]:40560 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232658AbhJEJng (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 5 Oct 2021 05:43:36 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10127"; a="286576438"
X-IronPort-AV: E=Sophos;i="5.85,348,1624345200"; 
   d="scan'208";a="286576438"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2021 02:41:46 -0700
X-IronPort-AV: E=Sophos;i="5.85,348,1624345200"; 
   d="scan'208";a="438633858"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2021 02:41:42 -0700
Received: by lahna (sSMTP sendmail emulation); Tue, 05 Oct 2021 12:41:39 +0300
Date:   Tue, 5 Oct 2021 12:41:39 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Mark Brown <broonie@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Michael Walle <michael@walle.cc>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Lima <mauro.lima@eclypsium.com>,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        "open list:MEMORY TECHNOLOGY..." <linux-mtd@lists.infradead.org>,
        linux-spi <linux-spi@vger.kernel.org>
Subject: Re: [PATCH 2/3] mtd: spi-nor: intel-spi: Convert to SPI MEM
Message-ID: <YVwd09KZwOQVvh4g@lahna>
References: <20210930100719.2176-1-mika.westerberg@linux.intel.com>
 <20210930100719.2176-3-mika.westerberg@linux.intel.com>
 <CAHp75VdtOHn4ED-ixdDngBQw10OnKmbtTv=ydLs6dYbkjyqW4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VdtOHn4ED-ixdDngBQw10OnKmbtTv=ydLs6dYbkjyqW4Q@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Andy,

On Mon, Oct 04, 2021 at 05:29:47PM +0300, Andy Shevchenko wrote:
> On Thu, Sep 30, 2021 at 1:08 PM Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> >
> > The preferred way to implement SPI-NOR controller drivers is through SPI
> > subsubsystem utilizing the SPI MEM core functions. This converts the
> > Intel SPI flash controller driver over the SPI MEM by moving the driver
> > from SPI-NOR subsystem to SPI subsystem and in one go make it use the
> > SPI MEM functions. The driver name will be changed from intel-spi to
> > spi-intel to match the convention used in the SPI subsystem.
> 
> ...
> 
> > +config SPI_INTEL_PCI
> > +       tristate "Intel PCH/PCU SPI flash PCI driver (DANGEROUS)"
> > +       depends on PCI && (X86 || COMPILE_TEST)
> 
> Perhaps two entries, one of which will be the same as for platform case?

Sure will do that in v2.

> > +       depends on SPI_MEM
> > +       select SPI_INTEL
> > +       help
> > +         This enables PCI support for the Intel PCH/PCU SPI controller in
> > +         master mode. This controller is present in modern Intel hardware
> > +         and is used to hold BIOS and other persistent settings. Using
> > +         this driver it is possible to upgrade BIOS directly from Linux.
> > +
> > +         Say N here unless you know what you are doing. Overwriting the
> > +         SPI flash may render the system unbootable.
> > +
> > +         To compile this driver as a module, choose M here: the module
> > +         will be called spi-intel-pci.
> > +
> > +config SPI_INTEL_PLATFORM
> > +       tristate "Intel PCH/PCU SPI flash platform driver (DANGEROUS)"
> > +       depends on X86 || COMPILE_TEST
> > +       depends on SPI_MEM
> > +       select SPI_INTEL
> > +       help
> > +         This enables platform support for the Intel PCH/PCU SPI
> > +         controller in master mode. This controller is present in modern
> > +         Intel hardware and is used to hold BIOS and other persistent
> > +         settings. Using this driver it is possible to upgrade BIOS
> > +         directly from Linux.
> > +
> > +         Say N here unless you know what you are doing. Overwriting the
> > +         SPI flash may render the system unbootable.
> > +
> > +         To compile this driver as a module, choose M here: the module
> > +         will be called spi-intel-platform.
> 
> ...
> 
> + Blank line ?

OK

> 
> >  #include <linux/mtd/partitions.h>
> >  #include <linux/mtd/spi-nor.h>
> 
> + Blank line?

OK

> > +#include <linux/spi/flash.h>
> > +#include <linux/spi/spi.h>
> > +#include <linux/spi/spi-mem.h>
> 
> The rationale is to show that we use two sub(sub)sytems here.

Yup, got it.

> ...
> 
> > -                       dev_err(ispi->dev, "read error: %llx: %#x\n", from,
> > +                       dev_err(ispi->dev, "read error: %x: %#x\n", from,
> >                                 status);
> 
> Now one line?
> 
> ...
> 
> > -                       dev_err(ispi->dev, "write error: %llx: %#x\n", to,
> > +                       dev_err(ispi->dev, "write error: %x: %#x\n", to,
> >                                 status);
> 
> Ditto.

Sure for both.
> 
> ...
> 
> > +               ret = intel_spi_sw_cycle(ispi, opcode, 0,
> > +                                        OPTYPE_WRITE_WITH_ADDR);
> > +               return ret ? ret : 0;
> 
> Why not simply return intel_spi_dw_cycle(...); ?

Good point. Will fix that.

> ...
> 
> > +       val = readl(ispi->base + HSFSTS_CTL);
> > +       val &= ~(HSFSTS_CTL_FDBC_MASK | HSFSTS_CTL_FCYCLE_MASK);
> > +       val |= HSFSTS_CTL_AEL | HSFSTS_CTL_FCERR | HSFSTS_CTL_FDONE;
> 
> > +       val |= cmd;
> > +       val |= HSFSTS_CTL_FGO;
> 
> Maybe swap these lines to group constants?

OK

> ...
> 
> > +       status = readl(ispi->base + HSFSTS_CTL);
> > +       if (status & HSFSTS_CTL_FCERR)
> > +               return -EIO;
> 
> > +       else if (status & HSFSTS_CTL_AEL)
> 
> Redundant 'else'

Right.

> > +               return -EACCES;
> 
> ...
> 
> > +static int intel_spi_exec_mem_op(struct spi_mem *mem, const struct spi_mem_op *op)
> > +{
> > +       struct intel_spi *ispi = spi_master_get_devdata(mem->spi->master);
> > +       size_t nbytes = op->data.nbytes;
> > +       u8 opcode = op->cmd.opcode;
> > +
> > +       if (op->addr.nbytes) {
> > +               if  (op->data.dir == SPI_MEM_DATA_IN)
> > +                       return intel_spi_read(ispi, op->addr.val, nbytes,
> > +                                             op->data.buf.in);
> 
> > +               else if (op->data.dir == SPI_MEM_DATA_OUT)
> 
> Redundant 'else' here and nearby.

Right. I'll fix these in v2.

> > +                       return intel_spi_write(ispi, op->addr.val, nbytes,
> > +                                              op->data.buf.out);
> > +               else if (op->data.dir == SPI_MEM_NO_DATA)
> > +                       return intel_spi_erase(ispi, opcode, op->addr.val);
> > +       } else {
> > +               if  (op->data.dir == SPI_MEM_DATA_IN)
> > +                       return intel_spi_read_reg(ispi, opcode, op->data.buf.in,
> > +                                                 nbytes);
> > +               else if (op->data.dir == SPI_MEM_DATA_OUT)
> > +                       return intel_spi_write_reg(ispi, opcode, op->data.buf.out,
> > +                                                  nbytes);
> > +               else if (op->data.dir == SPI_MEM_NO_DATA)
> > +                       return intel_spi_write_reg(ispi, opcode, NULL, 0);
> >         }
> 
> > +       return -EINVAL;
> > +}
> 
> -- 
> With Best Regards,
> Andy Shevchenko
