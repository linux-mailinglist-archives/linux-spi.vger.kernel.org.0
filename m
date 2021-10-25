Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F86F4392F5
	for <lists+linux-spi@lfdr.de>; Mon, 25 Oct 2021 11:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232713AbhJYJtb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 25 Oct 2021 05:49:31 -0400
Received: from mga06.intel.com ([134.134.136.31]:37161 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232745AbhJYJsB (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 25 Oct 2021 05:48:01 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10147"; a="290445099"
X-IronPort-AV: E=Sophos;i="5.87,179,1631602800"; 
   d="scan'208";a="290445099"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2021 02:45:38 -0700
X-IronPort-AV: E=Sophos;i="5.87,179,1631602800"; 
   d="scan'208";a="554151039"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2021 02:45:34 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 25 Oct 2021 12:43:20 +0300
Date:   Mon, 25 Oct 2021 12:43:20 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Boris Brezillon <boris.brezillon@collabora.com>
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
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH v3 2/3] mtd: spi-nor: intel-spi: Convert to SPI MEM
Message-ID: <YXZ8OJFICqYSatZX@lahna>
References: <20211013114432.31352-1-mika.westerberg@linux.intel.com>
 <20211013114432.31352-3-mika.westerberg@linux.intel.com>
 <20211020114153.0f99c5df@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211020114153.0f99c5df@collabora.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Oct 20, 2021 at 11:41:53AM +0200, Boris Brezillon wrote:
> On Wed, 13 Oct 2021 14:44:31 +0300
> Mika Westerberg <mika.westerberg@linux.intel.com> wrote:
> 
> > The preferred way to implement SPI-NOR controller drivers is through SPI
> > subsubsystem utilizing the SPI MEM core functions. This converts the
> > Intel SPI flash controller driver over the SPI MEM by moving the driver
> > from SPI-NOR subsystem to SPI subsystem and in one go make it use the
> > SPI MEM functions. The driver name will be changed from intel-spi to
> > spi-intel to match the convention used in the SPI subsystem.
> > 
> 
> I skimmed over the driver changes, and I'm skeptical about this "let's
> convert all spi-nor controller drivers into spi-mem drivers even if
> they don't fit the spi-mem model" strategy. Clearly, the intel
> controller is much more limited than any other spi-mem controller (I
> mean feature-wise not perf-wise of course). The fact that you have to
> check the opcode to decide whether the operation is supported or not,
> or the way you deduce when to issue an erase vs a regular read/write is
> kind of hack-ish. Not saying we shouldn't support this case in spi-mem,
> but it should at least be done in a more controlled way. Maybe with an
> explicit array of supported spi_mem operations, and driver specific
> hooks for each of these operations so anything falling outside is
> clearly identified and rejected (we have this sort of things in the raw
> NAND framework).

I'm not fan of this either but this was requirement from the SPI-NOR
maintainers before any new features can be added, and we have a bunch of
new hardware that needs to be supported :(

Sure, I can take a look at the array you suggest if that helps to get
things moving. Any objections anyone for doing this?

> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> 
> > +static bool intel_spi_supports_mem_op(struct spi_mem *mem,
> > +				      const struct spi_mem_op *op)
> > +{
> > +	struct intel_spi *ispi = spi_master_get_devdata(mem->spi->master);
> > +
> > +	if (op->cmd.dtr)
> > +		return false;
> > +
> > +	/*
> > +	 * The Intel controller supports widths up to 4 but it handles
> > +	 * them automatically and does not expose them to software. Here
> > +	 * we accept anything up to 4.
> > +	 */
> > +	if (op->cmd.buswidth > 4 ||
> > +	    (op->addr.nbytes && op->addr.buswidth > 4) ||
> > +	    (op->dummy.nbytes && op->dummy.buswidth > 4))
> > +		return false;
> > +
> > +	if (ispi->swseq_reg && ispi->locked) {
> > +		int i;
> > +
> > +		/* Check if it is in the locked opcodes list */
> > +		for (i = 0; i < ARRAY_SIZE(ispi->opcodes); i++) {
> > +			if (ispi->opcodes[i] == op->cmd.opcode)
> > +				goto check_opcode;
> >  		}
> >  
> > -		return 0;
> > +		return false;
> >  	}
> >  
> > -	/* Not needed with HW sequencer erase, make sure it is cleared */
> > -	ispi->atomic_preopcode = 0;
> > +check_opcode:
> > +	switch (op->cmd.opcode) {
> > +	case SPINOR_OP_RDID:
> > +	case SPINOR_OP_RDSR:
> > +	case SPINOR_OP_WRSR:
> > +		return true;
> 
> Ouch. I hate how spi-nor specific stuff leak into the supposedly
> spi-mem generic driver. Now if we want to allow such specialization, we
> should at least make sure the whole operation is consistent instead of
> checking the opcode, address, dummy and data cycles separately.

OK.

> > -	while (len > 0) {
> > -		writel(offs, ispi->base + FADDR);
> > +	case SPINOR_OP_READ:
> > +	case SPINOR_OP_READ_FAST:
> > +	case SPINOR_OP_READ_4B:
> > +	case SPINOR_OP_READ_FAST_4B:
> > +		return true;
> >  
> > -		val = readl(ispi->base + HSFSTS_CTL);
> > -		val &= ~(HSFSTS_CTL_FDBC_MASK | HSFSTS_CTL_FCYCLE_MASK);
> > -		val |= HSFSTS_CTL_AEL | HSFSTS_CTL_FCERR | HSFSTS_CTL_FDONE;
> > -		val |= cmd;
> > -		val |= HSFSTS_CTL_FGO;
> > -		writel(val, ispi->base + HSFSTS_CTL);
> > +	case SPINOR_OP_PP:
> > +	case SPINOR_OP_PP_4B:
> > +	case SPINOR_OP_WREN:
> > +	case SPINOR_OP_WRDI:
> > +		return true;
> >  
> > -		ret = intel_spi_wait_hw_busy(ispi);
> > -		if (ret)
> > -			return ret;
> > +	case SPINOR_OP_SE:
> > +	case SPINOR_OP_SE_4B:
> > +		return ispi->erase_64k;
> >  
> > -		status = readl(ispi->base + HSFSTS_CTL);
> > -		if (status & HSFSTS_CTL_FCERR)
> > -			return -EIO;
> > -		else if (status & HSFSTS_CTL_AEL)
> > -			return -EACCES;
> > +	case SPINOR_OP_BE_4K:
> > +	case SPINOR_OP_BE_4K_4B:
> > +		return true;
> > +	}
> >  
> > -		offs += erase_size;
> > -		len -= erase_size;
> > +	return false;
> > +}
> > +
> > +static int intel_spi_exec_mem_op(struct spi_mem *mem, const struct spi_mem_op *op)
> > +{
> > +	struct intel_spi *ispi = spi_master_get_devdata(mem->spi->master);
> > +	size_t nbytes = op->data.nbytes;
> > +	u8 opcode = op->cmd.opcode;
> > +
> > +	if (op->addr.nbytes) {
> > +		if  (op->data.dir == SPI_MEM_DATA_IN)
> > +			return intel_spi_read(ispi, op->addr.val, nbytes,
> > +					      op->data.buf.in);
> > +		if (op->data.dir == SPI_MEM_DATA_OUT)
> > +			return intel_spi_write(ispi, op->addr.val, nbytes,
> > +					       op->data.buf.out);
> > +		if (op->data.dir == SPI_MEM_NO_DATA)
> > +			return intel_spi_erase(ispi, opcode, op->addr.val);
> 
> That's risky IMHO, how can you be sure that NO_DATA means erase? Again,
> it looks like the whole operation should be checked, not just the data
> field.

intel_spi_erase() does further checks based on the opcode:

        switch (opcode) {
        case SPINOR_OP_SE:
                cmd = HSFSTS_CTL_FCYCLE_ERASE_64K;
                break;

        case SPINOR_OP_BE_4K:
                cmd = HSFSTS_CTL_FCYCLE_ERASE;
                break;

        default:
                return -EINVAL;
        }

I should probably add comment on the caller to make it clear though.
