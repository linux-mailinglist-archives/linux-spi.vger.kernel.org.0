Return-Path: <linux-spi+bounces-2475-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D65AF8AFCE4
	for <lists+linux-spi@lfdr.de>; Wed, 24 Apr 2024 01:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AE4828150D
	for <lists+linux-spi@lfdr.de>; Tue, 23 Apr 2024 23:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2E33EA95;
	Tue, 23 Apr 2024 23:51:36 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from fgw22-7.mail.saunalahti.fi (fgw22-7.mail.saunalahti.fi [62.142.5.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F9143AC1
	for <linux-spi@vger.kernel.org>; Tue, 23 Apr 2024 23:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713916296; cv=none; b=sx7jmgHmmW72Hh6BAY5QRkKeQubqVICC2bLSh7L3yU+OFjJZFejnlVJzHZxsVQSAODsI+02EuYel2Woeb3pcn+HeiANyPtz4nsXxKDKoiyx7sCZCMxOcMITY5oCN48BgiTdDr3SmBPcovNMdjq++S0Ea+wuAlT7eJn+/RXFfnSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713916296; c=relaxed/simple;
	bh=EAaY3X0XQewWtGYPMs954mCQEcRmHFcBBCFOcrbFz90=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f8vkaftj0KDYMP4Li+NnOKeIsEWX0deQIyBz8imTu0KnLVwtAjt7smQ5s0G7Sw3Mt2bK2+dojSqBEUblaXsL4XXADyWv3wzODrxa+AvphBUiGOVKsi7cY8KdDNDBjLI/Xl6pbozGzFmJzNkkTaqnbwJVyNkjoE2xkFSY6Kbsv5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-25-208.elisa-laajakaista.fi [88.113.25.208])
	by fgw20.mail.saunalahti.fi (Halon) with ESMTP
	id 65415545-01cc-11ef-b3cf-005056bd6ce9;
	Wed, 24 Apr 2024 02:51:26 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 24 Apr 2024 02:51:25 +0300
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-spi@vger.kernel.org, conor@kernel.org, broonie@kernel.org,
	lorenzo.bianconi83@gmail.com, linux-arm-kernel@lists.infradead.org,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org, nbd@nbd.name,
	john@phrozen.org, dd@embedd.com, catalin.marinas@arm.com,
	will@kernel.org, upstream@airoha.com,
	angelogioacchino.delregno@collabora.com
Subject: Re: [PATCH v3 3/3] spi: airoha: add SPI-NAND Flash controller driver
Message-ID: <ZihJfcmjoJZwLofz@surfacebook.localdomain>
References: <cover.1713866770.git.lorenzo@kernel.org>
 <497dc9dad823fcd1403ed62ba164dd7d70f31f90.1713866770.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <497dc9dad823fcd1403ed62ba164dd7d70f31f90.1713866770.git.lorenzo@kernel.org>

Tue, Apr 23, 2024 at 12:16:37PM +0200, Lorenzo Bianconi kirjoitti:
> Introduce support for SPI-NAND driver of the Airoha NAND Flash Interface
> found on Airoha ARM SoCs.

...

> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/device.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/init.h>
> +#include <linux/iopoll.h>

> +#include <linux/kernel.h>

Make sure you are using exact headers you need, this one seems "proxy" and not
really in use here.

(Quite likely you wanted minmax.h, types.h, and possible others.)

> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/spi/spi.h>
> +#include <linux/spi/spi-mem.h>

...

> +#define SPI_NFI_ALL_IRQ_EN			(SPI_NFI_RD_DONE_EN | \
> +						 SPI_NFI_WR_DONE_EN | \
> +						 SPI_NFI_RST_DONE_EN | \
> +						 SPI_NFI_ERASE_DONE_EN | \
> +						 SPI_NFI_BUSY_RETURN_EN | \
> +						 SPI_NFI_ACCESS_LOCK_EN | \
> +						 SPI_NFI_AHB_DONE_EN)

What about writing this as

#define SPI_NFI_ALL_IRQ_EN					\
	(SPI_NFI_RD_DONE_EN | SPI_NFI_WR_DONE_EN |		\
	 SPI_NFI_RST_DONE_EN | SPI_NFI_ERASE_DONE_EN |		\
	 SPI_NFI_BUSY_RETURN_EN | SPI_NFI_ACCESS_LOCK_EN |	\
	 SPI_NFI_AHB_DONE_EN)

