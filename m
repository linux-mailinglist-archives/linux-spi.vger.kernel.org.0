Return-Path: <linux-spi+bounces-5664-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CCCE9C3F99
	for <lists+linux-spi@lfdr.de>; Mon, 11 Nov 2024 14:36:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE9612826F5
	for <lists+linux-spi@lfdr.de>; Mon, 11 Nov 2024 13:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7987514D70E;
	Mon, 11 Nov 2024 13:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ePtHOvLo"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CF319D06D
	for <linux-spi@vger.kernel.org>; Mon, 11 Nov 2024 13:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731332181; cv=none; b=LnMwzfZELqNdRS2+Te18X4dE69VRq8bHoQKGPBc0Emg8rL7AvhpuhzArkEXyRiwQtP85fXB9aoi4eKAcMHMZkzX3sSNbnqrrCQ43kN8K6v1erC8h8Gn0B/fCEnkJEbacNVCShZ/Dy4h+YxKqO2yDd4svoHl8JOvG8HXntr7gDBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731332181; c=relaxed/simple;
	bh=EXIYtordOVfrV3YTQarE+065g2DVBui6lvKuQE+dZb8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tGj04ayd65NDvi+PwvGhMzmzSDtBZPHTrVRtXtMm060Y+QrGptu1whVsJjb7I6RcQuk11/HBdQ9s1kGVIuGbqCQqNWQwxiwcGCdZ89INfS5b5Xp8RkFRtUi4Pmd4iWo4S/P+mK3roQOrYkrTR7tZkWIivrfRsjzXGCCh/oO/V/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ePtHOvLo; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43193678216so43079095e9.0
        for <linux-spi@vger.kernel.org>; Mon, 11 Nov 2024 05:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731332178; x=1731936978; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W1Qw4yUdezst90A3OaSW7+Czevxz1AHdZNP7o9+iGUw=;
        b=ePtHOvLolGAHjlzs44JhlHpNwejEe4z8/KLi5zSQJWrGzdalLQAJ8i+CIrAmG+ItPi
         WJYrep0yR5qYefX2JvUlSfxmjDsUUeTonbU75Dy3qxMflwpjncOhTXoS0dRcoWRRyf8d
         f0vx/OWngCxaCQQB+Xc+eibY7AcOsarM4I41fe72gGqoQCme3k/rZ4nqZymcfR/i/xYR
         h2RFRPHZn24XGQd+XVQ3xpT3VtVGK7wxp/w7XJkYyWEN/a2q+VCfoeL8P+dF0DIA9Xg/
         pJTaYb93d97ESmCTFUnkKNrh8AjyBbrnXlpbzk47eu18rfix1yF7liid/FTACLF7iwFn
         7LjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731332178; x=1731936978;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W1Qw4yUdezst90A3OaSW7+Czevxz1AHdZNP7o9+iGUw=;
        b=Mb+0Ro2+zdXliB5Ggx6bhUSSBwcpb8Qmi3eD6sjd+Us49S3Mz9Ks2AyWDyV2288e6q
         avXPVxsTa59zOIcSWb/kVJekiK0REut8A3Ketl162fttOng8GHT6MLqXzuehzYZeixMU
         mYYLKcOI91/G+tdSTx7Kf7wCaaDSXu5EczwzB0EwJjEZR4EjPAPnCPueZwNAYgg/awix
         h6emL6LoOYOgWnXf5YFfoeboshuWpaYSiEkFfStzLbHixKuTtn7S6KPR3qfe8jNQCs/r
         t148ofDR1rjzDy8fMb9n2ZU7QwmKq1kckfES25GTOhbzOVaHls0c1dxXHCXtn69+Q3hS
         V7bw==
X-Forwarded-Encrypted: i=1; AJvYcCWOqEg958aYCG/zALLJeUgL9GNlce7cOPS0TlauuoPEuG/myoQ/is2LjvjlQR4zwrKtBn7mLDUcKR0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj1W7e/dfjSDzAV8vZNkG7ntIbjqdYhJF0/5Em6k6D4nvKGZS+
	oVzkEWa7LtdVfpCyIjKWcAC2bAk3f+pB3OgwrrqMzvpBaathVcGyHmtRIbHRiAo=
