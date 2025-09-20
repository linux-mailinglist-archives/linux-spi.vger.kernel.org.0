Return-Path: <linux-spi+bounces-10182-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DC14B8BE74
	for <lists+linux-spi@lfdr.de>; Sat, 20 Sep 2025 05:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19706A06E62
	for <lists+linux-spi@lfdr.de>; Sat, 20 Sep 2025 03:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CAB6217705;
	Sat, 20 Sep 2025 03:53:15 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD38934BA28;
	Sat, 20 Sep 2025 03:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758340395; cv=none; b=MeoclgomcAh66N7FlAPL+fM2DyAFqJti1hvpPjYCU5c532PL+ZJsormn2euIH6MtWO6ZbFV+dOYpXFwd794cC9xx2ZzM6XtpLYDsoMe0bDnpwkDz5vVIRg791zhHTgNOtIq7a9lIc6tlbBj7r+yOiCYdOpMpKNFYIUN1xgMJ8jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758340395; c=relaxed/simple;
	bh=Gr/V9zBrcmfXE1HIoAgXxx7HeT1pp+J4AlPClBXV9Vo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HkmrNifLVm5aL4BHHFo4oVamL14EHu/ExacoeTKfXD5cECi5KgfARS5ouGZK/qzfrODiMew72g+3oT6sUwJ5J3k8cdkNjO1P4Vbz15NrEAvXZT06s9piha3UupfKrOy3qGbSHsIXk8SPsfsu4eOjMXlEvAWbF7N4noAwtL3tDcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [192.168.0.102] (unknown [114.241.87.235])
	by APP-05 (Coremail) with SMTP id zQCowAAnjRYRJc5o_pjgAw--.30976S2;
	Sat, 20 Sep 2025 11:52:49 +0800 (CST)
Message-ID: <a7070f3f-8857-4834-9e9e-02068637075c@iscas.ac.cn>
Date: Sat, 20 Sep 2025 11:52:49 +0800
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] spi: spacemit: introduce SpacemiT K1 SPI
 controller driver
To: Alex Elder <elder@riscstar.com>, broonie@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org
Cc: dlan@gentoo.org, ziyao@disroot.org, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, alex@ghiti.fr, p.zabel@pengutronix.de,
 spacemit@lists.linux.dev, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250919155914.935608-1-elder@riscstar.com>
 <20250919155914.935608-3-elder@riscstar.com>
Content-Language: en-US
From: Vivian Wang <wangruikang@iscas.ac.cn>
In-Reply-To: <20250919155914.935608-3-elder@riscstar.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:zQCowAAnjRYRJc5o_pjgAw--.30976S2
X-Coremail-Antispam: 1UD129KBjvJXoW3JF13Kw1DuF18JFyfXF48Xrb_yoW7ZF1kpF
	Z8GFZxCrWktF4fGr42ya17ua4ruw1rWFW0gw4UJ343Zryq93y7AF1rKryxZa129FWkA3WI
	ya18Wa109as8Wr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvGb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4
	vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
	Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJV
	W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkI
	wI1lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
	0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
	17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
	C0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
	6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa
	73UjIFyTuYvjxUvaZXDUUUU
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/

Hi Alex,

On 9/19/25 23:59, Alex Elder wrote:
> [...]
>
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index 82fa5eb3b8684..4f6c446c6bc16 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -1071,6 +1071,14 @@ config SPI_SG2044_NOR
>  	  also supporting 3Byte address devices and 4Byte address
>  	  devices.
>  
> +config SPI_SPACEMIT_K1
> +	tristate "K1 SPI Controller"
> +	depends on ARCH_SPACEMIT || COMPILE_TEST
> +	depends on OF
> +	default ARCH_SPACEMIT
> +	help
> +	  Enable support for the SpacemiT K1 SPI controller.
> +

We could still add:

	imply MMP_PDMA if ARCH_SPACEMIT

To add a "recommended" dependency. This way, enabling SPI_SPACEMIT_K1
automatically enables MMP_PDMA, but if the user is willing to fiddle
around, they can explicitly disable it. What do you think?

