Return-Path: <linux-spi+bounces-5585-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E9F09B94D0
	for <lists+linux-spi@lfdr.de>; Fri,  1 Nov 2024 17:00:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E198C28310A
	for <lists+linux-spi@lfdr.de>; Fri,  1 Nov 2024 16:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D16F19CCFA;
	Fri,  1 Nov 2024 16:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="iPUnZ8bs"
X-Original-To: linux-spi@vger.kernel.org
Received: from msa.smtpout.orange.fr (out-72.smtpout.orange.fr [193.252.22.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C926B1DA53;
	Fri,  1 Nov 2024 16:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730476845; cv=none; b=uimo72vJj8DNmXhAPWJW7MBb9EXBZvoMOSrvftyFqr8KH/Rw7B1HXsveul5fAJhAY78H+LSW8xk/bD5reZ7uv7d+m19BD2b2ASGiZwynHPIhortzBSPDYmrjGqw14uj1iCt/apFlpnIi1LJMy8Gb+9vOKKmIUq8HFuIjsmKXDOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730476845; c=relaxed/simple;
	bh=tgUcafWIcyw/Xw6WtWftC4IV18qq2lbN+XPC1DDYwpA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rACojyvNkRbdc8RPgiqaAs845DY+pGNpXBx4XKMuo2epZNYGBgNz1wOCKHw2srzinCoHps93+SJO5iFb3gQBCs1r74zyJ3DlTl3exWiCPaigCu27Af6H6wn9PR8FIUhuLfitxVy9ayBttlAVA3pvvDdoanRoakUXZbA2YSbTyCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=iPUnZ8bs; arc=none smtp.client-ip=193.252.22.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id 6u3ZtHqXNH3SU6u3ZtLSD5; Fri, 01 Nov 2024 16:59:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1730476768;
	bh=OPHPOhW9HUBF4EAgD2hHEl89Ml4qq1QzyjIJ4lZA8VU=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=iPUnZ8bsHVrouKOtqJuIaZT9mlO0HzGTPoMPj1s2yuM7ms6mOg1moCSuWZku7Ndwd
	 jVvaMAENZvOrBkCGLorHATLAAPE6NlDfdntZ/qDdho1yOfACdoBrRqASevzKgLALSM
	 BwHgW4OJGsJTjXJhY9j/3yFgXkQy2JwkIa5/YVqIy6++dEH7a/qKYfrrjuPoVl5cXj
	 j4BXOjPqvwWLbR1y81ZcWdy9Uac4kiVk6xFgVLeEmzzp7W1aJAWjSi5alIw/pc53tW
	 m4RJNOq5bexSI9JFbWxfbVKaIa40QZ76aXuFzifXUTnSDZI95RWCdQmZ+N3+ol/neF
	 kxZXn8wK1zuEA==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Fri, 01 Nov 2024 16:59:28 +0100
X-ME-IP: 90.11.132.44
Message-ID: <9bf24861-f792-4315-9492-e71f7d9c457f@wanadoo.fr>
Date: Fri, 1 Nov 2024 16:59:21 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] spi: apple: Add driver for Apple SPI controller
To: Janne Grunau via B4 Relay <devnull+j.jannau.net@kernel.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Janne Grunau <j@jannau.net>,
 Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
References: <20241101-asahi-spi-v2-0-763a8a84d834@jannau.net>
 <20241101-asahi-spi-v2-2-763a8a84d834@jannau.net>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20241101-asahi-spi-v2-2-763a8a84d834@jannau.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 01/11/2024 à 15:25, Janne Grunau via B4 Relay a écrit :
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

Hi,

a few nitpicks, if they make sense to you or in case of v3.


> +static int apple_spi_probe(struct platform_device *pdev)
> +{
> +	struct apple_spi *spi;
> +	int ret, irq;
> +	struct spi_controller *ctlr;
> +
> +	ctlr = devm_spi_alloc_master(&pdev->dev, sizeof(struct apple_spi));
> +	if (!ctlr)
> +		return dev_err_probe(&pdev->dev, -ENOMEM, "out of memory\n");

Usually, no message is needed, because kmalloc like functions are 
already verbose.

> +
> +	spi = spi_controller_get_devdata(ctlr);
> +	init_completion(&spi->done);
> +	platform_set_drvdata(pdev, ctlr);
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
> +	ctlr->flags = 0;

Nitpick: not needed, the memory if already zeroed.

> +	ctlr->prepare_message = apple_spi_prepare_message;
> +	ctlr->set_cs = apple_spi_set_cs;
> +	ctlr->transfer_one = apple_spi_transfer_one;
> +	ctlr->auto_runtime_pm = true;
> +
> +	pm_runtime_set_active(&pdev->dev);
> +	devm_pm_runtime_enable(&pdev->dev);

There could be an error handling, or if intentional, maybe a (void) or a 
comment to show the intent.

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

