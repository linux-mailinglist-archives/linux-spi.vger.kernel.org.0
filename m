Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 739D5434813
	for <lists+linux-spi@lfdr.de>; Wed, 20 Oct 2021 11:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbhJTJoN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 20 Oct 2021 05:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbhJTJoN (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 20 Oct 2021 05:44:13 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E223C061746
        for <linux-spi@vger.kernel.org>; Wed, 20 Oct 2021 02:41:59 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 48CAA1F43FE7;
        Wed, 20 Oct 2021 10:41:57 +0100 (BST)
Date:   Wed, 20 Oct 2021 11:41:53 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
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
Message-ID: <20211020114153.0f99c5df@collabora.com>
In-Reply-To: <20211013114432.31352-3-mika.westerberg@linux.intel.com>
References: <20211013114432.31352-1-mika.westerberg@linux.intel.com>
        <20211013114432.31352-3-mika.westerberg@linux.intel.com>
Organization: Collabora
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 13 Oct 2021 14:44:31 +0300
Mika Westerberg <mika.westerberg@linux.intel.com> wrote:

> The preferred way to implement SPI-NOR controller drivers is through SPI
> subsubsystem utilizing the SPI MEM core functions. This converts the
> Intel SPI flash controller driver over the SPI MEM by moving the driver
> from SPI-NOR subsystem to SPI subsystem and in one go make it use the
> SPI MEM functions. The driver name will be changed from intel-spi to
> spi-intel to match the convention used in the SPI subsystem.
> 

I skimmed over the driver changes, and I'm skeptical about this "let's
convert all spi-nor controller drivers into spi-mem drivers even if
they don't fit the spi-mem model" strategy. Clearly, the intel
controller is much more limited than any other spi-mem controller (I
mean feature-wise not perf-wise of course). The fact that you have to
check the opcode to decide whether the operation is supported or not,
or the way you deduce when to issue an erase vs a regular read/write is
kind of hack-ish. Not saying we shouldn't support this case in spi-mem,
but it should at least be done in a more controlled way. Maybe with an
explicit array of supported spi_mem operations, and driver specific
hooks for each of these operations so anything falling outside is
clearly identified and rejected (we have this sort of things in the raw
NAND framework).

> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---

> +static bool intel_spi_supports_mem_op(struct spi_mem *mem,
> +				      const struct spi_mem_op *op)
> +{
> +	struct intel_spi *ispi = spi_master_get_devdata(mem->spi->master);
> +
> +	if (op->cmd.dtr)
> +		return false;
> +
> +	/*
> +	 * The Intel controller supports widths up to 4 but it handles
> +	 * them automatically and does not expose them to software. Here
> +	 * we accept anything up to 4.
> +	 */
> +	if (op->cmd.buswidth > 4 ||
> +	    (op->addr.nbytes && op->addr.buswidth > 4) ||
> +	    (op->dummy.nbytes && op->dummy.buswidth > 4))
> +		return false;
> +
> +	if (ispi->swseq_reg && ispi->locked) {
> +		int i;
> +
> +		/* Check if it is in the locked opcodes list */
> +		for (i = 0; i < ARRAY_SIZE(ispi->opcodes); i++) {
> +			if (ispi->opcodes[i] == op->cmd.opcode)
> +				goto check_opcode;
>  		}
>  
> -		return 0;
> +		return false;
>  	}
>  
> -	/* Not needed with HW sequencer erase, make sure it is cleared */
> -	ispi->atomic_preopcode = 0;
> +check_opcode:
> +	switch (op->cmd.opcode) {
> +	case SPINOR_OP_RDID:
> +	case SPINOR_OP_RDSR:
> +	case SPINOR_OP_WRSR:
> +		return true;

Ouch. I hate how spi-nor specific stuff leak into the supposedly
spi-mem generic driver. Now if we want to allow such specialization, we
should at least make sure the whole operation is consistent instead of
checking the opcode, address, dummy and data cycles separately.

>  
> -	while (len > 0) {
> -		writel(offs, ispi->base + FADDR);
> +	case SPINOR_OP_READ:
> +	case SPINOR_OP_READ_FAST:
> +	case SPINOR_OP_READ_4B:
> +	case SPINOR_OP_READ_FAST_4B:
> +		return true;
>  
> -		val = readl(ispi->base + HSFSTS_CTL);
> -		val &= ~(HSFSTS_CTL_FDBC_MASK | HSFSTS_CTL_FCYCLE_MASK);
> -		val |= HSFSTS_CTL_AEL | HSFSTS_CTL_FCERR | HSFSTS_CTL_FDONE;
> -		val |= cmd;
> -		val |= HSFSTS_CTL_FGO;
> -		writel(val, ispi->base + HSFSTS_CTL);
> +	case SPINOR_OP_PP:
> +	case SPINOR_OP_PP_4B:
> +	case SPINOR_OP_WREN:
> +	case SPINOR_OP_WRDI:
> +		return true;
>  
> -		ret = intel_spi_wait_hw_busy(ispi);
> -		if (ret)
> -			return ret;
> +	case SPINOR_OP_SE:
> +	case SPINOR_OP_SE_4B:
> +		return ispi->erase_64k;
>  
> -		status = readl(ispi->base + HSFSTS_CTL);
> -		if (status & HSFSTS_CTL_FCERR)
> -			return -EIO;
> -		else if (status & HSFSTS_CTL_AEL)
> -			return -EACCES;
> +	case SPINOR_OP_BE_4K:
> +	case SPINOR_OP_BE_4K_4B:
> +		return true;
> +	}
>  
> -		offs += erase_size;
> -		len -= erase_size;
> +	return false;
> +}
> +
> +static int intel_spi_exec_mem_op(struct spi_mem *mem, const struct spi_mem_op *op)
> +{
> +	struct intel_spi *ispi = spi_master_get_devdata(mem->spi->master);
> +	size_t nbytes = op->data.nbytes;
> +	u8 opcode = op->cmd.opcode;
> +
> +	if (op->addr.nbytes) {
> +		if  (op->data.dir == SPI_MEM_DATA_IN)
> +			return intel_spi_read(ispi, op->addr.val, nbytes,
> +					      op->data.buf.in);
> +		if (op->data.dir == SPI_MEM_DATA_OUT)
> +			return intel_spi_write(ispi, op->addr.val, nbytes,
> +					       op->data.buf.out);
> +		if (op->data.dir == SPI_MEM_NO_DATA)
> +			return intel_spi_erase(ispi, opcode, op->addr.val);

That's risky IMHO, how can you be sure that NO_DATA means erase? Again,
it looks like the whole operation should be checked, not just the data
field.

> +	} else {
> +		if  (op->data.dir == SPI_MEM_DATA_IN)
> +			return intel_spi_read_reg(ispi, opcode, op->data.buf.in,
> +						  nbytes);
> +		if (op->data.dir == SPI_MEM_DATA_OUT)
> +			return intel_spi_write_reg(ispi, opcode, op->data.buf.out,
> +						   nbytes);
> +		if (op->data.dir == SPI_MEM_NO_DATA)
> +			return intel_spi_write_reg(ispi, opcode, NULL, 0);
>  	}
>  
> -	return 0;
> +	return -EINVAL;
> +}
> +