>  config SPI_SPRD
>  	tristate "Spreadtrum SPI controller"
>  	depends on ARCH_SPRD || COMPILE_TEST
>
> [...]
>
> diff --git a/drivers/spi/spi-spacemit-k1.c b/drivers/spi/spi-spacemit-k1.c
> new file mode 100644
> index 0000000000000..8d564fe6c4303
> --- /dev/null
> +++ b/drivers/spi/spi-spacemit-k1.c
> @@ -0,0 +1,968 @@
>
> [...]
>
> +static void k1_spi_read_word(struct k1_spi_driver_data *drv_data)
> +{
> +	struct k1_spi_io *rx = &drv_data->rx;
> +	u32 bytes = drv_data->bytes;
> +	u32 val;
> +
> +	val = readl(drv_data->base + SSP_DATAR);
> +	rx->resid -= bytes;
> +
> +	if (!rx->buf)
> +		return;	/* Null reader: discard the data */
> +
> +	if (bytes == 1)
> +		*(u8 *)rx->buf = val;
> +	else if (bytes == 1)

Typo? else if (bytes == 2)

> +		*(u16 *)rx->buf = val;
> +	else
> +		*(u32 *)rx->buf = val;

Maybe

	else if (bytes == 4)
		*(u32 *)rx->buf = val;
	else
		WARN_ON_ONCE(1);

Just to make the pattern consistent? Same for k1_spi_write_word.

> +
> +	rx->buf += bytes;
> +}
>
> [...]
>
> +static int k1_spi_dma_setup(struct k1_spi_driver_data *drv_data)
> +{
> +	struct device *dev = drv_data->dev;
> +	int rx_ret;
> +	int tx_ret;
> +
> +	/* We must get both DMA channels, or neither of them */
> +	rx_ret = k1_spi_dma_setup_io(drv_data, true);
> +	if (rx_ret == -EPROBE_DEFER)
> +		return -EPROBE_DEFER;
> +
> +	tx_ret = k1_spi_dma_setup_io(drv_data, false);
> +
> +	/* If neither is specified, we don't use DMA */
> +	if (rx_ret == -ENODEV && tx_ret == -ENODEV)
> +		return 0;
> +
> +	if (rx_ret || tx_ret)
> +		goto err_cleanup;

This seems a bit convoluted. I'm wondering if all this explicit handling
really is necessary - if we get an error at probe time, can we just
return that error and let devres handle the rest? With the special case
that if we get both -ENODEV then disable DMA.

k1_spi_dma_cleanup_io seems to handle unmapping and termination of DMA,
which we... don't need, right?

> +
> +	drv_data->dummy = devm_kzalloc(dev, SZ_2K, GFP_KERNEL);
> +	if (drv_data->dummy)
> +		return 0;		/* Success! */
> +
> +	dev_warn(dev, "error allocating DMA dummy buffer; DMA disabled\n");

Just return -ENOMEM. If we can't even allocate 2K of buffer, we're
doomed anyway.

> +err_cleanup:
> +	if (tx_ret) {
> +		if (tx_ret != -EPROBE_DEFER)
> +			dev_err(dev, "error requesting DMA TX DMA channel\n");
> +	} else {
> +		k1_spi_dma_cleanup_io(drv_data, false);
> +	}
> +
> +	if (rx_ret)
> +		dev_err(dev, "error requesting DMA RX DMA channel\n");
> +	else
> +		k1_spi_dma_cleanup_io(drv_data, true);
> +
> +	if (tx_ret == -EPROBE_DEFER)
> +		return -EPROBE_DEFER;
> +
> +	/* Return success if we don't get the dummy buffer; PIO will be used */
> +
> +	return rx_ret ? : tx_ret ? : 0;
> +}
>
> [...]
>
> +static int devm_k1_spi_dma_setup(struct k1_spi_driver_data *drv_data)
> +{
> +	struct k1_spi_driver_data **ptr;
> +	int ret;
> +
> +	if (!IS_ENABLED(CONFIG_MMP_PDMA)) {
> +		dev_warn(drv_data->dev, "DMA not available; using PIO\n");
> +		return 0;
> +	}
> +

Shouldn't be necessary if we do the "imply" thing in Kconfig.

> [...]
>
> +static void k1_spi_host_init(struct k1_spi_driver_data *drv_data)
> +{
>
> [...]
>
> +
> +	ret = of_property_read_u32(np, "spi-max-frequency", &max_speed_hz);
> +	if (!ret) {
> +		host->max_speed_hz = clamp(max_speed_hz, K1_SPI_MIN_SPEED_HZ,
> +					   K1_SPI_MAX_SPEED_HZ);
> +		if (host->max_speed_hz != max_speed_hz)
> +			dev_warn(dev, "spi-max-frequency %u out of range, using %u\n",
> +				max_speed_hz, host->max_speed_hz);
> +	} else {
> +		if (ret != -EINVAL)
> +			dev_warn(dev, "bad spi-max-frequency, using %u\n",
> +				 K1_SPI_DEFAULT_MAX_SPEED_HZ);
> +		host->max_speed_hz = K1_SPI_DEFAULT_MAX_SPEED_HZ;
> +	}

I think it makes sense to have spi-max-frequency default to
K1_SPI_DEFAULT_MAX_SPEED_HZ, but if the value is out of range just print
a message and return an error, to get whoever wrote the bad value to fix it.

This range seems to be fixed by hardware, so, it should also be
specified in the bindings.

> +}
> +
>
> [...]
>
> +
> +static int k1_spi_probe(struct platform_device *pdev)
> +{
> +	struct k1_spi_driver_data *drv_data;
> +	struct device *dev = &pdev->dev;
> +	struct reset_control *reset;
> +	struct spi_controller *host;
> +	struct resource *iores;
> +	struct clk *clk_bus;
> +	int ret;
> +
> +	host = devm_spi_alloc_host(dev, sizeof(*drv_data));
> +	if (!host)
> +		return -ENOMEM;
> +	drv_data = spi_controller_get_devdata(host);
> +	drv_data->controller = host;
> +	platform_set_drvdata(pdev, drv_data);
> +	drv_data->dev = dev;
> +	init_completion(&drv_data->completion);
> +
> +	drv_data->base = devm_platform_get_and_ioremap_resource(pdev, 0,
> +								&iores);

Maybe

    devm_platform_ioremap_resource(pdev, 0);

> [...]
>
> +
> +MODULE_DESCRIPTION("SpacemiT K1 SPI controller driver");
> +MODULE_LICENSE("GPL");

Maybe MODULE_AUTHOR()?

Vivian "dramforever" Wang


