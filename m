Return-Path: <linux-spi+bounces-5089-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C85898CDF6
	for <lists+linux-spi@lfdr.de>; Wed,  2 Oct 2024 09:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05292B216A2
	for <lists+linux-spi@lfdr.de>; Wed,  2 Oct 2024 07:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D699194151;
	Wed,  2 Oct 2024 07:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S77LzS7D"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DBC80C0C
	for <linux-spi@vger.kernel.org>; Wed,  2 Oct 2024 07:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727855118; cv=none; b=mU9g0p840drQtUV1FCf2Oq7e/4/x/WrDlFjWu32J53YjqQz/gSmQtiYsWDLALgr/lmkzOwFx2Qd/UHEn12bscDskpU999pgXckT9GYkrK94os5gU83uI7vLzr4L9fDa4sCUhr3Gxxu1ZRYoVVr3rUmYmNLJN/pWKDnZZO5znCUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727855118; c=relaxed/simple;
	bh=P7T4X2QOQmn/6AJQHqJ0PxbUiZ8NKgqZP340whTGLWI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dv51odM+TUf+/6tiEgegKf7y7q2IfCafgxXa9CVNNSAs63GhktlodG55L/DZW4FQDq8sPmgfyHDNNTGOl5Zggpp/zpafwKk0vddF7f+GFP4y1TB0vzXp8TGqKwEDTZLYEbcUM4mAjnoD9R7OLCBZpx5EU6A8i/wTXlizn3UPUm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=S77LzS7D; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a8ce5db8668so1105090066b.1
        for <linux-spi@vger.kernel.org>; Wed, 02 Oct 2024 00:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727855114; x=1728459914; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FNRdu4560cxyW4H48SPNRuOsXYe3wo5Kz8Tevusjh/Q=;
        b=S77LzS7D6MEln44nyEtM2+FncfpE+uCCZqYSJziLogBkTyj55qGuHCFNd3GJ58i28M
         d2JpxZIXc80yxs0nVOLSGzsg6b8WWslT2X9iTaGenJfYl/VZvLAHi5vWDsdJ0qr6ZuH7
         /Zl/Odqs5uuAt5PFSMIyEAa+oyVDihTNGTGhwusQLC+9K9rcz9VS3idCBdTSwD7mtC01
         nMdl2ILW2e+HBzcuy3LBoC0L+2PDpU9Vh0m3YTHuehg9fTfKcrPFUO0f0l7MfzE/9OIQ
         ovBf3f4QiineCjBczD3WTRe4dDGUwj0GVPDRgRS61MHUv9RSfPTQHKDg1D5/qS9wVlmR
         N+Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727855114; x=1728459914;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FNRdu4560cxyW4H48SPNRuOsXYe3wo5Kz8Tevusjh/Q=;
        b=l8OE5n1AAcvISv/PqJnWhewdehpEfNRd0A2P5ZQ4RfAZF34NkfXgeil+h+4xgG1ymr
         nZi1pvS8AmkkRtlFxR6/SCmuEIO5RKzfc0C1l/rnIokjkXQIewT6/Qt9gM/4z3PhVUoA
         xihaSMvfJwIecJ8LPNTA1dSy91PU3Xwx+3vUKy/DiP7y/yh1iI4kZseCdiwkhczwkHj1
         Upw/ZK42XfPdvzYWGIbszf+imRAAARUtA6NunHK1h1LEYvYfS3/Wl5TdxsA8uIQ7rkTL
         HIiyzHTffiLMUpxmdDrSvTXBKKY5u7oFWQmaNtg/qm5NQsRpXtxmMJjStIGy1vmIHxKN
         fZYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXc4Qw1L8nq6mu0b2Zex0KoHkuR/y0ZjfIAReIxUY77NwsZ0dYPc7MRbuP9KpErvNzGkrRPMoOevNQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNsckezDQN91YD9GYbfYxUzIItm6P3puS8JuAEV7S+0ZVTjP1b
	tcgDEPMAgfVAN9+b6v8YR8z0Zy0gPuatY0sRTFggM+P6hXPr0sN3EgzhM0sl18c=
