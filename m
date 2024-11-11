Return-Path: <linux-spi+bounces-5667-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C582B9C404F
	for <lists+linux-spi@lfdr.de>; Mon, 11 Nov 2024 15:05:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E90031C203E6
	for <lists+linux-spi@lfdr.de>; Mon, 11 Nov 2024 14:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC481DA53;
	Mon, 11 Nov 2024 14:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zF79IM/a"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE38153BF6
	for <linux-spi@vger.kernel.org>; Mon, 11 Nov 2024 14:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731333918; cv=none; b=IiL4ouUOwuPfa83UmCYAafWTyC7nJDyOhwPPYaEhhy6gSzI++5cHTNCljbIR/NeYB374ezIWIDpkR7fhk/X/WRQvA8YanULkX7a8g542ic0+3mYbBluV1XrrX96e3seDjgIEzA28JmKElu28nCS5eI4z1cvs0X/Gcr6cyWjp8p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731333918; c=relaxed/simple;
	bh=4ScKEgA8iL43ZhWr+1bQsPECmDQZJrH6+xKE1aJuyVU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mOQzOHaAfl9LGaeP6YHPvyPNtZUcPi3BTkZi7taGR2KvSsqtMKvSMjHd6FNkz94FOJZ5JYVd+JVekBHJbnq9USUBOyDcnKtTAj2ldW1WnHeQluvQ5vO8sUo1BZBq8qnJ6bzeIKFsXivuCtmInKIkq+d8oOVZV8+ACo2istImdHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zF79IM/a; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4315abed18aso38253785e9.2
        for <linux-spi@vger.kernel.org>; Mon, 11 Nov 2024 06:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731333915; x=1731938715; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QUuoF0rVu8yLQVOlU2klya1GLjhEzhswqT49iwbZI44=;
        b=zF79IM/aWaYdT2Y7wWXnGdZPjAbWd9UEZIYYQiG54mkaZmPzg0ElgKLCrKFFjXiy0M
         jEI2H/GfcS3tzcsMF4l/6+8XwngO+XeqYDS02y69I1mSYx/JrhfucytyfxuMvqhFkurl
         Sb0aeMzVSZNXH47leGCknK34dvBE44lgVOhvEPgC3VpjgZEwsajeqL1TNMPOo8jUoG/A
         9HzdUWQ/57KmZ1/j4MSh9gMAsqHY+4M08HI523n+7mKHXWb/AIgUZ3VTFTfQvNyYMHU/
         6nVmNI/JR0Sx3OkmXWKItfWdXjiV14o4sTApFd7jEXwK1Un04zePZjMe38YS1wgHCqft
         YAlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731333915; x=1731938715;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QUuoF0rVu8yLQVOlU2klya1GLjhEzhswqT49iwbZI44=;
        b=k/ZCn24EPAEewFD/m6OGlYkJrqmJIiTyQJSUHH9iKFnEicEmJfEjCtB8/k066ARRZ3
         1Uz0d4KemRmoLZ1YynA4Tu7lAlm2LsMzB4xA5iAAmTnKwNU1N69wdLaxFdt9UmtwHvkl
         1LYz3Z0pHZtw0qkIm8VgJc9YLT9PXbps9KoiDPU9B8UyBKVHFgfcwgtkjBOUb8ea2kTX
         GeMUzlrp7iV+5Y6cfLdzjvXLlD5B6BmjVqBAjBCLfIU/iI+Aa2Kr07QhsnEaeVUBhbM9
         1npCcJ+tqmYtXBHVUGM8QzBeSjTTECPyQh4YDX5I7yJ7JVCKCuI59YOpJB/ltls06Pxo
         MA9w==
X-Forwarded-Encrypted: i=1; AJvYcCVnnBPMGbaS6lt3Ry/HRwiTvvS6LoJd4k3mTNb2UnICUF9TdJS9Yc/oPl9VM270jm6lEr8uOLceeDk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRf5jFgdKE0PDixeM+0p9BjhV/yfUzctIxmAutEArrj2eLb6vk
	eGciaOYnbXoVDPiJiXk3A11+rJJfMDLzHpXVKsdfvi1HoLj4U72mYLSB+AIjR/g=