X-Google-Smtp-Source: AGHT+IEdBCKU11SXShmf+ASOGWCtFd+QYwaO/LBhwXYdyIAFQI6sp6uez78lCCFomWX0PCaBNF/ogQ==
X-Received: by 2002:a05:6000:2a5:b0:381:c5ee:9c00 with SMTP id ffacd0b85a97d-381f18855c6mr10511312f8f.47.1731332177749;
        Mon, 11 Nov 2024 05:36:17 -0800 (PST)
Received: from [192.168.0.157] ([79.115.63.225])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed9ea5d9sm13013041f8f.75.2024.11.11.05.36.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 05:36:17 -0800 (PST)
Message-ID: <64ade17d-3800-4afc-847c-b8e5fc5d7360@linaro.org>
Date: Mon, 11 Nov 2024 13:36:15 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/24] spi: amd: Support per spi-mem operation frequency
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
 <20241025161501.485684-4-miquel.raynal@bootlin.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20241025161501.485684-4-miquel.raynal@bootlin.com>
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
> This controller however performed a frequency check, which is also
> observed during the ->check_op() phase.
> 
> The per-operation frequency capability is thus advertised to the spi-mem
> core.
> 
> Cc: Sanjay R Mehta <sanju.mehta@amd.com>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/spi/spi-amd.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-amd.c b/drivers/spi/spi-amd.c
> index 2245ad54b03a..f58dc6375582 100644
> --- a/drivers/spi/spi-amd.c
> +++ b/drivers/spi/spi-amd.c
> @@ -368,6 +368,9 @@ static bool amd_spi_supports_op(struct spi_mem *mem,
>  	    op->data.buswidth > 1 || op->data.nbytes > AMD_SPI_MAX_DATA)
>  		return false;
>  
> +	if (op->max_freq < AMD_SPI_MIN_HZ)

How about using mem->spi->controller->min_speed_hz intead?

> +		return false;

I find the check fine here, but I see however that amd_set_spi_freq()
duplicates the same, returning -EINVAL when speed_hz < AMD_SPI_MIN_HZ
> +
>  	return spi_mem_default_supports_op(mem, op);
>  }
>  
> @@ -443,7 +446,7 @@ static int amd_spi_exec_mem_op(struct spi_mem *mem,
>  
>  	amd_spi = spi_controller_get_devdata(mem->spi->controller);
>  
> -	ret = amd_set_spi_freq(amd_spi, mem->spi->max_speed_hz);
> +	ret = amd_set_spi_freq(amd_spi, op->max_freq);
>  	if (ret)
>  		return ret;

however the return code is checked just on this call, and completely
ignored in the 2 other calls. I find the code a bit ugly for the non
SPIMEM case, but maybe something for the amd owner to address.

Looking good,
ta
>  
> @@ -469,6 +472,10 @@ static const struct spi_controller_mem_ops amd_spi_mem_ops = {
>  	.supports_op = amd_spi_supports_op,
>  };
>  
> +static const struct spi_controller_mem_caps amd_spi_mem_caps = {
> +	.per_op_freq = true,
> +};
> +
>  static int amd_spi_host_transfer(struct spi_controller *host,
>  				   struct spi_message *msg)
>  {
> @@ -521,6 +528,7 @@ static int amd_spi_probe(struct platform_device *pdev)
>  	host->setup = amd_spi_host_setup;
>  	host->transfer_one_message = amd_spi_host_transfer;
>  	host->mem_ops = &amd_spi_mem_ops;
> +	host->mem_caps = &amd_spi_mem_caps;
>  	host->max_transfer_size = amd_spi_max_transfer_size;
>  	host->max_message_size = amd_spi_max_transfer_size;
>  