X-Google-Smtp-Source: AGHT+IHVRBvw4u/Hgc+95QlfN8nSdnQa/vKgvNfz2NepqXg9A9A3Xuj0DuZM4kdWAhwKx81HVNgdGA==
X-Received: by 2002:a17:907:97c4:b0:a93:d6dc:d047 with SMTP id a640c23a62f3a-a98f836ee86mr222771766b.49.1727855113507;
        Wed, 02 Oct 2024 00:45:13 -0700 (PDT)
Received: from [10.11.12.174] ([82.76.204.61])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c27c59bdsm815585666b.50.2024.10.02.00.45.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2024 00:45:13 -0700 (PDT)
Message-ID: <5e7e0aa4-74b0-4262-8e8b-de86be54f0bc@linaro.org>
Date: Wed, 2 Oct 2024 10:45:08 +0300
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 6/6] mtd: spi-nor: add support for Macronix Octal
 flash
To: AlvinZhou <alvinzhou.tw@gmail.com>, linux-mtd@lists.infradead.org,
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
 pratyush@kernel.org, mwalle@kernel.org, miquel.raynal@bootlin.com,
 richard@nod.at, vigneshr@ti.com, broonie@kernel.org
Cc: chengminglin@mxic.com.tw, leoyu@mxic.com.tw,
 AlvinZhou <alvinzhou@mxic.com.tw>, JaimeLiao <jaimeliao@mxic.com.tw>
References: <20240926141956.2386374-1-alvinzhou.tw@gmail.com>
 <20240926141956.2386374-7-alvinzhou.tw@gmail.com>
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Content-Language: en-US
In-Reply-To: <20240926141956.2386374-7-alvinzhou.tw@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 26.09.2024 17:19, AlvinZhou wrote:
> From: AlvinZhou <alvinzhou@mxic.com.tw>
> 
> Adding manufacturer ID 0xC2 at the end of ID table
> to allow manufacturer fixup to be applied for any
> Macronix flashes instead of needing to list each
> flash ID in the ID table.
> 
> Such as macronix_nor_set_octal_dtr function in the
> manufacturer fixup can be applied to any Macronix
> Octal Flashes without the need to add the specific
> ID in the ID table.
> 
> Suggested-by: Michael Walle <mwalle@kernel.org>
> Signed-off-by: JaimeLiao <jaimeliao@mxic.com.tw>
> Signed-off-by: AlvinZhou <alvinzhou@mxic.com.tw>
> ---
>  drivers/mtd/spi-nor/macronix.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/spi-nor/macronix.c b/drivers/mtd/spi-nor/macronix.c
> index f039819a5252..1a8ccebdfe0e 100644
> --- a/drivers/mtd/spi-nor/macronix.c
> +++ b/drivers/mtd/spi-nor/macronix.c
> @@ -200,7 +200,9 @@ static const struct flash_info macronix_nor_parts[] = {
>  		.name = "mx25l3255e",
>  		.size = SZ_4M,
>  		.no_sfdp_flags = SECT_4K,
> -	}
> +	},
> +	/* Need the manufacturer fixups, Keep this last */

you have a capital letter in the middle of the sentence.

I'll replace the comment with:

/*

 * This spares us of adding new flash entries for flashes that can be
 * initialized solely based on the SFDP data, but still need the
 * manufacturer hooks to set parameters that can't be discovered at SFDP
 * parsing time.
 */

Which brings me to why you really set this. I remember SFDP contains
tables with sequence of commands for enabling/disabling Octal DTR mode.
Would you please remember me, why you didn't use those SFDP tables and
implemented your own enable/disable methods?

> +	{ .id = SNOR_ID(0xc2) }
>  };
>  
>  static int macronix_nor_octal_dtr_en(struct spi_nor *nor)

