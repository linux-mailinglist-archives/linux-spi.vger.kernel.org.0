Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18C0BF2738
	for <lists+linux-spi@lfdr.de>; Thu,  7 Nov 2019 06:43:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726095AbfKGFno (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 7 Nov 2019 00:43:44 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:53308 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbfKGFnn (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 7 Nov 2019 00:43:43 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id xA75hZQM101891;
        Wed, 6 Nov 2019 23:43:35 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1573105415;
        bh=8v/LIsfQTRe/5vt9kk3vGd7bzdqqu56uD04fOknlffE=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=xzeker+m39zH6JbRvT4fjH3/DRKrP0l7zcIpokAlp1lt9pG4o3Zef3RMD5itznnOA
         znmeAY9qJbbg4jB20JSkZTK7mtk1kA5GAHtDqvD6CY6X3QS2TiozoqA4mbhb9WS+OZ
         faQzOLBskphw6RF5qiBNJ3HTLsHiwgtPxrH+v9Ag=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xA75hZY1126332
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 6 Nov 2019 23:43:35 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 6 Nov
 2019 23:43:19 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 6 Nov 2019 23:43:19 -0600
Received: from [172.24.145.136] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id xA75hWWr060101;
        Wed, 6 Nov 2019 23:43:32 -0600
Subject: Re: [PATCH v2 2/2] spi: cadence-quadpsi: Add support for the Cadence
 QSPI controller
To:     "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <broonie@kernel.org>, <robh+dt@kernel.org>,
        <cheol.yong.kim@intel.com>, <qi-ming.wu@intel.com>
References: <20191030081155.29947-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20191030081155.29947-3-vadivel.muruganx.ramuthevar@linux.intel.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <1f0e56c4-6a09-da05-204d-f1856fcbe8f8@ti.com>
Date:   Thu, 7 Nov 2019 11:14:07 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191030081155.29947-3-vadivel.muruganx.ramuthevar@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On 30/10/19 1:41 PM, Ramuthevar,Vadivel MuruganX wrote:
> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> 
> Add support for the Cadence QSPI controller. This controller is
> present in the Intel Lightning Mountain(LGM) SoCs, Altera and TI SoCs.
> This driver has been tested on the Intel LGM SoCs.
> 
> This driver does not support generic SPI and also the implementation
> only supports spi-mem interface to replace the existing driver in
> mtd/spi-nor/cadence-quadspi.c, the existing driver only support SPI-NOR
> flash memory.
> 
> Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> ---
>  drivers/spi/Kconfig               |   10 +
>  drivers/spi/Makefile              |    1 +
>  drivers/spi/spi-cadence-quadspi.c | 1290 +++++++++++++++++++++++++++++++++++++
>  drivers/spi/spi-cadence-quadspi.h |  272 ++++++++
>  4 files changed, 1573 insertions(+)
>  create mode 100644 drivers/spi/spi-cadence-quadspi.c
>  create mode 100644 drivers/spi/spi-cadence-quadspi.h
> 
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index 6f7fdcbb9151..ef4d961feb54 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -192,6 +192,16 @@ config SPI_CADENCE
>  	  This selects the Cadence SPI controller master driver
>  	  used by Xilinx Zynq and ZynqMP.
>  
> +config SPI_CADENCE_QUADSPI
> +	tristate "Cadence Quad SPI controller"
> +	depends on OF && (ARM || ARM64 || COMPILE_TEST || X86)
> +	depends on MTD || MTD_SPI_NOR || MTD_SPI_NAND
> +	help
> +	  Cadence QSPI is a specialized controller for connecting an SPI
> +	  Flash over 1/2/4-bit wide bus. This enables support for the Quad SPI

Supports Octal mode as well. So its 1/2/4/8-bit wide

> +	  controller in master mode. This driver does not support generic SPI.
> +	  The implementation only supports spi-mem interface.
> +
>  config SPI_CLPS711X
>  	tristate "CLPS711X host SPI controller"
>  	depends on ARCH_CLPS711X || COMPILE_TEST
> diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
> index bb49c9e6d0a0..84a59d75a13a 100644
> --- a/drivers/spi/Makefile
> +++ b/drivers/spi/Makefile
> @@ -29,6 +29,7 @@ obj-$(CONFIG_SPI_BCM_QSPI)		+= spi-iproc-qspi.o spi-brcmstb-qspi.o spi-bcm-qspi.
>  obj-$(CONFIG_SPI_BITBANG)		+= spi-bitbang.o
>  obj-$(CONFIG_SPI_BUTTERFLY)		+= spi-butterfly.o
>  obj-$(CONFIG_SPI_CADENCE)		+= spi-cadence.o
> +obj-$(CONFIG_SPI_CADENCE_QUADSPI)		+= spi-cadence-quadspi.o
>  obj-$(CONFIG_SPI_CLPS711X)		+= spi-clps711x.o
>  obj-$(CONFIG_SPI_COLDFIRE_QSPI)		+= spi-coldfire-qspi.o
>  obj-$(CONFIG_SPI_DAVINCI)		+= spi-davinci.o
> diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
> new file mode 100644
> index 000000000000..bca391bfb58f
> --- /dev/null
> +++ b/drivers/spi/spi-cadence-quadspi.c
> @@ -0,0 +1,1290 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Driver for Cadence QSPI Controller
> + *
> + * Copyright Altera Corporation (C) 2012-2014. All rights reserved.
> + * Copyright Intel Corporation (C) 2019. All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License along with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +#include <linux/clk.h>
> +#include <linux/completion.h>
> +#include <linux/delay.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/dmaengine.h>
> +#include <linux/errno.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/jiffies.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +#include <linux/platform_device.h>
> +#include <linux/spi/spi.h>
> +#include <linux/spi/spi-mem.h>
> +#include <linux/unaligned/be_byteshift.h>
> +
> +#include "spi-cadence-quadspi.h"
> +
> +/* Quirks */
> +#define CQSPI_NEEDS_WR_DELAY		BIT(0)
> +#define CQSPI_DISABLE_DAC_MODE		BIT(1)
> +
> +#define CADENCE_QSPI_NAME                       "cadence-qspi"
> +
> +struct cqspi_driver_platdata {
> +	u32 hwcaps_mask;
> +	u8 quirks;
> +};
> +
> +unsigned int cadence_qspi_init_timeout(const unsigned long timeout_in_ms)
> +{
> +	return jiffies + msecs_to_jiffies(timeout_in_ms);
> +}
> +
> +unsigned int cadence_qspi_check_timeout(const unsigned long timeout)
> +{
> +	return time_before(jiffies, timeout);
> +}
> +
> +static irqreturn_t cadence_qspi_irq_handler(int this_irq, void *dev)
> +{
> +	struct struct_cqspi *cadence_qspi = dev;
> +	u32 irq_status;
> +
> +	/* Read interrupt status */
> +	irq_status = readl(cadence_qspi->iobase + CQSPI_REG_IRQSTATUS);
> +	if (!irq_status)
> +		return IRQ_HANDLED;
> +
> +	cadence_qspi->irq_status = irq_status;
> +
> +	/* Clear interrupt */
> +	writel(irq_status, cadence_qspi->iobase + CQSPI_REG_IRQSTATUS);
> +	if (irq_status)
> +		complete(&cadence_qspi->transfer_complete);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static u32 cadence_qspi_cmd2addr(const unsigned char *addr_buf, u32 addr_width)
> +{
> +	unsigned int addr = 0;
> +	int i;
> +
> +	/* Invalid address return zero. */
> +	if (addr_width > 4)
> +		return 0;
> +
> +	for (i = 0; i < addr_width; i++) {
> +		addr = addr << 8;
> +		addr |= addr_buf[i];
> +	}
> +
> +	return addr;
> +}
> +
> +void enable_qspi_direct_access(void *reg_base, bool enable)
> +{

Please be consistent with function names. Start all functions with
cadence_qspi_. If need you could have a shorter function prefix like cqspi_

Also, this and few other functions below can be static and they are not
used outside of this module.

> +	u32 reg;
> +
> +	reg = readl(reg_base + CQSPI_REG_CONFIG);
> +	if (enable)
> +		reg |= CQSPI_REG_CONFIG_DIRECT_MASK;
> +	else
> +		reg &= ~CQSPI_REG_CONFIG_DIRECT_MASK;
> +
> +	writel(reg, reg_base + CQSPI_REG_CONFIG);
> +}
> +
> +void cadence_qspi_controller_enable(void *reg_base, bool enable)
> +{
> +	unsigned int reg;
> +
> +	reg = readl(reg_base + CQSPI_REG_CONFIG);
> +	if (enable)
> +		reg |= CQSPI_REG_CONFIG_ENABLE_MASK;
> +	else
> +		reg &= ~CQSPI_REG_CONFIG_ENABLE_MASK;
> +
> +	writel(reg, reg_base + CQSPI_REG_CONFIG);
> +}
> +
> +static unsigned int cadence_qspi_wait_idle(void *reg_base)
> +{
> +	u32 timeout, count = 0;
> +
> +	timeout = cadence_qspi_init_timeout(CQSPI_READ_TIMEOUT_MS);
> +	while (cadence_qspi_check_timeout(timeout)) {
> +		if (CQSPI_REG_IS_IDLE(reg_base)) {
> +			count++;
> +			if (count >= CQSPI_POLL_IDLE_RETRY)
> +				return 1;
> +		} else {
> +			count = 0;
> +		}
> +	}
> +
> +	return 0;
> +}
> +

Could you please keep polling routines from original driver
(drivers/mtd/spi-nor/cadence-quadspi.c). If you really want to improve
these helpers, please do those changes in a separate patch later on in
the series. This will greatly help in reviewing the code.

Also, I see that you have dropped many inline comments in the code.
These comments are quite important and I suggest not to drop them unless
they are no longer applicable

> +static void cadence_qspi_readdata_capture(void *reg_base, u32 bypass, u32 delay)
> +{
> +	unsigned int reg;
> +
> +	cadence_qspi_controller_enable(reg_base, 0);
> +
> +	reg = readl(reg_base + CQSPI_REG_READCAPTURE);
> +	if (bypass)
> +		reg |= (1 << CQSPI_REG_READCAPTURE_BYPASS_LSB);
> +	else
> +		reg &= ~(1 << CQSPI_REG_READCAPTURE_BYPASS_LSB);
> +
> +	reg &= ~(CQSPI_REG_READCAPTURE_DELAY_MASK
> +		<< CQSPI_REG_READCAPTURE_DELAY_LSB);
> +	reg |= ((delay & CQSPI_REG_READCAPTURE_DELAY_MASK)
> +		<< CQSPI_REG_READCAPTURE_DELAY_LSB);
> +	writel(reg, reg_base + CQSPI_REG_READCAPTURE);
> +
> +	cadence_qspi_controller_enable(reg_base, 1);
> +}
> +
> +static void cadence_qspi_config_baudrate_div(void *reg_base, u32 ref_clk_hz,
> +					     u32 sclk_hz)
> +{
> +	unsigned int reg, div;
> +
> +	/* Recalculate the baudrate divisor based on QSPI specification. */
> +	div = DIV_ROUND_UP(ref_clk_hz, 2 * sclk_hz) - 1;
> +
> +	reg = readl(reg_base + CQSPI_REG_CONFIG);
> +	reg &= ~(CQSPI_REG_CONFIG_BAUD_MASK << CQSPI_REG_CONFIG_BAUD_LSB);
> +	div = (div & CQSPI_REG_CONFIG_BAUD_MASK) << CQSPI_REG_CONFIG_BAUD_LSB;
> +	writel(reg, reg_base + CQSPI_REG_CONFIG);
> +}
> +
> +static void cadence_qspi_cs(void *reg_base, u32 chip_select, u32 decoder_enable)
> +{
> +	unsigned int reg;
> +
> +	cadence_qspi_controller_enable(reg_base, 0);
> +
> +	reg = readl(reg_base + CQSPI_REG_CONFIG);
> +	/* docoder */

s/docoder/decoder

> +	if (decoder_enable) {
> +		reg |= CQSPI_REG_CONFIG_DECODE_MASK;
> +	} else {
> +		reg &= ~CQSPI_REG_CONFIG_DECODE_MASK;
> +		chip_select = 0xF & ~(1 << chip_select);
> +	}
> +	reg &= ~(CQSPI_REG_CONFIG_CHIPSELECT_MASK
> +			<< CQSPI_REG_CONFIG_CHIPSELECT_LSB);
> +	reg |= (chip_select & CQSPI_REG_CONFIG_CHIPSELECT_MASK)
> +			<< CQSPI_REG_CONFIG_CHIPSELECT_LSB;
> +	writel(reg, reg_base + CQSPI_REG_CONFIG);
> +	cadence_qspi_controller_enable(reg_base, 1);
> +}
> +
> +static int cadence_qspi_exec_flash_cmd(void *reg_base, unsigned int reg)
> +{
> +	unsigned int timeout;
> +
> +	writel(reg, reg_base + CQSPI_REG_CMDCTRL);
> +	reg |= CQSPI_REG_CMDCTRL_EXECUTE_MASK;
> +	writel(reg, reg_base + CQSPI_REG_CMDCTRL);
> +
> +	timeout = cadence_qspi_init_timeout(CQSPI_TIMEOUT_MS);
> +	while (cadence_qspi_check_timeout(timeout)) {
> +		reg = readl(reg_base + CQSPI_REG_CMDCTRL) &
> +			CQSPI_REG_CMDCTRL_INPROGRESS_MASK;
> +		if (!reg)
> +			break;
> +	}
> +

Please use cqspi_wait_for_bit() that uses readl_relaxed_poll_timeout()
here. There are couple corner cases that above code does not take care of.

> +	if (!cadence_qspi_wait_idle(reg_base) || reg != 0)
> +		return -EIO;
> +
> +	return 0;
> +}
> +
> +static int cqspi_command_read(void *reg_base, u32 txlen, const u_char *txbuf,
> +			      u32 addrlen, const u8 *addrbuf, u32 rxlen,
> +			      u8 *rxbuf, u32 flash_type)
> +{
> +	u32 addr_value, read_len, reg;
> +	int ret;
> +
> +	if (!rxlen || rxlen > CQSPI_STIG_DATA_LEN_MAX || !rxbuf)
> +		return -EINVAL;
> +
> +	reg = txbuf[0] << CQSPI_REG_CMDCTRL_OPCODE_LSB;
> +	reg |= BIT(CQSPI_REG_CMDCTRL_RD_EN_LSB);
> +
> +	if (addrlen) {
> +		reg |= BIT(CQSPI_REG_CMDCTRL_ADDR_EN_LSB);
> +		reg |= ((addrlen - 1) & CQSPI_REG_CMDCTRL_ADD_BYTES_MASK)
> +			<< CQSPI_REG_CMDCTRL_ADD_BYTES_LSB;
> +		addr_value = cadence_qspi_cmd2addr(&addrbuf[0], addrlen);
> +		writel(addr_value, reg_base + CQSPI_REG_CMDADDRESS);
> +	}
> +	/* 0 means 1 byte. */
> +	reg |= (((rxlen - 1) & CQSPI_REG_CMDCTRL_RD_BYTES_MASK)
> +		<< CQSPI_REG_CMDCTRL_RD_BYTES_LSB);
> +	ret = cadence_qspi_exec_flash_cmd(reg_base, reg);
> +	if (ret != 0)
> +		return ret;
> +
> +	reg = readl(reg_base + CQSPI_REG_CMDREADDATALOWER);
> +	read_len = (rxlen > 4) ? 4 : rxlen;
> +	memcpy(rxbuf, &reg, read_len);
> +	rxbuf += read_len;
> +
> +	if (rxlen > 4) {
> +		reg = readl(reg_base + CQSPI_REG_CMDREADDATAUPPER);
> +		read_len = rxlen - read_len;
> +		memcpy(rxbuf, &reg, read_len);
> +	}
> +
> +	return 0;
> +}
> +
> +static int cqspi_command_write(void *reg_base, u32 txlen, const u8 *txbuf,
> +			       u32 addrlen, const u8 *addrbuf, u32 datalen,
> +			       const u8 *databuf, u32 flash_type)
> +{
> +	unsigned int addr_value, reg, data = 0;
> +
> +	if (!txlen || !txbuf)
> +		return -EINVAL;
> +
> +	reg = txbuf[0] << CQSPI_REG_CMDCTRL_OPCODE_LSB;
> +	if (datalen != 0) {
> +		reg |= BIT(CQSPI_REG_CMDCTRL_WR_EN_LSB);
> +		reg |= ((datalen - 1) & CQSPI_REG_CMDCTRL_WR_BYTES_MASK)
> +			<< CQSPI_REG_CMDCTRL_WR_BYTES_LSB;
> +		memcpy(&data, databuf, datalen);
> +		writel(data, reg_base + CQSPI_REG_CMDWRITEDATALOWER);
> +	}
> +	if (addrlen) {
> +		reg |= BIT(CQSPI_REG_CMDCTRL_ADDR_EN_LSB);
> +		reg |= ((addrlen - 1) & CQSPI_REG_CMDCTRL_ADD_BYTES_MASK)
> +			<< CQSPI_REG_CMDCTRL_ADD_BYTES_LSB;
> +		addr_value = cadence_qspi_cmd2addr(&addrbuf[0], addrlen);
> +		writel(addr_value, reg_base + CQSPI_REG_CMDADDRESS);
> +	}
> +
> +	return cadence_qspi_exec_flash_cmd(reg_base, reg);
> +}
> +
> +static int cqspi_indirect_read_setup(void *reg_base, u32 txlen, const u8 *txbuf,
> +				     u32 addrlen, const u8 *addrbuf,
> +				     u32 dummy_bytes, u32 flash_type,
> +				     u32 quad_mode)
> +{
> +	unsigned int addr_value, dummy_clk, reg;
> +
> +	if (addrlen) {
> +		addr_value = cadence_qspi_cmd2addr(&addrbuf[0], addrlen);
> +		writel(addr_value, reg_base + CQSPI_REG_INDIRECTRDSTARTADDR);
> +	}
> +
> +	reg = txbuf[0] << CQSPI_REG_RD_INSTR_OPCODE_LSB;
> +	reg |= (quad_mode & CQSPI_REG_RD_INSTR_TYPE_DATA_MASK) <<
> +		CQSPI_REG_RD_INSTR_TYPE_DATA_LSB;
> +
> +	if (dummy_bytes) {
> +		if (dummy_bytes > CQSPI_DUMMY_BYTES_MAX)
> +			dummy_bytes = CQSPI_DUMMY_BYTES_MAX;
> +		reg |= BIT(CQSPI_REG_RD_INSTR_MODE_EN_LSB);
> +		writel(0xFF, reg_base + CQSPI_REG_MODE_BIT);
> +		dummy_clk = dummy_bytes * CQSPI_DUMMY_CLKS_PER_BYTE;
> +		dummy_clk -= CQSPI_DUMMY_CLKS_PER_BYTE;
> +		if (dummy_clk)
> +			reg |= (dummy_clk & CQSPI_REG_RD_INSTR_DUMMY_MASK)
> +				<< CQSPI_REG_RD_INSTR_DUMMY_LSB;
> +	} else if (flash_type == QSPI_FLASH_TYPE_NAND) {
> +		reg |= ((1 * CQSPI_DUMMY_CLKS_PER_BYTE)
> +				<< CQSPI_REG_RD_INSTR_DUMMY_LSB);
> +	}

Why do we need flash type specific handling here? Does not spi-nand
driver provide appropriate dummy_clk values? Why is the driver always
adding 8 dummy clks always?

> +	writel(reg, reg_base + CQSPI_REG_RD_INSTR);
> +	/* Set device size */
> +	reg = readl(reg_base + CQSPI_REG_SIZE);
> +	reg &= ~CQSPI_REG_SIZE_ADDRESS_MASK;
> +	reg |= (addrlen - 1);
> +	writel(reg, reg_base + CQSPI_REG_SIZE);
> +	/* disable auto-polling */
> +	reg = readl(reg_base + CQSPI_REG_WR_COMPLETION_CTRL);
> +	reg |= BIT(CQSPI_REG_WR_COMPLETION_DIS_POLLING_FLD_POS);
> +	writel(reg, reg_base + CQSPI_REG_WR_COMPLETION_CTRL);
> +
> +	return 0;
> +}
> +
> +static void cqspi_request_mmap_dma(struct struct_cqspi *cqspi)
> +{
> +	dma_cap_mask_t mask;
> +
> +	dma_cap_zero(mask);
> +	dma_cap_set(DMA_MEMCPY, mask);
> +
> +	cqspi->rx_chan = dma_request_chan_by_mask(&mask);
> +	if (IS_ERR(cqspi->rx_chan)) {
> +		dev_err(&cqspi->pdev->dev, "No Rx DMA available\n");
> +		cqspi->rx_chan = NULL;
> +	}
> +	init_completion(&cqspi->rx_dma_complete);
> +}
> +
> +static void cqspi_rx_dma_callback(void *param)
> +{
> +	struct struct_cqspi *cqspi = param;
> +
> +	complete(&cqspi->rx_dma_complete);
> +}
> +
> +static int cqspi_direct_read_execute(struct struct_cqspi *cqspi, u8 *buf,
> +				     const u8 *addrbuf, size_t rxlen)
> +{
> +	struct platform_device *pdev = cqspi->pdev;
> +	struct device *dev = &pdev->dev;
> +	enum dma_ctrl_flags flags = DMA_CTRL_ACK | DMA_PREP_INTERRUPT;
> +	dma_addr_t dma_src = (dma_addr_t)cqspi->mmap_phys_base + addrbuf[0];
> +	void __iomem *ahb_base = cqspi->qspi_ahb_virt;
> +	int ret = 0;
> +	struct dma_async_tx_descriptor *tx;
> +	dma_cookie_t cookie;
> +	dma_addr_t dma_dst;
> +
> +	if (!cqspi->rx_chan || !virt_addr_valid(buf)) {
> +		memcpy_fromio(buf, ahb_base + addrbuf[0], rxlen);
> +		return 0;
> +	}
> +
> +	dma_dst = dma_map_single(dev, buf, rxlen, DMA_FROM_DEVICE);
> +	if (dma_mapping_error(dev, dma_dst)) {
> +		dev_err(dev, "dma mapping failed\n");
> +		return -ENOMEM;
> +	}
> +	tx = dmaengine_prep_dma_memcpy(cqspi->rx_chan, dma_dst, dma_src,
> +				       rxlen, flags);
> +	if (!tx) {
> +		dev_err(dev, "device_prep_dma_memcpy error\n");
> +		ret = -EIO;
> +		goto err_unmap;
> +	}
> +
> +	tx->callback = cqspi_rx_dma_callback;
> +	tx->callback_param = cqspi;
> +	cookie = tx->tx_submit(tx);
> +	reinit_completion(&cqspi->rx_dma_complete);
> +
> +	ret = dma_submit_error(cookie);
> +	if (ret) {
> +		dev_err(dev, "dma_submit_error %d\n", cookie);
> +		ret = -EIO;
> +		goto err_unmap;
> +	}
> +
> +	dma_async_issue_pending(cqspi->rx_chan);
> +	if (!wait_for_completion_timeout(&cqspi->rx_dma_complete,
> +					 msecs_to_jiffies(rxlen))) {
> +		dmaengine_terminate_sync(cqspi->rx_chan);
> +		dev_err(dev, "DMA wait_for_completion_timeout\n");
> +		ret = -ETIMEDOUT;
> +		goto err_unmap;
> +	}
> +
> +err_unmap:
> +	dma_unmap_single(dev, dma_dst, rxlen, DMA_FROM_DEVICE);
> +
> +	return ret;
> +}
> +
> +static int cqspi_indirect_read_execute(struct struct_cqspi *cqspi, u32 rxlen,
> +				       u8 *rxbuf, u32 flash_type)
> +{
> +	struct platform_device *pdev = cqspi->pdev;
> +	struct cqspi_platform_data *pdata = pdev->dev.platform_data;
> +	void *reg_base = cqspi->iobase;
> +	void *ahb_base = cqspi->qspi_ahb_virt;
> +	u8 *rxbuf_end = rxbuf + rxlen;
> +	u32 mod_bytes = rxlen % 4;
> +	u32 bytes_to_read = 0;
> +	int remaining = (int)rxlen;
> +	u32 timeout, reg = 0;
> +	int ret = 0;
> +
> +	writel(0, reg_base + CQSPI_REG_INDIRECTRDWATERMARK);
> +	writel(0xa, reg_base + CQSPI_INDIRECT_TRIGGER_ADDR_RANGE_REG);
> +	writel(remaining, reg_base + CQSPI_REG_INDIRECTRDBYTES);
> +
> +	mb();/* flush previous writes */
> +
> +	writel(pdata->fifo_depth - CQSPI_REG_SRAM_RESV_WORDS,
> +	       reg_base + CQSPI_REG_SRAMPARTITION);
> +	/* Clear all interrupts. */
> +	writel(CQSPI_IRQ_STATUS_MASK, reg_base + CQSPI_REG_IRQSTATUS);
> +	writel(CQSPI_IRQ_MASK_RD, reg_base + CQSPI_REG_IRQMASK);
> +
> +	reinit_completion(&cqspi->transfer_complete);
> +	writel(CQSPI_REG_INDIRECTRD_START_MASK,
> +	       reg_base + CQSPI_REG_INDIRECTRD);
> +
> +	while (remaining > 0) {
> +		bytes_to_read = CQSPI_GET_RD_SRAM_LEVEL(reg_base);
> +
> +		while (bytes_to_read != 0) {
> +			unsigned int word_remain = round_down(remaining, 4);
> +
> +			bytes_to_read *= CQSPI_FIFO_WIDTH;
> +			bytes_to_read = bytes_to_read > remaining ?
> +						remaining : bytes_to_read;
> +			bytes_to_read = round_down(bytes_to_read, 4);
> +			if (bytes_to_read) {
> +				ioread32_rep(ahb_base, rxbuf,
> +					     (bytes_to_read / 4));
> +			} else if (!word_remain && mod_bytes) {
> +				unsigned int temp = ioread32(ahb_base);
> +
> +				bytes_to_read = mod_bytes;
> +				memcpy(rxbuf, &temp, min((unsigned int)
> +				       (rxbuf_end - rxbuf), bytes_to_read));
> +			}
> +
> +			rxbuf += bytes_to_read;
> +			remaining -= bytes_to_read;
> +			bytes_to_read = CQSPI_GET_RD_SRAM_LEVEL(reg_base);
> +		}
> +
> +		if (remaining < 0)
> +			reinit_completion(&cqspi->transfer_complete);
> +	}
> +
> +	/* Check indirect done status */
> +	timeout = cadence_qspi_init_timeout(CQSPI_READ_TIMEOUT_MS);
> +	while (cadence_qspi_check_timeout(timeout)) {
> +		reg = readl(reg_base + CQSPI_REG_INDIRECTRD);
> +		if (reg & CQSPI_REG_INDIRECTRD_DONE_MASK)
> +			break;
> +	}
> +	if (!(reg & CQSPI_REG_INDIRECTRD_DONE_MASK)) {
> +		dev_err(&pdev->dev, "QSPI : Indirect read error %x\n", reg);
> +		ret = -ETIMEDOUT;
> +		goto failrd;
> +	}
> +	/* Disable interrupt */
> +	writel(0, reg_base + CQSPI_REG_IRQMASK);
> +	/* Clear indirect completion status */
> +	writel(CQSPI_REG_INDIRECTRD_DONE_MASK, reg_base + CQSPI_REG_INDIRECTRD);
> +
> +	return 0;
> +failrd:
> +	/* Disable interrupt */
> +	writel(0, reg_base + CQSPI_REG_IRQMASK);
> +	/* Cancel the indirect read */
> +	writel(CQSPI_REG_INDIRECTWR_CANCEL_MASK,
> +	       reg_base + CQSPI_REG_INDIRECTRD);
> +	return ret;
> +}
> +
> +static int cqspi_indirect_write_setup(void *reg_base, u32 txlen,
> +				      const u8 *txbuf, u32 addrlen,
> +				      const u8 *addrbuf, u32 flash_type,
> +				      u32 quad_mode)
> +{
> +	unsigned int reg;
> +
> +	if (!txbuf)
> +		return -EINVAL;
> +
> +	reg = readl(reg_base + CQSPI_REG_CONFIG);
> +	reg &= ~(CQSPI_REG_CONFIG_DIRECT_MASK);
> +	reg &= ~(CQSPI_REG_CONFIG_DMA_MASK);
> +	writel(reg, reg_base + CQSPI_REG_CONFIG);
> +
> +	/* Set opcode. */
> +	reg = txbuf[0] << CQSPI_REG_WR_INSTR_OPCODE_LSB;
> +	reg |= BIT(CQSPI_REG_WR_CONFIG_WEL_DIS_FLD_POS);
> +	if (txbuf[0] == MACRONIX_4PP_CMD && flash_type == QSPI_FLASH_TYPE_NOR &&
> +	    quad_mode == QUAD_QIO) {
> +		/* Configure the quad */
> +		reg |= (quad_mode & CQSPI_REG_WR_INSTR_TYPE_ADDR_MASK) <<
> +		       CQSPI_REG_WR_INSTR_TYPE_ADDR_LSB;
> +	}

Nope, no custom handling or interpreting of opcodes in driver.
Just set addrwidth to quad in CQSPI_REG_WR_INSTR when op->addr.buswidth
is 4.


> +	/* Configure the quad */
> +	reg |= (quad_mode & CQSPI_REG_WR_INSTR_TYPE_DATA_MASK) <<
> +	       CQSPI_REG_WR_INSTR_TYPE_DATA_LSB;
> +	writel(reg, reg_base + CQSPI_REG_WR_INSTR);
> +	/* Setup write address. */
> +	reg = cadence_qspi_cmd2addr(&addrbuf[0], addrlen);
> +	writel(reg, reg_base + CQSPI_REG_INDIRECTWRSTARTADDR);
> +	reg = readl(reg_base + CQSPI_REG_SIZE);
> +	reg &= ~CQSPI_REG_SIZE_ADDRESS_MASK;
> +	reg |= ((addrlen - 1) & CQSPI_REG_SIZE_ADDRESS_MASK);
> +	writel(reg, reg_base +  CQSPI_REG_SIZE);
> +
> +	/* disable auto-polling */
> +	reg = readl(reg_base + CQSPI_REG_WR_COMPLETION_CTRL);
> +	reg |= BIT(CQSPI_REG_WR_COMPLETION_DIS_POLLING_FLD_POS);
> +	writel(reg, reg_base + CQSPI_REG_WR_COMPLETION_CTRL);
> +
> +	return 0;
> +}
> +
> +static int cqspi_indirect_write_execute(struct struct_cqspi *cqspi, u32 txlen,
> +					const u8 *txbuf, u32 flash_type)
> +{
> +	struct platform_device *pdev = cqspi->pdev;
> +	struct cqspi_platform_data *pdata = pdev->dev.platform_data;
> +	struct cqspi_flash_pdata *f_pdata =
> +			&pdata->f_pdata[cqspi->current_cs];
> +	void *reg_base = cqspi->iobase;
> +	void *ahb_base = cqspi->qspi_ahb_virt;
> +	u32 *irq_status = &cqspi->irq_status;
> +	u32 page_size = f_pdata->page_size;
> +	u32 write_bytes, timeout, reg = 0;
> +	int remaining = (int)txlen;
> +	int ret;
> +
> +	writel(0xa, reg_base + CQSPI_INDIRECT_TRIGGER_ADDR_RANGE_REG);
> +	writel(0x0, reg_base + CQSPI_REG_INDIRECTWRWATERMARK);
> +	reg = readl(reg_base + CQSPI_REG_SIZE);
> +	reg &= ~(CQSPI_REG_SIZE_PAGE_MASK << CQSPI_REG_SIZE_PAGE_LSB);
> +	reg &= ~(CQSPI_REG_SIZE_BLOCK_MASK << CQSPI_REG_SIZE_BLOCK_LSB);
> +	reg |= (f_pdata->page_size << CQSPI_REG_SIZE_PAGE_LSB);
> +	reg |= (f_pdata->block_size << CQSPI_REG_SIZE_BLOCK_LSB);
> +	writel(reg, reg_base +  CQSPI_REG_SIZE);
> +
> +	writel(remaining, reg_base + CQSPI_REG_INDIRECTWRBYTES);
> +	writel(CQSPI_REG_SRAM_PARTITION_WR, reg_base + CQSPI_REG_SRAMPARTITION);
> +	/* Clear all interrupts. */
> +	writel(CQSPI_IRQ_STATUS_MASK, reg_base + CQSPI_REG_IRQSTATUS);
> +	writel(CQSPI_IRQ_MASK_WR, reg_base + CQSPI_REG_IRQMASK);
> +	reinit_completion(&cqspi->transfer_complete);
> +	writel(CQSPI_REG_INDIRECTWR_START_MASK,
> +	       reg_base + CQSPI_REG_INDIRECTWR);
> +
> +	if (cqspi->wr_delay)
> +		ndelay(cqspi->wr_delay);
> +
> +	while (remaining > 0) {
> +		size_t write_words, mod_bytes;
> +
> +		write_bytes = remaining > page_size ? page_size : remaining;
> +		write_words = write_bytes / 4;
> +		mod_bytes = write_bytes % 4;
> +
> +		if (write_words) {
> +			iowrite32_rep(ahb_base, txbuf, write_words);
> +			txbuf += (write_words * 4);
> +		}
> +		if (mod_bytes) {
> +			unsigned int temp = 0xFFFFFFFF;
> +
> +			memcpy(&temp, txbuf, mod_bytes);
> +			iowrite32(temp, ahb_base);
> +			txbuf += mod_bytes;
> +		}
> +		ret = wait_event_interruptible_timeout(cqspi->waitqueue,
> +						       *irq_status &
> +						       CQSPI_IRQ_MASK_WR,
> +						       CQSPI_TIMEOUT_MS);

This was wait_for_completion_timeout() previously. Have you tested
interrupting the sleep and verified that driver handles this case correctly?

> +		if (!(ret) & (*irq_status & CQSPI_IRQ_STATUS_ERR)) {
> +			ret = -ETIMEDOUT;
> +			goto failwr;
> +		} else {
> +			ret = 0;
> +		}
> +		remaining -= write_bytes;
> +
> +		if (remaining < 0)
> +			reinit_completion(&cqspi->transfer_complete);
> +	}
> +
> +	/* Check indirect done status */
> +	timeout = cadence_qspi_init_timeout(CQSPI_TIMEOUT_MS);
> +	while (cadence_qspi_check_timeout(timeout)) {
> +		reg = readl(reg_base + CQSPI_REG_INDIRECTWR);
> +		if (reg & CQSPI_REG_INDIRECTWR_DONE_MASK)
> +			break;
> +	}
> +	if (!(reg & CQSPI_REG_INDIRECTWR_DONE_MASK)) {
> +		dev_err(&pdev->dev, "QSPI: Indirect write error %x", reg);
> +		ret = -ETIMEDOUT;
> +		goto failwr;
> +	}
> +
> +	return 0;
> +
> +failwr:
> +	/* Disable interrupt. */
> +	writel(0, reg_base + CQSPI_REG_IRQMASK);
> +	/* Clear indirect completion status */
> +	writel(CQSPI_REG_INDIRECTWR_DONE_MASK, reg_base + CQSPI_REG_INDIRECTWR);
> +
> +	/* Cancel the indirect write */
> +	if (ret)
> +		writel(CQSPI_REG_INDIRECTWR_CANCEL_MASK,
> +		       reg_base + CQSPI_REG_INDIRECTWR);
> +
> +	return ret;
> +}
> +
> +unsigned int cadence_qspi_is_controller_ready(void *reg_base)
> +{
> +	return cadence_qspi_wait_idle(reg_base);
> +}
> +
> +void cadence_qspi_controller_init(struct struct_cqspi *cqspi)
> +{
> +	struct platform_device *pdev = cqspi->pdev;
> +	struct cqspi_platform_data *pdata = pdev->dev.platform_data;
> +
> +	cadence_qspi_controller_enable(cqspi->iobase, 0);
> +
> +	/* Configure the remap address register, no remap */
> +	writel(0, cqspi->iobase + CQSPI_REG_REMAP);
> +	/* Disable all interrupts. */
> +	writel(0, cqspi->iobase + CQSPI_REG_IRQMASK);
> +
> +	/* DAC is disabled for Intel LGM SOC */
> +	if (!cqspi->dac_mode) {
> +		enable_qspi_direct_access(cqspi->iobase, 0);
> +	} else {
> +		enable_qspi_direct_access(cqspi->iobase, 1);
> +		/* TODO: for TI platform to be enabled */
> +		cqspi_request_mmap_dma(cqspi);
> +	}
> +
> +	/* Load indirect trigger address. */
> +	writel(pdata->trigger_address,
> +	       cqspi->iobase + CQSPI_REG_INDIRECTTRIGGER);
> +
> +	cadence_qspi_controller_enable(cqspi->iobase, 1);
> +}
> +
> +unsigned int calculate_ticks_for_ns(u32 ref_clk_hz, u32 ns_val)
> +{
> +	unsigned int ticks;
> +
> +	ticks = ref_clk_hz / 1000;      /* kHz */
> +	ticks = DIV_ROUND_UP(ticks * ns_val, 1000000);
> +
> +	return ticks;
> +}
> +
> +void cadence_qspi_delay(struct struct_cqspi *cqspi, u32 ref_clk, u32 sclk_hz)
> +{
> +	struct platform_device *pdev = cqspi->pdev;
> +	struct cqspi_platform_data *pdata = pdev->dev.platform_data;
> +	struct cqspi_flash_pdata *f_pdata = &pdata->f_pdata[cqspi->current_cs];
> +	void __iomem *iobase = cqspi->iobase;
> +	const unsigned int ref_clk_hz = pdata->master_ref_clk_hz;
> +	unsigned int tshsl, tchsh, tslch, tsd2d;
> +	unsigned int reg;
> +	unsigned int tsclk;
> +
> +	cadence_qspi_controller_enable(cqspi->iobase, 0);
> +	/* calculate the number of ref ticks for one sclk tick */
> +	tsclk = DIV_ROUND_UP(ref_clk_hz, sclk_hz);
> +
> +	/* this particular value must be at least one sclk */
> +	if (tshsl < tsclk)
> +		tshsl = tsclk;
> +
> +	tchsh = calculate_ticks_for_ns(ref_clk_hz, f_pdata->tchsh_ns);
> +	tslch = calculate_ticks_for_ns(ref_clk_hz, f_pdata->tslch_ns);
> +	tsd2d = calculate_ticks_for_ns(ref_clk_hz, f_pdata->tsd2d_ns);
> +
> +	reg = ((tshsl & CQSPI_REG_DELAY_TSHSL_MASK)
> +			<< CQSPI_REG_DELAY_TSHSL_LSB);
> +	reg |= ((tchsh & CQSPI_REG_DELAY_TCHSH_MASK)
> +			<< CQSPI_REG_DELAY_TCHSH_LSB);
> +	reg |= ((tslch & CQSPI_REG_DELAY_TSLCH_MASK)
> +			<< CQSPI_REG_DELAY_TSLCH_LSB);
> +	reg |= ((tsd2d & CQSPI_REG_DELAY_TSD2D_MASK)
> +			<< CQSPI_REG_DELAY_TSD2D_LSB);
> +	writel(reg, iobase + CQSPI_REG_DELAY);
> +	cadence_qspi_controller_enable(cqspi->iobase, 1);
> +}
> +
> +void cadence_qspi_switch_chipselect(struct struct_cqspi *cqspi, u32 cs)
> +{
> +	struct platform_device *pdev = cqspi->pdev;
> +	struct cqspi_platform_data *pdata = pdev->dev.platform_data;
> +	struct cqspi_flash_pdata *f_pdata = &pdata->f_pdata[cs];
> +	void __iomem *iobase = cqspi->iobase;
> +	unsigned int reg;
> +
> +	cadence_qspi_controller_enable(cqspi->iobase, 0);
> +	/* Configure page size and block size. */
> +	reg = readl(iobase + CQSPI_REG_SIZE);
> +	/* clear the previous value */
> +	reg &= ~(CQSPI_REG_SIZE_PAGE_MASK << CQSPI_REG_SIZE_PAGE_LSB);
> +	reg &= ~(CQSPI_REG_SIZE_BLOCK_MASK << CQSPI_REG_SIZE_BLOCK_LSB);
> +	reg |= (f_pdata->page_size << CQSPI_REG_SIZE_PAGE_LSB);
> +	reg |= (f_pdata->block_size << CQSPI_REG_SIZE_BLOCK_LSB);
> +	writel(reg, iobase + CQSPI_REG_SIZE);
> +	/* configure the chip select */
> +	cadence_qspi_cs(iobase, cs, pdata->ext_decoder);
> +	cadence_qspi_controller_enable(cqspi->iobase, 1);
> +}
> +
> +static int cadence_qspi_mem_process(struct struct_cqspi *cqspi,
> +				    struct spi_mem *mem,
> +				    const struct spi_mem_op *op)
> +{
> +	struct platform_device *pdev = cqspi->pdev;
> +	struct cqspi_platform_data *pdata = pdev->dev.platform_data;
> +	unsigned int tmpbufsize, n_trans = 0, totalxferlen = 0;
> +	void __iomem *iobase = cqspi->iobase;
> +	struct spi_mem_op_cadence ops[4] = { };
> +	struct spi_mem_op_cadence *cmd_ops = NULL;
> +	struct spi_mem_op_cadence *data_ops = NULL;
> +	struct spi_mem_op_cadence *dummy_ops = NULL;
> +	struct spi_mem_op_cadence *addr_ops = NULL;
> +	struct cqspi_flash_pdata *f_pdata;
> +	int rdid_length, mode, ret, i;
> +	u8 *tmpbuf;
> +	u32 sclk;
> +
> +	if (cqspi->current_cs != mem->spi->chip_select) {
> +		cqspi->current_cs = mem->spi->chip_select;
> +		cadence_qspi_switch_chipselect(cqspi, mem->spi->chip_select);
> +	}
> +
> +	f_pdata = &pdata->f_pdata[cqspi->current_cs];
> +	if (f_pdata->flash_type == QSPI_FLASH_TYPE_NOR)
> +		rdid_length = 6;
> +	else
> +		rdid_length = 3;
> +

What? NACK... why should driver worry about rdid_length?


> +	tmpbufsize = sizeof(op->cmd.opcode) + op->addr.nbytes +
> +			op->dummy.nbytes;
> +
> +	tmpbuf = kzalloc(tmpbufsize, GFP_KERNEL | GFP_DMA);
> +	if (!tmpbuf)
> +		return -ENOMEM;
> +
> +	tmpbuf[0] = op->cmd.opcode;
> +	ops[n_trans].tx_buf = tmpbuf;
> +	ops[n_trans].len = sizeof(op->cmd.opcode);
> +	ops[n_trans].tx_nbits = op->cmd.buswidth;
> +
> +	n_trans++;
> +	totalxferlen++;
> +
> +	if (op->addr.nbytes) {
> +		int i;
> +
> +		for (i = 0; i < op->addr.nbytes; i++)
> +			tmpbuf[i + 1] = op->addr.val >>
> +					(8 * (op->addr.nbytes - i - 1));
> +
> +		ops[n_trans].tx_buf = tmpbuf + 1;
> +		ops[n_trans].len = op->addr.nbytes;
> +		ops[n_trans].tx_nbits = op->addr.buswidth;
> +
> +		n_trans++;
> +		totalxferlen += op->addr.nbytes;
> +	}
> +	if (op->dummy.nbytes) {
> +		memset(tmpbuf + op->addr.nbytes + 1, 0xff, op->dummy.nbytes);
> +		ops[n_trans].tx_buf = tmpbuf + op->addr.nbytes + 1;
> +		ops[n_trans].len = op->dummy.nbytes;
> +		ops[n_trans].tx_nbits = op->dummy.buswidth;
> +
> +		n_trans++;
> +		totalxferlen += op->dummy.nbytes;
> +	}
> +	if (op->data.nbytes) {
> +		if (op->data.dir == SPI_MEM_DATA_IN) {
> +			ops[n_trans].rx_buf = op->data.buf.in;
> +			ops[n_trans].rx_nbits = op->data.buswidth;
> +		} else {
> +			ops[n_trans].tx_buf = op->data.buf.out;
> +			ops[n_trans].tx_nbits = op->data.buswidth;
> +		}
> +
> +		ops[n_trans].len = op->data.nbytes;
> +		n_trans++;
> +		totalxferlen += op->data.nbytes;
> +	}
> +
> +	for (i = 0; i < n_trans; i++)
> +		dev_dbg(&pdev->dev, "ops[%d] %d\n", i, ops[i].len);
> +
> +	switch (n_trans) {
> +	case 1:
> +		cmd_ops = &ops[0];
> +		break;
> +	case 2:
> +		cmd_ops = &ops[0];
> +		if (f_pdata->flash_type == QSPI_FLASH_TYPE_NAND) {
> +			if (data_ops->rx_buf)
> +				data_ops = &ops[1];
> +			else
> +				addr_ops = &ops[1];
> +		} else {
> +			data_ops = &ops[1];
> +		}


Please get ride of all flash type specific handling... There should be
no need for it. IF there are gaps in then lets discuss and fix it in
spi-nand and spi-nor frameworks and not in the driver.

spi-mem user should just take spi_mem_op template passed by the core and
execute it. No assumptions wrt flash type or opcode should be done.

> +		break;
> +	case 3:
> +		cmd_ops = &ops[0];
> +		addr_ops = &ops[1];
> +		data_ops = &ops[2];
> +		break;
> +	case 4:
> +		cmd_ops = &ops[0];
> +		addr_ops = &ops[1];
> +		dummy_ops = &ops[2];
> +		data_ops = &ops[3];
> +		break;
> +	default:
> +		dev_err(&pdev->dev, "Unsupported n_trans %u\n", n_trans);
> +		return -EINVAL;
> +	}
> +
> +	if (!data_ops)
> +		mode = STIG_WRITE_MODE;
> +	else if (data_ops->len > rdid_length)
> +		mode = data_ops->tx_buf ? IDC_WRITE_MODE : IDC_READ_MODE;
> +	else
> +		mode = data_ops->tx_buf ? STIG_WRITE_MODE : STIG_READ_MODE;
> +

Decision to use STIG was INDAC mode can be done using:

        if (op->data.dir == SPI_MEM_DATA_IN && op->data.buf.in) {
                if (!op->addr.nbytes)
                        mode = CQSPI_STIG_READ;
                else
                        mode = IDC_READ_MODE;
        } else {
                if (!op->addr.nbytes || !op->data.buf.out)
                        mode = CQSPI_STIG_WRITE;
                else
                        mode = IDC_WRITE_MODE;
        }

No need for rdid_length etc.

> +	sclk = mem->spi->max_speed_hz;
> +	cadence_qspi_controller_enable(iobase, 0);
> +	cadence_qspi_config_baudrate_div(iobase, pdata->master_ref_clk_hz,
> +					 sclk);
> +	cadence_qspi_delay(cqspi, pdata->master_ref_clk_hz, sclk);
> +	cadence_qspi_readdata_capture(iobase, 1, f_pdata->read_delay);
> +	cadence_qspi_controller_enable(iobase, 1);
> +
> +	/* execute transfer */
> +	switch (mode) {
> +	case STIG_WRITE_MODE:
> +		ret = cqspi_command_write(iobase, cmd_ops->len, cmd_ops->tx_buf,
> +					  addr_ops ? addr_ops->len : 0,
> +					  addr_ops ? addr_ops->tx_buf : NULL,
> +					  data_ops ? data_ops->len : 0,
> +					  data_ops ? data_ops->tx_buf : NULL,
> +					  f_pdata->flash_type);
> +		break;
> +	case STIG_READ_MODE:
> +		ret = cqspi_command_read(iobase, cmd_ops->len, cmd_ops->tx_buf,
> +					 addr_ops ? addr_ops->len : 0,
> +					 addr_ops ? addr_ops->tx_buf : NULL,
> +					 data_ops ? data_ops->len : 0,
> +					 data_ops ? data_ops->rx_buf : NULL,
> +					 f_pdata->flash_type);
> +		break;
> +	case IDC_WRITE_MODE:
> +		ret = cqspi_indirect_write_setup(iobase, cmd_ops->len,
> +						 cmd_ops->tx_buf,
> +						 addr_ops ? addr_ops->len : 0,
> +						 addr_ops ? addr_ops->tx_buf : 0,
> +						 f_pdata->flash_type,
> +						 f_pdata->quad);
> +		ret = cqspi_indirect_write_execute(cqspi, data_ops->len,
> +						   data_ops->tx_buf,
> +						   f_pdata->flash_type);
> +		break;
> +	case IDC_READ_MODE:
> +		ret = cqspi_indirect_read_setup(iobase, cmd_ops->len,
> +						cmd_ops->tx_buf,
> +						addr_ops ? addr_ops->len : 0,
> +						addr_ops ? addr_ops->tx_buf : 0,
> +						dummy_ops ? dummy_ops->len : 0,
> +						f_pdata->flash_type,
> +						f_pdata->quad);
> +		ret = cqspi_indirect_read_execute(cqspi, data_ops->len,
> +						  data_ops->rx_buf,
> +						  f_pdata->flash_type);
> +		/* TODO: for TI DMA + DAC to be enabled */

This is a big gap and there is lot of code sharing that can be done b/w
INDAC and DAC mode.

Looks like driver isn't quite close to being ready. I suggest you also
take a look at patches for spi-mem conversion of cadence-quadspi driver
in U-Boot as well:

https://patchwork.ozlabs.org/cover/1176362/

> +		break;
> +	default:
> +		dev_err(&pdev->dev, "Unsupported mode %u\n", mode);
> +		return -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +
> +int cadence_qspi_exec_mem_op(struct spi_mem *mem, const struct spi_mem_op *op)
> +{
> +	struct struct_cqspi *cqspi = spi_master_get_devdata(mem->spi->master);
> +	int ret;
> +
> +	mutex_lock(&cqspi->lock);
> +	ret = cadence_qspi_mem_process(cqspi, mem, op);
> +	if (ret)
> +		dev_err(&mem->spi->dev, "Error: qspi transfer failed!!!.\n");
> +	mutex_unlock(&cqspi->lock);
> +
> +	return ret;
> +}
> +
> +static const struct spi_controller_mem_ops cadence_qspi_mem_ops = {
> +	.exec_op = cadence_qspi_exec_mem_op,
> +};
> +
> +static int cadence_qspi_setup(struct spi_device *spi)
> +{
> +	if (spi->chip_select > spi->master->num_chipselect) {
> +		dev_err(&spi->dev, "%d CS is out of range\n", spi->chip_select);
> +		return -EINVAL;
> +	}
> +	return 0;
> +}
> +
> +static int cadence_qspi_of_get_pdata(struct platform_device *pdev)
> +{
> +	struct device_node *np = pdev->dev.of_node;
> +	struct device_node *nc;
> +	struct cqspi_platform_data *pdata = pdev->dev.platform_data;
> +	struct cqspi_flash_pdata *f_pdata;
> +	unsigned int cs;
> +	unsigned int prop;
> +
> +	pdata->is_decoded_cs = of_property_read_bool(np, "cdns,is-decoded-cs");
> +
> +	if (of_property_read_u32(np, "cdns,trigger-address", &prop)) {
> +		dev_err(&pdev->dev, "couldn't determine trigger-address\n");
> +		return -ENXIO;
> +	}
> +	pdata->trigger_address = prop;
> +
> +	pdata->rclk_en = of_property_read_bool(np, "cdns,rclk-en");
> +
> +	if (of_property_read_u32(np, "cdns,qspi-phyaddr", &prop)) {
> +		dev_err(&pdev->dev, "couldn't determine cdns,qspi-phyaddr\n");
> +		return -ENXIO;
> +	}
> +	pdata->qspi_ahb_phy = prop;
> +

Please dont add any new DT properties, there is no need for them. See
how this was handled in existing driver and reuse it

> +	if (of_property_read_u32(np, "cdns,qspi-physize", &prop)) {
> +		dev_info(&pdev->dev, "missing cdns,qspi-physize to 128 kB\n");
> +		prop = 128;
> +	}
> +	pdata->qspi_ahb_size = prop * 1024;
> +
> +	if (of_property_read_u32(np, "cdns,qspi-phymask", &prop))
> +		prop = CQSPI_INDIRECTTRIGGER_ADDR_MASK;
> +	pdata->qspi_ahb_mask = prop;
> +
> +	if (of_property_read_u32(np, "bus-num", &prop)) {
> +		dev_err(&pdev->dev, "couldn't determine bus-num\n");
> +		return -ENXIO;
> +	}
> +	pdata->bus_num = prop;
> +
> +	if (of_property_read_u32(np, "num-chipselect", &prop)) {
> +		dev_err(&pdev->dev, "couldn't determine num-chipselect\n");
> +		return -ENXIO;
> +	}
> +	pdata->num_chipselect = prop;
> +
> +	if (of_property_read_u32(np, "cdns,fifo-depth", &prop)) {
> +		dev_err(&pdev->dev, "couldn't determine fifo-depth\n");
> +		return -ENXIO;
> +	}
> +	pdata->fifo_depth = prop;
> +
> +	if (of_property_read_u32(np, "ext-decoder", &prop)) {
> +		dev_err(&pdev->dev, "couldn't determine ext-decoder\n");
> +		return -ENXIO;
> +	}
> +	pdata->ext_decoder = prop;
> +



> +	pdata->enable_dma = of_property_read_bool(np, "dmas");
> +	dev_info(&pdev->dev, "DMA %senabled\n", pdata->enable_dma ? "" : "NOT");
> +

Slave DMA was never supported and is not needed.

> +	/* Get flash devices platform data */
> +	for_each_child_of_node(np, nc) {
> +		if (!of_device_is_available(nc))
> +			continue;
> +
> +		if (of_property_read_u32(nc, "reg", &cs)) {
> +			dev_err(&pdev->dev, "couldn't determine reg\n");
> +			return -ENXIO;
> +		}
> +		f_pdata = &pdata->f_pdata[cs];
> +
> +		/* use compatible string to determine flash type */
> +		if (of_device_is_compatible(nc, "spinand"))
> +			f_pdata->flash_type = QSPI_FLASH_TYPE_NAND;
> +		else
> +			f_pdata->flash_type = QSPI_FLASH_TYPE_NOR;
> +
> +		if (of_property_read_u32(nc, "spi-rx-bus-width", &prop)) {
> +			dev_err(&pdev->dev, "couldn't determine quad\n");
> +			return -ENXIO;
> +		}
> +		f_pdata->quad = (prop == 4) ? QUAD_QIO : QUAD_SIO;
> +
> +		if (of_property_read_u32(nc, "page-size", &prop)) {
> +			dev_err(&pdev->dev, "couldn't determine page-size\n");
> +			return -ENXIO;
> +		}
> +		f_pdata->page_size = prop;
> +
> +		if (of_property_read_u32(nc, "block-size", &prop)) {
> +			dev_err(&pdev->dev, "couldn't determine block-size\n");
> +			return -ENXIO;
> +		}
> +		f_pdata->block_size = prop;
> +
> +		if (of_property_read_u32(nc, "cdns,read-delay", &prop)) {
> +			dev_err(&pdev->dev, "couldn't determine read-delay\n");
> +			return -ENXIO;
> +		}
> +		f_pdata->read_delay = prop;
> +
> +		if (of_property_read_u32(nc, "cdns,tshsl-ns", &prop)) {
> +			dev_err(&pdev->dev, "couldn't determine tshsl-ns\n");
> +			return -ENXIO;
> +		}
> +		f_pdata->tshsl_ns = prop;
> +
> +		if (of_property_read_u32(nc, "cdns,tsd2d-ns", &prop)) {
> +			dev_err(&pdev->dev, "couldn't determine tsd2d-ns\n");
> +			return -ENXIO;
> +		}
> +		f_pdata->tsd2d_ns = prop;
> +
> +		if (of_property_read_u32(nc, "cdns,tchsh-ns", &prop)) {
> +			dev_err(&pdev->dev, "couldn't determine tchsh-ns\n");
> +			return -ENXIO;
> +		}
> +		f_pdata->tchsh_ns = prop;
> +
> +		if (of_property_read_u32(nc, "cdns,tslch-ns", &prop)) {
> +			dev_err(&pdev->dev, "couldn't determine tslch-ns\n");
> +			return -ENXIO;
> +		}
> +		f_pdata->tslch_ns = prop;
> +	}
> +	return 0;
> +}
> +
> +static int cadence_qspi_probe(struct platform_device *pdev)
> +{
> +	struct cqspi_platform_data *pdata;
> +	struct device *dev = &pdev->dev;
> +	struct struct_cqspi *cqspi;
> +	struct spi_master *master;
> +	struct reset_control *rstc, *rstc_ocp;
> +	const struct cqspi_driver_platdata *ddata;
> +	struct resource *res = NULL;
> +	int ret;
> +
> +	master = spi_alloc_master(&pdev->dev, sizeof(*cqspi));
> +	if (!master) {
> +		dev_err(&pdev->dev, "spi_alloc_master failed\n");
> +		return -ENOMEM;
> +	}
> +	master->mode_bits = SPI_CS_HIGH | SPI_CPOL | SPI_CPHA | SPI_TX_QUAD |
> +				SPI_RX_QUAD | SPI_TX_DUAL | SPI_RX_DUAL;

Octal?

> +	master->setup = cadence_qspi_setup;
> +	master->mem_ops = &cadence_qspi_mem_ops;
> +	master->dev.of_node = pdev->dev.of_node;
> +	cqspi = spi_master_get_devdata(master);
> +	cqspi->pdev = pdev;
> +
> +	pdata = kmalloc(sizeof(*pdata), GFP_KERNEL);
> +	if (!pdata) {
> +		ret = -ENOMEM;
> +		goto err_pdata;
> +	}
> +	pdev->dev.platform_data = pdata;
> +
> +	cqspi->clk = devm_clk_get(&pdev->dev, "qspi");
> +	if (IS_ERR(cqspi->clk)) {
> +		dev_err(&pdev->dev, "cannot get qspi clk\n");
> +		return PTR_ERR(cqspi->clk);
> +	}
> +	pdata->master_ref_clk_hz = clk_get_rate(cqspi->clk);
> +
> +	ret = clk_prepare_enable(cqspi->clk);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "failed to enable qspi clock: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = cadence_qspi_of_get_pdata(pdev);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Get platform data failed.\n");
> +		return -ENODEV;
> +	}
> +
> +	cqspi->res = res;
> +	/* Obtain and remap controller address. */
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	cqspi->iobase = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(cqspi->iobase)) {
> +		dev_err(dev, "Cannot remap controller address.\n");
> +		return PTR_ERR(cqspi->iobase);
> +	}
> +
> +	/* Obtain and remap AHB address. */
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +	cqspi->qspi_ahb_virt = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(cqspi->qspi_ahb_virt)) {
> +		dev_err(dev, "Cannot remap AHB address.\n");
> +		return PTR_ERR(cqspi->qspi_ahb_virt);
> +	}
> +	cqspi->mmap_phys_base = (dma_addr_t)res->start;
> +	cqspi->ahb_size = resource_size(res);
> +
> +	/* Obtain QSPI reset control */
> +	rstc = devm_reset_control_get_optional_exclusive(dev, "qspi");
> +	if (IS_ERR(rstc)) {
> +		dev_err(dev, "Cannot get QSPI reset.\n");
> +		return PTR_ERR(rstc);
> +	}
> +
> +	rstc_ocp = devm_reset_control_get_optional_exclusive(dev, "qspi-ocp");
> +	if (IS_ERR(rstc_ocp)) {
> +		dev_err(dev, "Cannot get QSPI OCP reset.\n");
> +		return PTR_ERR(rstc_ocp);
> +	}
> +
> +	reset_control_assert(rstc);
> +	reset_control_deassert(rstc);
> +
> +	reset_control_assert(rstc_ocp);
> +	reset_control_deassert(rstc_ocp);
> +
> +	ddata  = of_device_get_match_data(dev);
> +	if (ddata && (ddata->quirks & CQSPI_NEEDS_WR_DELAY))
> +		cqspi->wr_delay = 5 * DIV_ROUND_UP(NSEC_PER_SEC,
> +						   pdata->master_ref_clk_hz);
> +
> +	init_completion(&cqspi->transfer_complete);
> +
> +	cqspi->irq = platform_get_irq(pdev, 0);
> +	if (cqspi->irq < 0) {
> +		dev_err(dev, "platform_get_irq failed.\n");
> +		ret = -ENXIO;
> +		goto err_irq;
> +	}
> +	ret = devm_request_irq(dev, cqspi->irq, cadence_qspi_irq_handler, 0,
> +			       pdev->name, cqspi);
> +	if (ret) {
> +		dev_err(dev, "request_irq failed.\n");
> +		goto err_irq;
> +	}
> +
> +	master->bus_num = pdata->bus_num;
> +	master->num_chipselect = pdata->num_chipselect;
> +	mutex_init(&cqspi->lock);
> +	platform_set_drvdata(pdev, master);
> +	cadence_qspi_controller_init(cqspi);
> +	cqspi->current_cs = 0;
> +
> +	ret = devm_spi_register_master(dev, master);
> +	if (ret) {
> +		dev_err(&pdev->dev, "devm_spi_register_master failed.\n");
> +		goto err_of;
> +	}
> +
> +	if (ddata && (ddata->quirks & CQSPI_DISABLE_DAC_MODE))
> +		cqspi->dac_mode = false;
> +
> +	return 0;
> +
> +err_pdata:
> +	kfree(pdata);
> +err_irq:
> +	free_irq(cqspi->irq, cqspi);
> +err_of:
> +	spi_master_put(master);
> +	dev_err(&pdev->dev, "Cadence QSPI controller probe failed\n");
> +	return ret;
> +}
> +
> +static int cadence_qspi_remove(struct platform_device *pdev)
> +{
> +	struct spi_master *master = platform_get_drvdata(pdev);
> +	struct struct_cqspi *cadence_qspi = spi_master_get_devdata(master);
> +
> +	cadence_qspi_controller_enable(cadence_qspi->iobase, 0);
> +	platform_set_drvdata(pdev, NULL);
> +	free_irq(cadence_qspi->irq, cadence_qspi);
> +	iounmap(cadence_qspi->iobase);
> +	iounmap(cadence_qspi->qspi_ahb_virt);
> +	release_mem_region(cadence_qspi->res->start,
> +			   resource_size(cadence_qspi->res));
> +	kfree(pdev->dev.platform_data);
> +	spi_unregister_master(master);
> +	spi_master_put(master);
> +	return 0;
> +}
> +
> +static const struct cqspi_driver_platdata k2g_qspi = {
> +	.quirks = CQSPI_NEEDS_WR_DELAY,
> +};
> +
> +static const struct cqspi_driver_platdata am654_ospi = {
> +	.quirks = CQSPI_NEEDS_WR_DELAY,
> +};
> +
> +static const struct cqspi_driver_platdata intel_lgm_qspi = {
> +	.quirks = CQSPI_DISABLE_DAC_MODE,
> +};
> +
> +#ifdef CONFIG_OF
> +static const struct of_device_id cadence_qspi_of_match[] = {
> +	{
> +		.compatible = "cadence,qspi",
> +	},
> +	{
> +		.compatible = "ti,k2g-qspi",
> +		.data = &k2g_qspi,
> +	},
> +	{
> +		.compatible = "ti,am654-ospi",
> +		.data = &am654_ospi,
> +	},
> +	{
> +		.compatible = "intel,lgm-qspi",
> +		.data = &intel_lgm_qspi,
> +	},
> +	{ /* end of table */}
> +};
> +MODULE_DEVICE_TABLE(of, cadence_qspi_of_match);
> +#else
> +#define cadence_qspi_of_match NULL
> +#endif /* CONFIG_OF */
> +
> +static struct platform_driver cadence_qspi_platform_driver = {
> +	.probe          = cadence_qspi_probe,
> +	.remove         = cadence_qspi_remove,
> +	.driver = {
> +		.name   = CADENCE_QSPI_NAME,
> +		.of_match_table = cadence_qspi_of_match,
> +	},
> +};
> +
> +module_platform_driver(cadence_qspi_platform_driver);
> +
> +MODULE_DESCRIPTION("Cadence QSPI Controller Driver");
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("platform:" CADENCE_QSPI_NAME);
> +MODULE_AUTHOR("Ley Foon Tan <lftan@altera.com>");
> +MODULE_AUTHOR("Graham Moore <grmoore@opensource.altera.com>");
> +MODULE_AUTHOR("Vadivel Murugan R <vadivel.muruganx.ramuthevar@intel.com>");
> diff --git a/drivers/spi/spi-cadence-quadspi.h b/drivers/spi/spi-cadence-quadspi.h
> new file mode 100644
> index 000000000000..c78ee9423950
> --- /dev/null
> +++ b/drivers/spi/spi-cadence-quadspi.h
> @@ -0,0 +1,272 @@
> +/* SPDX-License-Identifier: BSD-2-Clause */

NACK, should be GPLv2 and no need for boilerplate text below when SPDX
Identifier is present.

> +/*
> + * Driver for Cadence QSPI Controller
> + *
> + * Copyright Altera Corporation (C) 2012-2014. All rights reserved.
> + * Copyright Intel Corporation (C) 2019. All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License along with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +#ifndef __CADENCE_QSPI__H__
> +#define __CADENCE_QSPI__H__
> +#include <linux/reset.h>
> +#include <linux/spi/spi-mem.h>
> +
> +#define CQSPI_MAX_CHIP_SELECT		(16)
> +#define STIG_READ_MODE			1
> +#define STIG_WRITE_MODE			2
> +#define STIG_WRITE_READ_MODE		3
> +#define IDC_READ_MODE			4
> +#define IDC_WRITE_MODE			5
> +
> +#define QSPI_FLASH_TYPE_NOR		0
> +#define QSPI_FLASH_TYPE_NAND		1
> +


> +#define QUAD_SIO			0
> +#define QUAD_DIO			1
> +#define QUAD_QIO			2
> +
> +#define QUAD_LSB			4
> +

Have driver specific prefixes please.

> +#define MACRONIX_4PP_CMD		0x38
> +#define MACRONIX_WRSR_CMD		0x01
> +

These needs to be dropped

> +/* Operation timeout value */
> +#define CQSPI_TIMEOUT_MS			5000
> +#define CQSPI_READ_TIMEOUT_MS			10
> +#define CQSPI_POLL_IDLE_RETRY			3
> +#define CQSPI_FIFO_WIDTH			4
> +
> +/* Controller sram size in word */
> +#define CQSPI_REG_SRAM_RESV_WORDS		2
> +#define CQSPI_REG_SRAM_PARTITION_WR		1
> +#define CQSPI_REG_SRAM_THRESHOLD_BYTES		50
> +
> +/* Instruction type */
> +#define CQSPI_INST_TYPE_SINGLE			0
> +#define CQSPI_INST_TYPE_DUAL			1
> +#define CQSPI_INST_TYPE_QUAD			2
> +#define CQSPI_DUMMY_CLKS_PER_BYTE		8
> +#define CQSPI_DUMMY_BYTES_MAX			4
> +#define CQSPI_STIG_DATA_LEN_MAX			8
> +#define CQSPI_INDIRECTTRIGGER_ADDR_MASK		0xFFFFF
> +
> +/* Register map */
> +#define	CQSPI_REG_CONFIG			0x00
> +#define	CQSPI_REG_CONFIG_ENABLE_MASK		BIT(0)
> +#define	CQSPI_REG_CONFIG_DIRECT_MASK		BIT(7)
> +#define	CQSPI_REG_CONFIG_DECODE_MASK		BIT(9)
> +#define	CQSPI_REG_CONFIG_CHIPSELECT_LSB		10
> +#define CQSPI_REG_CONFIG_DMA_MASK		BIT(15)
> +#define	CQSPI_REG_CONFIG_BAUD_LSB		19
> +#define	CQSPI_REG_CONFIG_IDLE_LSB		31
> +#define	CQSPI_REG_CONFIG_CHIPSELECT_MASK	0xF
> +#define	CQSPI_REG_CONFIG_BAUD_MASK		0xF
> +#define	CQSPI_REG_RD_INSTR			0x04
> +#define	CQSPI_REG_RD_INSTR_OPCODE_LSB		0
> +#define	CQSPI_REG_RD_INSTR_TYPE_INSTR_LSB	8
> +#define	CQSPI_REG_RD_INSTR_TYPE_ADDR_LSB	12
> +#define	CQSPI_REG_RD_INSTR_TYPE_DATA_LSB	16
> +#define	CQSPI_REG_RD_INSTR_MODE_EN_LSB		20
> +#define	CQSPI_REG_RD_INSTR_DUMMY_LSB		24
> +#define	CQSPI_REG_RD_INSTR_TYPE_INSTR_MASK	0x3
> +#define	CQSPI_REG_RD_INSTR_TYPE_ADDR_MASK	0x3
> +#define	CQSPI_REG_RD_INSTR_TYPE_DATA_MASK	0x3
> +#define	CQSPI_REG_RD_INSTR_DUMMY_MASK		0x1F
> +#define	CQSPI_REG_WR_INSTR			0x08
> +#define	CQSPI_REG_WR_INSTR_OPCODE_LSB		0
> +#define	CQSPI_REG_WR_INSTR_TYPE_DATA_MASK	0x3
> +#define	CQSPI_REG_WR_INSTR_TYPE_DATA_LSB	16
> +#define	CQSPI_REG_WR_INSTR_TYPE_ADDR_MASK	0x3
> +#define	CQSPI_REG_WR_INSTR_TYPE_ADDR_LSB	12
> +
> +/*! Field WEL_DIS_FLD - wel_dis_fld */
> +#define CQSPI_REG_WR_CONFIG_WEL_DIS_FLD_POS	8
> +#define CQSPI_REG_WR_COMPLETION_CTRL		0x38
> +#define CQSPI_REG_WR_COMPLETION_DIS_POLLING_FLD_POS	14
> +
> +#define	CQSPI_REG_DELAY				0x0C
> +#define	CQSPI_REG_DELAY_TSLCH_LSB		0
> +#define	CQSPI_REG_DELAY_TCHSH_LSB		8
> +#define	CQSPI_REG_DELAY_TSD2D_LSB		16
> +#define	CQSPI_REG_DELAY_TSHSL_LSB		24
> +#define	CQSPI_REG_DELAY_TSLCH_MASK		0xFF
> +#define	CQSPI_REG_DELAY_TCHSH_MASK		0xFF
> +#define	CQSPI_REG_DELAY_TSD2D_MASK		0xFF
> +#define	CQSPI_REG_DELAY_TSHSL_MASK		0xFF
> +#define	CQSPI_REG_READCAPTURE			0x10
> +#define	CQSPI_REG_READCAPTURE_BYPASS_LSB	0
> +#define	CQSPI_REG_READCAPTURE_DELAY_LSB		1
> +#define	CQSPI_REG_READCAPTURE_DELAY_MASK	0xF
> +#define	CQSPI_REG_SIZE				0x14
> +#define	CQSPI_REG_SIZE_ADDRESS_LSB		0
> +#define	CQSPI_REG_SIZE_PAGE_LSB			4
> +#define	CQSPI_REG_SIZE_BLOCK_LSB		16
> +#define	CQSPI_REG_SIZE_ADDRESS_MASK		0xF
> +#define	CQSPI_REG_SIZE_PAGE_MASK		0xFFF
> +#define	CQSPI_REG_SIZE_BLOCK_MASK		0x3F
> +#define	CQSPI_REG_SRAMPARTITION			0x18
> +#define	CQSPI_REG_INDIRECTTRIGGER		0x1C
> +#define	CQSPI_REG_DMA				0x20
> +#define	CQSPI_REG_DMA_SINGLE_LSB		0
> +#define	CQSPI_REG_DMA_BURST_LSB			8
> +#define	CQSPI_REG_DMA_SINGLE_MASK		0xFF
> +#define	CQSPI_REG_DMA_BURST_MASK		0xFF
> +#define	CQSPI_REG_REMAP				0x24
> +#define	CQSPI_REG_MODE_BIT			0x28
> +#define	CQSPI_REG_SDRAMLEVEL			0x2C
> +#define	CQSPI_REG_SDRAMLEVEL_RD_LSB		0
> +#define	CQSPI_REG_SDRAMLEVEL_WR_LSB		16
> +#define	CQSPI_REG_SDRAMLEVEL_RD_MASK		0xFFFF
> +#define	CQSPI_REG_SDRAMLEVEL_WR_MASK		0xFFFF
> +
> +#define	CQSPI_REG_IRQSTATUS			0x40
> +#define	CQSPI_REG_IRQMASK			0x44
> +#define	CQSPI_REG_INDIRECTRD			0x60
> +#define	CQSPI_REG_INDIRECTRD_START_MASK		BIT(0)
> +#define	CQSPI_REG_INDIRECTRD_CANCEL_MASK	BIT(1)
> +#define	CQSPI_REG_INDIRECTRD_DONE_MASK		BIT(5)
> +#define	CQSPI_REG_INDIRECTRDWATERMARK		0x64
> +#define	CQSPI_REG_INDIRECTRDSTARTADDR		0x68
> +#define	CQSPI_REG_INDIRECTRDBYTES		0x6C
> +#define CQSPI_INDIRECT_TRIGGER_ADDR_RANGE_REG	0x80
> +#define	CQSPI_REG_CMDCTRL			0x90
> +#define	CQSPI_REG_CMDCTRL_EXECUTE_MASK		BIT(0)
> +#define	CQSPI_REG_CMDCTRL_INPROGRESS_MASK	BIT(1)
> +#define	CQSPI_REG_CMDCTRL_WR_BYTES_LSB		12
> +#define	CQSPI_REG_CMDCTRL_WR_EN_LSB		15
> +#define	CQSPI_REG_CMDCTRL_ADD_BYTES_LSB		16
> +#define	CQSPI_REG_CMDCTRL_ADDR_EN_LSB		19
> +#define	CQSPI_REG_CMDCTRL_RD_BYTES_LSB		20
> +#define	CQSPI_REG_CMDCTRL_RD_EN_LSB		23
> +#define	CQSPI_REG_CMDCTRL_OPCODE_LSB		24
> +#define	CQSPI_REG_CMDCTRL_WR_BYTES_MASK		0x7
> +#define	CQSPI_REG_CMDCTRL_ADD_BYTES_MASK	0x3
> +#define	CQSPI_REG_CMDCTRL_RD_BYTES_MASK		0x7
> +#define	CQSPI_REG_INDIRECTWR			0x70
> +#define	CQSPI_REG_INDIRECTWR_START_MASK		BIT(0)
> +#define	CQSPI_REG_INDIRECTWR_CANCEL_MASK	BIT(1)
> +#define	CQSPI_REG_INDIRECTWR_DONE_MASK		BIT(5)
> +#define	CQSPI_REG_INDIRECTWRWATERMARK		0x74
> +#define	CQSPI_REG_INDIRECTWRSTARTADDR		0x78
> +#define	CQSPI_REG_INDIRECTWRBYTES		0x7C
> +#define	CQSPI_REG_CMDADDRESS			0x94
> +#define	CQSPI_REG_CMDREADDATALOWER		0xA0
> +#define	CQSPI_REG_CMDREADDATAUPPER		0xA4
> +#define	CQSPI_REG_CMDWRITEDATALOWER		0xA8
> +#define	CQSPI_REG_CMDWRITEDATAUPPER		0xAC
> +
> +/* Interrupt status bits */
> +#define CQSPI_REG_IRQ_MODE_ERR			BIT(0)
> +#define CQSPI_REG_IRQ_UNDERFLOW			BIT(1)
> +#define CQSPI_REG_IRQ_IND_COMP			BIT(2)
> +#define CQSPI_REG_IRQ_IND_RD_REJECT		BIT(3)
> +#define CQSPI_REG_IRQ_WR_PROTECTED_ERR		BIT(4)
> +#define CQSPI_REG_IRQ_ILLEGAL_AHB_ERR		BIT(5)
> +#define CQSPI_REG_IRQ_WATERMARK			BIT(6)
> +#define CQSPI_REG_IRQ_IND_RD_OVERFLOW		BIT(12)
> +#define CQSPI_IRQ_STATUS_ERR		(CQSPI_REG_IRQ_MODE_ERR		| \
> +					 CQSPI_REG_IRQ_IND_RD_REJECT	| \
> +					 CQSPI_REG_IRQ_WR_PROTECTED_ERR	| \
> +					 CQSPI_REG_IRQ_ILLEGAL_AHB_ERR)
> +#define CQSPI_IRQ_MASK_RD		(CQSPI_REG_IRQ_MODE_ERR		| \
> +					 CQSPI_REG_IRQ_IND_RD_REJECT	| \
> +					 CQSPI_REG_IRQ_WATERMARK	| \
> +					 CQSPI_REG_IRQ_IND_RD_OVERFLOW	| \
> +					 CQSPI_REG_IRQ_IND_COMP)
> +#define CQSPI_IRQ_MASK_WR		(CQSPI_REG_IRQ_MODE_ERR		| \
> +					 CQSPI_REG_IRQ_WR_PROTECTED_ERR	| \
> +					 CQSPI_REG_IRQ_IND_COMP		| \
> +					 CQSPI_REG_IRQ_WATERMARK	| \
> +					 CQSPI_REG_IRQ_UNDERFLOW)
> +
> +#define CQSPI_IRQ_STATUS_MASK			(0xFFFFFFFF)
> +#define CQSPI_REG_IS_IDLE(base)					\
> +		((readl(base + CQSPI_REG_CONFIG) >>		\
> +			CQSPI_REG_CONFIG_IDLE_LSB) & 0x1)
> +#define CQSPI_CAL_DELAY(tdelay_ns, tref_ns, tsclk_ns)		\
> +		((((tdelay_ns) - (tsclk_ns)) / (tref_ns)))
> +#define CQSPI_GET_RD_SRAM_LEVEL(reg_basse)			\
> +		(((readl(reg_base + CQSPI_REG_SDRAMLEVEL)) >>	\
> +		CQSPI_REG_SDRAMLEVEL_RD_LSB) & CQSPI_REG_SDRAMLEVEL_RD_MASK)
> +
> +struct cqspi_flash_pdata {
> +	u32	page_size;
> +	u32	block_size;
> +	u32	flash_type;
> +	u32	quad;
> +	u32	read_delay;
> +	u32	tshsl_ns;
> +	u32	tsd2d_ns;
> +	u32	tchsh_ns;
> +	u32	tslch_ns;
> +};
> +
> +struct cqspi_platform_data {
> +	u32	bus_num;
> +	u32	num_chipselect;
> +	u32	qspi_ahb_phy;
> +	u32	qspi_ahb_size;
> +	u32	qspi_ahb_mask;
> +	u32	master_ref_clk_hz;
> +	u32	ext_decoder;
> +	u32	fifo_depth;
> +	u32	enable_dma;
> +	u32	tx_dma_peri_id;
> +	u32	rx_dma_peri_id;
> +	u32	trigger_address;
> +	bool	is_decoded_cs;
> +	bool	rclk_en;
> +	struct cqspi_flash_pdata f_pdata[CQSPI_MAX_CHIP_SELECT];
> +};
> +
> +struct struct_cqspi {
> +	struct platform_device	*pdev;
> +
> +	struct clk		*clk;
> +	struct clk		*fpi_clk;
> +
> +	struct reset_control	*reset;
> +	struct completion	transfer_complete;
> +	struct workqueue_struct	*workqueue;
> +	wait_queue_head_t	waitqueue;
> +	/* mutex lock for synchronization */
> +	struct mutex		lock;
> +
> +	void __iomem		*iobase;
> +	void __iomem		*qspi_ahb_virt;
> +	struct resource		*res;
> +	struct resource		*res_ahb;
> +	resource_size_t		ahb_size;
> +
> +	struct dma_chan		*rx_chan;
> +	struct completion       rx_dma_complete;
> +	dma_addr_t		mmap_phys_base;
> +	int			dma_done;
> +	u32			trigger_address;
> +	u32			wr_delay;
> +	u32			irq_status;
> +	int			current_cs;
> +	int			irq;
> +	bool			dac_mode;
> +};
> +
> +struct spi_mem_op_cadence {
> +	const void	*tx_buf;
> +	void		*rx_buf;
> +	u32		len;
> +	u32		tx_nbits:3;
> +	u32		rx_nbits:3;
> +};
> +
> +#endif /* __CADENCE_QSPI__H__ */
> 

-- 
Regards
Vignesh
