Return-Path: <linux-spi+bounces-6894-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 396F6A42066
	for <lists+linux-spi@lfdr.de>; Mon, 24 Feb 2025 14:22:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DBE816C4E9
	for <lists+linux-spi@lfdr.de>; Mon, 24 Feb 2025 13:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C805E24886D;
	Mon, 24 Feb 2025 13:21:28 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9213E248877;
	Mon, 24 Feb 2025 13:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740403288; cv=none; b=HiPu2Koym8B9yoa3BbDQTXqaJM/XAMxDsqulvxQLbfcBKelfK8V8edhzdwkmikbLXO4PTpT/ovieSi991euN9NYjxcqb8/lWV0TOSphVcTIG4DVOVzNzZ7lgdJrs1ITvRcYvtF6nrzO62p/GAGRJU0ljcJD4WMdqJ00YqwxH2KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740403288; c=relaxed/simple;
	bh=9RQ15RCja7xM8x8dxUpSCKgp018jIy0wsHH5lJIvyYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NuttBcdT377gWLhyDmeGRQdkz4n5m+DMV83ewuBtKXvHXh5Jjod6jUWflH4Oa1K04ZGNb7nQ+ITunp2p24FppUcZhtbkPFBI4IuSE6ss/l+e0xScpj/rhOS8Gjvhz3iVvz1DJkQFY3zS5b6Ii5i4TIQRh4fQ+N0DM+tsgajuSuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (unknown [116.232.55.252])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 67D90343183;
	Mon, 24 Feb 2025 13:21:25 +0000 (UTC)
Date: Mon, 24 Feb 2025 13:21:15 +0000
From: Yixun Lan <dlan@gentoo.org>
To: Longbin Li <looong.bin@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, sophgo@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH 2/3] spi: sophgo: add Sophgo SPI NOR controller driver
Message-ID: <20250224132115-GYA41655@gentoo>
References: <20250224101213.26003-1-looong.bin@gmail.com>
 <20250224101213.26003-3-looong.bin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224101213.26003-3-looong.bin@gmail.com>

Hi Longbin:

On 18:12 Mon 24 Feb     , Longbin Li wrote:
> Add support for Sophgo SPI NOR controller in Sophgo SoC.
> 
> Signed-off-by: Longbin Li <looong.bin@gmail.com>
> ---
>  drivers/spi/Kconfig          |   9 +
>  drivers/spi/Makefile         |   1 +
>  drivers/spi/spi-sophgo-nor.c | 501 +++++++++++++++++++++++++++++++++++
>  3 files changed, 511 insertions(+)
>  create mode 100644 drivers/spi/spi-sophgo-nor.c
> 
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index ea8a31032927..6b6d7b348485 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -1021,6 +1021,15 @@ config SPI_SN_F_OSPI
>  	  for connecting an SPI Flash memory over up to 8-bit wide bus.
>  	  It supports indirect access mode only.
> 
> +config SPI_SOPHGO_NOR
> +	tristate "Sophgo SPI NOR Controller"
> +	depends on ARCH_SOPHGO || COMPILE_TEST
> +	help
> +	  This enables support for the Sophgo SPI NOR controller,
> +	  which supports Dual/Qual read and write operations while
> +	  also supporting 3Byte address devices and 4Byte address
> +	  devices.
> +
>  config SPI_SPRD
>  	tristate "Spreadtrum SPI controller"
>  	depends on ARCH_SPRD || COMPILE_TEST
> diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
> index 9db7554c1864..9ded1de4b2fd 100644
> --- a/drivers/spi/Makefile
> +++ b/drivers/spi/Makefile
> @@ -134,6 +134,7 @@ obj-$(CONFIG_SPI_SH_SCI)		+= spi-sh-sci.o
>  obj-$(CONFIG_SPI_SIFIVE)		+= spi-sifive.o
>  obj-$(CONFIG_SPI_SLAVE_MT27XX)          += spi-slave-mt27xx.o
>  obj-$(CONFIG_SPI_SN_F_OSPI)		+= spi-sn-f-ospi.o
> +obj-$(CONFIG_SPI_SOPHGO_NOR)	+= spi-sophgo-nor.o
>  obj-$(CONFIG_SPI_SPRD)			+= spi-sprd.o
>  obj-$(CONFIG_SPI_SPRD_ADI)		+= spi-sprd-adi.o
>  obj-$(CONFIG_SPI_STM32) 		+= spi-stm32.o
> diff --git a/drivers/spi/spi-sophgo-nor.c b/drivers/spi/spi-sophgo-nor.c
> new file mode 100644
> index 000000000000..1139deeac327
> --- /dev/null
> +++ b/drivers/spi/spi-sophgo-nor.c
> @@ -0,0 +1,501 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Sophgo SPI NOR controller driver
> + *
> + * Copyright (c) 2025 Longbin Li <looong.bin@gmail.com>
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/iopoll.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/spi/spi-mem.h>
> +
> +/* Hardware register definitions */
> +#define SPIFMC_CTRL				0x00
> +#define SPIFMC_CTRL_CPHA			BIT(12)
> +#define SPIFMC_CTRL_CPOL			BIT(13)
> +#define SPIFMC_CTRL_HOLD_OL			BIT(14)
> +#define SPIFMC_CTRL_WP_OL			BIT(15)
> +#define SPIFMC_CTRL_LSBF			BIT(20)
> +#define SPIFMC_CTRL_SRST			BIT(21)
> +#define SPIFMC_CTRL_SCK_DIV_SHIFT		0
> +#define SPIFMC_CTRL_FRAME_LEN_SHIFT		16
> +#define SPIFMC_CTRL_SCK_DIV_MASK		0x7FF
> +
> +#define SPIFMC_CE_CTRL				0x04
> +#define SPIFMC_CE_CTRL_CEMANUAL			BIT(0)
> +#define SPIFMC_CE_CTRL_CEMANUAL_EN		BIT(1)
> +
> +#define SPIFMC_DLY_CTRL				0x08
> +#define SPIFMC_CTRL_FM_INTVL_MASK		0x000f
> +#define SPIFMC_CTRL_FM_INTVL			BIT(0)
> +#define SPIFMC_CTRL_CET_MASK			0x0f00
> +#define SPIFMC_CTRL_CET				BIT(8)
> +
> +#define SPIFMC_DMMR				0x0c
> +
> +#define SPIFMC_TRAN_CSR				0x10
> +#define SPIFMC_TRAN_CSR_TRAN_MODE_MASK		GENMASK(1, 0)
> +#define SPIFMC_TRAN_CSR_TRAN_MODE_RX		BIT(0)
> +#define SPIFMC_TRAN_CSR_TRAN_MODE_TX		BIT(1)
> +#define SPIFMC_TRAN_CSR_FAST_MODE		BIT(3)
> +#define SPIFMC_TRAN_CSR_BUS_WIDTH_1_BIT		(0x00 << 4)
> +#define SPIFMC_TRAN_CSR_BUS_WIDTH_2_BIT		(0x01 << 4)
> +#define SPIFMC_TRAN_CSR_BUS_WIDTH_4_BIT		(0x02 << 4)
> +#define SPIFMC_TRAN_CSR_DMA_EN			BIT(6)
> +#define SPIFMC_TRAN_CSR_MISO_LEVEL		BIT(7)
> +#define SPIFMC_TRAN_CSR_ADDR_BYTES_MASK		GENMASK(10, 8)
> +#define SPIFMC_TRAN_CSR_ADDR_BYTES_SHIFT	8
> +#define SPIFMC_TRAN_CSR_WITH_CMD		BIT(11)
> +#define SPIFMC_TRAN_CSR_FIFO_TRG_LVL_MASK	GENMASK(13, 12)
> +#define SPIFMC_TRAN_CSR_FIFO_TRG_LVL_1_BYTE	(0x00 << 12)
> +#define SPIFMC_TRAN_CSR_FIFO_TRG_LVL_2_BYTE	(0x01 << 12)
> +#define SPIFMC_TRAN_CSR_FIFO_TRG_LVL_4_BYTE	(0x02 << 12)
> +#define SPIFMC_TRAN_CSR_FIFO_TRG_LVL_8_BYTE	(0x03 << 12)
> +#define SPIFMC_TRAN_CSR_GO_BUSY			BIT(15)
> +#define SPIFMC_TRAN_CSR_ADDR4B_SHIFT		20
> +#define SPIFMC_TRAN_CSR_CMD4B_SHIFT		21
> +
> +#define SPIFMC_TRAN_NUM				0x14
> +#define SPIFMC_FIFO_PORT			0x18
> +#define SPIFMC_FIFO_PT				0x20
> +
> +#define SPIFMC_INT_STS				0x28
> +#define SPIFMC_INT_TRAN_DONE			BIT(0)
> +#define SPIFMC_INT_RD_FIFO			BIT(2)
> +#define SPIFMC_INT_WR_FIFO			BIT(3)
> +#define SPIFMC_INT_RX_FRAME			BIT(4)
> +#define SPIFMC_INT_TX_FRAME			BIT(5)
> +
> +#define SPIFMC_INT_EN				0x2c
> +#define SPIFMC_INT_TRAN_DONE_EN			BIT(0)
> +#define SPIFMC_INT_RD_FIFO_EN			BIT(2)
> +#define SPIFMC_INT_WR_FIFO_EN			BIT(3)
> +#define SPIFMC_INT_RX_FRAME_EN			BIT(4)
> +#define SPIFMC_INT_TX_FRAME_EN			BIT(5)
> +
> +#define SPIFMC_OPT				0x030
> +#define SPIFMC_OPT_DISABLE_FIFO_FLUSH		BIT(1)
> +
> +#define SPIFMC_MAX_FIFO_DEPTH			8
> +
> +#define SPIFMC_MAX_READ_SIZE			0x10000
> +
> +struct sophgo_spifmc {
> +	struct spi_controller *ctrl;
> +	void __iomem *io_base;
> +	struct device *dev;
> +	struct mutex lock;
it will be great to document the lock
> +	struct clk *clk;
> +};
> +
> +static int sophgo_spifmc_wait_int(struct sophgo_spifmc *spifmc, u8 int_type)
> +{
> +	u32 stat;
> +
> +	return readl_poll_timeout(spifmc->io_base + SPIFMC_INT_STS, stat,
> +				  (stat & int_type), 0, 1000000);
> +}
> +
> +static int sophgo_spifmc_wait_xfer_size(struct sophgo_spifmc *spifmc,
> +					int xfer_size)
> +{
> +	u8 stat;
> +
> +	return readl_poll_timeout(spifmc->io_base + SPIFMC_FIFO_PT, stat,
> +				  ((stat & 0xf) == xfer_size), 1, 1000000);
> +}
> +
> +static u32 sophgo_spifmc_init_reg(struct sophgo_spifmc *spifmc)
> +{
> +	u32 reg;
> +
> +	reg = readl(spifmc->io_base + SPIFMC_TRAN_CSR);
> +	reg &= ~(SPIFMC_TRAN_CSR_TRAN_MODE_MASK |
> +		 SPIFMC_TRAN_CSR_FAST_MODE |
> +		 SPIFMC_TRAN_CSR_BUS_WIDTH_2_BIT |
> +		 SPIFMC_TRAN_CSR_BUS_WIDTH_4_BIT |
> +		 SPIFMC_TRAN_CSR_DMA_EN |
> +		 SPIFMC_TRAN_CSR_ADDR_BYTES_MASK |
> +		 SPIFMC_TRAN_CSR_WITH_CMD |
> +		 SPIFMC_TRAN_CSR_FIFO_TRG_LVL_MASK);
> +
> +	writel(reg, spifmc->io_base + SPIFMC_TRAN_CSR);
> +
> +	return reg;
> +}
> +
> +static ssize_t sophgo_spifmc_read_64k(struct sophgo_spifmc *spifmc,
> +				      const struct spi_mem_op *op, loff_t from,
> +				      size_t len, u_char *buf)
> +{
> +	int xfer_size, offset;
> +	u32 reg;
> +	int ret;
> +	int i;
> +
> +	reg = sophgo_spifmc_init_reg(spifmc);
> +	reg |= (op->addr.nbytes + op->dummy.nbytes) << SPIFMC_TRAN_CSR_ADDR_BYTES_SHIFT;
> +	reg |= SPIFMC_TRAN_CSR_FIFO_TRG_LVL_8_BYTE;
> +	reg |= SPIFMC_TRAN_CSR_WITH_CMD;
> +	reg |= SPIFMC_TRAN_CSR_TRAN_MODE_RX;
> +
> +	writel(0, spifmc->io_base + SPIFMC_FIFO_PT);
> +	writeb(op->cmd.opcode, spifmc->io_base + SPIFMC_FIFO_PORT);
> +
> +	for (i = op->addr.nbytes - 1; i >= 0; i--)
> +		writeb((from >> i * 8) & 0xff, spifmc->io_base + SPIFMC_FIFO_PORT);
> +
> +	for (i = 0; i < op->dummy.nbytes; i++)
> +		writeb(0xff, spifmc->io_base + SPIFMC_FIFO_PORT);
> +
> +	writel(len, spifmc->io_base + SPIFMC_TRAN_NUM);
> +	writel(0, spifmc->io_base + SPIFMC_INT_STS);
> +	reg |= SPIFMC_TRAN_CSR_GO_BUSY;
> +	writel(reg, spifmc->io_base + SPIFMC_TRAN_CSR);
> +
> +	ret = sophgo_spifmc_wait_int(spifmc, SPIFMC_INT_RD_FIFO);
> +	if (ret < 0)
> +		return ret;
> +
> +	offset = 0;
> +	while (offset < len) {
> +		xfer_size = min_t(size_t, SPIFMC_MAX_FIFO_DEPTH, len - offset);
> +
> +		ret = sophgo_spifmc_wait_xfer_size(spifmc, xfer_size);
> +		if (ret < 0)
> +			return ret;
> +
> +		for (i = 0; i < xfer_size; i++)
> +			buf[i + offset] = readb(spifmc->io_base + SPIFMC_FIFO_PORT);
> +
> +		offset += xfer_size;
> +	}
> +
> +	ret = sophgo_spifmc_wait_int(spifmc, SPIFMC_INT_TRAN_DONE);
> +	if (ret < 0)
> +		return ret;
> +
> +	writel(0, spifmc->io_base + SPIFMC_FIFO_PT);
> +
> +	return len;
> +}
> +
> +static ssize_t sophgo_spifmc_read(struct sophgo_spifmc *spifmc,
> +				  const struct spi_mem_op *op)
> +{
> +	size_t xfer_size;
> +	size_t offset;
> +	loff_t from = op->addr.val;
> +	size_t len = op->data.nbytes;
> +	int ret;
> +	u8 *din = op->data.buf.in;
> +
> +	offset = 0;
> +	while (offset < len) {
> +		xfer_size = min_t(size_t, SPIFMC_MAX_READ_SIZE, len - offset);
> +
> +		ret = sophgo_spifmc_read_64k(spifmc, op, from, xfer_size, din);
> +		if (ret < 0)
> +			return ret;
> +
> +		offset += xfer_size;
> +		din += xfer_size;
> +		from += xfer_size;
> +	}
> +
> +	return 0;
> +}
> +
> +static ssize_t sophgo_spifmc_write(struct sophgo_spifmc *spifmc,
> +				   const struct spi_mem_op *op)
> +{
> +	size_t xfer_size;
> +	const u8 *dout = op->data.buf.out;
> +	int i, offset;
> +	size_t ret;
> +	u32 reg;
> +
> +	reg = sophgo_spifmc_init_reg(spifmc);
> +	reg |= (op->addr.nbytes + op->dummy.nbytes) << SPIFMC_TRAN_CSR_ADDR_BYTES_SHIFT;
> +	reg |= SPIFMC_TRAN_CSR_FIFO_TRG_LVL_8_BYTE;
> +	reg |= SPIFMC_TRAN_CSR_WITH_CMD;
> +	reg |= SPIFMC_TRAN_CSR_TRAN_MODE_TX;
> +
> +	writel(0, spifmc->io_base + SPIFMC_FIFO_PT);
> +	writeb(op->cmd.opcode, spifmc->io_base + SPIFMC_FIFO_PORT);
> +
> +	for (i = op->addr.nbytes - 1; i >= 0; i--)
> +		writeb((op->addr.val >> i * 8) & 0xff, spifmc->io_base + SPIFMC_FIFO_PORT);
> +
> +	for (i = 0; i < op->dummy.nbytes; i++)
> +		writeb(0xff, spifmc->io_base + SPIFMC_FIFO_PORT);
> +
> +	writel(0, spifmc->io_base + SPIFMC_INT_STS);
> +	writel(op->data.nbytes, spifmc->io_base + SPIFMC_TRAN_NUM);
> +	reg |= SPIFMC_TRAN_CSR_GO_BUSY;
> +	writel(reg, spifmc->io_base + SPIFMC_TRAN_CSR);
> +
> +	ret = sophgo_spifmc_wait_xfer_size(spifmc, 0);
> +	if (ret < 0)
> +		return ret;
> +
> +	writel(0, spifmc->io_base + SPIFMC_FIFO_PT);
> +
> +	offset = 0;
> +	while (offset < op->data.nbytes) {
> +		xfer_size = min_t(size_t, SPIFMC_MAX_FIFO_DEPTH, op->data.nbytes - offset);
> +
> +		ret = sophgo_spifmc_wait_xfer_size(spifmc, 0);
> +		if (ret < 0)
> +			return ret;
> +
> +		for (i = 0; i < xfer_size; i++)
> +			writeb(dout[i + offset], spifmc->io_base + SPIFMC_FIFO_PORT);
> +
> +		offset += xfer_size;
> +	}
> +
> +	ret = sophgo_spifmc_wait_int(spifmc, SPIFMC_INT_TRAN_DONE);
> +	if (ret < 0)
> +		return ret;
> +
> +	writel(0, spifmc->io_base + SPIFMC_FIFO_PT);
> +
> +	return 0;
> +}
> +
> +static ssize_t sophgo_spifmc_tran_cmd(struct sophgo_spifmc *spifmc,
> +				      const struct spi_mem_op *op)
> +{
> +	int i, ret;
> +	u32 reg;
> +
> +	reg = sophgo_spifmc_init_reg(spifmc);
> +	reg |= (op->addr.nbytes + op->dummy.nbytes) << SPIFMC_TRAN_CSR_ADDR_BYTES_SHIFT;
> +	reg |= SPIFMC_TRAN_CSR_FIFO_TRG_LVL_1_BYTE;
> +	reg |= SPIFMC_TRAN_CSR_WITH_CMD;
> +
> +	writel(0, spifmc->io_base + SPIFMC_FIFO_PT);
> +	writeb(op->cmd.opcode, spifmc->io_base + SPIFMC_FIFO_PORT);
> +
> +	for (i = op->addr.nbytes - 1; i >= 0; i--)
> +		writeb((op->addr.val >> i * 8) & 0xff, spifmc->io_base + SPIFMC_FIFO_PORT);
> +
> +	for (i = 0; i < op->dummy.nbytes; i++)
> +		writeb(0xff, spifmc->io_base + SPIFMC_FIFO_PORT);
> +
> +	writel(0, spifmc->io_base + SPIFMC_INT_STS);
> +	reg |= SPIFMC_TRAN_CSR_GO_BUSY;
> +	writel(reg, spifmc->io_base + SPIFMC_TRAN_CSR);
> +
> +	ret = sophgo_spifmc_wait_int(spifmc, SPIFMC_INT_TRAN_DONE);
> +	if (ret < 0)
> +		return ret;
> +
> +	writel(0, spifmc->io_base + SPIFMC_FIFO_PT);
> +
> +	return 0;
> +}
> +
> +static void sophgo_spifmc_trans(struct sophgo_spifmc *spifmc,
> +				const struct spi_mem_op *op)
> +{
> +	if (op->data.dir == SPI_MEM_DATA_IN)
> +		sophgo_spifmc_read(spifmc, op);
> +	else if (op->data.dir == SPI_MEM_DATA_OUT)
> +		sophgo_spifmc_write(spifmc, op);
> +	else
> +		sophgo_spifmc_tran_cmd(spifmc, op);
> +}
> +
> +static ssize_t sophgo_spifmc_trans_reg(struct sophgo_spifmc *spifmc,
> +				       const struct spi_mem_op *op)
> +{
> +	const u8 *dout = NULL;
> +	u8 *din = NULL;
> +	size_t len = op->data.nbytes;
> +	u32 reg;
> +	int ret;
> +	int i;
squash them which save one line:
	int i, ret;

> +
> +	if (op->data.dir == SPI_MEM_DATA_IN)
> +		din = op->data.buf.in;
> +	else
> +		dout = op->data.buf.out;
> +
> +	reg = sophgo_spifmc_init_reg(spifmc);
> +	reg |= SPIFMC_TRAN_CSR_FIFO_TRG_LVL_1_BYTE;
> +	reg |= SPIFMC_TRAN_CSR_WITH_CMD;
> +
> +	if (din) {
> +		reg |= SPIFMC_TRAN_CSR_BUS_WIDTH_1_BIT;
> +		reg |= SPIFMC_TRAN_CSR_TRAN_MODE_RX;
> +		reg |= SPIFMC_TRAN_CSR_TRAN_MODE_TX;
> +
> +		writel(SPIFMC_OPT_DISABLE_FIFO_FLUSH, spifmc->io_base + SPIFMC_OPT);
> +	} else {
> +		/*
> +		 * If write values to the Status Register,
> +		 * configure TRAN_CSR register as the same as
> +		 * sophgo_spifmc_read_reg.
> +		 */
> +		if (op->cmd.opcode == 0x01) {
> +			reg |= SPIFMC_TRAN_CSR_TRAN_MODE_RX;
> +			reg |= SPIFMC_TRAN_CSR_TRAN_MODE_TX;
> +			writel(len, spifmc->io_base + SPIFMC_TRAN_NUM);
> +		}
> +	}
> +
> +	writel(0, spifmc->io_base + SPIFMC_FIFO_PT);
> +	writeb(op->cmd.opcode, spifmc->io_base + SPIFMC_FIFO_PORT);
> +
> +	for (i = 0; i < len; i++) {
> +		if (din)
> +			writeb(0xff, spifmc->io_base + SPIFMC_FIFO_PORT);
> +		else
> +			writeb(dout[i], spifmc->io_base + SPIFMC_FIFO_PORT);
> +	}
> +
> +	writel(0, spifmc->io_base + SPIFMC_INT_STS);
> +	writel(len, spifmc->io_base + SPIFMC_TRAN_NUM);
> +	reg |= SPIFMC_TRAN_CSR_GO_BUSY;
> +	writel(reg, spifmc->io_base + SPIFMC_TRAN_CSR);
> +
> +	ret = sophgo_spifmc_wait_int(spifmc, SPIFMC_INT_TRAN_DONE);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (din) {
> +		while (len--)
> +			*din++ = readb(spifmc->io_base + SPIFMC_FIFO_PORT);
> +	}
> +
> +	writel(0, spifmc->io_base + SPIFMC_FIFO_PT);
> +
> +	return 0;
> +}
> +
> +static int sophgo_spifmc_exec_op(struct spi_mem *mem,
> +				 const struct spi_mem_op *op)
> +{
> +	struct sophgo_spifmc *spifmc;
> +
> +	spifmc = spi_controller_get_devdata(mem->spi->controller);
> +
> +	mutex_lock(&spifmc->lock);
> +
> +	if (op->addr.nbytes == 0)
> +		sophgo_spifmc_trans_reg(spifmc, op);
> +	else
> +		sophgo_spifmc_trans(spifmc, op);
> +
> +	mutex_unlock(&spifmc->lock);
> +
> +	return 0;
> +}
> +
> +static const struct spi_controller_mem_ops sophgo_spifmc_mem_ops = {
> +	.exec_op = sophgo_spifmc_exec_op,
> +};
> +
> +static void sophgo_spifmc_init(struct sophgo_spifmc *spifmc)
> +{
> +	u32 tran_csr;
> +	u32 reg;
> +
> +	writel(0, spifmc->io_base + SPIFMC_DMMR);
> +
> +	reg = readl(spifmc->io_base + SPIFMC_CTRL);
> +	reg |= SPIFMC_CTRL_SRST;
..
> +	reg &= ~((1 << 11) - 1);
so this is a mask? use macro to define, instead of using magic number
> +	reg |= 1;
> +	writel(reg, spifmc->io_base + SPIFMC_CTRL);
> +
> +	writel(0, spifmc->io_base + SPIFMC_CE_CTRL);
> +
> +	tran_csr = readl(spifmc->io_base + SPIFMC_TRAN_CSR);
> +	tran_csr |= (0 << SPIFMC_TRAN_CSR_ADDR_BYTES_SHIFT);
> +	tran_csr |= SPIFMC_TRAN_CSR_FIFO_TRG_LVL_4_BYTE;
> +	tran_csr |= SPIFMC_TRAN_CSR_WITH_CMD;
> +	writel(tran_csr, spifmc->io_base + SPIFMC_TRAN_CSR);
> +}
> +
> +static int sophgo_spifmc_probe(struct platform_device *pdev)
> +{
> +	struct spi_controller *ctrl;
> +	struct sophgo_spifmc *spifmc;
> +	void __iomem *base;
> +	int ret;
> +
> +	ctrl = devm_spi_alloc_host(&pdev->dev, sizeof(*spifmc));
> +	if (!ctrl)
> +		return -ENOMEM;
> +
> +	spifmc = spi_controller_get_devdata(ctrl);
> +	dev_set_drvdata(&pdev->dev, ctrl);
> +
..
> +	spifmc->clk = devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(spifmc->clk)) {
> +		dev_err(&pdev->dev, "AHB clock not found.\n");
> +		return PTR_ERR(spifmc->clk);
> +	}
> +
> +	ret = clk_prepare_enable(spifmc->clk);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Unable to enable AHB clock.\n");
> +		return ret;
> +	}
you can combine above with devm_clk_get_enabled(), and simplify 
return routine by using "return dev_err_probe(..)"