?

...

> +enum airoha_snand_mode {
> +	SPI_MODE_AUTO,
> +	SPI_MODE_MANUAL,
> +	SPI_MODE_DMA,
> +	SPI_MODE_NO

Is _NO a termination entry? Meaning there always be only 3 modes no matter
what. If not, leave the trailing comma as it helps to reduce a burden in case
this list will be expanded.

> +};

...

> +struct airoha_snand_dev {
> +	size_t buf_len;
> +
> +	u8 *txrx_buf;
> +	dma_addr_t dma_addr;
> +
> +	bool data_need_update;
> +	u64 cur_page_num;
> +};

Most likely `pahole` shows better layout to save a few bytes in some cases.

...

> +struct airoha_snand_ctrl {
> +	struct device *dev;
> +	struct regmap *regmap_ctrl;
> +	struct regmap *regmap_nfi;
> +	struct clk *spi_clk;
> +
> +	struct {
> +		size_t page_size;
> +		size_t sec_size;

> +		unsigned char sec_num;
> +		unsigned char spare_size;

Hmm... Why not u8 for both of these?

> +	} nfi_cfg;
> +};

...

> +static int airoha_snand_write_data(struct airoha_snand_ctrl *as_ctrl, u8 cmd,
> +				   const u8 *data, int len)
> +{
> +	int i = 0;
> +
> +	while (i < len) {

Seems nothing prevents you from using for-loop here as well.

> +		int data_len = min(len, MAX_TRANSFER_SIZE);
> +		int err;
> +
> +		err = airoha_snand_set_fifo_op(as_ctrl, cmd, data_len);
> +		if (err)
> +			return err;
> +
> +		err = airoha_snand_write_data_to_fifo(as_ctrl, &data[i],
> +						      data_len);
> +		if (err < 0)
> +			return err;
> +
> +		i += data_len;
> +	}
> +
> +	return 0;
> +}

...

> +static int airoha_snand_read_data(struct airoha_snand_ctrl *as_ctrl, u8 *data,
> +				  int len)

As per above.

...

> +	/* addr part */
> +	for (i = 0; i < op->addr.nbytes; i++) {
> +		u8 cmd = opcode == SPI_NAND_OP_GET_FEATURE ? 0x11 : 0x8;
> +
> +		data = op->addr.val >> ((op->addr.nbytes - i - 1) * 8);

Seems like you wanted to have always the same endianess and hence can be done
outside the loop via cpu_to_xxx()?

> +		err = airoha_snand_write_data(as_ctrl, cmd, &data,
> +					      sizeof(data));
> +		if (err)
> +			return err;
> +	}

...

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

Why not utilising cleanup.h? (__free(), no_free_ptr(), etc)

> +	return -EINVAL;
> +}

...

> +	err = regmap_read(as_ctrl->regmap_nfi,
> +			  REG_SPI_NFI_SECCUS_SIZE, &val);

One line?

> +	if (err)
> +		return err;

...

> +	as_ctrl->nfi_cfg.page_size = rounddown(sec_size * sec_num, 1024);

round_down() is optimised for power-of-2.
You would need to include math.h IIRC.

...

> +	as_ctrl->regmap_ctrl = devm_regmap_init_mmio(&pdev->dev, base,
> +						     &spi_ctrl_regmap_config);

With help of

	struct device *dev = &pdev->dev;

at the top of the function the entire code will become neater.

> +	if (IS_ERR(as_ctrl->regmap_ctrl)) {
> +		dev_err(&pdev->dev, "failed to init spi ctrl regmap: %ld\n",
> +			PTR_ERR(as_ctrl->regmap_ctrl));
> +		return PTR_ERR(as_ctrl->regmap_ctrl);

		return dev_err_probe(...);

> +	}

...

> +		dev_err(&pdev->dev, "failed to init spi nfi regmap: %ld\n",
> +			PTR_ERR(as_ctrl->regmap_nfi));
> +		return PTR_ERR(as_ctrl->regmap_nfi);

		return dev_err_probe(...);

...

> +		dev_err(&pdev->dev, "unable to get spi clk");
> +		return PTR_ERR(as_ctrl->spi_clk);

Ditto.

...

> +

Unneeded blank line.

> +module_platform_driver(airoha_snand_driver);

-- 
With Best Regards,
Andy Shevchenko



