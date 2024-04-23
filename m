Return-Path: <linux-spi+bounces-2461-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D634B8AE282
	for <lists+linux-spi@lfdr.de>; Tue, 23 Apr 2024 12:44:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C2FC281767
	for <lists+linux-spi@lfdr.de>; Tue, 23 Apr 2024 10:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D8D219FD;
	Tue, 23 Apr 2024 10:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ZWgwFjAC"
X-Original-To: linux-spi@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31605D527;
	Tue, 23 Apr 2024 10:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713869051; cv=none; b=uVtMUwkNoaJvu0n5m2+1HeYLjiCGXQUn/xjF/zK0OjqURXH0mJQMdtRbyFAL/oIpYMZke/XxFylEsWASwhU4NURWxOPr+LA3l0YhBxNh/iC2m/SQ7xysayDl7m/x4nnzw9dexP4wfZTbtHZo4N194bellUsfqqmPYBS1caOMW8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713869051; c=relaxed/simple;
	bh=zDJt23fvtClF2RoGc5I6euxTC2BOtp2cbdM4k1tRlpk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ce/GgaFczGy5oVsX3AG9u2H/DmkjPW052oDL3QeaxctuOdDq4C3lSxuybYxSjcKNWfcSKD/oWAYiGPP5/ECYYmZPoeAAB8acYwL1o7qmiXDwTbSHWalRoT5pM51p4jTgE+WwPdfyF+asK9tyGIp2KALygCWPAnte/RFCzW3Xl6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ZWgwFjAC; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713869047;
	bh=zDJt23fvtClF2RoGc5I6euxTC2BOtp2cbdM4k1tRlpk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZWgwFjAC0CZKxSg8jP2Og1Eov6Avm1tDmmGvSj1woFCU7IpESc6BBle4X1/nsNGly
	 qi0UEull4XwHlPdPBeDOo/PedNt2/ThmOXRgCnT6Qgg4Dt0GWrX4PuBEx18hvJnlwq
	 niTgmA2jSRwUzHf0LmMt3vyxXH1y7MToYuWoZ0y1KZ0sreTz8UxTymHhtgCR/d+Xfd
	 RncRt+v8Cv5Xl4eLlk3rbXy5VAhV4bUNqzx8Q/dqmFsn12VYO5Zu+ptTN4Zf542usD
	 2gmbqS11PhbJLn5MmSonIifKSGeTmwc9A/5wr0s10qNECQ3hi11nFSRJmysUT8QRPB
	 YodOIIohOJx1A==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id E525D378208C;
	Tue, 23 Apr 2024 10:44:06 +0000 (UTC)
Message-ID: <d0e2918f-893a-4442-bdbf-36e95ffcd4d7@collabora.com>
Date: Tue, 23 Apr 2024 12:44:06 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] spi: airoha: add SPI-NAND Flash controller driver
To: Lorenzo Bianconi <lorenzo@kernel.org>, linux-spi@vger.kernel.org
Cc: conor@kernel.org, broonie@kernel.org, lorenzo.bianconi83@gmail.com,
 linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, nbd@nbd.name, john@phrozen.org, dd@embedd.com,
 catalin.marinas@arm.com, will@kernel.org, upstream@airoha.com
References: <cover.1713866770.git.lorenzo@kernel.org>
 <497dc9dad823fcd1403ed62ba164dd7d70f31f90.1713866770.git.lorenzo@kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <497dc9dad823fcd1403ed62ba164dd7d70f31f90.1713866770.git.lorenzo@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 23/04/24 12:16, Lorenzo Bianconi ha scritto:
> Introduce support for SPI-NAND driver of the Airoha NAND Flash Interface
> found on Airoha ARM SoCs.
> 
> Tested-by: Rajeev Kumar <Rajeev.Kumar@airoha.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>   MAINTAINERS                   |    9 +
>   drivers/spi/Kconfig           |   10 +
>   drivers/spi/Makefile          |    1 +
>   drivers/spi/spi-airoha-snfi.c | 1156 +++++++++++++++++++++++++++++++++
>   4 files changed, 1176 insertions(+)
>   create mode 100644 drivers/spi/spi-airoha-snfi.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index aa3b947fb080..ce9fac46f741 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -653,6 +653,15 @@ S:	Supported
>   F:	fs/aio.c
>   F:	include/linux/*aio*.h
>   
> +AIROHA SPI SNFI DRIVER
> +M:	Lorenzo Bianconi <lorenzo@kernel.org>
> +M:	Ray Liu <ray.liu@airoha.com>
> +L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> +L:	linux-spi@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/spi/airoha,en7581-snand.yaml
> +F:	drivers/spi/spi-airoha.c
> +
>   AIRSPY MEDIA DRIVER
>   L:	linux-media@vger.kernel.org
>   S:	Orphan
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index bc7021da2fe9..6fa91775f334 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -57,6 +57,16 @@ config SPI_MEM
>   
>   comment "SPI Master Controller Drivers"
>   
> +config SPI_AIROHA_SNFI
> +	tristate "Airoha SPI NAND Flash Interface"
> +	depends on ARCH_AIROHA || COMPILE_TEST
> +	depends on SPI_MASTER
> +	select REGMAP_MMIO
> +	help
> +	  This enables support for SPI-NAND mode on the Airoha NAND
> +	  Flash Interface found on Airoha ARM SoCs. This controller
> +	  is implemented as a SPI-MEM controller.
> +
>   config SPI_ALTERA
>   	tristate "Altera SPI Controller platform driver"
>   	select SPI_ALTERA_CORE
> diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
> index 4ff8d725ba5e..e694254dec04 100644
> --- a/drivers/spi/Makefile
> +++ b/drivers/spi/Makefile
> @@ -14,6 +14,7 @@ obj-$(CONFIG_SPI_SPIDEV)		+= spidev.o
>   obj-$(CONFIG_SPI_LOOPBACK_TEST)		+= spi-loopback-test.o
>   
>   # SPI master controller drivers (bus)
> +obj-$(CONFIG_SPI_AIROHA_SNFI)		+= spi-airoha-snfi.o
>   obj-$(CONFIG_SPI_ALTERA)		+= spi-altera-platform.o
>   obj-$(CONFIG_SPI_ALTERA_CORE)		+= spi-altera-core.o
>   obj-$(CONFIG_SPI_ALTERA_DFL)		+= spi-altera-dfl.o
> diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
> new file mode 100644
> index 000000000000..eacb32d6e28e
> --- /dev/null
> +++ b/drivers/spi/spi-airoha-snfi.c
> @@ -0,0 +1,1156 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2024 AIROHA Inc
> + * Author: Lorenzo Bianconi <lorenzo@kernel.org>
> + * Author: Ray Liu <ray.liu@airoha.com>
> + */
> +

..snip...

> +static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
> +					u64 offs, size_t len, void *buf)
> +{
> +	struct spi_device *spi = desc->mem->spi;
> +	struct airoha_snand_dev *as_dev = spi_get_ctldata(spi);
> +	struct spi_mem_op *op = &desc->info.op_tmpl;
> +	struct airoha_snand_ctrl *as_ctrl;
> +	u32 val, rd_mode;
> +	int err;
> +
> +	if (!as_dev->data_need_update)
> +		return len;
> +
> +	as_dev->data_need_update = false;
> +
> +	switch (op->cmd.opcode) {
> +	case SPI_NAND_OP_READ_FROM_CACHE_DUAL:
> +		rd_mode = 1;
> +		break;
> +	case SPI_NAND_OP_READ_FROM_CACHE_QUAD:
> +		rd_mode = 2;
> +		break;
> +	default:
> +		rd_mode = 0;
> +		break;
> +	}
> +
> +	as_ctrl = spi_controller_get_devdata(spi->controller);
> +	err = airoha_snand_set_mode(as_ctrl, SPI_MODE_DMA);
> +	if (err < 0)
> +		return err;
> +
> +	err = airoha_snand_nfi_config(as_ctrl);
> +	if (err)
> +		return err;
> +
> +	dma_sync_single_for_device(as_ctrl->dev, as_dev->dma_addr,
> +				   as_dev->buf_len, DMA_BIDIRECTIONAL);
> +	mb();

Are you sure you need this memory barrier here?

P.S.: Just in case... any other write or read will anyway add a barrier ;-)