> +
> +	spifmc->dev = &pdev->dev;
> +	spifmc->ctrl = ctrl;
> +
> +	spifmc->io_base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	ctrl->num_chipselect = 1;
> +	ctrl->dev.of_node = pdev->dev.of_node;
> +	ctrl->bits_per_word_mask = SPI_BPW_MASK(8);
> +	ctrl->auto_runtime_pm = false;
> +	ctrl->mem_ops = &sophgo_spifmc_mem_ops;
> +	ctrl->mode_bits = SPI_RX_DUAL | SPI_TX_DUAL | SPI_RX_QUAD | SPI_TX_QUAD;
> +
> +	mutex_init(&spifmc->lock);
strictly, you still need to do error handler, e.g, destroy mutex if probe fail
> +
> +	sophgo_spifmc_init(spifmc);
> +	sophgo_spifmc_init_reg(spifmc);
> +
> +	return devm_spi_register_controller(&pdev->dev, ctrl);
> +}
> +
> +static void sophgo_spifmc_remove(struct platform_device *pdev)
> +{
> +	struct sophgo_spifmc *spifmc = platform_get_drvdata(pdev);
> +
> +	mutex_destroy(&spifmc->lock);
> +}
> +
> +static const struct of_device_id sophgo_spifmc_match[] = {
> +	{ .compatible = "sophgo,sg2044-spifmc-nor" },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, sophgo_spifmc_match);
> +
> +static struct platform_driver sophgo_nor_driver = {
> +	.driver = {
> +		.name = "sophgo,spifmc-nor",
> +		.of_match_table = sophgo_spifmc_match,
> +	},
> +	.probe = sophgo_spifmc_probe,
> +	.remove = sophgo_spifmc_remove,
> +};
..
> +
spurious blank line here, drop it
> +module_platform_driver(sophgo_nor_driver);
> +
> +MODULE_DESCRIPTION("Sophgo SPI NOR controller driver");
> +MODULE_AUTHOR("Longbin Li <looong.bin@gmail.com>");
> +MODULE_LICENSE("GPL");
> --
> 2.48.1

-- 
Yixun Lan (dlan)
Gentoo Linux Developer
GPG Key ID AABEFD55