X-Google-Smtp-Source: AGHT+IFkKp60ux5VX81x3K6C5sHL8ZZWYxxqNmryS1kz6rRzgAWjB0iLpxlxaNBZqH/2wGg/7uh4nA==
X-Received: by 2002:a05:600c:46c8:b0:432:7c08:d11e with SMTP id 5b1f17b1804b1-432b74fedc8mr108724265e9.1.1731333914997;
        Mon, 11 Nov 2024 06:05:14 -0800 (PST)
Received: from [192.168.0.157] ([79.115.63.225])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed9707c8sm12988363f8f.17.2024.11.11.06.05.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 06:05:14 -0800 (PST)
Message-ID: <03c363d6-3c0d-45fe-93a7-76e9fcaff96c@linaro.org>
Date: Mon, 11 Nov 2024 14:05:12 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/24] spi: dw: Support per spi-mem operation frequency
 switches
To: Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <michael@walle.cc>,
 linux-mtd@lists.infradead.org
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
 Steam Lin <stlin2@winbond.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Sanjay R Mehta <sanju.mehta@amd.com>, Han Xu <han.xu@nxp.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 Daire McNamara <daire.mcnamara@microchip.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Haibo Chen <haibo.chen@nxp.com>, Yogesh Gaur <yogeshgaur.83@gmail.com>,
 Heiko Stuebner <heiko@sntech.de>, Michal Simek <michal.simek@amd.com>
References: <20241025161501.485684-1-miquel.raynal@bootlin.com>
 <20241025161501.485684-7-miquel.raynal@bootlin.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20241025161501.485684-7-miquel.raynal@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/25/24 5:14 PM, Miquel Raynal wrote:
> Every ->exec_op() call correctly configures the spi bus speed to the
> maximum allowed frequency for the memory using the constant spi default
> parameter. Since we can now have per-operation constraints, let's use
> the value that comes from the spi-mem operation structure instead. In
> case there is no specific limitation for this operation, the default spi
> device value will be given anyway.
> 
> The per-operation frequency capability is thus advertised to the spi-mem
> core.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/spi/spi-dw-core.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
> index 431788dd848c..3d49b1dbaed4 100644
> --- a/drivers/spi/spi-dw-core.c
> +++ b/drivers/spi/spi-dw-core.c
> @@ -677,7 +677,7 @@ static int dw_spi_exec_mem_op(struct spi_mem *mem, const struct spi_mem_op *op)
>  	 * operation. Transmit-only mode is suitable for the rest of them.
>  	 */
>  	cfg.dfs = 8;
> -	cfg.freq = clamp(mem->spi->max_speed_hz, 0U, dws->max_mem_freq);
> +	cfg.freq = clamp(op->max_freq, 0U, dws->max_mem_freq);
>  	if (op->data.dir == SPI_MEM_DATA_IN) {
>  		cfg.tmode = DW_SPI_CTRLR0_TMOD_EPROMREAD;
>  		cfg.ndf = op->data.nbytes;
> @@ -894,6 +894,10 @@ static void dw_spi_hw_init(struct device *dev, struct dw_spi *dws)
>  		dw_writel(dws, DW_SPI_CS_OVERRIDE, 0xF);
>  }
>  
> +static const struct spi_controller_mem_caps dw_spi_mem_caps = {
> +	.per_op_freq = true,
> +};
> +
>  int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
>  {
>  	struct spi_controller *host;
> @@ -941,8 +945,10 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
>  		host->set_cs = dw_spi_set_cs;
>  	host->transfer_one = dw_spi_transfer_one;
>  	host->handle_err = dw_spi_handle_err;
> -	if (dws->mem_ops.exec_op)
> +	if (dws->mem_ops.exec_op) {
>  		host->mem_ops = &dws->mem_ops;
> +		host->mem_caps = &dw_spi_mem_caps;

I guess you need a dws->mem_caps, otherwise you overwrite whatever the
layer above specifies.

> +	}
>  	host->max_speed_hz = dws->max_freq;
>  	host->flags = SPI_CONTROLLER_GPIO_SS;
>  	host->auto_runtime_pm = true;