> +
> +	/* set dma addr */
> +	err = regmap_write(as_ctrl->regmap_nfi, REG_SPI_NFI_STRADDR,
> +			   as_dev->dma_addr);
> +	if (err)
> +		return err;
> +

..snip..

> +
> +static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
> +					 u64 offs, size_t len, const void *buf)
> +{
> +	struct spi_device *spi = desc->mem->spi;
> +	struct airoha_snand_dev *as_dev = spi_get_ctldata(spi);
> +	struct spi_mem_op *op = &desc->info.op_tmpl;
> +	struct airoha_snand_ctrl *as_ctrl;
> +	u32 wr_mode, val;
> +	int err;
> +
> +	as_ctrl = spi_controller_get_devdata(spi->controller);
> +	err = airoha_snand_set_mode(as_ctrl, SPI_MODE_MANUAL);
> +	if (err < 0)
> +		return err;
> +
> +	dma_sync_single_for_cpu(as_ctrl->dev, as_dev->dma_addr,
> +				as_dev->buf_len, DMA_BIDIRECTIONAL);
> +	memcpy(as_dev->txrx_buf + offs, buf, len);
> +	dma_sync_single_for_device(as_ctrl->dev, as_dev->dma_addr,
> +				   as_dev->buf_len, DMA_BIDIRECTIONAL);
> +	mb();
> +
> +	err = airoha_snand_set_mode(as_ctrl, SPI_MODE_DMA);
> +	if (err < 0)
> +		return err;
> +
> +	err = airoha_snand_nfi_config(as_ctrl);
> +	if (err)
> +		return err;
> +
> +	if (op->cmd.opcode == SPI_NAND_OP_PROGRAM_LOAD_QUAD ||
> +	    op->cmd.opcode == SPI_NAND_OP_PROGRAM_LOAD_RAMDON_QUAD)
> +		wr_mode = 2;

I'm mostly sure that this '2' is supposed to be BIT(1) instead

> +	else
> +		wr_mode = 0;
> +
> +	err = regmap_write(as_ctrl->regmap_nfi, REG_SPI_NFI_STRADDR,
> +			   as_dev->dma_addr);
> +	if (err)
> +		return err;
> +
> +	val = as_ctrl->nfi_cfg.sec_size * as_ctrl->nfi_cfg.sec_num;
> +	val = FIELD_PREP(SPI_NFI_PROG_LOAD_BYTE_NUM, val);

val = FIELD_PREP(SPI_NFI_PROG_LOAD_BYTE_NUM,
                  as_ctrl->nfi_cfg.sec_size * as_ctrl->nfi_cfg.sec_num);

Being this 100 cols eventually, you wouldn't even need two lines - but
if you don't want to go 100, it's still more readable (imo) like this,
even if in two lines.

> +	err = regmap_update_bits(as_ctrl->regmap_nfi,
> +				 REG_SPI_NFI_SNF_MISC_CTL2,
> +				 SPI_NFI_PROG_LOAD_BYTE_NUM, val);
> +	if (err)
> +		return err;
> +
> +	err = regmap_write(as_ctrl->regmap_nfi, REG_SPI_NFI_PG_CTL1,
> +			   FIELD_PREP(SPI_NFI_PG_LOAD_CMD,
> +				      op->cmd.opcode));
> +	if (err)
> +		return err;
> +
> +	err = regmap_write(as_ctrl->regmap_nfi, REG_SPI_NFI_SNF_MISC_CTL,
> +			   FIELD_PREP(SPI_NFI_DATA_READ_WR_MODE, wr_mode));
> +	if (err)
> +		return err;
> +

..snip..

> +
> +#define SPI_NAND_CACHE_SIZE	(4096 + 256)

#include <linux/sizes.h>      <--- at the beginning

#define SPI_NAND_CACHE_SIZE (SZ_4K + SZ_256)

...there are macros for that, might as well use them, right? :-)

