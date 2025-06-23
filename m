Return-Path: <linux-spi+bounces-8718-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9A9AE39B7
	for <lists+linux-spi@lfdr.de>; Mon, 23 Jun 2025 11:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 522587A389D
	for <lists+linux-spi@lfdr.de>; Mon, 23 Jun 2025 09:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85665235065;
	Mon, 23 Jun 2025 09:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MUME+Uqq"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CA9231836;
	Mon, 23 Jun 2025 09:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750670230; cv=none; b=q6KZFWQw9K9DvYgJ7KMJy+dAAt8jR7yIbx/Kh2LMlsSZAummbxEmeLvqW8z8oSDb+nUZx4xq8kie9SljyrIvZf9HOqhj2BP+hoS0tGWQR4xZI6IPhW5ksqWaw/emjhbWGM2CGerkNbF6DQslHkIE/qbKKI31aCcOVc05S8EclFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750670230; c=relaxed/simple;
	bh=lTDfnouWRD6t3V6geE9rp1WNIhalLtWBgQjfMtQEnOE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RFVsJ5rkRmcWsqdZQfCcU1KhuatVvQCEy2tpKWaqJChX5X+ATplg/9HvwYegYcn+6rLPD34pr7r48OesiriaItEaseo98wdDu2bkgzHAlrWb8shAororhcn+8c0cmjinTxZJmuqO2GCxDuGYM2f5W0UiYy6u+PrdYAp1EksnGC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MUME+Uqq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52D14C4CEEA;
	Mon, 23 Jun 2025 09:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750670229;
	bh=lTDfnouWRD6t3V6geE9rp1WNIhalLtWBgQjfMtQEnOE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MUME+Uqqq7s2+T36iA3RvUi0SBjyyMkJl4SKlUBTXtmPzHi9j5RO+ycfMilJ6C3Uq
	 1zVHxG+wHBKMObnmE7sQ/Ectd5HvvSM72v/DU8SS7fB8R8/5ntX7X3x4C1+aWSlb2f
	 +H/czKXjOmY5DiWiZwyUOoQZhJXYNxvsK1ipFnhaP0wHgAMJaOGYUqoZnTihupqz58
	 6OPULul71gq+mtpKTkoNclWpgN54UN/A44+HHw5XaeTinNqlDII279RmCLCN7e1IGx
	 URCfyoehLGA9gGBPvJZBTUj0pLiXEkrIatkLzFCBaGQohZtRM8irQBy7nEteiB8887
	 2SC+iQuUK1JCQ==
Message-ID: <682a48fc-8451-46e5-b3a8-5ad7c237588e@kernel.org>
Date: Mon, 23 Jun 2025 11:17:05 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] spi: Add Amlogic SPISG driver
To: xianwei.zhao@amlogic.com, Sunny Luo <sunny.luo@amlogic.com>,
 Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-amlogic@lists.infradead.org, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250623-spisg-v3-0-c731f57e289c@amlogic.com>
 <20250623-spisg-v3-2-c731f57e289c@amlogic.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20250623-spisg-v3-2-c731f57e289c@amlogic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/06/2025 10:53, Xianwei Zhao via B4 Relay wrote:
