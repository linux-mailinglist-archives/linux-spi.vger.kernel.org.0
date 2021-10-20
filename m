Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D65ED434670
	for <lists+linux-spi@lfdr.de>; Wed, 20 Oct 2021 10:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbhJTIIo (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 20 Oct 2021 04:08:44 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:55880 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbhJTIIn (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 20 Oct 2021 04:08:43 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 19K8656a101524;
        Wed, 20 Oct 2021 03:06:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1634717165;
        bh=GXfKDQ1ul15UO9SWMiOrsfAfNsRqeQ5arl3FvVUzDyI=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=CCnYHSICmJoJEAAvrvqF0WGrz7KOIEpmwcflgpcmTATX/qgDLP181mjMiU1Dy+cuu
         k4/o1My1Yn1pcWIA78C46aOnWA/8N1ar0XT7qKOxizMALRKfvSOx849NiUVPYmD+rw
         m0brO9muM6umiDHpMZJvoJIEZrcFgfW/l26H75gg=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 19K864UU060597
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 20 Oct 2021 03:06:05 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 20
 Oct 2021 03:06:04 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 20 Oct 2021 03:06:04 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 19K863Vd001959;
        Wed, 20 Oct 2021 03:06:04 -0500
Date:   Wed, 20 Oct 2021 13:36:03 +0530
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
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        <linux-mtd@lists.infradead.org>, <linux-spi@vger.kernel.org>
Subject: Re: [PATCH v3 2/3] mtd: spi-nor: intel-spi: Convert to SPI MEM
Message-ID: <20211020080601.c2uxccl3zaa557b2@ti.com>
References: <20211013114432.31352-1-mika.westerberg@linux.intel.com>
 <20211013114432.31352-3-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20211013114432.31352-3-mika.westerberg@linux.intel.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 13/10/21 02:44PM, Mika Westerberg wrote:
> The preferred way to implement SPI-NOR controller drivers is through SPI
> subsubsystem utilizing the SPI MEM core functions. This converts the
> Intel SPI flash controller driver over the SPI MEM by moving the driver
> from SPI-NOR subsystem to SPI subsystem and in one go make it use the
> SPI MEM functions. The driver name will be changed from intel-spi to
> spi-intel to match the convention used in the SPI subsystem.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/mtd/spi-nor/controllers/Kconfig       |  36 --
>  drivers/mtd/spi-nor/controllers/Makefile      |   3 -
>  drivers/mtd/spi-nor/controllers/intel-spi.h   |  21 --
>  drivers/spi/Kconfig                           |  39 +++
>  drivers/spi/Makefile                          |   3 +
>  .../intel-spi-pci.c => spi/spi-intel-pci.c}   |  20 +-
>  .../spi-intel-platform.c}                     |  21 +-
>  .../intel-spi.c => spi/spi-intel.c}           | 316 +++++++++++-------
>  drivers/spi/spi-intel.h                       |  19 ++
>  include/linux/mfd/lpc_ich.h                   |   2 +-
>  .../x86/{intel-spi.h => spi-intel.h}          |   6 +-
>  11 files changed, 266 insertions(+), 220 deletions(-)
>  delete mode 100644 drivers/mtd/spi-nor/controllers/intel-spi.h
>  rename drivers/{mtd/spi-nor/controllers/intel-spi-pci.c => spi/spi-intel-pci.c} (86%)
>  rename drivers/{mtd/spi-nor/controllers/intel-spi-platform.c => spi/spi-intel-platform.c} (65%)
>  rename drivers/{mtd/spi-nor/controllers/intel-spi.c => spi/spi-intel.c} (79%)
>  create mode 100644 drivers/spi/spi-intel.h
>  rename include/linux/platform_data/x86/{intel-spi.h => spi-intel.h} (89%)
> 
[...]
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

Also need to check data buswidth here?

Other than this,

Acked-by: Pratyush Yadav <p.yadav@ti.com>

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
[...]

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