> +
> +static int airoha_snand_setup(struct spi_device *spi)
> +{
> +	struct airoha_snand_dev *as_dev = spi_get_ctldata(spi);
> +	struct airoha_snand_ctrl *as_ctrl;
> +
> +	as_dev = kzalloc(sizeof(*as_dev), GFP_KERNEL);
> +	if (!as_dev)
> +		return -ENOMEM;
> +
> +	spi_set_ctldata(spi, as_dev);
> +	as_dev->data_need_update = true;
> +
> +	/* prepare device buffer */
> +	as_dev->buf_len = SPI_NAND_CACHE_SIZE;
> +	as_dev->txrx_buf = kzalloc(as_dev->buf_len, GFP_KERNEL);
> +	if (!as_dev->txrx_buf)
> +		goto error_dev_free;
> +
> +	as_ctrl = spi_controller_get_devdata(spi->controller);
> +	as_dev->dma_addr = dma_map_single(as_ctrl->dev, as_dev->txrx_buf,
> +					  as_dev->buf_len, DMA_BIDIRECTIONAL);
> +	if (dma_mapping_error(as_ctrl->dev, as_dev->dma_addr))
> +		goto error_buf_free;
> +
> +	return 0;
> +
> +error_buf_free:
> +	kfree(as_dev->txrx_buf);
> +error_dev_free:
> +	kfree(as_dev);
> +
> +	return -EINVAL;
> +}
> +
> +static void airoha_snand_cleanup(struct spi_device *spi)
> +{
> +	struct airoha_snand_dev *as_dev = spi_get_ctldata(spi);
> +	struct airoha_snand_ctrl *as_ctrl;
> +
> +	as_ctrl = spi_controller_get_devdata(spi->controller);
> +	dma_unmap_single(as_ctrl->dev, as_dev->dma_addr,
> +			 as_dev->buf_len, DMA_BIDIRECTIONAL);
> +	kfree(as_dev->txrx_buf);
> +
> +	spi_set_ctldata(spi, NULL);
> +}
> +
> +static int airoha_snand_nfi_setup(struct airoha_snand_ctrl *as_ctrl)
> +{
> +	u32 val, sec_size, sec_num;
> +	int err;
> +
> +	err = regmap_read(as_ctrl->regmap_nfi, REG_SPI_NFI_CON, &val);
> +	if (err)
> +		return err;
> +
> +	sec_num = FIELD_GET(SPI_NFI_SEC_NUM, val);
> +
> +	err = regmap_read(as_ctrl->regmap_nfi,
> +			  REG_SPI_NFI_SECCUS_SIZE, &val);
> +	if (err)
> +		return err;
> +
> +	sec_size = FIELD_GET(SPI_NFI_CUS_SEC_SIZE, val);
> +
> +	/* init default value */
> +	as_ctrl->nfi_cfg.sec_size = sec_size;
> +	as_ctrl->nfi_cfg.sec_num = sec_num;
> +	as_ctrl->nfi_cfg.page_size = rounddown(sec_size * sec_num, 1024);
> +	as_ctrl->nfi_cfg.spare_size = 16;
> +
> +	err = airoha_snand_nfi_init(as_ctrl);
> +	if (err)
> +		return err;
> +
> +	return airoha_snand_nfi_config(as_ctrl);
> +}
> +
> +static const struct regmap_config spi_ctrl_regmap_config = {
> +	.name		= "ctrl",
> +	.reg_bits	= 32,
> +	.val_bits	= 32,
> +	.reg_stride	= 4,
> +	.max_register	= REG_SPI_CTRL_NFI2SPI_EN,
> +};
> +
> +static const struct regmap_config spi_nfi_regmap_config = {
> +	.name		= "nfi",
> +	.reg_bits	= 32,
> +	.val_bits	= 32,
> +	.reg_stride	= 4,
> +	.max_register	= REG_SPI_NFI_SNF_NFI_CNFG,
> +};
> +
> +static const struct of_device_id airoha_snand_ids[] = {
> +	{ .compatible	= "airoha,en7581-snand" },
> +	{ }

{ /* sentinel */ }

...please!

> +};
> +MODULE_DEVICE_TABLE(of, airoha_snand_ids);
> +

Cheers,
Angelo



