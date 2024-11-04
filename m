Return-Path: <linux-spi+bounces-5614-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E5E9BBDDA
	for <lists+linux-spi@lfdr.de>; Mon,  4 Nov 2024 20:16:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 738C4B21AE6
	for <lists+linux-spi@lfdr.de>; Mon,  4 Nov 2024 19:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C209118C93B;
	Mon,  4 Nov 2024 19:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="BHDWDqf+"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-15.smtpout.orange.fr [80.12.242.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB57E1805E;
	Mon,  4 Nov 2024 19:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730747800; cv=none; b=nwvftXOmVWrNOsNNTD5DcfVVNniAYSIPXnEJGKzsqvuLnLDtVTBf2KLvQOBJbA1Q3HaNwnY8RbmEYxdU2qmhmbK2jYw+0uZpsBbCqzfewUWhdm3DpwZF0BLIzWA9EJwb/V5ij9wtNcGilEW42FN80VcLOoRHGh1nrnGcpmn2Olk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730747800; c=relaxed/simple;
	bh=3xuuggSkQ1gJDazVSehcHvaQLA17WBi8ZghN/dKlbdg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G7aPg9XuAXXywFV0uDvBbIR21iv7JIqHNDgsNHZ9F6qg9h84n+MTI4RUHwRyalXEmnNwbz6ucFNyS/V1DCQwHlywyTcUcxsnHfacRtx9nQ2YynmLxTNntoGpW3EPcvrCqiZLlKv1V3Q6W9auI+quYG531/rvnTwL9/1ZxylKF8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=BHDWDqf+; arc=none smtp.client-ip=80.12.242.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id 82YstxmztYm1782YstBapD; Mon, 04 Nov 2024 20:16:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1730747789;
	bh=d1jQaocaMHbNON/4n1N6k2N3AqN6ubtMG+w0c/TobY0=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=BHDWDqf+CJCUETUTPBtliWbjwoQy4lIo0UBJSkWL8RKc47xSr3CcoEB5vqQzKy0q9
	 MyUH6r4J6T8Za1YuUV3RL0694+z4X24XjOaqhNNtAx4SG5rODViLBgb9c3pYnkaDaL
	 L84GJKN1pISWNnKkjErVKOvm+togOGqIMHnXrXz9ew5IiwfqrFVFrGAutNAEr0OtIO
	 6RrKsxap4+GZk5bohJAICU9CtK2RJNQjp6xRPc/EvOkXkhG03/dPm7nmiRa/od77gD
	 cULhiCCV79RQ6KKHaSAZGAt9wmmKnAsnhOwOLvwbjOEhgA5+pQIuaobF4P803hJPM+
	 KSYMtWVH8BSqQ==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Mon, 04 Nov 2024 20:16:29 +0100
X-ME-IP: 90.11.132.44
Message-ID: <ff82c5bf-c757-4496-83ac-c3b257ef476c@wanadoo.fr>
Date: Mon, 4 Nov 2024 20:16:25 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] spi: apple: Add driver for Apple SPI controller
To: Janne Grunau via B4 Relay <devnull+j.jannau.net@kernel.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Janne Grunau <j@jannau.net>,
 Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
References: <20241101-asahi-spi-v3-0-3b411c5fb8e5@jannau.net>
 <20241101-asahi-spi-v3-2-3b411c5fb8e5@jannau.net>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20241101-asahi-spi-v3-2-3b411c5fb8e5@jannau.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 01/11/2024 à 20:26, Janne Grunau via B4 Relay a écrit :
> From: Hector Martin <marcan-WKacp4m3WJJeoWH0uzbU5w@public.gmane.org>
> 
> This SPI controller is present in Apple SoCs such as the M1 (t8103) and
> M1 Pro/Max (t600x). It is a relatively straightforward design with two
> 16-entry FIFOs, arbitrary transfer sizes (up to 2**32 - 1) and fully
> configurable word size up to 32 bits. It supports one hardware CS line
> which can also be driven via the pinctrl/GPIO driver instead, if
> desired. TX and RX can be independently enabled.
> 
> There are a surprising number of knobs for tweaking details of the
> transfer, most of which we do not use right now. Hardware CS control
> is available, but we haven't found a way to make it stay low across
> multiple logical transfers, so we just use software CS control for now.
> 
> There is also a shared DMA offload coprocessor that can be used to handle
> larger transfers without requiring an IRQ every 8-16 words, but that
> feature depends on a bunch of scaffolding that isn't ready to be
> upstreamed yet, so leave it for later.
> 
> The hardware shares some register bit definitions with spi-s3c24xx which
> suggests it has a shared legacy with Samsung SoCs, but it is too
> different to warrant sharing a driver.
> 
> Signed-off-by: Hector Martin <marcan-WKacp4m3WJJeoWH0uzbU5w@public.gmane.org>
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---

Hi,

> diff --git a/drivers/spi/spi-apple.c b/drivers/spi/spi-apple.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..1a3f61501db56d0d7689cc3d6f987bf636130cdb
> --- /dev/null
> +++ b/drivers/spi/spi-apple.c
> @@ -0,0 +1,531 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// Apple SoC SPI device driver
> +//
> +// Copyright The Asahi Linux Contributors
> +//
> +// Based on spi-sifive.c, Copyright 2018 SiFive, Inc.
> +
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/clk.h>
> +#include <linux/module.h>

Move a few lines below to keep alphabetical order?

> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/spi/spi.h>

...

> +static int apple_spi_probe(struct platform_device *pdev)
> +{
> +	struct apple_spi *spi;
> +	int ret, irq;
> +	struct spi_controller *ctlr;
> +
> +	ctlr = devm_spi_alloc_master(&pdev->dev, sizeof(struct apple_spi));
> +	if (!ctlr)
> +		return -ENOMEM;
> +
> +	spi = spi_controller_get_devdata(ctlr);
> +	init_completion(&spi->done);
> +	platform_set_drvdata(pdev, ctlr);

Is it needed?
There is no platform_get_drvdata()

> +
> +	spi->regs = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(spi->regs))
> +		return PTR_ERR(spi->regs);
> +
> +	spi->clk = devm_clk_get_enabled(&pdev->dev, NULL);
> +	if (IS_ERR(spi->clk))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(spi->clk),
> +				     "Unable to find or enable bus clock\n");
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0)
> +		return irq;
> +
> +	ret = devm_request_irq(&pdev->dev, irq, apple_spi_irq, 0,
> +			       dev_name(&pdev->dev), spi);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret, "Unable to bind to interrupt\n");
> +
> +	ctlr->dev.of_node = pdev->dev.of_node;
> +	ctlr->bus_num = pdev->id;
> +	ctlr->num_chipselect = 1;
> +	ctlr->mode_bits = SPI_CPHA | SPI_CPOL | SPI_LSB_FIRST;
> +	ctlr->bits_per_word_mask = SPI_BPW_RANGE_MASK(1, 32);
> +	ctlr->prepare_message = apple_spi_prepare_message;
> +	ctlr->set_cs = apple_spi_set_cs;
> +	ctlr->transfer_one = apple_spi_transfer_one;
> +	ctlr->auto_runtime_pm = true;
> +
> +	pm_runtime_set_active(&pdev->dev);
> +	ret = devm_pm_runtime_enable(&pdev->dev);
> +	if (ret < 0)
> +		return ret;
> +
> +	apple_spi_init(spi);
> +
> +	ret = devm_spi_register_controller(&pdev->dev, ctlr);
> +	if (ret < 0)
> +		return dev_err_probe(&pdev->dev, ret, "devm_spi_register_controller failed\n");
> +
> +	return 0;
> +}

...

CJ

