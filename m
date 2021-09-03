Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA4FD400565
	for <lists+linux-spi@lfdr.de>; Fri,  3 Sep 2021 20:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349675AbhICS6B (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 3 Sep 2021 14:58:01 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:51594 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349372AbhICS6B (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 3 Sep 2021 14:58:01 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 183IuuMK009100;
        Fri, 3 Sep 2021 13:56:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1630695416;
        bh=nf5AqUkVW9t9JU95IDdR1mQyrisWt+ppFpgZCF/soRU=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=HkQGLicOlhIuoS7Js9LH09I5Kx9GMGT4blh5kJS5Aty0z4enr5Szz4VwaUt9QlB1Z
         id9nyRoN8rUW3I0HwJ8fw2beE1OWFIu1kEgI1E3RCUGmjUyGxtwWgxqmXKizIcirgt
         GayHl42u+uWJTvu+RgfkFBwCN0ARaRx7kcSh+Uvw=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 183IuuPH106923
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 3 Sep 2021 13:56:56 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 3
 Sep 2021 13:56:56 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 3 Sep 2021 13:56:56 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 183IutvB017581;
        Fri, 3 Sep 2021 13:56:56 -0500
Date:   Sat, 4 Sep 2021 00:26:55 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Parshuram Thombare <pthombar@cadence.com>
CC:     <broonie@kernel.org>, <lukas@wunner.de>, <robh+dt@kernel.org>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <jpawar@cadence.com>,
        <mparab@cadence.com>, Konrad Kociolek <konrad@cadence.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH v3 2/2] spi: cadence: add support for Cadence XSPI
 controller
Message-ID: <20210903185653.7vrfn4qfzvuiaiq2@ti.com>
References: <1630499755-18751-1-git-send-email-pthombar@cadence.com>
 <1630499858-20456-1-git-send-email-pthombar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1630499858-20456-1-git-send-email-pthombar@cadence.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

+ Tudor, Vignesh,

On 01/09/21 02:37PM, Parshuram Thombare wrote:
> This patch adds driver for Cadence's XSPI controller.
> It supports 3 work modes.
> 1. ACMD (auto command) work mode
>     ACMD name is because it uses auto command engine in the controller.
>     It further has 2 modes PIO and CDMA (command DMA).
>     The CDMA work mode is dedicated for high-performance application
>     where very low software overhead is required. In this mode the
>     Command Engine is programmed by the series of linked descriptors
>     stored in system memory. These descriptors provide commands to execute
>     and store status information for finished commands.
>     The PIO mode work mode is dedicated for single operation where
>     constructing a linked list of descriptors would require too
>     much effort.
> 2. STIG (Software Triggered Instruction Generator) work mode
>     In STIG mode, controller sends low-level instructions to memory.
>     Each instruction is 128-bit width. There is special instruction
>     DataSequence which carries information about data phase.
>     Driver uses Slave DMA interface to transfer data as only this
>     interface can be used in STIG work mode.
> 3. Direct work mode
>     This work mode allows sending data without invoking any command through
>     the slave interface.
> Currently ACMD PIO mode is used for NOR flash read, program, erase
> operations, all other operations are handled in STIG work mode.

Thanks. The commit message is much nicer now!

> 
> Signed-off-by: Konrad Kociolek <konrad@cadence.com>
> Signed-off-by: Jayshri Pawar <jpawar@cadence.com>
> Signed-off-by: Parshuram Thombare <pthombar@cadence.com>
> ---
>  drivers/spi/Kconfig            |  11 +
>  drivers/spi/Makefile           |   1 +
>  drivers/spi/spi-cadence-xspi.c | 837 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 849 insertions(+)
>  create mode 100644 drivers/spi/spi-cadence-xspi.c
> 
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index e71a4c5..874f7aa 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -228,6 +228,17 @@ config SPI_CADENCE_QUADSPI
>  	  device with a Cadence QSPI controller and want to access the
>  	  Flash as an MTD device.
>  
> +config SPI_CADENCE_XSPI
> +	tristate "Cadence XSPI controller"
> +	depends on (OF || COMPILE_TEST) && HAS_IOMEM

Depends on SPI_MEM as well.

> +	help
> +	  Enable support for the Cadence XSPI Flash controller.
> +
> +	  Cadence XSPI is a specialized controller for connecting an SPI
> +	  Flash over upto 8bit wide bus. Enable this option if you have a
> +	  device with a Cadence XSPI controller and want to access the
> +	  Flash as an MTD device.
> +
>  config SPI_CLPS711X
>  	tristate "CLPS711X host SPI controller"
>  	depends on ARCH_CLPS711X || COMPILE_TEST
> diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
> index 13e54c4..93229a8 100644
> --- a/drivers/spi/Makefile
> +++ b/drivers/spi/Makefile
> @@ -21,6 +21,7 @@ obj-$(CONFIG_SPI_AR934X)		+= spi-ar934x.o
>  obj-$(CONFIG_SPI_ARMADA_3700)		+= spi-armada-3700.o
>  obj-$(CONFIG_SPI_ATMEL)			+= spi-atmel.o
>  obj-$(CONFIG_SPI_ATMEL_QUADSPI)		+= atmel-quadspi.o
> +obj-$(CONFIG_SPI_CADENCE_XSPI)		+= spi-cadence-xspi.o
>  obj-$(CONFIG_SPI_AT91_USART)		+= spi-at91-usart.o
>  obj-$(CONFIG_SPI_ATH79)			+= spi-ath79.o
>  obj-$(CONFIG_SPI_AU1550)		+= spi-au1550.o
> diff --git a/drivers/spi/spi-cadence-xspi.c b/drivers/spi/spi-cadence-xspi.c
> new file mode 100644
> index 0000000..c2b33e2
> --- /dev/null
> +++ b/drivers/spi/spi-cadence-xspi.c
> @@ -0,0 +1,837 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Cadence XSPI flash controller driver
> + *
> + * Copyright (C) 2020-21 Cadence
> + *
> + */
> +#include <linux/completion.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/errno.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/spi/spi.h>
> +#include <linux/mtd/spi-nor.h>

Umm, this seems wrong to me. SPI MEM based drivers should generally not 
need to know anything about the subsystem driving them. Why do you need 
to include this?

More on this below.

> +#include <linux/bitfield.h>
> +#include <linux/limits.h>
> +#include <linux/log2.h>
> +
[...]
> +static int cdns_xspi_mem_op(struct cdns_xspi_dev *cdns_xspi,
> +			    struct spi_mem *mem,
> +			    const struct spi_mem_op *op)
> +{
> +	struct spi_driver *spidrv = to_spi_driver(mem->spi->dev.driver);
> +	enum spi_mem_data_dir dir = op->data.dir;
> +
> +	if (cdns_xspi->cur_cs != mem->spi->chip_select)
> +		cdns_xspi->cur_cs = mem->spi->chip_select;
> +
> +	if (!strstr(spidrv->driver.name, "nor") ||

I commented on this last time around as well. This does not look right 
at all. A SPI MEM based driver should *not* need to know anything about 
the subsystem driving it. That is the entire point of the API.

The controller seems to be able to extract the read and write opcodes 
from the SFDP on its own since you don't pass in that information to 
cdns_xspi_nor_read(). It looks like it is tied very heavily to a NOR 
flash, and I am not sure if it can really be used with a NAND flash, or 
something else entirely.

Which makes me wonder how we should handle controllers like these. I 
don't think they fit in very well with the SPI MEM model, since they 
can't execute arbitrary SPI MEM commands very well. At the same time we 
are trying to get rid of mtd/spi-nor/controllers. Dunno...

Mark, Tudor, Vignesh, any ideas?

> +	    (!op->addr.buswidth && !op->addr.nbytes && !op->addr.val)) {
> +		return cdns_xspi_send_stig_command(cdns_xspi, op,
> +						   (dir != SPI_MEM_NO_DATA));
> +	} else {
> +		if (dir == SPI_MEM_DATA_IN)
> +			return cdns_xspi_nor_read(cdns_xspi, op->addr.val,
> +						  op->data.nbytes,
> +						  op->data.buf.in);
> +		else if (dir == SPI_MEM_DATA_OUT)
> +			return cdns_xspi_nor_write(cdns_xspi, op->addr.val,
> +						   op->data.nbytes,
> +						   op->data.buf.out);
> +		else
> +			return cdns_xspi_nor_erase(cdns_xspi, op->addr.val);
> +	}
> +}
> +
> +static int cdns_xspi_mem_op_execute(struct spi_mem *mem,
> +				    const struct spi_mem_op *op)
> +{
> +	struct cdns_xspi_dev *cdns_xspi =
> +		spi_master_get_devdata(mem->spi->master);
> +	int ret = 0;
> +
> +	ret = cdns_xspi_mem_op(cdns_xspi, mem, op);
> +
> +	return ret;
> +}
> +
> +static const struct spi_controller_mem_ops cadence_xspi_mem_ops = {
> +	.exec_op = cdns_xspi_mem_op_execute,
> +};
> +

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