> From: Sunny Luo <sunny.luo@amlogic.com>
> 
> Introduced support for the new SPI IP (SPISG) driver. The SPISG is
> a communication-oriented SPI controller from Amlogic,supporting
> three operation modes: PIO, block DMA, and scatter-gather DMA.
> 
> Signed-off-by: Sunny Luo <sunny.luo@amlogic.com>
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> ---
>  drivers/spi/Kconfig             |   9 +
>  drivers/spi/Makefile            |   1 +
>  drivers/spi/spi-amlogic-spisg.c | 876 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 886 insertions(+)
> 
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index c51da3fc3604..e11341df2ecf 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -99,6 +99,15 @@ config SPI_AMLOGIC_SPIFC_A1
>  	  This enables master mode support for the SPIFC (SPI flash
>  	  controller) available in Amlogic A1 (A113L SoC).
>  
> +config SPI_AMLOGIC_SPISG
> +	tristate "Amlogic SPISG controller"
> +	depends on COMMON_CLK
> +	depends on ARCH_MESON || COMPILE_TEST
> +	help
> +	  This enables master mode support for the SPISG (SPI scatter-gather
> +	  communication controller), which is available on platforms such as
> +	  Amlogic A4 SoCs.
> +
>  config SPI_APPLE
>  	tristate "Apple SoC SPI Controller platform driver"
>  	depends on ARCH_APPLE || COMPILE_TEST
> diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
> index 4ea89f6fc531..b74e3104d71f 100644
> --- a/drivers/spi/Makefile
> +++ b/drivers/spi/Makefile
> @@ -20,6 +20,7 @@ obj-$(CONFIG_SPI_ALTERA)		+= spi-altera-platform.o
>  obj-$(CONFIG_SPI_ALTERA_CORE)		+= spi-altera-core.o
>  obj-$(CONFIG_SPI_ALTERA_DFL)		+= spi-altera-dfl.o
>  obj-$(CONFIG_SPI_AMLOGIC_SPIFC_A1)	+= spi-amlogic-spifc-a1.o
> +obj-$(CONFIG_SPI_AMLOGIC_SPISG)		+= spi-amlogic-spisg.o
>  obj-$(CONFIG_SPI_APPLE)			+= spi-apple.o
>  obj-$(CONFIG_SPI_AR934X)		+= spi-ar934x.o
>  obj-$(CONFIG_SPI_ARMADA_3700)		+= spi-armada-3700.o
> diff --git a/drivers/spi/spi-amlogic-spisg.c b/drivers/spi/spi-amlogic-spisg.c
> new file mode 100644
> index 000000000000..2f2982154d49
> --- /dev/null
> +++ b/drivers/spi/spi-amlogic-spisg.c
> @@ -0,0 +1,876 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Driver for Amlogic SPI communication Scatter-Gather Controller
> + *
> + * Copyright (C) 2025 Amlogic, Inc. All rights reserved
> + *
> + * Author: Sunny Luo <sunny.luo@amlogic.com>
> + * Author: Xianwei Zhao <xianwei.zhao@amlogic.com>
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/device.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/clk-provider.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/pm_domain.h>

cacheflush

> +#include <linux/platform_device.h>
> +#include <linux/spi/spi.h>
> +#include <linux/types.h>
> +#include <linux/interrupt.h>
> +#include <linux/reset.h>

So this you take to reset device... but your device does not have any
resets! Just look at your binding.

> +#include <linux/pinctrl/consumer.h>
> +#include <linux/delay.h>
> +#include <linux/cacheflush.h>

Where do you use it?

> +#include <linux/regmap.h>

Actually several other headers looks unused. I am not going to keep
checking one by one - you should check and do not include irrelevant
headers.

> +
> +static int aml_spisg_probe(struct platform_device *pdev)
> +{
> +	struct spi_controller *ctlr;
> +	struct spisg_device *spisg;
> +	struct device *dev = &pdev->dev;
> +	void __iomem *base;
> +	int ret, irq;
> +
> +	const struct regmap_config aml_regmap_config = {
> +		.reg_bits = 32,
> +		.val_bits = 32,
> +		.reg_stride = 4,
> +		.max_register = SPISG_MAX_REG,
> +	};
> +
> +	if (of_property_read_bool(dev->of_node, "slave"))

"slave" is not a bool. You want to check for child presence, don't you?
You need to use appropriate API for that otherwise you just add one of
the issues which was being fixed recently.

> +		ctlr = spi_alloc_target(dev, sizeof(*spisg));
> +	else
> +		ctlr = spi_alloc_host(dev, sizeof(*spisg));
> +	if (!ctlr)
> +		return dev_err_probe(dev, -ENOMEM, "controller allocation failed\n");
> +



> +
> +static struct platform_driver amlogic_spisg_driver = {
> +	.probe = aml_spisg_probe,
> +	.remove = aml_spisg_remove,
> +	.driver  = {
> +		.name = "amlogic-spisg",
> +		.of_match_table = of_match_ptr(amlogic_spisg_of_match),

So now you will have warnings... drop of_match_ptr.

Both suggest you send us some old code, instead of working on something
recent.

> +		.pm = &amlogic_spisg_pm_ops,
> +	},
> +};
> +
> +module_platform_driver(amlogic_spisg_driver);
> +
> +MODULE_DESCRIPTION("Amlogic SPI Scatter-Gather Controller driver");
> +MODULE_AUTHOR("Sunny Luo <sunny.luo@amlogic.com>");
> +MODULE_LICENSE("GPL");
> 


Best regards,
Krzysztof

