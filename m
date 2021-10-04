Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7FCF420911
	for <lists+linux-spi@lfdr.de>; Mon,  4 Oct 2021 12:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbhJDKLc (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 4 Oct 2021 06:11:32 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:41692 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbhJDKLb (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 4 Oct 2021 06:11:31 -0400
X-Greylist: delayed 977 seconds by postgrey-1.27 at vger.kernel.org; Mon, 04 Oct 2021 06:11:31 EDT
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1949qh0B024577;
        Mon, 4 Oct 2021 04:52:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1633341163;
        bh=5WdsnwlwsYMdLy7scJT5t5Q2/ywa6whHTtDTXygqv70=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=CoOXluL2bBEaFxCI+mx1VupjyQw4FA7xBhB7k0y5je+7tSqvzdA7ZVd843Wvqfc5C
         q6/3X9RtWdGebsMaDy+RempjKf56Wwx+k837/o0wUHUb0N+T3WdEBf70WdI4PRnzHK
         mglFvgrq2vfGkRKZ3I5o6D5aSwrGgv0Y45RuetOA=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1949qgup030894
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 4 Oct 2021 04:52:42 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 4
 Oct 2021 04:52:42 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 4 Oct 2021 04:52:42 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1949qfR0038100;
        Mon, 4 Oct 2021 04:52:42 -0500
Date:   Mon, 4 Oct 2021 15:22:41 +0530
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
Message-ID: <20211004095239.dyowgkyq5lnfdag2@ti.com>
References: <20210930100719.2176-1-mika.westerberg@linux.intel.com>
 <20210930100719.2176-3-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210930100719.2176-3-mika.westerberg@linux.intel.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 30/09/21 01:07PM, Mika Westerberg wrote:
> The preferred way to implement SPI-NOR controller drivers is through SPI
> subsubsystem utilizing the SPI MEM core functions. This converts the
> Intel SPI flash controller driver over the SPI MEM by moving the driver
> from SPI-NOR subsystem to SPI subsystem and in one go make it use the
> SPI MEM functions. The driver name will be changed from intel-spi to
> spi-intel to match the convention used in the SPI subsystem.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  drivers/mtd/spi-nor/controllers/Kconfig       |  36 ---
>  drivers/mtd/spi-nor/controllers/Makefile      |   3 -
>  drivers/mtd/spi-nor/controllers/intel-spi.h   |  21 --
>  drivers/spi/Kconfig                           |  38 +++
>  drivers/spi/Makefile                          |   3 +
>  .../intel-spi-pci.c => spi/spi-intel-pci.c}   |  20 +-
>  .../spi-intel-platform.c}                     |  21 +-
>  .../intel-spi.c => spi/spi-intel.c}           | 300 +++++++++++-------
>  drivers/spi/spi-intel.h                       |  19 ++
>  include/linux/mfd/lpc_ich.h                   |   2 +-
>  .../x86/{intel-spi.h => spi-intel.h}          |   6 +-
>  11 files changed, 252 insertions(+), 217 deletions(-)
>  delete mode 100644 drivers/mtd/spi-nor/controllers/intel-spi.h
>  rename drivers/{mtd/spi-nor/controllers/intel-spi-pci.c => spi/spi-intel-pci.c} (86%)
>  rename drivers/{mtd/spi-nor/controllers/intel-spi-platform.c => spi/spi-intel-platform.c} (65%)
>  rename drivers/{mtd/spi-nor/controllers/intel-spi.c => spi/spi-intel.c} (80%)
>  create mode 100644 drivers/spi/spi-intel.h
>  rename include/linux/platform_data/x86/{intel-spi.h => spi-intel.h} (89%)
> 
[...]
> +static bool intel_spi_supports_mem_op(struct spi_mem *mem,
> +				      const struct spi_mem_op *op)
> +{
> +	struct intel_spi *ispi = spi_master_get_devdata(mem->spi->master);
>  
> -			offs += erase_size;
> -			len -= erase_size;
> +	if (op->cmd.dtr)
> +		return false;
> +
> +	if (ispi->swseq_reg && ispi->locked) {
> +		int i;
> +
> +		for (i = 0; i < ARRAY_SIZE(ispi->opcodes); i++) {
> +			if (ispi->opcodes[i] == op->cmd.opcode)
> +				return true;
>  		}
>  
> -		return 0;
> +		return false;
>  	}
>  
> -	/* Not needed with HW sequencer erase, make sure it is cleared */
> -	ispi->atomic_preopcode = 0;
> +	switch (op->cmd.opcode) {
> +	case SPINOR_OP_RDID:
> +	case SPINOR_OP_RDSR:
> +	case SPINOR_OP_WRSR:
> +		return true;
>  
> -	while (len > 0) {
> -		writel(offs, ispi->base + FADDR);
> +	case SPINOR_OP_READ:
> +	case SPINOR_OP_READ_FAST:
> +	case SPINOR_OP_READ_4B:
> +	case SPINOR_OP_READ_FAST_4B:
> +		return true;

I think the checks need to be stricter here. For example, I don't see 
you pass in protocol width (dual, quad, octal, etc.) to intel_spi_read() 
so I assume it can only do a certain protocol. You need to make sure 
that other protocols are rejected here.

Similarly, you also don't pass in dummy cycles to intel_spi_read(), so I 
assume it can only do a fix number of dummy cycles. Need to make sure 
you reject unsupported ones. Same for other opcodes/cases.

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
> +
> +	return false;
> +}
>  
> -		offs += erase_size;
> -		len -= erase_size;
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
> +		else if (op->data.dir == SPI_MEM_DATA_OUT)
> +			return intel_spi_write(ispi, op->addr.val, nbytes,
> +					       op->data.buf.out);
> +		else if (op->data.dir == SPI_MEM_NO_DATA)
> +			return intel_spi_erase(ispi, opcode, op->addr.val);
> +	} else {
> +		if  (op->data.dir == SPI_MEM_DATA_IN)
> +			return intel_spi_read_reg(ispi, opcode, op->data.buf.in,
> +						  nbytes);
> +		else if (op->data.dir == SPI_MEM_DATA_OUT)
> +			return intel_spi_write_reg(ispi, opcode, op->data.buf.out,
> +						   nbytes);
> +		else if (op->data.dir == SPI_MEM_NO_DATA)
> +			return intel_spi_write_reg(ispi, opcode, NULL, 0);
>  	}
>  
> -	return 0;
> +	return -EINVAL;
> +}
> +
[...]

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
