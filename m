Return-Path: <linux-spi+bounces-11203-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D04C5CF8C
	for <lists+linux-spi@lfdr.de>; Fri, 14 Nov 2025 12:59:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BE7E635AADA
	for <lists+linux-spi@lfdr.de>; Fri, 14 Nov 2025 11:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF04315D5B;
	Fri, 14 Nov 2025 11:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qTfB0OIH"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1047313E02;
	Fri, 14 Nov 2025 11:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763121525; cv=none; b=C4QfGzoJ5dVXySxH6fSPrTdip7WtCBaBCiei7IpKkKl6xQcY++KHPKokrxzacjR05mVA2C8ZkkO1OnQGok5kWawQoDID/FpVDNRUWi9h9bC2r9+dsYI8tAWY54qYCkNcbAYYRY9poMcupU9sp5eBOhi1LuWUzBTOtree4LlZy/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763121525; c=relaxed/simple;
	bh=yh5fJQGdhx2NySkfsWDlhR3K1wLRF17ZiRDZ47ourgE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U7cCgX7TCJk39EgUvvRyzm/CZV2wN8G8MXD0wl4OkZ2vH1eIFiINW7q0tTOS32LGRB7gNPf11RT0NXGEBpY/rakB5dgHULcAhvd3F8xjmTevopAJuvzgUr6OguZ6+VknBqZqJBVAUyjTweeh6/rC/62uLhYkD0DIgqPHPtLNB+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qTfB0OIH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83B23C4CEF5;
	Fri, 14 Nov 2025 11:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763121525;
	bh=yh5fJQGdhx2NySkfsWDlhR3K1wLRF17ZiRDZ47ourgE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qTfB0OIHA02m4A2962eAAWs+HLfyD9Tf+frZ2F4WOGxUUnU6OHCxclpDD9vboKak4
	 y3nUTxtqlyK9hpQhsgKup7i5DK1l9a/sL3qeonoNI0a+Ycczt/S7VDSuPozFtW0BLc
	 LWDveKds4FzyuX2gWMFlKvUbw9KIuq5bLx4w2ewwBh1oI5GGiEUMRDTLXBlX5ez7Zq
	 0m5ci4AVOrnY241u4Hsso6Pf1HH5h0759x1D0x3uoauogR9oVEZeWzHFtZ7XUI89yL
	 D2FrkPRuloB7EjVED6+Bp3TYmPooTST4PjoVfwgSoW/IdHW2UWp07oyfzcuttdTXBa
	 nzfaddh31aVYQ==
Message-ID: <73a39371-5bf0-4a3d-a48b-9e91668b779c@kernel.org>
Date: Fri, 14 Nov 2025 12:58:41 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] spi: atcspi200: Add ATCSPI200 SPI driver
To: CL Wang <cl634@andestech.com>, broonie@kernel.org,
 linux-spi@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 tim609@andestech.com
References: <20251112034724.1977630-1-cl634@andestech.com>
 <20251112034724.1977630-3-cl634@andestech.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20251112034724.1977630-3-cl634@andestech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/11/2025 04:47, CL Wang wrote:
> +
> +static int atcspi_enable_clk(struct atcspi_dev *spi)
> +{
> +	int ret;
> +
> +	ret = clk_prepare_enable(spi->clk);
> +	if (ret)
> +		return dev_err_probe(spi->dev, ret,
> +				     "Failed to enable clock\n");
> +
> +	spi->clk_rate = clk_get_rate(spi->clk);
> +	if (!spi->clk_rate)
> +		return dev_err_probe(spi->dev, -EINVAL,
> +				     "Failed to get SPI clock rate\n");

You miss clock enable/prepare cleanup. In other places as well.
 > +
> +	return 0;
> +}
> +
> +static void atcspi_init_controller(struct platform_device *pdev,
> +				   struct atcspi_dev *spi,
> +				   struct spi_controller *host,
> +				   struct resource *mem_res)
> +{
> +	/* Get the physical address of the data register for DMA transfers. */
> +	spi->dma_addr = (dma_addr_t)(mem_res->start + ATCSPI_DATA);
> +
> +	/* Initialize controller properties */
> +	host->bus_num = pdev->id;
> +	host->mode_bits = SPI_CPOL | SPI_CPHA | SPI_RX_QUAD | SPI_TX_QUAD;
> +	host->dev.of_node = pdev->dev.of_node;
> +	host->num_chipselect = ATCSPI_MAX_CS_NUM;
> +	host->mem_ops = &atcspi_mem_ops;
> +	host->max_speed_hz = spi->sclk_rate;
> +}
> +
> +static int atcspi_probe(struct platform_device *pdev)
> +{
> +	struct spi_controller *host;
> +	struct atcspi_dev *spi;
> +	struct resource *mem_res;
> +	int ret;
> +
> +	host = spi_alloc_host(&pdev->dev, sizeof(*spi));
> +	if (!host)
> +		return -ENOMEM;
> +
> +	spi = spi_controller_get_devdata(host);
> +	spi->host = host;
> +	spi->dev = &pdev->dev;
> +	platform_set_drvdata(pdev, host);
> +
> +	ret = atcspi_init_resources(pdev, spi, &mem_res);
> +	if (ret)
> +		goto free_controller;
> +
> +	ret = atcspi_enable_clk(spi);
> +	if (ret)
> +		goto free_controller;
> +
> +	atcspi_init_controller(pdev, spi, host, mem_res);
> +
> +	ret = atcspi_setup(spi);
> +	if (ret)
> +		goto free_controller;
> +
> +	ret = devm_spi_register_controller(&pdev->dev, host);
> +	if (ret) {
> +		dev_err_probe(spi->dev, ret,
> +			      "Failed to register SPI controller\n");
> +		goto free_controller;
> +	}
> +
> +	spi->use_dma = false;
> +	if (ATCSPI_DMA_SUPPORT) {
> +		ret = atcspi_configure_dma(spi);
> +		if (ret)
> +			dev_info(spi->dev,
> +				 "Failed to init DMA, fallback to PIO mode\n");
> +		else
> +			spi->use_dma = true;
> +	}
> +	mutex_init(&spi->mutex_lock);
> +
> +	return 0;
> +
> +free_controller:
> +	spi_controller_put(host);

Where is DMA channel release? Same for unbind path.

> +	return ret;
> +}
> +
> +static const struct of_device_id atcspi_of_match[] = {
> +	{ .compatible = "andestech,qilai-spi", },
> +	{ .compatible = "andestech,atcspi200", },

Where did you document this compatible/ABI?


Best regards,
Krzysztof

